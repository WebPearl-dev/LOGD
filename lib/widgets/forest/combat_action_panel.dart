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
              side: const BorderSide(color: Colors.red, width: 2),
              backgroundColor: const Color(0xFF240D0D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2), // Iets meer ademruimte aan de binnenkant
            ),
            onPressed: onAttackPressed,
            child: const Text("VAL AAN", style: TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: skillUsedThisFight ? Colors.grey.shade800 : Colors.purple, width: 2),
              backgroundColor: skillUsedThisFight ? Colors.black : const Color(0xFF1A0022),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            ),
            onPressed: onUseSkillPressed,
            child: Text(skillLabel.toUpperCase(), style: TextStyle(color: skillUsedThisFight ? Colors.grey : Colors.purpleAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.yellow, width: 2),
              backgroundColor: const Color(0xFF1E1E00),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            ),
            onPressed: onFleePressed,
            child: const Text("VLUCHT", style: TextStyle(color: Colors.yellowAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
          ),
        ),
      ],
    );
  }
}
