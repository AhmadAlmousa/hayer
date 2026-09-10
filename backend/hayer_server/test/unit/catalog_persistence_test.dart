import 'package:hayer_server/src/places/catalog_persistence.dart';
import 'package:test/test.dart';

void main() {
  test('catalog write is one ordered atomic upsert', () {
    expect(catalogBatchUpsertSql, contains('json_to_recordset'));
    expect(
      catalogBatchUpsertSql,
      contains('ORDER BY input."providerPlaceId"'),
    );
    expect(
      catalogBatchUpsertSql,
      contains('ON CONFLICT ("provider", "providerPlaceId") DO UPDATE'),
    );
    final merge = catalogBatchUpsertSql.split('DO UPDATE SET').last;
    expect(merge, isNot(contains('"firstSeenAt" =')));
    expect(merge, isNot(contains('"quarantinedAt" =')));
    expect(merge, isNot(contains('"quarantineReason" =')));
    expect(merge, contains('GREATEST(catalog."lastSeenAt"'));
  });

  test('evidence write is batched, versioned and reconciles snapshots', () {
    expect(catalogEvidenceBatchUpsertSql, contains('json_to_recordset'));
    expect(
      catalogEvidenceBatchUpsertSql,
      contains('ORDER BY input."providerPlaceId", input."categoryId"'),
    );
    expect(
      catalogEvidenceBatchUpsertSql,
      contains(
        'ON CONFLICT ("provider", "providerPlaceId", "categoryId")',
      ),
    );
    expect(catalogEvidenceBatchUpsertSql, contains('@evidencePrefix'));
    expect(catalogEvidenceBatchUpsertSql, contains("'{categoryIds}'"));
    expect(catalogEvidencePrefix('cal-3'), 'hayer-v2:cal-3:');
  });

  test('coverage write uses a freshness-ordered upsert', () {
    expect(
      catalogCoverageUpsertSql,
      contains('ON CONFLICT ("coverageKey") DO UPDATE'),
    );
    expect(
      catalogCoverageUpsertSql,
      contains(
        'WHERE EXCLUDED."refreshedAt" >= coverage."refreshedAt"',
      ),
    );
    expect(catalogCoverageUpsertSql, contains('"invalidatedAt" = NULL'));
  });
}
