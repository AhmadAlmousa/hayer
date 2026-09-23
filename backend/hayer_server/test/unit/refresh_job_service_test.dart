import 'package:hayer_server/src/admin/refresh_job_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('RefreshJobPlan', () {
    test('replays broad coverage with a useful minimum deck size', () {
      final plan = RefreshJobPlan.fromCoverage(
        _coverage(queryKey: 'restaurant', resultCount: 4),
      );

      expect(plan.categoryId, 'restaurant');
      expect(plan.subcategoryIds, isEmpty);
      expect(plan.deckSize, 20);
      expect(plan.countryCode, 'SA');
    });

    test('sorts valid subcategories and caps the refresh size', () {
      final plan = RefreshJobPlan.fromCoverage(
        _coverage(
          queryKey: 'pizza,restaurant,hamburger',
          resultCount: 80,
        ),
      );

      expect(plan.categoryId, 'restaurant');
      expect(plan.subcategoryIds, ['hamburger', 'pizza']);
      expect(plan.deckSize, 50);
    });

    test('rejects coverage without a top-level category', () {
      expect(
        () => RefreshJobPlan.fromCoverage(
          _coverage(queryKey: 'pizza', resultCount: 20),
        ),
        throwsFormatException,
      );
    });

    test('rejects a subcategory from another category', () {
      expect(
        () => RefreshJobPlan.fromCoverage(
          _coverage(queryKey: 'restaurant,coffee_shop', resultCount: 20),
        ),
        throwsFormatException,
      );
    });
  });
}

PoiCoverageRow _coverage({
  required String queryKey,
  required int resultCount,
}) => PoiCoverageRow(
  coverageKey: 'coverage-key',
  queryKey: queryKey,
  language: 'en',
  countryCode: 'SA',
  anchorLatitude: 24.7136,
  anchorLongitude: 46.6753,
  location: const GeographyPoint(longitude: 46.6753, latitude: 24.7136),
  radiusMeters: 3000,
  calibrationVersion: 'test',
  resultCount: resultCount,
  refreshedAt: DateTime.utc(2026),
  expiresAt: DateTime.utc(2026, 1, 2),
);
