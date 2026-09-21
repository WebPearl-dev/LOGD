// lib/widgets/town_square_panels.dart
import 'package:flutter/material.dart';
import 'inn/healer_panel.dart';
import 'inn/barber_panel.dart';
import 'inn/alley_panel.dart';
import 'inn/mightye_panel.dart';
import 'inn/wedding_panel.dart';

class TownSquarePanels extends StatelessWidget {
  final String activeSubLocation;
  final Map<String, dynamic>?
  playerData; // DE CORE FIX: Directe toegang tot de echte spelerdata!
  final Map<String, dynamic> storyContent;
  final Map<String, dynamic> barberContent;
  final String healerStatusMessage;
  final String barberStatusMessage;
  final String alleyStatusMessage;
  final String mightyEStatusMessage;
  final String weddingStatusMessage;
  final int currentHp;
  final int maxHp;
  final int gems;
  final int level;
  final bool isMarried;
  final VoidCallback onHealPressed;
  final VoidCallback onBarberPressed;
  final VoidCallback onBarberCutPressed;
  final VoidCallback onBarberShavePressed;
  final VoidCallback onBarberDyePressed;
  final VoidCallback onAlleyPressed;
  final VoidCallback onMightyEPressed;
  final VoidCallback onWeddingPressed;
  final VoidCallback onLeavePressed;

  const TownSquarePanels({
    super.key,
    required this.activeSubLocation,
    this.playerData, // Netjes opgenomen
    required this.storyContent,
    required this.barberContent,
    required this.healerStatusMessage,
    required this.barberStatusMessage,
    required this.alleyStatusMessage,
    required this.mightyEStatusMessage,
    required this.weddingStatusMessage,
    required this.currentHp,
    required this.maxHp,
    required this.gems,
    required this.level,
    required this.isMarried,
    required this.onHealPressed,
    required this.onBarberPressed,
    required this.onBarberCutPressed,
    required this.onBarberShavePressed,
    required this.onBarberDyePressed,
    required this.onAlleyPressed,
    required this.onMightyEPressed,
    required this.onWeddingPressed,
    required this.onLeavePressed,
  });

  @override
  Widget build(BuildContext context) {
    final String loc = activeSubLocation.toUpperCase();

    if (loc == "HEALER") {
      return HealerPanel(
        storyContent: storyContent,
        statusMessage: healerStatusMessage,
        currentHp: currentHp,
        maxHp: maxHp,
        healCost: level * 20,
        onHealPressed: onHealPressed,
        onLeavePressed: onLeavePressed,
      );
    }
    if (loc == "BARBER") {
      return BarberPanel(
        storyContent: barberContent,
        statusMessage: barberStatusMessage,
        gems: gems,
        level: level,
        onBuyTitlePressed: onBarberPressed,
        onBuyCutPressed: onBarberCutPressed,
        onBuyShavePressed: onBarberShavePressed,
        onBuyDyePressed: onBarberDyePressed,
        onLeavePressed: onLeavePressed,
      );
    }
    if (loc == "ALLEY") {
      return AlleyPanel(
        storyContent: storyContent,
        statusMessage: alleyStatusMessage,
        gems: gems,
        onResetReputationPressed: onAlleyPressed,
        onLeavePressed: onLeavePressed,
      );
    }
    if (loc == "MIGHTYE") {
      return MightyEPanel(
        storyContent: storyContent,
        statusMessage: mightyEStatusMessage,
        onDonatePressed: onMightyEPressed,
        onLeavePressed: onLeavePressed,
      );
    }
    if (loc == "WEDDING") {
      // DE CORE FIX: We lezen het geslacht nu ZUIVER uit de echte cloud-data van profiles!
      final String gender = playerData?['gender'] ?? 'M';
      final String baseWelcome =
          storyContent['wedding_welcome']?.toString() ?? "...";
      final String parsedWelcome = baseWelcome.replaceAll(
        '[Liefdesinteresse (Violet/Seth)]',
        (gender == 'F' ? 'Seth' : 'Violet'),
      );

      return WeddingPanel(
        storyContent: storyContent,
        welcomeText: parsedWelcome,
        statusMessage: weddingStatusMessage,
        isMarried: isMarried,
        onMarryPressed: onWeddingPressed,
        onLeavePressed: onLeavePressed,
      );
    }
    return const SizedBox.shrink();
  }
}
