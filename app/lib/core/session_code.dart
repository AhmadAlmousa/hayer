const sessionCodeLength = 6;
const shortLegacySessionCodeLength = 3;
const legacySessionCodeLength = 6;
const sessionCodeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
const sessionCodeLetterAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const legacySessionCodeLetterAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ';
const sessionCodeDigitAlphabet = '0123456789';

final RegExp _sessionCodePattern = RegExp(
  '[$sessionCodeLetterAlphabet]{3}[$sessionCodeDigitAlphabet]{3}|'
  '[$legacySessionCodeLetterAlphabet][$sessionCodeDigitAlphabet]{2}|'
  '[$sessionCodeAlphabet]{$shortLegacySessionCodeLength}|'
  '[$sessionCodeAlphabet]{$legacySessionCodeLength}',
  caseSensitive: false,
);

String? extractSessionCode(String value) {
  final localized = normalizeSessionCodeCharacters(value.trim());
  final uri = Uri.tryParse(localized);
  if (uri != null) {
    final segments = uri.pathSegments.where((part) => part.isNotEmpty).toList();
    final joinIndex = segments.length == 3 && segments.first == 'app' ? 1 : 0;
    if (segments.length == joinIndex + 2 &&
        segments[joinIndex].toLowerCase() == 'join') {
      final code = normalizeSessionCodeInput(segments.last);
      return isValidSessionCode(code) ? code : null;
    }
  }

  final normalized = normalizeSessionCodeInput(localized);
  return isValidSessionCode(normalized) ? normalized : null;
}

bool isValidSessionCode(String value) => RegExp(
  '^(?:${_sessionCodePattern.pattern})'
  r'$',
).hasMatch(normalizeSessionCodeInput(value));

String normalizeSessionCodeInput(String value) =>
    normalizeSessionCodeCharacters(
      value,
    ).toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');

String formatSessionCode(String value) {
  final normalized = normalizeSessionCodeInput(value);
  if (RegExp(r'^[A-Z]{3}[0-9]{1,3}$').hasMatch(normalized)) {
    return '${normalized.substring(0, 3)}-${normalized.substring(3)}';
  }
  return normalized;
}

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
