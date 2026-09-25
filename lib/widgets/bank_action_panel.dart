// lib/widgets/bank_action_panel.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import 'logd_text.dart';

class BankActionPanel extends StatelessWidget {
  final TextEditingController amountController;
  final Function(bool) onHandleCustomAmount;
  final VoidCallback onDepositAll;
  final VoidCallback onWithdrawAll;
  final String? limitInfo;

  const BankActionPanel({
    super.key,
    required this.amountController,
    required this.onHandleCustomAmount,
    required this.onDepositAll,
    required this.onWithdrawAll,
    this.limitInfo,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (limitInfo != null) ...[
          LogdText(text: limitInfo!, fontSize: LogdCodes.fontSizeDefault - 2),
          const SizedBox(height: 8),
        ],
        
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: LogdCodes.uiChurch, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
          decoration: InputDecoration(
            labelText: local.smithyAmountLabel,
            labelStyle: const TextStyle(color: LogdCodes.uiGrey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGrey)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiYellow)),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => onHandleCustomAmount(true),
                child: Text(local.btnDepositCustom.toUpperCase(), style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => onHandleCustomAmount(false),
                child: Text(local.btnWithdrawCustom.toUpperCase(), style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiGreen, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: onDepositAll,
                child: Text(local.btnDepositAll.toUpperCase(), style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiGreen, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: onWithdrawAll,
                child: Text(local.btnWithdrawAll.toUpperCase(), style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 2, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
