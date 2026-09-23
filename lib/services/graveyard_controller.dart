import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'guest_manager.dart';

class GraveyardController {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> killPlayer() async {
    if (GuestManager.isGuest) {
      GuestManager.guestProfile['alive'] = false;
      GuestManager.guestProfile['gold_on_hand'] = 0;
      GuestManager.guestProfile['hp'] = 0;
      return;
    }

    final String userId = supabase.auth.currentUser!.id;
    await supabase
        .from('profiles')
        .update({
          'alive': false,
          'gold_on_hand': 0,
          'hp': 0,
        })
        .eq('id', userId);
  }

  Future<bool> tryResurrect({
    required int playerLevel,
    required int currentFavor,
  }) async {
    final int requiredFavor = playerLevel * 10;

    if (currentFavor < requiredFavor) {
      return false;
    }

    final int updatedFavor = currentFavor - requiredFavor;

    if (GuestManager.isGuest) {
      final int maxHp = GuestManager.guestProfile['max_hp'] ?? 20;
      GuestManager.guestProfile['alive'] = true;
      GuestManager.guestProfile['favor'] = updatedFavor;
      GuestManager.guestProfile['hp'] = maxHp;
      return true;
    }

    final profileData = await supabase
        .from('profiles')
        .select('max_hp')
        .eq('id', supabase.auth.currentUser!.id)
        .single();

    final int maxHp = profileData['max_hp'] ?? 100;

    await supabase
        .from('profiles')
        .update({'alive': true, 'favor': updatedFavor, 'hp': maxHp})
        .eq('id', supabase.auth.currentUser!.id);

    return true;
  }

  Future<Map<String, dynamic>?> hauntRandomPlayer() async {
    if (GuestManager.isGuest) {
      int turns = GuestManager.guestProfile['turns'] ?? 30;
      GuestManager.guestProfile['turns'] = (turns - 1).clamp(0, 100);
      return {'username': 'Schaduwreiziger', 'gold_in_bank': 1000, 'hp': 20};
    }

    await supabase.rpc('decrement_forest_turns', params: {'amount': 1});

    final List<dynamic> response = await supabase
        .from('profiles')
        .select('id, username, gold_in_bank, hp')
        .eq('alive', true)
        .neq('id', supabase.auth.currentUser!.id)
        .limit(1);

    if (response.isEmpty) {
      return null;
    }

    final targetPlayer = response.first as Map<String, dynamic>;
    final random = Random().nextInt(2);

    if (random == 0) {
      await supabase.from('profiles_status').insert({
        'player_id': targetPlayer['id'],
        'status_effect': 'sour_beer',
      });
    } else {
      final int currentHp = targetPlayer['hp'] ?? 0;
      await supabase
          .from('profiles')
          .update({
            'hp': (currentHp - 5).clamp(0, 9999),
          })
          .eq('id', targetPlayer['id']);
    }

    return targetPlayer;
  }

  Future<void> punishCombatDisconnect() async {
    if (GuestManager.isGuest) {
      int turns = GuestManager.guestProfile['turns'] ?? 30;
      GuestManager.guestProfile['turns'] = (turns - 3).clamp(0, 100);
      return;
    }
    await supabase.rpc('decrement_forest_turns', params: {'amount': 3});
  }

