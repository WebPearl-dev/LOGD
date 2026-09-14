import 'package:flutter/material.dart';

class LogdText extends StatelessWidget {
  final String text;
  final double fontSize;

  const LogdText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
  });

  static String capitalize(String s) {
    if (s.isEmpty) return s;
    return s.toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseText(text),
        style: TextStyle(
          fontFamily: 'Courier',
          fontSize: fontSize,
          height: 1.3,
        ),
      ),
    );
  }

  List<TextSpan> _parseText(String rawText) {
    List<TextSpan> spans = [];
    Color currentColor = const Color(0xFFFFFFFF);
    List<String> parts = rawText.split('`');

    for (int i = 0; i < parts.length; i++) {
      String part = parts[i];
      if (part.isEmpty) continue;

      // GECORRIGEERD: Maakt nu efficiënt gebruik van .isNotEmpty in plaats van .length checks!
      if (i > 0 && part.isNotEmpty) {
        String code = part;
        String actualText = part.substring(1);

        switch (code) {
          case '4':
            currentColor = const Color(0xFFFF3333);
            break;
          case '2':
            currentColor = const Color(0xFF00FF66);
            break;
          case 'y':
            currentColor = const Color(0xFFFFEA00);
            break;
          case 'c':
            currentColor = const Color(0xFF00E5FF);
            break;
          case 'p':
            currentColor = const Color(0xFFD500F9);
            break;
          case 'o':
            currentColor = const Color(0xFFFF9100);
            break;
          case 'w':
          default:
            currentColor = const Color(0xFFFFFFFF);
            break;
        }

        if (actualText.isNotEmpty) {
          spans.add(TextSpan(text: actualText, style: TextStyle(color: currentColor)));
        }
      } else {
        spans.add(TextSpan(text: part, style: TextStyle(color: currentColor)));
      }
    }

    return spans;
  }
}
