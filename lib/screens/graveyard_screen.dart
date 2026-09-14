import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import 'town_square_screen.dart';

class GraveyardScreen extends StatefulWidget {
  const GraveyardScreen({super.key});

  @override
  State<GraveyardScreen> createState() => _GraveyardScreenState();
}

class _GraveyardScreenState extends State<GraveyardScreen> {
  final _supabase = Supabase.instance.client;

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
          _isLoading = false;
        });
      }
    }
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
        int newGems = useGem ? gems - 1 : gems;
        int newXp = useGem ? experience : experience - 100;

        // Schrijf de opstanding direct live weg naar de cloud!
        await _supabase.from('profiles').update({
          'gems': newGems,
          'experience': newXp,
          'hp': playerMaxHp, // Volle HP bij opstanding!
          'alive': true,      // Je mag de stad weer in!
        }).eq('id', user.id);

        if (!mounted) return;
        // Wandel triomfantelijk terug naar de levende wereld!
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TownSquareScreen()),
        );
      }
    } catch (e) {
      setState(() { _statusMessage = "`4Er is een fout opgetreden bij de opstanding.`w"; _isLoading = false; });
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
      appBar: AppBar(title: Text(local.graveyardTitle, style: const TextStyle(fontFamily: 'Courier', color: Colors.redAccent)), backgroundColor: const Color(0xFF111111), automaticallyImplyLeading: false),
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
                    LogdText(text: _hasAcceptedFate ? local.graveyardWaitMessage : local.graveyardWelcome, fontSize: 16),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14.0), child: Divider(color: Colors.grey)),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: 16),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ),

            if (!_hasChallengedAndWaiting) ...[
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.cyan)),
                onPressed: () => _handleOffer(true),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardOfferGem.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontFamily: 'Courier'))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple)),
                onPressed: () => _handleOffer(false),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardOfferXp.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: 'Courier'))),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.grey)),
                onPressed: () => setState(() { _hasAcceptedFate = true; }),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnGraveyardAcceptLot.toUpperCase(), style: const TextStyle(color: Colors.grey, fontFamily: 'Courier'))),
              ),
            ] else ...[
              // Knop om terug te keren naar het startscherm/uitloggen als je besluit te wachten
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue)),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: 'Courier'))),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }

  bool get _hasChallengedAndWaiting => _hasAcceptedFate;
}
