import 'package:flutter/material.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';

class ChurchScreen extends StatefulWidget {
  const ChurchScreen({super.key});

  @override
  State<ChurchScreen> createState() => _ChurchScreenState();
}

class _ChurchScreenState extends State<ChurchScreen> {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  bool prayedThisTurn = false;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadChurchData();
  }

  Future<void> _loadChurchData() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          prayedThisTurn = data['prayed_this_turn'] ?? false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pray() async {
    final local = AppLocalizations.of(context)!;
    if (prayedThisTurn) {
      setState(() { _statusMessage = local.churchAlreadyPrayed; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    // Kansberekening (0 = Zegen, 1 = Neutraal, 2 = Vloek)
    int outcome = _random.nextInt(3);
    String msg = "";

    if (outcome == 0) {
      // --- ZEGENINGEN (Blessings) ---
      int subOutcome = _random.nextInt(3);
      if (subOutcome == 0) {
        int goldGained = level * 150 + 100;
        goldOnHand += goldGained;
        msg = local.churchBlessGold(goldGained.toString());
      } else if (subOutcome == 1) {
        gems += 1;
        msg = local.churchBlessGems("1");
      } else {
        playerHp = playerMaxHp;
        msg = local.churchBlessHeal;
      }
    } else if (outcome == 1) {
      // --- NEUTRAAL ---
      msg = local.churchNeutral;
    } else {
      // --- VLOEKEN (Curses) ---
      int subOutcome = _random.nextInt(2);
      if (subOutcome == 0) {
        int hpLost = (playerHp * 0.3).round().clamp(1, 15);
        playerHp = (playerHp - hpLost).clamp(1, playerMaxHp); // Goden doden je niet direct, laten je op minimaal 1 HP achter
        msg = local.churchCurseHp(hpLost.toString());
      } else {
        int goldLost = (goldOnHand * 0.2).round().clamp(0, 500);
        goldOnHand = (goldOnHand - goldLost).clamp(0, double.maxFinite).toInt();
        msg = local.churchCurseGold(goldLost.toString());
      }
    }

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        await _supabase.from('profiles').update({
          'gold_on_hand': goldOnHand,
          'gems': gems,
          'hp': playerHp,
          'prayed_this_turn': true, // Vergrendel het gebed
        }).eq('id', user.id);

        setState(() {
          prayedThisTurn = true;
          _statusMessage = msg;
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
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: LogdCodes.uiYellow)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(local.churchTitle, style: const TextStyle(fontFamily: 'Courier')),
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
                    LogdText(text: local.churchWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Divider(color: Colors.grey)),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),

            if (!prayedThisTurn) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: LogdCodes.uiYellow, width: 2),
                    backgroundColor: const Color(0xFF1E1E00),
                  ),
                  onPressed: _pray,
                  child: Text(local.btnChurchPray.toUpperCase(), style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 15)),
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
