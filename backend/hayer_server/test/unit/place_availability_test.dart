import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/place_availability.dart';
import 'package:test/test.dart';

void main() {
  group('PlaceAvailability', () {
    test('converts UTC to the place country before checking hours', () {
      final hours = [
        OpeningPeriod(
          day: DateTime.wednesday,
          openMinutes: 9 * 60,
          closeMinutes: 17 * 60,
          overnight: false,
        ),
      ];

      expect(
        PlaceAvailability.isOpenDuring(
          hours,
          visitAt: DateTime.utc(2026, 9, 2, 7),
          countryCode: 'SA',
        ),
        isTrue,
      );
      expect(
        PlaceAvailability.isOpenDuring(
          hours,
          visitAt: DateTime.utc(2026, 9, 2, 15),
          countryCode: 'SA',
        ),
        isFalse,
      );
    });

    test('carries overnight ranges into the following day', () {
      final hours = [
        OpeningPeriod(
          day: DateTime.friday,
          openMinutes: 20 * 60,
          closeMinutes: 2 * 60,
          overnight: true,
        ),
      ];

      expect(
        PlaceAvailability.isOpenDuring(
          hours,
          visitAt: DateTime.utc(2026, 9, 4, 22),
          countryCode: 'SA',
        ),
        isTrue,
      );
    });

    test('keeps places with unknown hours eligible', () {
      expect(
        PlaceAvailability.isOpenDuring(
          const [],
          visitAt: DateTime.utc(2026, 9, 2),
          countryCode: 'SA',
        ),
        isTrue,
      );
    });
  });
}
