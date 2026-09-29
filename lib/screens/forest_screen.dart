// lib/screens/forest_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Map<String, dynamic> _storyContent = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initForest();
      }
    });
  }

  Future<void> _initForest() async {
    try {
      final String lang = Localizations.localeOf(context).languageCode;
      final String langCode = (lang == 'nl') ? 'nl' : 'en';

      await _controller.initGame(() {});
      
      final String jsonPath = 'assets/story/$langCode/locatie_bos.json';
      final String jsonString = await rootBundle.loadString(jsonPath);
      _storyContent = jsonDecode(jsonString);

      if (mounted) {
        setState(() {
          _isLoading = false;
          _startEncounter();
        });
      }
    } catch (e) {
      debugPrint("Fout bij initialiseren bos: $e");
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _toSnakeCase(String name) {
    return name.replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(0)!.toLowerCase()}');
  }

  String _getEnemyName() {
    final String key = _controller.currentEnemy?.name ?? "monster";
    return _storyContent['${key}_name'] ?? key;
  }

  String _getEnemyAtk() {
    final String key = _controller.currentEnemy?.name ?? "monster";
    return _storyContent['${key}_atk'] ?? "...";
  }

  void _startEncounter() {
    if (widget.forcedEvent != ForestEventType.none) {
      _controller.activeEvent = widget.forcedEvent;
      _controller.currentEnemy = null;
      _controller.updateCloudStats();
    } else {
      _controller.startEncounter(
        _storyContent['no_turns'] ?? "Je hebt geen beurten meer over!",
        "", "", "",
      );
    }

    if (_controller.activeEvent != ForestEventType.none) {
      final String eventId = _toSnakeCase(_controller.activeEvent.name);
      _controller.combatLog = _storyContent['${eventId}_desc'] ?? "...";
    } else if (_controller.currentEnemy != null) {
      final String enemyName = _getEnemyName();
      final String template = _storyContent['encounter_start'] ?? "Je komt oog in oog te staan met {enemy}!";
      _controller.combatLog = template.contains('{enemy}') 
          ? template.replaceAll('{enemy}', enemyName) 
          : template;
    }
  }

  void _onAttackPressed() {
    final String enemyName = _getEnemyName();
    final String attackText = _getEnemyAtk();

    setState(() {
      _controller.handleAttack(
        (res) {
          final String template = _storyContent['enemy_defeated'] ?? "Je hebt de {enemy} verslagen! Je verdient {gold} goud en {xp} ervaring!";
          String msg = template
              .replaceAll('{enemy}', enemyName)
              .replaceAll('{gold}', res.goldEarned.toString())
              .replaceAll('{xp}', res.xpEarned.toString());
          _controller.combatLog += "\n\n$msg\n\n";
        },
        () {
          final String template = _storyContent['player_died'] ?? "Je bent bezweken aan je verwondingen door de {enemy}...";
          String msg = template.replaceAll('{enemy}', enemyName);
          _controller.combatLog += "\n\n$msg\n\n";
        },
        (res) {
          final String template = _storyContent['round_continue'] ?? "Je valt aan en doet {damageDealt} schade. De {enemy} {attackText} en doet {damageReceived} schade terug!";
          String msg = template
              .replaceAll('{enemy}', enemyName)
              .replaceAll('{damageDealt}', res.damageDealt.toString())
              .replaceAll('{damageReceived}', res.damageReceived.toString())
              .replaceAll('{attackText}', attackText);
          _controller.combatLog += "\n\n$msg";
        },
      );
    });
  }

  void _onUseSkillPressed() {
    final String enemyName = _getEnemyName();

    if (_controller.activeEvent != ForestEventType.none) return;

    if (_controller.skillUsedThisFight) {
      setState(() { 
        _controller.combatLog += "\n\n${_storyContent['skill_already_used'] ?? "Je hebt je vaardigheid al gebruikt!"}\n\n"; 
      });
      return;
    }

    setState(() {
      _controller.handleSkill((res) {
        String log = "";
        if (res.status == CombatStatus.skillMagic) {
          final String key = res.args['log_key'] ?? 'skill_magic';
          final String template = _storyContent[key] ?? _storyContent['skill_magic'] ?? "Je geneest {amount} HP.";
          log = template.replaceAll('{amount}', res.hpHealed.toString());
        } else if (res.status == CombatStatus.skillThieving) {
          final String key = res.args['log_key'] ?? 'skill_thieving';
          final String template = _storyContent[key] ?? _storyContent['skill_thieving'] ?? "Je rooft {amount} goud van de {enemy}.";
          log = template.replaceAll('{amount}', res.goldEarned.toString());
        } else if (res.status == CombatStatus.skillWarrior) {
          final String key = res.args['log_key'] ?? 'skill_warrior';
          final String template = _storyContent[key] ?? _storyContent['skill_warrior'] ?? "Je voert een beuk uit voor {amount} schade.";
          log = template.replaceAll('{amount}', res.damageDealt.toString());
        }
        if (log.contains('{enemy}')) {
          log = log.replaceAll('{enemy}', enemyName);
        }
        if (log.contains('[Monster_Naam]')) {
          log = log.replaceAll('[Monster_Naam]', enemyName);
        }
        _controller.combatLog += "\n\n$log\n\n";
      });
    });
  }

  void _onFleePressed() {
    final String enemyName = _getEnemyName();

    setState(() {
      _controller.handleFlee(
        () {
          final String template = _storyContent['flee_success'] ?? "Je bent ontsnapt aan de {enemy}!";
          _controller.combatLog += "\n\n${template.replaceAll('{enemy}', enemyName)}";
        },
        (dmg) {
          final String template = _storyContent['flee_failed'] ?? "Vluchten mislukt! De {enemy} doet {damage} schade.";
          _controller.combatLog += "\n\n${template.replaceAll('{enemy}', enemyName).replaceAll('{damage}', dmg.toString())}";
        },
        () {
          final String template = _storyContent['flee_death'] ?? "Je bent bezweken tijdens het vluchten...";
          _controller.combatLog += "\n\n${template.replaceAll('{enemy}', enemyName)}";
        },
      );
    });
  }

  void _onEventChoiceSelected(String choice) {
    setState(() {
      _controller.handleChoice(choice, (result) {
        String log = _storyContent[result.logKey] ?? "...";
        log = log.replaceAll('{amount}', (result.goldGained.abs() + result.hpLost.abs() + result.xpGained.abs() + result.turnsGained.abs() + result.turnsLost.abs()).toString());
        log = log.replaceAll('{gold}', result.goldGained.abs().toString());
        log = log.replaceAll('{gems}', result.gemsGained.abs().toString());
        
        _controller.combatLog += "\n\n$log";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_isLoading) { return const Scaffold(backgroundColor: LogdCodes.uiBlueBg, body: Center(child: CircularProgressIndicator(color: Colors.green))); }

    String titleText = local.forestTitle;
    if (_controller.activeEvent != ForestEventType.none) {
      final String eventId = _toSnakeCase(_controller.activeEvent.name);
      titleText = "=== ${_storyContent['${eventId}_title']?.toUpperCase() ?? eventId.toUpperCase()} ===";
    }

    final String enemyName = _getEnemyName();
    String cleanEnemyName = enemyName.isNotEmpty
        ? enemyName.substring(0, 1).toUpperCase() + enemyName.substring(1)
        : "";

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
          title: Text(
              titleText,
              style: const TextStyle(
                  fontFamily: LogdCodes.retroFont,
                  fontSize: LogdCodes.fontSizeDefault,
                  fontWeight: FontWeight.bold
              )
          ),
          backgroundColor: LogdCodes.uiAppBarBg,
          automaticallyImplyLeading: false
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_controller.currentEnemy != null && !_controller.isCombatOver) ...[
              LogdText(
                text: (_storyContent['enemy_hp'] ?? "{enemy} HP: {current}/{max}")
                    .replaceAll('{enemy}', cleanEnemyName)
                    .replaceAll('{current}', _controller.currentEnemy!.currentHp.toString())
                    .replaceAll('{max}', _controller.currentEnemy!.maxHp.toString()),
                fontSize: LogdCodes.fontSizeDefault,
              ),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
            ],
            if (_controller.activeEvent != ForestEventType.none && !_controller.isCombatOver) ...[
              LogdText(text: titleText, fontSize: LogdCodes.fontSizeCardTitle),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
            ],
            Expanded(child: SingleChildScrollView(child: LogdText(text: _controller.combatLog, fontSize: LogdCodes.fontSizeDefault))),

            ForestActionButtons(
              isCombatOver: _controller.isCombatOver,
              skillUsedThisFight: _controller.skillUsedThisFight,
              specialty: _controller.specialty,
              activeEvent: _controller.activeEvent,
              storyContent: _storyContent,
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
