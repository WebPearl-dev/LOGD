// lib/services/forest_controller.dart
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'forest_manager.dart';
import 'combat_engine.dart';
import 'forest_event_manager.dart';
import 'logd_enums.dart';

class ForestController {
  final _supabase = Supabase.instance.client;
  final _forestManager = ForestManager();
  final _combatEngine = CombatEngine();
  final _eventManager = ForestEventManager();
  final _random = Random();

  int playerHp = 20, playerMaxHp = 20, goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerAttack = 8, playerDefense = 5;
  String username = "";

  PlayerSpecialty specialty = PlayerSpecialty.magic;
  ForestEventType activeEvent = ForestEventType.none;

  LogdEnemy? currentEnemy;
  String combatLog = "";
  bool isCombatOver = false;
  bool isSearching = true;
  bool skillUsedThisFight = false;

  Future<void> initGame(Function onUpdate) async {
    await _forestManager.loadEnemies();
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

      final String dbSpec = (data['specialty'] ?? '').toString().toLowerCase();
      specialty = PlayerSpecialty.magic;
      for (var type in PlayerSpecialty.values) {
        if (type.name.toLowerCase() == dbSpec) { specialty = type; break; }
      }

      final int atkPotionBoost = data['potion_attack'] ?? 0;
      final int defPotionBoost = data['potion_defense'] ?? 0;
      playerAttack = (level * 5 + 3) + atkPotionBoost;
      playerDefense = (level * 3 + 2) + defPotionBoost;
    }
  }

  Future<void> updateCloudStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final String specName = specialty.name;
      await _supabase.from('profiles').update({
        'hp': playerHp, 'gold_on_hand': goldOnHand, 'gems': gems,
        'turns': turns, 'experience': experience, 'alive': playerHp > 0,
        'specialty': specName.toUpperCase() + specName.substring(1),
      }).eq('id', user.id);
    }
  }

  void startEncounter(String noTurnsText, String fountainDesc, String giantDesc, String encounterStart) {
    if (turns <= 0) { isSearching = false; isCombatOver = true; combatLog = noTurnsText; return; }
    turns -= 1; isSearching = false;

    int roll = _random.nextInt(100);

    if (roll < 5) {
      activeEvent = ForestEventType.hermit;
      currentEnemy = null;
    } else if (roll < 20) {
      activeEvent = _random.nextBool() ? ForestEventType.fountain : ForestEventType.giant;
      currentEnemy = null;
    } else {
      activeEvent = ForestEventType.none;
      currentEnemy = _forestManager.getRandomEnemyForLevel(level);
      combatLog = encounterStart;
      skillUsedThisFight = false;
    }
    updateCloudStats();
  }

  void handleAttack(Function(CombatResult) onDefeated, Function onDied, Function(CombatResult) onContinue) {
    if (currentEnemy == null || isCombatOver) return;
    final result = _combatEngine.executeAttackRound(enemy: currentEnemy!, playerAttack: playerAttack, playerDefense: playerDefense, playerCurrentHp: playerHp, playerMaxHp: playerMaxHp, playerLevel: level);

    int updatedEnemyHp = currentEnemy!.currentHp - result.damageDealt;
    currentEnemy = currentEnemy!.copyWith(currentHp: updatedEnemyHp < 0 ? 0 : updatedEnemyHp);
    playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);

    if (result.status == CombatStatus.enemyDefeated) {
      goldOnHand += result.goldEarned; experience += result.xpEarned; isCombatOver = true;
      onDefeated(result);
    } else if (result.status == CombatStatus.playerDied) {
      goldOnHand = 0; isCombatOver = true;
      onDied();
    } else {
      onContinue(result);
    }
    updateCloudStats();
  }

  void handleChoice(String choice, Function(ForestEventResult) onResolved) {
    String eventId = activeEvent.name;
    final result = _eventManager.resolveChoice(eventId, choice);

    playerHp = (playerHp - result.hpLost).clamp(0, playerMaxHp);
    goldOnHand += result.goldGained;
    experience += result.xpGained;
    gems += result.gemsGained;
    turns += result.turnsGained;

    isCombatOver = true;
    onResolved(result);
    updateCloudStats();
  }

  // DE INTERACTIEVE RETRO FIX: Vaardigheden activeren en verwerken!
  void handleSkill(Function(CombatResult) onResult) {
    if (currentEnemy == null || isCombatOver || skillUsedThisFight) return;

    // Voer de vaardigheid uit via de combat engine rekenmotor
    final result = _combatEngine.executeSpecialSkill(
        specialty: specialty,
        enemy: currentEnemy!,
        playerLevel: level,
        playerMaxHp: playerMaxHp
    );

    skillUsedThisFight = true;

    // Verwerk de statistische gevolgen per klasse
    if (specialty == PlayerSpecialty.magic) {
      playerHp = (playerHp + result.hpHealed).clamp(0, playerMaxHp);
    } else if (specialty == PlayerSpecialty.thieving) {
      goldOnHand += result.goldEarned;
    } else if (specialty == PlayerSpecialty.warrior) {
      int updatedEnemyHp = currentEnemy!.currentHp - result.damageDealt;
      currentEnemy = currentEnemy!.copyWith(currentHp: updatedEnemyHp < 0 ? 0 : updatedEnemyHp);

      // Controleer of de Warrior Smash de vijand direct heeft verpletterd!
      if (result.status == CombatStatus.enemyDefeated) {
        goldOnHand += result.goldEarned;
        experience += result.xpEarned;
        isCombatOver = true;
      }
    }

    onResult(result);
    updateCloudStats();
  }

  // DE INTERACTIEVE RETRO FIX: Vluchtpogingen afhandelen!
  void handleFlee(Function onSuccess, Function(int) onFailed, Function onDeath) {
    if (currentEnemy == null || isCombatOver) return;

    final result = _combatEngine.executeFlee(enemy: currentEnemy!);

    if (result.status == CombatStatus.fleeSuccess) {
      isCombatOver = true;
      onSuccess();
    } else {
      playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);
      if (playerHp <= 0) {
        goldOnHand = 0;
        isCombatOver = true;
        onDeath();
      } else {
        onFailed(result.damageReceived);
      }
    }
    updateCloudStats();
  }
}
