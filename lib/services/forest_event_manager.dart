// lib/services/forest_event_manager.dart
import 'dart:math';
import 'logd_enums.dart';

class ForestEventResult {
  final String logKey;
  final int hpLost;
  final int hpGained;
  final int goldGained;
  final int xpGained;
  final int gemsGained;
  final int turnsGained;
  final int turnsLost;
  final int atkBuff;
  final int defBuff;

  ForestEventResult({
    required this.logKey,
    this.hpLost = 0,
    this.hpGained = 0,
    this.goldGained = 0,
    this.xpGained = 0,
    this.gemsGained = 0,
    this.turnsGained = 0,
    this.turnsLost = 0,
    this.atkBuff = 0,
    this.defBuff = 0,
  });
}

class ForestEventManager {
  final _random = Random();

  ForestEventResult resolveChoice(String eventId, String choice, int level) {
    switch (eventId) {
      // 1. De Kabouter (Leprechaun)
      case 'leprechaun':
        if (choice == 'play') {
          return _random.nextBool()
              ? ForestEventResult(logKey: 'leprechaun_success', goldGained: 500, gemsGained: 1)
              : ForestEventResult(logKey: 'leprechaun_fail', goldGained: -100, hpLost: 5);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 2. De Woudmagiër (Hedge Wizard)
      case 'hedgeWizard':
        if (choice == 'drink') {
          return (_random.nextInt(100) < 60)
              ? ForestEventResult(logKey: 'wizard_success', turnsGained: 4, hpGained: 999)
              : ForestEventResult(logKey: 'wizard_fail', hpLost: 20, turnsLost: 2);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 3. De Omgevallen Kar (Merchant's Wagon)
      case 'merchantWagon':
        if (choice == 'search') {
          return ForestEventResult(logKey: 'wagon_search', gemsGained: 2, turnsLost: 1);
        }
        if (choice == 'smash') {
          return (_random.nextInt(100) < 30)
              ? ForestEventResult(logKey: 'wagon_smash_success', goldGained: 300)
              : ForestEventResult(logKey: 'wagon_smash_fail', hpLost: 15);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 4. Het Mystieke Woudwezen (White Hart)
      case 'whiteHart':
        if (choice == 'bow') {
          return ForestEventResult(logKey: 'hart_success', hpGained: 999, defBuff: 2);
        }
        if (choice == 'hunt') {
          return ForestEventResult(logKey: 'hart_fail', turnsLost: 5, atkBuff: -2);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 5. De Geheimzinnige Kaartspeler (Card Shark)
      case 'cardShark':
        if (choice == 'higher' || choice == 'lower') {
          return _random.nextBool()
              ? ForestEventResult(logKey: 'card_success', gemsGained: 1)
              : ForestEventResult(logKey: 'card_fail', gemsGained: -1);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 6. De Fontein van de Jeugd (Fountain of Youth)
      case 'fountain':
        if (choice == 'slok') {
          return ForestEventResult(logKey: 'fountain_success_heal', hpGained: 999);
        }
        if (choice == 'drink') {
          return (_random.nextInt(100) < 40)
              ? ForestEventResult(logKey: 'fountain_super', hpGained: 999)
              : ForestEventResult(logKey: 'fountain_curse', hpLost: 15, atkBuff: -2);
        }
        if (choice == 'wash') {
          return ForestEventResult(logKey: 'fountain_wash', atkBuff: 1);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 7. De Sprekende Boom (Prating Tree)
      case 'talkingTree':
        if (choice == 'gold') {
          return ForestEventResult(logKey: 'tree_success', goldGained: -(level * 20), turnsGained: 2, xpGained: level * 15);
        }
        if (choice == 'chop') {
          return ForestEventResult(logKey: 'tree_fail', hpLost: 25, atkBuff: -1);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 8. De Slapende Reus (Sleeping Giant)
      case 'giant':
        if (choice == 'steal') {
          return (_random.nextInt(100) < 70)
              ? ForestEventResult(logKey: 'giant_steal_success', goldGained: level * 40, gemsGained: 1)
              : ForestEventResult(logKey: 'giant_steal_fail', hpLost: 30, turnsLost: 1);
        }
        if (choice == 'sneak') {
          return ForestEventResult(logKey: 'giant_sneak', xpGained: 25);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 9. De Verlaten Tempel (Ruined Temple)
      case 'ruinedTemple':
        if (choice == 'read') {
          return _random.nextBool()
              ? ForestEventResult(logKey: 'temple_read_success', xpGained: level * 25)
              : ForestEventResult(logKey: 'temple_read_fail', hpLost: 15, turnsLost: 2);
        }
        if (choice == 'search') {
          return ForestEventResult(logKey: 'temple_search', goldGained: level * 30);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 10. De Mysterieuze Kruidenier (Travelling Herbalist)
      case 'travellingHerbalist':
        if (choice == 'red') {
          return (_random.nextInt(100) < 70)
              ? ForestEventResult(logKey: 'herbalist_red_success', hpGained: 999)
              : ForestEventResult(logKey: 'herbalist_red_fail', hpLost: 20);
        }
        if (choice == 'blue') {
          return (_random.nextInt(100) < 70)
              ? ForestEventResult(logKey: 'herbalist_blue_success', turnsGained: 3)
              : ForestEventResult(logKey: 'herbalist_blue_fail', turnsLost: 3);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 11. De Das met de Bril (Scholar Badger)
      case 'scholarBadger':
        if (choice == 'answer') {
          return ForestEventResult(logKey: 'badger_success', gemsGained: 1);
        }
        if (choice == 'hunt') {
          return ForestEventResult(logKey: 'badger_fail', hpLost: 10);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 12. Het Verloren Harnas (Skeleton in Armour)
      case 'skeletonArmour':
        if (choice == 'plunder') {
          return (_random.nextInt(100) < 40)
              ? ForestEventResult(logKey: 'skeleton_success', defBuff: 1)
              : ForestEventResult(logKey: 'skeleton_fail', hpLost: 25);
        }
        if (choice == 'bow') {
          return ForestEventResult(logKey: 'skeleton_respect', xpGained: level * 10);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 13. De Reizende Kermis (Dark Carnival)
      case 'darkCarnival':
        if (choice == 'spin') {
          int roll = _random.nextInt(100);
          if (roll < 33) return ForestEventResult(logKey: 'carnival_grand', goldGained: -200, gemsGained: 2);
          if (roll < 66) return ForestEventResult(logKey: 'carnival_consolation', goldGained: 0);
          return ForestEventResult(logKey: 'carnival_fail', goldGained: -200, hpLost: 15);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 14. De Smeulende Kampvuurplek (Abandoned Camp)
      case 'abandonedCamp':
        if (choice == 'eat') {
          return ForestEventResult(logKey: 'camp_eat', hpGained: 30);
        }
        if (choice == 'search') {
          return _random.nextBool()
              ? ForestEventResult(logKey: 'camp_search_success', goldGained: 150)
              : ForestEventResult(logKey: 'camp_search_fail', hpLost: 20);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 15. De Wensput (Wishing Well)
      case 'wishingWell':
        if (choice == 'offer') {
          return ForestEventResult(logKey: 'well_success', gemsGained: -1, atkBuff: 1);
        }
        if (choice == 'fish') {
          return ForestEventResult(logKey: 'well_fail', hpLost: 25, turnsLost: 2);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 16. De Honingboom (Honey Tree)
      case 'honeyTree':
        if (choice == 'climb') {
          return ForestEventResult(logKey: 'honey_success', hpGained: 999);
        }
        if (choice == 'smoke') {
          return (_random.nextInt(100) < 60)
              ? ForestEventResult(logKey: 'honey_smoke_success', gemsGained: 1, hpGained: 20)
              : ForestEventResult(logKey: 'honey_smoke_fail', hpLost: 25);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 17. De Kabouterkring (Mushroom Ring)
      case 'mushroomRing':
        if (choice == 'step') {
          return _random.nextBool()
              ? ForestEventResult(logKey: 'mushroom_success', turnsGained: 3, hpGained: 20)
              : ForestEventResult(logKey: 'mushroom_fail', hpLost: 25, turnsLost: 2);
        }
        if (choice == 'destroy') {
          return ForestEventResult(logKey: 'mushroom_destroy', goldGained: level * 20);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 18. Het Doelwit van de Jager (Hunter's Target)
      case 'huntersTarget':
        if (choice == 'play') {
          return (_random.nextInt(100) < 60)
              ? ForestEventResult(logKey: 'hunter_success', gemsGained: 1)
              : ForestEventResult(logKey: 'hunter_fail');
        }
        if (choice == 'demand') {
          return ForestEventResult(logKey: 'hunter_demand', goldGained: 100);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 19. Het Standbeeld van de Oude Held (Warrior's Statue)
      case 'warriorStatue':
        if (choice == 'offer') {
          return ForestEventResult(logKey: 'statue_offer', goldGained: -(level * 30), atkBuff: 1);
        }
        if (choice == 'clean') {
          return ForestEventResult(logKey: 'statue_clean', xpGained: level * 15);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      // 20. De Verborgen Stropersval (Poacher's Snare)
      case 'poachersSnare':
        if (choice == 'cut') {
          return ForestEventResult(logKey: 'snare_escape', turnsLost: 1);
        }
        if (choice == 'force') {
          return (_random.nextInt(100) < 40)
              ? ForestEventResult(logKey: 'snare_force_success', hpLost: 5)
              : ForestEventResult(logKey: 'snare_force_fail', goldGained: -200, hpLost: 15);
        }
        return ForestEventResult(logKey: 'fountain_leave');

      case 'hermit':
        if (choice == 'drink') {
          return ForestEventResult(logKey: 'hermit_success', turnsGained: 3);
        }
        return ForestEventResult(logKey: 'fountain_leave');
    }

    return ForestEventResult(logKey: 'fountain_leave');
  }

  List<Map<String, String>> getChoicesForEvent(ForestEventType event) {
    switch (event) {
      case ForestEventType.leprechaun:
        return [{'id': 'play'}, {'id': 'walk'}];
      case ForestEventType.hedgeWizard:
        return [{'id': 'drink'}, {'id': 'walk'}];
      case ForestEventType.merchantWagon:
        return [{'id': 'search'}, {'id': 'smash'}, {'id': 'walk'}];
      case ForestEventType.whiteHart:
        return [{'id': 'bow'}, {'id': 'hunt'}];
      case ForestEventType.cardShark:
        return [{'id': 'higher'}, {'id': 'lower'}, {'id': 'walk'}];
      case ForestEventType.fountain:
        return [{'id': 'slok'}, {'id': 'drink'}, {'id': 'wash'}, {'id': 'leave'}];
      case ForestEventType.talkingTree:
        return [{'id': 'gold'}, {'id': 'chop'}, {'id': 'walk'}];
      case ForestEventType.giant:
        return [{'id': 'steal'}, {'id': 'sneak'}];
      case ForestEventType.ruinedTemple:
        return [{'id': 'read'}, {'id': 'search'}, {'id': 'walk'}];
      case ForestEventType.travellingHerbalist:
        return [{'id': 'red'}, {'id': 'blue'}, {'id': 'walk'}];
      case ForestEventType.scholarBadger:
        return [{'id': 'answer'}, {'id': 'hunt'}];
      case ForestEventType.skeletonArmour:
        return [{'id': 'plunder'}, {'id': 'bow'}, {'id': 'walk'}];
      case ForestEventType.darkCarnival:
        return [{'id': 'spin'}, {'id': 'walk'}];
      case ForestEventType.abandonedCamp:
        return [{'id': 'eat'}, {'id': 'search'}, {'id': 'walk'}];
      case ForestEventType.wishingWell:
        return [{'id': 'offer'}, {'id': 'fish'}, {'id': 'walk'}];
      case ForestEventType.honeyTree:
        return [{'id': 'climb'}, {'id': 'smoke'}, {'id': 'walk'}];
      case ForestEventType.mushroomRing:
        return [{'id': 'step'}, {'id': 'destroy'}, {'id': 'walk'}];
      case ForestEventType.huntersTarget:
        return [{'id': 'play'}, {'id': 'demand'}, {'id': 'walk'}];
      case ForestEventType.warriorStatue:
        return [{'id': 'offer'}, {'id': 'clean'}, {'id': 'walk'}];
      case ForestEventType.poachersSnare:
        return [{'id': 'cut'}, {'id': 'force'}, {'id': 'walk'}];
      case ForestEventType.hermit:
        return [{'id': 'drink'}, {'id': 'walk'}];
      default:
        return [];
    }
  }
}
