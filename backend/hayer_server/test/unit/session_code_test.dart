import 'dart:math';

import 'package:hayer_server/src/sessions/session_code.dart';
import 'package:test/test.dart';

void main() {
  group('SessionCode', () {
    test('generates three-letter, three-digit codes', () {
      final value = SessionCode.generate(Random(7));

      expect(value, hasLength(SessionCode.length));
      expect(SessionCode.isValid(value), isTrue);
      expect(value, matches(RegExp(r'^[A-Z]{3}[0-9]{3}$')));
    });

    test('accepts formatted current and historical codes', () {
      expect(SessionCode.normalize(' abc-١۲3 '), 'ABC123');
      expect(SessionCode.isValid('abc-123'), isTrue);
      expect(SessionCode.normalize(' q-3 w '), 'Q3W');
      expect(SessionCode.isValid('q3w'), isTrue);
      expect(SessionCode.isValid('A01'), isTrue);
      expect(SessionCode.isValid('Q37'), isTrue);
      expect(SessionCode.isValid('Q3QTWM'), isTrue);
      expect(SessionCode.isValid('QI1'), isFalse);
      expect(SessionCode.isValid('Q3QT'), isFalse);
      expect(SessionCode.isValid('12A-BCD'), isFalse);
    });
  });
}
