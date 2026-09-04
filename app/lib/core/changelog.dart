import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef ChangelogReader = Future<String?> Function();
typedef ChangelogWriter = Future<void> Function(String version);

const appChanges = <String, Map<String, List<String>>>{
  '0.1.0': {
    'en': [
      'More reliable session links, QR joining, and live group updates.',
      'Interactive search-radius maps and faster location setup.',
      'Arabic language selection and refreshed Material 3 Expressive styling.',
    ],
    'ar': [
      'روابط جلسات ومسح QR وتحديثات جماعية أكثر موثوقية.',
      'خريطة تفاعلية لنطاق البحث وتجهيز أسرع للموقع.',
      'اختيار العربية وتصميم Material 3 Expressive محدّث.',
    ],
  },
};

class ChangelogController {
  ChangelogController({
    ChangelogReader? read,
    ChangelogWriter? write,
  }) : _read = read ?? _defaultRead,
       _write = write ?? _defaultWrite;

  static const _key = 'hayer.last-seen-version';
  static const _storage = FlutterSecureStorage();
  final ChangelogReader _read;
  final ChangelogWriter _write;

  Future<List<String>> unseenChanges(
    String currentVersion,
    String languageCode,
  ) async {
    final saved = await _read();
    if (saved == null) {
      await _write(currentVersion);
      return const [];
    }
    if (saved == currentVersion) return const [];
    final versions = appChanges.keys.toList()..sort(_compareVersions);
    final changes = <String>[];
    for (final version in versions) {
      if (_compareVersions(version, saved) > 0 &&
          _compareVersions(version, currentVersion) <= 0) {
        changes.addAll(
          appChanges[version]![languageCode] ?? appChanges[version]!['en']!,
        );
      }
    }
    await _write(currentVersion);
    return changes;
  }

  static Future<String?> _defaultRead() => _storage.read(key: _key);
  static Future<void> _defaultWrite(String value) =>
      _storage.write(key: _key, value: value);
}

int _compareVersions(String left, String right) {
  final a = left.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  final b = right.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  for (var index = 0; index < 3; index++) {
    final result = (index < a.length ? a[index] : 0).compareTo(
      index < b.length ? b[index] : 0,
    );
    if (result != 0) return result;
  }
  return 0;
}
