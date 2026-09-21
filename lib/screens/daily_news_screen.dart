// lib/screens/daily_news_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';

class DailyNewsScreen extends StatefulWidget {
  const DailyNewsScreen({super.key});

  @override
  State<DailyNewsScreen> createState() => _DailyNewsScreenState();
}

class _DailyNewsScreenState extends State<DailyNewsScreen> {
  final _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _newsLogs = [];

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNewsAndStats();
  }

  // Gecorrigeerd: Maak de methode bruikbaar voor de RefreshIndicator
  Future<void> _loadNewsAndStats() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final newsData = await _supabase
            .from('daily_news')
            .select()
            .order('created_at', ascending: false)
            .limit(50);

        final playerData = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        if (mounted) {
          setState(() {
            _newsLogs = List<Map<String, dynamic>>.from(newsData);
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
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // --- CORE RETRO LOGS FIX: PARST DE DATABASE-KOLOMMEN IN DE EXACT JUISTE VOLGORDE ---
  String _parseLogToText(AppLocalizations local, Map<String, dynamic> log) {
    final String type = log['log_type'] ?? '';
    final String user = log['username'] ?? local.newsUnknownPlayer;

    // Haal dynamic het level op uit de juiste database-kolom
    final int numericLevel = log['reached_level'] ?? log['value_after'] ?? 0;
    final String levelStr = numericLevel.toString();

    // Haal dynamic het goudbedrag op uit de gok-kolommen
    final int numericGold = log['gold_amount'] ?? log['gold'] ?? 0;
    final String goldStr = numericGold.toString();

    if (type == 'level_up') {
      return local.newsLogLevelUp(levelStr, user);
    }
    if (type == 'defeated') {
      return local.newsLogDefeated(log['enemy_name'] ?? 'een monster', user);
    }
    if (type == 'defeated_brutal') {
      return local.newsLogDefeatedBrutal(log['enemy_name'] ?? 'een monster', user);
    }
    if (type == 'inn_win') {
      return local.newsLogInnWin(goldStr, user);
    }
    if (type == 'inn_loss') {
      return local.newsLogInnLoss(goldStr, user);
    }
    if (type == 'marriage') {
      return local.newsLogMarriage(log['partner_name'] ?? 'iemand', user);
    }
    // Mocht er een ruwe tekst in staan (zoals bij de eekhoorn), toon die dan als fallback
    return log['log_text'] ?? log['message'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
          local.btnVisitNews.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeDefault,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D2D2D),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(
              text: local.newsWelcome,
              fontSize: LogdCodes.fontSizeDefault,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Colors.grey),
            ),

            // DYNAMIC UPDATE FIX: Trek het scherm naar beneden om het nieuws LIVE te verversen!
            Expanded(
              child: _newsLogs.isEmpty
                  ? Center(
                      child: LogdText(
                        text: local.newsEmpty,
                        fontSize: LogdCodes.fontSizeDefault,
                      ),
                    )
                  : RefreshIndicator(
                      color: Colors.green,
                      backgroundColor: const Color(0xFF2D2D2D),
                      onRefresh: _loadNewsAndStats,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        // Nodig voor de RefreshIndicator
                        itemCount: _newsLogs.length,
                        itemBuilder: (context, index) {
                          final log = _newsLogs[index];
                          final String parsedText = _parseLogToText(local, log);

                          if (parsedText.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: LogdText(
                              text: "• $parsedText",
                              fontSize: LogdCodes.fontSizeDefault,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 10),

            // DE RETRO THEME FIX: Volledig hardcode-vrij via uiBlueDark en uiBlueBg!
            OutlinedButton(
              style:
                  OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: LogdCodes.uiBlueDark,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    backgroundColor: LogdCodes.uiBlueBg,
                  ).copyWith(
                    foregroundColor: WidgetStateProperty.all<Color>(
                      LogdCodes.uiBlueDark,
                    ),
                  ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  local.btnReturnTown.toUpperCase(),
                  style: const TextStyle(
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
