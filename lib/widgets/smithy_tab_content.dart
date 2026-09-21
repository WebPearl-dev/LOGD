// lib/widgets/smithy_tab_content.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import '../widgets/logd_text.dart';

class SmithyTabContent extends StatelessWidget {
  final String currentLabel;
  final bool maxReached;
  final String nextName;
  final int cost;
  final bool isWeapon;
  final VoidCallback onBuyUpgrade;

  const SmithyTabContent({
    super.key,
    required this.currentLabel,
    required this.maxReached,
    required this.nextName,
    required this.cost,
    required this.isWeapon,
    required this.onBuyUpgrade,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Content deel (scrollbaar voor kleine schermen)
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogdText(text: "=== ${local.smithyCurrentEquip} ===", fontSize: LogdCodes.fontSizeCardTitle),
                const SizedBox(height: 6),
                LogdText(text: currentLabel, fontSize: LogdCodes.fontSizeDefault),
                const SizedBox(height: 20),

                if (!maxReached) ...[
                  LogdText(text: "=== ${local.smithyUpgradeAvailable} ===", fontSize: LogdCodes.fontSizeCardTitle),
                  const SizedBox(height: 6),
                  LogdText(text: "`c$nextName`w", fontSize: LogdCodes.fontSizeDefault),
                  const SizedBox(height: 4),
                  LogdText(text: local.smithyCostLabel(cost.toString()), fontSize: LogdCodes.fontSizeDefault),
                ] else ...[
                  const SizedBox(height: 20),
                  Center(child: LogdText(text: local.smithyMaxLevel, fontSize: LogdCodes.fontSizeDefault)),
                ],
              ],
            ),
          ),
        ),

        // Koopknop (altijd onderaan vastgezet)
        if (!maxReached)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
                  backgroundColor: LogdCodes.uiYellowBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: onBuyUpgrade,
                child: Text(
                    local.btnBuyUpgrade.toUpperCase(),
                    style: const TextStyle(
                        color: LogdCodes.uiYellow,
                        fontFamily: LogdCodes.retroFont,
                        fontSize: LogdCodes.fontSizeDefault,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),
          ),
      ],
    );
  }
}
