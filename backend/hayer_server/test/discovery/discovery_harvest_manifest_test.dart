import 'dart:io';

import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_manifest_service.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_plan.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:test/test.dart';

DiscoveryHarvestManifestEntry _entry(
  String id, {
  int order = 0,
  bool enabled = true,
  String? query,
}) => DiscoveryHarvestManifestEntry(
  id: id,
  label: 'Label $id',
  queryEn: query ?? 'query $id',
  fallbackQueryAr: 'استعلام $id',
  sortOrder: order,
  enabled: enabled,
);

void main() {
  group('harvest manifest', () {
    test('the seed has one reviewed-query entry per domain and validates', () {
      final seed = DiscoveryHarvestManifestService.seedEntries();
      expect(seed, hasLength(9));
      expect(DiscoveryHarvestManifestService.validate(seed), isEmpty);
      expect(seed.map((entry) => entry.id), contains('places_of_worship'));
      expect(
        seed.every((entry) => entry.fallbackQueryAr.trim().isNotEmpty),
        isTrue,
      );
    });

    test('validation rejects malformed, duplicate and disabled manifests', () {
      expect(DiscoveryHarvestManifestService.validate(const []), [
        'Add at least one query.',
      ]);
      final errors = DiscoveryHarvestManifestService.validate([
        _entry('Bad id', order: 1),
        _entry('hotels', order: 2, query: 'Hotels'),
        _entry('hotels', order: 2, query: 'hotels', enabled: false),
      ]);
      expect(errors, contains(startsWith('Bad id: an id is')));
      expect(errors, contains('hotels: the id is used more than once.'));
      expect(
        errors,
        contains('hotels: the English query repeats another entry.'),
      );
      expect(errors, contains('hotels: another entry has the same order.'));
      expect(
        DiscoveryHarvestManifestService.validate([
          _entry('only', enabled: false),
        ]),
        ['Enable at least one query.'],
      );
      expect(
        DiscoveryHarvestManifestService.validate([
          for (var i = 0; i < 21; i++) _entry('entry_$i', order: i),
        ]),
        ['A manifest can hold at most 20 queries.'],
      );
    });

    test('normalizes whitespace and orders enabled entries', () {
      final normalized = DiscoveryHarvestManifestService.normalize(
        DiscoveryHarvestManifestEntry(
          id: ' cafes ',
          label: '  Cafes   and bakeries ',
          queryEn: ' cafes\tand  bakeries ',
          fallbackQueryAr: ' مقاهي  ومخابز ',
          sortOrder: 3,
          enabled: true,
        ),
      );
      expect(normalized.id, 'cafes');
      expect(normalized.label, 'Cafes and bakeries');
      expect(normalized.queryEn, 'cafes and bakeries');
      expect(normalized.fallbackQueryAr, 'مقاهي ومخابز');
      expect(
        DiscoveryHarvestManifestService.enabledInOrder([
          _entry('late', order: 20),
          _entry('off', order: 0, enabled: false),
          _entry('b_tie', order: 10),
          _entry('a_tie', order: 10),
        ]).map((entry) => entry.id),
        ['a_tie', 'b_tie', 'late'],
      );
    });
  });

  test('a harvest plan round-trips its manifest snapshot and queries', () {
    final plan = DiscoveryHarvestPlan(
      cell: DiscoveryArea.cell(
        DiscoverViewport(south: 24.70, west: 46.66, north: 24.71, east: 46.67),
        countryCode: 'SA',
      ),
      manifestVersion: 'discovery-manifest-v1',
      manifestRevision: 4,
      manifestEntries: [
        _entry('second', order: 2),
        _entry('first', order: 1),
        _entry('off', order: 0, enabled: false),
      ],
      compatibility: const [
        DiscoveryHarvestQuery(
          id: 'restaurant',
          kind: DiscoveryHarvestQueryKind.compatibility,
          query: 'restaurants',
        ),
      ],
      calibrationVersion: 'calibration-7',
    );
    final decoded = DiscoveryHarvestPlan.decode(plan.encode());
    expect(decoded.cell.cellId, plan.cell.cellId);
    expect(decoded.cell.radiusMeters, plan.cell.radiusMeters);
    expect(decoded.cell.latitude, plan.cell.latitude);
    expect(decoded.manifestRevision, 4);
    expect(decoded.calibrationVersion, 'calibration-7');
    expect(decoded.manifestEntries, hasLength(3));
    expect(decoded.broad.map((query) => query.id), ['first', 'second']);
    expect(decoded.broad.first.fallbackQuery, 'استعلام first');
    expect(decoded.compatibility.single.fallbackQuery, isNull);
    expect(decoded.totalQueries, 3);
    expect(
      () => DiscoveryHarvestPlan.decode('{"v":2}'),
      throwsFormatException,
    );
    expect(() => DiscoveryHarvestPlan.decode('[]'), throwsFormatException);
  });

  group('ProviderOperation.within', () {
    test('spends one budget across sequential steps', () async {
      final operation = ProviderOperation(maximumRequests: 2);
      addTearDown(operation.cancel);
      Future<int> step() async {
        expect(ProviderOperation.current, same(operation));
        ProviderOperation.current!.takeRequest();
        return operation.requestCount;
      }

      expect(await operation.within(step), 1);
      expect(await operation.within(step), 2);
      await expectLater(
        operation.within(step),
        throwsA(isA<PlaceSourceException>()),
      );
      expect(operation.isStopped, isTrue);
      expect(operation.requestCount, 3);
    });

    test('a stopped operation fails the running step at once', () async {
      final operation = ProviderOperation();
      final watch = Stopwatch()..start();
      final step = operation.within(
        () => Future<void>.delayed(const Duration(seconds: 3)),
      );
      operation.cancel('Stopped by the test.');
      await expectLater(step, throwsA(isA<PlaceSourceException>()));
      expect(watch.elapsed, lessThan(const Duration(seconds: 1)));
    });
  });

  test('the M9-E migration adds harvest storage and guards', () async {
    final migrations = Directory('migrations')
        .listSync()
        .whereType<Directory>()
        .where((dir) => dir.path.endsWith('-discovery-harvest-coverage'))
        .toList();
    expect(migrations, hasLength(1));
    final id = migrations.single.uri.pathSegments.lastWhere(
      (segment) => segment.isNotEmpty,
    );
    final registered = await File(
      'migrations/migration_registry.txt',
    ).readAsString();
    final migration = await File('migrations/$id/migration.sql').readAsString();
    final definition = await File(
      'migrations/$id/definition.sql',
    ).readAsString();
    expect(registered, contains(id));
    expect(
      migration,
      contains(
        'ALTER TABLE "hayer_refresh_job" ADD COLUMN "heartbeatAt" '
        'timestamp without time zone;',
      ),
    );
    for (final sql in [migration, definition]) {
      for (final name in [
        'CREATE TABLE "hayer_discovery_harvest_manifest"',
        'CREATE TABLE "hayer_discovery_harvest"',
        'CREATE TABLE "hayer_discovery_coverage"',
        'CREATE TABLE "hayer_discovery_type_observation"',
        '"hayer_refresh_job_active_harvest"',
        '"hayer_discovery_harvest_one_active"',
        '"hayer_discovery_manifest_one_active"',
        '"hayer_discovery_manifest_one_draft"',
        '"hayer_discovery_harvest_values_valid"',
        '"hayer_discovery_coverage_values_valid"',
        '"hayer_discovery_type_observation_values_valid"',
      ]) {
        expect(sql, contains(name));
      }
    }
    // Only an upgrade has existing catalog places to seed type counts from.
    expect(
      migration,
      contains('INSERT INTO "hayer_discovery_type_observation"'),
    );
    expect(
      definition,
      isNot(contains('INSERT INTO "hayer_discovery_type_observation"')),
    );
    expect(definition, contains('"hayer_poi_issue_source_valid"'));
    expect(definition, contains('CREATE EXTENSION IF NOT EXISTS postgis;'));
  });
}
