import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import 'town_square_screen.dart';

class SpecialtySelectionScreen extends StatefulWidget {
  final String chosenRace;
  final int turns;
  final int goldOnHand;
  final int gems;
  final int maxHp;

  const SpecialtySelectionScreen({
    super.key,
    required this.chosenRace,
    required this.turns,
    required this.goldOnHand,
    required this.gems,
    required this.maxHp,
  });

  @override
  State<SpecialtySelectionScreen> createState() => _SpecialtySelectionScreenState();
}

class _SpecialtySelectionScreenState extends State<SpecialtySelectionScreen> {
  final _supabase = Supabase.instance.client;
  String _selectedSpecialty = 'Magic';
  bool _isLoading = false;

  Future<void> _confirmSpecialty() async {
    setState(() { _isLoading = true; });
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        // We slaan nu ALLES (Ras bonussen + Klasse) in één vederlichte update op!
        await _supabase.from('profiles').update({
          'race': widget.chosenRace,
          'turns': widget.turns,
          'gold_on_hand': widget.goldOnHand,
          'gems': widget.gems,
          'max_hp': widget.maxHp,
          'hp': widget.maxHp,
          'specialty': _selectedSpecialty,
          'level': 1,
          'experience': 0,
          'alive': true,
        }).eq('id', user.id);

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TownSquareScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  Widget _buildSpecialtyCard(String specKey, String title, String description) {
    bool isSelected = _selectedSpecialty == specKey;
    return GestureDetector(
      onTap: () => setState(() => _selectedSpecialty = specKey),
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
        title: Text(local.specialtyTitle, style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF111111),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(text: local.specialtyWelcome, fontSize: 16),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  _buildSpecialtyCard('Magic', local.specMagic, local.specMagicDesc),
                  _buildSpecialtyCard('Thieving', local.specThieving, local.specThievingDesc),
                  _buildSpecialtyCard('Warrior', local.specWarrior, local.specWarriorDesc),
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
                onPressed: _isLoading ? null : _confirmSpecialty,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.yellow)
                    : Text(local.btnConfirmSpecialty.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
