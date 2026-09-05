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
  final normalized = normalizeSessionCodeInput(value);
  if (isValidSessionCode(normalized)) return normalized;

  final uri = Uri.tryParse(normalizeSessionCodeCharacters(value.trim()));
  if (uri == null) return null;
  final segments = uri.pathSegments.where((part) => part.isNotEmpty).toList();
  final joinIndex = segments.length == 3 && segments.first == 'app' ? 1 : 0;
  if (segments.length != joinIndex + 2 ||
      segments[joinIndex].toLowerCase() != 'join') {
    return null;
  }
  final code = normalizeSessionCodeInput(segments.last);
  return isValidSessionCode(code) ? code : null;
}

bool isValidSessionCode(String value) => RegExp(
  '^(?:${_sessionCodePattern.pattern})'
  r'$',
).hasMatch(normalizeSessionCodeInput(value));

String normalizeSessionCodeInput(String value) =>
    normalizeSessionCodeCharacters(value).trim().toUpperCase();

String normalizeSessionCodeCharacters(String value) => value
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
    .replaceAll('۹', '9');
