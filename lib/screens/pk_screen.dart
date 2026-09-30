// lib/screens/pk_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../services/guest_manager.dart';
import 'direct_messages_screen.dart';
import 'graveyard_screen.dart';

class PkScreen extends StatefulWidget {
  const PkScreen({super.key});

  @override
  State<PkScreen> createState() => _PkScreenState();
}

class _PkScreenState extends State<PkScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _targets = [];
  bool _isLoading = true;
  Map<String, dynamic> _myProfile = {};

  @override
  void initState() {
    super.initState();
    _loadPkData();
  }

  Future<void> _loadPkData() async {
    try {
      if (GuestManager.isGuest) {
        _myProfile = GuestManager.guestProfile;
        _targets = [
          {'id': 'dummy1', 'username': 'Bravoura', 'level': 3, 'hp': 40, 'max_hp': 40, 'gold_on_hand': 200, 'honor': 10, 'is_resting_in_inn': true},
          {'id': 'dummy2', 'username': 'Shadow', 'level': 5, 'hp': 60, 'max_hp': 60, 'gold_on_hand': 500, 'honor': 25, 'is_resting_in_inn': false},
        ];
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final user = supabase.auth.currentUser;
      if (user != null) {
        final myRes = await supabase.from('profiles').select().eq('id', user.id).single();
        _myProfile = myRes;

        final res = await supabase
            .from('profiles')
            .select()
            .not('id', 'eq', user.id)
            .order('level', ascending: false)
            .limit(30);
        _targets = List<Map<String, dynamic>>.from(res);
      }
    } catch (_) {
      // fallback
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _attemptAmbush(Map<String, dynamic> target) async {
    final local = AppLocalizations.of(context)!;
    bool isResting = target['is_resting_in_inn'] ?? false;

    if (isResting) {
      // Safe Haven Check: Target is resting in the inn under protection of Innkeeper and guards!
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: LogdCodes.uiCardBg,
          title: Text(
            local.dialogGuardHaltTitle.toUpperCase(),
            style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
          ),
          content: LogdText(
            text: "De aanval is mislukt! ${target['username']} rust veilig in een herbergkamer en staat onder strenge bescherming van de Herbergier en de koninklijke wachters (Safe Haven).",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(local.btnOk, style: const TextStyle(color: LogdCodes.uiGreen)),
            ),
          ],
        ),
      );
      return;
    }

    // Target is outside! Initiate PvP combat encounter / ambush.
    int myLvl = _myProfile['level'] ?? 1;
    int targetLvl = target['level'] ?? 1;
    bool iWon = (myLvl + Random().nextInt(5)) >= (targetLvl + Random().nextInt(5));

    int goldStolen = min(target['gold_on_hand'] ?? 50, 100);
    if (goldStolen < 10) goldStolen = 20;

    int damageTaken = 0;
    setState(() {
      if (iWon) {
        _myProfile['gold_on_hand'] = (_myProfile['gold_on_hand'] ?? 0) + goldStolen;
        _myProfile['pvp_wins'] = (_myProfile['pvp_wins'] ?? 0) + 1;
        _myProfile['honor'] = (_myProfile['honor'] ?? 0) + 3;
      } else {
        damageTaken = Random().nextInt(10) + 10;
        int currentHp = _myProfile['hp'] ?? 20;
        currentHp = max(0, currentHp - damageTaken);
        _myProfile['hp'] = currentHp;
        _myProfile['gold_on_hand'] = max(0, (_myProfile['gold_on_hand'] ?? 0) - 50);
        _myProfile['pvp_losses'] = (_myProfile['pvp_losses'] ?? 0) + 1;
        _myProfile['honor'] = max(0, (_myProfile['honor'] ?? 0) - 2);

        if (currentHp <= 0) {
          _myProfile['alive'] = false;
          _myProfile['hp'] = 0;
          _myProfile['gold_on_hand'] = 0;
        }
      }
    });

    await _updateCloudStats();

    if ((_myProfile['hp'] ?? 20) <= 0) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GraveyardScreen()),
      );
      return;
    }

    if (!GuestManager.isGuest && supabase.auth.currentUser != null) {
      try {
        await supabase.from('daily_news').insert({
          'log_type': iWon ? 'pk_win' : 'pk_loss',
          'username': _myProfile['username'] ?? 'Reiziger',
          'message': iWon
              ? "${_myProfile['username']} heeft ${target['username']} buiten op straat overvallen en $goldStolen goud buitgemaakt!"
              : "${_myProfile['username']} probeerde ${target['username']} buiten te overvallen, maar werd verslagen en liep $damageTaken schade op!",
        });
      } catch (_) {}
    }

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: LogdCodes.uiCardBg,
        title: Text(
          iWon ? "OVERVAL GESLAAGD!" : "OVERVAL MISLUKT!",
          style: TextStyle(
            color: iWon ? LogdCodes.uiGreen : LogdCodes.uiRed,
            fontFamily: LogdCodes.retroFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: LogdText(
          text: iWon
              ? "Je hebt ${target['username']} buiten op straat aangevallen en succesvol geroofd! Je verdient $goldStolen goud en 3 eer."
              : "Je werd afgeslagen tijdens je ambush op ${target['username']}! Je verliest de confrontatie, 50 goud en loopt $damageTaken schade op (HP: ${_myProfile['hp']}).",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadPkData();
            },
            child: Text(local.btnOk, style: const TextStyle(color: LogdCodes.uiGreen)),
          ),
        ],
      ),
    );
  }

  Future<void> _updateCloudStats() async {
    if (GuestManager.isGuest) {
      if ((_myProfile['hp'] ?? 20) <= 0) {
        GuestManager.guestProfile['alive'] = false;
        GuestManager.guestProfile['hp'] = 0;
        GuestManager.guestProfile['gold_on_hand'] = 0;
      }
      return;
    }
    final user = supabase.auth.currentUser;
    if (user != null) {
      final updates = {
        'gold_on_hand': _myProfile['gold_on_hand'],
        'hp': _myProfile['hp'],
        'pvp_wins': _myProfile['pvp_wins'],
        'pvp_losses': _myProfile['pvp_losses'],
        'honor': _myProfile['honor'],
        'is_resting_in_inn': false,
      };
      if ((_myProfile['hp'] ?? 20) <= 0) {
        updates['alive'] = false;
        updates['hp'] = 0;
        updates['gold_on_hand'] = 0;
      }
      await supabase.from('profiles').update(updates).eq('id', user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final currentHp = _myProfile['hp'] ?? 20;
    final maxHp = _myProfile['max_hp'] ?? 20;
    final goldOnHand = _myProfile['gold_on_hand'] ?? 0;
    final gems = _myProfile['gems'] ?? 0;
    final turns = _myProfile['turns'] ?? 0;
    final level = _myProfile['level'] ?? 1;
    final experience = _myProfile['experience'] ?? 0;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          "BUITEN PK & AMBUSH",
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeCardTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LogdCodes.uiCardBg,
                      border: Border.all(color: LogdCodes.uiRed),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const LogdText(
                      text: "Zoek reizigers buiten op straat of in het bos om te overvallen (PK). Let op: spelers die een kamer huren in het hotel/herberg (is_resting_in_inn) genieten van de bescherming van de Herbergier en wachters (Safe Haven)!",
                      fontSize: LogdCodes.fontSizeDefault - 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "REIZIGERS IN HET RIJK:",
                    style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _targets.isEmpty
                        ? Center(child: LogdText(text: local.arenaNoOpponents))
                        : ListView.builder(
                            itemCount: _targets.length,
                            itemBuilder: (context, index) {
                              final target = _targets[index];
                              final targetName = target['username'] ?? local.defaultUsername;
                              final targetLvl = target['level'] ?? 1;
                              final bool isResting = target['is_resting_in_inn'] ?? false;

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: LogdCodes.uiCardBg,
                                  border: Border.all(color: isResting ? LogdCodes.uiBlueDark : LogdCodes.uiRed),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            targetName,
                                            style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          LogdText(
                                            text: "Level: $targetLvl | Status: ${isResting ? '🛡️ In Herberg (Safe Haven)' : '⚔️ Buiten op straat'}",
                                            fontSize: LogdCodes.fontSizeDefault - 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.message, color: Colors.cyan),
                                          tooltip: local.btnDm,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DirectMessagesScreen(initialRecipientUsername: targetName),
                                              ),
                                            );
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: isResting ? LogdCodes.uiBlueBg : LogdCodes.uiRedBg,
                                            side: BorderSide(color: isResting ? LogdCodes.uiBlueDark : LogdCodes.uiRed),
                                          ),
                                          onPressed: () => _attemptAmbush(target),
                                          child: Text(
                                            isResting ? "HERBERG" : "AANVAL",
                                            style: TextStyle(
                                              color: isResting ? Colors.grey : LogdCodes.uiRed,
                                              fontFamily: LogdCodes.retroFont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: LogdStatusBar(
        currentHp: currentHp,
        maxHp: maxHp,
        goldOnHand: goldOnHand,
        gems: gems,
        turns: turns,
        level: level,
        experience: experience,
      ),
    );
  }
}
