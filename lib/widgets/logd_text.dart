// lib/widgets/logd_text.dart
import 'package:flutter/material.dart';
import '../theme/logd_codes.dart'; // Importeer je centrale styles!

class LogdText extends StatelessWidget {
  final String text;
  final double? fontSize; // Maak nullable om de centrale fallback te gebruiken

  const LogdText({
    super.key,
    required this.text,
    this.fontSize, // Geen hardcoded default meer hier
  });

  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s.toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // Pak de meegegeven grootte, of val terug op je ideale grotere centrale stand (17.0)!
    final double effectiveFontSize = fontSize ?? LogdCodes.fontSizeDefault;

    return RichText(
      text: TextSpan(
        children: _parseText(text, effectiveFontSize),
        style: TextStyle(
          fontFamily: LogdCodes.retroFont, // DE FIX: Direct gekoppeld aan 'RetroFont' met schreef!
          fontSize: effectiveFontSize,
          height: 1.3,
        ),
      ),
    );
  }

  List<TextSpan> _parseText(String rawText, double effectiveFontSize) {
    List<TextSpan> spans = [];
    Color currentColor = const Color(0xFFFFFFFF);

    // Splits op het retro ` teken
    List<String> parts = rawText.split('`');

    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (part.isEmpty) continue;

      if (i > 0 && part.isNotEmpty) {
        // De kleurcode is het allereerste karakter na de `
        String code = part[0];
        String actualText = part.substring(1);

        switch (code) {
          case '4':
            currentColor = LogdCodes.uiRed; // Netjes gekoppeld aan je centrale UI kleuren!
            break;
          case '2':
            currentColor = LogdCodes.uiGreen;
            break;
          case 'y':
            currentColor = LogdCodes.uiYellow;
            break;
          case 'c':
            currentColor = LogdCodes.uiBlue;
            break;
          case 'p':
            currentColor = LogdCodes.uiPurple;
            break;
          case 'o':
            currentColor = LogdCodes.uiOrange;
            break;
          case 'w':
          default:
            currentColor = const Color(0xFFFFFFFF);
            break;
        }

        if (actualText.isNotEmpty) {
          spans.add(TextSpan(
            text: actualText,
            style: TextStyle(
              color: currentColor,
              fontFamily: LogdCodes.retroFont, // DE FIX: Garandeert dat het lettertype ook na een kleurwissel behouden blijft
              fontSize: effectiveFontSize,
            ),
          ));
        }
      } else {
        spans.add(TextSpan(
          text: part,
          style: TextStyle(
            color: currentColor,
            fontFamily: LogdCodes.retroFont,
            fontSize: effectiveFontSize,
          ),
        ));
      }
    }

    return spans;
  }
}
