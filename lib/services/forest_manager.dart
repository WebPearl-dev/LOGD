class LogdEnemy {
  final String name;
  final int level;
  final int maxHp;
  final int currentHp;
  final int minGold;
  final int maxGold;
  final String attackText;

  LogdEnemy({
    required this.name,
    required this.level,
    required this.maxHp,
    required this.currentHp,
    required this.minGold,
    required this.maxGold,
    required this.attackText,
  });

  LogdEnemy copyWith({int? currentHp}) {
    return LogdEnemy(
      name: name,
      level: level,
      maxHp: maxHp,
      minGold: minGold,
      maxGold: maxGold,
      attackText: attackText,
      currentHp: currentHp ?? this.currentHp,
    );
  }
}

class ForestManager {
  // GECORRIGEERD: Alle koppelwoorden (naar, tegen, van, over) zijn aan het einde gestript voor perfect lopende zinnen!
  static final List<LogdEnemy> _enemiesCache = [
    LogdEnemy(name: "boze eekhoorn", level: 1, maxHp: 15, currentHp: 15, minGold: 5, maxGold: 15, attackText: "gooit met eikels"),
    LogdEnemy(name: "wilde zwijn", level: 2, maxHp: 25, currentHp: 25, minGold: 10, maxGold: 25, attackText: "beukt met zijn snuit"),
    LogdEnemy(name: "hondsdolle wolf", level: 3, maxHp: 40, currentHp: 40, minGold: 20, maxGold: 45, attackText: "grijpt naar de keel"),
    LogdEnemy(name: "bostrol", level: 4, maxHp: 60, currentHp: 60, minGold: 35, maxGold: 70, attackText: "slaat met een knuppel"),
    LogdEnemy(name: "moerasheks", level: 5, maxHp: 85, currentHp: 85, minGold: 50, maxGold: 110, attackText: "spreekt een vloek uit"),
    LogdEnemy(name: "schaduwpanter", level: 6, maxHp: 115, currentHp: 115, minGold: 75, maxGold: 160, attackText: "bespringt vanuit het duister"),
    LogdEnemy(name: "kwaadaardige boomgeest", level: 7, maxHp: 150, currentHp: 150, minGold: 110, maxGold: 220, attackText: "wurgt met zijn wortels"),
    LogdEnemy(name: "bergreus", level: 8, maxHp: 200, currentHp: 200, minGold: 160, maxGold: 310, attackText: "plet met zijn gigantische vuist"),
    LogdEnemy(name: "gouden draak", level: 9, maxHp: 300, currentHp: 300, minGold: 250, maxGold: 500, attackText: "spuwt verzengend vuur"),
  ];

  static LogdEnemy? _forcedDevEnemy;
  static String loadError = "";

  Future<void> loadEnemies() async {
    loadError = "";
    return;
  }

  List<LogdEnemy> getRawEnemiesList() {
    return _enemiesCache;
  }

  void setForcedDevEnemy(LogdEnemy? enemy) {
    _forcedDevEnemy = enemy;
  }

  LogdEnemy getRandomEnemyForLevel(int playerLevel) {
    if (_forcedDevEnemy != null) {
      final LogdEnemy forced = _forcedDevEnemy!.copyWith();
      _forcedDevEnemy = null;
      return forced;
    }

    final filtered = _enemiesCache.where((e) => e.level == playerLevel).toList();
    if (filtered.isEmpty) { return _enemiesCache.first.copyWith(); }
    return filtered[DateTime.now().millisecond % filtered.length].copyWith();
  }
}
