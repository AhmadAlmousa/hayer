const sessionCodeLength = 3;
const legacySessionCodeLength = 6;
const maxSessionCodeLength = legacySessionCodeLength;
const sessionCodeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
const sessionCodeLetterAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
const sessionCodeDigitAlphabet = '0123456789';

final RegExp _sessionCodePattern = RegExp(
  '[$sessionCodeLetterAlphabet][$sessionCodeDigitAlphabet]{2}|'
  '[$sessionCodeAlphabet]{$sessionCodeLength}|'
  '[$sessionCodeAlphabet]{$legacySessionCodeLength}',
  caseSensitive: false,
);

String? extractSessionCode(String value) {
  final trimmed = value.trim();
  if (isValidSessionCode(trimmed)) return trimmed.toUpperCase();

  final uri = Uri.tryParse(trimmed);
  if (uri == null) return null;
  final segments = uri.pathSegments.where((part) => part.isNotEmpty).toList();
  final joinIndex = segments.length == 3 && segments.first == 'app' ? 1 : 0;
  if (segments.length != joinIndex + 2 ||
      segments[joinIndex].toLowerCase() != 'join') {
    return null;
  }
  final code = segments.last;
  return isValidSessionCode(code) ? code.toUpperCase() : null;
}

bool isValidSessionCode(String value) => RegExp(
  '^(?:${_sessionCodePattern.pattern})'
  r'$',
).hasMatch(value.toUpperCase());
