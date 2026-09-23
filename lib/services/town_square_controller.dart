import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';
import 'guest_manager.dart';

class TownSquareController {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  Map<String, dynamic>? playerData;
  Map<String, dynamic>? latestNewsItem;
  Map<String, dynamic> storyContent = {};
  Map<String, dynamic> barberContent = {};
  static Map<String, dynamic> bosContent = {};

  bool isLoading = true;
  String healerStatusMessage = "";
  String barberStatusMessage = "";
  String mightyEStatusMessage = "";
  String weddingStatusMessage = "";
  String alleyStatusMessage = "";

  static String getMonsterName(String rawKey) {
    if (bosContent.containsKey('${rawKey}_name')) {
      return bosContent['${rawKey}_name'];
    }
    if (bosContent.containsKey(rawKey)) {
      return bosContent[rawKey];
    }
    return rawKey;
  }

  Future<void> loadLiveStats(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    try {
      final String languageCode = Localizations.localeOf(context).languageCode;

      final String mainPath = 'assets/story/$languageCode/locatie_dorpsplein.json';
      final String barberPath = 'assets/story/$languageCode/locatie_kapper.json';
      final String bosPath = 'assets/story/$languageCode/locatie_bos.json';

      final results = await Future.wait([
        rootBundle.loadString(mainPath),
        rootBundle.loadString(barberPath),
        rootBundle.loadString(bosPath),
      ]);

      storyContent = jsonDecode(results[0]) as Map<String, dynamic>;
      barberContent = jsonDecode(results[1]) as Map<String, dynamic>;
      bosContent = jsonDecode(results[2]) as Map<String, dynamic>;

      isLoading = false;
      onUpdate();

      if (GuestManager.isGuest) {
        playerData = GuestManager.guestProfile;
        latestNewsItem = {
          'log_type': 'welcome',
          'username': 'Gast Reiziger',
          'message': 'Welkom in de wereld van de Gouden Draak als gast!'
        };
        onUpdate();
        return;
      }

      var user = _supabase.auth.currentUser;
      if (user == null) {
        await Future.delayed(const Duration(milliseconds: 500));
        user = _supabase.auth.currentUser;
      }

      if (user != null) {
        final profileRes = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (profileRes != null) {
          playerData = profileRes;
        }

        final newsRes = await _supabase
            .from('daily_news')
            .select()
            .order('created_at', ascending: false)
            .limit(1);
        if (newsRes.isNotEmpty) {
          latestNewsItem = newsRes.first;
        }
      }
      
      onUpdate();
    } catch (e) {
      debugPrint("Error in loadLiveStats: $e");
      isLoading = false;
      onUpdate();
    }
  }

  Future<bool> handleHealerPurchase(int cost, int maxHp) async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    if (gold < cost) return false;

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = gold - cost;
      GuestManager.guestProfile['hp'] = maxHp;
      GuestManager.guestProfile['alive'] = true;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gold_on_hand': gold - cost, 'hp': maxHp, 'alive': true})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleBarberPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    final String currentName = playerData?['username'] ?? "";
    final String gender = playerData?['gender'] ?? 'M';
    if (userGems < 1) return false;

    final String rawTitles = (gender == 'F')
        ? (barberContent['title_options_female'] ?? "")
        : (barberContent['title_options_male'] ?? "");

    final List<String> titles = rawTitles.split(',');

