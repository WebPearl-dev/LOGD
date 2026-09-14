// lib/screens/forest_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/forest_action_buttons.dart';
import '../services/forest_controller.dart';
import '../services/logd_enums.dart';
import '../theme/logd_codes.dart';

class ForestScreen extends StatefulWidget {
  final ForestEventType forcedEvent;

  const ForestScreen({super.key, this.forcedEvent = ForestEventType.none});

  @override
  State<ForestScreen> createState() => _ForestScreenState();
}

class _ForestScreenState extends State<ForestScreen> {
  final ForestController _controller = ForestController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller.initGame(() {
      final local = AppLocalizations.of(context)!;
      setState(() {
        _isLoading = false;

        // De testknop uit het Dev Menu start nu direct de Kluizenaar op!
        if (widget.forcedEvent == ForestEventType.forcedFountain || widget.forcedEvent == ForestEventType.hermit) {
          _controller.activeEvent = ForestEventType.hermit;
          _controller.combatLog = local.eventHermitDesc;
          _controller.currentEnemy = null;
          _controller.updateCloudStats();
        } else if (widget.forcedEvent == ForestEventType.forcedGiant) {
          _controller.activeEvent = ForestEventType.giant;
          _controller.combatLog = local.eventGiantDesc;
          _controller.currentEnemy = null;
          _controller.updateCloudStats();
        } else {
          _controller.startEncounter(
            local.forestNoTurns,
            local.eventFountainDesc,
            local.eventGiantDesc,
            local.combatEncounterStart(_controller.currentEnemy?.name ?? "monster"),
          );

          if (_controller.activeEvent == ForestEventType.hermit) {
            _controller.combatLog = local.eventHermitDesc;
          } else if (_controller.currentEnemy != null) {
            _controller.combatLog = local.combatEncounterStart(_controller.currentEnemy!.name);
          }
        }
      });
    });
  }

  void _onAttackPressed() {
    final local = AppLocalizations.of(context)!;
    final String enemyName = _controller.currentEnemy?.name ?? "monster";

    setState(() {
      _controller.handleAttack(
            (res) {
          _controller.combatLog += "\n\n${local.enemyDefeated(enemyName, res.goldEarned.toString(), res.xpEarned.toString())}\n\n";
        },
            () {
          _controller.combatLog += "\n\n${local.playerDied(enemyName)}\n\n";
        },
            (res) {
          _controller.combatLog += "\n\n${local.roundContinue(_controller.currentEnemy!.attackText, res.damageDealt.toString(), res.damageReceived.toString(), enemyName)}";
        },
      );
    });
  }

  void _onUseSkillPressed() {
    final local = AppLocalizations.of(context)!;
    final String enemyName = _controller.currentEnemy?.name ?? "monster";

    if (_controller.activeEvent != ForestEventType.none) {
      if (_controller.activeEvent == ForestEventType.hermit) {
        _onEventChoiceSelected('drink');
      } else {
        _onEventChoiceSelected(_controller.activeEvent == ForestEventType.fountain ? 'dive' : 'steal');
      }
      return;
    }

    if (_controller.skillUsedThisFight) {
      setState(() { _controller.combatLog += "\n\n${local.skillAlreadyUsed}\n\n"; });
      return;
    }

    setState(() {
      _controller.handleSkill((res) {
        String log = "";
        if (res.status == CombatStatus.skillMagic) log = local.skillMagicSuccess(res.hpHealed.toString());
        if (res.status == CombatStatus.skillThieving) log = local.skillThievingSuccess(res.goldEarned.toString(), enemyName);
        if (res.status == CombatStatus.skillWarrior) log = local.skillWarriorSuccess(res.damageDealt.toString(), enemyName);

        if (res.status == CombatStatus.enemyDefeated) {
          log = local.enemyDefeated(enemyName, res.goldEarned.toString(), res.xpEarned.toString());
        }
        _controller.combatLog += "\n\n$log\n\n";
      });
    });
  }

  void _onFleePressed() {
    final local = AppLocalizations.of(context)!;
    final String enemyName = _controller.currentEnemy?.name ?? "monster";

    setState(() {
      _controller.handleFlee(
            () => _controller.combatLog += "\n\n${local.fleeSuccess(enemyName)}\n\n",
            (dmg) => _controller.combatLog += "\n\n${local.fleeFailed(dmg.toString(), enemyName)}\n\n",
            () => _controller.combatLog += "\n\n${local.fleeFailed(_controller.playerHp.toString(), enemyName)}${local.fleeFailedDeathSuffix}\n\n",
      );
    });
  }

  void _onEventChoiceSelected(String choice) {
    final local = AppLocalizations.of(context)!;
    setState(() {
      _controller.handleChoice(choice, (result) {
        String log = "";
        if (result.logKey == 'eventFountainSuccess') log = local.eventFountainSuccess(result.goldGained.toString());
        if (result.logKey == 'eventFountainFail') log = local.eventFountainFail(result.hpLost.toString());
        if (result.logKey == 'eventFountainLeaveLog') log = local.eventFountainLeaveLog;
        if (result.logKey == 'eventGiantSneakSuccess') log = local.eventGiantSneakSuccess(result.xpGained.toString());
        if (result.logKey == 'eventGiantStealSuccess') log = local.eventGiantStealSuccess(result.goldGained.toString());
        if (result.logKey == 'eventGiantStealFail') log = local.eventGiantStealFail(result.hpLost.toString());

        // DE FIX: Gebruik de bestaande fountain leave log key om arb errors te voorkomen
        if (result.logKey == 'eventHermitSuccess') log = local.eventHermitSuccess;
        if (result.logKey == 'eventHermitLeaveLog') log = local.eventFountainLeaveLog;

        _controller.combatLog += "\n\n$log";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) { return const Scaffold(backgroundColor: Color(0xFF1E1E1E), body: Center(child: CircularProgressIndicator(color: Colors.green))); }

    String titleText = local.forestTitle;
    if (_controller.activeEvent == ForestEventType.fountain) titleText = "=== ${local.eventFountainTitle} ===";
    if (_controller.activeEvent == ForestEventType.giant) titleText = "=== ${local.eventGiantTitle} ===";
    if (_controller.activeEvent == ForestEventType.hermit) titleText = "=== ${local.eventHermitTitle} ===";

    String rawEnemyName = _controller.currentEnemy?.name ?? "";
    String cleanEnemyName = rawEnemyName.isNotEmpty
        ? rawEnemyName.substring(0, 1).toUpperCase() + rawEnemyName.substring(1)
        : "";

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
          title: Text(titleText, style: const TextStyle(fontFamily: 'Courier')),
          backgroundColor: const Color(0xFF2D2D2D),
          automaticallyImplyLeading: false
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.currentEnemy != null && !_controller.isSearching) ...[
              LogdText(text: "HP: ${_controller.currentEnemy!.currentHp}/${_controller.currentEnemy!.maxHp} - $cleanEnemyName", fontSize: 18),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
            ],
            if (_controller.activeEvent != ForestEventType.none && !_controller.isSearching) ...[
              LogdText(text: titleText, fontSize: 18),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
            ],
            Expanded(child: SingleChildScrollView(child: LogdText(text: _controller.combatLog, fontSize: LogdCodes.fontSizeDefault))),

            ForestActionButtons(
              isCombatOver: _controller.isCombatOver,
              skillUsedThisFight: _controller.skillUsedThisFight,
              specialty: _controller.specialty,
              activeEvent: _controller.activeEvent,
              onAttackPressed: _onAttackPressed,
              onUseSkillPressed: _onUseSkillPressed,
              onFleePressed: _onFleePressed,
              onReturnTownPressed: () => Navigator.pop(context),
              onEventChoicePressed: _onEventChoiceSelected,
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
        experience: _controller.experience,
      ),
    );
  }
}
