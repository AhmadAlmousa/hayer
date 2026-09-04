import 'dart:math';

import 'package:hayer_server/src/sessions/session_code.dart';
import 'package:test/test.dart';

void main() {
  group('SessionCode', () {
    test('generates valid unambiguous three-character values', () {
      final value = SessionCode.generate(Random(7));

      expect(value, hasLength(SessionCode.length));
      expect(SessionCode.isValid(value), isTrue);
      expect(value, isNot(matches(RegExp('[IO10]'))));
    });

    test('accepts legacy codes but rejects invalid alphabets and lengths', () {
      expect(SessionCode.normalize(' q-3 w '), 'Q3W');
      expect(SessionCode.isValid('q3w'), isTrue);
      expect(SessionCode.isValid('Q3QTWM'), isTrue);
      expect(SessionCode.isValid('QI1'), isFalse);
      expect(SessionCode.isValid('Q3QT'), isFalse);
    });
  });
}
