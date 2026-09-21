// lib/widgets/inn/alley_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../logd_text.dart';

class AlleyPanel extends StatelessWidget {
  final Map<String, dynamic> storyContent;
  final String statusMessage;
  final int gems;
  final VoidCallback onResetReputationPressed;
  final VoidCallback onLeavePressed;

  const AlleyPanel({
    super.key,
    required this.storyContent,
    required this.statusMessage,
    required this.gems,
    required this.onResetReputationPressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final String welcomeText = storyContent['dark_alley_welcome'] ?? "...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LogdText(
                  text: welcomeText,
                  fontSize: LogdCodes.fontSizeDefault,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(color: Colors.grey),
                ),
                if (statusMessage.isNotEmpty) ...[
                  LogdText(
                    text: statusMessage,
                    fontSize: LogdCodes.fontSizeDefault,
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 48,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.purple, width: 2),
              backgroundColor: const Color(0xFF140024),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onPressed: onResetReputationPressed,
            child: Text(
              local.btnResetReputation.toUpperCase(),
              style: const TextStyle(
                color: Colors.purpleAccent,
                fontFamily: LogdCodes.retroFont,
                fontWeight: FontWeight.bold,
                fontSize: LogdCodes.fontSizeDefault - 2,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
            backgroundColor: LogdCodes.uiBlueBg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          onPressed: onLeavePressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              local.btnReturnTown.toUpperCase(),
              style: const TextStyle(
                color: LogdCodes.uiBlueDark,
                fontFamily: LogdCodes.retroFont,
                fontSize: LogdCodes.fontSizeDefault,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
