// lib/screens/developer_panel_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../services/forest_manager.dart';
import '../services/logd_enums.dart';
import '../theme/logd_codes.dart';
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

  LogdEnemy? _selectedEnemy;
  ForestEventType _selectedEvent = ForestEventType.forcedFountain;

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
        _allEnemies.sort((a, b) => a.level.compareTo(b.level));
        if (_allEnemies.isNotEmpty) _selectedEnemy = _allEnemies.first;
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
          'level': (data['level'] ?? 1) + 1, 'max_hp': (data['max_hp'] ?? 20) + 10, 'hp': (data['max_hp'] ?? 20) + 10, 'alive': true
        }).eq('id', user.id);
      }
      setState(() { _statusMessage = local.devSuccessMessage; });
    } catch (_) {}
  }

  void _forceSpawnMonster() {
    if (_selectedEnemy == null) return;
    _forestManager.setForcedDevEnemy(_selectedEnemy);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForestScreen()));
  }

  Future<void> _forceEvent() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;
    try {
      await _supabase.from('profiles').update({'forest_turns': 999}).eq('id', user.id);
      if (!mounted) return;
      _forestManager.setForcedDevEnemy(null);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForestScreen(forcedEvent: _selectedEvent)));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: LogdCodes.uiPurple)));
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(local.devScreenTitle.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiPurple, fontSize: LogdCodes.fontSizeCardTitle, fontWeight: FontWeight.bold)),
        backgroundColor: LogdCodes.uiAppBarBg, automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (_statusMessage.isNotEmpty) ...[
            LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
            const SizedBox(height: 10),
          ],
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _buildDevButton(local.btnDevHeal, () => _executeCheat('heal', null)),
              _buildDevButton(local.btnDevAddGold, () => _executeCheat('gold_on_hand', 10000, isIncrement: true)),
              _buildDevButton(local.btnDevAddGems, () => _executeCheat('gems', 5, isIncrement: true)),
              _buildDevButton(local.btnDevAddTurns, () => _executeCheat('forest_turns', 10, isIncrement: true)),
              _buildDevButton(local.btnDevLevelUp, () => _executeCheat('level_up', null)),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider(color: LogdCodes.uiPurple)),

          LogdText(text: local.lblDevSelectEvent, fontSize: LogdCodes.fontSizeDefault),
          const SizedBox(height: 6),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: LogdCodes.uiCardBg),
            child: DropdownButton<ForestEventType>(
              value: _selectedEvent, isExpanded: true, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiGreen),
              items: ForestEventType.values.map((e) => DropdownMenuItem(value: e, child: Text("EVENT: \${e.toString().split('.').last.toUpperCase()}"))).toList(),
              onChanged: (val) { if (val != null) setState(() => _selectedEvent = val); },
            ),
          ),
          const SizedBox(height: 6),
          OutlinedButton(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiCyan, width: 2), backgroundColor: const Color(0xFF1B2D35), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
            onPressed: _forceEvent,
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(local.btnDevSpawnAction.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
          ),

          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider(color: LogdCodes.uiPurple)),

          LogdText(text: local.lblDevSelectMonster, fontSize: LogdCodes.fontSizeDefault),
          const SizedBox(height: 6),
          if (_allEnemies.isNotEmpty) ...[
            Theme(
              data: Theme.of(context).copyWith(canvasColor: LogdCodes.uiCardBg),
              child: DropdownButton<LogdEnemy>(
                value: _selectedEnemy, isExpanded: true, style: const TextStyle(fontFamily: LogdCodes.retroFont, color: LogdCodes.uiRed),
                items: _allEnemies.map((e) => DropdownMenuItem(value: e, child: Text("LVL \${e.level} - e.name.toUpperCase() (HP: {e.maxHp})"))).toList(),
                onChanged: (val) { if (val != null) setState(() => _selectedEnemy = val); },
              ),
            ),
            const SizedBox(height: 6),
            OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiPurple, width: 2), backgroundColor: LogdCodes.uiPurpleBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
              onPressed: _forceSpawnMonster,
              child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(local.btnDevSpawnAction.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
            ),
          ],

          const Spacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiPurple, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)), backgroundColor: LogdCodes.uiBlueBg).copyWith(foregroundColor: WidgetStateProperty.all<Color>(LogdCodes.uiPurple)),
            onPressed: () => Navigator.pop(context),
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 12.0), child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
          ),
        ]),
      ),
    );
  }

  Widget _buildDevButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: const BorderSide(color: LogdCodes.uiPurple), backgroundColor: LogdCodes.uiPurpleBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
      onPressed: onPressed,
      child: Text(label.toUpperCase(), style: const TextStyle(color: LogdCodes.uiPurple, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault - 3, fontWeight: FontWeight.bold)),
    );
  }
}
