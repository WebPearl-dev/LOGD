// lib/screens/inn_screen.dart - DEEL 1
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../theme/logd_codes.dart';
import '../services/inn_controller.dart';
import '../services/logd_enums.dart';

class InnScreen extends StatefulWidget {
  const InnScreen({super.key});

  @override
  State<InnScreen> createState() => _InnScreenState();
}

class _InnScreenState extends State<InnScreen> {
final InnController _controller = InnController();
final int _wagerAmount = 50;

@override
void initState() {
super.initState();
_controller.initInn(() {
if (mounted) {
setState(() {});
}
});
}

void _onRollPressed() {
final local = AppLocalizations.of(context)!;

_controller.playDice(_wagerAmount, (status, pRoll, eRoll) {
setState(() {
if (_controller.statusMessage == "NO_GOLD") {
_controller.statusMessage = local.innErrorNoGold;
return;
}

if (status == CombatStatus.skillMagic) {
_controller.statusMessage = local.innDiceVictory(pRoll.toString(), eRoll.toString(), _wagerAmount.toString());
} else if (status == CombatStatus.playerDied) {
String message = local.innDiceDefeat(pRoll.toString(), eRoll.toString(), _wagerAmount.toString());
if (message.startsWith('`4')) {
message = LogdCodes.colorLoss + message.substring(2);
}
_controller.statusMessage = message;
} else {
_controller.statusMessage = local.innDiceTie(pRoll.toString());
}
});
});
}

void _onFlirtPressed() {
final local = AppLocalizations.of(context)!;
final bool hasGems = _controller.flirtWithViolet();

setState(() {
if (!hasGems) {
_controller.statusMessage = local.innFlirtNoGems;
} else if (_controller.statusMessage == "FLIRT_SUCCESS") {
_controller.statusMessage = local.innFlirtSuccess;
} else {
_controller.statusMessage = local.innFlirtFail;
}
});
}

void _onTalkCedrikPressed() {
final local = AppLocalizations.of(context)!;
final String rumorKey = _controller.getCedrikRumor();

setState(() {
if (rumorKey == "RUMOR_1") {
_controller.statusMessage = local.innCedrikRumor1;
} else {
_controller.statusMessage = local.innCedrikRumor2;
}
});
}
// lib/screens/inn_screen.dart - DEEL 2
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    if (_controller.isLoading) {
      return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: Colors.green)));
    }

    return DefaultTabController(
      length: 3, // Drie tabbladen voor de NPC's en Goktafel
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        appBar: AppBar(
          title: Text(local.innTitle, style: const TextStyle(fontFamily: 'Courier')),
          backgroundColor: const Color(0xFF2D2D2D),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            labelColor: Colors.yellowAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: local.innMenuGamble.toUpperCase()),
              Tab(text: local.innMenuBartender.toUpperCase()),
              Tab(text: local.innMenuFlirt.toUpperCase()),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Bovenste gedeelte: Welkomstekst en live statusberichten
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogdText(text: local.innWelcome, fontSize: LogdCodes.fontSizeDefault),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Divider(color: Colors.grey)),

                      if (_controller.statusMessage.isNotEmpty) ...[
                        LogdText(text: _controller.statusMessage, fontSize: LogdCodes.fontSizeDefault),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),

              // TabBarView Content (Goktafel vs Barman vs Violet)
              SizedBox(
                height: 180,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(), // Houdt scrollen binnen de tabs strak
                  children: [
                    // TAB 1: GOKTAFEL
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(color: const Color(0xFF262626), border: Border.all(color: Colors.grey.shade800), borderRadius: BorderRadius.circular(4.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LogdText(text: "${LogdCodes.colorGold}${local.innDiceTitle}${LogdCodes.white}", fontSize: LogdCodes.fontSizeCardTitle),
                          LogdText(text: local.innDiceDesc, fontSize: 13),
                          LogdText(text: local.smithyCostLabel(_wagerAmount.toString()), fontSize: 13),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.yellow, width: 2), backgroundColor: const Color(0xFF1E1E00)),
                              onPressed: _onRollPressed,
                              child: Text(local.btnInnRoll.toUpperCase(), style: const TextStyle(color: Colors.yellowAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),

                    // TAB 2: BARMAN CEDRIK
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(color: const Color(0xFF262626), border: Border.all(color: Colors.grey.shade800), borderRadius: BorderRadius.circular(4.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LogdText(text: "${LogdCodes.colorGold}${local.innMenuBartender}${LogdCodes.white}", fontSize: LogdCodes.fontSizeCardTitle),
                          const LogdText(text: "Cedrik knikt naar je en droogt een bierpul met zijn schort. 'Op zoek naar sterke verhalen of een goed gerucht?'", fontSize: 13),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.orange, width: 2), backgroundColor: const Color(0xFF241400)),
                              onPressed: _onTalkCedrikPressed,
                              child: Text(local.innTalkCedrik.toUpperCase(), style: const TextStyle(color: Colors.orangeAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),

                    // TAB 3: BARMEID VIOLET (FLIRTSYSTEEM)
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(color: const Color(0xFF262626), border: Border.all(color: Colors.grey.shade800), borderRadius: BorderRadius.circular(4.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LogdText(text: "${LogdCodes.colorGold}${local.innMenuFlirt}${LogdCodes.white}", fontSize: LogdCodes.fontSizeCardTitle),
                          const LogdText(text: "Violet glimlacht charmant. Ze houdt van glimmende edelstenen. Durf jij een gokje te wagen met een compliment?", fontSize: 13),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.purple, width: 2), backgroundColor: const Color(0xFF1A0022)),
                              onPressed: _onFlirtPressed,
                              child: Text(local.innFlirtAttempt.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

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
            currentHp: _controller.playerHp,
            maxHp: _controller.playerMaxHp,
            goldOnHand: _controller.goldOnHand,
            gems: _controller.gems,
            turns: _controller.turns,
            level: _controller.level,
            experience: _controller.experience
        ),
      ),
    );
  }
}
