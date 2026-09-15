import 'package:hayer_server/src/admin/admin_endpoint.dart';
import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_observation_writer.dart';
import 'package:hayer_server/src/storage/catalog_pruner.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';
import 'harvest_fixtures.dart';

void main() {
  withServerpod(
    'Discover harvest administration',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final alice = discoveryMember(builder, 'admin-harvest-alice');
      final bob = discoveryMember(builder, 'admin-harvest-bob');
      final admin = AdminEndpoint.forTesting(
        authorizer: (_) async => 'operator',
      );
      final productionSource = DiscoveryHarvestService.sourceFor;
      final productionCalibration =
          DiscoveryHarvestService.calibrationVersionFor;
      late DiscoveryHarvestCell cell;
      late FixtureHarvestSource source;
      late int swipeQueries;

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

      setUp(() async {
        await withSession(resetHarvests);
        DiscoveryHarvestService.clock = () => fixtureNow;
        DiscoveryHarvestService.calibrationVersionFor = (_) async =>
            harvestCalibration;
        pinDiscoveryClock(fixtureNow);
        cell = riyadhCell();
        source = FixtureHarvestSource(
          (_) async => [harvestCandidate('p${source.fetches.length}', cell)],
        );
        DiscoveryHarvestService.sourceFor = (_, _) async => source;
        await withSession((session) => useDiscoveryPolicy(session));
        swipeQueries = (await withSession(swipeCategories)).length;
      });

      tearDown(() async {
        DiscoveryHarvestService.sourceFor = productionSource;
        DiscoveryHarvestService.calibrationVersionFor = productionCalibration;
        DiscoveryHarvestService.clock = () => DateTime.now().toUtc();
        restoreDiscoveryClock();
        await withSession(resetHarvests);
      });

      test(
        'the manifest lifecycle is validated, audited and used by new harvests',
        () async {
          await withSession((session) async {
            final draft = await admin.discoveryHarvestManifestDraft(session);
            expect(draft.status, DiscoveryManifestStatus.draft);
            expect(draft.revision, 1);
            expect(draft.entries, hasLength(9));

            final invalid = await admin.saveDiscoveryHarvestManifestDraft(
              session,
              reason: 'Try a duplicate entry.',
              version: draft.version,
              revision: draft.revision,
              entries: [...draft.entries, draft.entries.first],
            );
            expect(invalid.revision, 2);
            expect(invalid.validationErrors, isNotEmpty);
            final failed = await admin.validateDiscoveryHarvestManifestDraft(
              session,
              reason: 'Check the duplicate.',
              version: draft.version,
              revision: invalid.revision,
            );
            expect(failed.passed, isFalse);
            await expectLater(
              admin.publishDiscoveryHarvestManifest(
                session,
                reason: 'Publish the invalid draft.',
                version: draft.version,
                revision: invalid.revision,
              ),
              throwsA(apiError('conflict')),
            );
            await expectLater(
              admin.saveDiscoveryHarvestManifestDraft(
                session,
                reason: 'Save over a stale revision.',
                version: draft.version,
                revision: draft.revision,
                entries: draft.entries,
              ),
              throwsA(apiError('conflict')),
            );

            final bakeries = DiscoveryHarvestManifestEntry(
              id: 'bakeries',
              label: 'Bakeries',
              queryEn: '  bakeries ',
              fallbackQueryAr: 'مخابز',
              sortOrder: 95,
              enabled: true,
            );
            final valid = await admin.saveDiscoveryHarvestManifestDraft(
              session,
              reason: 'Add bakeries.',
              version: draft.version,
              revision: invalid.revision,
              entries: [...draft.entries, bakeries],
            );
            expect(valid.entries.last.queryEn, 'bakeries');
            final passed = await admin.validateDiscoveryHarvestManifestDraft(
              session,
              reason: 'Validate bakeries.',
              version: draft.version,
              revision: valid.revision,
            );
            expect(passed.passed, isTrue);
            final published = await admin.publishDiscoveryHarvestManifest(
              session,
              reason: 'Publish bakeries.',
              version: draft.version,
              revision: valid.revision,
            );
            expect(published.status, DiscoveryManifestStatus.active);
            expect(published.revision, 2);
            expect(published.entries, hasLength(10));

            final history = await admin.discoveryHarvestManifestHistory(
              session,
            );
            expect(
              history.map(
                (version) => '${version.version}:${version.status.name}',
              ),
              containsAll([
                'discovery-manifest-v1:superseded',
                '${draft.version}:active',
              ]),
            );
            await expectLater(
              admin.rollbackDiscoveryHarvestManifest(
                session,
                reason: 'Restore with a stale revision.',
                version: 'discovery-manifest-v1',
                expectedActiveRevision: 1,
              ),
              throwsA(apiError('conflict')),
            );
            final restored = await admin.rollbackDiscoveryHarvestManifest(
              session,
              reason: 'Restore the seed manifest.',
              version: 'discovery-manifest-v1',
              expectedActiveRevision: 2,
            );
            expect(restored.revision, 3);
            expect(restored.entries, hasLength(9));

            final audit = await AdminAuditRow.db.find(session);
            expect(
              audit.map((row) => row.action).toList()..sort(),
              [
                'discovery_manifest.draft.save',
                'discovery_manifest.draft.save',
                'discovery_manifest.draft.validate',
                'discovery_manifest.draft.validate',
                'discovery_manifest.publish',
                'discovery_manifest.rollback',
              ],
            );
            final publish = audit.singleWhere(
              (row) => row.action == 'discovery_manifest.publish',
            );
            expect(publish.beforeData?['revision'], '1');
            expect(publish.afterData?['revision'], '2');
          });

          // A harvest enqueued now takes the restored revision and snapshot.
          final receipt = await endpoints.discover.ensureArea(
            alice,
            viewport: cellView(cell),
          );
          expect(receipt.job!.manifestRevision, 3);
          expect(receipt.job!.totalQueries, 9 + swipeQueries);
        },
      );

      test('harvest jobs are filterable and carry their plan', () async {
        final committed = await endpoints.discover.ensureArea(
          alice,
          viewport: cellView(cell),
        );
        final deepened = await endpoints.discover.deepen(
          bob,
          viewport: cellView(cell, northMetres: 3000),
          idempotencyKey: 'bob-admin-deepen',
        );
        await runHarvests(builder);

        await withSession((session) async {
          final all = await admin.discoveryHarvestJobs(
            session,
            page: 0,
            pageSize: 25,
          );
          expect(all.total, 2);
          final job = all.items.singleWhere(
            (item) => item.jobId == committed.job!.jobId,
          );
          expect(job.state, DiscoveryHarvestState.succeeded);
          expect(job.requester, DiscoveryHarvestRequester.user);
          expect(job.requestedBy, startsWith('user:'));
          expect(job.trigger, DiscoveryHarvestTrigger.committedSearch);
          expect(job.countryCode, 'SA');
          expect(job.cellId, cell.cellId);
          expect(job.radiusMeters, 1000);
          expect(job.manifestVersion, 'discovery-manifest-v1');
          expect(job.manifestRevision, 1);
          expect(job.calibrationVersion, harvestCalibration);
          expect(job.manifestEntries, hasLength(9));
          expect(job.queryOutcomes, hasLength(9 + swipeQueries));
          expect(job.attemptedQueries, job.totalQueries);
          expect(job.upstreamRequests, 9 + swipeQueries);
          expect(job.startedAt, isNotNull);
          expect(job.retryAfter, fixtureNow.add(const Duration(hours: 1)));

          final deepens = await admin.discoveryHarvestJobs(
            session,
            page: 0,
            pageSize: 25,
            trigger: DiscoveryHarvestTrigger.deepen,
          );
          expect(deepens.items.single.jobId, deepened.job!.jobId);
          expect(
            (await admin.discoveryHarvestJobs(
              session,
              page: 0,
              pageSize: 25,
              state: DiscoveryHarvestState.partial,
            )).total,
            0,
          );
          expect(
            (await admin.discoveryHarvestJobs(
              session,
              page: 0,
              pageSize: 25,
              requester: DiscoveryHarvestRequester.administrator,
            )).total,
            0,
          );
          final byCell = await admin.discoveryHarvestJobs(
            session,
            page: 0,
            pageSize: 25,
            query: cell.cellId,
          );
          expect(byCell.items.single.jobId, committed.job!.jobId);
          final second = await admin.discoveryHarvestJobs(
            session,
            page: 1,
            pageSize: 1,
          );
          expect(second.items, hasLength(1));
          expect(second.total, 2);

          // The refresh jobs page tells user harvests from operator refreshes.
          final refreshJobs = await admin.refreshJobs(
            session,
            page: 0,
            pageSize: 25,
          );
          expect(refreshJobs.items.map((item) => item.reason).toSet(), {
            'discover:committedSearch',
            'discover:deepen',
          });
        });
      });

      test(
        'unmapped and ambiguous types rank by frequency and map without a scrape',
        () async {
          final tree = [
            taxonomyNode(
              'food',
              children: [
                taxonomyNode('cafes', aliases: ['Coffee shop', 'Food court']),
              ],
            ),
            taxonomyNode('outdoors', aliases: ['City park', 'Food court']),
          ];
          const writer = CatalogObservationWriter(
            calibrationVersion: 'admin-fixture',
          );
          PlaceSnapshot snapshot(String id, String type) =>
              place(id, primaryType: type).snapshot;
          await withSession((session) async {
            await publishDiscoveryTree(session, tree, revision: 2);
            await writer.write(
              session,
              [
                snapshot('bowl-1', 'Bowling alley'),
                snapshot('court-1', 'Food court'),
                snapshot('cafe-1', 'Coffee shop'),
              ],
              countryCode: 'SA',
              observedAt: fixtureNow.subtract(const Duration(hours: 2)),
            );
            await writer.write(
              session,
              [snapshot('bowl-1', ' bowling  ALLEY ')],
              countryCode: 'SA',
              observedAt: fixtureNow.subtract(const Duration(hours: 1)),
            );

            final page = await admin.discoveryUnmappedTypes(
              session,
              page: 0,
              pageSize: 25,
            );
            expect(page.total, 2);
            final bowling = page.items.first;
            expect(bowling.issue, DiscoveryTypeMappingIssue.unmapped);
            expect(bowling.primaryType, 'bowling  ALLEY');
            expect(bowling.observationCount, 2);
            expect(bowling.catalogPlaceCount, 1);
            expect(bowling.exampleCatalogIds, hasLength(1));
            expect(
              bowling.firstObservedAt,
              fixtureNow.subtract(const Duration(hours: 2)),
            );
            expect(
              bowling.lastObservedAt,
              fixtureNow.subtract(const Duration(hours: 1)),
            );
            final court = page.items.last;
            expect(court.issue, DiscoveryTypeMappingIssue.ambiguous);
            expect(court.primaryType, 'Food court');
            expect(court.observationCount, 1);

            expect(
              (await admin.discoveryUnmappedTypes(
                session,
                page: 0,
                pageSize: 25,
                issue: DiscoveryTypeMappingIssue.ambiguous,
              )).items.single.primaryType,
              'Food court',
            );
            expect(
              (await admin.discoveryUnmappedTypes(
                session,
                page: 0,
                pageSize: 25,
                query: ' BOWL',
              )).items.single.issue,
              DiscoveryTypeMappingIssue.unmapped,
            );

            // The operator maps the type into the tree.
            await publishDiscoveryTree(session, [
              tree.first,
              taxonomyNode(
                'outdoors',
                aliases: ['City park', 'Food court', 'Bowling alley'],
              ),
            ], revision: 3);
            final after = await admin.discoveryUnmappedTypes(
              session,
              page: 0,
              pageSize: 25,
            );
            expect(after.items.map((item) => item.primaryType), [
              'Food court',
            ]);
          });

          final outdoors = await endpoints.discover.browse(
            alice,
            query: discoverQuery(categoryIds: const ['outdoors']),
            pageSize: 10,
            includeMap: false,
          );
          expect(placeIds(outdoors), ['bowl-1']);
          expect(source.fetches, isEmpty);
        },
      );

      test('growth metrics count harvests, cache use and removals', () async {
        final start = DateTime.now().toUtc().subtract(const Duration(hours: 1));
        final laterOfNow = DateTime.now().toUtc().isAfter(fixtureNow)
            ? DateTime.now().toUtc()
            : fixtureNow;
        final end = laterOfNow.add(const Duration(hours: 1));

        await endpoints.discover.ensureArea(alice, viewport: cellView(cell));
        await runHarvests(builder);
        final fresh = await endpoints.discover.ensureArea(
          bob,
          viewport: cellView(cell),
        );
        expect(fresh.job, isNull);
        final harvested = source.fetches.length;

        await withSession((session) async {
          await PoiCatalogRow.db.insertRow(
            session,
            place(
              'ancient',
              checkedAt: DateTime.utc(2020, 1, 1),
              firstSeenAt: DateTime.utc(2019, 1, 1),
            ),
          );
          expect(
            await CatalogPruner.prune(session, cutoff: DateTime.utc(2021)),
            1,
          );

          final growth = await admin.discoveryGrowthMetrics(
            session,
            from: start,
            to: end,
          );
          final harvest = growth.breakdowns.singleWhere(
            (item) =>
                item.mode == DiscoveryMetricMode.discovery &&
                item.operation == DiscoveryMetricOperation.harvest,
          );
          expect(harvest.observations, harvested);
          expect(harvest.newCatalogPlaces, harvested);
          expect(harvest.upstreamRequests, harvested);
          final browse = growth.breakdowns.singleWhere(
            (item) =>
                item.mode == DiscoveryMetricMode.discovery &&
                item.operation == DiscoveryMetricOperation.browse,
          );
          expect(browse.cacheMisses, 1);
          expect(browse.cacheHits, 1);
          expect(growth.exploredCells, 1);
          expect(growth.newCatalogPlaces, harvested);
          expect(growth.removedPlaces, 1);
          expect(growth.catalogPlacesAtStart, 1);
          expect(growth.catalogPlacesAtEnd, harvested);
          expect(growth.upstreamRequests, harvested);
          expect(growth.observations, harvested);
          expect(growth.quarantinedPlaces, 0);

          await expectLater(
            admin.discoveryGrowthMetrics(session, from: end, to: start),
            throwsA(apiError('bad_request')),
          );
          await expectLater(
            admin.discoveryGrowthMetrics(
              session,
              from: start,
              to: start.add(const Duration(days: 91)),
            ),
            throwsA(apiError('bad_request')),
          );
        });
      });
    },
  );
}
