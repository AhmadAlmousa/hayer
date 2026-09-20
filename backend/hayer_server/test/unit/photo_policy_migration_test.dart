import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260918132049087-photo-policy';

  test('photo settings are migrated and bounded', () async {
    final registered = await File(
      'migrations/migration_registry.txt',
    ).readAsString();
    final migration = await File(
      'migrations/$migrationId/migration.sql',
    ).readAsString();
    final definition = await File(
      'migrations/$migrationId/definition.sql',
    ).readAsString();
    final settingsRow = await File(
      'lib/src/storage/cache_settings_row.spy.yaml',
    ).readAsString();
    final policy = await File(
      'lib/src/protocol/photo_policy.spy.yaml',
    ).readAsString();
    final cachePolicy = await File(
      'lib/src/protocol/cache_policy.spy.yaml',
    ).readAsString();

    expect(registered, contains(migrationId));

    // Existing rows take the defaults, so the new bounds hold immediately.
    for (final column in const [
      ('photoFetchCount', '6'),
      ('photoWidth', '1200'),
      ('photoCacheCount', '400'),
      ('photoCacheDays', '14'),
    ]) {
      expect(
        migration,
        contains(
          'ALTER TABLE "hayer_cache_settings" ADD COLUMN "${column.$1}" '
          'bigint NOT NULL DEFAULT ${column.$2};',
        ),
      );
      expect(definition, contains('"${column.$1}" bigint NOT NULL'));
    }

    // A CHECK cannot be extended in place, so the upgrade recreates it, and a
    // fresh database gets the same bounds from the definition.
    expect(
      migration,
      contains(
        'DROP CONSTRAINT IF EXISTS "hayer_discovery_policy_valid";',
      ),
    );
    for (final sql in [migration, definition]) {
      expect(sql, contains('ADD CONSTRAINT "hayer_discovery_policy_valid"'));
      expect(sql, contains('"photoFetchCount" BETWEEN 1 AND 10'));
      expect(sql, contains('"photoWidth" BETWEEN 400 AND 2400'));
      expect(sql, contains('"photoCacheCount" BETWEEN 20 AND 2000'));
      expect(sql, contains('"photoCacheDays" BETWEEN 1 AND 90'));
    }

    // Serverpod regenerates the definition from the models alone, so the DDL
    // it cannot represent has to be carried forward by hand each time.
    expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
    expect(definition, contains('CREATE EXTENSION IF NOT EXISTS pg_trgm;'));
    expect(definition, contains('"hayer_discovery_search_trgm"'));
    expect(definition, contains('"hayer_cache_policy_valid"'));
    expect(definition, contains('hayer_discovery_normalize'));
    expect(definition, contains('"hayer_poi_location_gist"'));

    expect(settingsRow, contains('photoFetchCount: int, default=6'));
    expect(settingsRow, contains('photoWidth: int, default=1200'));
    expect(settingsRow, contains('photoCacheCount: int, default=400'));
    expect(settingsRow, contains('photoCacheDays: int, default=14'));
    expect(policy, contains('class: PhotoPolicy'));
    // Nullable, so an older client omitting it never resets the stored values.
    expect(cachePolicy, contains('photos: PhotoPolicy?'));
  });
}
