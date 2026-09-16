// lib/screens/graveyard_screen.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';

class GraveyardScreen extends StatefulWidget {
  const GraveyardScreen({super.key});

  @override
  State<GraveyardScreen> createState() => _GraveyardScreenState();
}

class _GraveyardScreenState extends State<GraveyardScreen> {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 0, playerMaxHp = 20;

  bool _isLoading = true;
  bool _hasAcceptedFate = false;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadGraveyardData();
  }

  Future<void> _loadGraveyardData() async {
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
          playerHp = data['hp'] ?? 0;
          playerMaxHp = data['max_hp'] ?? 20;

          _hasAcceptedFate = (playerHp <= 0);
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateCloudStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'gems': gems,
        'hp': playerHp,
        'alive': playerHp > 0,
      }).eq('id', user.id);
    }
  }

  Future<void> _robGrave() async {
    final local = AppLocalizations.of(context)!;
    setState(() { _isLoading = true; _statusMessage = ""; });

    int roll = _random.nextInt(100);
    String msg = "";

    if (roll < 35) {
      int goldGained = (level * 40) + _random.nextInt(30);
      goldOnHand += goldGained;
      msg = local.graveyardSuccessGold(goldGained.toString());
    } else if (roll < 45) {
      gems += 1;
      msg = local.graveyardSuccessGem("1");
    } else if (roll < 75) {
      int hpLost = (level * 3) + _random.nextInt(5);
      playerHp = (playerHp - hpLost).clamp(0, playerMaxHp);
      msg = local.graveyardZombieEncounter(hpLost.toString());
    } else {
      msg = local.graveyardEmpty;
    }

    await _updateCloudStats();

    setState(() {
      _statusMessage = msg;
      _isLoading = false;
      if (playerHp <= 0) _hasAcceptedFate = true;
    });
  }

  Future<void> _handleOffer(bool useGem) async {
    final local = AppLocalizations.of(context)!;

    if (useGem && gems < 1) {
      setState(() { _statusMessage = local.graveyardErrorNoGem; });
      return;
    }
    if (!useGem && experience < 100) {
      setState(() { _statusMessage = local.graveyardErrorNoXp; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        gems = useGem ? gems - 1 : gems;
        experience = useGem ? experience : experience - 100;
        playerHp = playerMaxHp;

        await _supabase.from('profiles').update({
          'gems': gems,
          'experience': experience,
          'hp': playerHp,
          'alive': true,
        }).eq('id', user.id);

        if (!mounted) return;
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (_) {
      setState(() { _statusMessage = local.graveyardErrorResurrection; _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
            local.graveyardTitle,
            style: const TextStyle(fontFamily: LogdCodes.retroFont, color: Colors.redAccent, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)
        ),
        backgroundColor: const Color(0xFF111111),
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
                    LogdText(text: _hasAcceptedFate ? local.graveyardWaitMessage : local.graveyardWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14.0), child: Divider(color: Colors.grey)),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ),

            if (_hasAcceptedFate) ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.cyan, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () => _handleOffer(true),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardOfferGem.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () => _handleOffer(false),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardOfferXp.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.grey, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold))),
              ),
            ] else ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent, width: 2), backgroundColor: const Color(0xFF1A0505), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: _robGrave,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardRob.toUpperCase(), style: const TextStyle(color: Colors.redAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () => Navigator.pop(context),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold))),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
