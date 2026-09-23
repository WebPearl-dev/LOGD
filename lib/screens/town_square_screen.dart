// lib/screens/town_square_screen.dart
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../widgets/town_square_panels.dart';
import '../widgets/town_square_menu_router.dart';
import '../services/town_square_controller.dart';
import '../services/town_square_actions.dart';
import '../theme/logd_codes.dart';
import 'profile_settings_screen.dart';
import 'bank_screen.dart';
import 'smithy_screen.dart';
import 'training_screen.dart';
import 'inn_screen.dart';
import 'stables_screen.dart';
import 'church_screen.dart';
import 'alchemist_screen.dart';
import 'daily_news_screen.dart';
import 'developer_panel_screen.dart';
import 'rankings_screen.dart';
import 'dragon_shrine_screen.dart';

import '../services/new_day_service.dart';
import 'new_day_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/guest_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/logd_tutorial_dialog.dart';

class TownSquareScreen extends StatefulWidget {
  const TownSquareScreen({super.key});

  @override
  State<TownSquareScreen> createState() => _TownSquareScreenState();
}

class _TownSquareScreenState extends State<TownSquareScreen> {
  final TownSquareController _con = TownSquareController();
  String _activeSubLocation = "MAIN";
  String _alleyStatusMessage = "",
      _mightyEStatusMessage = "",
      _weddingStatusMessage = "";
  bool _hasCheckedTutorial = false;

  @override
  void initState() {
    super.initState();
    _con.isLoading = true;
    _refreshData();
    _checkForNewDay();
  }

