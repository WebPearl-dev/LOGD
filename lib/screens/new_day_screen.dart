// lib/screens/new_day_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../theme/logd_codes.dart';
import '../services/new_day_service.dart';

class NewDayScreen extends StatelessWidget {
  final NewDayResult result;

  const NewDayScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogdText(text: "`y== ${local.resetNewDayTitle.toUpperCase()} ==`w", fontSize: 22),
              const SizedBox(height: 30),
              
              LogdText(text: local.resetNewDayMessage, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 24),
              
              const Divider(color: Colors.grey),
              const SizedBox(height: 16),
              
              LogdText(text: local.resetNightResults, fontSize: LogdCodes.fontSizeCardTitle),
              const SizedBox(height: 10),
              
              if (result.interestEarned > 0)
                LogdText(text: local.resetInterestLog(result.interestEarned.toString()), fontSize: LogdCodes.fontSizeDefault),
              
              LogdText(text: local.resetTurnsLog(result.newTurns.toString()), fontSize: LogdCodes.fontSizeDefault),
              LogdText(text: local.resetReadyLog, fontSize: LogdCodes.fontSizeDefault),
              
              const SizedBox(height: 40),
              
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiGreen, width: 2),
                  backgroundColor: LogdCodes.uiGreenBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Text(local.btnStartDay.toUpperCase(), style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
