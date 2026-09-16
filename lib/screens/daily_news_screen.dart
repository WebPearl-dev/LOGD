// lib/screens/daily_news_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart'; // Importeer je centrale styles!

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

  Future<void> _loadNewsAndStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final newsData = await _supabase
          .from('daily_news')
          .select()
          .order('created_at', ascending: false)
          .limit(50);

      final playerData = await _supabase.from('profiles').select().eq('id', user.id).single();

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
  }

  String _parseLogToText(AppLocalizations local, Map<String, dynamic> log) {
    final String type = log['log_type'] ?? '';
    final String user = log['username'] ?? local.newsUnknownPlayer;

    final int numericValue = log['reached_level'] ?? 0;
    final String valueStr = numericValue.toString();

    if (type == 'level_up') {
      return local.newsLogLevelUp(user, valueStr);
    } else if (type == 'defeated') {
      return local.newsLogDefeated(user, log['enemy_name'] ?? 'een monster');
    } else if (type == 'inn_win') {
      return local.newsLogInnWin(valueStr, user);
    } else if (type == 'inn_loss') {
      return local.newsLogInnLoss(valueStr, user);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        // DE FIX: Gekoppeld aan de centrale font- en size wet!
        title: Text(
            local.btnVisitNews,
            style: const TextStyle(
                fontFamily: LogdCodes.retroFont,
                fontSize: LogdCodes.fontSizeDefault,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: const Color(0xFF2D2D2D),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(text: local.newsWelcome, fontSize: LogdCodes.fontSizeDefault),
            const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Divider(color: Colors.grey)),

            Expanded(
              child: _newsLogs.isEmpty
                  ? Center(child: LogdText(text: local.newsEmpty, fontSize: LogdCodes.fontSizeDefault))
                  : ListView.builder(
                itemCount: _newsLogs.length,
                itemBuilder: (context, index) {
                  final log = _newsLogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: LogdText(text: "• ${_parseLogToText(local, log)}", fontSize: LogdCodes.fontSizeDefault),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                // DE FIX: Hardcoded Courier en vaste grootte verwijderd
                child: Text(
                    local.btnReturnTown.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: LogdCodes.retroFont,
                        fontSize: LogdCodes.fontSizeDefault,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
