// lib/services/inn_controller.dart
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'logd_enums.dart';

class InnController {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  String username = "";

  bool isLoading = true;
  String statusMessage = "";

  List<int> playerHand = [];
  List<int> houseHand = [];
  bool isBlackjackOver = true;

  Future<void> initInn(Function onUpdate) async {
    await loadLiveStats();
    onUpdate();
  }

  Future<void> loadLiveStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      username = data['username'] ?? user.email ?? "Reiziger";
      goldOnHand = data['gold_on_hand'] ?? 0;
      gems = data['gems'] ?? 0;
      turns = data['turns'] ?? 0;
      level = data['level'] ?? 1;
      experience = data['experience'] ?? 0;
      playerHp = data['hp'] ?? 20;
      playerMaxHp = data['max_hp'] ?? 20;
      isLoading = false;
    }
  }

  Future<void> updateCloudStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      // DE FIX: Zorgt dat beurten en maximale HP rotsvast live in de cloud landen!
      await _supabase
          .from('profiles')
          .update({
            'gold_on_hand': goldOnHand,
            'gems': gems,
            'hp': playerHp,
            'max_hp': playerMaxHp,
            'turns': turns,
            'alive': playerHp > 0,
            // Sluist je direct naar het kerkhof als Violet je K.O. slaat
          })
          .eq('id', user.id);
    }
  }

  void playDice(int wager, Function(CombatStatus, int, int) onFinished) {
    if (goldOnHand < wager) {
      statusMessage = "NO_GOLD";
      return;
    }
    statusMessage = "";
    final int pRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;
    final int hRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;

    if (pRoll > hRoll) {
      goldOnHand += wager;
      onFinished(CombatStatus.skillMagic, pRoll, hRoll);
    } else if (pRoll < hRoll) {
      goldOnHand -= wager;
      onFinished(CombatStatus.playerDied, pRoll, hRoll);
    } else {
      onFinished(CombatStatus.roundContinue, pRoll, hRoll);
    }
    updateCloudStats();
  }

  bool buyDrink(int drinkId, int cost) {
    if (goldOnHand < cost) {
      statusMessage = "NO_GOLD";
      return false;
    }
    goldOnHand -= cost;
    statusMessage = "";

    if (drinkId == 1) {
      playerHp = (playerHp + 15).clamp(0, playerMaxHp);
      turns = (turns - 1).clamp(0, 999);
      statusMessage = "DRINK_1_SUCCESS";
    } else if (drinkId == 2) {
      turns += 2;
      statusMessage = "DRINK_2_SUCCESS";
    }

    updateCloudStats();
    return true;
  }

  // DE NIEUWE FLIRT MOTOR: Procentuele wiskunde live uitgevoerd!
  bool flirtWithViolet() {
    if (gems < 1) return false;
    gems -= 1;

    int roll = _random.nextInt(100); // Dobbelsteen met 100 zijden (0-99)

    if (roll < 20) {
      // 20% KANS: Legendarische Flirt (Permanente HP upgrade!)
      playerMaxHp += 1;
      playerHp = playerMaxHp; // Direct volledig genezen
      statusMessage = "FLIRT_MAX_HP_BONUS";
    } else if (roll < 60) {
      // 40% KANS: Sfeervolle Flirt (+2 Turns)
      turns += 2;
      statusMessage = "FLIRT_TURNS_BONUS";
    } else {
      // 40% KANS: Pijnlijke Afwijzing (-5 HP)
      playerHp = (playerHp - 5).clamp(0, playerMaxHp);
      statusMessage = "FLIRT_SLAP_DEFEAT";
    }

    updateCloudStats();
    return true;
  }

  int _drawCard() => _random.nextInt(10) + 1;

  int calculateScore(List<int> hand) => hand.fold(0, (sum, card) => sum + card);

  void startBlackjack(int wager) {
    if (goldOnHand < wager) {
      statusMessage = "NO_GOLD";
      return;
    }
    statusMessage = "";
    playerHand = [_drawCard(), _drawCard()];
    houseHand = [_drawCard()];
    isBlackjackOver = false;
  }

  void blackjackHit(int wager, Function(String) onResult) {
    playerHand.add(_drawCard());
    if (calculateScore(playerHand) > 21) {
      goldOnHand -= wager;
      isBlackjackOver = true;
      updateCloudStats();
      onResult("BUST");
    }
  }

  void blackjackStand(int wager, Function(String, int, int) onResult) {
    while (calculateScore(houseHand) < 17) {
      houseHand.add(_drawCard());
    }
    int pScore = calculateScore(playerHand);
    int hScore = calculateScore(houseHand);

    isBlackjackOver = true;
    if (hScore > 21 || pScore > hScore) {
      goldOnHand += wager;
      onResult("WIN", pScore, hScore);
    } else if (pScore < hScore) {
      goldOnHand -= wager;
      onResult("LOSE", pScore, hScore);
    } else {
      onResult("TIE", pScore, hScore);
    }
    updateCloudStats();
  }

  String getCedrikRumor() {
    return _random.nextBool() ? "RUMOR_1" : "RUMOR_2";
  }

  Future<List<Map<String, dynamic>>> getSpyTargets() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];
    final res = await _supabase
        .from('profiles')
        .select('username, level, gold_on_hand')
        .not('id', 'eq', user.id)
        .limit(5);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> getLatestNews() async {
    final res = await _supabase
        .from('daily_news')
        .select('username, log_type, reached_level')
        .order('created_at', ascending: false)
        .limit(10);
    return List<Map<String, dynamic>>.from(res);
  }
}
