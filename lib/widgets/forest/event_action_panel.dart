// lib/widgets/forest/event_action_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/logd_enums.dart';
import '../../theme/logd_codes.dart';
import '../../services/forest_event_manager.dart';

class EventActionPanel extends StatelessWidget {
  final ForestEventType activeEvent;
  final Map<String, dynamic> storyContent;
  final Function(String) onEventChoicePressed;

  const EventActionPanel({
    super.key,
    required this.activeEvent,
    required this.storyContent,
    required this.onEventChoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    final ForestEventManager eventManager = ForestEventManager();
    final List<Map<String, String>> choices = eventManager.getChoicesForEvent(activeEvent);

    if (choices.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (int i = 0; i < choices.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildChoiceButton(choices[i], context),
                ),
                const SizedBox(width: 10),
                if (i + 1 < choices.length)
                  Expanded(
                    child: _buildChoiceButton(choices[i + 1], context),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
      ],
    );
  }

  // DE CORE FIX: Mapt dynamic de event-id's naar de rotsvaste ARB-vertalingen
  String _getLabelFromArb(String id, AppLocalizations local) {
    switch (activeEvent) {
      case ForestEventType.leprechaun:
        if (id == 'play') return local.btnForestLeprechaunPlay;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.hedgeWizard:
        if (id == 'drink') return local.btnForestWizardDrink;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.merchantWagon:
        if (id == 'search') return local.btnForestWagonSearch;
        if (id == 'smash') return local.btnForestWagonSmash;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.whiteHart:
        if (id == 'bow') return local.btnForestHartBow;
        if (id == 'hunt') return local.btnForestHartHunt;
        break;
      case ForestEventType.cardShark:
        if (id == 'higher') return local.btnForestCardHigher;
        if (id == 'lower') return local.btnForestCardLower;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.fountain:
        if (id == 'slok') return local.btnForestFountainDive; 
        if (id == 'drink') return local.btnForestFountainDive;
        if (id == 'wash') return local.btnForestFountainDive;
        if (id == 'leave') return local.btnForestWalkAway;
        break;
      case ForestEventType.talkingTree:
        if (id == 'gold') return local.btnForestTreeGold;
        if (id == 'chop') return local.btnForestTreeChop;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.giant:
        if (id == 'steal') return local.btnForestGiantSteal;
        if (id == 'sneak') return local.btnForestGiantSneak;
        break;
      case ForestEventType.ruinedTemple:
        if (id == 'read') return local.btnForestTempleRead;
        if (id == 'search') return local.btnForestTempleSearch;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.travellingHerbalist:
        if (id == 'red') return local.btnForestHerbalistRed;
        if (id == 'blue') return local.btnForestHerbalistBlue;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.scholarBadger:
        if (id == 'answer') return local.btnForestBadgerAnswer;
        if (id == 'hunt') return local.btnForestBadgerHunt;
        break;
      case ForestEventType.skeletonArmour:
        if (id == 'plunder') return local.btnForestSkeletonPlunder;
        if (id == 'bow') return local.btnForestSkeletonBow;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.darkCarnival:
        if (id == 'spin') return local.btnForestCarnivalSpin;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.abandonedCamp:
        if (id == 'eat') return local.btnForestCampEat;
        if (id == 'search') return local.btnForestCampSearch;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.wishingWell:
        if (id == 'offer') return local.btnForestWellOffer;
        if (id == 'fish') return local.btnForestWellFish;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.honeyTree:
        if (id == 'climb') return local.btnForestHoneyClimb;
        if (id == 'smoke') return local.btnForestHoneySmoke;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.mushroomRing:
        if (id == 'step') return local.btnForestMushroomStep;
        if (id == 'destroy') return local.btnForestMushroomDestroy;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.huntersTarget:
        if (id == 'play') return local.btnForestHunterPlay;
        if (id == 'demand') return local.btnForestHunterDemand;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.warriorStatue:
        if (id == 'offer') return local.btnForestStatueOffer;
        if (id == 'clean') return local.btnForestStatueClean;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      case ForestEventType.poachersSnare:
        if (id == 'cut') return local.btnForestSnareCut;
        if (id == 'force') return local.btnForestSnareForce;
        if (id == 'walk') return local.btnForestSnareWait;
        break;
      case ForestEventType.hermit:
        if (id == 'drink') return local.btnHermitDrink;
        if (id == 'walk') return local.btnForestWalkAway;
        break;
      default:
        break;
    }
    return id;
  }

  Widget _buildChoiceButton(Map<String, String> choice, BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final String id = choice['id']!;
    
    final String label = _getLabelFromArb(id, local);
    
    Color color = LogdCodes.uiBlue;
    Color bg = LogdCodes.uiBlueBg;

    if (id == 'walk' || id == 'leave' || id == 'ignore' || id == 'demand') {
      color = Colors.grey;
      bg = Colors.transparent;
    } else if (id == 'steal' || id == 'hunt' || id == 'chop' || id == 'fish' || id == 'destroy' || id == 'smash') {
      color = LogdCodes.uiRed;
      bg = LogdCodes.uiRedBg;
    } else if (id == 'play' || id == 'spin' || id == 'higher' || id == 'lower') {
      color = LogdCodes.uiYellow;
      bg = LogdCodes.uiYellowBg;
    } else {
      color = LogdCodes.uiGreen;
      bg = LogdCodes.uiGreenBg;
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: () => onEventChoicePressed(id),
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color == Colors.grey ? Colors.grey : color.withValues(alpha: 0.9),
          fontFamily: LogdCodes.retroFont,
          fontWeight: FontWeight.bold,
          fontSize: LogdCodes.fontSizeDefault - 4,
        ),
      ),
    );
  }
}
