// lib/services/graveyard_controller.dart
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';

class GraveyardController {
  // Dit linkt direct naar de actieve client die in main.dart is opgestart
  final SupabaseClient supabase = Supabase.instance.client;

  // Kill-switch: Zet de speler officieel op DOOD in Supabase en wist goud op zak
  Future<void> killPlayer() async {
    final String userId = supabase.auth.currentUser!.id;

    await supabase
        .from('profiles')
        .update({
          'alive': false,
          'gold_on_hand': 0,
          // Verliest direct al het goud op zak volgens de regels!
          'hp': 0,
        })
        .eq('id', userId);
  }

  // 1. Controleer en voer de wederopstanding uit
  Future<bool> tryResurrect({
    required int playerLevel,
    required int currentFavor,
  }) async {
    final int requiredFavor = playerLevel * 10;

    if (currentFavor < requiredFavor) {
      return false; // UI toont direct de 'resurrect_fail' dialoog uit JSON
    }

    final int updatedFavor = currentFavor - requiredFavor;

    // Haal eerst het max_hp op van de speler
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

    return true; // UI navigeert direct terug naar Locatie 1 (Het Dorpsplein)
  }

  // 2. Multi-player Spoken: Selecteer willekeurige levende speler en plaag hem
  Future<Map<String, dynamic>?> hauntRandomPlayer() async {
    // Update eerst de forest_turns van de geest (-1)
    await supabase.rpc('decrement_forest_turns', params: {'amount': 1});

    // Haal een willekeurige speler op die in leven is
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
      // Effect 1: Bier zuur maken (Vlag zetten in database voor herberg-bezoek)
      await supabase.from('profiles_status').insert({
        'player_id': targetPlayer['id'],
        'status_effect': 'sour_beer',
      });
    } else {
      // Effect 2: Schrikken (-5 HP direct in de cloud)
      final int currentHp = targetPlayer['hp'] ?? 0;
      await supabase
          .from('profiles')
          .update({
            'hp': (currentHp - 5).clamp(0, 9999),
          }) // Gecorrigeerd naar 0 zodat slachtoffer ook kan sterven!
          .eq('id', targetPlayer['id']);
    }

    return targetPlayer; // UI pakt de naam en vult deze dynamisch in het JSON-sjabloon
  }

  // 3. Straf bij App-Sluiting tijdens combat (Rage-quit preventie)
  Future<void> punishCombatDisconnect() async {
    await supabase.rpc('decrement_forest_turns', params: {'amount': 3});
  }

  // 4. Graf Plunderen Logica
  Future<Map<String, dynamic>> robGrave() async {
    final random = Random();
    final roll = random.nextInt(100);

    if (roll < 40) {
      // Succes: Goud
      final int gold = random.nextInt(50) + 20;
      final int currentGold = await _getGoldOnHand();
      await supabase.from('profiles').update({
        'gold_on_hand': currentGold + gold,
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'gold', 'amount': gold};
    } else if (roll < 55) {
      // Succes: Gem
      final int currentGems = await _getGems();
      await supabase.from('profiles').update({
        'gems': currentGems + 1,
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'gem', 'amount': 1};
    } else if (roll < 85) {
      // Zombie encounter!
      final int damage = random.nextInt(10) + 5;
      final int currentHp = await _getHp();
      await supabase.from('profiles').update({
        'hp': (currentHp - damage).clamp(0, 9999),
      }).eq('id', supabase.auth.currentUser!.id);
      return {'type': 'zombie', 'amount': damage};
    } else {
      // Leeg
      return {'type': 'empty'};
    }
  }

  // 5. Onderwereld Events Logica
  Future<int> handleStyxEvent(int playerLevel) async {
    // Kost 2 beurten, geeft Level * 8 favor
    await supabase.rpc('decrement_forest_turns', params: {'amount': 2});
    final int favorGained = playerLevel * 8;
    final int currentFavor = await _getFavor();
    await supabase.from('profiles').update({
      'favor': currentFavor + favorGained,
    }).eq('id', supabase.auth.currentUser!.id);
    return favorGained;
  }

  Future<Map<String, dynamic>?> handleWhispersEvent() async {
    // Haalt info op over een andere speler
    final List<dynamic> response = await supabase
        .from('profiles')
        .select('username, gold_in_bank')
        .eq('alive', true)
        .neq('id', supabase.auth.currentUser!.id)
        .limit(1);

    if (response.isEmpty) return null;
    return response.first as Map<String, dynamic>;
  }

  // Helper methodes voor stats
  Future<int> _getGoldOnHand() async {
    final res = await supabase.from('profiles').select('gold_on_hand').eq('id', supabase.auth.currentUser!.id).single();
    return res['gold_on_hand'] ?? 0;
  }

  Future<int> _getGems() async {
    final res = await supabase.from('profiles').select('gems').eq('id', supabase.auth.currentUser!.id).single();
    return res['gems'] ?? 0;
  }

  Future<int> _getHp() async {
    final res = await supabase.from('profiles').select('hp').eq('id', supabase.auth.currentUser!.id).single();
    return res['hp'] ?? 0;
  }

  Future<int> _getFavor() async {
    final res = await supabase.from('profiles').select('favor').eq('id', supabase.auth.currentUser!.id).single();
    return res['favor'] ?? 0;
  }
}
