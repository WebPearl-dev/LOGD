import 'package:supabase_flutter/supabase_flutter.dart';
import 'guest_manager.dart';

class NewDayResult {
  final int interestEarned;
  final int oldTurns;
  final int newTurns;
  final bool triggered;

  NewDayResult({
    this.interestEarned = 0,
    this.oldTurns = 0,
    this.newTurns = 0,
    this.triggered = false,
  });
}

class NewDayService {
  static final _supabase = Supabase.instance.client;

  static Future<NewDayResult> checkAndPerformReset() async {
    if (GuestManager.isGuest) {
      final data = GuestManager.guestProfile;
      final String? lastResetStr = data['last_reset'];
      final DateTime now = DateTime.now();
      final DateTime today = DateTime(now.year, now.month, now.day);

      if (lastResetStr != null) {
        final DateTime lastReset = DateTime.parse(lastResetStr);
        if (!lastReset.isBefore(today)) {
          return NewDayResult();
        }
      }

      int goldInBank = data['gold_in_bank'] ?? 0;
      int interest = 0;
      if (goldInBank > 0 && goldInBank < 10000000) {
        interest = (goldInBank * 0.02).round();
        goldInBank += interest;
      }

      final String race = data['race'] ?? 'HUMAN';
      int baseTurns = 30;
      if (race == 'HUMAN') baseTurns += 5;
      final int permBonusTurns = data['permanent_bonus_turns'] ?? 0;
      baseTurns += permBonusTurns;

      int oldTurns = data['turns'] ?? 0;

      data['gold_in_bank'] = goldInBank;
      data['turns'] = baseTurns;
      data['daily_deposited'] = 0;
      data['prayed_this_turn'] = false;
      data['confessed_this_turn'] = false;
      data['lit_candle_this_turn'] = false;
      data['drinks_today'] = 0;
      data['bard_buff'] = 'none';
      data['last_reset'] = today.toIso8601String();

      return NewDayResult(
        interestEarned: interest,
        oldTurns: oldTurns,
        newTurns: baseTurns,
        triggered: true,
      );
    }

    final user = _supabase.auth.currentUser;
    if (user == null) return NewDayResult();

    final data = await _supabase.from('profiles').select().eq('id', user.id).single();
    
    final String? lastResetStr = data['last_reset'];
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    if (lastResetStr != null) {
      final DateTime lastReset = DateTime.parse(lastResetStr);
      if (!lastReset.isBefore(today)) {
        return NewDayResult(); // Al gereset vandaag
      }
    }

    int goldInBank = data['gold_in_bank'] ?? 0;
    int interest = 0;

    if (goldInBank > 0 && goldInBank < 10000000) {
      interest = (goldInBank * 0.02).round();
      goldInBank += interest;
    }

    final String race = data['race'] ?? 'HUMAN';
    int baseTurns = 30;
    if (race == 'HUMAN') baseTurns += 5;
    
    final int permBonusTurns = data['permanent_bonus_turns'] ?? 0;
    baseTurns += permBonusTurns;

    int oldTurns = data['turns'] ?? 0;

    await _supabase.from('profiles').update({
      'gold_in_bank': goldInBank,
      'turns': baseTurns,
      'daily_deposited': 0,
      'prayed_this_turn': false,
      'confessed_this_turn': false,
      'lit_candle_this_turn': false,
      'drinks_today': 0,
      'bard_buff': 'none',
      'last_reset': today.toIso8601String(),
    }).eq('id', user.id);

    return NewDayResult(
      interestEarned: interest,
      oldTurns: oldTurns,
      newTurns: baseTurns,
      triggered: true,
    );
  }
}
