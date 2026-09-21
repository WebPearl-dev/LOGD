// lib/services/forest_controller.dart
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'forest_manager.dart';
import 'forest_monster_manager.dart';
import 'forest_event_manager.dart';
import 'combat_engine.dart';
import 'logd_enums.dart';

class ForestController {
  final _supabase = Supabase.instance.client;
  final _monsterManager = ForestMonsterManager();
  final _eventManager = ForestEventManager();
  final _combatEngine = CombatEngine();
  final _random = Random();

  // Speler stats
  int playerHp = 20, playerMaxHp = 20, goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerAttack = 8, playerDefense = 5;
  String username = "";
  PlayerSpecialty specialty = PlayerSpecialty.magic;

  // Herberg Buffs
  String bardBuff = "none"; // "warrior", "scavenger", "haste"
  int dragonBreathFights = 0; // Telt af van 5 naar 0

  // Actieve state
  ForestEventType activeEvent = ForestEventType.none;
  LogdEnemy? currentEnemy;
  String combatLog = "";
  bool isCombatOver = false;
  bool isSearching = true;
  bool skillUsedThisFight = false;

  Future<void> initGame(Function onUpdate) async {
    await loadLiveStats();
    onUpdate();
  }

  Future<void> loadLiveStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      username = data['username'] ?? user.email ?? "";
      level = data['level'] ?? 1;
      playerHp = data['hp'] ?? 20;
      playerMaxHp = data['max_hp'] ?? 20;
      goldOnHand = data['gold_on_hand'] ?? 0;
      gems = data['gems'] ?? 0;
      turns = data['turns'] ?? 0;
      experience = data['experience'] ?? 0;

      // Laad Herberg Buffs
      bardBuff = data['bard_buff'] ?? "none";
      dragonBreathFights = data['dragon_breath_fights'] ?? 0;

      final String dbSpec = (data['specialty'] ?? '').toString().toLowerCase();
      specialty = PlayerSpecialty.magic;
      for (var type in PlayerSpecialty.values) {
        if (type.name.toLowerCase() == dbSpec) { specialty = type; break; }
      }

      // --- DE CORE BUFF CALCULATION ---
      final int atkPotionBoost = data['potion_attack'] ?? 0;
      final int defPotionBoost = data['potion_defense'] ?? 0;
      
      int baseAtk = (level * 5 + 3) + atkPotionBoost;
      
      // Pas Herberg Buffs toe
      if (bardBuff == "warrior") baseAtk += 2;
      if (dragonBreathFights > 0) baseAtk += 3;