    String newUsername = currentName;
    if (titles.isNotEmpty && rawTitles.isNotEmpty) {
      final String randomTitle = titles[_random.nextInt(titles.length)].trim();
      final String colorCode = _extractColor(currentName);
      final String cleanName = _cleanUsername(currentName);
      newUsername = "$colorCode$randomTitle $cleanName";
    }

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gems'] = userGems - 1;
      GuestManager.guestProfile['username'] = newUsername;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);

      if (playerData != null) {
        playerData!['gems'] = userGems - 1;
        playerData!['username'] = newUsername;
      }
      return true;
    }
    return false;
  }

  Future<bool> handleFreshCutPurchase(int cost) async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    final int romance = playerData?['romance_points'] ?? 0;
    if (gold < cost) return false;

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = gold - cost;
      GuestManager.guestProfile['romance_points'] = romance + 10;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gold_on_hand': gold - cost, 'romance_points': romance + 10})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleSmoothShavePurchase(int cost, int maxHp) async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    final int currentHp = playerData?['hp'] ?? 0;
    if (gold < cost) return false;

    final int healAmount = (maxHp * 0.2).round();
    final int newHp = min(maxHp, currentHp + healAmount);

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = gold - cost;
      GuestManager.guestProfile['hp'] = newHp;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gold_on_hand': gold - cost, 'hp': newHp})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleDyeHairPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    String currentName = playerData?['username'] ?? "";
    if (userGems < 1) return false;

    final colors = ['p', 'c', 'g', 'y', 'r'];
    final color = colors[_random.nextInt(colors.length)];

    final String cleanName = _cleanUsername(currentName);
    final String newUsername = "`$color$cleanName";

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gems'] = userGems - 1;
      GuestManager.guestProfile['username'] = newUsername;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);
      if (playerData != null) {
        playerData!['gems'] = userGems - 1;
        playerData!['username'] = newUsername;
      }
      return true;
    }
    return false;
  }

  Future<bool> handleAlleyPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    if (userGems < 5) {
      alleyStatusMessage = barberContent['error_no_gem'] ?? "...";
      return false;
    }

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gems'] = userGems - 5;
      GuestManager.guestProfile['bounty'] = 0;
      GuestManager.guestProfile['reputation'] = 0;
      playerData = GuestManager.guestProfile;
      alleyStatusMessage = storyContent['dark_alley_success'] ?? "...";
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gems': userGems - 5, 'bounty': 0, 'reputation': 0})
          .eq('id', user.id);
      
      if (playerData != null) {
        playerData!['gems'] = userGems - 5;
        playerData!['bounty'] = 0;
        playerData!['reputation'] = 0;
      }

      alleyStatusMessage = storyContent['dark_alley_success'] ?? "...";

      try {
        final String name = playerData?['username'] ?? "Een gure reiziger";
        await _supabase.from('daily_news').insert({
          'log_type': 'alley_bribe',
          'username': name,
          'message': "$name heeft stiekem wat edelstenen aan Sly overhandigd en ziet er ineens een stuk braver uit.",
        });
      } catch (_) {}

      return true;
    }
    return false;
  }

  Future<bool> handleMightyEPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    final String currentName = playerData?['username'] ?? "";
    if (userGems < 1) return false;

    final String rawTitles = storyContent['mightye_titles'] ?? "Donateur";
    final List<String> donorTitles = rawTitles.split(',');
    final String randomTitle = donorTitles[_random.nextInt(donorTitles.length)].trim();

    final String colorCode = _extractColor(currentName);
    final String cleanName = _cleanUsername(currentName);
    final String newUsername = "$colorCode$randomTitle $cleanName";

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gems'] = userGems - 1;
      GuestManager.guestProfile['username'] = newUsername;
      playerData = GuestManager.guestProfile;
      return true;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);

      if (playerData != null) {
        playerData!['gems'] = userGems - 1;
        playerData!['username'] = newUsername;
      }
      return true;
    }
    return false;
  }

  Future<int> handleWeddingPurchase() async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    final bool isMarried = playerData?['is_married'] ?? false;

    if (isMarried) return 1;
    if (gold < 500) return 2;

    if (GuestManager.isGuest) {
      GuestManager.guestProfile['gold_on_hand'] = gold - 500;
      GuestManager.guestProfile['is_married'] = true;
      playerData = GuestManager.guestProfile;
      return 0;
    }

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gold_on_hand': gold - 500, 'is_married': true})
          .eq('id', user.id);

      try {
        final String gender = playerData?['gender'] ?? 'M';
        final String partnerName = (gender == 'F') ? "Seth" : "Violet";
        await _supabase.from('daily_news').insert({
          'username': playerData?['username'] ?? "Reiziger",
          'log_type': 'marriage',
          'partner_name': partnerName,
        });
      } catch (_) {}

      return 0;
    }
    return 3;
  }

  String getRandomRumor(String fallback) {
    int rumorId = _random.nextInt(4) + 1;
    return storyContent['rumor$rumorId'] ?? fallback;
  }

  String parseNewsItem(AppLocalizations local, Map<String, dynamic> log) {
    final String type = log['log_type'] ?? '';
    final String user = log['username'] ?? local.newsUnknownPlayer;

    final int numericLevel = log['reached_level'] ?? log['value_after'] ?? 0;
    final String levelStr = numericLevel.toString();

    final int numericGold = log['gold_amount'] ?? log['gold'] ?? 0;
    final String goldStr = numericGold.toString();

    if (type == 'level_up') {
      return local.newsLogLevelUp(levelStr, user);
    }
    if (type == 'defeated') {
      final String enemyKey = log['enemy_name'] ?? '';
      final String enemyName = getMonsterName(enemyKey);
      return local.newsLogDefeated(enemyName, user);
    }
    if (type == 'defeated_brutal') {
      final String enemyKey = log['enemy_name'] ?? '';
      final String enemyName = getMonsterName(enemyKey);
      return local.newsLogDefeatedBrutal(enemyName, user);
    }
    if (type == 'inn_win') {
      return local.newsLogInnWin(goldStr, user);
    }
    if (type == 'inn_loss') {
      return local.newsLogInnLoss(goldStr, user);
    }
    if (type == 'marriage') {
      final String partner = log['partner_name'] ?? local.newsUnknownPartner;
      return local.newsLogMarriage(partner, user);
    }
    if (type == 'dragon_attack') {
      return local.newsLogDragonAttack(user);
    }
    if (type == 'dragon_defeat') {
      return local.newsLogDragonDefeat(user);
    }
    if (type == 'dragon_kill') {
      return local.news_dragon_kill(levelStr, user);
    }
    
    return log['log_text'] ?? log['message'] ?? '';
  }

  String _extractColor(String name) {
    if (name.isEmpty) return "";
    final RegExp colorRegex = RegExp(r"[`'][a-zA-Z0-9]");
    final match = colorRegex.firstMatch(name);
    return match?.group(0) ?? "";
  }

  static String cleanColorCodesOnly(String name) {
    if (name.isEmpty) return name;
    final RegExp colorRegex = RegExp(r"[`'][a-zA-Z0-9]");
    return name.replaceAll(colorRegex, '').trim();
  }

  String _cleanUsername(String name) {
    String clean = name;
    
    final RegExp colorRegex = RegExp(r"[`'][a-zA-Z0-9]");
    clean = clean.replaceAll(colorRegex, '');

    final List<String> allTitles = [];
    final String rawMale = barberContent['title_options_male'] ?? "";
    final String rawFemale = barberContent['title_options_female'] ?? "";
    final String rawMightyE = storyContent['mightye_titles'] ?? "";
    
    allTitles.addAll(rawMale.split(','));
    allTitles.addAll(rawFemale.split(','));
    allTitles.addAll(rawMightyE.split(','));
    allTitles.addAll(["Donateur", "Donor", "Sir", "Lady", "Lord", "Baron", "Barones", "Hertog", "Hertogin", "Graaf", "Gravin", "Legende"]);

    final titles = allTitles.map((t) => t.trim()).where((t) => t.isNotEmpty).toSet().toList();
    titles.sort((a, b) => b.length.compareTo(a.length));

    for (var t in titles) {
      clean = clean.replaceAll(RegExp('^$t\\s*', caseSensitive: false), '');
      clean = clean.replaceAll(RegExp('\\b$t\\b', caseSensitive: false), '');
    }

    return clean.trim();
  }
}
