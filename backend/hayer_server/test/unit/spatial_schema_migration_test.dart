import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260901083702427-spatial-schema-repair';
  const latestMigrationId = '20260902143335499-visit-scheduling';
  final migrationDirectory = Directory('migrations/$migrationId');

  group('spatial schema migration', () {
    test('remains registered before the current migration', () async {
      final entries = await File(
        'migrations/migration_registry.txt',
      ).readAsLines();
      final migrationIds = entries
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty && !line.startsWith('#'))
          .toList();

      expect(migrationIds, contains(migrationId));
      expect(migrationIds.last, latestMigrationId);
      expect(
        migrationIds.indexOf(migrationId),
        lessThan(migrationIds.length - 1),
      );
    });

    test('current definition preserves custom PostGIS DDL', () async {
      final sql = await File(
        'migrations/$latestMigrationId/definition.sql',
      ).readAsString();
      final migration = await File(
        'migrations/$latestMigrationId/migration.sql',
      ).readAsString();

      expect(sql, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
      expect(sql, contains('"location" geography(Point, 4326)'));
      expect(sql, contains('"visitAt" timestamp without time zone'));
      expect(
        migration,
        contains("{3}([ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{3})?"),
      );
    });

    test('repairs existing databases idempotently', () async {
      final sql = await File(
        '${migrationDirectory.path}/migration.sql',
      ).readAsString();

      expect(sql, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
      expect(
        sql,
        contains('ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)'),
      );
      expect(
        sql,
        contains('CREATE INDEX IF NOT EXISTS "hayer_poi_location_gist"'),
      );
      expect(sql, contains('ON "hayer_poi_catalog" USING gist ("location")'));
      expect(sql, contains("VALUES ('hayer', '$migrationId', now())"));
    });

    test('includes custom PostGIS DDL in fresh database definition', () async {
      final sql = await File(
        '${migrationDirectory.path}/definition.sql',
      ).readAsString();
      final definition = await File(
        '${migrationDirectory.path}/definition.json',
      ).readAsString();

      expect(sql, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
      expect(
        sql,
        contains('ADD COLUMN IF NOT EXISTS "location" geography(Point, 4326)'),
      );
      expect(
        sql,
        contains('CREATE INDEX IF NOT EXISTS "hayer_poi_location_gist"'),
      );
      expect(sql, contains('ON "hayer_poi_catalog" USING gist ("location")'));
      expect(sql, contains("VALUES ('hayer', '$migrationId', now())"));
      expect(definition, contains('"version": "$migrationId"'));
    });
  });
}
