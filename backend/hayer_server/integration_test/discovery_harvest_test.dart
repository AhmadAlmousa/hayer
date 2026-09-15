import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/admin/refresh_job_service.dart';
import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_manifest_service.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_place_service.dart';
import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';
import 'harvest_fixtures.dart';

final class _NoSource implements PlaceSource {
  @override
  Future<List<PlaceCandidate>> search({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int desiredCount,
    required String language,
    required String countryCode,
  }) => throw StateError('Swipe should read the harvested cache.');
}

void main() {
  withServerpod(
    'Discover harvests',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final alice = discoveryMember(builder, 'harvest-alice');
      final bob = discoveryMember(builder, 'harvest-bob');
      final admin = AdminEndpoint.forTesting(
        authorizer: (_) async => 'operator',
      );
      final productionSource = DiscoveryHarvestService.sourceFor;
      final productionCalibration =
          DiscoveryHarvestService.calibrationVersionFor;
      final manifest = DiscoveryHarvestManifestService.seedEntries();
      final cooldownEnds = fixtureNow.add(const Duration(minutes: 60));
      late DiscoveryHarvestCell cell;
      late FixtureHarvestSource source;
      late List<AdminTaxonomyItem> swipe;

      void useSource(
        Future<List<PlaceCandidate>> Function(HarvestFetch fetch) respond,
      ) {
        source = FixtureHarvestSource(respond);
        DiscoveryHarvestService.sourceFor = (_, _) async => source;
      }

      /// One result per page, each a distinct place: no continuation pages.
      Future<List<PlaceCandidate>> onePlace(HarvestFetch _) async => [
        harvestCandidate('p${source.fetches.length}', cell),
      ];

      Future<T> withSession<T>(
        Future<T> Function(Session session) action,
      ) async {
        final session = builder.build();
        try {
          return await action(session);
        } finally {
          await session.close();
        }
      }

      Future<void> setPolicy([
        DiscoveryPolicy Function(DiscoveryPolicy discovery)? adjust,
      ]) => withSession((session) => useDiscoveryPolicy(session, adjust));

      setUp(() async {
        await withSession(resetHarvests);
        DiscoveryHarvestService.clock = () => fixtureNow;
        DiscoveryHarvestService.calibrationVersionFor = (_) async =>
            harvestCalibration;
        pinDiscoveryClock(fixtureNow);
        cell = riyadhCell();
        useSource(onePlace);
        await setPolicy();
        swipe = await withSession(swipeCategories);
      });

      tearDown(() async {
        DiscoveryHarvestService.sourceFor = productionSource;
        DiscoveryHarvestService.calibrationVersionFor = productionCalibration;
        DiscoveryHarvestService.clock = () => DateTime.now().toUtc();
        restoreDiscoveryClock();
        await withSession(resetHarvests);
      });

      Future<DiscoveryAreaReceipt> ensure(
        TestSessionBuilder user, [
        DiscoverViewport? viewport,
      ]) => endpoints.discover.ensureArea(
        user,
        viewport: viewport ?? cellView(cell),
      );

      Future<DiscoveryHarvestRow> harvestRow(String jobId) => withSession(
        (session) async => (await DiscoveryHarvestRow.db.findFirstRow(
          session,
          where: (table) => table.jobId.equals(jobId),
        ))!,
      );

      Future<RefreshJobRow> jobRow(String jobId) => withSession(
        (session) async => (await RefreshJobRow.db.findFirstRow(
          session,
          where: (table) => table.jobId.equals(jobId),
        ))!,
      );

      Map<String, DiscoveryHarvestQueryOutcome> outcomesOf(
        DiscoveryHarvestRow harvest,
      ) => {
        for (final outcome in harvest.queryOutcomes)
          '${outcome.entryId}/${outcome.languageCode}': outcome,
      };

      test(
        'a cold committed search enqueues one job that users and jitter join',
        () async {
          final first = await ensure(alice);
          final job = first.job!;
          expect(job.state, DiscoveryHarvestState.pending);
          expect(job.trigger, DiscoveryHarvestTrigger.committedSearch);
          expect(job.manifestRevision, 1);
          expect(job.totalQueries, manifest.length + swipe.length);
          expect(job.bounds.south, closeTo(cell.bounds.south, 1e-9));
          expect(job.bounds.east, closeTo(cell.bounds.east, 1e-9));
          expect(first.retryAfter, isNull);
          expect(first.coverage.footprints, isEmpty);
          expect(first.coverage.pendingJobs.single.jobId, job.jobId);

          final joined = await Future.wait([
            ensure(bob, cellView(cell, northMetres: 120, eastMetres: 90)),
            ensure(alice, cellView(cell, northMetres: -80, eastMetres: -110)),
            endpoints.discover.deepen(
              bob,
              viewport: cellView(cell),
              idempotencyKey: 'bob-deepen-joins',
            ),
          ]);
          expect(joined.map((receipt) => receipt.job!.jobId).toSet(), {
            job.jobId,
          });

          await withSession((session) async {
            expect(await DiscoveryHarvestRow.db.count(session), 1);
            final queued = (await RefreshJobRow.db.find(session)).single;
            expect(queued.planJson, isNotNull);
            expect(
              queued.coverageKey,
              'discovery:SA:${cell.cellId}:1000:m1:$harvestCalibration',
            );
            expect(queued.requestedBy, startsWith('user:'));
            expect(queued.requestedBy, isNot(contains('alice')));
            expect(queued.reason, 'discover:committedSearch');
            // Only the request that created the job spent a harvest.
            final limits = await RateLimitRow.db.find(session);
            expect(limits.map((row) => row.counterKey), [
              'discovery-harvest:harvest-alice',
            ]);
            // Storage refuses a second active job for the same key.
            await expectLater(
              RefreshJobRow.db.insertRow(
                session,
                queued.copyWith(id: null, jobId: 'duplicate-job'),
              ),
              throwsA(isA<Exception>()),
            );
          });

          final polled = await endpoints.discover.harvestStatus(
            bob,
            jobId: job.jobId,
          );
          expect(polled.state, DiscoveryHarvestState.pending);
          await expectLater(
            endpoints.discover.harvestStatus(bob, jobId: 'missing-job'),
            throwsA(apiError('not_found')),
          );
          final elsewhere = await ensure(
            alice,
            cellView(cell, northMetres: 3000),
          );
          expect(elsewhere.job!.jobId, isNot(job.jobId));
        },
      );

      test(
        'a harvest stores every observation with genuine Swipe evidence',
        () async {
          final receipt = await ensure(alice);
          await runHarvests(builder);

          final status = await endpoints.discover.harvestStatus(
            alice,
            jobId: receipt.job!.jobId,
          );
          expect(status.state, DiscoveryHarvestState.succeeded);
          expect(status.completedQueries, status.totalQueries);
          expect(status.observedPlaces, source.fetches.length);
          expect(status.failureCode, isNull);
          expect(status.retryAfter, cooldownEnds);
          expect(source.fetches.map((fetch) => fetch.query), [
            for (final entry in manifest) entry.queryEn,
            for (final category in swipe) category.searchQueryEn,
          ]);
          expect(
            source.fetches.every(
              (fetch) =>
                  fetch.offset == 0 &&
                  fetch.language == 'en' &&
                  fetch.radiusMeters == 1000 &&
                  fetch.countryCode == 'SA' &&
                  fetch.latitude == cell.latitude &&
                  fetch.longitude == cell.longitude,
            ),
            isTrue,
          );
          final fetched = source.fetches.length;

          await withSession((session) async {
            final job = await jobRow(receipt.job!.jobId);
            expect(job.status, JobStatus.succeeded);
            expect(job.errorCode, isNull);
            expect(job.heartbeatAt, isNotNull);
            final harvest = await harvestRow(receipt.job!.jobId);
            expect(harvest.upstreamRequests, fetched);
            expect(
              harvest.queryOutcomes.map((outcome) => outcome.state).toSet(),
              {DiscoveryHarvestQueryState.succeeded},
            );
            expect(await PoiCatalogRow.db.count(session), fetched);

            // Only compatibility results carry Swipe category evidence.
            final evidence = await PoiCategoryRow.db.find(session);
            expect(
              evidence.map((row) => row.categoryId).toSet(),
              swipe.map((category) => category.id).toSet(),
            );
            expect(evidence, hasLength(swipe.length));
            final coverage = await PoiCoverageRow.db.find(session);
            expect(coverage, hasLength(swipe.length));
            for (final category in swipe) {
              final row = coverage.singleWhere(
                (row) =>
                    row.coverageKey ==
                    catalogCoverageKey(
                      categoryIds: [category.id],
                      countryCode: 'SA',
                      latitude: cell.latitude,
                      longitude: cell.longitude,
                      radiusMeters: 1000,
                    ),
              );
              expect(row.queryKey, category.id);
              expect(row.resultCount, 1);
              expect(row.calibrationVersion, harvestCalibration);
              expect(row.invalidatedAt, isNull);
            }

            final area = (await DiscoveryCoverageRow.db.find(session)).single;
            expect(
              area.queryCompletedAt.keys.toSet(),
              manifest.map((entry) => entry.id).toSet(),
            );
            expect(area.lastAttemptAt, fixtureNow);
            expect(area.lastSuccessAt, fixtureNow);
            expect(area.lastFailureCode, isNull);
          });

          // A fresh repeat search makes no provider request.
          final again = await ensure(bob, cellView(cell, eastMetres: 60));
          expect(again.job, isNull);
          expect(again.retryAfter, isNull);
          final footprint = again.coverage.footprints.single;
          expect(footprint.cellId, cell.cellId);
          expect(footprint.completedQueryGroups, hasLength(manifest.length));
          expect(footprint.incompleteQueryGroups, isEmpty);
          expect(footprint.lastSuccessAt, fixtureNow);
          expect(footprint.retryAfter, cooldownEnds);
          expect(again.coverage.eligibleCatalogCount, fetched);
          final page = await endpoints.discover.browse(
            alice,
            query: discoverQuery(viewport: cellView(cell)),
            pageSize: 50,
            includeMap: false,
          );
          expect(page.total, fetched);
          expect(
            page.coverage.footprints.single.incompleteQueryGroups,
            isEmpty,
          );
          expect(page.coverage.pendingJobs, isEmpty);
          expect(source.fetches, hasLength(fetched));

          await withSession((session) async {
            // A matching Swipe search reads the compatibility pass's evidence
            // and coverage from cache; broad-only places stay out.
            final category = swipe.first;
            final expected =
                'p${source.fetches.lastIndexWhere((fetch) => fetch.query == category.searchQueryEn) + 1}';
            final deck =
                await CatalogPlaceService(
                  source: _NoSource(),
                  calibrationVersion: harvestCalibration,
                ).buildDeck(
                  session,
                  categoryId: category.id,
                  subcategoryIds: const [],
                  latitude: cell.latitude,
                  longitude: cell.longitude,
                  radiusMeters: 1000,
                  deckSize: 1,
                  countryCode: 'SA',
                );
            expect(deck.map((place) => place.placeId), [expected]);

            final metrics = await OperationalMetricRow.db.find(
              session,
              where: (table) => table.metricName.like('growth.%'),
            );
            int sum(String name, String operation) => metrics
                .where(
                  (row) =>
                      row.metricName == 'growth.$name' &&
                      row.dimensions['operation'] == operation,
                )
                .fold(0, (total, row) => total + row.metricValue.round());
            expect(sum('upstreamRequests', 'harvest'), fetched);
            expect(sum('observations', 'harvest'), fetched);
            expect(sum('newCatalogPlaces', 'harvest'), fetched);
            expect(sum('cacheMisses', 'browse'), 1);
            expect(sum('cacheHits', 'browse'), 1);
            expect(sum('cacheHits', 'search'), 1);
          });
        },
      );

      test(
        'full first pages still reach every domain before continuation',
        () async {
          useSource(
            (_) async => [
              for (var index = 0; index < 5; index++)
                harvestCandidate('p${source.fetches.length}-$index', cell),
            ],
          );
          final receipt = await ensure(alice);
          await runHarvests(builder);

          final first = [
            for (final entry in manifest) entry.queryEn,
            for (final category in swipe) category.searchQueryEn,
          ];
          final order = [
            for (final fetch in source.fetches)
              '${fetch.query}@${fetch.offset}',
          ];
          // The default budget is 24 requests.
          expect(order, hasLength(24));
          expect(order.take(first.length), [
            for (final query in first) '$query@0',
          ]);
          // Continuation pages go round-robin, a round per page offset.
          final continuation = [
            for (var round = 1; round < 10; round++)
              for (final query in first) '$query@${round * 5}',
          ];
          expect(
            order.skip(first.length),
            continuation.take(24 - first.length),
          );

          final harvest = await harvestRow(receipt.job!.jobId);
          expect(harvest.state, DiscoveryHarvestState.succeeded);
          expect(harvest.upstreamRequests, 24);
          expect(harvest.observedPlaces, 24 * 5);
          final stopped = harvest.queryOutcomes.singleWhere(
            (outcome) => outcome.failureCode != null,
          );
          expect(stopped.failureCode, 'budget_exhausted');
          // The page that found the budget spent is the next one in turn.
          final stopIndex = 24 - first.length;
          expect(stopped.query, first[stopIndex % first.length]);
          expect(stopped.pagesAttempted, stopIndex ~/ first.length + 2);
          expect(stopped.state, DiscoveryHarvestQueryState.succeeded);
        },
      );

      test(
        'a partial harvest keeps its results, marks the rest and cools down',
        () async {
          await setPolicy(
            (discovery) => discovery.copyWith(harvestMaximumRequests: 4),
          );
          useSource((fetch) async {
            if (fetch.query == manifest[1].queryEn) {
              throw const PlaceSourceException(
                'place_source_unavailable',
                'Fixture failure.',
              );
            }
            return onePlace(fetch);
          });
          final receipt = await ensure(alice);
          await runHarvests(builder);

          expect(source.fetches.map((fetch) => fetch.query), [
            for (final entry in manifest.take(4)) entry.queryEn,
          ]);
          final status = await endpoints.discover.harvestStatus(
            alice,
            jobId: receipt.job!.jobId,
          );
          expect(status.state, DiscoveryHarvestState.partial);
          expect(status.completedQueries, 3);
          expect(status.failureCode, 'budget_exhausted');
          expect(status.retryAfter, cooldownEnds);

          final harvest = await harvestRow(receipt.job!.jobId);
          final outcomes = outcomesOf(harvest);
          expect(harvest.upstreamRequests, 4);
          expect(
            outcomes['${manifest[0].id}/en']!.state,
            DiscoveryHarvestQueryState.succeeded,
          );
          expect(
            outcomes['${manifest[1].id}/en']!.failureCode,
            'place_source_unavailable',
          );
          expect(
            outcomes['${manifest[4].id}/en']!.failureCode,
            'budget_exhausted',
          );
          for (final entry in manifest.skip(5)) {
            expect(
              outcomes['${entry.id}/en']!.state,
              DiscoveryHarvestQueryState.unattempted,
            );
          }
          for (final category in swipe) {
            expect(
              outcomes['${category.id}/en']!.state,
              DiscoveryHarvestQueryState.unattempted,
            );
          }
          final job = await jobRow(receipt.job!.jobId);
          expect(job.status, JobStatus.failed);
          expect(job.errorCode, 'partial_budget_exhausted');
          await withSession((session) async {
            final area = (await DiscoveryCoverageRow.db.find(session)).single;
            expect(area.queryCompletedAt.keys.toSet(), {
              manifest[0].id,
              manifest[2].id,
              manifest[3].id,
            });
            expect(area.lastAttemptAt, fixtureNow);
            expect(area.lastSuccessAt, isNull);
            expect(area.lastFailureCode, 'budget_exhausted');
            expect(await PoiCoverageRow.db.count(session), 0);
            expect(await PoiCatalogRow.db.count(session), 3);
          });

          final cooling = await ensure(bob);
          expect(cooling.job!.jobId, receipt.job!.jobId);
          expect(cooling.job!.state, DiscoveryHarvestState.partial);
          expect(cooling.retryAfter, cooldownEnds);
          final footprint = cooling.coverage.footprints.single;
          expect(footprint.incompleteQueryGroups, hasLength(6));
          expect(footprint.lastSuccessAt, isNull);
          expect(footprint.retryAfter, cooldownEnds);
          final deepened = await endpoints.discover.deepen(
            bob,
            viewport: cellView(cell),
            idempotencyKey: 'bob-deepens-too-soon',
          );
          expect(deepened.job!.jobId, receipt.job!.jobId);
          expect(deepened.retryAfter, cooldownEnds);
          await withSession(
            (session) async =>
                expect(await DiscoveryHarvestRow.db.count(session), 1),
          );

          DiscoveryHarvestService.clock = () =>
              fixtureNow.add(const Duration(minutes: 61));
          final retried = await ensure(bob);
          expect(retried.job!.jobId, isNot(receipt.job!.jobId));
          expect(retried.job!.state, DiscoveryHarvestState.pending);
        },
      );

      test('retries and Arabic fallbacks run after every first page', () async {
        final empty = manifest[0];
        final failing = manifest[1];
        var failingAttempts = 0;
        useSource((fetch) async {
          if (fetch.query == empty.queryEn) return const [];
          if (fetch.query == failing.queryEn) {
            failingAttempts++;
            throw const PlaceSourceException(
              'place_source_unavailable',
              'Fixture failure.',
            );
          }
          return onePlace(fetch);
        });
        final receipt = await ensure(alice);
        await runHarvests(builder);

        final firstPages = manifest.length + swipe.length;
        expect(
          [
            for (final fetch in source.fetches.skip(firstPages))
              '${fetch.language}:${fetch.query}',
          ],
          [
            'en:${failing.queryEn}',
            'ar:${empty.fallbackQueryAr}',
            'ar:${failing.fallbackQueryAr}',
          ],
        );
        expect(failingAttempts, 2);
        final harvest = await harvestRow(receipt.job!.jobId);
        final outcomes = outcomesOf(harvest);
        expect(harvest.state, DiscoveryHarvestState.succeeded);
        expect(
          outcomes['${empty.id}/en']!.state,
          DiscoveryHarvestQueryState.empty,
        );
        expect(
          outcomes['${empty.id}/ar']!.state,
          DiscoveryHarvestQueryState.succeeded,
        );
        expect(
          outcomes['${failing.id}/en']!.state,
          DiscoveryHarvestQueryState.failed,
        );
        expect(outcomes['${failing.id}/en']!.pagesAttempted, 2);
        expect(
          outcomes['${failing.id}/ar']!.state,
          DiscoveryHarvestQueryState.succeeded,
        );
        expect(harvest.completedQueries, harvest.totalQueries);
      });

      test(
        'the per-user harvest budget answers rate_limited with a wait',
        () async {
          await setPolicy(
            (discovery) => discovery.copyWith(userHarvestsPerHour: 1),
          );
          final other = cellView(cell, northMetres: 5000);
          await ensure(alice);
          await expectLater(
            ensure(alice, other),
            throwsA(
              apiError('rate_limited').having(
                (error) => error.retryAfterSeconds,
                'retryAfterSeconds',
                inInclusiveRange(1, 3600),
              ),
            ),
          );
          final bobs = await ensure(bob, other);
          // Joining another user's job spends nothing.
          final joined = await ensure(alice, other);
          expect(joined.job!.jobId, bobs.job!.jobId);
          await withSession(
            (session) async =>
                expect(await DiscoveryHarvestRow.db.count(session), 2),
          );
        },
      );

      test(
        'Deepen keeps its retry key, joins jobs and honours the cooldown',
        () async {
          final view = cellView(cell);
          await expectLater(
            endpoints.discover.deepen(
              alice,
              viewport: view,
              idempotencyKey: 'short',
            ),
            throwsA(apiError('bad_request')),
          );
          final first = await endpoints.discover.deepen(
            alice,
            viewport: view,
            idempotencyKey: 'alice-deepen-1',
          );
          expect(first.job!.trigger, DiscoveryHarvestTrigger.deepen);
          final retried = await endpoints.discover.deepen(
            alice,
            viewport: view,
            idempotencyKey: 'alice-deepen-1',
          );
          expect(retried.job!.jobId, first.job!.jobId);
          await expectLater(
            endpoints.discover.deepen(
              alice,
              viewport: cellView(cell, northMetres: 4000),
              idempotencyKey: 'alice-deepen-1',
            ),
            throwsA(apiError('conflict')),
          );
          await runHarvests(builder);

          final cooling = await endpoints.discover.deepen(
            alice,
            viewport: view,
            idempotencyKey: 'alice-deepen-2',
          );
          expect(cooling.job!.jobId, first.job!.jobId);
          expect(cooling.job!.state, DiscoveryHarvestState.succeeded);
          expect(cooling.retryAfter, cooldownEnds);
          expect((await ensure(bob)).job, isNull);

          // Deepen ignores freshness once the cooldown has passed.
          DiscoveryHarvestService.clock = () =>
              fixtureNow.add(const Duration(minutes: 61));
          final again = await endpoints.discover.deepen(
            alice,
            viewport: view,
            idempotencyKey: 'alice-deepen-3',
          );
          expect(again.job!.jobId, isNot(first.job!.jobId));
          expect(again.job!.state, DiscoveryHarvestState.pending);
          expect((await ensure(bob)).job!.jobId, again.job!.jobId);
        },
      );

      test('operators and a disabled flag cancel queued harvests', () async {
        final queued = await ensure(alice);
        await withSession(
          (session) => admin.cancelRefreshJob(
            session,
            jobId: queued.job!.jobId,
            reason: 'Checking the queue.',
          ),
        );
        final cancelled = await endpoints.discover.harvestStatus(
          alice,
          jobId: queued.job!.jobId,
        );
        expect(cancelled.state, DiscoveryHarvestState.cancelled);
        expect(cancelled.retryAfter, isNull);
        await runHarvests(builder);
        expect(source.fetches, isEmpty);

        // A cancelled job does not cool the cell down.
        final second = await ensure(bob);
        expect(second.job!.jobId, isNot(queued.job!.jobId));
        await withSession((session) async {
          final policy = await admin.policy(session);
          await admin.updatePolicy(
            session,
            reason: 'Pause Discover for the test.',
            policy: policy.copyWith(
              discovery: policy.discovery!.copyWith(enabled: false),
            ),
          );
        });
        final harvest = await harvestRow(second.job!.jobId);
        expect(harvest.state, DiscoveryHarvestState.cancelled);
        expect(harvest.failureCode, 'feature_disabled');
        final job = await jobRow(second.job!.jobId);
        expect(job.status, JobStatus.cancelled);
        await runHarvests(builder);
        expect(source.fetches, isEmpty);
      });

      test('a running harvest stops at its next page when stopped', () async {
        final disabled = await ensure(alice);
        useSource((fetch) async {
          if (source.fetches.length == 2) {
            await withSession(
              (session) => useDiscoveryPolicy(
                session,
                (discovery) => discovery.copyWith(enabled: false),
              ),
            );
          }
          return onePlace(fetch);
        });
        await runHarvests(builder);
        expect(source.fetches, hasLength(2));
        var harvest = await harvestRow(disabled.job!.jobId);
        expect(harvest.state, DiscoveryHarvestState.cancelled);
        expect(harvest.failureCode, 'feature_disabled');
        expect(
          harvest.queryOutcomes.map((outcome) => outcome.state).take(3),
          [
            DiscoveryHarvestQueryState.succeeded,
            DiscoveryHarvestQueryState.succeeded,
            DiscoveryHarvestQueryState.unattempted,
          ],
        );
        expect(
          (await jobRow(disabled.job!.jobId)).status,
          JobStatus.cancelled,
        );
        await withSession((session) async {
          final area = (await DiscoveryCoverageRow.db.find(session)).single;
          expect(area.queryCompletedAt, hasLength(2));
          expect(area.lastAttemptAt, isNull);
        });

        // An operator's cancellation stops the page in flight.
        await setPolicy();
        final operated = await ensure(bob, cellView(cell, northMetres: 3000));
        useSource((fetch) async {
          await withSession(
            (session) => admin.cancelRefreshJob(
              session,
              jobId: operated.job!.jobId,
              reason: 'Stop this harvest.',
            ),
          );
          return onePlace(fetch);
        });
        await runHarvests(builder);
        expect(source.fetches, hasLength(1));
        harvest = await harvestRow(operated.job!.jobId);
        expect(harvest.state, DiscoveryHarvestState.cancelled);
        expect(harvest.failureCode, 'cancelled');
        expect(harvest.queryOutcomes.first.failureCode, 'cancelled');
        expect(harvest.completedAt, isNotNull);
      });

      test(
        'recovery requeues only harvests whose heartbeat went quiet',
        () async {
          final receipt = await ensure(alice);
          await withSession((session) async {
            final claimed = (await RefreshJobService.claimNext(session))!;
            expect(claimed.heartbeatAt, claimed.startedAt);
            await DiscoveryHarvestRow.db.updateWhere(
              session,
              where: (table) => table.jobId.equals(claimed.jobId),
              columnValues: (table) => [
                table.state(DiscoveryHarvestState.running),
              ],
            );
            final now = DateTime.now().toUtc();
            await RefreshJobRow.db.updateWhere(
              session,
              where: (table) => table.jobId.equals(claimed.jobId),
              columnValues: (table) => [
                table.startedAt(now.subtract(const Duration(minutes: 10))),
                table.heartbeatAt(now.subtract(const Duration(minutes: 1))),
              ],
            );
            await RefreshJobService.recoverInterruptedJobs(session);
            expect((await jobRow(claimed.jobId)).status, JobStatus.running);

            await RefreshJobRow.db.updateWhere(
              session,
              where: (table) => table.jobId.equals(claimed.jobId),
              columnValues: (table) => [
                table.heartbeatAt(now.subtract(const Duration(minutes: 6))),
              ],
            );
            await RefreshJobService.recoverInterruptedJobs(session);
            final recovered = await jobRow(claimed.jobId);
            expect(recovered.status, JobStatus.pending);
            expect(recovered.startedAt, isNull);
            expect(recovered.heartbeatAt, isNull);
            expect(
              (await harvestRow(claimed.jobId)).state,
              DiscoveryHarvestState.pending,
            );
          });
          await runHarvests(builder);
          final status = await endpoints.discover.harvestStatus(
            alice,
            jobId: receipt.job!.jobId,
          );
          expect(status.state, DiscoveryHarvestState.succeeded);
        },
      );
    },
  );
}
