import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod('Discover ranking, paging and place context', (
    builder,
    endpoints,
  ) {
    final member = discoveryMember(builder);

    Future<void> seed(
      List<PoiCatalogRow> places, {
      DiscoveryPolicy Function(DiscoveryPolicy discovery)? policy,
    }) async {
      final session = builder.build();
      try {
        await seedDiscovery(session, places: places, policy: policy);
      } finally {
        await session.close();
      }
    }

    Future<DiscoverBrowsePage> browse(
      DiscoverQuery query, {
      DiscoverQueryContext? context,
      String? cursor,
      int pageSize = 20,
    }) => endpoints.discover.browse(
      member,
      query: query,
      context: context,
      cursor: cursor,
      pageSize: pageSize,
      includeMap: false,
    );

    setUp(() => pinDiscoveryClock(fixtureNow));

    tearDown(() async {
      restoreDiscoveryClock();
      final session = builder.build();
      try {
        await resetDiscovery(session);
      } finally {
        await session.close();
      }
    });

    List<PoiCatalogRow> rankingPlaces() => [
      place(
        'a',
        rating: 4.9,
        reviews: 300,
        firstSeenAt: DateTime.utc(2026, 9, 1),
      ),
      place(
        'b',
        rating: 4.0,
        reviews: 100000,
        firstSeenAt: DateTime.utc(2026, 9, 2),
      ),
      place(
        'c',
        rating: 4.6,
        reviews: 20,
        firstSeenAt: DateTime.utc(2026, 9, 4),
      ),
      place(
        'd',
        rating: 2.0,
        reviews: 10,
        primaryType: 'City park',
        firstSeenAt: DateTime.utc(2026, 9, 3),
      ),
      place(
        'e',
        firstSeenAt: DateTime.utc(2026, 9, 5),
        hours: [period(3, 0, 1440)],
      ),
    ];

    test('each sort orders the fixture exactly as specified', () async {
      await seed(rankingPlaces());
      final expected = {
        // 4.0 × log10(100010) = 20.0 outranks 4.9 × log10(310) = 12.2.
        DiscoverSort.best: ['b', 'a', 'c', 'd'],
        DiscoverSort.topRated: ['a', 'c', 'b', 'd'],
        DiscoverSort.mostReviewed: ['b', 'a', 'c', 'd', 'e'],
        DiscoverSort.hiddenGems: ['a', 'c'],
        DiscoverSort.worstRated: ['d', 'b', 'c', 'a'],
        DiscoverSort.recentlyDiscovered: ['e', 'c', 'd', 'b', 'a'],
      };
      for (final entry in expected.entries) {
        final page = await browse(discoverQuery(sort: entry.key));
        expect(placeIds(page), entry.value, reason: entry.key.name);
        expect(
          page.items.map((item) => item.ordinal),
          [for (var i = 1; i <= entry.value.length; i++) i],
          reason: entry.key.name,
        );
        expect(page.total, entry.value.length, reason: entry.key.name);
      }

      final recent = await browse(
        discoverQuery(sort: DiscoverSort.recentlyDiscovered),
      );
      expect(recent.items.first.firstSeenAt, DateTime.utc(2026, 9, 5));
      expect(recent.items.first.openNow, isTrue);
      expect(
        recent.items
            .where((item) => item.hiddenGem)
            .map((item) => item.place.placeId),
        unorderedEquals(['a', 'c']),
      );
    });

    test('switching the Best formula reorders results and old pages', () async {
      await seed(rankingPlaces());
      final popular = await browse(
        discoverQuery(sort: DiscoverSort.best),
        pageSize: 2,
      );
      expect(placeIds(popular), ['b', 'a']);

      final session = builder.build();
      try {
        await useDiscoveryPolicy(
          session,
          (discovery) => discovery.copyWith(
            scoring: discovery.scoring.copyWith(
              bestFormula: DiscoveryBestFormula.bayesian,
              bayesianPriorReviews: 100,
              bayesianMeanRating: 4.0,
            ),
          ),
        );
      } finally {
        await session.close();
      }

      await expectLater(
        browse(
          discoverQuery(sort: DiscoverSort.best),
          context: popular.context,
          cursor: popular.nextCursor,
          pageSize: 2,
        ),
        throwsA(apiError('query_changed')),
      );
      final bayesian = await browse(discoverQuery(sort: DiscoverSort.best));
      // (300/400)·4.9 + (100/400)·4.0 = 4.675 now beats
      // (100000/100100)·4.0 + (100/100100)·4.0 = 4.0, and
      // (20/120)·4.6 + (100/120)·4.0 = 4.1 passes it too.
      expect(placeIds(bayesian), ['a', 'c', 'b', 'd']);
      expect(
        bayesian.context.policyRevision,
        greaterThan(popular.context.policyRevision),
      );
    });

    test('hidden gem membership follows the policy thresholds', () async {
      await seed(
        rankingPlaces(),
        policy: (discovery) => discovery.copyWith(
          scoring: discovery.scoring.copyWith(
            gemMinimumRating: 4.6,
            gemMaximumReviewsExclusive: 300,
          ),
        ),
      );
      final page = await browse(discoverQuery(sort: DiscoverSort.hiddenGems));
      expect(placeIds(page), ['c']);
      expect(page.items.single.hiddenGem, isTrue);
    });

    test('stale rows lose ranking fields and badges but stay listed', () async {
      await seed([
        place(
          'fresh',
          rating: 4.0,
          reviews: 10,
          hours: [period(3, 0, 1440)],
          phone: '+966500000000',
        ),
        place(
          'stale',
          rating: 5.0,
          reviews: 9999,
          hours: [period(3, 0, 1440)],
          phone: '+966500000001',
          summary: 'Still described',
          checkedAt: fixtureNow.subtract(const Duration(hours: 100)),
        ),
      ]);
      expect(placeIds(await browse(discoverQuery(sort: DiscoverSort.best))), [
        'fresh',
      ]);
      final reviewed = await browse(discoverQuery());
      expect(placeIds(reviewed), ['fresh', 'stale']);
      final stale = reviewed.items.last.place;
      expect(stale.isStale, isTrue);
      expect(stale.rating, isNull);
      expect(stale.reviewCount, isNull);
      expect(stale.hours, isEmpty);
      expect(stale.phoneNumber, isNull);
      expect(stale.editorialSummary, 'Still described');
      expect(reviewed.items.last.openNow, isNull);
      expect(reviewed.items.first.openNow, isTrue);
      expect(reviewed.items.first.place.isStale, isFalse);
    });

    List<PoiCatalogRow> traversalPlaces() => [
      for (var i = 0; i < 16; i++)
        place(
          'p${i.toString().padLeft(2, '0')}',
          name: i.isEven ? 'Tie place $i' : 'Other place $i',
          rating: i % 5 == 4 ? null : const [4.5, 4.0, 4.5, 3.0][i % 4],
          reviews: i % 5 == 4 ? null : const [20, 1500, 20, 60][i % 4],
          price: i % 3 == 0 ? null : i % 2 + 1,
          primaryType: const [
            'Coffee shop',
            'Japanese restaurant',
            'Bowling alley',
            null,
          ][i % 4],
          hours: i % 3 == 2 ? [period(3, 0, 1440)] : const [],
          photos: i.isEven,
          firstSeenAt: DateTime.utc(2026, 9, 1 + i % 3),
        ),
    ];

    test(
      'every filter composes with every sort and pages without gaps',
      () async {
        await seed(traversalPlaces());
        final filters = <String, DiscoverQuery Function(DiscoverSort sort)>{
          'none': (sort) => discoverQuery(sort: sort),
          'category': (sort) =>
              discoverQuery(sort: sort, categoryIds: const ['food']),
          'other': (sort) =>
              discoverQuery(sort: sort, categoryIds: const ['other']),
          'reviews': (sort) => discoverQuery(
            sort: sort,
            reviewBands: const [
              DiscoverReviewBand.under50,
              DiscoverReviewBand.from1000,
            ],
          ),
          'price': (sort) => discoverQuery(sort: sort, exactPriceLevel: 2),
          'rating': (sort) => discoverQuery(sort: sort, minimumRating: 4.0),
          'hours': (sort) => discoverQuery(
            sort: sort,
            hoursWindows: const [DiscoverHoursWindow.openNow],
          ),
          'text': (sort) => discoverQuery(sort: sort, text: 'tie'),
          'completeness': (sort) => discoverQuery(
            sort: sort,
            completeness: const [DiscoverCompleteness.photos],
          ),
        };
        var paged = 0;
        for (final sort in DiscoverSort.values) {
          for (final filter in filters.entries) {
            final query = filter.value(sort);
            final reason = '${sort.name} + ${filter.key}';
            final whole = await browse(query, pageSize: 100);
            expect(whole.nextCursor, isNull, reason: reason);
            final pages = await browseAll(
              endpoints,
              member,
              query,
              pageSize: 2,
            );
            final items = [for (final page in pages) ...page.items];
            expect(
              items.map((item) => item.place.placeId),
              placeIds(whole),
              reason: reason,
            );
            expect(
              items.map((item) => item.catalogId).toSet(),
              hasLength(items.length),
              reason: reason,
            );
            expect(
              items.map((item) => item.ordinal),
              [for (var i = 1; i <= items.length; i++) i],
              reason: reason,
            );
            expect(
              pages.map((page) => page.total).toSet(),
              {items.length},
              reason: reason,
            );
            if (items.length > 2) paged++;
          }
        }
        expect(paged, greaterThan(30));
      },
    );

    test(
      'cursors reject tampering, other queries, revisions and expiry',
      () async {
        await seed(traversalPlaces());
        final query = discoverQuery();
        final first = await browse(query, pageSize: 2);
        final topRated = discoverQuery(sort: DiscoverSort.topRated);
        final other = await browse(topRated, pageSize: 2);

        await expectLater(
          browse(query, context: first.context, cursor: 'not-a-cursor'),
          throwsA(apiError('query_changed')),
        );
        await expectLater(
          browse(topRated, context: other.context, cursor: first.nextCursor),
          throwsA(apiError('query_changed')),
        );
        await expectLater(
          browse(topRated, context: first.context, cursor: first.nextCursor),
          throwsA(apiError('query_changed')),
        );

        pinDiscoveryClock(fixtureNow.add(const Duration(minutes: 61)));
        await expectLater(
          browse(query, context: first.context, cursor: first.nextCursor),
          throwsA(apiError('query_changed')),
        );
        pinDiscoveryClock(fixtureNow);
        expect(
          await browse(query, context: first.context, cursor: first.nextCursor),
          isA<DiscoverBrowsePage>(),
        );

        final session = builder.build();
        try {
          await publishDiscoveryTree(session, fixtureTree, revision: 2);
        } finally {
          await session.close();
        }
        await expectLater(
          browse(query, context: first.context, cursor: first.nextCursor),
          throwsA(apiError('query_changed')),
        );
        await expectLater(
          endpoints.discover.facets(
            member,
            query: query,
            context: first.context,
          ),
          throwsA(apiError('query_changed')),
        );
      },
    );

    test('live pages skip earlier inserts and a refresh rebuilds', () async {
      await seed([
        for (var i = 0; i < 6; i++) place('r$i', rating: 4.0, reviews: 100 - i),
      ]);
      final query = discoverQuery();
      final first = await browse(query, pageSize: 2);
      expect(placeIds(first), ['r0', 'r1']);

      final session = builder.build();
      try {
        await PoiCatalogRow.db.insertRow(
          session,
          place('new', rating: 4.0, reviews: 500),
        );
        final shown = await PoiCatalogRow.db.findFirstRow(
          session,
          where: (table) => table.providerPlaceId.equals('r0'),
        );
        // A row already shown can move past the cursor while scrolling.
        await PoiCatalogRow.db.updateRow(
          session,
          shown!.copyWith(snapshot: shown.snapshot.copyWith(reviewCount: 1)),
        );
      } finally {
        await session.close();
      }

      final rest = <DiscoverPlace>[];
      var page = first;
      while (page.nextCursor != null) {
        page = await browse(
          query,
          context: first.context,
          cursor: page.nextCursor,
          pageSize: 2,
        );
        expect(page.total, first.total + 1);
        rest.addAll(page.items);
      }
      final later = [for (final item in rest) item.place.placeId];
      expect(later, ['r2', 'r3', 'r4', 'r5', 'r0']);
      // The client drops the repeated row by catalog id.
      expect(
        rest.singleWhere((item) => item.place.placeId == 'r0').catalogId,
        first.items.first.catalogId,
      );

      final refreshed = await browse(query, pageSize: 2);
      expect(placeIds(refreshed), ['new', 'r1']);
    });

    test(
      'place context ranks ties, computes percentiles and eligibility',
      () async {
        await seed([
          ...rankingPlaces(),
          place(
            'f',
            rating: 4.6,
            reviews: 20,
            firstSeenAt: DateTime.utc(2026, 9, 4),
          ),
        ]);
        final cafes = discoverQuery(
          sort: DiscoverSort.best,
          categoryIds: const ['cafes'],
        );
        final page = await browse(cafes);
        expect(placeIds(page), ['b', 'a', 'c', 'f']);

        Future<DiscoverPlaceContext> contextOf(
          String id,
          DiscoverQuery query,
          DiscoverQueryContext context,
        ) => endpoints.discover.placeContext(
          member,
          identity: PoiIdentity(provider: fixtureProvider, placeId: id),
          query: query,
          context: context,
        );

        final c = await contextOf('c', cafes, page.context);
        expect(c.eligible, isTrue);
        expect(c.ordinal, 3);
        expect(c.total, 4);
        // Rated peers are a, b and f; only b's 4.0 is strictly below 4.6.
        expect(c.ratingPercentile, closeTo(100 / 3, 1e-9));
        expect(c.populationCategoryId, 'cafes');
        expect(c.place?.catalogId, page.items[2].catalogId);
        expect(
          c.ratingDistribution.fold<int>(
            0,
            (sum, bucket) => sum + bucket.count,
          ),
          4,
        );

        final f = await contextOf('f', cafes, page.context);
        expect(f.ordinal, 4);
        expect(f.ratingPercentile, closeTo(100 / 3, 1e-9));

        for (final ineligible in ['e', 'd']) {
          final result = await contextOf(ineligible, cafes, page.context);
          expect(result.eligible, isFalse, reason: ineligible);
          expect(result.place, isNull, reason: ineligible);
          expect(result.ordinal, isNull, reason: ineligible);
          expect(result.ratingPercentile, isNull, reason: ineligible);
          expect(result.total, 4, reason: ineligible);
        }

        final everything = discoverQuery();
        final all = await browse(everything);
        final e = await contextOf('e', everything, all.context);
        expect(e.eligible, isTrue);
        expect(e.ordinal, 6);
        expect(e.ratingPercentile, isNull);
        expect(e.populationCategoryId, isNull);
        expect(e.place?.openNow, isTrue);

        await expectLater(
          contextOf('c', everything, page.context),
          throwsA(apiError('query_changed')),
        );
      },
    );
  });
}
