import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_manifest_service.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_service.dart';
import 'package:hayer_server/src/discovery/discovery_metrics.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_place_service.dart';
import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_detail_resolver.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';
import 'harvest_fixtures.dart';

// Architecture item 7's loop against PostGIS: what one user observes in one
// mode, another user reads in the other mode without extracting it again.
// Every fake source spends one upstream request per call where the shared
// transport's admission would, so the counts compare real provider work
// rather than UI output.
//
// Swipe enters at CatalogPlaceService, the service hayerSession.create builds
// around the active calibration's source; the endpoint has no source seam.

/// Counts every Swipe provider search.
final class _SwipeSource implements PlaceSource {
  _SwipeSource(this.respond);

  final List<PlaceCandidate> Function(String categoryId) respond;
  var calls = 0;

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
  }) async {
    ProviderOperation.current?.takeRequest();
    calls++;
    return respond(categoryId);
  }
}

/// Counts every focused detail search and answers with a complete record for
/// the place its query names.
final class _DetailSource implements FocusedPlaceSource {
  final queries = <String>[];

  @override
  String get calibrationVersion => harvestCalibration;

  @override
  Future<List<PlaceCandidate>> fetch({
    required String query,
    required double latitude,
    required double longitude,
    required String language,
    required String countryCode,
  }) async {
    ProviderOperation.current?.takeRequest();
    queries.add(query);
    final id = query.substring('Place '.length);
    return [
      PlaceCandidate(
        placeId: id,
        name: query,
        primaryType: 'Coffee shop',
        rating: 4.4,
        reviewCount: 120,
        priceLevel: 2,
        priceText: r'$$',
        hours: [period(1, 420, 1380)],
        latitude: latitude,
        longitude: longitude,
        phoneNumber: _refreshedPhone,
        websiteUrl: 'https://example.com/detail/$id',
        photoUrls: ['https://example.com/detail/$id.jpg'],
        editorialSummary: 'Checked in detail.',
        sourceCheckedAt: fixtureNow,
      ),
    ];
  }
}

const _refreshedPhone = '+966 11 333 3333';

DiscoveryGrowthMetricBreakdown? _breakdown(
  DiscoveryGrowthMetrics metrics,
  DiscoveryMetricMode mode,
  DiscoveryMetricOperation operation,
) {
  for (final item in metrics.breakdowns) {
    if (item.mode == mode && item.operation == operation) return item;
  }
  return null;
}

