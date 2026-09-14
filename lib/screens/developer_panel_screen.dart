import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../services/forest_manager.dart';
import '../services/logd_enums.dart';
import 'forest_screen.dart';

class DeveloperPanelScreen extends StatefulWidget {
  const DeveloperPanelScreen({super.key});

  @override
  State<DeveloperPanelScreen> createState() => _DeveloperPanelScreenState();
}

class _DeveloperPanelScreenState extends State<DeveloperPanelScreen> {
  final _supabase = Supabase.instance.client;
  final ForestManager _forestManager = ForestManager();

  List<LogdEnemy> _allEnemies = [];
  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadDevPanelData();
  }

  Future<void> _loadDevPanelData() async {
    await _forestManager.loadEnemies();
    if (mounted) {
      setState(() {
        _allEnemies = _forestManager.getRawEnemiesList();
        _isLoading = false;
        if (ForestManager.loadError.isNotEmpty && _allEnemies.isEmpty) {
          _statusMessage = "`y[DIAGNOSE]: ${ForestManager.loadError}`w";
        }
      });
    }
  }

  Future<void> _executeCheat(String column, dynamic value, {bool isIncrement = false}) async {
    final local = AppLocalizations.of(context)!;
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      if (isIncrement) {
        final data = await _supabase.from('profiles').select(column).eq('id', user.id).single();
        final int currentVal = data[column] ?? 0;
        await _supabase.from('profiles').update({column: currentVal + (value as int)}).eq('id', user.id);
      } else if (column == 'heal') {
        final data = await _supabase.from('profiles').select('max_hp').eq('id', user.id).single();
        await _supabase.from('profiles').update({'hp': data['max_hp'] ?? 20, 'alive': true}).eq('id', user.id);
      } else if (column == 'level_up') {
        final data = await _supabase.from('profiles').select('level, max_hp').eq('id', user.id).single();
        await _supabase.from('profiles').update({
          'level': (data['level'] ?? 1) + 1,
          'max_hp': (data['max_hp'] ?? 20) + 10,
          'hp': (data['max_hp'] ?? 20) + 10,
          'alive': true
        }).eq('id', user.id);
      }
      setState(() { _statusMessage = local.devSuccessMessage; });
    } catch (_) {}
  }

  void _forceSpawnMonster(LogdEnemy enemy) {
    _forestManager.setForcedDevEnemy(enemy);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForestScreen()));
  }

  Future<void> _forceEvent(bool isFountain) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    try {
      await _supabase.from('profiles').update({'turns': 999}).eq('id', user.id);
      if (!mounted) return;
      _forestManager.setForcedDevEnemy(null);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ForestScreen(
                forcedEvent: isFountain ? ForestEventType.forcedFountain : ForestEventType.forcedGiant
            )
        ),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: Colors.purple)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // GEVIND: Omgebouwd naar luxe antraciet grijs!
      appBar: AppBar(
        title: Text(local.devScreenTitle, style: const TextStyle(fontFamily: 'Courier', color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2D2D2D), // Donkerder antraciet voor de balk
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_statusMessage.isNotEmpty) ...[
              LogdText(text: _statusMessage, fontSize: 14),
              const SizedBox(height: 10),
            ],

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDevButton(local.btnDevHeal, () => _executeCheat('heal', null)),
                _buildDevButton("+10K GOUD", () => _executeCheat('gold_on_hand', 10000, isIncrement: true)),
                _buildDevButton("+5 GEMS", () => _executeCheat('gems', 5, isIncrement: true)),
                _buildDevButton("+10 TURNS", () => _executeCheat('turns', 10, isIncrement: true)),
                _buildDevButton(local.btnDevLevelUp, () => _executeCheat('level_up', null)),
              ],
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildEventButton("SPAWN WATERBRON ⛲", () => _forceEvent(true)),
                _buildEventButton("SPAWN REUS 👹", () => _forceEvent(false)),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 6.0), child: Divider(color: Colors.purple)),

            LogdText(text: local.devSpawnMonsterTitle, fontSize: 16),
            const SizedBox(height: 4),
            LogdText(text: local.devSpawnMonsterDesc, fontSize: 13),
            const SizedBox(height: 10),

            Expanded(
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF262626), border: Border.all(color: Colors.purple.shade700)),
                child: ListView.builder(
                  itemCount: _allEnemies.length,
                  itemBuilder: (context, index) {
                    final enemy = _allEnemies[index];
                    return ListTile(
                      dense: true,
                      title: LogdText(text: "`rLvl ${enemy.level}`w - `c${LogdText.capitalize(enemy.name)}`w", fontSize: 15),
                      subtitle: LogdText(text: "HP: ${enemy.maxHp} | Goud: ${enemy.minGold}-${enemy.maxGold}", fontSize: 12),
                      trailing: const Icon(Icons.gavel, color: Colors.purpleAccent, size: 20),
                      onTap: () => _forceSpawnMonster(enemy),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple, width: 2)),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDevButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple), backgroundColor: const Color(0xFF2A1B35)),
      onPressed: onPressed,
      child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: 'Courier', fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEventButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.cyan), backgroundColor: const Color(0xFF1B2D35)),
      onPressed: onPressed,
      child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontFamily: 'Courier', fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
