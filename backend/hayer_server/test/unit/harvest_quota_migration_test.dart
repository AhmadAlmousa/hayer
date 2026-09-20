import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260918135454420-harvest-quota';

  test(
    'the per-user harvest allowance is raised for camera-led searches',
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
      expect(
        migration,
        contains(
          'ALTER TABLE "hayer_cache_settings" ALTER COLUMN '
          '"discoveryUserHarvestsPerHour" SET DEFAULT 12;',
        ),
      );
      // There is exactly one settings row, and a new default never reaches it.
      expect(migration, contains('UPDATE "hayer_cache_settings"'));
      expect(
        migration,
        contains('"discoveryUserHarvestsPerHour" = 3'),
        reason: 'only an untouched value should be raised',
      );
      expect(
        definition,
        contains('"discoveryUserHarvestsPerHour" bigint NOT NULL DEFAULT 12'),
      );
      // The ceiling is unchanged: this raises a default, not the safe bounds.
      expect(
        definition,
        contains('"discoveryUserHarvestsPerHour" BETWEEN 1 AND 60'),
      );
      expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
      expect(definition, contains('"hayer_discovery_search_trgm"'));
      expect(definition, contains('"photoFetchCount" BETWEEN 1 AND 10'));
    },
  );
}
