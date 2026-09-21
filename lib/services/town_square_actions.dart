// lib/services/town_square_actions.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/town_square_dialogs.dart';
import '../theme/logd_codes.dart';
import '../screens/forest_screen.dart';

class TownSquareActions {
  static void showRumorDialog(
    BuildContext context,
    AppLocalizations local,
    String rumorText,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          local.dialogRumorTitle,
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            color: Colors.amber,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: LogdText(text: rumorText, fontSize: LogdCodes.fontSizeDefault),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              local.btnOk,
              style: const TextStyle(
                fontFamily: LogdCodes.retroFont,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showHpWarningDialog(
    BuildContext context,
    AppLocalizations local,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          local.dialogWoundedTitle,
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: LogdText(
          text: local.dialogWoundedMessage,
          fontSize: LogdCodes.fontSizeDefault,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              local.btnOk,
              style: const TextStyle(
                fontFamily: LogdCodes.retroFont,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void navigateToForest(
    BuildContext context,
    int currentHp,
    AppLocalizations local,
    Function(Widget) navigateCallback,
  ) {
    if (currentHp <= 0) {
      TownSquareDialogs.showWoundedWarning(context, local);
    } else {
      navigateCallback(const ForestScreen());
    }
  }
}
