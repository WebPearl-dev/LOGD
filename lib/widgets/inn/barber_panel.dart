// lib/widgets/inn/barber_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../logd_text.dart';

class BarberPanel extends StatelessWidget {
  final Map<String, dynamic> storyContent;
  final String statusMessage;
  final int gems;
  final int level;
  final VoidCallback onBuyTitlePressed;
  final VoidCallback onBuyCutPressed;
  final VoidCallback onBuyShavePressed;
  final VoidCallback onBuyDyePressed;
  final VoidCallback onLeavePressed;

  const BarberPanel({
    super.key,
    required this.storyContent,
    required this.statusMessage,
    required this.gems,
    required this.level,
    required this.onBuyTitlePressed,
    required this.onBuyCutPressed,
    required this.onBuyShavePressed,
    required this.onBuyDyePressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final String welcomeText = storyContent['welcome'] ?? "...";

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

        // Nieuwe Service 1: Knippen
        _buildServiceButton(
          label: local.btnBuyCut((level * 50).toString()),
          onPressed: onBuyCutPressed,
          color: Colors.greenAccent,
        ),
        const SizedBox(height: 8),

        // Nieuwe Service 2: Scheren
        _buildServiceButton(
          label: local.btnBuyShave((level * 20).toString()),
          onPressed: onBuyShavePressed,
          color: Colors.cyanAccent,
        ),
        const SizedBox(height: 8),

        // Nieuwe Service 3: Verven
        _buildServiceButton(
          label: local.btnBuyDye,
          onPressed: onBuyDyePressed,
          color: Colors.purpleAccent,
        ),
        const SizedBox(height: 8),

        // Bestaande Service: Titel
        _buildServiceButton(
          label: local.btnBuyTitle.toUpperCase(),
          onPressed: onBuyTitlePressed,
          color: Colors.pinkAccent,
        ),
        const SizedBox(height: 12),

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

  Widget _buildServiceButton({
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      height: 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          backgroundColor: color.withAlpha(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: color,
            fontFamily: LogdCodes.retroFont,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
