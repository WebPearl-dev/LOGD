// lib/screens/dragon_shrine_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/dragon_shrine_controller.dart';

class DragonShrineScreen extends StatefulWidget {
  const DragonShrineScreen({super.key});

  @override
  State<DragonShrineScreen> createState() => _DragonShrineScreenState();
}

class _DragonShrineScreenState extends State<DragonShrineScreen> {
  final DragonShrineController _con = DragonShrineController();
  String _displayLog = "";
  bool _isInitLoading = true;

  @override
  void initState() {
    super.initState();
    _initShrine();
  }

  Future<void> _initShrine() async {
    await _con.loadShrineStats(context);
    if (mounted) {
      setState(() {
        _displayLog = _con.storyContent['dragonShrineWelcome'] ?? "";
        _isInitLoading = false;
      });
    }
  }

  void _handleUpgrade(int type) async {
    final String? result = await _con.purchaseUpgrade(type);
    if (mounted && result != null) {
      setState(() {
        _displayLog = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_isInitLoading) {
      return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen)));
    }

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(local.dragonShrineTitle.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontSize: LogdCodes.fontSizeDefault, fontWeight: FontWeight.bold)),
        backgroundColor: LogdCodes.uiAppBarBg,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LogdText(text: local.dragonShrinePoints(_con.dragonPoints.toString()), fontSize: LogdCodes.fontSizeCardTitle),
            const Divider(color: Colors.grey, height: 24),
            Expanded(child: SingleChildScrollView(child: LogdText(text: _displayLog, fontSize: LogdCodes.fontSizeDefault))),
            const SizedBox(height: 16),

            if (_con.dragonPoints > 0) ...[
              // UPGRADES IN RIJEN VAN 2: Veel compacter!
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.8,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildUpgradeBtn(label: "+1 ATK", color: LogdCodes.uiRed, onTap: () => _handleUpgrade(1)),
                  _buildUpgradeBtn(label: "+1 DEF", color: LogdCodes.uiBlue, onTap: () => _handleUpgrade(2)),
                  _buildUpgradeBtn(label: "+5 HP", color: LogdCodes.uiGreen, onTap: () => _handleUpgrade(3)),
                  _buildUpgradeBtn(label: "+1 TURN", color: LogdCodes.uiYellow, onTap: () => _handleUpgrade(4)),
                ],
              ),
              const SizedBox(height: 12),
            ],

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: LogdCodes.uiBlueDark, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                backgroundColor: LogdCodes.uiBlueBg,
              ).copyWith(foregroundColor: WidgetStateProperty.all(LogdCodes.uiBlueDark)),
              onPressed: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(local.btnReturnTown.toUpperCase(), style: const TextStyle(fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold)),
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

  Widget _buildUpgradeBtn({required String label, required Color color, required VoidCallback onTap}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 2),
        backgroundColor: color.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: onTap,
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: color, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }
}
