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
          final String todayStr = DateTime.now().toIso8601String().split('T')[0]; // Geeft bijv. '2026-09-14'
          final String lastResetStr = data['last_reset_date']?.toString() ?? '2020-01-01';

          if (todayStr != lastResetStr) {
            // Nieuw dag gedetecteerd! Bereken de nieuwe beurten inclusief de Stallen-bonus
            final int mountLvl = data['mount_level'] ?? 0;
            int extraTurns = 0;
            if (mountLvl == 1) extraTurns = 2;  // Pony
            if (mountLvl == 2) extraTurns = 5;  // Paard
            if (mountLvl == 3) extraTurns = 8;  // Wolf
            if (mountLvl == 4) extraTurns = 15; // Gouden Draak

            final int totalNewTurns = 10 + extraTurns; // 10 Basisbeurten + bonus
            final int maxHp = data['max_hp'] ?? 20;

            // Schrijf de reset live weg naar de cloud!
            await _supabase.from('profiles').update({
              'turns': totalNewTurns,
              'hp': maxHp,
              'alive': true,
              'prayed_this_turn': false, // Geef de Kerk weer vrij!
              'last_reset_date': todayStr,
            }).eq('id', user.id);

            // Toon de sfeervolle pop-up aan de speler
            _showNewDayDialog();
            return;
          }

          // Als de speler dood is (en geen nieuwe dag heeft), sturen we hem direct naar de Begraafplaats
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
      barrierDismissible: false, // Speler moet op de knop drukken
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Text(local.resetNewDayTitle, style: const TextStyle(fontFamily: 'Courier', color: LogdCodes.uiGreen, fontWeight: FontWeight.bold)),
          content: LogdText(text: local.resetNewDayMessage, fontSize: LogdCodes.fontSizeDefault),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiGreen, width: 2)),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() { _isLoading = true; });
                  _loadPlayerData(); // Herlaad de stats met de verse turns!
                },
                child: Text(local.btnStartDay.toUpperCase(), style: const TextStyle(color: LogdCodes.uiGreen, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
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
        title: Text(
          '$username (Lvl $level | ⏳ $turns)',
          style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 16),
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
                  child: LogdText(text: local.townSquareWelcome, fontSize: 16),
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
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: color,
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
            letterSpacing: 0.5
        ),
      ),
    );
  }
}
