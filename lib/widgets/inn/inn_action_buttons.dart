// lib/widgets/inn/inn_action_buttons.dart
// ... (houd de bovenste imports en parameters exact hetzelfde)
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../../services/inn_controller.dart';

class InnActionButtons extends StatelessWidget {
  final String activeSection;
  final InnController controller;
  final VoidCallback onRollPressed;
  final Function(int) onBuyDrinkPressed; // Gecorrigeerd naar acceptatie van drank ID!
  final VoidCallback onFlirtPressed;
  final VoidCallback onStartBlackjack;
  final VoidCallback onBlackjackHit;
  final VoidCallback onBlackjackStand;

  const InnActionButtons({
    super.key,
    required this.activeSection,
    required this.controller,
    required this.onRollPressed,
    required this.onBuyDrinkPressed,
    required this.onFlirtPressed,
    required this.onStartBlackjack,
    required this.onBlackjackHit,
    required this.onBlackjackStand,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (activeSection == "DICE") {
      return OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.amber, width: 2), backgroundColor: const Color(0xFF241C00), minimumSize: const Size.fromHeight(48)), onPressed: onRollPressed, child: Text(local.btnInnRoll.toUpperCase(), style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)));
    }

    // DE FIX: Cedrik toont nu twee bier-knoppen naast elkaar!
    if (activeSection == "BARTENDER") {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.orange, width: 2), backgroundColor: const Color(0xFF241400)),
              onPressed: () => onBuyDrinkPressed(1), // Koop Dwergen Stout
              child: Text(local.innDrink1Name, style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 3)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.orange, width: 2), backgroundColor: const Color(0xFF241400)),
              onPressed: () => onBuyDrinkPressed(2), // Koop Elfen Meede
              child: Text(local.innDrink2Name, style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault - 3)),
            ),
          ),
        ],
      );
    }

    if (activeSection == "FLIRT") {
      return OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple, width: 2), backgroundColor: const Color(0xFF1A0022), minimumSize: const Size.fromHeight(48)), onPressed: onFlirtPressed, child: Text(local.innFlirtAttempt.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)));
    }
    if (activeSection == "BLACKJACK") {
      if (controller.isBlackjackOver) {
        return OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.amber, width: 2), minimumSize: const Size.fromHeight(48)), onPressed: onStartBlackjack, child: Text(local.innBlackjackStart, style: const TextStyle(color: Colors.amber, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)));
      } else {
        return Row(children: [
          Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.green, width: 2)), onPressed: onBlackjackHit, child: Text(local.innBlackjackHitBtn, style: const TextStyle(color: Colors.greenAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 10),
          Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 2)), onPressed: onBlackjackStand, child: Text(local.innBlackjackStandBtn, style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)))),
        ]);
      }
    }

    return const SizedBox.shrink();
  }
}
