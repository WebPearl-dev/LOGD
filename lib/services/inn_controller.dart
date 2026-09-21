// lib/services/inn_controller.dart
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

class InnController {
  final SupabaseClient supabase = Supabase.instance.client;

  int goldOnHand = 0, gems = 0, turns = 0, level = 1, experience = 0;
  int playerHp = 20, playerMaxHp = 20;
  int romancePoints = 0;
  int drinksToday = 0;
  int dragonBreathFights = 0;
  String username = "";
  String gender = "male"; // "male" of "female"
  bool hasRing = false;
  bool isMarried = false;
  bool isLoading = true;
  String bardBuff = "none"; // "warrior", "scavenger", "haste"

  Future<void> loadLiveStats() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final data = await supabase
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
      
      gender = (data['gender'] ?? "male").toLowerCase();
      romancePoints = data['romance_points'] ?? 0;
      drinksToday = data['drinks_today'] ?? 0;
      dragonBreathFights = data['dragon_breath_fights'] ?? 0;
      bardBuff = data['bard_buff'] ?? "none";
      isMarried = data['is_married'] ?? false;
      hasRing = data['has_ring'] ?? false;

      isLoading = false;
    }
  }

  Future<void> updateCloudStats() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      await supabase
          .from('profiles')
          .update({
            'gold_on_hand': goldOnHand,
            'gems': gems,
            'hp': playerHp,
            'max_hp': playerMaxHp,
            'turns': turns,
            'experience': experience,
            'alive': playerHp > 0,
            'romance_points': romancePoints,
            'drinks_today': drinksToday,
            'dragon_breath_fights': dragonBreathFights,
            'bard_buff': bardBuff,
            'is_married': isMarried,
          })
          .eq('id', user.id);
    }
  }

  Future<bool> checkForSourBeer() async {
    final user = supabase.auth.currentUser;
    if (user == null) return false;

    final List<dynamic> response = await supabase
        .from('profiles_status')
        .select()
        .eq('player_id', user.id)
        .eq('status_effect', 'sour_beer')
        .limit(1);

    if (response.isNotEmpty) {
      await supabase
          .from('profiles_status')
          .delete()
          .eq('player_id', user.id)
          .eq('status_effect', 'sour_beer');
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>?> spyOnRival(String targetId) async {
    final res = await supabase
        .from('profiles')
        .select('username, hp, max_hp, gold_on_hand')
        .eq('id', targetId)
        .single();
    return res;
  }

  Future<Map<String, dynamic>?> bribeBarman(String targetId) async {
    final res = await supabase
        .from('profiles')
        .select('username, gold_in_bank')
        .eq('id', targetId)
        .single();
    return res;
  }

  Future<List<Map<String, dynamic>>> getSpyTargets() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];
    final res = await supabase
        .from('profiles')
        .select('id, username, level, gold_on_hand')
        .not('id', 'eq', user.id)
        .limit(10);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<Map<String, dynamic>?> getRichestPlayer() async {
    final res = await supabase
        .from('profiles')
        .select('username, gold_on_hand')
        .not('id', 'eq', supabase.auth.currentUser!.id)
        .order('gold_on_hand', ascending: false)
        .limit(1)
        .maybeSingle();
    return res;
  }

  Future<List<Map<String, dynamic>>> getBountyTargets() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];
    final res = await supabase
        .from('profiles')
        .select('id, username, level')
        .not('id', 'eq', user.id)
        .limit(10);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<List<Map<String, dynamic>>> getLatestNews() async {
    final res = await supabase
        .from('daily_news')
        .select('username, log_type, reached_level, created_at')
        .order('created_at', ascending: false)
        .limit(15);
    return List<Map<String, dynamic>>.from(res);
  }

  Future<bool> insertBounty(String targetId, int amount) async {
    try {
      await supabase.from('bounties').insert({
        'hunter_id': supabase.auth.currentUser!.id,
        'target_id': targetId,
        'amount': amount,
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
