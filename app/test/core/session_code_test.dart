import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/session_code.dart';

void main() {
  group('session codes', () {
    test('extracts a three-character code from a public join URL', () {
      expect(extractSessionCode('https://hayer.almou.sa/join/q3w'), 'Q3W');
      expect(extractSessionCode('https://hayer.almou.sa/app/join/q3w'), 'Q3W');
    });

    test('accepts new and legacy codes but rejects invalid values', () {
      expect(isValidSessionCode('Q3W'), isTrue);
      expect(isValidSessionCode('Q3QTWM'), isTrue);
      expect(
        extractSessionCode('https://hayer.almou.sa/join/Q3QTWM'),
        'Q3QTWM',
      );
      expect(isValidSessionCode('QI1'), isFalse);
      expect(isValidSessionCode('Q3QT'), isFalse);
      expect(extractSessionCode('https://example.com/not-a-join/Q3W'), isNull);
    });
  });
}
