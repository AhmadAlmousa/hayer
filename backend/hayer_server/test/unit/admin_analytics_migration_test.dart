import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260905132740811-admin-analytics-taxonomy';

  test(
    'analytics migration adds bounded aggregates and anonymous backfill',
    () async {
      final migration = await File(
        'migrations/$migrationId/migration.sql',
      ).readAsString();
      final definition = await File(
        'migrations/$migrationId/definition.sql',
      ).readAsString();

      expect(migration, contains('hayer_product_analytics_event'));
      expect(migration, contains('hayer_product_analytics_hour'));
      expect(migration, contains("'unknown', 'Unknown'"));
      expect(migration, contains('hayer_analytics_event_unprocessed'));
      expect(definition, contains('hayer_taxonomy_single_active'));
      expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
    },
  );
}
