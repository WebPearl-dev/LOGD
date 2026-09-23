import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'guest_manager.dart';

class ShopItem {
  final String nameKey;
  final int cost;
  final int bonus;
  ShopItem({required this.nameKey, required this.cost, required this.bonus});
}

class ShopController {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  int goldOnHand = 0;
  int weaponLvl = 0;
  int armorLvl = 0;
  int level = 1;
  int gems = 0;
  int turns = 0;
  int hp = 0;
  int maxHp = 0;
  int experience = 0;
  bool isLoading = true;

  Map<String, dynamic> storyContent = {};

  final List<ShopItem> weapons = [
    ShopItem(nameKey: "wep0", cost: 0, bonus: 0),
    ShopItem(nameKey: "wep1", cost: 150, bonus: 1),
    ShopItem(nameKey: "wep2", cost: 500, bonus: 2),
    ShopItem(nameKey: "wep3", cost: 1500, bonus: 4),
    ShopItem(nameKey: "wep4", cost: 4000, bonus: 6),
    ShopItem(nameKey: "wep5", cost: 9000, bonus: 9),
    ShopItem(nameKey: "wep6", cost: 18000, bonus: 12),
    ShopItem(nameKey: "wep7", cost: 35000, bonus: 16),
    ShopItem(nameKey: "wep8", cost: 70000, bonus: 20),
    ShopItem(nameKey: "wep9", cost: 150000, bonus: 25),
    ShopItem(nameKey: "wep10", cost: 300000, bonus: 31),
    ShopItem(nameKey: "wep11", cost: 600000, bonus: 38),
    ShopItem(nameKey: "wep12", cost: 1200000, bonus: 46),
    ShopItem(nameKey: "wep13", cost: 2500000, bonus: 55),
    ShopItem(nameKey: "wep14", cost: 5000000, bonus: 65),
    ShopItem(nameKey: "wep15", cost: 10000000, bonus: 80),
  ];

  final List<ShopItem> armors = [
    ShopItem(nameKey: "arm0", cost: 0, bonus: 0),
    ShopItem(nameKey: "arm1", cost: 150, bonus: 1),
    ShopItem(nameKey: "arm2", cost: 500, bonus: 2),
    ShopItem(nameKey: "arm3", cost: 1500, bonus: 4),
    ShopItem(nameKey: "arm4", cost: 4000, bonus: 6),
    ShopItem(nameKey: "arm5", cost: 9000, bonus: 9),
    ShopItem(nameKey: "arm6", cost: 18000, bonus: 12),
    ShopItem(nameKey: "arm7", cost: 35000, bonus: 16),
    ShopItem(nameKey: "arm8", cost: 70000, bonus: 20),
    ShopItem(nameKey: "arm9", cost: 150000, bonus: 25),
    ShopItem(nameKey: "arm10", cost: 300000, bonus: 31),
    ShopItem(nameKey: "arm11", cost: 600000, bonus: 38),
    ShopItem(nameKey: "arm12", cost: 1200000, bonus: 46),
    ShopItem(nameKey: "arm13", cost: 2500000, bonus: 55),
    ShopItem(nameKey: "arm14", cost: 5000000, bonus: 65),
    ShopItem(nameKey: "arm15", cost: 10000000, bonus: 80),
  ];

  Future<void> loadShopStats(BuildContext context) async {
    try {
      final String lang = Localizations.localeOf(context).languageCode;
      if (GuestManager.isGuest) {
        final data = GuestManager.guestProfile;
        goldOnHand = data['gold_on_hand'] ?? 0;
        weaponLvl = data['weapon_level'] ?? 0;
        armorLvl = data['armor_level'] ?? 0;
        level = data['level'] ?? 1;
        gems = data['gems'] ?? 0;
        turns = data['turns'] ?? 0;
        hp = data['hp'] ?? 20;
        maxHp = data['max_hp'] ?? 20;
        experience = data['experience'] ?? 0;
      } else {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          final data = await _supabase.from('profiles').select().eq('id', user.id).single();
          goldOnHand = data['gold_on_hand'] ?? 0;
          weaponLvl = data['weapon_level'] ?? 0;
          armorLvl = data['armor_level'] ?? 0;
          level = data['level'] ?? 1;
          gems = data['gems'] ?? 0;
          turns = data['turns'] ?? 0;
          hp = data['hp'] ?? 20;
          maxHp = data['max_hp'] ?? 20;
          experience = data['experience'] ?? 0;
        }
      }

      final String jsonPath = 'assets/story/$lang/locatie_winkels.json';
      final String jsonString = await rootBundle.loadString(jsonPath);
      storyContent = jsonDecode(jsonString);

      isLoading = false;
    } catch (e) {
      debugPrint("Error loading shop stats: $e");
      isLoading = false;
    }
  }

  int getPriceToPay(bool isWeapon) {
    int currentLvl = isWeapon ? weaponLvl : armorLvl;
    if (currentLvl >= 15) return 0;

    int nextCost = isWeapon ? weapons[currentLvl + 1].cost : armors[currentLvl + 1].cost;
    int currentCost = isWeapon ? weapons[currentLvl].cost : armors[currentLvl].cost;
    
    int discount = (currentCost * 0.75).round();
    return nextCost - discount;
  }

  Future<String?> purchaseUpgrade(bool isWeapon) async {
    int currentLvl = isWeapon ? weaponLvl : armorLvl;
    if (currentLvl >= 15) return isWeapon ? "pegasus_max_level" : "merilon_max_level";

    int price = getPriceToPay(isWeapon);
    if (goldOnHand < price) return isWeapon ? "pegasus_error_no_gold" : "merilon_error_no_gold";

    goldOnHand -= price;
    if (isWeapon) {
      weaponLvl++;
    } else {
      armorLvl++;
    }

    await _updateCloud();
    return isWeapon ? "pegasus_buy_$weaponLvl" : "merilon_buy_$armorLvl";
  }

  String getRandomTalkKey(bool isPegasus) {
    return isPegasus ? "pegasus_talk_${_random.nextInt(10) + 1}" : "merilon_talk_${_random.nextInt(10) + 1}";
  }

  Future<void> _updateCloud() async {
    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = goldOnHand;
      GuestManager.guestProfile['weapon_level'] = weaponLvl;
      GuestManager.guestProfile['armor_level'] = armorLvl;
      return;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').update({
        'gold_on_hand': goldOnHand,
        'weapon_level': weaponLvl,
        'armor_level': armorLvl,
      }).eq('id', user.id);
    }
  }
}
