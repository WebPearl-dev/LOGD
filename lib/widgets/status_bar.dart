// lib/widgets/status_bar.dart
import 'package:flutter/material.dart';
import '../theme/logd_codes.dart';

class LogdStatusBar extends StatelessWidget {
  final int currentHp;
  final int maxHp;
  final int goldOnHand;
  final int gems;
  final int turns;
  final int level;
  final int experience;

  const LogdStatusBar({
    super.key,
    required this.currentHp,
    required this.maxHp,
    required this.goldOnHand,
    required this.gems,
    required this.turns,
    required this.level,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    // We berekenen de XP die nodig is voor het volgende niveau om live de balk te vullen
    final int xpNeeded = level * level * 100;
    final double xpProgress = xpNeeded > 0 ? (experience / xpNeeded).clamp(0.0, 1.0) : 0.0;

    return Container(
      color: LogdCodes.uiAppBarBg, // Antracietgrijze retro balk
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Rij 1: HP, Goud en Edelstenen indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatText("HP: $currentHp/$maxHp", LogdCodes.uiGreen),
                _buildStatText("💰 $goldOnHand", LogdCodes.uiYellow),
                _buildStatText("💎 $gems", LogdCodes.uiBlue),
              ],
            ),
            const SizedBox(height: 6),

            // Rij 2: Niveau, Bosbeurten en XP voortgang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatText("LVL: $level", LogdCodes.uiChurch),
                _buildStatText("⏳ TURNS: $turns", LogdCodes.uiOrange),
                _buildStatText("XP: $experience/$xpNeeded", LogdCodes.uiPurple),
              ],
            ),
            const SizedBox(height: 8),

            // Retro XP-voortgangsbalkje onderaan de statusbalk
            ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: LinearProgressIndicator(
                value: xpProgress,
                backgroundColor: LogdCodes.uiCardBg,
                color: LogdCodes.uiPurple,
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HIER WORDT DE RETRO-WET HANDHAAFD:
  Widget _buildStatText(String label, Color color) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontFamily: LogdCodes.retroFont, // Gecorrigeerd: Schakelt nu blindelings mee met monospace/RetroFont
        fontSize: LogdCodes.fontSizeDefault - 2, // Iets compacter voor de statusbalk verhoudingen
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
