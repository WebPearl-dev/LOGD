// lib/services/town_square_controller.dart
import 'dart:convert'; // DE FIX: Alleen hier bovenaan, brandschoon!
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../l10n/app_localizations.dart';

class TownSquareController {
  final _supabase = Supabase.instance.client;
  final _random = Random();

  Map<String, dynamic>? playerData;
  Map<String, dynamic>? latestNewsItem;
  Map<String, dynamic> storyContent = {};
  Map<String, dynamic> barberContent = {};

  bool isLoading = true;
  String healerStatusMessage = "";
  String barberStatusMessage = "";
  String mightyEStatusMessage = "";
  String weddingStatusMessage = "";

  Future<void> loadLiveStats(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    try {
      final String languageCode = Localizations.localeOf(context).languageCode;

      // FIX: Wacht kort als de user nog null is (bijv. direct na inloggen)
      var user = _supabase.auth.currentUser;
      if (user == null) {
        await Future.delayed(const Duration(milliseconds: 500));
        user = _supabase.auth.currentUser;
      }

      if (user != null) {
        final data = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .maybeSingle(); // Gebruik maybeSingle om crashes bij ontbrekend profiel te voorkomen

        if (data != null) {
          playerData = data;
          
          final String mainPath = 'assets/story/$languageCode/locatie_dorpsplein.json';
          final String barberPath = 'assets/story/$languageCode/locatie_kapper.json';

          final String mainJson = await rootBundle.loadString(mainPath);
          final String barberJson = await rootBundle.loadString(barberPath);

          storyContent = jsonDecode(mainJson) as Map<String, dynamic>;
          barberContent = jsonDecode(barberJson) as Map<String, dynamic>;

          final newsRes = await _supabase
              .from('daily_news')
              .select()
              .order('created_at', ascending: false)
              .limit(1);
          if (newsRes.isNotEmpty) {
            latestNewsItem = newsRes.first;
          }
        }
      }
      
      isLoading = false;
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

    final user = _supabase.auth.currentUser;
    if (user != null) {
      final String rawTitles = (gender == 'F')
          ? (barberContent['title_options_female'] ?? "")
          : (barberContent['title_options_male'] ?? "");

      final List<String> titles = rawTitles.split(',');

      final String rawMale = barberContent['title_options_male'] ?? "";
      final String rawFemale = barberContent['title_options_female'] ?? "";
      final List<String> allPossibleTitles = [
        ...rawMale.split(','),
        ...rawFemale.split(','),
      ];

      String newUsername = currentName;
      if (titles.isNotEmpty && rawTitles.isNotEmpty) {
        final String randomTitle = titles[_random.nextInt(titles.length)];

        String cleanName = currentName;
        for (var t in allPossibleTitles) {
          if (t.isNotEmpty) cleanName = cleanName.replaceAll('$t ', '');
        }
        newUsername = "$randomTitle $cleanName";
      }

      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleFreshCutPurchase(int cost) async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    final int romance = playerData?['romance_points'] ?? 0;
    if (gold < cost) return false;

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

    final user = _supabase.auth.currentUser;
    if (user != null) {
      final int healAmount = (maxHp * 0.2).round();
      final int newHp = min(maxHp, currentHp + healAmount);

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

    final user = _supabase.auth.currentUser;
    if (user != null) {
      // Kies willekeurig uit een set kleuren (p=purple, c=cyan, g=green, y=yellow, r=red)
      final colors = ['p', 'c', 'g', 'y', 'r'];
      final color = colors[_random.nextInt(colors.length)];

      // Verwijder eventuele oude kleurcode aan het begin (bijv. `p)
      if (currentName.startsWith('`') && currentName.length > 2) {
        currentName = currentName.substring(2);
      }
      final String newUsername = "`$color$currentName";

      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleAlleyPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    if (userGems < 5) return false;

    final user = _supabase.auth.currentUser;
    if (user != null) {
      // RESET: Strafblad afkopen (Bounty en Reputatie terug naar neutraal)
      await _supabase
          .from('profiles')
          .update({'gems': userGems - 5, 'bounty': 0, 'reputation': 0})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<bool> handleMightyEPurchase() async {
    final int userGems = playerData?['gems'] ?? 0;
    final String currentName = playerData?['username'] ?? "";
    if (userGems < 1) return false;

    final user = _supabase.auth.currentUser;
    if (user != null) {
      final String donorTitle = storyContent['title_donor'] ?? "";
      String cleanName = currentName.replaceAll('$donorTitle ', '');
      final String newUsername = "$donorTitle $cleanName";

      await _supabase
          .from('profiles')
          .update({'gems': userGems - 1, 'username': newUsername})
          .eq('id', user.id);
      return true;
    }
    return false;
  }

  Future<int> handleWeddingPurchase() async {
    final int gold = playerData?['gold_on_hand'] ?? 0;
    final bool isMarried = playerData?['is_married'] ?? false;

    if (isMarried) return 1;
    if (gold < 500) return 2;

    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase
          .from('profiles')
          .update({'gold_on_hand': gold - 500, 'is_married': true})
          .eq('id', user.id);

      // NIEUW: Log het huwelijk op het nieuwsbord!
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
      return local.newsLogDefeated(log['enemy_name'] ?? 'een monster', user);
    }
    if (type == 'defeated_brutal') {
      return local.newsLogDefeatedBrutal(log['enemy_name'] ?? 'een monster', user);
    }
    if (type == 'inn_win') {
      return local.newsLogInnWin(goldStr, user);
    }
    if (type == 'inn_loss') {
      return local.newsLogInnLoss(goldStr, user);
    }
    if (type == 'marriage') {
      return local.newsLogMarriage(log['partner_name'] ?? 'iemand', user);
    }
    return log['log_text'] ?? log['message'] ?? '';
  }
}
