// lib/services/forest_monster_manager.dart
import 'dart:math';
import 'forest_manager.dart';

class ForestMonsterManager {
  final _random = Random();

  // DE CORE LIJST: Nu uitsluitend met sleutels en stats!
  static final List<LogdEnemy> _allMonsters = [
    // --- LEVEL 1 ---
    LogdEnemy(name: "m_1_0", level: 1, maxHp: 15, currentHp: 15, minGold: 5, maxGold: 15, attackText: "atk"),
    LogdEnemy(name: "m_1_1", level: 1, maxHp: 16, currentHp: 16, minGold: 6, maxGold: 18, attackText: "atk"),
    LogdEnemy(name: "m_1_2", level: 1, maxHp: 14, currentHp: 14, minGold: 4, maxGold: 12, attackText: "atk"),
    LogdEnemy(name: "m_1_3", level: 1, maxHp: 15, currentHp: 15, minGold: 5, maxGold: 14, attackText: "atk"),

    // --- LEVEL 2 ---
    LogdEnemy(name: "m_2_0", level: 2, maxHp: 25, currentHp: 25, minGold: 12, maxGold: 28, attackText: "atk"),
    LogdEnemy(name: "m_2_1", level: 2, maxHp: 28, currentHp: 28, minGold: 15, maxGold: 35, attackText: "atk"),
    LogdEnemy(name: "m_2_2", level: 2, maxHp: 24, currentHp: 24, minGold: 20, maxGold: 45, attackText: "atk"),
    LogdEnemy(name: "m_2_3", level: 2, maxHp: 30, currentHp: 30, minGold: 14, maxGold: 32, attackText: "atk"),

    // --- LEVEL 3 ---
    LogdEnemy(name: "m_3_0", level: 3, maxHp: 45, currentHp: 45, minGold: 25, maxGold: 60, attackText: "atk"),
    LogdEnemy(name: "m_3_1", level: 3, maxHp: 42, currentHp: 42, minGold: 22, maxGold: 55, attackText: "atk"),
    LogdEnemy(name: "m_3_2", level: 3, maxHp: 50, currentHp: 50, minGold: 30, maxGold: 70, attackText: "atk"),
    LogdEnemy(name: "m_3_3", level: 3, maxHp: 48, currentHp: 48, minGold: 28, maxGold: 65, attackText: "atk"),

    // --- LEVEL 4 ---
    LogdEnemy(name: "m_4_0", level: 4, maxHp: 65, currentHp: 65, minGold: 40, maxGold: 90, attackText: "atk"),
    LogdEnemy(name: "m_4_1", level: 4, maxHp: 75, currentHp: 75, minGold: 45, maxGold: 100, attackText: "atk"),
    LogdEnemy(name: "m_4_2", level: 4, maxHp: 60, currentHp: 60, minGold: 35, maxGold: 85, attackText: "atk"),
    LogdEnemy(name: "m_4_3", level: 4, maxHp: 55, currentHp: 55, minGold: 30, maxGold: 110, attackText: "atk"),

    // --- LEVEL 5 ---
    LogdEnemy(name: "m_5_0", level: 5, maxHp: 100, currentHp: 100, minGold: 60, maxGold: 130, attackText: "atk"),
    LogdEnemy(name: "m_5_1", level: 5, maxHp: 90, currentHp: 90, minGold: 55, maxGold: 125, attackText: "atk"),
    LogdEnemy(name: "m_5_2", level: 5, maxHp: 110, currentHp: 110, minGold: 70, maxGold: 150, attackText: "atk"),
    LogdEnemy(name: "m_5_3", level: 5, maxHp: 85, currentHp: 85, minGold: 50, maxGold: 120, attackText: "atk"),

    // --- LEVEL 6 ---
    LogdEnemy(name: "m_6_0", level: 6, maxHp: 130, currentHp: 130, minGold: 80, maxGold: 170, attackText: "atk"),
    LogdEnemy(name: "m_6_1", level: 6, maxHp: 145, currentHp: 145, minGold: 95, maxGold: 190, attackText: "atk"),
    LogdEnemy(name: "m_6_2", level: 6, maxHp: 160, currentHp: 140, minGold: 100, maxGold: 210, attackText: "atk"),
    LogdEnemy(name: "m_6_3", level: 6, maxHp: 120, currentHp: 120, minGold: 75, maxGold: 160, attackText: "atk"),

    // --- LEVEL 7 ---
    LogdEnemy(name: "m_7_0", level: 7, maxHp: 180, currentHp: 180, minGold: 120, maxGold: 250, attackText: "atk"),
    LogdEnemy(name: "m_7_1", level: 7, maxHp: 170, currentHp: 170, minGold: 110, maxGold: 240, attackText: "atk"),
    LogdEnemy(name: "m_7_2", level: 7, maxHp: 160, currentHp: 160, minGold: 105, maxGold: 230, attackText: "atk"),
    LogdEnemy(name: "m_7_3", level: 7, maxHp: 190, currentHp: 190, minGold: 130, maxGold: 260, attackText: "atk"),

    // --- LEVEL 8 ---
    LogdEnemy(name: "m_8_0", level: 8, maxHp: 220, currentHp: 220, minGold: 150, maxGold: 300, attackText: "atk"),
    LogdEnemy(name: "m_8_1", level: 8, maxHp: 235, currentHp: 235, minGold: 165, maxGold: 320, attackText: "atk"),
    LogdEnemy(name: "m_8_2", level: 8, maxHp: 260, currentHp: 260, minGold: 180, maxGold: 350, attackText: "atk"),
    LogdEnemy(name: "m_8_3", level: 8, maxHp: 240, currentHp: 240, minGold: 170, maxGold: 330, attackText: "atk"),

    // --- LEVEL 9 ---
    LogdEnemy(name: "m_9_0", level: 9, maxHp: 280, currentHp: 280, minGold: 200, maxGold: 400, attackText: "atk"),
    LogdEnemy(name: "m_9_1", level: 9, maxHp: 300, currentHp: 300, minGold: 220, maxGold: 450, attackText: "atk"),
    LogdEnemy(name: "m_9_2", level: 9, maxHp: 260, currentHp: 260, minGold: 300, maxGold: 500, attackText: "atk"),
    LogdEnemy(name: "m_9_3", level: 9, maxHp: 320, currentHp: 320, minGold: 240, maxGold: 480, attackText: "atk"),

    // --- LEVEL 10 ---
    LogdEnemy(name: "m_10_0", level: 10, maxHp: 350, currentHp: 350, minGold: 300, maxGold: 600, attackText: "atk"),
    LogdEnemy(name: "m_10_1", level: 10, maxHp: 330, currentHp: 330, minGold: 280, maxGold: 550, attackText: "atk"),
    LogdEnemy(name: "m_10_2", level: 10, maxHp: 380, currentHp: 380, minGold: 350, maxGold: 650, attackText: "atk"),
    LogdEnemy(name: "m_10_3", level: 10, maxHp: 400, currentHp: 400, minGold: 400, maxGold: 700, attackText: "atk"),

    // --- LEVEL 11 ---
    LogdEnemy(name: "m_11_0", level: 11, maxHp: 450, currentHp: 450, minGold: 450, maxGold: 800, attackText: "atk"),
    LogdEnemy(name: "m_11_1", level: 11, maxHp: 420, currentHp: 420, minGold: 420, maxGold: 750, attackText: "atk"),
    LogdEnemy(name: "m_11_2", level: 11, maxHp: 400, currentHp: 400, minGold: 400, maxGold: 700, attackText: "atk"),
    LogdEnemy(name: "m_11_3", level: 11, maxHp: 480, currentHp: 480, minGold: 500, maxGold: 850, attackText: "atk"),

    // --- LEVEL 12 ---
    LogdEnemy(name: "m_12_0", level: 12, maxHp: 550, currentHp: 550, minGold: 550, maxGold: 1000, attackText: "atk"),
    LogdEnemy(name: "m_12_1", level: 12, maxHp: 520, currentHp: 520, minGold: 520, maxGold: 950, attackText: "atk"),
    LogdEnemy(name: "m_12_2", level: 12, maxHp: 580, currentHp: 580, minGold: 600, maxGold: 1100, attackText: "atk"),
    LogdEnemy(name: "m_12_3", level: 12, maxHp: 540, currentHp: 540, minGold: 580, maxGold: 1050, attackText: "atk"),

    // --- LEVEL 13 ---
    LogdEnemy(name: "m_13_0", level: 13, maxHp: 650, currentHp: 650, minGold: 650, maxGold: 1200, attackText: "atk"),
    LogdEnemy(name: "m_13_1", level: 13, maxHp: 680, currentHp: 680, minGold: 680, maxGold: 1300, attackText: "atk"),
    LogdEnemy(name: "m_13_2", level: 13, maxHp: 720, currentHp: 720, minGold: 750, maxGold: 1400, attackText: "atk"),
    LogdEnemy(name: "m_13_3", level: 13, maxHp: 750, currentHp: 750, minGold: 700, maxGold: 1350, attackText: "atk"),

    // --- LEVEL 14 ---
    LogdEnemy(name: "m_14_0", level: 14, maxHp: 850, currentHp: 850, minGold: 850, maxGold: 1600, attackText: "atk"),
    LogdEnemy(name: "m_14_1", level: 14, maxHp: 900, currentHp: 900, minGold: 900, maxGold: 1700, attackText: "atk"),
    LogdEnemy(name: "m_14_2", level: 14, maxHp: 950, currentHp: 950, minGold: 1000, maxGold: 1800, attackText: "atk"),
    LogdEnemy(name: "m_14_3", level: 14, maxHp: 880, currentHp: 880, minGold: 880, maxGold: 1650, attackText: "atk"),

    // --- LEVEL 15 ---
    LogdEnemy(name: "m_15_0", level: 15, maxHp: 1000, currentHp: 1000, minGold: 1000, maxGold: 2000, attackText: "atk"),
    LogdEnemy(name: "m_15_1", level: 15, maxHp: 1200, currentHp: 1200, minGold: 1500, maxGold: 2500, attackText: "atk"),
    LogdEnemy(name: "m_15_2", level: 15, maxHp: 950, currentHp: 950, minGold: 1200, maxGold: 2200, attackText: "atk"),
    LogdEnemy(name: "m_15_3", level: 15, maxHp: 1500, currentHp: 1500, minGold: 2000, maxGold: 5000, attackText: "atk"),
  ];

  LogdEnemy getRandomEnemyForLevel(int level) {
    final filtered = _allMonsters.where((m) => m.level == level).toList();
    if (filtered.isEmpty) {
      return _allMonsters.first.copyWith();
    }
    return filtered[_random.nextInt(filtered.length)].copyWith();
  }

  List<LogdEnemy> getAllMonsters() => _allMonsters;
}
