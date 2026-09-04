import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260904222500000-continuous-search-radius';
  const continuousRadiusCheck = '"radiusMeters" BETWEEN 500 AND 10000';

  test('latest migration permits radii selected by the editable map', () async {
    final registry = await File(
      'migrations/migration_registry.txt',
    ).readAsLines();
    final registered = registry
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty && !line.startsWith('#'))
        .toList();
    final migration = await File(
      'migrations/$migrationId/migration.sql',
    ).readAsString();
    final definition = await File(
      'migrations/$migrationId/definition.sql',
    ).readAsString();

    expect(registered.last, migrationId);
    expect(continuousRadiusCheck.allMatches(migration), hasLength(2));
    expect(continuousRadiusCheck.allMatches(definition), hasLength(2));
    expect(
      migration,
      contains('DROP CONSTRAINT IF EXISTS "hayer_coverage_values_valid"'),
    );
    expect(
      migration,
      contains('DROP CONSTRAINT IF EXISTS "hayer_session_values_valid"'),
    );
  });
}
