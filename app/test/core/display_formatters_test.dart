import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/display_formatters.dart';

void main() {
  test('formats GCC phone numbers into readable groups', () {
    // Behavior under test: a phone number is recognizable at a glance.
    expect(formatPhoneNumber('+966551234567'), '+966 55 123 4567');
    expect(formatPhoneNumber('971501234567'), '+971 50 123 4567');
  });

  test('keeps non-GCC numbers readable without inventing a country code', () {
    expect(formatPhoneNumber('1234567'), '1 234 567');
    expect(formatPhoneNumber('not available'), 'not available');
  });
}
