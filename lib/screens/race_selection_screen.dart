// lib/screens/race_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../services/story_service.dart';
import '../theme/logd_codes.dart';
import 'specialty_selection_screen.dart';

class RaceSelectionScreen extends StatefulWidget {
  const RaceSelectionScreen({super.key});

  @override
  State<RaceSelectionScreen> createState() => _RaceSelectionScreenState();
}

class _RaceSelectionScreenState extends State<RaceSelectionScreen> {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic> _storyContent = {};
  bool _isLoading = true;

  String _selectedGender = "";
  String _selectedRace = "";
  bool _confirmedGender = false;

  @override
  void initState() {
    super.initState();
    _loadStoryContent();
  }

  Future<void> _loadStoryContent() async {
    final content = await StoryService.loadLocationContent(context, 'locatie_dorpsplein');
    if (mounted) {
      setState(() {
        _storyContent = content;
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCharacterCreation() async {
    if (_selectedGender.isEmpty || _selectedRace.isEmpty) {
      return;
    }
    setState(() { _isLoading = true; });

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        int startTurns = 10;
        int startGold = 0;
        int startGems = 0;
        int startMaxHp = 20;

        if (_selectedRace == 'HUMAN') { startTurns += 5; }
        if (_selectedRace == 'ELF') { startGems += 1; }
        if (_selectedRace == 'DWARF') { startGold += 100; }
        if (_selectedRace == 'ORC') { startMaxHp += 5; }

        await _supabase.from('profiles').update({
          'race': _selectedRace,
          'gender': _selectedGender,
          'title': _selectedGender == 'F' ? 'Lady' : 'Sir',
          'turns': startTurns,
          'gold_on_hand': startGold,
          'gems': startGems,
          'max_hp': startMaxHp,
          'hp': startMaxHp,
        }).eq('id', user.id);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SpecialtySelectionScreen(
                chosenRace: _selectedRace,
                turns: startTurns,
                goldOnHand: startGold,
                gems: startGems,
                maxHp: startMaxHp,
              ),
            ),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    final String genderTitle = _storyContent['gender_title'] ?? "...";
    final String genderWelcome = _storyContent['gender_welcome'] ?? "...";
    final String genderMaleLabel = _storyContent['gender_male'] ?? "...";
    final String genderFemaleLabel = _storyContent['gender_female'] ?? "...";
    final String btnConfirmGenderLabel = _storyContent['btn_confirm_gender'] ?? "...";

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(!_confirmedGender ? genderTitle : local.raceTitle, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2D2D2D),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!_confirmedGender) ...[
              LogdText(text: genderWelcome, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 20),
              _buildSelectionButton(genderMaleLabel, _selectedGender == 'M', Colors.blue, () => setState(() => _selectedGender = 'M')),
              const SizedBox(height: 10),
              _buildSelectionButton(genderFemaleLabel, _selectedGender == 'F', Colors.pinkAccent, () => setState(() => _selectedGender = 'F')),
              const Spacer(),
              // DE DEFTIGE FLUTTER FIX: if-conditionele widgets inline zonder verwarrende accolades!
              if (_selectedGender.isNotEmpty)
                _buildActionButton(btnConfirmGenderLabel, Colors.green, () {
                  setState(() => _confirmedGender = true);
                }),
            ]
            else ...[
              LogdText(text: local.raceWelcome, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 20),
              _buildSelectionButton(local.raceHuman, _selectedRace == 'HUMAN', Colors.yellow, () => setState(() => _selectedRace = 'HUMAN')),
              const SizedBox(height: 10),
              _buildSelectionButton(local.raceElf, _selectedRace == 'ELF', LogdCodes.uiBlue, () => setState(() => _selectedRace = 'ELF')),
              const SizedBox(height: 10),
              _buildSelectionButton(local.raceDwarf, _selectedRace == 'DWARF', Colors.orange, () => setState(() => _selectedRace = 'DWARF')),
              const SizedBox(height: 10),
              _buildSelectionButton(local.raceOrc, _selectedRace == 'ORC', Colors.red, () => setState(() => _selectedRace = 'ORC')),
              const Spacer(),
              // DE DEFTIGE FLUTTER FIX:
              if (_selectedRace.isNotEmpty)
                _buildActionButton(local.btnConfirmRace.toUpperCase(), LogdCodes.uiGreen, _saveCharacterCreation),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionButton(String label, bool isSelected, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isSelected ? color : Colors.grey, width: isSelected ? 3 : 1),
        backgroundColor: isSelected ? const Color(0xFF111111) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: onPressed,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(label, style: TextStyle(color: isSelected ? color : Colors.grey, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: const Color(0xFF001B24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: onPressed,
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 14), child: Text(label, style: TextStyle(color: color, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault))),
    );
  }
}
