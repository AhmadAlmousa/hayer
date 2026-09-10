import 'package:hayer_server/src/places/catalog_spatial_query.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  test('indexed query uses the generated PostGIS location column', () {
    expect(nearbyCatalogByLocationSql, contains('"location"'));
    expect(
      nearbyCatalogByLocationSql,
      contains('ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)'),
    );
  });

  test('fallback query computes geography from stored coordinates', () {
    expect(
      nearbyCatalogByCoordinatesSql,
      contains(
        'ST_MakePoint(catalog."longitude", catalog."latitude")',
      ),
    );
    expect(nearbyCatalogByCoordinatesSql, isNot(contains('\n    "location",')));
  });

  test('both variants filter exact policy before the deterministic bound', () {
    for (final sql in [
      nearbyCatalogByLocationSql,
      nearbyCatalogByCoordinatesSql,
    ]) {
      final limit = sql.indexOf('LIMIT 500');
      expect(
        sql.indexOf('"hayer_poi_category" AS evidence'),
        inInclusiveRange(0, limit),
      );
      expect(sql.indexOf('@categoryIds'), inInclusiveRange(0, limit));
      expect(sql.indexOf('@evidencePrefix'), inInclusiveRange(0, limit));
      expect(sql.indexOf('@maximumPriceLevel'), inInclusiveRange(0, limit));
      expect(sql.indexOf('%permanently closed%'), inInclusiveRange(0, limit));
      expect(sql.indexOf('ORDER BY'), inInclusiveRange(0, limit));
      expect(sql, contains('review_count DESC'));
      expect(sql, contains('rating DESC'));
      expect(sql, contains('distance_meters'));
      expect(sql, contains('"providerPlaceId"'));
    }
  });

  test('fallback is limited to the missing location column error', () {
    expect(
      isMissingCatalogLocation(
        _QueryException(
          message: 'column "location" does not exist',
          code: '42703',
        ),
      ),
      isTrue,
    );
    expect(
      isMissingCatalogLocation(
        _QueryException(message: 'relation does not exist', code: '42P01'),
      ),
      isFalse,
    );
  });
}

final class _QueryException extends DatabaseQueryException {
  _QueryException({required this.message, required this.code});

  @override
  final String message;

  @override
  final String? code;

  @override
  String? get columnName => null;

  @override
  String? get constraintName => null;

  @override
  String? get detail => null;

  @override
  String? get hint => null;

  @override
  int? get position => null;

  @override
  String? get tableName => null;
}
