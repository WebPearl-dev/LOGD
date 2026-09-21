// lib/widgets/inn/wedding_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../logd_text.dart';

class WeddingPanel extends StatelessWidget {
  final Map<String, dynamic> storyContent;
  final String welcomeText;
  final String statusMessage;
  final bool isMarried;
  final VoidCallback onMarryPressed;
  final VoidCallback onLeavePressed;

  const WeddingPanel({
    super.key,
    required this.storyContent,
    required this.welcomeText,
    required this.statusMessage,
    required this.isMarried,
    required this.onMarryPressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

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
        if (!isMarried) ...[
          SizedBox(
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.redAccent, width: 2),
                backgroundColor: const Color(0xFF240D0D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: onMarryPressed,
              child: Text(
                local.btnMarry.toUpperCase(),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontFamily: LogdCodes.retroFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
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
