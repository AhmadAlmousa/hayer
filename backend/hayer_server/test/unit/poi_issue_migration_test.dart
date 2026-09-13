import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260909025500100-poi-issue-reports';

  test('POI issue migration enforces the moderation lifecycle', () async {
    final registered = await File(
      'migrations/migration_registry.txt',
    ).readAsString();
    final migration = await File(
      'migrations/$migrationId/migration.sql',
    ).readAsString();
    final definition = await File(
      'migrations/$migrationId/definition.sql',
    ).readAsString();
    final adminProtocol = await File(
      'lib/src/protocol/admin_poi_issue.spy.yaml',
    ).readAsString();

    expect(registered, contains(migrationId));
    for (final sql in [migration, definition]) {
      expect(sql, contains('hayer_poi_issue_report'));
      expect(sql, contains('hayer_poi_issue_values_valid'));
      expect(sql, contains('hayer_poi_issue_active_dedupe'));
      expect(sql, contains('hayer_poi_issue_status_created'));
      expect(sql, contains("'wrongCategory'"));
      expect(sql, contains("'misleadingPhoto'"));
      expect(sql, contains('"sourceEvidence" IS NOT NULL'));
      expect(sql, contains('"activeDedupeKey" IS NULL'));
    }
    expect(adminProtocol, isNot(contains('reporterHash')));
    // Discovery adds optional navigation context; reporter correlation remains
    // private and older responses need not include either new field.
    expect(adminProtocol, contains('sessionId: String?'));
    expect(adminProtocol, contains('source: PoiIssueSource?'));
  });
}
