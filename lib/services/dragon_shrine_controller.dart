import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'guest_manager.dart';

class DragonShrineController {
  final _supabase = Supabase.instance.client;

  Map<String, dynamic>? playerData;
  Map<String, dynamic> storyContent = {};
  bool isLoading = true;

  // Getters voor de UI stats
  int get dragonPoints => playerData?['dragon_points'] ?? 0;
  int get hp => playerData?['hp'] ?? 0;
  int get maxHp => playerData?['max_hp'] ?? 0;
  int get goldOnHand => playerData?['gold_on_hand'] ?? 0;
  int get gems => playerData?['gems'] ?? 0;
  int get turns => playerData?['turns'] ?? 0;
  int get level => playerData?['level'] ?? 1;
  int get experience => playerData?['experience'] ?? 0;

  Future<void> loadShrineStats(BuildContext context) async {
    try {
      final String lang = Localizations.localeOf(context).languageCode;
      if (GuestManager.isGuest) {
        playerData = GuestManager.guestProfile;
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          final data = await _supabase
              .from('profiles')
              .select()
              .eq('id', user.id)
              .single();
          playerData = data;
        }
      }

      final String jsonString = await rootBundle.loadString('assets/story/$lang/locatie_drakenheiligdom.json');
      storyContent = json.decode(jsonString);
      isLoading = false;
    } catch (e) {
      debugPrint("Error loading dragon shrine stats: $e");
      isLoading = false;
    }
  }

  Future<String?> purchaseUpgrade(int type) async {
    if (dragonPoints < 1) return storyContent['dragonShrineNoPoints'];

    Map<String, dynamic> updates = {
      'dragon_points': dragonPoints - 1,
    };

    switch (type) {
      case 1: // ATK
        updates['permanent_bonus_atk'] = (playerData?['permanent_bonus_atk'] ?? 0) + 1;
        break;
      case 2: // DEF
        updates['permanent_bonus_def'] = (playerData?['permanent_bonus_def'] ?? 0) + 1;
        break;
      case 3: // HP
        updates['permanent_bonus_hp'] = (playerData?['permanent_bonus_hp'] ?? 0) + 5;
        updates['max_hp'] = maxHp + 5;
        updates['hp'] = maxHp + 5;
        break;
      case 4: // TURNS
        updates['permanent_bonus_turns'] = (playerData?['permanent_bonus_turns'] ?? 0) + 1;
        break;
    }

    if (GuestManager.isGuest) {
      GuestManager.guestProfile.addAll(updates);
      playerData = GuestManager.guestProfile;
      return storyContent['dragonShrineSuccess'];
    }

    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    try {
      await _supabase.from('profiles').update(updates).eq('id', user.id);
      
      final newData = await _supabase.from('profiles').select().eq('id', user.id).single();
      playerData = newData;
      
      return storyContent['dragonShrineSuccess'];
    } catch (e) {
      debugPrint("Error updating dragon shrine upgrade: $e");
      return "Er is een fout opgetreden bij de upgrade.";
    }
  }
}
