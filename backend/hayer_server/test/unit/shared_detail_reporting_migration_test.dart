import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260915070806721-shared-detail-reporting';

  test('shared detail refresh and sessionless reports are migrated', () async {
    final registered = await File(
      'migrations/migration_registry.txt',
    ).readAsString();
    final migration = await File(
      'migrations/$migrationId/migration.sql',
    ).readAsString();
    final definition = await File(
      'migrations/$migrationId/definition.sql',
    ).readAsString();
    final reportRow = await File(
      'lib/src/storage/poi_issue_report_row.spy.yaml',
    ).readAsString();

    expect(registered, contains(migrationId));
    expect(
      migration,
      contains(
        'ALTER TABLE "hayer_poi_issue_report" ALTER COLUMN "sessionId" '
        'DROP NOT NULL;',
      ),
    );
    expect(
      migration,
      contains(
        'ALTER TABLE "hayer_poi_issue_report" ADD COLUMN "source" text '
        "NOT NULL DEFAULT 'session'::text;",
      ),
    );
    expect(definition, contains('"sessionId" text,\n'));
    expect(definition, contains('"source" text NOT NULL DEFAULT \'session\''));
    for (final sql in [migration, definition]) {
      expect(sql, contains('CREATE TABLE "hayer_poi_detail_refresh"'));
      expect(sql, contains('"hayer_poi_detail_refresh_identity"'));
      expect(sql, contains('"hayer_poi_detail_refresh_values_valid"'));
      expect(sql, contains('"hayer_poi_issue_source_valid"'));
      expect(
        sql,
        contains('("source" = \'discovery\' AND "sessionId" IS NULL)'),
      );
    }
    // Fresh databases regain the report lifecycle constraint and keep the
    // custom PostGIS and Discover DDL.
    expect(definition, contains('"hayer_poi_issue_values_valid"'));
    expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
    expect(definition, contains('"hayer_discovery_search_trgm"'));
    expect(reportRow, contains('sessionId: String?'));
    expect(reportRow, contains('source: PoiIssueSource, default=session'));
  });
}
