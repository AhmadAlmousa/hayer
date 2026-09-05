import 'dart:io';

import 'package:test/test.dart';

void main() {
  const migrationId = '20260904163500000-session-code-digits';

  test(
    'latest migration permits every decimal digit in generated codes',
    () async {
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

      expect(registered, contains(migrationId));
      expect(migration, contains(r"^[A-HJ-NP-Z][0-9]{2}$"));
      expect(definition, contains(r"^[A-HJ-NP-Z][0-9]{2}$"));
      expect(
        migration,
        contains('DROP CONSTRAINT IF EXISTS "hayer_session_values_valid"'),
      );
    },
  );

  test('clean join links accept every decimal digit', () async {
    final configuration = await File('../deploy/nginx.conf').readAsString();

    expect(configuration, contains('[A-HJ-NP-Za-hj-np-z0-9]'));
    expect(configuration, isNot(contains('[A-HJ-NP-Za-hj-np-z2-9]')));
  });
}
