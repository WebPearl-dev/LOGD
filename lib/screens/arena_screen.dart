// lib/screens/arena_screen.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import '../theme/logd_codes.dart';
import '../widgets/logd_text.dart';
import '../widgets/status_bar.dart';
import '../services/guest_manager.dart';
import '../services/story_service.dart';
import 'direct_messages_screen.dart';

class ArenaScreen extends StatefulWidget {
  const ArenaScreen({super.key});

  @override
  State<ArenaScreen> createState() => _ArenaScreenState();
}

class _ArenaScreenState extends State<ArenaScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _opponents = [];
  bool _isLoading = true;
  Map<String, dynamic> _myProfile = {};
  Map<String, dynamic> _storyContent = {};

  @override
  void initState() {
    super.initState();
    _loadArenaData();
    _loadStoryContent();
  }

  Future<void> _loadStoryContent() async {
    final content = await StoryService.loadLocationContent(context, 'locatie_training');
    if (mounted) {
      setState(() {
        _storyContent = content;
      });
    }
  }

  Future<void> _loadArenaData() async {
    if (GuestManager.isGuest) {
      _myProfile = GuestManager.guestProfile;
      _opponents = [
        {'id': 'dummy1', 'username': 'Bravoura', 'level': 3, 'hp': 40, 'max_hp': 40, 'gold_on_hand': 200, 'honor': 10, 'pvp_wins': 5, 'pvp_losses': 2},
        {'id': 'dummy2', 'username': 'Shadow', 'level': 5, 'hp': 60, 'max_hp': 60, 'gold_on_hand': 500, 'honor': 25, 'pvp_wins': 12, 'pvp_losses': 3},
      ];
      setState(() => _isLoading = false);
      return;
    }

    final user = supabase.auth.currentUser;
    if (user != null) {
      final myRes = await supabase.from('profiles').select().eq('id', user.id).single();
      _myProfile = myRes;

      final oppRes = await supabase
          .from('profiles')
          .select()
          .not('id', 'eq', user.id)
          .order('level', ascending: false)
          .limit(20);
      _opponents = List<Map<String, dynamic>>.from(oppRes);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _challengeOpponent(Map<String, dynamic> opponent) async {
    final local = AppLocalizations.of(context)!;
    final wagerController = TextEditingController(text: "50");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: LogdCodes.uiCardBg,
        title: Text(
          "${local.btnChallenge} ${opponent['username']}",
          style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LogdText(text: "${local.arenaWagerPrompt} (Max: ${_myProfile['gold_on_hand'] ?? 0})"),
            const SizedBox(height: 10),
            TextField(
              controller: wagerController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontFamily: LogdCodes.retroFont),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiBlueDark)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: LogdCodes.uiGreen)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(local.btnCancel, style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              int wager = int.tryParse(wagerController.text) ?? 50;
              int myGold = _myProfile['gold_on_hand'] ?? 0;
              if (wager > myGold) wager = myGold;
              if (wager < 0) wager = 0;
              _executeDuel(opponent, wager);
            },
            child: Text(local.btnChallenge, style: const TextStyle(color: LogdCodes.uiGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _executeDuel(Map<String, dynamic> opponent, int wager) {
    final local = AppLocalizations.of(context)!;
    int myLvl = _myProfile['level'] ?? 1;
    int oppLvl = opponent['level'] ?? 1;
    int myWins = _myProfile['pvp_wins'] ?? 0;
    int oppWins = opponent['pvp_wins'] ?? 0;

    bool iWon = (myLvl + (myWins * 0.1)) >= (oppLvl + (oppWins * 0.1)) || (DateTime.now().millisecond % 2 == 0);

    int goldChange = wager;
    int honorChange = iWon ? 5 : -2;

    setState(() {
      if (iWon) {
        _myProfile['gold_on_hand'] = (_myProfile['gold_on_hand'] ?? 0) + goldChange;
        _myProfile['pvp_wins'] = myWins + 1;
        _myProfile['honor'] = (_myProfile['honor'] ?? 0) + honorChange;
      } else {
        _myProfile['gold_on_hand'] = (_myProfile['gold_on_hand'] ?? 0) - goldChange;
        _myProfile['pvp_losses'] = (_myProfile['pvp_losses'] ?? 0) + 1;
        _myProfile['honor'] = ((_myProfile['honor'] ?? 0) + honorChange).clamp(0, 99999);
      }
    });

    _updateMyStatsInCloud();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: LogdCodes.uiCardBg,
        title: Text(
          local.arenaTitle.toUpperCase(),
          style: TextStyle(
            color: iWon ? LogdCodes.uiGreen : LogdCodes.uiRed,
            fontFamily: LogdCodes.retroFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: LogdText(
          text: iWon
              ? (_storyContent['arena_victory'] ?? "You won the PvP duel and earned {gold} gold and {honor} honor!")
                  .replaceAll('{gold}', goldChange.toString())
                  .replaceAll('{honor}', honorChange.toString())
              : (_storyContent['arena_defeat'] ?? "You were defeated in the PvP duel by {opponent}!")
                  .replaceAll('{opponent}', opponent['username'] ?? 'Rivaal'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadArenaData();
            },
            child: Text(local.btnOk, style: const TextStyle(color: LogdCodes.uiGreen)),
          ),
        ],
      ),
    );
  }

  Future<void> _updateMyStatsInCloud() async {
    if (GuestManager.isGuest) return;
    final user = supabase.auth.currentUser;
    if (user != null) {
      await supabase.from('profiles').update({
        'gold_on_hand': _myProfile['gold_on_hand'],
        'pvp_wins': _myProfile['pvp_wins'],
        'pvp_losses': _myProfile['pvp_losses'],
        'honor': _myProfile['honor'],
      }).eq('id', user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final currentHp = _myProfile['hp'] ?? 20;
    final maxHp = _myProfile['max_hp'] ?? 20;
    final goldOnHand = _myProfile['gold_on_hand'] ?? 0;
    final gems = _myProfile['gems'] ?? 0;
    final turns = _myProfile['turns'] ?? 0;
    final level = _myProfile['level'] ?? 1;
    final experience = _myProfile['experience'] ?? 0;
    final honor = _myProfile['honor'] ?? 0;
    final wins = _myProfile['pvp_wins'] ?? 0;
    final losses = _myProfile['pvp_losses'] ?? 0;

    return Scaffold(
      backgroundColor: LogdCodes.uiBlueBg,
      appBar: AppBar(
        title: Text(
          local.arenaTitle.toUpperCase(),
          style: const TextStyle(
            fontFamily: LogdCodes.retroFont,
            fontSize: LogdCodes.fontSizeCardTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: LogdCodes.uiAppBarBg,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: LogdCodes.uiGreen))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LogdCodes.uiCardBg,
                      border: Border.all(color: LogdCodes.uiYellow),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "JOUW ARENA STATS",
                          style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        LogdText(text: local.statHonor(honor)),
                        LogdText(text: local.statPvpWins(wins, losses)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "BESCHIKBAAR VOOR DUEL:",
                    style: const TextStyle(color: Colors.cyan, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _opponents.isEmpty
                        ? Center(child: LogdText(text: local.arenaNoOpponents))
                        : ListView.builder(
                            itemCount: _opponents.length,
                            itemBuilder: (context, index) {
                              final opp = _opponents[index];
                              final oppName = opp['username'] ?? local.defaultUsername;
                              final oppLvl = opp['level'] ?? 1;
                              final oppHonor = opp['honor'] ?? 0;
                              final oppWins = opp['pvp_wins'] ?? 0;

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: LogdCodes.uiCardBg,
                                  border: Border.all(color: LogdCodes.uiBlueDark),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            oppName,
                                            style: const TextStyle(color: LogdCodes.uiYellow, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 2),
                                          LogdText(text: "Level: $oppLvl | Eer: $oppHonor | Wins: $oppWins"),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.message, color: Colors.cyan),
                                          tooltip: local.btnDm,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DirectMessagesScreen(initialRecipientUsername: oppName),
                                              ),
                                            );
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: LogdCodes.uiRedBg,
                                            side: const BorderSide(color: LogdCodes.uiRed),
                                          ),
                                          onPressed: () => _challengeOpponent(opp),
                                          child: Text(
                                            local.btnChallenge,
                                            style: const TextStyle(color: LogdCodes.uiRed, fontFamily: LogdCodes.retroFont, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
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
    );
  }
}
