// lib/services/profanity_filter_service.dart
class ProfanityFilterService {
  static final List<String> _bannedWords = [
    // Dutch profanity / slurs
    'kut', 'hufter', 'lul', 'kanker', 'godverdomme', 'tering', 'tyfus', 'kolere', 'pleuris', 'schijt', 'godver', 'homo', 'mongool', 'mokkel', 'eikel', 'trut', 'hoer', 'teringlijer',
    // English profanity / slurs
    'fuck', 'shit', 'bitch', 'asshole', 'dick', 'cunt', 'bastard', 'slut', 'whore', 'motherfucker', 'piss', 'cock', 'fag', 'nigger', 'retard'
  ];

  static String clean(String text) {
    if (text.isEmpty) return text;
    String cleaned = text;
    for (final word in _bannedWords) {
      final pattern = RegExp(r'\b' + word + r'\b', caseSensitive: false);
      cleaned = cleaned.replaceAllMapped(pattern, (match) => r'*#$!*');
    }
    for (final word in _bannedWords) {
      if (word.length >= 4) {
        final reg = RegExp(word, caseSensitive: false);
        cleaned = cleaned.replaceAllMapped(reg, (match) => r'*#$!*');
      }
    }
    return cleaned;
  }
}