  void _checkForNewDay() async {
    final result = await NewDayService.checkAndPerformReset();
    if (result.triggered && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewDayScreen(result: result)),
      ).then((_) => _refreshData());
    }
  }

  void _refreshData() {
    _con.loadLiveStats(context, () {
      if (mounted) {
        setState(() {
          _con.isLoading = false;
        });
        _checkAndShowTutorial();
      }
    });
  }

  Future<void> _checkAndShowTutorial() async {
    if (_hasCheckedTutorial) return;
    _hasCheckedTutorial = true;
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeen = prefs.getBool('has_seen_tutorial') ?? false;
    if (!hasSeen && mounted) {
      await prefs.setBool('has_seen_tutorial', true);
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const LogdTutorialDialog(),
        );
      }
    }
  }

  void _onHealPressed(int cost, int maxHp, AppLocalizations local) async {
    bool success = await _con.handleHealerPurchase(cost, maxHp);
    setState(() {
      _con.healerStatusMessage = success
          ? (_con.storyContent['healer_success'] ?? local.healerSuccessFallback)
          : local.smithyErrorNoGold;
    });
    if (success) _refreshData();
  }

  void _onBarberPressed() async {
    bool success = await _con.handleBarberPurchase();
    setState(() {
      _con.barberStatusMessage = success
          ? (_con.barberContent['success'] ?? "...")
          : (_con.barberContent['error_no_gem'] ?? "...");
    });
    if (success) _refreshData();
  }

  void _onBarberCutPressed(int level, AppLocalizations local) async {
    final int cost = level * 50;
    bool success = await _con.handleFreshCutPurchase(cost);
    setState(() {
      _con.barberStatusMessage = success
          ? (_con.barberContent['cut_success'] ?? "...")
          : (_con.barberContent['error_no_gold'] ?? "...");
    });
    if (success) _refreshData();
  }

  void _onBarberShavePressed(int level, int maxHp, AppLocalizations local) async {
    final int cost = level * 20;
    bool success = await _con.handleSmoothShavePurchase(cost, maxHp);
    setState(() {
      _con.barberStatusMessage = success
          ? (_con.barberContent['shave_success'] ?? "...")
          : (_con.barberContent['error_no_gold'] ?? "...");
    });
    if (success) _refreshData();
  }

  void _onBarberDyePressed() async {
    bool success = await _con.handleDyeHairPurchase();
    setState(() {
      _con.barberStatusMessage = success
          ? (_con.barberContent['dye_success'] ?? "...")
          : (_con.barberContent['error_no_gem'] ?? "...");
    });
    if (success) _refreshData();
  }

  void _onAlleyPressed() async {
    final local = AppLocalizations.of(context)!;
    bool success = await _con.handleAlleyPurchase(local);
    setState(() {
      _alleyStatusMessage = _con.alleyStatusMessage;
    });
    if (success) _refreshData();
  }

  void _onMightyEPressed() async {
    final local = AppLocalizations.of(context)!;
    bool success = await _con.handleMightyEPurchase(local);
    setState(() {
      _mightyEStatusMessage = success
          ? (_con.storyContent['mightye_success'] ?? "...")
          : (_con.barberContent['error_no_gem'] ?? "...");
    });
    if (success) _refreshData();
  }

  void _onWeddingPressed(AppLocalizations local) async {
    int res = await _con.handleWeddingPurchase(local);
    setState(() {
      if (res == 0) {
        _weddingStatusMessage = _con.storyContent['wedding_success'] ?? "...";
      }
      if (res == 1) {
        _weddingStatusMessage =
            _con.storyContent['wedding_error_married'] ?? "...";
      }
      if (res == 2) {
        _weddingStatusMessage =
            _con.storyContent['wedding_error_no_gold'] ?? "...";
      }
      if (res == 3) {
        _weddingStatusMessage = local.smithyErrorUnknown;
      }
    });
    if (res == 0) _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    if (_con.isLoading) {
      return const Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    final currentHp = _con.playerData?['hp'] ?? 20,
        maxHp = _con.playerData?['max_hp'] ?? 20;
    final goldOnHand = _con.playerData?['gold_on_hand'] ?? 0,
        gems = _con.playerData?['gems'] ?? 0,
        turns = _con.playerData?['turns'] ?? 0;
    final level = _con.playerData?['level'] ?? 1,
        experience = _con.playerData?['experience'] ?? 0,
        username = _con.playerData?['username'] ?? local.defaultUsername,
        isMarried = _con.playerData?['is_married'] ?? false,
        bounty = _con.playerData?['bounty'] ?? 0;
    final bool isPanelActive =
        _activeSubLocation == "HEALER" ||
        _activeSubLocation == "BARBER" ||
        _activeSubLocation == "ALLEY" ||
        _activeSubLocation == "MIGHTYE" ||
        _activeSubLocation == "WEDDING";

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, res) {
        if (!didPop && _activeSubLocation != "MAIN") {
          setState(() {
            _activeSubLocation = "MAIN";
            _alleyStatusMessage = "";
            _mightyEStatusMessage = "";
            _weddingStatusMessage = "";
          });
        }
      },

      child: Scaffold(
        backgroundColor: LogdCodes.uiBlueBg,
        appBar: AppBar(
          title: Text(
            _activeSubLocation == "MAIN"
                ? TownSquareController.cleanColorCodesOnly(username)
                : _activeSubLocation == "BARBER"
                ? local.town_sub_barber.toUpperCase()
                : _activeSubLocation == "HEALER"
                ? local.town_sub_healer.toUpperCase()
                : _activeSubLocation == "ALLEY"
                ? local.town_sub_alley.toUpperCase()
                : _activeSubLocation == "MIGHTYE"
                ? local.town_sub_mightye.toUpperCase()
                : _activeSubLocation == "WEDDING"
                ? local.town_sub_wedding.toUpperCase()
                : _activeSubLocation == "SUB_SHOPS"
                ? local.town_btn_shops.toUpperCase()
                : _activeSubLocation == "SUB_MYSTERY"
                ? local.town_btn_mystery.toUpperCase()
                : _activeSubLocation == "SUB_TRAINING"
                ? local.town_btn_training.toUpperCase()
                : _activeSubLocation == "SUB_TOWN"
                ? local.town_btn_heart.toUpperCase()
                : "=== ${_activeSubLocation.replaceAll('SUB_', '')} ===",
            style: const TextStyle(
              fontFamily: LogdCodes.retroFont,
              fontSize: LogdCodes.fontSizeCardTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: LogdCodes.uiAppBarBg,
          automaticallyImplyLeading: false,
          actions: [
            if (!GuestManager.isGuest && (_con.playerData?['is_admin'] == true || Supabase.instance.client.auth.currentUser?.email == 'samhaoir@live.nl'))
              IconButton(
                icon: const Icon(Icons.code, color: Colors.purpleAccent),
                onPressed: () => _navigateTo(const DeveloperPanelScreen()),
              ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.grey),
              onPressed: () => _navigateTo(const ProfileSettingsScreen()),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: isPanelActive
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // DE DORPSOMROEPER: Toont het allerlaatste nieuws als een schreeuw op het plein!
                              if (_con.latestNewsItem != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha(20),
                                    border: Border.all(color: Colors.redAccent, width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: LogdText(
                                    text: "${local.townCrierPrefix}${_con.parseNewsItem(local, _con.latestNewsItem!)}",
                                    fontSize: LogdCodes.fontSizeDefault - 1,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],

                              LogdText(
                                text: _con.storyContent['welcome'] ?? "",
                                fontSize: LogdCodes.fontSizeDefault,
                              ),

                              if (bounty > 0) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.redAccent, width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: LogdText(
                                    text: _con.storyContent['guard_warning'] ?? "",
                                    fontSize: LogdCodes.fontSizeDefault - 1,
                                  ),
                                ),
                              ],
                            ],
                          ),
                  ),
                ),
              ),
              if (isPanelActive)
                Expanded(
                  flex: 12,
                  child: TownSquarePanels(
                    activeSubLocation: _activeSubLocation,
                    playerData: _con.playerData,
                    // DE FIX: Geef de cloud-data live door aan de panels!
                    storyContent: _con.storyContent,
                    barberContent: _con.barberContent,
                    healerStatusMessage: _con.healerStatusMessage,
                    barberStatusMessage: _con.barberStatusMessage,
                    alleyStatusMessage: _alleyStatusMessage,
                    mightyEStatusMessage: _mightyEStatusMessage,
                    weddingStatusMessage: _weddingStatusMessage,
                    currentHp: currentHp,
                    maxHp: maxHp,
                    gems: gems,
                    level: level,
                    isMarried: isMarried,
                    onHealPressed: () =>
                        _onHealPressed(level * 20, maxHp, local),
                    onBarberPressed: _onBarberPressed,
                    onBarberCutPressed: () => _onBarberCutPressed(level, local),
                    onBarberShavePressed: () => _onBarberShavePressed(level, maxHp, local),
                    onBarberDyePressed: _onBarberDyePressed,
                    onAlleyPressed: _onAlleyPressed,
                    onMightyEPressed: _onMightyEPressed,
                    onWeddingPressed: () => _onWeddingPressed(local),
                    onLeavePressed: () => setState(() {
                      _activeSubLocation = "MAIN";
                    }),
                  ),
                )
              else
                TownSquareMenuRouter(
                  activeSubLocation: _activeSubLocation,
                  onForestPressed: () => TownSquareActions.navigateToForest(
                    context,
                    currentHp,
                    local,
                    _navigateTo,
                  ),
                  onNewsPressed: () => _navigateTo(const DailyNewsScreen()),
                  onSubMenuPressed: (m) =>
                      setState(() => _activeSubLocation = m),
                  onSmithyPressed: () => _navigateTo(const SmithyScreen()),
                  onBankPressed: () => _navigateTo(const BankScreen()),
                  onBarberPressed: () => setState(() {
                    _activeSubLocation = "BARBER";
                  }),
                  onAlchemistPressed: () =>
                      _navigateTo(const AlchemistScreen()),
                  onHealerPressed: () => setState(() {
                    _activeSubLocation = "HEALER";
                  }),
                  onAlleyPressed: () => setState(() {
                    _activeSubLocation = "ALLEY";
                  }),
                  onTrainingPressed: () => _navigateTo(const TrainingScreen()),
                  onStablesPressed: () => _navigateTo(const StablesScreen()),
                  onInnPressed: () => _navigateTo(const InnScreen()),
                  onChurchPressed: () {
                    final int bounty = _con.playerData?['bounty'] ?? 0;
                    if (bounty > 0) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: LogdCodes.uiCardBg,
                          title: Text(local.dialogGuardHaltTitle.toUpperCase(), style: const TextStyle(color: LogdCodes.uiRed, fontWeight: FontWeight.bold, fontFamily: LogdCodes.retroFont)),
                          content: LogdText(text: _con.storyContent['guard_block_church'] ?? ""),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: Text(local.btnOk, style: const TextStyle(color: Colors.grey))),
                          ],
                        ),
                      );
                    } else {
                      _navigateTo(const ChurchScreen());
                    }
                  },
                  onWeddingPressed: () => setState(() {
                    _activeSubLocation = "WEDDING";
                  }),
                  onTownfolkPressed: () => TownSquareActions.showRumorDialog(
                    context,
                    local,
                    _con.getRandomRumor(local.townSquareRumorFallback),
                  ),
                  onMightyEPressed: () => setState(() {
                    _activeSubLocation = "MIGHTYE";
                  }),
                  onRankingsPressed: () => _navigateTo(const RankingsScreen()),
                  onDragonShrinePressed: () => _navigateTo(const DragonShrineScreen()),
                ),
              if (_activeSubLocation != "MAIN" && !isPanelActive) ...[
                const SizedBox(height: 10),
                OutlinedButton(
                  style:
                      OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: LogdCodes.uiBlueDark,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        backgroundColor: LogdCodes.uiBlueBg,
                      ).copyWith(
                        foregroundColor: WidgetStateProperty.all<Color>(
                          LogdCodes.uiBlueDark,
                        ),
                      ),
                  onPressed: () {
                    setState(() {
                      _activeSubLocation = "MAIN";
                      _alleyStatusMessage = "";
                      _mightyEStatusMessage = "";
                      _weddingStatusMessage = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        local.btnReturnTown.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: LogdCodes.retroFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 6),
            ],
          ),
        ),
        bottomNavigationBar: LogdStatusBar(
          currentHp: currentHp,
          maxHp: maxHp,
          goldOnHand: goldOnHand,
          gems: gems,
          turns: turns,
          level: level,
          experience: experience,
        ),
      ),
    );
  }

  void _navigateTo(Widget s) {
    Navigator.push(context, MaterialPageRoute(builder: (c) => s)).then((_) {
      if (mounted) {
        setState(() {
          _con.isLoading = true;
        });
        _refreshData();
      }
    });
  }
}
