import 'dart:math';

class ForestEventResult {
  final String logKey;
  final int hpLost;
  final int goldGained;
  final int xpGained;
  final int gemsGained;
  final int turnsGained; // Nieuw: Beurten modifier!

  ForestEventResult({
    required this.logKey,
    this.hpLost = 0,
    this.goldGained = 0,
    this.xpGained = 0,
    this.gemsGained = 0,
    this.turnsGained = 0,
  });
}

class ForestEventManager {
  final _random = Random();

  ForestEventResult resolveChoice(String eventId, String choice) {
    // --- DE OUDE KLUIZENAAR ---
    if (eventId == 'hermit') {
      if (choice == 'drink') {
        return ForestEventResult(logKey: 'eventHermitSuccess', turnsGained: 3);
      }
      if (choice == 'walk') {
        return ForestEventResult(logKey: 'eventHermitLeaveLog');
      }
    }

    // --- DE WATERBRON ---
    if (eventId == 'fountain') {
      if (choice == 'dive') {
        return _random.nextBool()
            ? ForestEventResult(logKey: 'eventFountainSuccess', goldGained: 40)
            : ForestEventResult(logKey: 'eventFountainFail', hpLost: 4);
      }
      return ForestEventResult(logKey: 'eventFountainLeaveLog');
    }

    // --- DE SLAPENDE REUS ---
    if (eventId == 'giant') {
      if (choice == 'sneak') {
        return ForestEventResult(logKey: 'eventGiantSneakSuccess', xpGained: 25);
      }
      if (choice == 'steal') {
        return _random.nextBool()
            ? ForestEventResult(logKey: 'eventGiantStealSuccess', goldGained: 80)
            : ForestEventResult(logKey: 'eventGiantStealFail', hpLost: 8);
      }
    }

    return ForestEventResult(logKey: 'eventFountainLeaveLog');
  }
}
