// lib/widgets/inn_main_grid.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';

class InnMainGrid extends StatelessWidget {
  final Function(String) onSectionChange;
  final VoidCallback onReturnTown;

  const InnMainGrid({
    super.key,
    required this.onSectionChange,
    required this.onReturnTown,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.1,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildGridButton(label: local.innDiceTitle.toUpperCase(), color: Colors.amber, onTap: () => onSectionChange("DICE")),
              // DE FIX: Volledig gelokaliseerd via de juiste .arb getters!
              _buildGridButton(label: local.innMenuBlackjack.toUpperCase(), color: Colors.amber.shade700, onTap: () => onSectionChange("BLACKJACK")),
              _buildGridButton(label: local.innMenuBartender.toUpperCase(), color: Colors.orange, onTap: () => onSectionChange("BARTENDER")),
              _buildGridButton(label: local.innMenuFlirt.toUpperCase(), color: Colors.purple, onTap: () => onSectionChange("FLIRT")),
              _buildGridButton(label: local.innMenuSpy.toUpperCase(), color: Colors.red, onTap: () => onSectionChange("SPY")),
              _buildGridButton(label: local.innMenuNews.toUpperCase(), color: Colors.cyan, onTap: () => onSectionChange("NEWS")),
            ],
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 2),
            minimumSize: const Size.fromHeight(48),
            // DE FIX: Vormgeving gelijkgetrokken met de rest van de game
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          onPressed: onReturnTown,
          child: Text(
              local.btnReturnTown.toUpperCase(),
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontFamily: LogdCodes.retroFont, // DE FIX: Nu ook met de retro-schreef letter!
                fontSize: LogdCodes.fontSizeDefault,
              )
          ),
        ),
      ],
    );
  }

  Widget _buildGridButton({required String label, required Color color, required VoidCallback onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: color.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: LogdCodes.retroFont, // DE FIX: Zorgt dat de knopletters de schreef behouden
          fontSize: LogdCodes.fontSizeDefault - 2, // Iets compacter voor een strakke fit in de gridcellen
        ),
      ),
    );
  }
}
