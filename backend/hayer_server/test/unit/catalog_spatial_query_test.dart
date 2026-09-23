import 'package:hayer_server/src/places/catalog_spatial_query.dart';
import 'package:test/test.dart';

void main() {
  test('indexed query uses the generated PostGIS location column', () {
    expect(nearbyCatalogByLocationSql, contains('"location"'));
    expect(
      nearbyCatalogByLocationSql,
      contains('ST_SetSRID(ST_MakePoint(@longitude, @latitude), 4326)'),
    );
  });

  test('filters exact policy before the deterministic bound', () {
    final sql = nearbyCatalogByLocationSql;
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
  });
}
