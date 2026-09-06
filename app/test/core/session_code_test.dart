import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/session_code.dart';

void main() {
  group('session codes', () {
    test('extracts current and historical codes from public join URLs', () {
      expect(
        extractSessionCode('https://hayer.almou.sa/join/abc-١۲3'),
        'ABC123',
      );
      expect(extractSessionCode('https://hayer.almou.sa/join/a37'), 'A37');
      expect(extractSessionCode('https://hayer.almou.sa/app/join/a37'), 'A37');
      expect(extractSessionCode('Z٧٠'), 'Z70');
      expect(extractSessionCode('https://hayer.almou.sa/app/join/Z۷۰'), 'Z70');
    });

    test('accepts current and historical codes but rejects invalid values', () {
      expect(isValidSessionCode('ABC-019'), isTrue);
      expect(isValidSessionCode('Q37'), isTrue);
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

    test('formats only the new code shape with a dash', () {
      expect(formatSessionCode('abc019'), 'ABC-019');
      expect(formatSessionCode('ABC-01'), 'ABC-01');
      expect(formatSessionCode('Q37'), 'Q37');
      expect(formatSessionCode('Q3QTWM'), 'Q3QTWM');
    });
  });
}
