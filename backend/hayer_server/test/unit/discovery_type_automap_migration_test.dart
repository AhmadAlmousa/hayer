import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260918204857510-discovery-type-automap';

  test('auto-mapped types are recorded and the flag defaults on', () async {
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
        'ALTER TABLE "hayer_cache_settings" ADD COLUMN '
        '"discoveryTypeAutoMapEnabled" boolean NOT NULL DEFAULT true;',
      ),
    );
    expect(
      migration,
      contains('CREATE TABLE "hayer_discovery_type_automap"'),
    );
    // One row per observed type: a later run overwrites its own assignment
    // rather than piling up a history of guesses.
    expect(
      migration,
      contains(
        'CREATE UNIQUE INDEX "hayer_discovery_type_automap_key" '
        'ON "hayer_discovery_type_automap" USING btree ("typeKey")',
      ),
    );
    expect(
      definition,
      contains('"discoveryTypeAutoMapEnabled" boolean NOT NULL DEFAULT true'),
    );
    // The custom DDL Serverpod's model cannot express has to be carried into
    // every new definition, or a fresh database loses it.
    expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
    expect(definition, contains('"hayer_discovery_search_trgm"'));
    expect(definition, contains('"photoFetchCount" BETWEEN 1 AND 10'));
    expect(
      definition,
      contains('"discoveryUserHarvestsPerHour" bigint NOT NULL DEFAULT 12'),
    );
  });
}
