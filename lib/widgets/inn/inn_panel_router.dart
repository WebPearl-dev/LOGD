// lib/widgets/inn/inn_panel_router.dart
import 'package:flutter/material.dart';
import '../../services/inn_controller.dart';
import '../../widgets/inn/inn_action_buttons.dart';

class InnPanelRouter extends StatelessWidget {
  final String activeSection;
  final InnController controller;
  
  final Function(int) onBuyDrinkPressed;
  final Function(bool) onListenBardPressed;
  final VoidCallback onFlirtPressed;
  final VoidCallback onGiveGiftPressed;
  final VoidCallback onProposePressed;
  final VoidCallback onTalkToVeteranPressed;
  final VoidCallback onStartBlackjack;
  final VoidCallback onBlackjackHit;
  final VoidCallback onBlackjackStand;
  final VoidCallback onPlayDice;
  final VoidCallback onPlayShell;
  final Function(bool)? onPlayHigherLower;
  final VoidCallback? onAskRichestPressed;

  const InnPanelRouter({
    super.key,
    required this.activeSection,
    required this.controller,
    required this.onBuyDrinkPressed,
    required this.onListenBardPressed,
    required this.onFlirtPressed,
    required this.onGiveGiftPressed,
    required this.onProposePressed,
    required this.onTalkToVeteranPressed,
    required this.onStartBlackjack,
    required this.onBlackjackHit,
    required this.onBlackjackStand,
    required this.onPlayDice,
    required this.onPlayShell,
    this.onPlayHigherLower,
    this.onAskRichestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InnActionButtons(
      activeSection: activeSection,
      controller: controller,
      onBuyDrinkPressed: onBuyDrinkPressed,
      onListenBardPressed: onListenBardPressed,
      onFlirtPressed: onFlirtPressed,
      onGiveGiftPressed: onGiveGiftPressed,
      onProposePressed: onProposePressed,
      onTalkToVeteranPressed: onTalkToVeteranPressed,
      onStartBlackjack: onStartBlackjack,
      onBlackjackHit: onBlackjackHit,
      onBlackjackStand: onBlackjackStand,
      onPlayDice: onPlayDice,
      onPlayShell: onPlayShell,
      onPlayHigherLower: onPlayHigherLower,
      onAskRichestPressed: onAskRichestPressed,
    );
  }
}