      playerAttack = baseAtk;
      playerDefense = (level * 3 + 2) + defPotionBoost;
    }
  }

  Future<void> updateCloudStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final String specName = specialty.name;
      await _supabase.from('profiles').update({
        'hp': playerHp,
        'gold_on_hand': goldOnHand,
        'gems': gems,
        'turns': turns,
        'experience': experience,
        'alive': playerHp > 0,
        'specialty': specName.toUpperCase() + specName.substring(1),
        'dragon_breath_fights': dragonBreathFights,
      }).eq('id', user.id);
    }
  }

  void startEncounter(String noTurnsText, String fountainDesc, String giantDesc, String encounterStart) {
    if (turns <= 0) {
      isSearching = false;
      isCombatOver = true;
      combatLog = noTurnsText;
      return;
    }

    turns -= 1;
    isSearching = false;
    skillUsedThisFight = false;

    int roll = _random.nextInt(100);

    if (roll < 20) {
      final List<ForestEventType> allEvents = ForestEventType.values
          .where((e) => e != ForestEventType.none && 
                        e != ForestEventType.forcedFountain && 
                        e != ForestEventType.forcedGiant)
          .toList();
      
      activeEvent = allEvents[_random.nextInt(allEvents.length)];
      currentEnemy = null;
    } else {
      activeEvent = ForestEventType.none;
      currentEnemy = _monsterManager.getRandomEnemyForLevel(level);
      combatLog = encounterStart;
    }
    updateCloudStats();
  }

  void handleAttack(Function(CombatResult) onDefeated, Function onDied, Function(CombatResult) onContinue) {
    if (currentEnemy == null || isCombatOver) return;

    final result = _combatEngine.executeAttackRound(
        enemy: currentEnemy!,
        playerAttack: playerAttack,
        playerDefense: playerDefense,
        playerCurrentHp: playerHp,
        playerMaxHp: playerMaxHp,
        playerLevel: level
    );

    int updatedEnemyHp = currentEnemy!.currentHp - result.damageDealt;
    currentEnemy = currentEnemy!.copyWith(currentHp: updatedEnemyHp < 0 ? 0 : updatedEnemyHp);
    playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);

    if (result.status == CombatStatus.enemyDefeated) {
      // --- DE SCAVENGER BUFF ---
      int finalGold = result.goldEarned;
      if (bardBuff == "scavenger") {
        finalGold = (finalGold * 1.15).round();
      }
      
      goldOnHand += finalGold;
      experience += result.xpEarned;
      isCombatOver = true;

      // Verbruik Drakenbloed na overwinning
      if (dragonBreathFights > 0) {
        dragonBreathFights--;
      }

      onDefeated(CombatResult(
        status: CombatStatus.enemyDefeated,
        goldEarned: finalGold,
        xpEarned: result.xpEarned,
        damageDealt: result.damageDealt
      ));
    } else if (result.status == CombatStatus.playerDied) {
      goldOnHand = 0;
      isCombatOver = true;
      _logDeathToNews(currentEnemy!.name);
      onDied();
    } else {
      onContinue(result);
    }
    updateCloudStats();
  }

  void handleSkill(Function(CombatResult) onResult) {
    if (currentEnemy == null || isCombatOver || skillUsedThisFight) return;

    final result = _combatEngine.executeSpecialSkill(
        specialty: specialty,
        enemy: currentEnemy!,
        playerLevel: level,
        playerMaxHp: playerMaxHp
    );

    skillUsedThisFight = true;

    if (specialty == PlayerSpecialty.magic) {
      playerHp = (playerHp + result.hpHealed).clamp(0, playerMaxHp);
    } else if (specialty == PlayerSpecialty.thieving) {
      goldOnHand += result.goldEarned;
    } else if (specialty == PlayerSpecialty.warrior) {
      int updatedEnemyHp = currentEnemy!.currentHp - result.damageDealt;
      currentEnemy = currentEnemy!.copyWith(currentHp: updatedEnemyHp < 0 ? 0 : updatedEnemyHp);

      if (result.status == CombatStatus.enemyDefeated) {
        int finalGold = result.goldEarned;
        if (bardBuff == "scavenger") finalGold = (finalGold * 1.15).round();
        goldOnHand += finalGold;
        experience += result.xpEarned;
        isCombatOver = true;
        
        if (dragonBreathFights > 0) dragonBreathFights--;
      }
    }

    onResult(result);
    updateCloudStats();
  }

  void handleFlee(Function onSuccess, Function(int) onFailed, Function onDeath) {
    if (currentEnemy == null || isCombatOver) return;

    final String enemyName = currentEnemy!.name;
    final result = _combatEngine.executeFlee(enemy: currentEnemy!);

    if (result.status == CombatStatus.fleeSuccess) {
      isCombatOver = true;
      onSuccess();
    } else {
      playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);
      if (playerHp <= 0) {
        goldOnHand = 0;
        isCombatOver = true;
        _logDeathToNews(enemyName);
        onDeath();
      } else {
        onFailed(result.damageReceived);
      }
    }
    updateCloudStats();
  }

  void handleChoice(String choice, Function(ForestEventResult) onResolved) {
    String eventId = activeEvent.name;
    final result = _eventManager.resolveChoice(eventId, choice, level);

    playerHp = (playerHp - result.hpLost).clamp(0, playerMaxHp);
    if (result.hpGained > 500) {
      playerHp = playerMaxHp;
    } else {
      playerHp = (playerHp + result.hpGained).clamp(0, playerMaxHp);
    }

    goldOnHand += result.goldGained;
    experience += result.xpGained;
    gems += result.gemsGained;
    turns = (turns + result.turnsGained - result.turnsLost).clamp(0, 100);

    isCombatOver = true;
    onResolved(result);
    updateCloudStats();
  }

  Future<void> _logDeathToNews(String enemyName) async {
    try {
      final bool isBrutal = _random.nextInt(100) < 20;
      await _supabase.from('daily_news').insert({
        'username': username,
        'log_type': isBrutal ? 'defeated_brutal' : 'defeated',
        'enemy_name': enemyName,
      });
    } catch (_) {}
  }
}
