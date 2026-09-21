// lib/widgets/inn/mightye_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../logd_text.dart';

class MightyEPanel extends StatelessWidget {
  final Map<String, dynamic> storyContent;
  final String statusMessage;
  final VoidCallback onDonatePressed;
  final VoidCallback onLeavePressed;

  const MightyEPanel({
    super.key,
    required this.storyContent,
    required this.statusMessage,
    required this.onDonatePressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final String welcomeText = storyContent['mightye_welcome'] ?? "...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // DE FIX: Kaarsrechte Flutter syntax!
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
              side: const BorderSide(color: Colors.amber, width: 2),
              backgroundColor: const Color(0xFF241C00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onPressed: onDonatePressed,
            child: Text(
              local.btnDonateGem.toUpperCase(),
              style: const TextStyle(
                color: Colors.amberAccent,
                fontFamily: LogdCodes.retroFont,
                fontWeight: FontWeight.bold,
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
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
