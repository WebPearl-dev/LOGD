// lib/screens/rankings_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/guest_manager.dart';

class RankingsScreen extends StatefulWidget {
  const RankingsScreen({super.key});

  @override
  State<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends State<RankingsScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _rankings = [];
  bool _isLoading = true;

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;

  @override
  void initState() {
    super.initState();
    _loadRankingsAndStats();
  }

  Future<void> _loadRankingsAndStats() async {
    try {
      if (GuestManager.isGuest) {
        final playerData = GuestManager.guestProfile;
        if (mounted) {
          setState(() {
            _rankings = [
              {
                'username': playerData['username'] ?? 'Gast Reiziger',
                'dragon_kills': playerData['dragon_kills'] ?? 0,
                'level': playerData['level'] ?? 1,
                'experience': playerData['experience'] ?? 0,
              }
            ];
            goldOnHand = playerData['gold_on_hand'] ?? 0;
            gems = playerData['gems'] ?? 0;
            turns = playerData['turns'] ?? 0;
            level = playerData['level'] ?? 1;
            experience = playerData['experience'] ?? 0;
            playerHp = playerData['hp'] ?? 20;
            playerMaxHp = playerData['max_hp'] ?? 20;
            _isLoading = false;
          });
        }
        return;
      }

      final user = _supabase.auth.currentUser;
      if (user != null) {
        final rankingsData = await _supabase
            .from('profiles')
            .select('username, dragon_kills, level, experience')
            .order('dragon_kills', ascending: false)
            .order('level', ascending: false)
            .order('experience', ascending: false)
            .limit(50);

        final playerData = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        if (mounted) {
          setState(() {
            _rankings = List<Map<String, dynamic>>.from(rankingsData);
            goldOnHand = playerData['gold_on_hand'] ?? 0;
            gems = playerData['gems'] ?? 0;
            turns = playerData['turns'] ?? 0;
            level = playerData['level'] ?? 1;
            experience = playerData['experience'] ?? 0;
            playerHp = playerData['hp'] ?? 20;
            playerMaxHp = playerData['max_hp'] ?? 20;
            _isLoading = false;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        body: Center(child: CircularProgressIndicator(color: Colors.yellow)),
      );
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          local.rankingsTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeDefault,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(
              text: local.rankingsWelcome,
              fontSize: LogdCodes.fontSizeDefault,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Colors.grey),
            ),

            Expanded(
              child: _rankings.isEmpty
                  ? Center(
                      child: LogdText(
                        text: local.rankingsEmpty,
                        fontSize: LogdCodes.fontSizeDefault,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _rankings.length,
                      itemBuilder: (context, index) {
                        final player = _rankings[index];
                        final int pos = index + 1;
                        final String name = player['username'] ?? local.defaultUsername;
                        final int dk = player['dragon_kills'] ?? 0;
                        final int lvl = player['level'] ?? 1;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: LogdText(
                                  text: "`y$pos.`w",
                                  fontSize: LogdCodes.fontSizeDefault,
                                ),
                              ),
                              Expanded(
                                child: LogdText(
                                  text: "`c$name`w",
                                  fontSize: LogdCodes.fontSizeDefault,
                                ),
                              ),
                              LogdText(
                                text: "`r${local.statDk(dk)}`w  `y${local.statLvl(lvl)}`w",
                                fontSize: LogdCodes.fontSizeDefault - 2,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  local.btnReturnTown.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontFamily: LogdCodes.retroFont,
                    fontSize: LogdCodes.fontSizeDefault,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
    );
  }
}
