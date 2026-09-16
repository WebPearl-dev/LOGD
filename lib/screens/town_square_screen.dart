// lib/screens/town_square_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import 'forest_screen.dart';
import 'profile_settings_screen.dart';
import 'bank_screen.dart';
import 'smithy_screen.dart';
import 'training_screen.dart';
import 'graveyard_screen.dart';
import 'daily_news_screen.dart';
import 'inn_screen.dart';
import 'stables_screen.dart';
import 'church_screen.dart';
import 'alchemist_screen.dart';

class TownSquareScreen extends StatefulWidget {
  const TownSquareScreen({super.key});

  @override
  State<TownSquareScreen> createState() => _TownSquareScreenState();
}

class _TownSquareScreenState extends State<TownSquareScreen> {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic>? _playerData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        final data = await _supabase.from('profiles').select().eq('id', user.id).single();

        if (mounted) {
          // --- HIER DRAAIT DE AUTOMATISCHE MIDDERNACHT RESET ---
          final String todayStr = DateTime.now().toIso8601String().split('T')[0];
          final String lastResetStr = data['last_reset_date']?.toString() ?? '2020-01-01';

          if (todayStr != lastResetStr) {
            final int mountLvl = data['mount_level'] ?? 0;
            int extraTurns = 0;
            if (mountLvl == 1) extraTurns = 2;
            if (mountLvl == 2) extraTurns = 5;
            if (mountLvl == 3) extraTurns = 8;
            if (mountLvl == 4) extraTurns = 15;

            final int totalNewTurns = 10 + extraTurns;
            final int maxHp = data['max_hp'] ?? 20;

            await _supabase.from('profiles').update({
              'turns': totalNewTurns,
              'hp': maxHp,
              'alive': true,
              'prayed_this_turn': false,
              'last_reset_date': todayStr,
            }).eq('id', user.id);

            _showNewDayDialog();
            return;
          }

          final bool isAlive = data['alive'] ?? true;
          if (!isAlive) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const GraveyardScreen()));
            return;
          }

          setState(() {
            _playerData = data;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) { setState(() { _isLoading = false; }); }
    }
  }

  void _showNewDayDialog() {
    final local = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          // DE FIX: Dialoog titel font hersteld naar centrale retro wet
          title: Text(local.resetNewDayTitle, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeCardTitle, color: LogdCodes.uiGreen, fontWeight: FontWeight.bold)),
          content: LogdText(text: local.resetNewDayMessage, fontSize: LogdCodes.fontSizeDefault),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiGreen, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() { _isLoading = true; });
                  _loadPlayerData();
                },
                // DE FIX: Start dag knop font hersteld naar de wet
                child: Text(local.btnStartDay.toUpperCase(), style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    final level = _playerData?['level'] ?? 1;
    final currentHp = _playerData?['hp'] ?? 20;
    final maxHp = _playerData?['max_hp'] ?? 20;
    final goldOnHand = _playerData?['gold_on_hand'] ?? 0;
    final gems = _playerData?['gems'] ?? 0;
    final turns = _playerData?['turns'] ?? 0;
    final experience = _playerData?['experience'] ?? 0;
    final username = _playerData?['username'] ?? 'Reiziger';

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        // DE FIX: Toont nu puur en alleen de spelersnaam. Niveau en beurten staan al sfeervol onderaan!
        title: Text(
          username,
          style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeDefault,
              fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color(0xFF2D2D2D),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettingsScreen())).then((_) {
                setState(() { _isLoading = true; }); _loadPlayerData();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: LogdText(text: local.townSquareWelcome, fontSize: LogdCodes.fontSizeDefault),
                ),
              ),
            ),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.2,
              children: [
                _buildGridButton(local.btnVisitBank.toUpperCase(), Colors.yellow, const Color(0xFF1E1E00), () => _navigateTo(const BankScreen())),
                _buildGridButton(local.btnVisitSmithy.toUpperCase(), Colors.orange, const Color(0xFF241400), () => _navigateTo(const SmithyScreen())),
                _buildGridButton(local.btnVisitTraining.toUpperCase(), Colors.red, const Color(0xFF240D0D), () => _navigateTo(const TrainingScreen())),
                _buildGridButton(local.btnVisitInn.toUpperCase(), const Color(0xFFE040FB), const Color(0xFF1F0024), () => _navigateTo(const InnScreen())),
                _buildGridButton(local.btnVisitStables.toUpperCase(), LogdCodes.uiBlue, const Color(0xFF001B24), () => _navigateTo(const StablesScreen())),
                _buildGridButton(local.btnVisitChurch.toUpperCase(), LogdCodes.uiChurch, const Color(0xFF222222), () => _navigateTo(const ChurchScreen())),
                _buildGridButton(local.btnVisitAlchemist.toUpperCase(), LogdCodes.uiMagenta, const Color(0xFF240024), () => _navigateTo(const AlchemistScreen())),
                _buildGridButton(local.btnVisitNews.toUpperCase(), Colors.blue, const Color(0xFF0D1B24), () => _navigateTo(const DailyNewsScreen())),
                _buildGridButton(local.btnGoToForest.toUpperCase(), Colors.green, const Color(0xFF0D240D), () => _navigateTo(const ForestScreen())),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(
        currentHp: currentHp, maxHp: maxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience,
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen)).then((_) {
      setState(() { _isLoading = true; });
      _loadPlayerData();
    });
  }

  Widget _buildGridButton(String label, Color color, Color bg, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
      onPressed: onPressed,
      // DE FIX: Dorpsplein gridknoppen font en size synchroon gezet met de rest van de game
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color,
            fontFamily: LogdCodes.retroFont,
            fontWeight: FontWeight.bold,
            fontSize: LogdCodes.fontSizeDefault - 2,
            letterSpacing: 0.5
        ),
      ),
    );
  }
}
