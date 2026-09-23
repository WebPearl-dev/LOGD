// lib/screens/alchemist_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/guest_manager.dart';

class AlchemistScreen extends StatefulWidget {
  const AlchemistScreen({super.key});

  @override
  State<AlchemistScreen> createState() => _AlchemistScreenState();
}

class _AlchemistScreenState extends State<AlchemistScreen> {
  final _supabase = Supabase.instance.client;
  final int _potionCost = 300;
  final int _maxPotionsPerDay = 2;

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  int potionAtk = 0, potionDef = 0;
  int elixirsBoughtToday = 0;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadAlchemistData();
  }

  Future<void> _loadAlchemistData() async {
    if (GuestManager.isGuest) {
      final data = GuestManager.guestProfile;
      if (mounted) {
        setState(() {
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          potionAtk = data['potion_attack'] ?? 0;
          potionDef = data['potion_defense'] ?? 0;
          elixirsBoughtToday = data['elixirs_bought_today'] ?? 0;
          _isLoading = false;
        });
      }
      return;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          goldOnHand = data['gold_on_hand'] ?? 0;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          level = data['level'] ?? 1;
          experience = data['experience'] ?? 0;
          playerHp = data['hp'] ?? 20;
          playerMaxHp = data['max_hp'] ?? 20;
          potionAtk = data['potion_attack'] ?? 0;
          potionDef = data['potion_defense'] ?? 0;
          elixirsBoughtToday = data['elixirs_bought_today'] ?? 0;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _buyPotion(bool isAttack) async {
    final local = AppLocalizations.of(context)!;
    int currentBoost = isAttack ? potionAtk : potionDef;

    if (elixirsBoughtToday >= _maxPotionsPerDay) {
      setState(() { _statusMessage = local.alchemistLimitReached; });
      return;
    }

    if (currentBoost > 0) {
      setState(() { _statusMessage = local.alchemistErrorAlreadyActive; });
      return;
    }

    if (goldOnHand < _potionCost) {
      setState(() { _statusMessage = local.smithyErrorNoGold; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    int newGold = goldOnHand - _potionCost;
    int newAtkBoost = isAttack ? 5 : potionAtk;
    int newDefBoost = isAttack ? potionDef : 5;
    int newElixirsBought = elixirsBoughtToday + 1;

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = newGold;
      GuestManager.guestProfile['potion_attack'] = newAtkBoost;
      GuestManager.guestProfile['potion_defense'] = newDefBoost;
      GuestManager.guestProfile['elixirs_bought_today'] = newElixirsBought;
      setState(() {
        goldOnHand = newGold;
        potionAtk = newAtkBoost;
        potionDef = newDefBoost;
        elixirsBoughtToday = newElixirsBought;
        _statusMessage = local.alchemistSuccessBuy(isAttack ? "+5 Attack" : "+5 Defense");
        _isLoading = false;
      });
      return;
    }

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        try {
          await _supabase.from('profiles').update({
            'gold_on_hand': newGold,
            'potion_attack': newAtkBoost,
            'potion_defense': newDefBoost,
            'elixirs_bought_today': newElixirsBought,
          }).eq('id', user.id);
        } catch (e) {
          if (e.toString().contains('column') || e.toString().contains('42703')) {
            await _supabase.from('profiles').update({
              'gold_on_hand': newGold,
              'potion_attack': newAtkBoost,
              'potion_defense': newDefBoost,
            }).eq('id', user.id);
          } else {
            rethrow;
          }
        }

        setState(() {
          goldOnHand = newGold;
          potionAtk = newAtkBoost;
          potionDef = newDefBoost;
          elixirsBoughtToday = newElixirsBought;
          _statusMessage = local.alchemistSuccessBuy(isAttack ? "+5 Attack" : "+5 Defense");
        });
      }
    } catch (e) {
      debugPrint("Alchemist buy error: $e");
      setState(() { _statusMessage = local.smithyErrorUnknown; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: LogdCodes.uiMagenta)));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(
            local.alchemistTitle,
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
                    LogdText(text: local.alchemistWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Divider(color: Colors.grey)),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 10),
                    ],
                    LogdText(text: local.alchemistCurrentBoosts(potionAtk.toString(), potionDef.toString()), fontSize: LogdCodes.fontSizeDefault),
                    const SizedBox(height: 6),
                    LogdText(text: local.smithyCostLabel(_potionCost.toString()), fontSize: LogdCodes.fontSizeDefault),
                    const SizedBox(height: 16),

                    LogdText(
                      text: elixirsBoughtToday >= _maxPotionsPerDay
                          ? "${LogdCodes.colorLoss}${local.alchemistTodayCounter(elixirsBoughtToday.toString())}"
                          : "${LogdCodes.colorGold}${local.alchemistTodayCounter(elixirsBoughtToday.toString())}",
                      fontSize: LogdCodes.fontSizeDefault,
                    ),
                  ],
                ),
              ),
            ),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.grey : LogdCodes.uiMagenta, width: 2),
                backgroundColor: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.black12 : const Color(0xFF240024),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => _buyPotion(true),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                      local.btnBuyAtkPotion.toUpperCase(),
                      style: TextStyle(
                          color: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.grey : LogdCodes.uiMagenta,
                          fontFamily: LogdCodes.retroFont,
                          fontSize: LogdCodes.fontSizeDefault,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
            ),
            const SizedBox(height: 10),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.grey : LogdCodes.uiMagenta, width: 2),
                backgroundColor: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.black12 : const Color(0xFF240024),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => _buyPotion(false),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                      local.btnBuyDefPotion.toUpperCase(),
                      style: TextStyle(
                          color: elixirsBoughtToday >= _maxPotionsPerDay ? Colors.grey : LogdCodes.uiMagenta,
                          fontFamily: LogdCodes.retroFont,
                          fontSize: LogdCodes.fontSizeDefault,
                          fontWeight: FontWeight.bold
                      )
                  )
              ),
            ),
            const SizedBox(height: 16),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                    local.btnReturnTown.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: LogdCodes.retroFont,
                        fontSize: LogdCodes.fontSizeDefault,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
