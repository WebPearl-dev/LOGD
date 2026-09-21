// lib/widgets/inn/inn_action_buttons.dart
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/logd_codes.dart';
import '../../services/inn_controller.dart';
import '../logd_text.dart';

class InnActionButtons extends StatelessWidget {
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

  const InnActionButtons({
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
    final local = AppLocalizations.of(context)!;

    if (activeSection == "BARMAN") {
      return Row(children: [
        Expanded(child: _buildBtn(label: local.innBtnDrinkAle, color: LogdCodes.uiOrange, onTap: () => onBuyDrinkPressed(1), bgColor: LogdCodes.uiOrangeBg)),
        const SizedBox(width: 8),
        Expanded(child: _buildBtn(label: local.innBtnDrinkDragon, color: LogdCodes.uiRed, onTap: () => onBuyDrinkPressed(2), bgColor: LogdCodes.uiRedBg)),
      ]);
    }

    if (activeSection == "BARD") {
      return Row(children: [
        Expanded(child: _buildBtn(label: local.innBtnBardGold, color: LogdCodes.uiBlue, onTap: () => onListenBardPressed(false))),
        const SizedBox(width: 8),
        Expanded(child: _buildBtn(label: local.innBtnBardGem, color: LogdCodes.uiCyan, onTap: () => onListenBardPressed(true))),
      ]);
    }

    if (activeSection == "ROMANCE") {
      return Column(children: [
        Row(children: [
          Expanded(child: _buildBtn(label: local.innBtnFlirt, color: LogdCodes.uiPurple, onTap: onFlirtPressed, bgColor: LogdCodes.uiPurpleBg)),
          const SizedBox(width: 8),
          Expanded(child: _buildBtn(label: local.innBtnGift, color: LogdCodes.uiPink, onTap: onGiveGiftPressed)),
        ]),
        if (controller.romancePoints >= 100 && !controller.isMarried) ...[
          const SizedBox(height: 8),
          _buildBtn(label: local.innBtnPropose, color: LogdCodes.uiAmber, onTap: onProposePressed, width: double.infinity, bgColor: LogdCodes.uiYellowBg),
        ],
      ]);
    }

    if (activeSection == "VETERAN") {
      return _buildBtn(label: local.inn_btn_talk_veteran, color: LogdCodes.uiBrown, onTap: onTalkToVeteranPressed, width: double.infinity);
    }

    if (activeSection == "GAMBLE") {
      return Column(children: [
        Row(children: [
          Expanded(child: _buildBtn(label: local.innBtnGambleDice, color: LogdCodes.uiAmber, onTap: onPlayDice, bgColor: LogdCodes.uiYellowBg)),
          const SizedBox(width: 8),
          Expanded(child: _buildBtn(label: local.innBtnGambleShell, color: LogdCodes.uiAmber, onTap: onPlayShell, bgColor: LogdCodes.uiYellowBg)),
          const SizedBox(width: 8),
          Expanded(child: _buildBtn(label: local.innBtnGambleBlackjack, color: LogdCodes.uiAmber, onTap: onStartBlackjack, bgColor: LogdCodes.uiYellowBg)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: LogdText(text: local.innGambleShark, fontSize: 13)),
          Expanded(child: _buildBtn(label: local.innBtnHigher, color: LogdCodes.uiGreen, onTap: () => onPlayHigherLower?.call(true))),
          const SizedBox(width: 8),
          Expanded(child: _buildBtn(label: local.innBtnLower, color: LogdCodes.uiRed, onTap: () => onPlayHigherLower?.call(false))),
        ]),
      ]);
    }

    if (activeSection == "BLACKJACK") {
      return Row(children: [
        Expanded(child: _buildBtn(label: local.innBlackjackHitBtn, color: LogdCodes.uiGreen, onTap: onBlackjackHit)),
        const SizedBox(width: 8),
        Expanded(child: _buildBtn(label: local.innBlackjackStandBtn, color: LogdCodes.uiRed, onTap: onBlackjackStand)),
      ]);
    }

    if (activeSection == "SPY" || activeSection == "BOUNTY") {
      return _buildBtn(label: local.innBtnRichest, color: LogdCodes.uiCyan, onTap: onAskRichestPressed ?? () {}, width: double.infinity);
    }

    return const SizedBox.shrink();
  }

  Widget _buildBtn({required String label, required Color color, required VoidCallback onTap, double? width, Color? bgColor}) {
    return SizedBox(
      width: width,
      height: 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          backgroundColor: bgColor ?? color.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        onPressed: onTap,
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontFamily: LogdCodes.retroFont, fontSize: 10),
        ),
      ),
    );
  }
}
