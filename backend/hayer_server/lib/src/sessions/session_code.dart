import 'dart:math';

class SessionCode {
  const SessionCode._();

  static const length = 3;
  static const legacyLength = 6;
  static const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  static final _pattern = RegExp(
    '^([$alphabet]{$length}|[$alphabet]{$legacyLength})\$',
  );

  static String normalize(String value) =>
      value.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

  static bool isValid(String value) => _pattern.hasMatch(normalize(value));

  static String generate(Random random) => List.generate(
    length,
    (_) => alphabet[random.nextInt(alphabet.length)],
  ).join();
}
