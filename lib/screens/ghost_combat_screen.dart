// lib/screens/ghost_combat_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../theme/logd_codes.dart';
import '../services/combat_engine.dart';
import '../services/forest_manager.dart';
import '../services/logd_enums.dart';
import '../services/graveyard_controller.dart';

class GhostCombatScreen extends StatefulWidget {
  final int playerLevel;
  final int currentHp;
  final int maxHp;

  const GhostCombatScreen({
    super.key,
    required this.playerLevel,
    required this.currentHp,
    required this.maxHp,
  });

  @override
  State<GhostCombatScreen> createState() => _GhostCombatScreenState();
}

class _GhostCombatScreenState extends State<GhostCombatScreen> {
  final CombatEngine _engine = CombatEngine();
  final GraveyardController _graveyardController = GraveyardController();

  late int _ghostHp;
  late int _ghostMaxHp;
  late LogdEnemy _activeEnemy;
  late int _enemyHp;

  bool _isLoading = true;
  bool _isCombatOver = false;
  String _combatLog = "";
  Map<String, String> _storyTexts = {};
  GhostEventType _activeEvent = GhostEventType.none;

  @override
  void initState() {
    super.initState();
    _ghostHp = widget.currentHp <= 0 ? widget.maxHp : widget.currentHp;
    _ghostMaxHp = widget.maxHp;
    
    _activeEnemy = LogdEnemy(
      name: "...",
      level: widget.playerLevel,
      currentHp: 1,
      maxHp: 1,
      attackText: "...",
      minGold: 0,
      maxGold: 0,
    );
    _enemyHp = _activeEnemy.currentHp;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadGhostCombatData();
      }
    });
  }

  Future<void> _loadGhostCombatData() async {
    try {
      if (!mounted) return;
      
      String lang = Localizations.localeOf(context).languageCode;
      if (lang != 'nl' && lang != 'en') lang = 'en';

      final String monstersPath = 'assets/story/$lang/monsters_begraafplaats.json';
      final String locationPath = 'assets/story/$lang/locatie_begraafplaats.json';

      final bundle = DefaultAssetBundle.of(context);
      final String monstersJson = await bundle.loadString(monstersPath);
      final String locationJson = await bundle.loadString(locationPath);

      final Map<String, dynamic> monstersDecoded = json.decode(monstersJson);
      final Map<String, dynamic> locationDecoded = json.decode(locationJson);

      if (mounted) {
        setState(() {
          _storyTexts = monstersDecoded.map((key, value) => MapEntry(key, value.toString()));
          _storyTexts.addAll(locationDecoded.map((key, value) => MapEntry(key, value.toString())));
          
          final int roll = (DateTime.now().millisecondsSinceEpoch % 100);
          if (roll < 20) {
            _activeEvent = (roll < 10) ? GhostEventType.styx : GhostEventType.whispers;
            _combatLog = (_activeEvent == GhostEventType.styx) 
                ? (_storyTexts['event_styx_text'] ?? "") 
                : (_storyTexts['event_whispers_text'] ?? "");
          } else {
            _setupGhostEnemy(enemyLevel: widget.playerLevel.clamp(1, 15));
          }
          
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Fout bij laden van JSON data: $e");
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _setupGhostEnemy({required int enemyLevel}) {
    final String fallback = _storyTexts['enemy_fallback_name'] ?? "Schim";
    final String name = _storyTexts['enemy_name_$enemyLevel'] ?? fallback;
    final String desc = _storyTexts['enemy_desc_$enemyLevel'] ?? "";
    final String atk = _storyTexts['enemy_atk_$enemyLevel'] ?? "valt aan";

    _enemyHp = enemyLevel * 25;

    _activeEnemy = LogdEnemy(
      name: name,
      level: enemyLevel,
      currentHp: _enemyHp,
      maxHp: enemyLevel * 25,
      attackText: atk,
      minGold: 0,
      maxGold: 0,
    );

    _combatLog = "$desc\n\n`4${_activeEnemy.name} (Level ${_activeEnemy.level})`w";
  }

  Future<void> _handleStyxChoice(bool onboard) async {
    if (!onboard) {
      setState(() {
        _isCombatOver = true;
        _combatLog += "\n\n${_storyTexts['event_styx_leave'] ?? ""}";
      });
      return;
    }

    final favorGained = await _graveyardController.handleStyxEvent(widget.playerLevel);
    setState(() {
      _isCombatOver = true;
      final String template = _storyTexts['event_styx_outcome'] ?? "";
      _combatLog += "\n\n${template.replaceAll('{favor}', favorGained.toString())}";
    });
  }

  Future<void> _handleWhispersChoice(bool listen) async {
    if (!listen) {
      setState(() {
        _isCombatOver = true;
        _combatLog += "\n\n${_storyTexts['event_whispers_leave'] ?? ""}";
      });
      return;
    }

    final target = await _graveyardController.handleWhispersEvent();
    setState(() {
      _isCombatOver = true;
      if (target != null) {
        final String template = _storyTexts['event_whispers_outcome'] ?? "";
        final String infoTemplate = _storyTexts['event_whispers_secret'] ?? "";
        final String info = "\n\n${infoTemplate.replaceAll('{user}', target['username']).replaceAll('{gold}', target['gold_in_bank'].toString())}";
        _combatLog += "\n\n$template$info";
      } else {
        _combatLog += "\n\n${_storyTexts['event_whispers_empty'] ?? ""}";
      }
    });
  }

  Future<void> _handleAttack() async {
    final int playerAttack = widget.playerLevel * 5;
    final int playerDefense = widget.playerLevel * 3;

    final result = _engine.executeAttackRound(
      enemy: _activeEnemy.copyWith(currentHp: _enemyHp),
      playerAttack: playerAttack,
      playerDefense: playerDefense,
      playerCurrentHp: _ghostHp,
      playerMaxHp: _ghostMaxHp,
      playerLevel: widget.playerLevel,
      isGhostCombat: true,
    );

    setState(() {
      _ghostHp = (_ghostHp - result.damageReceived).clamp(0, _ghostMaxHp);
      _enemyHp = (_enemyHp - result.damageDealt).clamp(0, _activeEnemy.maxHp);

      final String logTemplate = _storyTexts['combat_round_log'] ?? "";
      _combatLog = logTemplate
          .replaceAll('{player_dmg}', result.damageDealt.toString())
          .replaceAll('{enemy_atk_text}', _activeEnemy.attackText)
          .replaceAll('{enemy_dmg}', result.damageReceived.toString());

      if (result.isCombatOver) {
        _isCombatOver = true;
        _finalizeCombat(result);
      }
    });
  }

  void _finalizeCombat(CombatResult result) async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    if (result.status == CombatStatus.enemyDefeated) {
      final profile = await Supabase.instance.client.from('profiles').select('favor').eq('id', user.id).single();
      final int currentFavor = profile['favor'] ?? 0;
      final int newFavor = currentFavor + result.favorEarned;

      await Supabase.instance.client.from('profiles').update({
        'favor': newFavor,
        'hp': _ghostHp,
      }).eq('id', user.id);

      setState(() {
        final String template = _storyTexts['combat_victory'] ?? "";
        _combatLog += template.replaceAll('{favor}', result.favorEarned.toString());
      });
    } else {
      final userRef = Supabase.instance.client;
      // Haal eerst de beurten op om te kunnen decrementeren
      final profileRes = await userRef.from('profiles').select('turns').eq('id', user.id).single();
      final int currentTurns = profileRes['turns'] ?? 0;
      
      await userRef.from('profiles').update({
        'hp': 0,
        'turns': (currentTurns - 2).clamp(0, 100),
      }).eq('id', user.id);

      setState(() {
        _combatLog += _storyTexts['combat_defeat'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(local.ghost_combat_title, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: Colors.redAccent)),
        backgroundColor: LogdCodes.uiAppBarBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ARB LAYOUT FIX: Toon monster info alleen als we echt vechten (en niet bij een Event!)
            if (_activeEvent == GhostEventType.none) ...[
              LogdText(text: local.ghost_combat_monster_label(_activeEnemy.level.toString(), _activeEnemy.name), fontSize: LogdCodes.fontSizeDefault),
              LogdText(text: local.ghost_combat_hp_label(_enemyHp.toString(), _activeEnemy.maxHp.toString()), fontSize: LogdCodes.fontSizeDefault),
              const Divider(color: Colors.grey),
            ],
            Expanded(
              child: SingleChildScrollView(
                child: LogdText(text: _combatLog, fontSize: LogdCodes.fontSizeDefault),
              ),
            ),
            const Divider(color: Colors.grey),
            if (!_isCombatOver) ...[
              if (_activeEvent == GhostEventType.none)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent, width: 2)),
                  onPressed: _handleAttack,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.ghost_combat_btn_attack)),
                )
              else if (_activeEvent == GhostEventType.styx) ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.cyan, width: 2)),
                  onPressed: () => _handleStyxChoice(true),
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnStyxOnboard.toUpperCase())),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2)),
                  onPressed: () => _handleStyxChoice(false),
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnStyxStay.toUpperCase())),
                ),
              ] else if (_activeEvent == GhostEventType.whispers) ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.amber, width: 2)),
                  onPressed: () => _handleWhispersChoice(true),
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnWhispersListen.toUpperCase())),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2)),
                  onPressed: () => _handleWhispersChoice(false),
                  child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnWhispersLeave.toUpperCase())),
                ),
              ],
            ] else ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2)),
                onPressed: () => Navigator.pop(context),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.ghost_combat_btn_return)),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
