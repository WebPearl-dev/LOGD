// lib/screens/bank_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/bank_action_panel.dart';
import '../theme/logd_codes.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final _supabase = Supabase.instance.client;
  final _amountController = TextEditingController();

  int goldOnHand = 0, goldInBank = 0, playerHp = 20, playerMaxHp = 20;
  int gems = 0, turns = 0, level = 1, experience = 0;

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

  Future<void> _updateCloudGold() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'gold_in_bank': goldInBank,
      }).eq('id', user.id);
    }
  }

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
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
            local.btnVisitBank,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LogdText(text: local.bankWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Divider(color: Colors.grey)),
                    LogdText(text: local.bankInBank(goldInBank), fontSize: LogdCodes.fontSizeCardTitle),
                    const SizedBox(height: 8),
                    LogdText(text: local.bankOnHand(goldOnHand), fontSize: LogdCodes.fontSizeCardTitle),
                    const SizedBox(height: 20),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            BankActionPanel(
              amountController: _amountController,
              onHandleCustomAmount: _handleCustomAmount,
              onDepositAll: _depositAll,
              onWithdrawAll: _withdrawAll,
              onReturnTown: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
