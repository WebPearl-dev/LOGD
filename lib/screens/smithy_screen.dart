// lib/screens/smithy_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/smithy_tab_content.dart';
import '../theme/logd_codes.dart';

class SmithyScreen extends StatefulWidget {
  const SmithyScreen({super.key});

  @override
  State<SmithyScreen> createState() => _SmithyScreenState();
}

class _SmithyScreenState extends State<SmithyScreen> {
  final _supabase = Supabase.instance.client;

  final List<int> _weaponCosts = "0,150,400,1000,3000,9000,25000,60000,100000".split(',').map(int.parse).toList();
  final List<int> _armorCosts = "0,120,350,900,2500,7500,20000,50000,85000".split(',').map(int.parse).toList();

  int goldOnHand = 0, weaponLvl = 0, armorLvl = 0;
  int playerHp = 20, playerMaxHp = 20, gems = 0, turns = 0, level = 1, experience = 0;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadSmithyData();
  }

  Future<void> _loadSmithyData() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      if (mounted) {
        setState(() {
          goldOnHand = data['gold_on_hand'] ?? 0;
          weaponLvl = (data['weapon_level'] ?? 1) - 1;
          armorLvl = (data['armor_level'] ?? 1) - 1;
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

  String _getWeaponName(AppLocalizations local, int index) {
    switch (index) {
      case 0: return local.wep0; case 1: return local.wep1; case 2: return local.wep2;
      case 3: return local.wep3; case 4: return local.wep4; case 5: return local.wep5;
      case 6: return local.wep6; case 7: return local.wep7; case 8: return local.wep8;
      default: return "";
    }
  }

  String _getArmorName(AppLocalizations local, int index) {
    switch (index) {
      case 0: return local.arm0; case 1: return local.arm1; case 2: return local.arm2;
      case 3: return local.arm3; case 4: return local.arm4; case 5: return local.arm5;
      case 6: return local.arm6; case 7: return local.arm7; case 8: return local.arm8;
      default: return "";
    }
  }

  Future<void> _buyUpgrade(bool isWeapon) async {
    final local = AppLocalizations.of(context)!;
    int currentLvl = isWeapon ? weaponLvl : armorLvl;
    List<int> costList = isWeapon ? _weaponCosts : _armorCosts;

    if (currentLvl >= 8) return;

    int currentCost = costList[currentLvl];
    int nextCost = costList[currentLvl + 1];
    int priceToPay = nextCost - currentCost;

    if (goldOnHand < priceToPay) {
      setState(() { _statusMessage = local.smithyErrorNoGold; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        int newGold = goldOnHand - priceToPay;
        int newLvl = currentLvl + 1;

        // DE FIX: De .eq() parameter-syntax is hersteld naar de juiste SDK-notatie
        await _supabase.from('profiles').update({
          'gold_on_hand': newGold,
          isWeapon ? 'weapon_level' : 'armor_level': newLvl + 1,
        }).eq('id', user.id);

        setState(() {
          goldOnHand = newGold;
          if (isWeapon) { weaponLvl = newLvl; } else { armorLvl = newLvl; }
          _statusMessage = local.smithySuccessBuy(isWeapon ? _getWeaponName(local, newLvl) : _getArmorName(local, newLvl));
        });
      }
    } catch (_) {
      setState(() { _statusMessage = local.smithyErrorUnknown; });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    int nextWeaponCost = (weaponLvl < 8) ? _weaponCosts[weaponLvl + 1] - _weaponCosts[weaponLvl] : 0;
    int nextArmorCost = (armorLvl < 8) ? _armorCosts[armorLvl + 1] - _armorCosts[armorLvl] : 0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(local.smithyTitle, style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF111111),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault),
            tabs: [
              Tab(text: local.smithyTabWeapons.toUpperCase()),
              Tab(text: local.smithyTabArmor.toUpperCase()),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LogdText(text: local.smithyWelcome, fontSize: LogdCodes.fontSizeDefault),
              const SizedBox(height: 10),
              if (_statusMessage.isNotEmpty) ...[
                LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                const SizedBox(height: 10),
              ],
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),

              Expanded(
                child: TabBarView(
                  children: [
                    SmithyTabContent(
                      currentLabel: local.smithyWeaponLabel(_getWeaponName(local, weaponLvl), (weaponLvl + 1).toString()),
                      maxReached: weaponLvl >= 8,
                      nextName: weaponLvl < 8 ? _getWeaponName(local, weaponLvl + 1) : "",
                      cost: nextWeaponCost,
                      isWeapon: true,
                      onBuyUpgrade: () => _buyUpgrade(true),
                    ),
                    SmithyTabContent(
                      currentLabel: local.smithyArmorLabel(_getArmorName(local, armorLvl), (armorLvl + 1).toString()),
                      maxReached: armorLvl >= 8,
                      nextName: armorLvl < 8 ? _getArmorName(local, armorLvl + 1) : "",
                      cost: nextArmorCost,
                      isWeapon: false,
                      onBuyUpgrade: () => _buyUpgrade(false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                ),
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: Colors.blueAccent, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
      ),
    );
  }
}
