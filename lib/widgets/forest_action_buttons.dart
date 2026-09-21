// lib/widgets/forest_action_buttons.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/logd_enums.dart';
import '../theme/logd_codes.dart';
import 'forest/event_action_panel.dart';
import 'forest/combat_action_panel.dart';

class ForestActionButtons extends StatelessWidget {
  final bool isCombatOver;
  final bool skillUsedThisFight;
  final PlayerSpecialty specialty;
  final ForestEventType activeEvent;
  final Map<String, dynamic> storyContent;
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
    required this.storyContent,
    required this.onAttackPressed,
    required this.onUseSkillPressed,
    required this.onFleePressed,
    required this.onReturnTownPressed,
    required this.onEventChoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (isCombatOver) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
            backgroundColor: LogdCodes.uiBlueBg,
          ).copyWith(foregroundColor: WidgetStateProperty.all<Color>(LogdCodes.uiBlueDark)),
          onPressed: onReturnTownPressed,
          child: Text(
              local.btnReturnTown.toUpperCase(),
              style: const TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontWeight: FontWeight.bold,
                  fontSize: LogdCodes.fontSizeDefault
              )
          ),
        ),
      );
    }

    if (activeEvent != ForestEventType.none) {
      return EventActionPanel(
        activeEvent: activeEvent,
        storyContent: storyContent,
        onEventChoicePressed: onEventChoicePressed,
      );
    }

    return CombatActionPanel(
      skillUsedThisFight: skillUsedThisFight,
      specialty: specialty,
      onAttackPressed: onAttackPressed,
      onUseSkillPressed: onUseSkillPressed,
      onFleePressed: onFleePressed,
    );
  }
}
