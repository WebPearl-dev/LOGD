// lib/widgets/inn/healer_panel.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../logd_text.dart';

class HealerPanel extends StatelessWidget {
  final Map<String, dynamic> storyContent;
  final String statusMessage;
  final int currentHp;
  final int maxHp;
  final int healCost;
  final VoidCallback onHealPressed;
  final VoidCallback onLeavePressed;

  const HealerPanel({
    super.key,
    required this.storyContent,
    required this.statusMessage,
    required this.currentHp,
    required this.maxHp,
    required this.healCost,
    required this.onHealPressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final String welcomeText =
        storyContent['healer_welcome'] ?? local.healerFallbackWelcome;
    final String healthyText =
        storyContent['healer_healthy'] ?? local.healerFallbackHealthy;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // DE FLEXIBELE OVERFLOW FIX: Verhalen zijn nu vloeibaar scrollbaar mocht het scherm te klein zijn!
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
                LogdText(
                  text: local.labelHealCost(healCost.toString()),
                  fontSize: LogdCodes.fontSizeDefault,
                ),
                if (currentHp >= maxHp) ...[
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: const Color(0xFF112211),
                    child: LogdText(
                      text: healthyText,
                      fontSize: LogdCodes.fontSizeDefault,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // De stabiele knoppensectie aan de onderzijde
        if (currentHp < maxHp) ...[
          SizedBox(
            height: 48,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiGreen, width: 2),
                backgroundColor: const Color(0xFF0D240D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: onHealPressed,
              child: Text(
                local.btnBuyHealing.toUpperCase(),
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: LogdCodes.retroFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],

        // DE RETRO THEME FIX: Nu dwingend via uiBlueDark voor die rustige look!
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
