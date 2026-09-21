// lib/services/bank_controller.dart
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankController {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  int goldOnHand = 0;
  int goldInBank = 0;
  int level = 1;
  int dailyDeposited = 0;
  int gems = 0;
  int turns = 0;
  int hp = 0;
  int maxHp = 0;
  int experience = 0;
  bool isLoading = true;

  Future<void> loadBankStats() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      final data = await _supabase.from('profiles').select().eq('id', user.id).single();
      goldOnHand = data['gold_on_hand'] ?? 0;
      goldInBank = data['gold_in_bank'] ?? 0;
      level = data['level'] ?? 1;
      dailyDeposited = data['daily_deposited'] ?? 0;
      gems = data['gems'] ?? 0;
      turns = data['turns'] ?? 0;
      hp = data['hp'] ?? 20;
      maxHp = data['max_hp'] ?? 20;
      experience = data['experience'] ?? 0;
      isLoading = false;
    }
  }

  int get maxDeposit => level * 10000;
  int get remainingDepositLimit => (maxDeposit - dailyDeposited).clamp(0, maxDeposit);

  Future<String?> deposit(int amount) async {
    if (amount <= 0) return "error_invalid_amount";
    if (amount > goldOnHand) return "error_insufficient_hand";
    if (dailyDeposited + amount > maxDeposit) return "error_limit_reached";

    goldOnHand -= amount;
    goldInBank += amount;
    dailyDeposited += amount;

    await _updateCloud();
    return "deposit_success";
  }

  Future<String?> withdraw(int amount) async {
    if (amount <= 0) return "error_invalid_amount";
    if (amount > goldInBank) return "error_insufficient_bank";

    goldOnHand += amount;
    goldInBank -= amount;

    await _updateCloud();
    return "withdraw_success";
  }

  String getRandomTalkKey() {
    return "talk_${_random.nextInt(15) + 1}";
  }

  Future<void> _updateCloud() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'gold_in_bank': goldInBank,
        'daily_deposited': dailyDeposited,
      }).eq('id', user.id);
    }
  }
}
