// lib/widgets/profile_action_panel.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';

class ProfileActionPanel extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onUpdateUsername;
  final VoidCallback onLogout;
  final Function(BuildContext) onDeleteAccountAttempt;

  const ProfileActionPanel({
    super.key,
    required this.isLoading,
    required this.onUpdateUsername,
    required this.onLogout,
    required this.onDeleteAccountAttempt,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 45,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))
            ),
            onPressed: isLoading ? null : onUpdateUsername,
            child: Text(local.btnSave.toUpperCase(), style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 40),

        OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: LogdCodes.uiCyan, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))
          ),
          onPressed: isLoading ? null : onLogout,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(local.profileLogout.toUpperCase(), style: const TextStyle(color: LogdCodes.uiCyan, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),

        OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: LogdCodes.uiRed, width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))
          ),
          onPressed: isLoading ? null : () => onDeleteAccountAttempt(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(local.profileDeleteAccount.toUpperCase(), style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
