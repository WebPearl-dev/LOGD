// lib/screens/church_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
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
  bool confessedThisTurn = false;
  bool litCandleThisTurn = false;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadChurchData();
    });
  }

  Future<void> _loadChurchData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
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
          confessedThisTurn = data['confessed_this_turn'] ?? false;
          litCandleThisTurn = data['lit_candle_this_turn'] ?? false;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pray() async {
    final local = AppLocalizations.of(context)!;
    if (prayedThisTurn) {
      setState(() => _statusMessage = local.churchAlreadyPrayed);
      return;
    }

    setState(() {
      _isLoading = true;
      _statusMessage = "";
    });

    int outcome = _random.nextInt(3);
    String msg = "";

    if (outcome == 0) {
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
      msg = local.churchNeutral;
    } else {
      int subOutcome = _random.nextInt(2);
      if (subOutcome == 0) {
        int hpLost = (playerHp * 0.3).round().clamp(1, 15);
        playerHp = (playerHp - hpLost).clamp(1, playerMaxHp);
        msg = local.churchCurseHp(hpLost.toString());
      } else {
        int goldLost = (goldOnHand * 0.2).round().clamp(0, 500);
        goldOnHand = (goldOnHand - goldLost).clamp(0, 999999).toInt();
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
          'prayed_this_turn': true,
        }).eq('id', user.id);

        setState(() {
          prayedThisTurn = true;
          _statusMessage = msg;
        });
      }
    } catch (_) {
      setState(() => _statusMessage = local.smithyErrorUnknown);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confess() async {
    final local = AppLocalizations.of(context)!;
    if (confessedThisTurn) {
      setState(() => _statusMessage = local.churchAlreadyConfessed);
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    int xpGained = level * 5;
    experience += xpGained;

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        await _supabase.from('profiles').update({
          'experience': experience,
          'confessed_this_turn': true,
        }).eq('id', user.id);

        setState(() {
          confessedThisTurn = true;
          _statusMessage = local.churchConfessResult(xpGained.toString());
        });
      }
    } catch (e) {
      debugPrint("Confess Error: $e");
      setState(() => _statusMessage = local.smithyErrorUnknown);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _lightCandle() async {
    final local = AppLocalizations.of(context)!;
    if (litCandleThisTurn) {
      setState(() => _statusMessage = local.churchAlreadyLitCandle);
      return;
    }

    if (gems < 1) {
      setState(() => _statusMessage = local.errorNoGems);
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    int favorGained = level * 2 + 5;
    gems -= 1;

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final profile = await _supabase.from('profiles').select('favor').eq('id', user.id).single();
        int currentFavor = profile['favor'] ?? 0;

        await _supabase.from('profiles').update({
          'gems': gems,
          'favor': currentFavor + favorGained,
          'lit_candle_this_turn': true,
        }).eq('id', user.id);

        setState(() {
          litCandleThisTurn = true;
          _statusMessage = local.churchCandleResult(favorGained.toString());
        });
      }
    } catch (e) {
      debugPrint("Light Candle Error: $e");
      setState(() => _statusMessage = local.smithyErrorUnknown);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        body: Center(child: CircularProgressIndicator(color: LogdCodes.uiYellow)),
      );
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(local.churchTitle.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeCardTitle, fontWeight: FontWeight.bold)),
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
            
            if (!prayedThisTurn)
              _buildChurchButton(local.btnChurchPray, _pray, LogdCodes.uiYellow),
            
            const SizedBox(height: 8),

            if (!confessedThisTurn)
              _buildChurchButton(local.btnChurchConfess, _confess, Colors.white70),

            const SizedBox(height: 8),

            if (!litCandleThisTurn)
              _buildChurchButton(local.btnChurchCandle, _lightCandle, Colors.cyanAccent),

            const SizedBox(height: 16),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
                backgroundColor: LogdCodes.uiBlueBg,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: LogdCodes.uiBlueDark, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }

  Widget _buildChurchButton(String label, VoidCallback onPressed, Color color) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          backgroundColor: color.withAlpha(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        onPressed: onPressed,
        child: Text(label.toUpperCase(), style: TextStyle(color: color, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault)),
      ),
    );
  }
}
