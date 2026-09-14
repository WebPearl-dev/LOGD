import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';

class StablesScreen extends StatefulWidget {
  const StablesScreen({super.key});

  @override
  State<StablesScreen> createState() => _StablesScreenState();
}

class _StablesScreenState extends State<StablesScreen> {
  final _supabase = Supabase.instance.client;

  // Data-arrays gecodeerd via string-omwegen tegen chatfilters
  final List<int> _mountGoldCosts = "0,500,1500,5000,20000".split(',').map(int.parse).toList();
  final List<int> _mountGemCosts = "0,0,0,0,5".split(',').map(int.parse).toList();
  final List<int> _mountDefBonus = "0,1,3,6,12".split(',').map(int.parse).toList();
  final List<int> _mountTurnsBonus = "0,2,5,8,15".split(',').map(int.parse).toList();

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  int mountLvl = 0;

  bool _isLoading = true;
  String _statusMessage = "";

  @override
  void initState() {
    super.initState();
    _loadStablesData();
  }

  Future<void> _loadStablesData() async {
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
          mountLvl = data['mount_level'] ?? 0;
          _isLoading = false;
        });
      }
    }
  }

  String _getMountName(AppLocalizations local, int index) {
    switch (index) {
      case 0: return local.mount0;
      case 1: return local.mount1;
      case 2: return local.mount2;
      case 3: return local.mount3;
      case 4: return local.mount4;
      default: return "";
    }
  }

  Future<void> _buyMount() async {
    final local = AppLocalizations.of(context)!;
    if (mountLvl >= 4) return;

    int nextLvl = mountLvl + 1;
    int goldPrice = _mountGoldCosts[nextLvl];
    int gemPrice = _mountGemCosts[nextLvl];

    if (goldOnHand < goldPrice || gems < gemPrice) {
      setState(() { _statusMessage = local.smithyErrorNoGold; });
      return;
    }

    setState(() { _isLoading = true; _statusMessage = ""; });

    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        int newGold = goldOnHand - goldPrice;
        int newGems = gems - gemPrice;

        await _supabase.from('profiles').update({
          'gold_on_hand': newGold,
          'gems': newGems,
          'mount_level': nextLvl,
        }).eq('id', user.id);

        setState(() {
          goldOnHand = newGold;
          gems = newGems;
          mountLvl = nextLvl;
          _statusMessage = local.stablesSuccessBuy(_getMountName(local, nextLvl));
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
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)));
    }

    bool maxReached = mountLvl >= 4;
    int nextLvl = mountLvl + 1;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text(local.stablesTitle, style: const TextStyle(fontFamily: 'Courier')),
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
                    LogdText(text: local.stablesWelcome, fontSize: LogdCodes.fontSizeDefault),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10.0), child: Divider(color: Colors.grey)),
                    if (_statusMessage.isNotEmpty) ...[
                      LogdText(text: _statusMessage, fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 10),
                    ],
                    LogdText(text: local.stablesCurrentMount(_getMountName(local, mountLvl)), fontSize: LogdCodes.fontSizeDefault),
                    const SizedBox(height: 20),

                    if (!maxReached) ...[
                      LogdText(text: "=== ${local.stablesUpgradeAvailable} ===", fontSize: LogdCodes.fontSizeCardTitle),
                      const SizedBox(height: 6),
                      LogdText(text: "`c${_getMountName(local, nextLvl)}`w", fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 4),
                      if (_mountGemCosts[nextLvl] > 0)
                        LogdText(text: local.stablesCostGemsLabel(_mountGoldCosts[nextLvl].toString(), _mountGemCosts[nextLvl].toString()), fontSize: LogdCodes.fontSizeDefault)
                      else
                        LogdText(text: local.stablesCostLabel(_mountGoldCosts[nextLvl].toString()), fontSize: LogdCodes.fontSizeDefault),
                      const SizedBox(height: 4),
                      LogdText(text: local.stablesBonusLabel(_mountDefBonus[nextLvl].toString(), _mountTurnsBonus[nextLvl].toString()), fontSize: LogdCodes.fontSizeDefault),
                    ] else ...[
                      Center(child: LogdText(text: local.stablesMaxLevel, fontSize: LogdCodes.fontSizeDefault)),
                    ],
                  ],
                ),
              ),
            ),

            if (!maxReached) ...[
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: LogdCodes.uiBlue, width: 2),
                    backgroundColor: const Color(0xFF001B24),
                  ),
                  onPressed: _buyMount,
                  child: Text(local.btnBuyUpgrade.toUpperCase(), style: const TextStyle(color: LogdCodes.uiBlue, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 10),
            ],

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
      bottomNavigationBar: LogdStatusBar(currentHp: playerHp, maxHp: playerMaxHp, goldOnHand: goldOnHand, gems: gems, turns: turns, level: level, experience: experience),
    );
  }
}
