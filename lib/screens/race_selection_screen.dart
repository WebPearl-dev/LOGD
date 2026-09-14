import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import 'specialty_selection_screen.dart';

class RaceSelectionScreen extends StatefulWidget {
  const RaceSelectionScreen({super.key});

  @override
  State<RaceSelectionScreen> createState() => _RaceSelectionScreenState();
}

class _RaceSelectionScreenState extends State<RaceSelectionScreen> {
  String _selectedRace = 'Human';

  void _proceedToSpecialty() {
    int bonusTurns = 30;
    int bonusGold = 50;
    int bonusGems = 0;
    int bonusMaxHp = 20;

    if (_selectedRace == 'Human') bonusTurns = 35;
    if (_selectedRace == 'Dwarf') bonusGold = 150;
    if (_selectedRace == 'Elf') bonusGems = 1;
    if (_selectedRace == 'Orc') bonusMaxHp = 25;

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SpecialtySelectionScreen(
          chosenRace: _selectedRace,
          turns: bonusTurns,
          goldOnHand: bonusGold,
          gems: bonusGems,
          maxHp: bonusMaxHp,
        ),
      ),
    );
  }

  Widget _buildRaceCard(String raceKey, String title, String description) {
    bool isSelected = _selectedRace == raceKey;
    return GestureDetector(
      onTap: () => setState(() => _selectedRace = raceKey),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A00) : const Color(0xFF111111),
          border: Border.all(
            color: isSelected ? Colors.yellowAccent : Colors.grey.shade800,
            width: isSelected ? 2.0 : 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogdText(text: isSelected ? "`y> $title`w" : "`w  $title`w", fontSize: 18),
            const SizedBox(height: 4),
            LogdText(text: description, fontSize: 14),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(local.raceTitle, style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF111111),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(text: local.raceWelcome, fontSize: 16),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  _buildRaceCard('Human', local.raceHuman, local.raceHumanDesc),
                  _buildRaceCard('Elf', local.raceElf, local.raceElfDesc),
                  _buildRaceCard('Dwarf', local.raceDwarf, local.raceDwarfDesc),
                  _buildRaceCard('Orc', local.raceOrc, local.raceOrcDesc),
                ],
              ),
            ),

            SizedBox(
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.yellow, width: 2),
                  backgroundColor: const Color(0xFF1E1E00),
                ),
                onPressed: _proceedToSpecialty,
                child: Text(local.btnConfirmRace.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
