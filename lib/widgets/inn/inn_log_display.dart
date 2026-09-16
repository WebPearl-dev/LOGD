// lib/widgets/inn/inn_log_display.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../../widgets/logd_text.dart';
import '../../services/inn_controller.dart';

class InnLogDisplay extends StatelessWidget {
  final String activeSection;
  final String statusMessage;
  final List<Map<String, dynamic>> newsLogs;
  final List<Map<String, dynamic>> spyTargets;
  final InnController controller;
  final Function(Map<String, dynamic>) onSpyPressed;

  const InnLogDisplay({
    super.key,
    required this.activeSection,
    required this.statusMessage,
    required this.newsLogs,
    required this.spyTargets,
    required this.controller,
    required this.onSpyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade800, width: 2), color: Colors.black),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (activeSection == "MAIN") LogdText(text: local.innWelcome, fontSize: LogdCodes.fontSizeDefault),

            if (statusMessage.isNotEmpty) ...[
              // DE FIX: Vangt de dynamic flirt resultaten op en koppelt ze aan de vertaal-keys!
              if (statusMessage == "DRINK_1_SUCCESS") LogdText(text: local.innDrinkSuccess1, fontSize: LogdCodes.fontSizeDefault)
              else if (statusMessage == "DRINK_2_SUCCESS") LogdText(text: local.innDrinkSuccess2, fontSize: LogdCodes.fontSizeDefault)
              else if (statusMessage == "FLIRT_MAX_HP_BONUS") LogdText(text: local.innFlirtMaxHpBonus, fontSize: LogdCodes.fontSizeDefault)
                else if (statusMessage == "FLIRT_TURNS_BONUS") LogdText(text: local.innFlirtTurnsBonus, fontSize: LogdCodes.fontSizeDefault)
                  else if (statusMessage == "FLIRT_SLAP_DEFEAT") LogdText(text: local.innFlirtSlapDefeat, fontSize: LogdCodes.fontSizeDefault)
                    else LogdText(text: statusMessage, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 10),
            ],

            if (activeSection == "BARTENDER") ...[
              LogdText(text: local.innDrinkSelectTitle, fontSize: LogdCodes.fontSizeCardTitle),
              const SizedBox(height: 6),
              LogdText(text: local.innDrinkSelectDesc, fontSize: LogdCodes.fontSizeDefault),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider(color: Colors.grey)),
              LogdText(text: "`o1. ${local.innDrink1Name}`w\n${local.innDrink1Desc}", fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 10),
              LogdText(text: "`o2. ${local.innDrink2Name}`w\n${local.innDrink2Desc}", fontSize: LogdCodes.fontSizeDefault),
            ],

            if (activeSection == "NEWS") ...[
              LogdText(text: local.innNewsTitle, fontSize: LogdCodes.fontSizeCardTitle),
              const SizedBox(height: 10),
              ...newsLogs.map((row) {
                String user = row['username'] ?? local.innNewsUnknownPlayer;
                String type = row['log_type'] ?? "";
                String val = (row['reached_level'] ?? 0).toString();
                String logLine = local.innNewsEnterLog(user);
                if (type == 'inn_win') logLine = local.innNewsWinLog(user, val);
                if (type == 'inn_loss') logLine = local.innNewsLossLog(user, val);
                return Padding(padding: const EdgeInsets.only(bottom: 6), child: LogdText(text: logLine, fontSize: LogdCodes.fontSizeDefault));
              }),
            ],

            if (activeSection == "SPY") ...[
              LogdText(text: local.innSpySelect, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 10),
              if (spyTargets.isEmpty)
                LogdText(text: local.innSpyNoTargets, fontSize: LogdCodes.fontSizeDefault)
              else ...spyTargets.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red, width: 2)),
                  onPressed: () => onSpyPressed(t),
                  child: Text("${t['username']} (Lv ${t['level']})", style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
                ),
              )),
            ],

            if (activeSection == "BLACKJACK" && !controller.isBlackjackOver) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(8),
                color: const Color(0xFF222222),
                child: LogdText(text: local.innBlackjackScoreLog(controller.playerHand.toString(), controller.calculateScore(controller.playerHand).toString(), controller.houseHand.toString()), fontSize: LogdCodes.fontSizeDefault),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
