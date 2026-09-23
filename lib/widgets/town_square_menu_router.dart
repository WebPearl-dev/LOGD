// lib/widgets/town_square_menu_router.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';

class TownSquareMenuRouter extends StatelessWidget {
  final String activeSubLocation;
  final VoidCallback onForestPressed;
  final VoidCallback onNewsPressed;
  final Function(String) onSubMenuPressed;
  final VoidCallback onSmithyPressed;
  final VoidCallback onBankPressed;
  final VoidCallback onBarberPressed;
  final VoidCallback onAlchemistPressed;
  final VoidCallback onHealerPressed;
  final VoidCallback onAlleyPressed;
  final VoidCallback onTrainingPressed;
  final VoidCallback onStablesPressed;
  final VoidCallback onInnPressed;
  final VoidCallback onChurchPressed;
  final VoidCallback onWeddingPressed;
  final VoidCallback onTownfolkPressed;
  final VoidCallback onMightyEPressed;
  final VoidCallback onRankingsPressed;
  final VoidCallback onDragonShrinePressed;

  const TownSquareMenuRouter({
    super.key,
    required this.activeSubLocation,
    required this.onForestPressed,
    required this.onNewsPressed,
    required this.onSubMenuPressed,
    required this.onSmithyPressed,
    required this.onBankPressed,
    required this.onBarberPressed,
    required this.onAlchemistPressed,
    required this.onHealerPressed,
    required this.onAlleyPressed,
    required this.onTrainingPressed,
    required this.onStablesPressed,
    required this.onInnPressed,
    required this.onChurchPressed,
    required this.onWeddingPressed,
    required this.onTownfolkPressed,
    required this.onMightyEPressed,
    required this.onRankingsPressed,
    required this.onDragonShrinePressed,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    Widget buildMenuButton({
      required String label,
      required Color color,
      required VoidCallback onPressed,
      Color? customBg,
    }) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          backgroundColor: customBg ?? color.withAlpha(13),
        ).copyWith(foregroundColor: WidgetStateProperty.all<Color>(color)),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontFamily: LogdCodes.retroFont,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    switch (activeSubLocation) {
      case "MAIN":
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            buildMenuButton(
              label: local.town_btn_forest,
              color: Colors.green,
              onPressed: onForestPressed,
            ),
            buildMenuButton(
              label: local.town_btn_news,
              color: Colors.white,
              onPressed: onNewsPressed,
            ),
            buildMenuButton(
              label: local.town_btn_shops,
              color: Colors.yellow,
              onPressed: () => onSubMenuPressed("SUB_SHOPS"),
            ),
            buildMenuButton(
              label: local.town_btn_mystery,
              color: Colors.purple,
              onPressed: () => onSubMenuPressed("SUB_MYSTERY"),
            ),
            buildMenuButton(
              label: local.town_btn_training,
              color: LogdCodes.uiRed,
              onPressed: () => onSubMenuPressed("SUB_TRAINING"),
            ),
            buildMenuButton(
              label: local.town_btn_heart,
              color: LogdCodes.uiBlue,
              customBg: LogdCodes.uiBlueBg,
              onPressed: () => onSubMenuPressed("SUB_TOWN"),
            ),
            buildMenuButton(
              label: local.rankingsTitle,
              color: Colors.amberAccent,
              onPressed: onRankingsPressed,
            ),
          ],
        );

      case "SUB_SHOPS":
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            buildMenuButton(
              label: local.btnVisitSmithy,
              color: Colors.orange,
              onPressed: onSmithyPressed,
            ),
            buildMenuButton(
              label: local.btnVisitBank,
              color: Colors.yellow,
              onPressed: onBankPressed,
            ),
            buildMenuButton(
              label: local.btnVisitBarber,
              color: Colors.pinkAccent,
              onPressed: onBarberPressed,
            ), // Roze voor de kapper!
          ],
        );

      case "SUB_MYSTERY":
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            buildMenuButton(
              label: local.btnVisitAlchemist,
              color: LogdCodes.uiMagenta,
              onPressed: onAlchemistPressed,
            ),
            buildMenuButton(
              label: local.btnVisitHealer,
              color: LogdCodes.uiTeal,
              onPressed: onHealerPressed,
            ), // Teal voor de Kruidenheks!
            buildMenuButton(
              label: local.btnVisitAlley,
              color: LogdCodes.uiPurple,
              onPressed: onAlleyPressed,
            ), // Paars voor Sly!
            buildMenuButton(
              label: local.btnVisitDragonShrine,
              color: LogdCodes.uiAmber,
              onPressed: onDragonShrinePressed,
            ),
          ],
        );

      case "SUB_TRAINING":
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            buildMenuButton(
              label: "Training",
              color: LogdCodes.uiRed,
              onPressed: onTrainingPressed,
            ),
            buildMenuButton(
              label: local.btnVisitStables,
              color: LogdCodes.uiBlue,
              onPressed: onStablesPressed,
            ),
          ],
        );

      case "SUB_TOWN":
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 3.2,
          children: [
            buildMenuButton(
              label: local.btnVisitInn,
              color: const Color(0xFFE040FB),
              onPressed: onInnPressed,
            ),
            buildMenuButton(
              label: local.btnVisitChurch,
              color: LogdCodes.uiChurch,
              onPressed: onChurchPressed,
            ),
            buildMenuButton(
              label: local.btnVisitWedding,
              color: Colors.redAccent,
              onPressed: onWeddingPressed,
            ), // Rood voor de kapel!
            buildMenuButton(
              label: local.btnTalkTownfolk,
              color: Colors.amber,
              onPressed: onTownfolkPressed,
            ),
            buildMenuButton(
              label: local.btnVisitMightyE,
              color: Colors.amber,
              onPressed: onMightyEPressed,
            ), // Goud voor MightyE!
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
