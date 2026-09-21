// lib/screens/inn_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/status_bar.dart';
import '../widgets/inn_main_grid.dart';
import '../widgets/inn/inn_log_display.dart';
import '../widgets/inn/inn_panel_router.dart';
import '../theme/logd_codes.dart';
import '../services/inn_controller.dart';
import '../services/inn_event_manager.dart';
import '../services/logd_enums.dart';

class InnScreen extends StatefulWidget {
  const InnScreen({super.key});

  @override
  State<InnScreen> createState() => _InnScreenState();
}

class _InnScreenState extends State<InnScreen> {
  final InnController _controller = InnController();
  late final InnEventManager _eventManager;
  final int _wagerAmount = 50;

  String _activeSection = "MAIN";
  List<Map<String, dynamic>> _spyTargets = [];
  List<Map<String, dynamic>> _newsLogs = [];
  Map<String, String> _storyTexts = {};
  String _displayLog = "";

  @override
  void initState() {
    super.initState();
    _eventManager = InnEventManager(controller: _controller);
    _initInn();
  }

  Future<void> _initInn() async {
    await _controller.loadLiveStats();
    await _loadInnStoryAssets();
    
    // HUWELIJK LOGICA: Volledig genezen + zakgeld
    if (_controller.isMarried) {
      int pocketMoney = _controller.level * 100;
      _controller.playerHp = _controller.playerMaxHp;
      _controller.goldOnHand += pocketMoney;
      await _controller.updateCloudStats();
      _handleGenericResult("romance_married_welcome", params: {'gold': pocketMoney.toString()});
    }

    if (mounted) setState(() {});
  }

  Future<void> _loadInnStoryAssets() async {
    try {
      final String lang = Localizations.localeOf(context).languageCode;
      final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/story/$lang/locatie_herberg.json');
      final Map<String, dynamic> decoded = json.decode(jsonString);
      final bool isPoisoned = await _controller.checkForSourBeer();

      if (mounted) {
        setState(() {
          _storyTexts = decoded.map((key, value) => MapEntry(key, value.toString()));
          _displayLog = isPoisoned ? (_storyTexts['sour_beer_event'] ?? "") : (_storyTexts['welcome'] ?? "");
        });
      }
    } catch (_) {}
  }

  void _changeSection(String section) async {
    setState(() {
      _activeSection = section;
      _displayLog = _storyTexts['${section.toLowerCase()}_welcome'] ?? _storyTexts['welcome'] ?? "...";
    });
    
    if (section == "SPY") {
      final targets = await _controller.getSpyTargets();
      setState(() => _spyTargets = targets);
    } else if (section == "BOUNTY") {
      final targets = await _controller.getBountyTargets();
      setState(() => _spyTargets = targets);
    } else if (section == "NEWS") {
      final logs = await _controller.getLatestNews();
      setState(() => _newsLogs = logs);
    } else if (section == "ROMANCE") {
      String partnerKey = _controller.gender == "male" ? "violet" : "seth";
      setState(() => _displayLog = _storyTexts['romance_welcome_$partnerKey'] ?? "...");
    }
  }

  void _handleGenericResult(String key, {Map<String, String>? params}) {
    setState(() {
      String text = _storyTexts[key] ?? "...";
      if (params != null) {
        params.forEach((k, v) => text = text.replaceAll('{$k}', v));
      }
      _displayLog = text;
    });
  }

  // --- ACTIONS ---

  void _onAskRichest() async {
    if (_controller.goldOnHand < 50) {
      _handleGenericResult("error_no_gold");
      return;
    }
    final info = await _controller.getRichestPlayer();
    if (info != null) {
      _controller.goldOnHand -= 50;
      await _controller.updateCloudStats();
      _handleGenericResult("gossip_success", params: {
        'target': info['username'],
        'gold': info['gold_on_hand'].toString(),
      });
    }
  }

