// lib/screens/inn_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/status_bar.dart';
import '../widgets/inn_main_grid.dart';
import '../widgets/inn/inn_action_buttons.dart';
import '../widgets/inn/inn_log_display.dart';
import '../theme/logd_codes.dart';
import '../services/inn_controller.dart';
import '../services/logd_enums.dart';

class InnScreen extends StatefulWidget {
  const InnScreen({super.key});

  @override
  State<InnScreen> createState() => _InnScreenState();
}

class _InnScreenState extends State<InnScreen> {
  final InnController _controller = InnController();
  final int _wagerAmount = 50;

  String _activeSection = "MAIN";
  List<Map<String, dynamic>> _spyTargets = [];
  List<Map<String, dynamic>> _newsLogs = [];

  @override
  void initState() {
    super.initState();
    _controller.initInn(() { if (mounted) setState(() {}); });
  }

  void _changeSection(String section) async {
    setState(() { _activeSection = section; _controller.statusMessage = ""; });
    if (section == "SPY") {
      final targets = await _controller.getSpyTargets();
      setState(() { _spyTargets = targets; });
    } else if (section == "NEWS") {
      final logs = await _controller.getLatestNews();
      setState(() { _newsLogs = logs; });
    }
  }

  void _onRollPressed() {
    final local = AppLocalizations.of(context)!;
    _controller.playDice(_wagerAmount, (status, pRoll, eRoll) {
      setState(() {
        if (_controller.statusMessage == "NO_GOLD") { _controller.statusMessage = local.innErrorNoGold; return; }
        if (status == CombatStatus.skillMagic) { _controller.statusMessage = local.innDiceVictory(pRoll.toString(), eRoll.toString(), _wagerAmount.toString()); }
        else if (status == CombatStatus.playerDied) { _controller.statusMessage = local.innDiceDefeat(pRoll.toString(), eRoll.toString(), _wagerAmount.toString()); }
        else { _controller.statusMessage = local.innDiceTie(pRoll.toString()); }
      });
    });
  }

  void _onStartBlackjack() {
    _controller.startBlackjack(_wagerAmount);
    setState(() { if (_controller.statusMessage == "NO_GOLD") _controller.statusMessage = AppLocalizations.of(context)!.innErrorNoGold; });
  }

  void _onBlackjackHit() {
    final local = AppLocalizations.of(context)!;
    setState(() {
      _controller.blackjackHit(_wagerAmount, (res) {
        if (res == "BUST") {
          final String scoreStr = _controller.calculateScore(_controller.playerHand).toString();
          _controller.statusMessage = "${LogdCodes.colorLoss}${local.innBlackjackBustLog(scoreStr)}";
        }
      });
    });
  }

  void _onBlackjackStand() {
    final local = AppLocalizations.of(context)!;
    setState(() {
      _controller.blackjackStand(_wagerAmount, (res, pScore, hScore) {
        final String pScoreStr = pScore.toString();
        final String hScoreStr = hScore.toString();

        if (res == "WIN") { _controller.statusMessage = "${LogdCodes.colorGold}${local.innBlackjackWinLog(pScoreStr, hScoreStr)}"; }
        else if (res == "LOSE") { _controller.statusMessage = "${LogdCodes.colorLoss}${local.innBlackjackLoseLog(pScoreStr, hScoreStr)}"; }
        else { _controller.statusMessage = local.innBlackjackTieLog(pScoreStr); }
      });
    });
  }

  void _onSpyAction(Map<String, dynamic> target) {
    final local = AppLocalizations.of(context)!;
    setState(() {
      _controller.goldOnHand -= 10;
      _controller.statusMessage = local.innSpyResultLog(target['username'], target['level'].toString(), target['gold_on_hand'].toString());
      _controller.updateCloudStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_controller.isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(_activeSection == "MAIN" ? local.innTitle : "=== $_activeSection ===", style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2D2D2D),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: InnLogDisplay(
                activeSection: _activeSection,
                statusMessage: _controller.statusMessage,
                newsLogs: _newsLogs,
                spyTargets: _spyTargets,
                controller: _controller,
                onSpyPressed: _onSpyAction,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              flex: 5,
              child: _activeSection == "MAIN"
                  ? InnMainGrid(
                onSectionChange: _changeSection,
                onReturnTown: () => Navigator.pop(context),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InnActionButtons(
                    activeSection: _activeSection,
                    controller: _controller,
                    onRollPressed: _onRollPressed,
                    onBuyDrinkPressed: (drinkId) {
                      final local = AppLocalizations.of(context)!;
                      setState(() {
                        bool success = _controller.buyDrink(drinkId, 20);
                        if (!success && _controller.statusMessage == "NO_GOLD") {
                          _controller.statusMessage = local.innErrorNoGold;
                        }
                      });
                    },
                    // DE FIX: De meertalige statusberichten worden nu feilloos afgehandeld door de controller en correct getoond!
                    onFlirtPressed: () {
                      setState(() {
                        if (_controller.gems < 1) {
                          _controller.statusMessage = local.innFlirtNoGems;
                        } else {
                          _controller.flirtWithViolet();
                        }
                      });
                    },
                    onStartBlackjack: _onStartBlackjack,
                    onBlackjackHit: _onBlackjackHit,
                    onBlackjackStand: _onBlackjackStand,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                    onPressed: () => _changeSection("MAIN"),
                    child: Text(local.innBlackjackReturn, style: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(
        currentHp: _controller.playerHp, maxHp: _controller.playerMaxHp, goldOnHand: _controller.goldOnHand,
        gems: _controller.gems, turns: _controller.turns, level: _controller.level, experience: _controller.experience,
      ),
    );
  }
}
