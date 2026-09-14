import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260914073223386-discovery-policy-taxonomy';

  test(
    'Discover policy and taxonomy storage is registered and guarded',
    () async {
      final registered = await File(
        'migrations/migration_registry.txt',
      ).readAsString();
      final migration = await File(
        'migrations/$migrationId/migration.sql',
      ).readAsString();
      final definition = await File(
        'migrations/$migrationId/definition.sql',
      ).readAsString();

      expect(registered, contains(migrationId));
      for (final sql in [migration, definition]) {
        expect(
          sql,
          contains('"discoveryEnabled" boolean NOT NULL DEFAULT false'),
        );
        expect(sql, contains('"discoveryBestFormula"'));
        expect(sql, contains('"detailRefreshMaximumRequests"'));
        expect(sql, contains('hayer_discovery_taxonomy'));
        expect(sql, contains('hayer_discovery_taxonomy_one_active'));
        expect(sql, contains('hayer_discovery_taxonomy_one_draft'));
        expect(sql, contains('WHERE "status" = \'active\''));
        expect(sql, contains('WHERE "status" = \'draft\''));
      }
    },
  );
}
