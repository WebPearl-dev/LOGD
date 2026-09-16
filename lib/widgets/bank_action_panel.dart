// lib/widgets/bank_action_panel.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';

class BankActionPanel extends StatelessWidget {
  final TextEditingController amountController;
  final Function(bool) onHandleCustomAmount;
  final VoidCallback onDepositAll;
  final VoidCallback onWithdrawAll;
  final VoidCallback onReturnTown;

  const BankActionPanel({
    super.key,
    required this.amountController,
    required this.onHandleCustomAmount,
    required this.onDepositAll,
    required this.onWithdrawAll,
    required this.onReturnTown,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // GECORRIGEERD: Invoerveld gekoppeld aan de centrale retro wetten
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
          decoration: InputDecoration(
            labelText: local.smithyAmountLabel,
            labelStyle: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
          ),
        ),
        const SizedBox(height: 16),

        // Rij 1: Handmatige transacties
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.yellow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => onHandleCustomAmount(true),
                child: Text(local.btnDepositCustom.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.yellow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => onHandleCustomAmount(false),
                child: Text(local.btnWithdrawCustom.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Rij 2: Alles storten / opnemen
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: onDepositAll,
                child: Text(local.btnDepositAll.toUpperCase(), style: const TextStyle(color: Colors.greenAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: onWithdrawAll,
                child: Text(local.btnWithdrawAll.toUpperCase(), style: const TextStyle(color: Colors.greenAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Terugknop
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          onPressed: onReturnTown,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