  Future<Map<String, dynamic>> robGrave() async {
    final random = Random();
    final roll = random.nextInt(100);

    if (GuestManager.isGuest) {
      if (roll < 40) {
        final int gold = random.nextInt(50) + 20;
        int currentGold = GuestManager.guestProfile['gold_on_hand'] ?? 0;
        GuestManager.guestProfile['gold_on_hand'] = currentGold + gold;
        return {'type': 'gold', 'amount': gold};
      } else if (roll < 55) {
        int currentGems = GuestManager.guestProfile['gems'] ?? 0;
        GuestManager.guestProfile['gems'] = currentGems + 1;
        return {'type': 'gem', 'amount': 1};
      } else if (roll < 85) {
        final int damage = random.nextInt(10) + 5;
        int currentHp = GuestManager.guestProfile['hp'] ?? 20;
        GuestManager.guestProfile['hp'] = (currentHp - damage).clamp(0, 9999);
        return {'type': 'zombie', 'amount': damage};
      } else {
        return {'type': 'empty'};
      }
    }

    if (roll < 40) {
      final int gold = random.nextInt(50) + 20;
      final int currentGold = await _getGoldOnHand();
      await supabase.from('profiles').update({
        'gold_on_hand': currentGold + gold,
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'gold', 'amount': gold};
    } else if (roll < 55) {
      final int currentGems = await _getGems();
      await supabase.from('profiles').update({
        'gems': currentGems + 1,
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'gem', 'amount': 1};
    } else if (roll < 85) {
      final int damage = random.nextInt(10) + 5;
      final int currentHp = await _getHp();
      await supabase.from('profiles').update({
        'hp': (currentHp - damage).clamp(0, 9999),
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'zombie', 'amount': damage};
    } else {
      return {'type': 'empty'};
    }
  }

  Future<int> handleStyxEvent(int playerLevel) async {
    final int favorGained = playerLevel * 8;
    if (GuestManager.isGuest) {
      int turns = GuestManager.guestProfile['turns'] ?? 30;
      GuestManager.guestProfile['turns'] = (turns - 2).clamp(0, 100);
      int currentFavor = GuestManager.guestProfile['favor'] ?? 50;
      GuestManager.guestProfile['favor'] = currentFavor + favorGained;
      return favorGained;
    }

    await supabase.rpc('decrement_forest_turns', params: {'amount': 2});
    final int currentFavor = await _getFavor();
    await supabase.from('profiles').update({
      'favor': currentFavor + favorGained,
    }).eq('id', supabase.auth.currentUser!.id);
    return favorGained;
  }

  Future<Map<String, dynamic>?> handleWhispersEvent() async {
    if (GuestManager.isGuest) {
      return {'username': 'Geestelijke Reiziger', 'gold_in_bank': 2000};
    }

    final List<dynamic> response = await supabase
        .from('profiles')
        .select('username, gold_in_bank')
        .eq('alive', true)
        .neq('id', supabase.auth.currentUser!.id)
        .limit(20);

    if (response.isEmpty) return null;
    
    final random = Random();
    return response[random.nextInt(response.length)] as Map<String, dynamic>;
  }

  Future<void> finalizeGhostCombat({
    required bool victory,
    required int favorEarned,
    required int currentHp,
  }) async {
    if (GuestManager.isGuest) {
      if (victory) {
        int currentFavor = GuestManager.guestProfile['favor'] ?? 50;
        GuestManager.guestProfile['favor'] = currentFavor + favorEarned;
        GuestManager.guestProfile['hp'] = currentHp;
      } else {
        int currentTurns = GuestManager.guestProfile['turns'] ?? 30;
        GuestManager.guestProfile['hp'] = 0;
        GuestManager.guestProfile['turns'] = (currentTurns - 2).clamp(0, 100);
      }
      return;
    }

    final String userId = supabase.auth.currentUser!.id;

    if (victory) {
      final int currentFavor = await _getFavor();
      await supabase.from('profiles').update({
        'favor': currentFavor + favorEarned,
        'hp': currentHp,
      }).eq('id', userId);
    } else {
      final res = await supabase.from('profiles').select('turns').eq('id', userId).single();
      final int currentTurns = res['turns'] ?? 0;
      
      await supabase.from('profiles').update({
        'hp': 0,
        'turns': (currentTurns - 2).clamp(0, 100),
      }).eq('id', userId);
    }
  }

  Future<int> _getGoldOnHand() async {
    if (GuestManager.isGuest) return GuestManager.guestProfile['gold_on_hand'] ?? 0;
    final res = await supabase.from('profiles').select('gold_on_hand').eq('id', supabase.auth.currentUser!.id).single();
    return res['gold_on_hand'] ?? 0;
  }

  Future<int> _getGems() async {
    if (GuestManager.isGuest) return GuestManager.guestProfile['gems'] ?? 0;
    final res = await supabase.from('profiles').select('gems').eq('id', supabase.auth.currentUser!.id).single();
    return res['gems'] ?? 0;
  }

  Future<int> _getHp() async {
    if (GuestManager.isGuest) return GuestManager.guestProfile['hp'] ?? 20;
    final res = await supabase.from('profiles').select('hp').eq('id', supabase.auth.currentUser!.id).single();
    return res['hp'] ?? 0;
  }

  Future<int> _getFavor() async {
    if (GuestManager.isGuest) return GuestManager.guestProfile['favor'] ?? 50;
    final res = await supabase.from('profiles').select('favor').eq('id', supabase.auth.currentUser!.id).single();
    return res['favor'] ?? 0;
  }
}
