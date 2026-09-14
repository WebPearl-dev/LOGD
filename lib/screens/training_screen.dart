import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final _supabase = Supabase.instance.client;

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  String username = "";

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadTrainingData();
  }

  Future<void> _loadTrainingData() async {
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
          _isLoading = false;
        });
      }
    }
  }

  int _getXpRequiredForNextLevel() {
    return level * level * 100;
  }

  Future<void> _challengeMaster() async {
    final local = AppLocalizations.of(context)!;
    int xpNeeded = _getXpRequiredForNextLevel();

    if (experience < xpNeeded) {
      setState(() {
        _statusMessage = local.trainingErrorNoXp;
      });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        int newLevel = level + 1;
        int newMaxHp = playerMaxHp + 10;

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
    } catch (_) {
      setState(() { _statusMessage = local.smithyErrorUnknown; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: LogdCodes.uiRed)));
    }

    int xpNeeded = _getXpRequiredForNextLevel();
    bool canUpgrade = experience >= xpNeeded;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(local.btnVisitTraining, style: const TextStyle(fontFamily: 'Courier')),
        backgroundColor: const Color(0xFF2D2D2D),
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
                    LogdText(text: local.trainingWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Divider(color: Colors.grey)),

                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 14),
                    ],

                    LogdText(text: "=== STATUS ===", fontSize: LogdCodes.fontSizeCardTitle),
                    const SizedBox(height: 6),
                    LogdText(text: "Huidig Niveau: `yLevel $level`w", fontSize: LogdCodes.fontSizeDefault),
                    LogdText(text: "Ervaring (XP): `c$experience / $xpNeeded`w", fontSize: LogdCodes.fontSizeDefault),
                  ],
                ),
              ),
            ),

            if (canUpgrade) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: LogdCodes.uiRed, width: 2),
                    backgroundColor: const Color(0xFF240D0D),
                  ),
                  onPressed: _challengeMaster,
                  child: Text(local.btnChallengeMaster.toUpperCase(), style: const TextStyle(color: LogdCodes.uiRed, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 10),
            ],

            OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue, width: 2)),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
