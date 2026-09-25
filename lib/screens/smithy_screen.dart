// lib/screens/smithy_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/smithy_tab_content.dart';
import '../theme/logd_codes.dart';
import '../services/shop_controller.dart';

class SmithyScreen extends StatefulWidget {
  const SmithyScreen({super.key});

  @override
  State<SmithyScreen> createState() => _SmithyScreenState();
}

class _SmithyScreenState extends State<SmithyScreen> {
  final ShopController _con = ShopController();
  String _displayLog = "";
  bool _isInitLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initShops();
      }
    });
  }

  Future<void> _initShops() async {
    try {
      await _con.loadShopStats(context);
      if (mounted) {
        setState(() {
          _displayLog = _con.storyContent['pegasus_welcome'] ?? "";
          _isInitLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Fout bij laden winkels: $e");
      if (mounted) {
        setState(() => _isInitLoading = false);
      }
    }
  }

  void _handlePurchase(bool isWeapon) async {
    final String? resultKey = await _con.purchaseUpgrade(isWeapon);
    if (mounted && resultKey != null) {
      setState(() {
        _displayLog = _con.storyContent[resultKey] ?? resultKey;
      });
    }
  }

  void _talkToNPC(bool isPegasus) {
    setState(() {
      final String key = _con.getRandomTalkKey(isPegasus);
      _displayLog = _con.storyContent[key] ?? "...";
    });
  }

  String _getShopItemName(AppLocalizations local, String key) {
    switch (key) {
      case "wep0": return local.wep0; case "wep1": return local.wep1; case "wep2": return local.wep2;
      case "wep3": return local.wep3; case "wep4": return local.wep4; case "wep5": return local.wep5;
      case "wep6": return local.wep6; case "wep7": return local.wep7; case "wep8": return local.wep8;
      case "wep9": return local.wep9; case "wep10": return local.wep10; case "wep11": return local.wep11;
      case "wep12": return local.wep12; case "wep13": return local.wep13; case "wep14": return local.wep14;
      case "wep15": return local.wep15;
      case "arm0": return local.arm0; case "arm1": return local.arm1; case "arm2": return local.arm2;
      case "arm3": return local.arm3; case "arm4": return local.arm4; case "arm5": return local.arm5;
      case "arm6": return local.arm6; case "arm7": return local.arm7; case "arm8": return local.arm8;
      case "arm9": return local.arm9; case "arm10": return local.arm10; case "arm11": return local.arm11;
      case "arm12": return local.arm12; case "arm13": return local.arm13; case "arm14": return local.arm14;
      case "arm15": return local.arm15;
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isInitLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        appBar: AppBar(
          title: Text(local.smithyTitle.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
          backgroundColor: LogdCodes.uiAppBarBg,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: LogdCodes.fontSizeDefault),
            onTap: (index) {
              setState(() {
                _displayLog = index == 0 ? _con.storyContent['pegasus_welcome'] : _con.storyContent['merilon_welcome'];
              });
            },
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
            // Top tekst sectie (Scrollbaar voor lange quotes)
            SizedBox(
              height: 110,
              child: SingleChildScrollView(
                child: LogdText(
                  text: _displayLog.isEmpty ? (_con.storyContent['smithy_welcome'] ?? "") : _displayLog,
                  fontSize: LogdCodes.fontSizeDefault,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),

              Expanded(
                child: TabBarView(
                  children: [
                    // Pegasus Wapens
                    Column(
                      children: [
                        Expanded(
                          child: SmithyTabContent(
                            currentLabel: local.smithyWeaponLabel(_getShopItemName(local, _con.weapons[_con.weaponLvl].nameKey), _con.weaponLvl.toString()),
                            maxReached: _con.weaponLvl >= 15,
                            nextName: _con.weaponLvl < 15 ? _getShopItemName(local, _con.weapons[_con.weaponLvl + 1].nameKey) : "",
                            cost: _con.getPriceToPay(true),
                            isWeapon: true,
                            onBuyUpgrade: () => _handlePurchase(true),
                          ),
                        ),
                        _buildTalkButton(local.btnTalkPegasus, () => _talkToNPC(true)),
                      ],
                    ),
                    // Merilon Harnassen
                    Column(
                      children: [
                        Expanded(
                          child: SmithyTabContent(
                            currentLabel: local.smithyArmorLabel(_getShopItemName(local, _con.armors[_con.armorLvl].nameKey), _con.armorLvl.toString()),
                            maxReached: _con.armorLvl >= 15,
                            nextName: _con.armorLvl < 15 ? _getShopItemName(local, _con.armors[_con.armorLvl + 1].nameKey) : "",
                            cost: _con.getPriceToPay(false),
                            isWeapon: false,
                            onBuyUpgrade: () => _handlePurchase(false),
                          ),
                        ),
                        _buildTalkButton(local.btnTalkMerilon, () => _talkToNPC(false)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  backgroundColor: LogdCodes.uiBlueBg,
                ),
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(color: LogdCodes.uiBlueDark, fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
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
          experience: _con.experience
        ),
      ),
    );
  }

  Widget _buildTalkButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.cyan, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        onPressed: onTap,
        child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.cyanAccent, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
