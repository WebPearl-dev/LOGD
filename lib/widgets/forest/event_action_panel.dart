// lib/widgets/forest/event_action_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/logd_enums.dart';
import '../../theme/logd_codes.dart';

class EventActionPanel extends StatelessWidget {
  final ForestEventType activeEvent;
  final Function(String) onEventChoicePressed;

  const EventActionPanel({
    super.key,
    required this.activeEvent,
    required this.onEventChoicePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    // --- 1. DE OUDE KLUIZENAAR ---
    if (activeEvent == ForestEventType.hermit) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green, width: 2),
                backgroundColor: const Color(0xFF0D240D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('drink'),
              child: Text(local.btnHermitDrink.toUpperCase(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.greenAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('walk'),
              // DE FIX: Gelokaliseerd!
              child: Text(local.btnForestWalkAway, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
            ),
          ),
        ],
      );
    }

    // --- 2. DE WATERBRON ---
    if (activeEvent == ForestEventType.fountain) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.cyan, width: 2),
                backgroundColor: const Color(0xFF001B24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('dive'),
              // DE FIX: Gelokaliseerd!
              child: Text(local.btnForestFountainDive, textAlign: TextAlign.center, style: const TextStyle(color: Colors.cyanAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('leave'),
              // DE FIX: Gelokaliseerd!
              child: Text(local.btnForestWalkAway, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 2)),
            ),
          ),
        ],
      );
    }

    // --- 3. DE SLAPENDE REUS ---
    if (activeEvent == ForestEventType.giant) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange, width: 2),
                backgroundColor: const Color(0xFF241400),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('sneak'),
              // DE FIX: Gelokaliseerd!
              child: Text(local.btnForestGiantSneak, textAlign: TextAlign.center, style: const TextStyle(color: Colors.orangeAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 3)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 2),
                backgroundColor: const Color(0xFF240D0D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => onEventChoicePressed('steal'),
              // DE FIX: Gelokaliseerd!
              child: Text(local.btnForestGiantSteal, textAlign: TextAlign.center, style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 3)),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
