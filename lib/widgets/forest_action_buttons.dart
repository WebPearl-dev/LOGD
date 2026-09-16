// lib/widgets/forest_action_buttons.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/logd_enums.dart';
import '../theme/logd_codes.dart';
import 'forest/event_action_panel.dart';   // Importeer het nieuwe event-paneel!
import 'forest/combat_action_panel.dart';  // Importeer het nieuwe combat-paneel!

class ForestActionButtons extends StatelessWidget {
  final bool isCombatOver;
  final bool skillUsedThisFight;
  final PlayerSpecialty specialty;
  final ForestEventType activeEvent;
  final VoidCallback onAttackPressed;
  final VoidCallback onUseSkillPressed;
  final VoidCallback onFleePressed;
  final VoidCallback onReturnTownPressed;
  final Function(String) onEventChoicePressed;

  const ForestActionButtons({
    super.key,
    required this.isCombatOver,
    required this.skillUsedThisFight,
    required this.specialty,
    required this.activeEvent,
    required this.onAttackPressed,
    required this.onUseSkillPressed,
    required this.onFleePressed,
    required this.onReturnTownPressed,
    required this.onEventChoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    // 1. Als het gevecht of event voorbij is, tonen we direct de return-knop
    if (isCombatOver) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          onPressed: onReturnTownPressed,
          child: Text(
              local.btnReturnTown.toUpperCase(),
              style: const TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: LogdCodes.retroFont,
                  fontWeight: FontWeight.bold,
                  fontSize: LogdCodes.fontSizeDefault
              )
          ),
        ),
      );
    }

    // 2. Als er een speciaal bos-event actief is, laad het event-paneel
    if (activeEvent != ForestEventType.none) {
      return EventActionPanel(
        activeEvent: activeEvent,
        onEventChoicePressed: onEventChoicePressed,
      );
    }

    // 3. Standaard situatie: toon de gevechtsknoppen tegen het monster
    return CombatActionPanel(
      skillUsedThisFight: skillUsedThisFight,
      specialty: specialty,
      onAttackPressed: onAttackPressed,
      onUseSkillPressed: onUseSkillPressed,
      onFleePressed: onFleePressed,
    );
  }
}
