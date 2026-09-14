import 'dart:math';
import 'forest_manager.dart';
import 'logd_enums.dart'; // Import voor de enums!

class CombatResult {
  final CombatStatus status;
  final Map<String, dynamic> args;
  final bool isCombatOver;
  final int goldEarned;
  final int xpEarned;
  final int damageDealt;
  final int damageReceived;
  final int hpHealed;

  CombatResult({
    required this.status,
    this.args = const {},
    this.isCombatOver = false,
    this.goldEarned = 0,
    this.xpEarned = 0,
    this.damageDealt = 0,
    this.damageReceived = 0,
    this.hpHealed = 0,
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
  }) {
    int playerDamage = playerAttack + _random.nextInt(playerLevel + 2) - (enemy.level ~/ 2);
    if (playerDamage < 1) playerDamage = 1;

    int newEnemyHp = enemy.currentHp - playerDamage;

    if (newEnemyHp <= 0) {
      int xpEarned = enemy.level * 15 + _random.nextInt(10);
      int goldEarned = enemy.minGold +
          (enemy.maxGold > enemy.minGold ? _random.nextInt(enemy.maxGold - enemy.minGold + 1) : 0);

      return CombatResult(
        status: CombatStatus.enemyDefeated,
        args: {'enemy': enemy.name},
        isCombatOver: true,
        goldEarned: goldEarned,
        xpEarned: xpEarned,
        damageDealt: playerDamage,
      );
    }

    int enemyBaseAttack = enemy.level * 4;
    int enemyDamage = enemyBaseAttack + _random.nextInt(enemy.level + 2) - (playerDefense ~/ 2);
    if (enemyDamage < 1) enemyDamage = 1;

    int newPlayerHp = playerCurrentHp - enemyDamage;

    if (newPlayerHp <= 0) {
      return CombatResult(
        status: CombatStatus.playerDied,
        args: {'enemy': enemy.name},
        isCombatOver: true,
        damageDealt: playerDamage,
        damageReceived: enemyDamage,
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
    );
  }

  CombatResult executeSpecialSkill({
    required PlayerSpecialty specialty,
    required LogdEnemy enemy,
    required int playerLevel,
    required int playerMaxHp,
  }) {
    if (specialty == PlayerSpecialty.magic) {
      int healAmount = playerLevel * 6 + _random.nextInt(5);
      return CombatResult(
        status: CombatStatus.skillMagic,
        hpHealed: healAmount,
        isCombatOver: false,
      );
    } else if (specialty == PlayerSpecialty.thieving) {
      int stolenGold = enemy.level * 10 + _random.nextInt(15);
      return CombatResult(
        status: CombatStatus.skillThieving,
        goldEarned: stolenGold,
        args: {'enemy': enemy.name},
        isCombatOver: false,
      );
    } else {
      int heavyDamage = playerLevel * 8 + _random.nextInt(6);
      int newEnemyHp = enemy.currentHp - heavyDamage;

      if (newEnemyHp <= 0) {
        int xpEarned = enemy.level * 15 + _random.nextInt(10);
        int goldEarned = enemy.minGold + (enemy.maxGold > enemy.minGold ? _random.nextInt(enemy.maxGold - enemy.minGold + 1) : 0);
        return CombatResult(
          status: CombatStatus.enemyDefeated,
          args: {'enemy': enemy.name},
          isCombatOver: true,
          goldEarned: goldEarned,
          xpEarned: xpEarned,
          damageDealt: heavyDamage,
        );
      }

      return CombatResult(
        status: CombatStatus.skillWarrior,
        damageDealt: heavyDamage,
        args: {'enemy': enemy.name},
        isCombatOver: false,
      );
    }
  }

  CombatResult executeFlee({required LogdEnemy enemy}) {
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
