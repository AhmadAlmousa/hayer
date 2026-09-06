import 'dart:math';

class SessionCode {
  const SessionCode._();

  static const length = 6;
  static const shortLegacyLength = 3;
  static const legacyLength = 6;
  static const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  static const letterAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const digitAlphabet = '0123456789';
  static final _pattern = RegExp(
    '^([$letterAlphabet]{3}[$digitAlphabet]{3}|'
    '[ABCDEFGHJKLMNPQRSTUVWXYZ][$digitAlphabet]{2}|'
    '[$alphabet]{$shortLegacyLength}|[$alphabet]{$legacyLength})\$',
  );

  static String normalize(String value) => value
      .replaceAll('٠', '0')
      .replaceAll('١', '1')
      .replaceAll('٢', '2')
      .replaceAll('٣', '3')
      .replaceAll('٤', '4')
      .replaceAll('٥', '5')
      .replaceAll('٦', '6')
      .replaceAll('٧', '7')
      .replaceAll('٨', '8')
      .replaceAll('٩', '9')
      .replaceAll('۰', '0')
      .replaceAll('۱', '1')
      .replaceAll('۲', '2')
      .replaceAll('۳', '3')
      .replaceAll('۴', '4')
      .replaceAll('۵', '5')
      .replaceAll('۶', '6')
      .replaceAll('۷', '7')
      .replaceAll('۸', '8')
      .replaceAll('۹', '9')
      .toUpperCase()
      .replaceAll(RegExp('[^A-Z0-9]'), '');

  static bool isValid(String value) => _pattern.hasMatch(normalize(value));

  static String generate(Random random) => [
    for (var index = 0; index < 3; index++)
      letterAlphabet[random.nextInt(letterAlphabet.length)],
    for (var index = 0; index < 3; index++)
      digitAlphabet[random.nextInt(digitAlphabet.length)],
  ].join();
}
