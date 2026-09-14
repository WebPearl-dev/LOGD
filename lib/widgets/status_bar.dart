import 'package:flutter/material.dart';

class LogdStatusBar extends StatelessWidget {
  final int currentHp;
  final int maxHp;
  final int goldOnHand;
  final int gems;
  // De overige parameters laten we in de constructor staan zodat er elders in de app niets crasht!
  final int turns;
  final int level;
  final int experience;

  const LogdStatusBar({
    super.key,
    required this.currentHp,
    required this.maxHp,
    required this.goldOnHand,
    required this.gems,
    this.turns = 0,
    this.level = 1,
    this.experience = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF221100), // Warme BBS-bruine achtergrond
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // HP Status
            Text(
              "HP: $currentHp/$maxHp",
              style: const TextStyle(
                fontFamily: 'Courier',
                color: Color(0xFF00FF66), // Retro Groen
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            // Goud Status
            Text(
              "GOUD: $goldOnHand",
              style: const TextStyle(
                fontFamily: 'Courier',
                color: Color(0xFFFFEA00), // Retro Geel
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            // Gems Status
            Text(
              "GEMS: $gems",
              style: const TextStyle(
                fontFamily: 'Courier',
                color: Color(0xFF00E5FF), // Retro Cyaan
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
