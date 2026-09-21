// lib/services/new_day_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

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

    // --- NIEUWE DAG RESET LOGICA ---
    int goldInBank = data['gold_in_bank'] ?? 0;
    int interest = 0;

    // 2% Rente tot 10M goud
    if (goldInBank > 0 && goldInBank < 10000000) {
      interest = (goldInBank * 0.02).round();
      goldInBank += interest;
    }

    final String race = data['race'] ?? 'HUMAN';
    int baseTurns = (race == 'HUMAN') ? 15 : 10;
    int oldTurns = data['turns'] ?? 0;

    // Update de database met de nieuwe dag stats
    await _supabase.from('profiles').update({
      'gold_in_bank': goldInBank,
      'turns': baseTurns,
      'daily_deposited': 0,
      'prayed_this_turn': false,
      'confessed_this_turn': false,
      'lit_candle_this_turn': false,
      'drinks_today': 0,
      'bard_buff': 'none', // Bard buffs vervallen elke dag
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
