// lib/screens/dragon_lair_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/combat_engine.dart';
import '../services/forest_manager.dart';
import '../services/logd_enums.dart';
import '../services/guest_manager.dart';

class DragonLairScreen extends StatefulWidget {
  const DragonLairScreen({super.key});

  @override
  State<DragonLairScreen> createState() => _DragonLairScreenState();
}

class _DragonLairScreenState extends State<DragonLairScreen> {
  final _supabase = Supabase.instance.client;
  final CombatEngine _engine = CombatEngine();

  int goldOnHand = 0, gems = 0, turns = 0, level = 15, experience = 0, dragonKills = 0, dragonPoints = 0;
  int playerHp = 100, playerMaxHp = 100, playerAttack = 75, playerDefense = 60;
  int _dragonHp = 1000, _dragonMaxHp = 1000;

  bool _isLoading = true;
  bool _isCombatActive = false;
  bool _isCombatOver = false;
  String _displayLog = "";
  String _charName = "Held";
  Map<String, String> _storyTexts = {};

  @override
  void initState() {
    super.initState();
    _loadLairAndPlayerData();
  }

  Future<void> _loadLairAndPlayerData() async {
    try {
      final String lang = Localizations.localeOf(context).languageCode;
      final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/story/$lang/locatie_draak.json');
      final Map<String, dynamic> decoded = json.decode(jsonString);

      Map<String, dynamic> data;
      if (GuestManager.isGuest) {
        data = GuestManager.guestProfile;
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          data = await _supabase.from('profiles').select().eq('id', user.id).single();
        } else {
          data = GuestManager.guestProfile;
        }
      }

      if (mounted) {
        setState(() {
          _charName = data['username'] ?? "Held";
          level = data['level'] ?? 15;
          experience = data['experience'] ?? 0;
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          playerHp = data['hp'] ?? 100;
          playerMaxHp = data['max_hp'] ?? 100;
          dragonKills = data['dragon_kills'] ?? 0;
          dragonPoints = data['dragon_points'] ?? 0;

          final int permAtk = data['permanent_bonus_atk'] ?? 0;
          final int permDef = data['permanent_bonus_def'] ?? 0;

          _dragonMaxHp = 1000 + (dragonKills * 250);
          _dragonHp = _dragonMaxHp;

          playerAttack = level * 5 + permAtk;
          playerDefense = level * 4 + permDef;

          _storyTexts = decoded.map((key, value) => MapEntry(key, value.toString()));
          _displayLog = _storyTexts['welcome'] ?? "";
          _isLoading = false;
        });

        if (!GuestManager.isGuest) {
          try {
            await _supabase.from('daily_news').insert({
              'log_type': 'dragon_attack',
              'username': _charName,
            });
          } catch (_) {}
        }
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleAttackRound() {
    final String bossName = _storyTexts['dragon_name'] ?? "Groene Draak";
    final currentDragonState = LogdEnemy(
      name: bossName, level: 15 + dragonKills, currentHp: _dragonHp, maxHp: _dragonMaxHp,
      attackText: "", minGold: 0, maxGold: 0,
    );

    final result = _engine.executeAttackRound(
      enemy: currentDragonState, playerAttack: playerAttack, playerDefense: playerDefense,
      playerCurrentHp: playerHp, playerMaxHp: playerMaxHp, playerLevel: level, isDragonCombat: true,
    );

    setState(() {
      _dragonHp = (_dragonHp - result.damageDealt).clamp(0, _dragonMaxHp);
      playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);

      final String baseRoundText = _storyTexts['combat_round_log'] ?? "";
      final String parsedRoundText = baseRoundText.replaceAll('{player_dmg}', result.damageDealt.toString());

      String dragonAtkText = "";
      if (result.isDragonFlame) {
        dragonAtkText = (_storyTexts['dragon_vlammenzee_atk'] ?? "").replaceAll('{damage}', result.damageReceived.toString());
      } else {
        dragonAtkText = _storyTexts['dragon_fysiek_atk'] ?? "";
      }

      _displayLog = "$parsedRoundText\n\n$dragonAtkText";

      if (result.isCombatOver) {
        _isCombatActive = false;
        _isCombatOver = true;
        _finalizeDragonLairCombat(result.status == CombatStatus.enemyDefeated);
      }
    });
  }

  void _finalizeDragonLairCombat(bool playerWon) async {
    final local = AppLocalizations.of(context)!;

    if (playerWon) {
      if (GuestManager.isGuest) {
        GuestManager.guestProfile['level'] = 1;
        GuestManager.guestProfile['experience'] = 0;
        GuestManager.guestProfile['gold_on_hand'] = 0;
        GuestManager.guestProfile['weapon_level'] = 0;
        GuestManager.guestProfile['armor_level'] = 0;
        GuestManager.guestProfile['hp'] = playerMaxHp;
        GuestManager.guestProfile['dragon_kills'] = dragonKills + 1;
        GuestManager.guestProfile['dragon_points'] = dragonPoints + 1;
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          await _supabase.from('profiles').update({
            'level': 1, 'experience': 0, 'gold_on_hand': 0, 'weapon_level': 0, 'armor_level': 0,
            'hp': playerMaxHp, 'dragon_kills': dragonKills + 1, 'dragon_points': dragonPoints + 1,
          }).eq('id', user.id);

          final String killCountStr = (dragonKills + 1).toString();
          final String announcement = local.news_dragon_kill(_charName, killCountStr);

          try {
            await _supabase.from('daily_news').insert({
              'log_type': 'dragon_kill',
              'username': _charName,
              'kills': dragonKills + 1,
              'log_text': announcement,
            });
          } catch (_) {}
        }
      }

      setState(() { _displayLog = _storyTexts['victory_text'] ?? ""; });
    } else {
      final int reducedXp = (experience * 0.9).toInt();
      if (GuestManager.isGuest) {
        GuestManager.guestProfile['alive'] = false;
        GuestManager.guestProfile['gold_on_hand'] = 0;
        GuestManager.guestProfile['hp'] = 0;
        GuestManager.guestProfile['experience'] = reducedXp;
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          await _supabase.from('profiles').update({
            'alive': false, 'gold_on_hand': 0, 'hp': 0, 'experience': reducedXp,
          }).eq('id', user.id);

          try {
            await _supabase.from('daily_news').insert({
              'log_type': 'dragon_defeat',
              'username': _charName,
            });
          } catch (_) {}
        }
      }

      setState(() { _displayLog = _storyTexts['defeat_text'] ?? ""; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)));
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        appBar: AppBar(
          title: Text(local.dragon_lair_title.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, color: Colors.redAccent, fontSize: LogdCodes.fontSizeCardTitle, fontWeight: FontWeight.bold)),
          backgroundColor: LogdCodes.uiAppBarBg, automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (_isCombatActive || _isCombatOver) ...[
              LogdText(text: "${(_storyTexts['dragon_name'] ?? "Groene Draak").toUpperCase()} HP: $_dragonHp / $_dragonMaxHp", fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 6),
            ],
            Expanded(child: SingleChildScrollView(child: LogdText(text: _displayLog, fontSize: LogdCodes.fontSizeDefault))),
            const SizedBox(height: 12),
            if (!_isCombatActive && !_isCombatOver) ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent, width: 2), backgroundColor: LogdCodes.uiDragonRedBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () => setState(() { _isCombatActive = true; _handleAttackRound(); }),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btn_attack_dragon.toUpperCase(), style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2), backgroundColor: LogdCodes.uiBlueBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))).copyWith(foregroundColor: WidgetStateProperty.all<Color>(LogdCodes.uiBlueDark)),
                onPressed: () => Navigator.pop(context),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btn_sneak_away.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
              ),
            ],
            if (_isCombatActive && !_isCombatOver) ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent, width: 2), backgroundColor: LogdCodes.uiDragonRedBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: _handleAttackRound,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnAttack.toUpperCase(), style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
              ),
            ],
            if (_isCombatOver) ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2), backgroundColor: LogdCodes.uiBlueBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))).copyWith(foregroundColor: WidgetStateProperty.all<Color>(LogdCodes.uiBlueDark)),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btn_dragon_continue.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
              ),
            ]
          ]),
        ),
        bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
      ),
    );
  }
}