void main() {
  withServerpod(
    'Cross-mode catalog loop',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final alice = discoveryMember(builder, 'loop-alice');
      final bob = discoveryMember(builder, 'loop-bob');
      final productionHarvestSource = DiscoveryHarvestService.sourceFor;
      final productionCalibration =
          DiscoveryHarvestService.calibrationVersionFor;
      final productionDetailSource = PlaceDetailResolver.sourceFor;
      final manifest = DiscoveryHarvestManifestService.seedEntries();
      late DiscoveryHarvestCell areaA;
      late DiscoveryHarvestCell areaB;
      late FixtureHarvestSource harvestSource;
      late _DetailSource detailSource;
      late List<AdminTaxonomyItem> swipe;

      Future<T> withSession<T>(
        Future<T> Function(Session session) action, {
        TestSessionBuilder? user,
      }) async {
        final session = (user ?? builder).build();
        try {
          return await action(session);
        } finally {
          await session.close();
        }
      }

      Future<void> reset() => withSession((session) async {
        await session.db.unsafeExecute(
          'TRUNCATE TABLE "hayer_poi_detail_refresh", "hayer_session" CASCADE',
        );
        await resetHarvests(session);
      });

      setUp(() async {
        await reset();
        DiscoveryHarvestService.clock = () => fixtureNow;
        DiscoveryHarvestService.calibrationVersionFor = (_) async =>
            harvestCalibration;
        PlaceDetailResolver.clock = () => fixtureNow;
        pinDiscoveryClock(fixtureNow);
        areaA = riyadhCell();
        areaB = DiscoveryArea.cell(
          cellView(areaA, northMetres: 5000),
          countryCode: 'SA',
        );
        // One distinct place per page, so a harvest spends one request per
        // query and needs no continuation.
        harvestSource = FixtureHarvestSource(
          (_) async => [
            harvestCandidate('b${harvestSource.fetches.length}', areaB),
          ],
        );
        DiscoveryHarvestService.sourceFor = (_, _) async => harvestSource;
        detailSource = _DetailSource();
        PlaceDetailResolver.sourceFor = (_, _) async => detailSource;
        await withSession((session) => useDiscoveryPolicy(session));
        swipe = await withSession(swipeCategories);
      });

      tearDown(() async {
        DiscoveryHarvestService.sourceFor = productionHarvestSource;
        DiscoveryHarvestService.calibrationVersionFor = productionCalibration;
        DiscoveryHarvestService.clock = () => DateTime.now().toUtc();
        PlaceDetailResolver.sourceFor = productionDetailSource;
        PlaceDetailResolver.clock = () => DateTime.now().toUtc();
        restoreDiscoveryClock();
        await reset();
      });

      Future<List<PlaceSnapshot>> swipeSearch(
        TestSessionBuilder user,
        _SwipeSource source,
        DiscoveryHarvestCell area,
        String categoryId, {
        int deckSize = 2,
      }) => withSession(
        user: user,
        (session) =>
            CatalogPlaceService(
              source: source,
              calibrationVersion: harvestCalibration,
            ).buildDeck(
              session,
              categoryId: categoryId,
              subcategoryIds: const [],
              latitude: area.latitude,
              longitude: area.longitude,
              radiusMeters: 1000,
              deckSize: deckSize,
              countryCode: 'SA',
            ),
      );

      // Metric buckets start at the wall clock while harvests complete at the
      // pinned fixture clock, so the window spans both.
      Future<DiscoveryGrowthMetrics> growth() => withSession((session) {
        final now = DateTime.now().toUtc();
        final earliest = now.isBefore(fixtureNow) ? now : fixtureNow;
        final latest = now.isBefore(fixtureNow) ? fixtureNow : now;
        return DiscoveryMetrics.growth(
          session,
          from: earliest.subtract(const Duration(hours: 2)),
          to: latest.add(const Duration(hours: 2)),
        );
      });

      test(
        'Swipe observations serve another user in Discover and Swipe from cache',
        () async {
          final firstSeen = DateTime.utc(2026, 9, 1);
          final quarantined = DateTime.utc(2026, 9, 10);
          await withSession(
            (session) => PoiCatalogRow.db.insert(session, [
              place(
                'known',
                rating: 4.3,
                reviews: 60,
                latitude: areaA.latitude,
                longitude: areaA.longitude,
                firstSeenAt: firstSeen,
              ),
              place(
                'hidden',
                rating: 4.3,
                reviews: 60,
                latitude: areaA.latitude,
                longitude: areaA.longitude,
                quarantinedAt: quarantined,
              ),
            ]),
          );
          final category = swipe.first.id;
          final observed = ['s1', 's2', 's3', 'known', 'hidden'];
          final aliceSource = _SwipeSource(
            (_) => [for (final id in observed) harvestCandidate(id, areaA)],
          );

          final deck = await swipeSearch(alice, aliceSource, areaA, category);
          final searches = aliceSource.calls;
          expect(searches, greaterThan(0));
          expect(deck, hasLength(2));
          expect(
            deck.map((place) => place.placeId),
            everyElement(isIn(['s1', 's2', 's3', 'known'])),
          );

          // Every observation is stored once, not only the deck. A known place
          // keeps its first sighting and a quarantined one stays quarantined.
          await withSession((session) async {
            final rows = await PoiCatalogRow.db.find(session);
            expect(rows, hasLength(observed.length));
            expect(
              rows.map((row) => row.providerPlaceId).toSet(),
              observed.toSet(),
            );
            final known = rows.singleWhere(
              (row) => row.providerPlaceId == 'known',
            );
            expect(known.firstSeenAt, firstSeen);
            final hidden = rows.singleWhere(
              (row) => row.providerPlaceId == 'hidden',
            );
            expect(hidden.quarantinedAt, quarantined);
          });

          // Bob's Discover view lists them without a provider request, and his
          // committed search counts them before any harvest runs.
          final page = await endpoints.discover.browse(
            bob,
            query: discoverQuery(viewport: cellView(areaA)),
            pageSize: 50,
            includeMap: false,
          );
          expect(placeIds(page).toSet(), {'s1', 's2', 's3', 'known'});
          final receipt = await endpoints.discover.ensureArea(
            bob,
            viewport: cellView(areaA),
          );
          expect(receipt.job, isNotNull);
          expect(receipt.coverage.eligibleCatalogCount, 4);
          expect(harvestSource.fetches, isEmpty);

          // Bob's matching Swipe search is a cache hit.
          final bobSource = _SwipeSource((_) => const []);
          final again = await swipeSearch(bob, bobSource, areaA, category);
          expect(again, hasLength(2));
          expect(bobSource.calls, 0);
          expect(aliceSource.calls, searches);

          final metrics = await growth();
          final search = _breakdown(
            metrics,
            DiscoveryMetricMode.swipe,
            DiscoveryMetricOperation.search,
          )!;
          expect(search.upstreamRequests, searches);
          expect(search.cacheMisses, 1);
          expect(search.cacheHits, 1);
          expect(search.newCatalogPlaces, 3);
          expect(
            _breakdown(
              metrics,
              DiscoveryMetricMode.discovery,
              DiscoveryMetricOperation.harvest,
            ),
            isNull,
          );
          expect(metrics.upstreamRequests, searches);
        },
      );

      test(
        'a cold Discover search in another area feeds a later Swipe search',
        () async {
          final category = swipe.first;
          final swipeSource = _SwipeSource(
            (_) => [
              for (final id in ['a1', 'a2']) harvestCandidate(id, areaA),
            ],
          );
          await swipeSearch(alice, swipeSource, areaA, category.id);
          final searches = swipeSource.calls;
          expect(searches, greaterThan(0));

          final cold = await endpoints.discover.ensureArea(
            bob,
            viewport: cellView(areaB),
          );
          expect(cold.job, isNotNull);
          await runHarvests(builder);
          final harvested = harvestSource.fetches.length;
          expect(harvested, manifest.length + swipe.length);
          final status = await endpoints.discover.harvestStatus(
            bob,
            jobId: cold.job!.jobId,
          );
          expect(status.state, DiscoveryHarvestState.succeeded);

          // Repeat views within freshness make no provider request, and broad
          // observations with no Swipe evidence are still listed.
          final fresh = await endpoints.discover.ensureArea(
            alice,
            viewport: cellView(areaB, eastMetres: 80),
          );
          expect(fresh.job, isNull);
          expect(fresh.retryAfter, isNull);
          final page = await endpoints.discover.browse(
            alice,
            query: discoverQuery(viewport: cellView(areaB)),
            pageSize: 50,
            includeMap: false,
          );
          expect(page.total, harvested);
          expect(placeIds(page), contains('b1'));
          expect(harvestSource.fetches, hasLength(harvested));

          // A matching Swipe search in area B reads the harvest's compatibility
          // evidence and coverage from cache.
          final compatibility =
              'b${harvestSource.fetches.lastIndexWhere((fetch) => fetch.query == category.searchQueryEn) + 1}';
          final later = _SwipeSource((_) => const []);
          final deck = await swipeSearch(
            bob,
            later,
            areaB,
            category.id,
            deckSize: 1,
          );
          expect(deck.map((place) => place.placeId), [compatibility]);
          expect(later.calls, 0);
          expect(swipeSource.calls, searches);

          // Both areas grew the one catalog.
          await withSession((session) async {
            expect(await PoiCatalogRow.db.count(session), 2 + harvested);
          });

          final metrics = await growth();
          expect(metrics.exploredCells, 1);
          expect(metrics.newCatalogPlaces, 2 + harvested);
          expect(metrics.upstreamRequests, searches + harvested);
          final search = _breakdown(
            metrics,
            DiscoveryMetricMode.swipe,
            DiscoveryMetricOperation.search,
          )!;
          expect(search.upstreamRequests, searches);
          expect(search.cacheMisses, 1);
          expect(search.cacheHits, 1);
          final harvest = _breakdown(
            metrics,
            DiscoveryMetricMode.discovery,
            DiscoveryMetricOperation.harvest,
          )!;
          expect(harvest.upstreamRequests, harvested);
          expect(harvest.newCatalogPlaces, harvested);
          final browse = _breakdown(
            metrics,
            DiscoveryMetricMode.discovery,
            DiscoveryMetricOperation.browse,
          )!;
          expect(browse.cacheMisses, 1);
          expect(browse.cacheHits, 1);
        },
      );

      test(
        'a detail refresh from either mode updates the record the other reads',
        () async {
          final fromSwipe = place('from-swipe', rating: 4.1, reviews: 12);
          final fromDiscover = place('from-discover', rating: 4.0, reviews: 9);
          await withSession((session) async {
            await PoiCatalogRow.db.insert(session, [fromSwipe, fromDiscover]);
            await insertSwipeSession(
              session,
              sessionId: 'loop-session',
              code: 'LPX001',
              userId: 'loop-alice',
              places: [fromSwipe.snapshot, fromDiscover.snapshot],
            );
          });
          Future<PlaceDetailResult> details(
            TestSessionBuilder user,
            String placeId, {
            String? sessionId,
          }) => endpoints.place.details(
            user,
            identity: PoiIdentity(provider: fixtureProvider, placeId: placeId),
            sessionId: sessionId,
          );

          // Swipe refreshes; Discover reads the refreshed record.
          final swipeRefresh = await details(
            alice,
            'from-swipe',
            sessionId: 'loop-session',
          );
          expect(swipeRefresh.refreshState, PlaceDetailRefreshState.succeeded);
          expect(swipeRefresh.place.phoneNumber, _refreshedPhone);
          expect(detailSource.queries, ['Place from-swipe']);
          final discoverRead = await details(bob, 'from-swipe');
          expect(discoverRead.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(discoverRead.place.phoneNumber, _refreshedPhone);
          final page = await endpoints.discover.browse(
            bob,
            query: discoverQuery(),
            pageSize: 10,
            includeMap: false,
          );
          expect(
            page.items
                .singleWhere((item) => item.place.placeId == 'from-swipe')
                .place
                .phoneNumber,
            _refreshedPhone,
          );

          // Discover refreshes; Swipe reads the refreshed record.
          final discoverRefresh = await details(bob, 'from-discover');
          expect(
            discoverRefresh.refreshState,
            PlaceDetailRefreshState.succeeded,
          );
          final swipeRead = await details(
            alice,
            'from-discover',
            sessionId: 'loop-session',
          );
          expect(swipeRead.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(swipeRead.place.phoneNumber, _refreshedPhone);
          expect(detailSource.queries, [
            'Place from-swipe',
            'Place from-discover',
          ]);

          // The session keeps its own snapshots, order and revision.
          await withSession((session) async {
            final deck = await SessionPlaceRow.db.find(
              session,
              where: (table) => table.sessionId.equals('loop-session'),
              orderBy: (table) => table.deckOrder,
            );
            expect(deck.map((row) => row.snapshot.placeId), [
              'from-swipe',
              'from-discover',
            ]);
            expect(deck.map((row) => row.snapshot.phoneNumber), [null, null]);
            final room = await HayerSessionRow.db.findFirstRow(
              session,
              where: (table) => table.sessionId.equals('loop-session'),
            );
            expect(room!.revision, 3);
            expect(await PoiCatalogRow.db.count(session), 2);
          });

          final metrics = await growth();
          for (final mode in DiscoveryMetricMode.values) {
            final detail = _breakdown(
              metrics,
              mode,
              DiscoveryMetricOperation.detailRefresh,
            );
            expect(detail, isNotNull, reason: mode.name);
            expect(detail!.detailRefreshes, 1, reason: mode.name);
            expect(detail.upstreamRequests, 1, reason: mode.name);
            expect(detail.cacheMisses, 1, reason: mode.name);
            expect(detail.cacheHits, 1, reason: mode.name);
          }
        },
      );
    },
  );
}
