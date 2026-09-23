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
  static Map<String, dynamic> begraafplaatsContent = {};

  bool isLoading = true;
  String healerStatusMessage = "";
  String barberStatusMessage = "";
  String mightyEStatusMessage = "";
  String weddingStatusMessage = "";
  String alleyStatusMessage = "";

  static const Map<String, String> _monsterFallbackMap = {
    // Level 1
    'm_1_0': 'Kleine pixie',
    'm_1_1': 'Agressieve bosrat',
    'm_1_2': 'Reusachtige kakkerlak',
    'm_1_3': 'Boompad',
    // Level 2
    'm_2_0': 'Hondsdolle eekhoorn',
    'm_2_1': 'Bosgoblin',
    'm_2_2': 'Zakkenroller',
    'm_2_3': 'Boze das',
    // Level 3
    'm_3_0': 'Struikrover',
    'm_3_1': 'Reuzenspin',
    'm_3_2': 'Wilde zwijn',
    'm_3_3': 'Wegpiraat',
    // Level 4
    'm_4_0': 'Goblin verkenner',
    'm_4_1': 'Bloeddorstige Orc',
    'm_4_2': 'Skelet',
    'm_4_3': 'Zwerm killerbijen',
    // Level 5
    'm_5_0': 'Woudtrol',
    'm_5_1': 'Hagedis-man',
    'm_5_2': 'Oger',
    'm_5_3': 'Geestenverschijning',
    // Level 6
    'm_6_0': 'Harpy',
    'm_6_1': 'Minotaurus kalf',
    'm_6_2': 'Gargoyle',
    'm_6_3': 'Moerasslijm',
    // Level 7
    'm_7_0': 'Weerwolf',
    'm_7_1': 'Goblin bokser',
    'm_7_2': 'Duistere magiër',
    'm_7_3': 'Moerasmonster',
    // Level 8
    'm_8_0': 'Wraith',
    'm_8_1': 'Zielenvreter',
    'm_8_2': 'Golem',
    'm_8_3': 'Kwaadaardige boomgeest',
    // Level 9
    'm_9_0': 'Manticore',
    'm_9_1': 'Wyvern',
    'm_9_2': 'Robin hood',
    'm_9_3': 'Bergreus',
    // Level 10
    'm_10_0': 'Zwarte ridder',
    'm_10_1': 'Schaduwreiziger',
    'm_10_2': 'Cycloop',
    'm_10_3': 'Bosdraak kalf',
    // Level 11
    'm_11_0': 'Regenererend slijm',
    'm_11_1': 'Vampier',
    'm_11_2': 'Banshee',
    'm_11_3': 'Weerwolf alfa',
    // Level 12
    'm_12_0': 'Killerbijen koningin',
    'm_12_1': 'Necromancer',
    'm_12_2': 'Beholder',
    'm_12_3': 'Schaduwmagiër',
    // Level 13
    'm_13_0': 'Goblin sjamaan',
    'm_13_1': 'Vuur-elemental',
    'm_13_2': 'Lich',
    'm_13_3': 'Oude eiken-ent',
    // Level 14
    'm_14_0': 'Horrifying slime',
    'm_14_1': 'Dragon spawn',
    'm_14_2': 'Oude titaan',
    'm_14_3': 'Hydra',
    // Level 15
    'm_15_0': 'Changeling',
    'm_15_1': 'Demon lord',
    'm_15_2': 'Dark elf assassin',
    'm_15_3': 'Gouden draak',
    // Begraafplaats
    'enemy_name_1': 'Een Dwaallicht',
    'enemy_name_2': 'De Spookachtige Verschijning',
    'enemy_name_3': 'Een Huilende Banshee',
    'enemy_name_4': 'De Grafschender',
    'enemy_name_5': 'Een Rusteloze Poltergeist',
    'enemy_name_6': 'Het Rusteloze Skelet',
    'enemy_name_7': 'De Schaduw van een Gevallen Ridder',
    'enemy_name_8': 'De IJzige Geest',
    'enemy_name_9': 'Een Zielenvreter',
    'enemy_name_10': 'Een Grote Zielenvreter',
    'enemy_name_11': 'Het Schimmige Fantoom',
    'enemy_name_12': 'De Necromancer-Geest',
    'enemy_name_13': 'Een Ondode Lich-Koning',
    'enemy_name_14': 'De Onderwereld Bewaker',
    'enemy_name_15': 'De Schim van de Vorige Held',
  };

  static Future<void> ensureMonsterDataLoaded([String languageCode = 'nl']) async {
    if (bosContent.isNotEmpty && begraafplaatsContent.isNotEmpty) return;
    try {
      final String bosPath = 'assets/story/$languageCode/locatie_bos.json';
      final String begraafplaatsPath = 'assets/story/$languageCode/monsters_begraafplaats.json';
      final results = await Future.wait([
        rootBundle.loadString(bosPath).catchError((_) => '{}'),
        rootBundle.loadString(begraafplaatsPath).catchError((_) => '{}'),
      ]);
      bosContent = jsonDecode(results[0]) as Map<String, dynamic>;
      begraafplaatsContent = jsonDecode(results[1]) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Error loading monster data: $e");
    }
  }

  static String getMonsterName(String rawKey) {
    if (rawKey.trim().isEmpty) return 'een monster';

    String key = rawKey.trim();

    // 1. Check bosContent
    if (bosContent.containsKey('${key}_name')) {
      final name = bosContent['${key}_name'].toString();
      if (name.isNotEmpty) return cleanColorCodesOnly(name);
    }
    if (bosContent.containsKey(key)) {
      final name = bosContent[key].toString();
      if (name.isNotEmpty) return cleanColorCodesOnly(name);
    }

    // 2. Check begraafplaatsContent
    if (begraafplaatsContent.containsKey(key)) {
      final name = begraafplaatsContent[key].toString();
      if (name.isNotEmpty) return cleanColorCodesOnly(name);
    }
    if (begraafplaatsContent.containsKey('enemy_name_$key')) {
      final name = begraafplaatsContent['enemy_name_$key'].toString();
      if (name.isNotEmpty) return cleanColorCodesOnly(name);
    }
    if (begraafplaatsContent.containsKey('${key}_name')) {
      final name = begraafplaatsContent['${key}_name'].toString();
      if (name.isNotEmpty) return cleanColorCodesOnly(name);
    }

    // 3. Fallback map lookup
    final String? fallback = _monsterFallbackMap[key] ?? _monsterFallbackMap['${key}_name'];
    if (fallback != null && fallback.isNotEmpty) {
      return cleanColorCodesOnly(fallback);
    }

    // 4. Raw key pattern match fallback
    final RegExp rawCodePattern = RegExp(r'^(m_\d+_\d+|enemy_name_\d+|enemy_\d+|\d+)$');
    if (rawCodePattern.hasMatch(key)) {
      if (key == 'm_4_3') return 'Zwerm killerbijen';
      if (key == 'm_4_1') return 'Bloeddorstige Orc';
      return 'Bosmonster';
    }

    final String cleaned = cleanColorCodesOnly(key);
    if (RegExp(r'^m_\d+').hasMatch(cleaned)) {
      return 'Bosmonster';
    }

    return cleaned.isNotEmpty ? cleaned : 'een monster';
  }

  Future<void> loadLiveStats(
    BuildContext context,
    VoidCallback onUpdate,
  ) async {
    try {
      final local = AppLocalizations.of(context);
      final String languageCode = Localizations.localeOf(context).languageCode;

      final String mainPath = 'assets/story/$languageCode/locatie_dorpsplein.json';
      final String barberPath = 'assets/story/$languageCode/locatie_kapper.json';
      final String bosPath = 'assets/story/$languageCode/locatie_bos.json';
      final String begraafplaatsPath = 'assets/story/$languageCode/monsters_begraafplaats.json';

      final results = await Future.wait([
        rootBundle.loadString(mainPath).catchError((_) => '{}'),
        rootBundle.loadString(barberPath).catchError((_) => '{}'),
        rootBundle.loadString(bosPath).catchError((_) => '{}'),
        rootBundle.loadString(begraafplaatsPath).catchError((_) => '{}'),
      ]);

      storyContent = jsonDecode(results[0]) as Map<String, dynamic>;
      barberContent = jsonDecode(results[1]) as Map<String, dynamic>;
      bosContent = jsonDecode(results[2]) as Map<String, dynamic>;
      begraafplaatsContent = jsonDecode(results[3]) as Map<String, dynamic>;

      if (GuestManager.isGuest) {
        playerData = GuestManager.guestProfile;
        latestNewsItem = {
          'log_type': 'welcome',
          'username': storyContent['guest_username'] ?? local?.guestPlayerName ?? 'Gast Reiziger',
          'message': storyContent['guest_welcome_news'] ?? local?.guestWelcomeNews ?? 'Welkom in de wereld van de Gouden Draak als gast!'
        };
        isLoading = false;
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

  Future<bool> handleAlleyPurchase([AppLocalizations? local]) async {
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
        final String fallbackName = local?.alleyBribeDefaultName ?? (storyContent['alley_bribe_default_name'] ?? "Een gure reiziger");
        final String name = playerData?['username'] ?? fallbackName;
        final String message = storyContent['alley_bribe_news'] != null
            ? storyContent['alley_bribe_news'].replaceAll('{name}', name)
            : (local?.alleyBribeNews(name) ?? "$name heeft stiekem wat edelstenen aan Sly overhandigd en ziet er ineens een stuk braver uit.");
        await _supabase.from('daily_news').insert({
          'log_type': 'alley_bribe',
          'username': name,
          'message': message,
        });
      } catch (_) {}

      return true;
    }
    return false;
  }

  Future<bool> handleMightyEPurchase([AppLocalizations? local]) async {
    final int userGems = playerData?['gems'] ?? 0;
    final String currentName = playerData?['username'] ?? "";
    if (userGems < 1) return false;

    final String rawTitles = storyContent['mightye_titles'] ?? (local?.mightyEDefaultTitle ?? "Donateur");
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

  Future<int> handleWeddingPurchase([AppLocalizations? local]) async {
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
        final String fallbackName = local?.defaultTravelerName ?? (storyContent['default_traveler'] ?? "Reiziger");
        await _supabase.from('daily_news').insert({
          'username': playerData?['username'] ?? fallbackName,
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
    
    String message = log['log_text'] ?? log['message'] ?? '';
    if (message.isNotEmpty) {
      message = message.replaceAllMapped(RegExp(r'\bm_\d+_\d+\b'), (match) {
        return getMonsterName(match.group(0)!);
      });
    }
    return message;
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
    if (name.isEmpty) return name;
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
    allTitles.addAll([
      "Donateur", "Patroon", "Grootmeester", "Weldoener", "Mecenas",
      "Sir", "Lady", "Lord", "Baron", "Barones", "Hertog", "Hertogin", "Graaf", "Gravin",
      "Duke", "Duchess", "Count", "Countess", "Legend", "Legende", "Donor", "Patron"
    ]);

    final titles = allTitles
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toSet()
        .toList();

    // Sort descending by length so longer titles match before shorter substrings
    titles.sort((a, b) => b.length.compareTo(a.length));

    bool titleRemoved = true;
    while (titleRemoved) {
      titleRemoved = false;
      clean = clean.trim();
      for (var t in titles) {
        final regStart = RegExp('^$t\\b\\s*', caseSensitive: false);
        if (regStart.hasMatch(clean)) {
          clean = clean.replaceFirst(regStart, '');
          titleRemoved = true;
          break;
        }
        final regWord = RegExp('\\b$t\\b\\s*', caseSensitive: false);
        if (regWord.hasMatch(clean)) {
          clean = clean.replaceAll(regWord, '');
          titleRemoved = true;
          break;
        }
      }
    }

    return clean.trim();
  }
}
