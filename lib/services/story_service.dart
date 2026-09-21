// lib/services/story_service.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class StoryService {
  // Laadt dynamic de juiste JSON-content in op basis van de taal van de app
  static Future<Map<String, dynamic>> loadLocationContent(
    BuildContext context,
    String fileName,
  ) async {
    try {
      // 1. Detecteer live of de telefoon op NL of EN staat ingesteld
      final String languageCode = Localizations.localeOf(context).languageCode;

      // 2. Bouw het dynamic pad naar de assets (bijv: assets/story/nl/locatie_dorpsplein.json)
      final String assetPath = 'assets/story/$languageCode/$fileName.json';

      // 3. Lees het bestand van de schijf en converteer de JSON-string naar een Dart Map
      final String jsonString = await rootBundle.loadString(assetPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      // Fallback naar NL mocht er onverhoopt iets misgaan of een vertaling ontbreken
      final String jsonString = await rootBundle.loadString(
        'assets/story/nl/$fileName.json',
      );
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
  }
}
