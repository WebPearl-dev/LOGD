// lib/widgets/inn/inn_log_display.dart
import 'package:flutter/material.dart';
import '../logd_text.dart';
import '../../l10n/app_localizations.dart';
import '../../services/inn_controller.dart';
import '../../services/town_square_controller.dart';
import '../../theme/logd_codes.dart';

class InnLogDisplay extends StatelessWidget {
  final String activeSection;
  final String statusMessage;
  final List<Map<String, dynamic>> newsLogs;
  final List<Map<String, dynamic>> spyTargets;
  final InnController controller;
  final Function(Map<String, dynamic>) onSpyPressed;
  final Function(Map<String, dynamic>)? onBribePressed;

  const InnLogDisplay({
    super.key,
    required this.activeSection,
    required this.statusMessage,
    required this.newsLogs,
    required this.spyTargets,
    required this.controller,
    required this.onSpyPressed,
    this.onBribePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (activeSection == "NEWS") {
      if (newsLogs.isEmpty) {
        return Center(
          child: LogdText(text: local.inn_news_empty, fontSize: LogdCodes.fontSizeDefault),
        );
      }

      return ListView.builder(
        itemCount: newsLogs.length,
        itemBuilder: (context, index) {
          final log = newsLogs[index];
          final String type = log['log_type'] ?? '';
          final String user = log['username'] ?? local.newsUnknownPlayer;

          final int numericLevel = log['reached_level'] ?? log['value_after'] ?? 0;
          final String levelStr = numericLevel.toString();

          final int numericGold = log['gold_amount'] ?? log['gold'] ?? 0;
          final String goldStr = numericGold.toString();

          String parsedText = "";

          if (type == 'level_up') {
            parsedText = local.newsLogLevelUp(levelStr, user);
          } else if (type == 'inn_win') {
            parsedText = local.newsLogInnWin(goldStr, user);
          } else if (type == 'inn_loss') {
            parsedText = local.newsLogInnLoss(goldStr, user);
          } else if (type == 'defeated') {
            final rawEnemy = log['enemy_name'] ?? '';
            final enemyName = rawEnemy.isNotEmpty ? TownSquareController.getMonsterName(rawEnemy) : 'een monster';
            parsedText = local.newsLogDefeated(enemyName, user);
          } else if (type == 'defeated_brutal') {
            final rawEnemy = log['enemy_name'] ?? '';
            final enemyName = rawEnemy.isNotEmpty ? TownSquareController.getMonsterName(rawEnemy) : 'een monster';
            parsedText = local.newsLogDefeatedBrutal(enemyName, user);
          } else if (type == 'marriage') {
            parsedText = local.newsLogMarriage(log['partner_name'] ?? 'iemand', user);
          } else if (type == 'dragon_kill') {
            parsedText = local.news_dragon_kill(user, log['kills']?.toString() ?? '1');
          } else if (type == 'dragon_attack') {
            parsedText = local.newsLogDragonAttack(user);
          } else if (type == 'dragon_defeat') {
            parsedText = local.newsLogDragonDefeat(user);
          } else {
            parsedText = log['log_text'] ?? log['message'] ?? local.innNewsEnterLog(user);
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogdText(text: "• ", fontSize: LogdCodes.fontSizeDefault),
                Expanded(child: LogdText(text: parsedText, fontSize: LogdCodes.fontSizeDefault)),
              ],
            ),
          );
        },
      );
    }

    if (activeSection == "SPY" || activeSection == "BOUNTY") {
      final bool isBounty = activeSection == "BOUNTY";
      if (spyTargets.isEmpty) {
        return Center(child: LogdText(text: local.inn_spy_empty, fontSize: LogdCodes.fontSizeDefault));
      }

      return ListView.builder(
        itemCount: spyTargets.length,
        itemBuilder: (context, index) {
          final target = spyTargets[index];
          final String name = target['username'] ?? 'Reiziger';
          final String targetLevel = (target['level'] ?? 1).toString();

          return Card(
            color: LogdCodes.uiCardBg,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: PublicListTile(
              title: LogdText(text: "`w$name (Level $targetLevel)`w", fontSize: LogdCodes.fontSizeDefault),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isBounty) ...[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiAmber)),
                      onPressed: () => onSpyPressed(target),
                      child: Text(local.inn_btn_spy_action, style: const TextStyle(color: LogdCodes.uiAmber)),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiCyan)),
                      onPressed: onBribePressed != null ? () => onBribePressed!(target) : null,
                      child: Text(local.innBtnBribe, style: const TextStyle(color: LogdCodes.uiCyan)),
                    ),
                  ] else ...[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiRed)),
                      onPressed: () => onSpyPressed(target), // We hergebruiken de spy-callback voor bounty placement
                      child: Text(local.innBtnBountyAction, style: const TextStyle(color: LogdCodes.uiRed)),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      );
    }

    if (activeSection == "ROMANCE") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(child: LogdText(text: statusMessage, fontSize: LogdCodes.fontSizeDefault))),
          const Divider(color: Colors.grey),
          LogdText(text: local.innRomanceLabel(controller.romancePoints.toString()), fontSize: LogdCodes.fontSizeDefault),
          const SizedBox(height: 5),
          LinearProgressIndicator(value: (controller.romancePoints / 100).clamp(0.0, 1.0), backgroundColor: LogdCodes.uiBlueBg, color: LogdCodes.uiPinkAccent),
        ],
      );
    }

    return SingleChildScrollView(
      child: LogdText(text: statusMessage, fontSize: LogdCodes.fontSizeDefault),
    );
  }
}

class PublicListTile extends StatelessWidget {
  final Widget title;
  final Widget trailing;

  const PublicListTile({
    super.key,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [title, trailing],
      ),
    );
  }
}
