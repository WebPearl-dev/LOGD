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
            childAspectRatio: 3.2,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildGridButton(label: local.innMenuBartender.toUpperCase(), color: LogdCodes.uiOrange, onTap: () => onSectionChange("BARMAN")),
              _buildGridButton(label: local.innMenuBard.toUpperCase(), color: LogdCodes.uiBlue, onTap: () => onSectionChange("BARD")),
              _buildGridButton(label: local.innMenuFlirt.toUpperCase(), color: LogdCodes.uiPurple, onTap: () => onSectionChange("ROMANCE")),
              _buildGridButton(label: local.innMenuVeteran.toUpperCase(), color: LogdCodes.uiBrown, onTap: () => onSectionChange("VETERAN")),
              _buildGridButton(label: local.innMenuGamble.toUpperCase(), color: LogdCodes.uiAmber, onTap: () => onSectionChange("GAMBLE")),
              _buildGridButton(label: local.innMenuSpy.toUpperCase(), color: LogdCodes.uiRed, onTap: () => onSectionChange("SPY")),
              _buildGridButton(label: local.innMenuNews.toUpperCase(), color: LogdCodes.uiCyan, onTap: () => onSectionChange("NEWS")),
              _buildGridButton(label: local.innMenuBounty.toUpperCase(), color: LogdCodes.uiGrey, onTap: () => onSectionChange("BOUNTY")),
            ],
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          onPressed: onReturnTown,
          child: Text(
              local.btnReturnTown.toUpperCase(),
              style: const TextStyle(
                color: LogdCodes.uiBlueDark,
                fontWeight: FontWeight.bold,
                fontFamily: LogdCodes.retroFont,
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
        backgroundColor: color.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: LogdCodes.retroFont,
          fontSize: LogdCodes.fontSizeDefault - 1,
        ),
      ),
    );
  }
}
