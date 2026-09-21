// lib/widgets/town_square_grid.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';

class TownSquareGrid extends StatelessWidget {
  final int currentHp;
  final VoidCallback onBankPressed;
  final VoidCallback onSmithyPressed;
  final VoidCallback onTrainingPressed;
  final VoidCallback onInnPressed;
  final VoidCallback onStablesPressed;
  final VoidCallback onChurchPressed;
  final VoidCallback onAlchemistPressed;
  final VoidCallback onNewsPressed;
  final VoidCallback onHealerPressed;
  final VoidCallback onBarberPressed;
  final VoidCallback onAlleyPressed; // Rotsvast toegevoegd!
  final VoidCallback onMightyEPressed;
  final VoidCallback onWeddingPressed;
  final VoidCallback onTalkTownfolkPressed;
  final VoidCallback onForestAttempt;

  const TownSquareGrid({
    super.key,
    required this.currentHp,
    required this.onBankPressed,
    required this.onSmithyPressed,
    required this.onTrainingPressed,
    required this.onInnPressed,
    required this.onStablesPressed,
    required this.onChurchPressed,
    required this.onAlchemistPressed,
    required this.onNewsPressed,
    required this.onHealerPressed,
    required this.onBarberPressed,
    required this.onAlleyPressed,
    required this.onMightyEPressed,
    required this.onWeddingPressed,
    required this.onTalkTownfolkPressed,
    required this.onForestAttempt,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 3.2,
      children: [
        _buildButton(
          local.btnVisitBank.toUpperCase(),
          Colors.yellow,
          const Color(0xFF1E1E00),
          onBankPressed,
        ),
        _buildButton(
          local.btnVisitSmithy.toUpperCase(),
          Colors.orange,
          const Color(0xFF241400),
          onSmithyPressed,
        ),
        _buildButton(
          local.btnVisitTraining.toUpperCase(),
          Colors.red,
          const Color(0xFF240D0D),
          onTrainingPressed,
        ),
        _buildButton(
          local.btnVisitInn.toUpperCase(),
          const Color(0xFFE040FB),
          const Color(0xFF1F0024),
          onInnPressed,
        ),
        _buildButton(
          local.btnVisitStables.toUpperCase(),
          LogdCodes.uiBlue,
          const Color(0xFF001B24),
          onStablesPressed,
        ),
        _buildButton(
          local.btnVisitChurch.toUpperCase(),
          LogdCodes.uiChurch,
          const Color(0xFF222222),
          onChurchPressed,
        ),
        _buildButton(
          local.btnVisitAlchemist.toUpperCase(),
          LogdCodes.uiMagenta,
          const Color(0xFF240024),
          onAlchemistPressed,
        ),
        _buildButton(
          local.btnVisitNews.toUpperCase(),
          Colors.blue,
          const Color(0xFF0D1B24),
          onNewsPressed,
        ),
        _buildButton(
          local.btnVisitHealer.toUpperCase(),
          Colors.teal,
          const Color(0xFF0D2420),
          onHealerPressed,
        ),
        _buildButton(
          local.btnTalkTownfolk.toUpperCase(),
          Colors.amber,
          const Color(0xFF241C00),
          onTalkTownfolkPressed,
        ),
        _buildButton(
          local.btnVisitBarber.toUpperCase(),
          Colors.pinkAccent,
          const Color(0xFF240014),
          onBarberPressed,
        ),
        _buildButton(
          local.btnVisitAlley.toUpperCase(),
          Colors.purple,
          const Color(0xFF140024),
          onAlleyPressed,
        ),
        _buildButton(
          local.btnVisitMightyE.toUpperCase(),
          Colors.amber,
          const Color(0xFF242000),
          onMightyEPressed,
        ),
        _buildButton(
          local.btnVisitWedding.toUpperCase(),
          Colors.redAccent,
          const Color(0xFF240A0A),
          onWeddingPressed,
        ),
        _buildButton(
          local.btnGoToForest.toUpperCase(),
          currentHp <= 0 ? Colors.grey : Colors.green,
          currentHp <= 0 ? const Color(0x3D000000) : const Color(0xFF0D240D),
          onForestAttempt,
        ),
      ],
    );
  }

  Widget _buildButton(
    String label,
    Color color,
    Color bg,
    VoidCallback onPressed,
  ) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontFamily: LogdCodes.retroFont,
          fontWeight: FontWeight.bold,
          fontSize: LogdCodes.fontSizeDefault - 2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
