// lib/theme/logd_codes.dart
import 'package:flutter/material.dart';

class LogdCodes {
  // De BBS tekst-kleurcodes
  static const String red = '`4';
  static const String green = '`2';
  static const String yellow = '`y';
  static const String cyan = '`c';
  static const String white = '`w';
  static const String purple = '`p';
  static const String orange = '`o';

  // --- CENTRALE TEXT-SIZES ---
  static const double fontSizeDefault = 16.5;
  static const double fontSizeCardTitle = 16.5;

  // --- CENTRALE LETTERTYPEN ---
  // DE RETRO FIX: We veranderen dit naar 'monospace'.
  // Dit dwingt Flutter om de nostalgische schreef-systeemletter te gebruiken!
  static const String retroFont = 'monospace';

  // ... (behoud de rest van je centrale UI-kleuren zoals ze stonden)
  static const String colorVictory = green;
  static const String colorLoss = orange;
  static const String colorGold = yellow;
  static const String colorInfo = cyan;

  static const Color uiGreen = Color(0xFF00FF66);
  static const Color uiOrange = Color(0xFFFF9100);
  static const Color uiYellow = Color(0xFFFFEA00);
  static const Color uiBlue = Color(0xFF00E5FF);
  static const Color uiRed = Color(0xFFFF3333);
  static const Color uiPurple = Color(0xFFE040FB);
  static const Color uiMagenta = Color(0xFFFF00FF);
  static const Color uiChurch = Color(0xFFE0E0E0);
}
