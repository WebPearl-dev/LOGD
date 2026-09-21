// lib/screens/graveyard_screen.dart
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/graveyard_controller.dart';
import 'ghost_combat_screen.dart';

class GraveyardScreen extends StatefulWidget {
  const GraveyardScreen({super.key});

  @override
  State<GraveyardScreen> createState() => _GraveyardScreenState();
}

class _GraveyardScreenState extends State<GraveyardScreen>
    with WidgetsBindingObserver {
  final GraveyardController _controller = GraveyardController();
  final _random = Random();

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0, favor = 0;
  int playerHp = 0, playerMaxHp = 20;
  bool _isLoading = true;
  bool _isInCombat = false;
  String _statusMessage = "";
  Map<String, String> _storyTexts = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadGraveyardData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused && _isInCombat) {
      _controller.punishCombatDisconnect();
    }
  }

  Future<void> _loadGraveyardData() async {
    final user = _controller.supabase.auth.currentUser;
    if (user != null) {
      try {
        final data = await _controller.supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        final int currentHp = data['hp'] ?? 0;
        final bool currentAlive = data['alive'] ?? true;

        if (currentHp <= 0 && currentAlive) {
          await _controller.killPlayer();
          _loadGraveyardData();
          return;
        }

        if (!mounted) return;
        final String lang = Localizations.localeOf(context).languageCode;
        final String jsonString = await DefaultAssetBundle.of(
          context,
        ).loadString('assets/story/$lang/locatie_begraafplaats.json');
        final Map<String, dynamic> decoded = json.decode(jsonString);

        if (mounted) {
          setState(() {
            goldOnHand = data['gold_on_hand'] ?? 0;
            gems = data['gems'] ?? 0;
            turns = data['turns'] ?? 0;
            level = data['level'] ?? 1;
            experience = data['experience'] ?? 0;
            playerHp = currentHp;
            playerMaxHp = data['max_hp'] ?? 20;
            favor = data['favor'] ?? 0;
            _storyTexts = decoded.map(
              (key, value) => MapEntry(key, value.toString()),
            );
            _statusMessage = _storyTexts['graveyard_intro'] ?? "";
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleResurrection() async {
    setState(() => _isLoading = true);
    final bool success = await _controller.tryResurrect(
      playerLevel: level,
      currentFavor: favor,
    );
    if (success) {
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _statusMessage = _storyTexts['ramius_resurrect_fail'] ?? "";
        _isLoading = false;
      });
    }
  }

  Future<void> _handleHaunting() async {
    if (turns < 1) {
      setState(() => _statusMessage = _storyTexts['error_no_turns'] ?? "");
      return;
    }
    final local = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    // DE CORE FIX: Luistert nu 100% zuiver naar jouw eigen database methode hauntRandomPlayer!
    final targetPlayer = await _controller.hauntRandomPlayer();

    setState(() {
      _isLoading = false;
      if (targetPlayer != null) {
        turns--;
        final String template = _storyTexts['haunt_success'] ?? "";
        _statusMessage = template.replaceAll(
          '{username}',
          targetPlayer['username'] ?? local.newsUnknownPlayer,
        );
      } else {
        _statusMessage = _storyTexts['haunt_no_players'] ?? "";
      }
    });
  }

  void _talkToRamius() {
    final int quoteNumber = _random.nextInt(15) + 1;
    setState(() {
      _statusMessage = _storyTexts['ramius_quote_$quoteNumber'] ?? "";
    });
  }

  Future<void> _handleGraveRobbing() async {
    setState(() => _isLoading = true);
    final result = await _controller.robGrave();
    
    setState(() {
      _isLoading = false;
      if (result['type'] == 'gold') {
        _statusMessage = _storyTexts['rob_success_gold']?.replaceAll('{gold}', result['amount'].toString()) ?? "";
      } else if (result['type'] == 'gem') {
        _statusMessage = _storyTexts['rob_success_gem']?.replaceAll('{gems}', result['amount'].toString()) ?? "";
      } else if (result['type'] == 'zombie') {
        _statusMessage = _storyTexts['rob_zombie_encounter']?.replaceAll('{hp}', result['amount'].toString()) ?? "";
        playerHp = (playerHp - (result['amount'] as int)).clamp(0, playerMaxHp);
      } else {
        _statusMessage = _storyTexts['rob_empty'] ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: LogdCodes.uiGreen),
        ),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        appBar: AppBar(
          title: Text(
            local.graveyard_title.toUpperCase(),
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              color: Colors.redAccent,
              fontSize: LogdCodes.fontSizeCardTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: LogdCodes.uiAppBarBg,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      LogdText(
                        text: local.graveyard_status_dead,
                        fontSize: LogdCodes.fontSizeDefault,
                      ),
                      LogdText(
                        text: local.graveyard_favor_points(favor.toString()),
                        fontSize: LogdCodes.fontSizeDefault,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(color: Colors.grey),
                      ),
                      if (_statusMessage.isNotEmpty) ...[
                        LogdText(
                          text: _statusMessage,
                          fontSize: LogdCodes.fontSizeDefault,
                        ),
                        const SizedBox(height: 14),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent, width: 2),
                  backgroundColor: const Color(0xFF1A0505),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  setState(() => _isInCombat = true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GhostCombatScreen(
                        playerLevel: level,
                        currentHp: playerHp,
                        maxHp: playerMaxHp,
                      ),
                    ),
                  ).then((_) {
                    if (mounted) {
                      setState(() => _isInCombat = false);
                      _loadGraveyardData();
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    local.graveyard_btn_fight.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.amber, width: 2),
                  backgroundColor: LogdCodes.uiBlueBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: _handleGraveRobbing,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    local.btnGraveyardRob.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style:
                    OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.cyan, width: 2),
                      backgroundColor: LogdCodes.uiBlueBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ).copyWith(
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.cyanAccent,
                      ),
                    ),
                onPressed: _handleResurrection,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    local.graveyard_btn_resurrect.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style:
                    OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple, width: 2),
                      backgroundColor: LogdCodes.uiBlueBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ).copyWith(
                      foregroundColor: WidgetStateProperty.all<Color>(
                        Colors.purpleAccent,
                      ),
                    ),
                onPressed: _handleHaunting,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    local.graveyard_btn_haunt.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                style:
                    OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: LogdCodes.uiBlueDark,
                        width: 2,
                      ),
                      backgroundColor: LogdCodes.uiBlueBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ).copyWith(
                      foregroundColor: WidgetStateProperty.all<Color>(
                        LogdCodes.uiBlueDark,
                      ),
                    ),
                onPressed: _talkToRamius,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    local.graveyard_btn_talk.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: LogdCodes.retroFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        bottomNavigationBar: LogdStatusBar(
          currentHp: playerHp,
          maxHp: playerMaxHp,
          goldOnHand: goldOnHand,
          gems: gems,
          turns: turns,
          level: level,
          experience: experience,
        ),
      ),
    );
  }
}
