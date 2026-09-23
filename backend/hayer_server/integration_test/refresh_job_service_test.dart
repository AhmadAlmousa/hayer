import 'dart:async';

import 'package:hayer_server/src/admin/refresh_job_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_place_service.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Refresh job execution',
    (sessionBuilder, _) {
      setUp(() => _resetTables(sessionBuilder));
      tearDown(() => _resetTables(sessionBuilder));

      test('two workers cannot claim the same pending job', () async {
        final setup = sessionBuilder.build();
        try {
          await _seed(setup, 'atomic-claim');
        } finally {
          await setup.close();
        }

        final sessions = [sessionBuilder.build(), sessionBuilder.build()];
        try {
          final claims = await Future.wait([
            RefreshJobService.claimNext(sessions[0]),
            RefreshJobService.claimNext(sessions[1]),
          ]);

          expect(claims.whereType<RefreshJobRow>(), hasLength(1));
          final stored = await _job(sessions[0], 'atomic-claim');
          expect(stored.status, JobStatus.running);
          expect(stored.startedAt, isNotNull);
        } finally {
          for (final session in sessions) {
            await session.close();
          }
        }
      });

      test('only a complete live refresh is marked succeeded', () async {
        final session = sessionBuilder.build();
        try {
          final claimed = await _seedAndClaim(session, 'live');

          await RefreshJobService.executeClaimed(
            session,
            claimed,
            refresh: (_, _, _) async => const CatalogDeckOutcome(
              deck: [],
              origin: CatalogDeckOrigin.live,
            ),
          );

          final stored = await _job(session, 'live');
          expect(stored.status, JobStatus.succeeded);
          expect(stored.completedAt, isNotNull);
          expect(stored.errorCode, isNull);
          final coverage = await _coverage(session, 'live');
          expect(coverage.lastFailureCode, isNull);
          expect(coverage.invalidatedAt, isNull);
        } finally {
          await session.close();
        }
      });

      for (final (name, origin, expectedCode) in [
        (
          'partial',
          CatalogDeckOrigin.partialLive,
          'partial_place_source_unavailable',
        ),
        (
          'fallback',
          CatalogDeckOrigin.staleFallback,
          'stale_fallback_place_source_unavailable',
        ),
      ]) {
        test('$name results are non-green and retain their cause', () async {
          final session = sessionBuilder.build();
          try {
            final claimed = await _seedAndClaim(session, name);

            await RefreshJobService.executeClaimed(
              session,
              claimed,
              refresh: (_, _, _) async => CatalogDeckOutcome(
                deck: const [],
                origin: origin,
                sourceFailureCode: 'place_source_unavailable',
              ),
            );

            final stored = await _job(session, name);
            expect(stored.status, JobStatus.failed);
            expect(stored.errorCode, expectedCode);
            final coverage = await _coverage(session, name);
            expect(coverage.lastFailureCode, expectedCode);
            expect(coverage.invalidatedAt, isNotNull);
          } finally {
            await session.close();
          }
        });
      }

      test('a hard source failure preserves its source code', () async {
        final session = sessionBuilder.build();
        try {
          final claimed = await _seedAndClaim(session, 'failed');

          await RefreshJobService.executeClaimed(
            session,
            claimed,
            refresh: (_, _, _) => throw const PlaceSourceException(
              'rate_limited',
              'Fixture source failure.',
            ),
          );

          final stored = await _job(session, 'failed');
          expect(stored.status, JobStatus.failed);
          expect(stored.errorCode, 'rate_limited');
          expect(
            (await _coverage(session, 'failed')).lastFailureCode,
            'rate_limited',
          );
        } finally {
          await session.close();
        }
      });

      test('cancelling a running job stops its provider operation', () async {
        final session = sessionBuilder.build();
        try {
          final claimed = await _seedAndClaim(session, 'cancelled');
          final started = Completer<void>();
          var providerCancelled = false;
          final execution = RefreshJobService.executeClaimed(
            session,
            claimed,
            refresh: (_, _, register) async {
              final operation = ProviderOperation(
                timeout: const Duration(minutes: 1),
              );
              register(operation);
              operation.onCancel(() => providerCancelled = true);
              started.complete();
              return operation.wait(
                Completer<CatalogDeckOutcome>().future,
              );
            },
          );
          await started.future;
          await RefreshJobRow.db.updateWhere(
            session,
            where: (table) =>
                table.jobId.equals('cancelled') &
                table.status.equals(JobStatus.running),
            columnValues: (table) => [
              table.status(JobStatus.cancelled),
              table.completedAt(DateTime.now().toUtc()),
            ],
          );

          RefreshJobService.cancelActive('cancelled');
          await execution.timeout(const Duration(seconds: 1));

          expect(providerCancelled, isTrue);
          final stored = await _job(session, 'cancelled');
          expect(stored.status, JobStatus.cancelled);
          expect(stored.errorCode, isNull);
          final coverage = await _coverage(session, 'cancelled');
          expect(coverage.lastFailureCode, 'manual_invalidation');
          expect(coverage.invalidatedAt, isNotNull);
        } finally {
          await session.close();
        }
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

Future<RefreshJobRow> _seedAndClaim(Session session, String id) async {
  await _seed(session, id);
  return (await RefreshJobService.claimNext(session))!;
}

Future<void> _seed(Session session, String id) async {
  final now = DateTime.now().toUtc();
  await PoiCoverageRow.db.insertRow(
    session,
    PoiCoverageRow(
      coverageKey: id,
      queryKey: 'restaurant',
      language: 'en',
      countryCode: 'SA',
      anchorLatitude: 24.7136,
      anchorLongitude: 46.6753,
      location: const GeographyPoint(
        longitude: 46.6753,
        latitude: 24.7136,
      ),
      radiusMeters: 3000,
      calibrationVersion: 'fixture',
      resultCount: 20,
      refreshedAt: now,
      expiresAt: now.add(const Duration(hours: 1)),
      lastFailureCode: 'manual_invalidation',
      invalidatedAt: now,
    ),
  );
  await RefreshJobRow.db.insertRow(
    session,
    RefreshJobRow(
      jobId: id,
      coverageKey: id,
      status: JobStatus.pending,
      requestedBy: 'fixture',
      reason: 'Exercise refresh outcome handling.',
      createdAt: now,
    ),
  );
}

Future<RefreshJobRow> _job(Session session, String id) async =>
    (await RefreshJobRow.db.findFirstRow(
      session,
      where: (table) => table.jobId.equals(id),
    ))!;

Future<PoiCoverageRow> _coverage(Session session, String id) async =>
    (await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(id),
    ))!;

Future<void> _resetTables(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_refresh_job",
  "hayer_poi_coverage",
  "hayer_discovery_type_observation",
  "hayer_discovery_harvest",
  "hayer_discovery_coverage",
  "hayer_taxonomy_version"
CASCADE
''');
  } finally {
    await session.close();
  }
}
