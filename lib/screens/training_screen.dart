// lib/screens/training_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../services/story_service.dart';
import '../theme/logd_codes.dart';
import '../services/combat_engine.dart';
import '../services/forest_manager.dart';
import '../services/logd_enums.dart';
import '../services/guest_manager.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final _supabase = Supabase.instance.client;
  final _combatEngine = CombatEngine();
  Map<String, dynamic> _storyContent = {};

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  int permanentBonusAtk = 0, permanentBonusDef = 0;
  String username = "";

  bool _isLoading = true;
  bool _isInCombat = false;
  String _statusMessage = "";
  String _combatLog = "";
  
  LogdEnemy? _currentMaster;
  int _masterHp = 0;

  @override
  void initState() {
    super.initState();
    _loadTrainingData();
    _loadStoryContent();
  }

  Future<void> _loadStoryContent() async {
    final content = await StoryService.loadLocationContent(context, 'locatie_training');
    if (mounted) {
      setState(() {
        _storyContent = content;
      });
    }
  }

  Future<void> _loadTrainingData() async {
    if (GuestManager.isGuest) {
      final data = GuestManager.guestProfile;
      if (mounted) {
        setState(() {
          username = data['username'] ?? "Gast Reiziger";
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          permanentBonusAtk = data['permanent_bonus_atk'] ?? 0;
          permanentBonusDef = data['permanent_bonus_def'] ?? 0;
          _isLoading = false;
        });
      }
      return;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          username = data['username'] ?? user.email ?? "Reiziger";
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          permanentBonusAtk = data['permanent_bonus_atk'] ?? 0;
          permanentBonusDef = data['permanent_bonus_def'] ?? 0;
          _isLoading = false;
        });
      }
    }
  }

  int _getXpRequiredForNextLevel() {
    return level * level * 100;
  }

  String _getMasterName(AppLocalizations local) {
    if (level < 4) return local.master0;
    if (level < 8) return local.master1;
    if (level < 12) return local.master2;
    return local.master3;
  }

  void _startDuel() {
    final local = AppLocalizations.of(context)!;
    final String mName = _getMasterName(local);
    
    setState(() {
      _isInCombat = true;
      _combatLog = "";
      _statusMessage = "";
      
      _masterHp = level * 20 + 10;
      _currentMaster = LogdEnemy(
        name: mName,
        level: level + 1,
        maxHp: _masterHp,
        currentHp: _masterHp,
        attackText: local.trainingMasterAttack,
        minGold: 0,
        maxGold: 0,
      );
    });
  }

  void _onAttackPressed() {
    if (_currentMaster == null || !_isInCombat) return;

    final local = AppLocalizations.of(context)!;
    
    final int pAtk = level * 6 + 5 + permanentBonusAtk;
    final int pDef = level * 4 + 3 + permanentBonusDef;

    final result = _combatEngine.executeAttackRound(
      enemy: _currentMaster!.copyWith(currentHp: _masterHp),
      playerAttack: pAtk,
      playerDefense: pDef,
      playerCurrentHp: playerHp,
      playerMaxHp: playerMaxHp,
      playerLevel: level,
    );

    setState(() {
      _masterHp = (_masterHp - result.damageDealt).clamp(0, 9999);
      playerHp = (playerHp - result.damageReceived).clamp(0, playerMaxHp);

      String roundLog = local.trainingPlayerAttackLog(result.damageDealt.toString()) +
                        local.trainingMasterAttackLog(
                          result.args['attack_text'] ?? local.trainingMasterAttack,
                          result.damageReceived.toString(),
                          _currentMaster!.name,
                        );
      
      _combatLog = "$roundLog\n\n$_combatLog";

      if (result.status == CombatStatus.enemyDefeated) {
        _isInCombat = false;
        _finalizeLevelUp();
      } else if (playerHp <= 1) {
        playerHp = 1;
        _isInCombat = false;
        _statusMessage = local.trainingDefeat;
        _updateHpInCloud();
      }
    });
  }

  Future<void> _updateHpInCloud() async {
    if (GuestManager.isGuest) {
      GuestManager.guestProfile['hp'] = playerHp;
      return;
    }
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({'hp': playerHp}).eq('id', user.id);
    }
  }

  Future<void> _finalizeLevelUp() async {
    final local = AppLocalizations.of(context)!;
    int newLevel = level + 1;
    int newMaxHp = playerMaxHp + 10;

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['level'] = newLevel;
      GuestManager.guestProfile['max_hp'] = newMaxHp;
      GuestManager.guestProfile['hp'] = newMaxHp;
      setState(() {
        level = newLevel;
        playerMaxHp = newMaxHp;
        playerHp = newMaxHp;
        _statusMessage = local.trainingSuccessLevelUp(newLevel.toString());
      });
      return;
    }

    final user = _supabase.auth.currentUser;
    if (user == null) return;

    await _supabase.from('profiles').update({
      'level': newLevel,
      'max_hp': newMaxHp,
      'hp': newMaxHp,
    }).eq('id', user.id);

    try {
      await _supabase.from('daily_news').insert({
        'username': username,
        'log_type': 'level_up',
        'reached_level': newLevel,
      });
    } catch (_) {}

    setState(() {
      level = newLevel;
      playerMaxHp = newMaxHp;
      playerHp = newMaxHp;
      _statusMessage = local.trainingSuccessLevelUp(newLevel.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: LogdCodes.uiRed)));
    }

    int xpNeeded = _getXpRequiredForNextLevel();
    bool canChallenge = experience >= xpNeeded && !_isInCombat && _statusMessage.isEmpty;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
            local.btnVisitTraining.toUpperCase(),
            style: const TextStyle(
                fontFamily: LogdCodes.retroFont,
                fontSize: LogdCodes.fontSizeDefault,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_isInCombat) ...[
                      LogdText(text: _storyContent['welcome'] ?? "Je stapt de serene trainingsruimte binnen...", fontSize: LogdCodes.fontSizeDefault),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Divider(color: Colors.grey)),
                    ],

                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 14),
                    ],

                    if (_isInCombat && _currentMaster != null) ...[
                      LogdText(text: local.trainingDuelTitle(_currentMaster!.name.toUpperCase()), fontSize: LogdCodes.fontSizeCardTitle),
                      const SizedBox(height: 8),
                      LogdText(text: local.trainingMasterHp(_masterHp.toString(), _currentMaster!.maxHp.toString()), fontSize: LogdCodes.fontSizeDefault),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      LogdText(text: _combatLog, fontSize: LogdCodes.fontSizeDefault),
                    ] else if (_statusMessage.isEmpty) ...[
                      LogdText(text: local.trainingStatusTitle, fontSize: LogdCodes.fontSizeCardTitle),
                      const SizedBox(height: 6),
                      LogdText(text: local.trainingCurrentLevel(level.toString()), fontSize: LogdCodes.fontSizeDefault),
                      LogdText(text: local.trainingXpLabel(experience.toString(), xpNeeded.toString()), fontSize: LogdCodes.fontSizeDefault),
                    ],
                  ],
                ),
              ),
            ),

            if (canChallenge) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: LogdCodes.uiRed, width: 2),
                    backgroundColor: LogdCodes.uiRedBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ),
                  onPressed: _startDuel,
                  child: Text(local.btnChallengeMaster.toUpperCase(), style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault)),
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (_isInCombat) ...[
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green, width: 2),
                    backgroundColor: LogdCodes.uiGreenBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ),
                  onPressed: _onAttackPressed,
                  child: Text(local.btnAttack.toUpperCase(), style: const TextStyle(color: Colors.greenAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (!_isInCombat)
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
                  backgroundColor: LogdCodes.uiBlueBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: LogdCodes.uiBlueDark, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
