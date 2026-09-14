// lib/widgets/forest_action_buttons.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/logd_enums.dart';

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

    if (isCombatOver) {
      return SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue, width: 2)),
          onPressed: onReturnTownPressed,
          child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 15)),
        ),
      );
    }

    // --- GEBEURTENISSEN IN HET BOS ---
    if (activeEvent != ForestEventType.none) {
      if (activeEvent == ForestEventType.hermit) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.green, width: 2), backgroundColor: const Color(0xFF0D240D)),
                  onPressed: () => onEventChoicePressed('drink'),
                  child: Text(local.btnHermitDrink.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2)),
                  onPressed: () => onEventChoicePressed('walk'),
                  child: const Text("LOOP DOOR", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ),
          ],
        );
      }

      if (activeEvent == ForestEventType.fountain) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.cyan, width: 2), backgroundColor: const Color(0xFF001B24)),
                  onPressed: () => onEventChoicePressed('dive'),
                  child: const Text("DUIK IN BRON", textAlign: TextAlign.center, style: TextStyle(color: Colors.cyanAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2)),
                  onPressed: () => onEventChoicePressed('leave'),
                  child: const Text("LOOP DOOR", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ),
          ],
        );
      }

      if (activeEvent == ForestEventType.giant) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.orange, width: 2), backgroundColor: const Color(0xFF241400)),
                  onPressed: () => onEventChoicePressed('sneak'),
                  child: const Text("SLUIP ER LANGS", textAlign: TextAlign.center, style: TextStyle(color: Colors.orangeAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 2), backgroundColor: const Color(0xFF240D0D)),
                  onPressed: () => onEventChoicePressed('steal'),
                  child: const Text("BESTEEL REUS", textAlign: TextAlign.center, style: TextStyle(color: Colors.redAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ),
          ],
        );
      }
    }

    // --- STANDAARD GEVECHTSKNOPPEN ---
    // DE FIX: Vervang hardcoded fallback-tekst met een gelokaliseerde arb key
    String skillLabel = local.btnSkillFallback;
    if (specialty == PlayerSpecialty.magic) skillLabel = local.skillMagicName;
    if (specialty == PlayerSpecialty.thieving) skillLabel = local.skillThievingName;
    if (specialty == PlayerSpecialty.warrior) skillLabel = local.skillWarriorName;

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 2), backgroundColor: const Color(0xFF240D0D)),
              onPressed: onAttackPressed,
              child: const Text("AANVALLEN", style: TextStyle(color: Colors.redAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: skillUsedThisFight ? Colors.grey.shade800 : Colors.purple, width: 2),
                backgroundColor: skillUsedThisFight ? Colors.black : const Color(0xFF1A0022),
              ),
              onPressed: onUseSkillPressed,
              child: Text(skillLabel.toUpperCase(), style: TextStyle(color: skillUsedThisFight ? Colors.grey : Colors.purpleAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.yellow, width: 2), backgroundColor: const Color(0xFF1E1E00)),
              onPressed: onFleePressed,
              child: const Text("VLUCHTEN", style: TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ),
      ],
    );
  }
}
