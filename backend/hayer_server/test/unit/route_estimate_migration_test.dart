import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260907165202325-route-estimates';

  test('route estimate policy migration is current and bounded', () async {
    final registered = (await File(
      'migrations/migration_registry.txt',
    ).readAsLines()).where((line) => line.trim().isNotEmpty).toList();
    final migration = await File(
      'migrations/$migrationId/migration.sql',
    ).readAsString();
    final definition = await File(
      'migrations/$migrationId/definition.sql',
    ).readAsString();

    expect(registered.last, migrationId);
    for (final field in const [
      'routeEstimatesEnabled',
      'allowParticipantLocation',
      'defaultRouteOrigin',
      'routeEstimateCacheMinutes',
      'routeRequestsPerMinute',
      'routeBurst',
    ]) {
      expect(migration, contains('"$field"'));
      expect(definition, contains('"$field"'));
    }
    expect(
      migration,
      contains('"routeEstimateCacheMinutes" BETWEEN 1 AND 120'),
    );
    expect(migration, contains("'participantLocation'"));
  });
}
