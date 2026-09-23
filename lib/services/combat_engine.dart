// lib/services/combat_engine.dart
import 'dart:math';
import 'forest_manager.dart';
import 'logd_enums.dart';

class CombatResult {
  final CombatStatus status;
  final Map<String, dynamic> args;
  final bool isCombatOver;
  final int goldEarned;
  final int xpEarned;
  final int favorEarned;
  final int damageDealt;
  final int damageReceived;
  final int hpHealed;
  final bool isDragonFlame; // VOEG TOE: Geeft aan of de Draak zijn Vlammenzee spuwde

  CombatResult({
    required this.status,
    this.args = const {},
    this.isCombatOver = false,
    this.goldEarned = 0,
    this.xpEarned = 0,
    this.favorEarned = 0,
    this.damageDealt = 0,
    this.damageReceived = 0,
    this.hpHealed = 0,
    this.isDragonFlame = false,
  });
}

class CombatEngine {
  final Random _random = Random();

  CombatResult executeAttackRound({
    required LogdEnemy enemy,
    required int playerAttack,
    required int playerDefense,
    required int playerCurrentHp,
    required int playerMaxHp,
    required int playerLevel,
    bool isGhostCombat = false,
    bool isDragonCombat = false, // VOEG TOE: Unieke vlag voor het eindgevecht
  }) {
    int playerDamage = playerAttack + _random.nextInt(playerLevel + 2) - (enemy.level ~/ 2);
    if (playerDamage < 1) playerDamage = 1;

    int newEnemyHp = enemy.currentHp - playerDamage;

    if (newEnemyHp <= 0) {
      if (isGhostCombat) {
        int favorEarned = playerLevel * (_random.nextInt(3) + 1);
        return CombatResult(
          status: CombatStatus.enemyDefeated,
          args: {'enemy': enemy.name},
          isCombatOver: true,
          favorEarned: favorEarned,
          damageDealt: playerDamage,
        );
      }

      // Bij winst op de draak hoeven we geen goud/XP te berekenen, dat handelt de reset-transactie af
      int gold = enemy.minGold + _random.nextInt(enemy.maxGold - enemy.minGold + 1);
      int xp = enemy.level * 15 + _random.nextInt(10);
      return CombatResult(
        status: CombatStatus.enemyDefeated,
        args: {'enemy': enemy.name},
        isCombatOver: true,
        damageDealt: playerDamage,
        goldEarned: gold,
        xpEarned: xp,
      );
    }

    int enemyDamage = 0;
    bool dragonFlameTriggered = false;

    if (isDragonCombat && _random.nextInt(100) < 25) {
      // DE VLAMMENZEE: 25% kans aanval, negeert 50% van de speler verdediging!
      dragonFlameTriggered = true;
      int enemyBaseAttack = enemy.level * 6; // Lair schaling
      enemyDamage = enemyBaseAttack + _random.nextInt(enemy.level + 5) - (playerDefense ~/ 4);
    } else {
      // Normale fysieke aanval van vijand of Draak
      int enemyBaseAttack = isDragonCombat ? (enemy.level * 5) : (enemy.level * 4);
      enemyDamage = enemyBaseAttack + _random.nextInt(enemy.level + 2) - (playerDefense ~/ 2);
    }

    if (enemyDamage < 1) enemyDamage = 1;
    int newPlayerHp = playerCurrentHp - enemyDamage;

    if (newPlayerHp <= 0) {
      return CombatResult(
        status: isGhostCombat ? CombatStatus.ghostPlayerDefeated : CombatStatus.playerDied,
        args: {'enemy': enemy.name},
        isCombatOver: true,
        damageDealt: playerDamage,
        damageReceived: enemyDamage,
        isDragonFlame: dragonFlameTriggered,
      );
    }

    return CombatResult(
      status: CombatStatus.roundContinue,
      args: {
        'enemy': enemy.name,
        'attack_text': enemy.attackText,
      },
      isCombatOver: false,
      damageDealt: playerDamage,
      damageReceived: enemyDamage,
      isDragonFlame: dragonFlameTriggered,
    );
  }

  CombatResult executeSpecialSkill({
    required PlayerSpecialty specialty,
    required LogdEnemy enemy,
    required int playerLevel,
    required int playerMaxHp,
    bool isGhostCombat = false,
  }) {
    if (specialty == PlayerSpecialty.magic) {
      int healAmount = playerLevel * 6 + _random.nextInt(5);
      return CombatResult(
        status: CombatStatus.skillMagic,
        hpHealed: healAmount,
        args: {'log_key': 'skill_magic_$playerLevel'},
        isCombatOver: false,
      );
    } else if (specialty == PlayerSpecialty.thieving) {
      int stolenGold = isGhostCombat ? 0 : (enemy.level * 10 + _random.nextInt(15));
      return CombatResult(
        status: CombatStatus.skillThieving,
        goldEarned: stolenGold,
        args: {'enemy': enemy.name, 'log_key': 'skill_thieving_$playerLevel'},
        isCombatOver: false,
      );
    } else {
      int heavyDamage = playerLevel * 8 + _random.nextInt(6);
      int newEnemyHp = enemy.currentHp - heavyDamage;

      if (newEnemyHp <= 0) {
        if (isGhostCombat) {
          int favorEarned = playerLevel * (_random.nextInt(3) + 1);
          return CombatResult(
            status: CombatStatus.enemyDefeated,
            args: {'enemy': enemy.name},
            isCombatOver: true,
            favorEarned: favorEarned,
            damageDealt: heavyDamage,
          );
        }
        int gold = enemy.minGold + _random.nextInt(enemy.maxGold - enemy.minGold + 1);
        int xp = enemy.level * 15 + _random.nextInt(10);
        return CombatResult(
          status: CombatStatus.enemyDefeated,
          args: {'enemy': enemy.name},
          isCombatOver: true,
          damageDealt: heavyDamage,
          goldEarned: gold,
          xpEarned: xp,
        );
      }

      return CombatResult(
        status: CombatStatus.skillWarrior,
        damageDealt: heavyDamage,
        args: {'enemy': enemy.name, 'log_key': 'skill_warrior_$playerLevel'},
        isCombatOver: false,
      );
    }
  }

  CombatResult executeFlee({required LogdEnemy enemy, bool isGhostCombat = false}) {
    bool success = _random.nextBool();
    if (success) {
      return CombatResult(
        status: CombatStatus.fleeSuccess,
        args: {'enemy': enemy.name},
        isCombatOver: true,
      );
    } else {
      int enemyBaseAttack = enemy.level * 4;
      int enemyDamage = enemyBaseAttack + _random.nextInt(enemy.level + 2);
      if (enemyDamage < 1) enemyDamage = 1;

      return CombatResult(
        status: CombatStatus.fleeFailed,
        args: {'enemy': enemy.name},
        isCombatOver: false,
        damageReceived: enemyDamage,
      );
    }
  }
}
