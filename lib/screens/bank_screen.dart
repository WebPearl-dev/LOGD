// lib/screens/bank_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/bank_action_panel.dart';
import '../theme/logd_codes.dart';
import '../services/bank_controller.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final BankController _con = BankController();
  final _amountController = TextEditingController();
  
  Map<String, dynamic> _storyContent = {};
  String _displayLog = "";
  bool _isInitLoading = true;

  @override
  void initState() {
    super.initState();
    _initBank();
  }

  Future<void> _initBank() async {
    await _con.loadBankStats();
    
    // Laad JSON verhalen
    if (!mounted) return;
    final String lang = Localizations.localeOf(context).languageCode;
    final String jsonPath = 'assets/story/${lang == 'nl' ? 'nl' : 'en'}/locatie_bank.json';
    final String jsonString = await rootBundle.loadString(jsonPath);
    _storyContent = jsonDecode(jsonString);

    if (mounted) {
      setState(() {
        _displayLog = _storyContent['welcome'] ?? "...";
        _isInitLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleTransaction(bool isDeposit) async {
    final int? amount = int.tryParse(_amountController.text.trim());
    if (amount == null) {
      setState(() => _displayLog = _storyContent['error_invalid_amount'] ?? "Voer een getal in.");
      return;
    }

    final String? resultKey = isDeposit ? await _con.deposit(amount) : await _con.withdraw(amount);

    if (mounted && resultKey != null) {
      setState(() {
        _displayLog = _storyContent[resultKey] ?? resultKey;
        if (resultKey.contains('success')) {
          _amountController.clear();
        }
      });
    }
  }

  void _talkToBanker() {
    setState(() {
      final String key = _con.getRandomTalkKey();
      _displayLog = _storyContent[key] ?? "...";
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isInitLoading) {
      return const Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)),
      );
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          local.bankTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeDefault,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
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
                    LogdText(
                      text: local.bankVaultBalance(_con.goldInBank.toString()),
                      fontSize: LogdCodes.fontSizeCardTitle,
                    ),
                    LogdText(
                      text: local.bankOnHandLabel(_con.goldOnHand.toString()),
                      fontSize: LogdCodes.fontSizeDefault,
                    ),
                    const Divider(color: Colors.grey, height: 24),
                    LogdText(text: _displayLog, fontSize: LogdCodes.fontSizeDefault),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            BankActionPanel(
              amountController: _amountController,
              limitInfo: local.bankDepositLimitLabel(_con.remainingDepositLimit.toString()),
              onHandleCustomAmount: _handleTransaction,
              onDepositAll: () {
                _amountController.text = _con.goldOnHand.toString();
                _handleTransaction(true);
              },
              onWithdrawAll: () {
                _amountController.text = _con.goldInBank.toString();
                _handleTransaction(false);
              },
            ),
            const SizedBox(height: 8),
            
            SizedBox(
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiCyan, width: 2),
                  backgroundColor: LogdCodes.uiBlueBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: _talkToBanker,
                child: Text(
                  local.btnTalkBanker.toUpperCase(),
                  style: const TextStyle(
                    color: LogdCodes.uiBlue,
                    fontFamily: LogdCodes.retroFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                backgroundColor: LogdCodes.uiBlueBg,
              ).copyWith(
                foregroundColor: WidgetStateProperty.all(LogdCodes.uiBlueDark),
              ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  local.btnReturnTown.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: LogdCodes.retroFont,
                    fontSize: LogdCodes.fontSizeDefault,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(
        currentHp: _con.hp,
        maxHp: _con.maxHp,
        goldOnHand: _con.goldOnHand,
        gems: _con.gems,
        turns: _con.turns,
        level: _con.level,
        experience: _con.experience,
      ),
    );
  }
}
