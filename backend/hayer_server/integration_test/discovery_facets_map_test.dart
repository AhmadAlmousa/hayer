import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod('Discover facets and map', (builder, endpoints) {
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
      int pageSize = 50,
      bool includeMap = false,
    }) => endpoints.discover.browse(
      member,
      query: query,
      pageSize: pageSize,
      includeMap: includeMap,
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

    List<PoiCatalogRow> facetPlaces() => [
      for (var i = 0; i < 24; i++)
        place(
          'f${i.toString().padLeft(2, '0')}',
          rating: i % 6 == 5 ? null : const [4.8, 4.2, 3.6, 4.5, 2.9][i % 5],
          reviews: const [12, 150, 30, 480, 1200, 75, 0][i % 7],
          price: i % 4 == 3 ? null : i % 4 + 1,
          primaryType: const [
            'Coffee shop',
            'Restaurant',
            'Japanese restaurant',
            'City park',
            'Bowling alley',
            null,
          ][i % 6],
        ),
    ];

    test('every facet count matches a brute-force browse', () async {
      await seed(facetPlaces());
      for (final sort in [DiscoverSort.mostReviewed, DiscoverSort.hiddenGems]) {
        final base = discoverQuery(
          sort: sort,
          categoryIds: const ['food'],
          reviewBands: const [
            DiscoverReviewBand.under50,
            DiscoverReviewBand.from100,
          ],
          exactPriceLevel: 2,
          minimumRating: 4.0,
        );
        DiscoverQuery vary({
          List<String>? categoryIds,
          List<DiscoverReviewBand>? reviewBands,
          int? price,
          bool anyPrice = false,
          double? minimumRating,
          bool anyRating = false,
        }) => discoverQuery(
          sort: sort,
          categoryIds: categoryIds ?? base.categoryIds,
          reviewBands: reviewBands ?? base.reviewBands,
          exactPriceLevel: anyPrice ? null : price ?? base.exactPriceLevel,
          minimumRating: anyRating ? null : minimumRating ?? base.minimumRating,
        );
        Future<int> total(DiscoverQuery query) async =>
            (await browse(query, pageSize: 1)).total;

        final committed = await browse(base, pageSize: 1);
        final facets = await endpoints.discover.facets(
          member,
          query: base,
          context: committed.context,
        );
        final reason = sort.name;
        expect(facets.total, committed.total, reason: reason);

        final ownCounts = <String, int>{};
        for (final count in facets.typeCounts) {
          ownCounts.update(
            count.taxonomyNodeId,
            (value) => value + count.count,
            ifAbsent: () => count.count,
          );
        }
        for (final leaf in ['cafes', 'japanese', 'outdoors', 'other']) {
          expect(
            ownCounts[leaf] ?? 0,
            await total(vary(categoryIds: [leaf])),
            reason: '$reason type $leaf',
          );
        }
        // An interior node's branch is its own mapped count plus descendants.
        expect(
          (ownCounts['restaurants'] ?? 0) + (ownCounts['japanese'] ?? 0),
          await total(vary(categoryIds: const ['restaurants'])),
          reason: '$reason branch restaurants',
        );

        expect(facets.reviewBandCounts, hasLength(6), reason: reason);
        for (final band in facets.reviewBandCounts) {
          expect(
            band.count,
            await total(vary(reviewBands: [band.band])),
            reason: '$reason band ${band.band.name}',
          );
        }

        for (final price in facets.priceCounts) {
          if (price.priceLevel == null) continue;
          expect(
            price.count,
            await total(vary(price: price.priceLevel)),
            reason: '$reason price ${price.priceLevel}',
          );
        }
        expect(
          facets.priceCounts.fold<int>(0, (sum, price) => sum + price.count),
          await total(vary(anyPrice: true)),
          reason: '$reason price with unknown',
        );

        for (final threshold in facets.minimumRatingCounts) {
          expect(
            threshold.count,
            await total(vary(minimumRating: threshold.minimumRating)),
            reason: '$reason rating ${threshold.minimumRating}',
          );
        }
        final ratingScope = await browseAll(
          endpoints,
          member,
          vary(anyRating: true),
          pageSize: 100,
        );
        final ratings = [
          for (final page in ratingScope)
            for (final item in page.items) item.place.rating,
        ];
        expect(
          facets.unknownRatingCount,
          ratings.where((rating) => rating == null).length,
          reason: reason,
        );
        for (final bucket in facets.ratingDistribution) {
          expect(
            bucket.count,
            ratings
                .where(
                  (rating) =>
                      rating != null &&
                      rating >= bucket.minimumInclusive &&
                      rating < bucket.maximumExclusive,
                )
                .length,
            reason: '$reason bucket ${bucket.minimumInclusive}',
          );
        }
        expect(
          facets.ratingDistribution.last.maximumExclusive,
          greaterThan(5),
        );
      }
    });

    test('each distribution ignores only its own selection', () async {
      await seed(facetPlaces());
      final query = discoverQuery(
        categoryIds: const ['cafes'],
        reviewBands: const [DiscoverReviewBand.from100],
      );
      final committed = await browse(query);
      final facets = await endpoints.discover.facets(
        member,
        query: query,
        context: committed.context,
      );
      expect(facets.context.fingerprint, committed.context.fingerprint);
      expect(
        facets.reviewBandCounts.where(
          (band) => band.band != DiscoverReviewBand.from100 && band.count > 0,
        ),
        isNotEmpty,
      );
      expect(
        facets.typeCounts.map((count) => count.taxonomyNodeId).toSet(),
        containsAll(['restaurants', 'japanese', 'outdoors', 'other']),
      );

      // A filter-sheet draft is counted under its own fingerprint.
      final draft = discoverQuery(categoryIds: const ['outdoors']);
      final preview = await endpoints.discover.facets(
        member,
        query: draft,
        context: committed.context,
      );
      expect(preview.context.fingerprint, isNot(committed.context.fingerprint));
      expect(preview.context.evaluatedAt, committed.context.evaluatedAt);
      expect(preview.total, (await browse(draft)).total);
    });

    test('the map lists every point up to the ceiling, then exact cells', () async {
      await seed([
        place(
          'corner',
          rating: 4.0,
          reviews: 13,
          latitude: 24.6,
          longitude: 46.5,
        ),
        place('middle', rating: 4.8, reviews: 12),
        place('gem', rating: 4.7, reviews: 11),
        place('edge', reviews: 10, latitude: 24.8, longitude: 46.8),
      ], policy: (discovery) => discovery.copyWith(maximumMapPoints: 3));

      // Best keeps the three rated places: at the ceiling, all are points.
      final points = await browse(
        discoverQuery(sort: DiscoverSort.best),
        pageSize: 1,
        includeMap: true,
      );
      expect(points.nextCursor, isNotNull);
      expect(points.map?.mode, DiscoveryMapMode.points);
      expect(points.map?.aggregates, isEmpty);
      final byId = {
        for (final point in points.map!.points) point.placeId: point,
      };
      expect(byId.keys, unorderedEquals(['corner', 'middle', 'gem']));
      expect(byId['gem']?.hiddenGem, isTrue);
      expect(byId['middle']?.rating, 4.8);

      // Most reviewed keeps all four, including the unrated corner of the view.
      final cells = await browse(
        discoverQuery(),
        pageSize: 1,
        includeMap: true,
      );
      final map = cells.map!;
      expect(map.mode, DiscoveryMapMode.aggregates);
      expect(map.points, isEmpty);
      expect(map.aggregates.fold<int>(0, (sum, cell) => sum + cell.count), 4);
      expect(
        map.aggregates.map((cell) => cell.cellId).toSet(),
        hasLength(map.aggregates.length),
      );
      for (final cell in map.aggregates) {
        expect(
          cell.bounds.south,
          greaterThanOrEqualTo(riyadhView.south - 1e-9),
        );
        expect(cell.bounds.north, lessThanOrEqualTo(riyadhView.north + 1e-9));
        expect(cell.bounds.west, greaterThanOrEqualTo(riyadhView.west - 1e-9));
        expect(cell.bounds.east, lessThanOrEqualTo(riyadhView.east + 1e-9));
      }

      expect((await browse(discoverQuery(), includeMap: false)).map, isNull);
      final empty = await browse(
        discoverQuery(text: 'nothing matches this'),
        includeMap: true,
      );
      expect(empty.total, 0);
      expect(empty.map?.mode, DiscoveryMapMode.points);
      expect(empty.map?.points, isEmpty);
    });

    test('both sides of the 2,000-place map threshold', () async {
      final session = builder.build();
      try {
        await seedDiscovery(session);
        await insertGridPlaces(session, count: 2000);
      } finally {
        await session.close();
      }
      final atCeiling = await browse(
        discoverQuery(),
        pageSize: 1,
        includeMap: true,
      );
      expect(atCeiling.total, 2000);
      expect(atCeiling.map?.mode, DiscoveryMapMode.points);
      expect(atCeiling.map?.points, hasLength(2000));

      final more = builder.build();
      try {
        await insertGridPlaces(more, count: 1, offset: 2000);
      } finally {
        await more.close();
      }
      final above = await browse(
        discoverQuery(),
        pageSize: 1,
        includeMap: true,
      );
      expect(above.total, 2001);
      expect(above.map?.mode, DiscoveryMapMode.aggregates);
      expect(above.map!.aggregates.length, lessThanOrEqualTo(2000));
      expect(
        above.map!.aggregates.fold<int>(0, (sum, cell) => sum + cell.count),
        2001,
      );
    });
  });
}