  void _onPlayHigherLower(bool higher) {
    _eventManager.playHigherLower(100, higher, (win, pCard, hCard) {
      _handleGenericResult(win ? "gambler_win" : "gambler_lose", params: {
        'wager': "100",
        'pCard': pCard.toString(),
        'hCard': hCard.toString(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_controller.isLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)));
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(_activeSection == "MAIN" ? local.innTitle : "=== $_activeSection ===", style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
        backgroundColor: LogdCodes.uiAppBarBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: InnLogDisplay(
                activeSection: _activeSection,
                statusMessage: _displayLog,
                newsLogs: _newsLogs,
                spyTargets: _spyTargets,
                controller: _controller,
                onSpyPressed: (target) async {
                  if (_activeSection == "BOUNTY") {
                    _eventManager.placeBounty(target['id'], 100, (key) => _handleGenericResult(key, params: {'target': target['username']}));
                  } else {
                    final info = await _controller.spyOnRival(target['id']);
                    if (info != null) {
                      _handleGenericResult("spy_result_basic", params: {
                        'target': info['username'], 'gold': info['gold_on_hand'].toString(),
                        'hp': info['hp'].toString(), 'maxHp': info['max_hp'].toString(),
                      });
                    }
                  }
                },
                onBribePressed: (target) async {
                  if (_controller.gems < 1) { _handleGenericResult("error_no_gems"); return; }
                  final info = await _controller.bribeBarman(target['id']);
                  if (info != null) {
                    _controller.gems -= 1; await _controller.updateCloudStats();
                    _handleGenericResult("spy_result_bank", params: {'target': info['username'], 'gold': info['gold_in_bank'].toString()});
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 5,
              child: _activeSection == "MAIN"
                  ? InnMainGrid(onSectionChange: _changeSection, onReturnTown: () => Navigator.pop(context))
                  : Column(
                      children: [
                        InnPanelRouter(
                          activeSection: _activeSection,
                          controller: _controller,
                          onBuyDrinkPressed: (type) => _eventManager.buyDrink(type, (key) => _handleGenericResult(key)),
                          onListenBardPressed: (gem) => _eventManager.listenToBard(gem, (key) => _handleGenericResult(key)),
                          onFlirtPressed: () => _eventManager.flirt((key, pts) => _handleGenericResult(key, params: {'points': pts.toString()})),
                          onGiveGiftPressed: () => _eventManager.giveGift((key) => _handleGenericResult(key)),
                          onProposePressed: () => _eventManager.propose((key) => _handleGenericResult(key)),
                          onTalkToVeteranPressed: () => _eventManager.talkToVeteran((key, xp, hp) => _handleGenericResult(key, params: {'xp': xp.toString()})),
                          onStartBlackjack: () => _eventManager.startBlackjack(_wagerAmount, (key) => _handleGenericResult(key)),
                          onBlackjackHit: () => _eventManager.blackjackHit(_wagerAmount, (res, score) {
                            if (res == "BUST") _handleGenericResult("blackjack_bust_log", params: {'score': score.toString()});
                          }),
                          onBlackjackStand: () => _eventManager.blackjackStand(_wagerAmount, (res, pScore, hScore) {
                            _handleGenericResult("blackjack_${res.toLowerCase()}_log", params: {'pScore': pScore.toString(), 'hScore': hScore.toString()});
                          }),
                          onPlayDice: () => _eventManager.playDice(_wagerAmount, (status, pRoll, hRoll) {
                            String key = "inn_dice_tie";
                            if (status == CombatStatus.skillMagic) key = "inn_dice_victory";
                            if (status == CombatStatus.playerDied) key = "inn_dice_defeat";
                            _handleGenericResult(key, params: {'pRoll': pRoll.toString(), 'eRoll': hRoll.toString(), 'wager': _wagerAmount.toString()});
                          }),
                          onPlayShell: () => _eventManager.playShellGame(_wagerAmount, (win) => _handleGenericResult(win ? "shell_win" : "shell_lose")),
                          onPlayHigherLower: _onPlayHigherLower,
                          onAskRichestPressed: _onAskRichest,
                        ),
                        const Spacer(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2), minimumSize: const Size.fromHeight(48)),
                          onPressed: () => _changeSection("MAIN"),
                          child: Text(local.inn_btn_leave.toUpperCase(), style: const TextStyle(color: LogdCodes.uiBlueDark, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(
        currentHp: _controller.playerHp, maxHp: _controller.playerMaxHp,
        goldOnHand: _controller.goldOnHand, gems: _controller.gems,
        turns: _controller.turns, level: _controller.level, experience: _controller.experience,
      ),
    );
  }
}
