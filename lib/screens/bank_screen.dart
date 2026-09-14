import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final _supabase = Supabase.instance.client;
  final _amountController = TextEditingController();

  int goldOnHand = 0;
  int goldInBank = 0;
  int playerHp = 20;
  int playerMaxHp = 20;
  int gems = 0;
  int turns = 0;
  int level = 1;
  int experience = 0;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadBankData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // Haal live goudgegevens op uit de cloud
  Future<void> _loadBankData() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          goldOnHand = data['gold_on_hand'] ?? 0;
          goldInBank = data['gold_in_bank'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          _isLoading = false;
        });
      }
    }
  }

  // Update de cloud database met de nieuwe goudstanden
  Future<void> _updateCloudGold() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'gold_in_bank': goldInBank,
      }).eq('id', user.id);
    }
  }

  // --- ACTIE: ALLES STORTEN ---
  void _depositAll() {
    if (goldOnHand <= 0) return;
    final local = AppLocalizations.of(context)!;
    setState(() {
      _statusMessage = local.bankSuccessDeposit(goldOnHand.toString());
      goldInBank += goldOnHand;
      goldOnHand = 0;
    });
    _updateCloudGold();
  }

  // --- ACTIE: ALLES OPNEMEN ---
  void _withdrawAll() {
    if (goldInBank <= 0) return;
    final local = AppLocalizations.of(context)!;
    setState(() {
      _statusMessage = local.bankSuccessWithdraw(goldInBank.toString());
      goldOnHand += goldInBank;
      goldInBank = 0;
    });
    _updateCloudGold();
  }

  // --- ACTIE: HANDMATIG BEDRAG AFHANDELEN ---
  void _handleCustomAmount(bool isDeposit) {
    final local = AppLocalizations.of(context)!;
    final int? enteredAmount = int.tryParse(_amountController.text.trim());

    if (enteredAmount == null || enteredAmount <= 0) {
      setState(() { _statusMessage = local.bankErrorInvalid; });
      return;
    }

    setState(() {
      if (isDeposit) {
        if (enteredAmount > goldOnHand) {
          _statusMessage = local.bankErrorNoGoldOnHand;
        } else {
          goldOnHand -= enteredAmount;
          goldInBank += enteredAmount;
          _statusMessage = local.bankSuccessDeposit(enteredAmount.toString());
          _amountController.clear();
        }
      } else {
        if (enteredAmount > goldInBank) {
          _statusMessage = local.bankErrorNoGoldInBank;
        } else {
          goldInBank -= enteredAmount;
          goldOnHand += enteredAmount;
          _statusMessage = local.bankSuccessWithdraw(enteredAmount.toString());
          _amountController.clear();
        }
      }
    });

    _updateCloudGold();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // GECORRIGEERD: Titel ingekort zodat deze nooit meer afkapt!
        title: Text(local.btnVisitBank, style: const TextStyle(fontFamily: 'Courier')),
        backgroundColor: const Color(0xFF2D2D2D),
        automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Het welkomstbericht van de dwerg
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LogdText(text: local.bankWelcome, fontSize: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(color: Colors.grey),
                    ),
                    LogdText(text: local.bankInBank(goldInBank), fontSize: 18),
                    const SizedBox(height: 8),
                    LogdText(text: local.bankOnHand(goldOnHand), fontSize: 18),
                    const SizedBox(height: 20),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: 16),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),

            // Invoerveld voor handmatige goudbedragen (Nu 100% hardcode-vrij)
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontFamily: 'Courier', fontSize: 18),
              decoration: InputDecoration(
                labelText: local.smithyAmountLabel,
                labelStyle: const TextStyle(color: Colors.grey, fontFamily: 'Courier'),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
              ),
            ),
            const SizedBox(height: 16),

            // Knoppenbalken voor transacties
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.yellow)),
                    onPressed: () => _handleCustomAmount(true),
                    child: Text(local.btnDepositCustom.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.yellow)),
                    onPressed: () => _handleCustomAmount(false),
                    child: Text(local.btnWithdrawCustom.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontSize: 13, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.green)),
                    onPressed: _depositAll,
                    child: Text(local.btnDepositAll.toUpperCase(), style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontSize: 14)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.green)),
                    onPressed: _withdrawAll,
                    child: Text(local.btnWithdrawAll.toUpperCase(), style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', fontSize: 14)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Knop: Terug naar het Dorpsplein
            OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.blue, width: 2)),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: 'Courier', fontSize: 16, fontWeight: FontWeight.bold)),
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
