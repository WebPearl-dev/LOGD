// lib/widgets/forest/combat_action_panel.dart
import 'package:flutter/material.dart';
import '../../services/logd_enums.dart';
import '../../theme/logd_codes.dart';

class CombatActionPanel extends StatelessWidget {
  final bool skillUsedThisFight;
  final PlayerSpecialty specialty;
  final VoidCallback onAttackPressed;
  final VoidCallback onUseSkillPressed;
  final VoidCallback onFleePressed;

  const CombatActionPanel({
    super.key,
    required this.skillUsedThisFight,
    required this.specialty,
    required this.onAttackPressed,
    required this.onUseSkillPressed,
    required this.onFleePressed,
  });

  @override
  Widget build(BuildContext context) {
    // DE FIX: Kortere, krachtige termen zodat de letters NOOIT meer buiten de knop vallen!
    String skillLabel = "SKILL";
    if (specialty == PlayerSpecialty.magic) skillLabel = "HEAL";
    if (specialty == PlayerSpecialty.thieving) skillLabel = "STEEAL";
    if (specialty == PlayerSpecialty.warrior) skillLabel = "SMASH";

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: LogdCodes.uiRed, width: 2),
              backgroundColor: LogdCodes.uiRedBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2), // Iets meer ademruimte aan de binnenkant
            ),
            onPressed: onAttackPressed,
            child: const Text("VAL AAN", style: TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: skillUsedThisFight ? LogdCodes.uiGrey : LogdCodes.uiPurple, width: 2),
              backgroundColor: skillUsedThisFight ? LogdCodes.uiCardBg : LogdCodes.uiPurpleBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            ),
            onPressed: onUseSkillPressed,
            child: Text(skillLabel.toUpperCase(), style: TextStyle(color: skillUsedThisFight ? LogdCodes.uiGrey : LogdCodes.uiPurple, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
              backgroundColor: LogdCodes.uiYellowBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            ),
            onPressed: onFleePressed,
            child: const Text("VLUCHT", style: TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
      ],
    );
  }
}
