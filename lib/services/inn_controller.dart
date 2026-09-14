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

  Future<void> initInn(Function onUpdate) async {
    await loadLiveStats();
    onUpdate();
  }

  Future<void> loadLiveStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();

      username = data['username'] ?? user.email ?? "";
      if (username.isEmpty) {
        username = "Reiziger";
      }

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

  Future<void> _logGambleToNews(bool won, int amount) async {
    try {
      await _supabase.from('daily_news').insert({
        'username': username,
        'log_type': won ? 'inn_win' : 'inn_loss',
        'reached_level': amount,
      });
    } catch (_) {}
  }

  Future<void> updateCloudStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'gems': gems,
        'hp': playerHp,
        'max_hp': playerMaxHp,
      }).eq('id', user.id);
    }
  }

  void playDice(int wager, Function(CombatStatus, int, int) onFinished) {
    if (goldOnHand < wager) {
      statusMessage = "NO_GOLD";
      return;
    }

    statusMessage = "";
    final int playerRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;
    final int houseRoll = _random.nextInt(6) + 1 + _random.nextInt(6) + 1;

    if (playerRoll > houseRoll) {
      goldOnHand += wager;
      _logGambleToNews(true, wager);
      onFinished(CombatStatus.skillMagic, playerRoll, houseRoll);
    } else if (playerRoll < houseRoll) {
      goldOnHand -= wager;
      _logGambleToNews(false, wager);
      onFinished(CombatStatus.playerDied, playerRoll, houseRoll);
    } else {
      onFinished(CombatStatus.roundContinue, playerRoll, houseRoll);
    }
    updateCloudStats();
  }

  // INTERACTIE LOGICA: Het Flirtsysteem (Violet)
  bool flirtWithViolet() {
    if (gems < 1) return false;

    gems -= 1; // Kost 1 edelsteen als cadeau!
    final bool success = _random.nextBool(); // 50% kans op succes

    if (success) {
      playerMaxHp += 1;
      playerHp = (playerHp + 15).clamp(0, playerMaxHp); // Geneest +15 HP en verhoogt max HP
      statusMessage = "FLIRT_SUCCESS";
    } else {
      playerHp = (playerHp - 2).clamp(1, playerMaxHp); // Verliest 2 HP van schaamte (gaat niet dood)
      statusMessage = "FLIRT_FAIL";
    }

    updateCloudStats();
    return true;
  }

  // INTERACTIE LOGICA: Geruchten van de Barman (Cedrik)
  String getCedrikRumor() {
    return _random.nextBool() ? "RUMOR_1" : "RUMOR_2";
  }
}
