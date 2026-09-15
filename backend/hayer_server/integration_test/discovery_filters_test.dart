import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod('Discover filters', (builder, endpoints) {
    final member = discoveryMember(builder);

    Future<void> seed(
      List<PoiCatalogRow> places, {
      List<DiscoveryTaxonomyNode>? tree,
    }) async {
      final session = builder.build();
      try {
        await seedDiscovery(session, places: places, tree: tree);
      } finally {
        await session.close();
      }
    }

    Future<DiscoverBrowsePage> browse(DiscoverQuery query) =>
        endpoints.discover.browse(
          member,
          query: query,
          pageSize: 50,
          includeMap: false,
        );

    Future<Set<String>> ids(DiscoverQuery query) async =>
        placeIds(await browse(query)).toSet();

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

    test('categories map types through normalized aliases and Other', () async {
      final noBreakSpace = String.fromCharCode(0x00a0);
      final tab = String.fromCharCode(0x09);
      final messyType = '  COFFEE$noBreakSpace Shop$tab';
      await seed([
        place('coffee', rating: 4.0, reviews: 80),
        place('arabic', rating: 4.0, reviews: 70, primaryType: 'مقهى'),
        place('messy', rating: 4.0, reviews: 60, primaryType: messyType),
        place(
          'japanese',
          rating: 4.0,
          reviews: 50,
          primaryType: 'Japanese restaurant',
        ),
        place(
          'restaurant',
          rating: 4.0,
          reviews: 40,
          primaryType: 'Restaurant',
        ),
        place('park', rating: 4.0, reviews: 30, primaryType: 'City park'),
        place(
          'bowling',
          rating: 4.0,
          reviews: 20,
          primaryType: 'Bowling alley',
        ),
        place('untyped', rating: 4.0, reviews: 10, primaryType: null),
      ]);

      Future<List<String>> inCategories(List<String> categories) async =>
          placeIds(await browse(discoverQuery(categoryIds: categories)));

      expect(await inCategories(['cafes']), ['coffee', 'arabic', 'messy']);
      expect(await inCategories(['restaurants']), ['japanese', 'restaurant']);
      expect(await inCategories(['food']), [
        'coffee',
        'arabic',
        'messy',
        'japanese',
        'restaurant',
      ]);
      expect(await inCategories(['other']), ['bowling', 'untyped']);
      expect(await inCategories(['japanese', 'other']), [
        'japanese',
        'bowling',
        'untyped',
      ]);

      final food = await browse(discoverQuery(categoryIds: const ['food']));
      final redundant = await browse(
        discoverQuery(categoryIds: const ['cafes', 'food']),
      );
      expect(redundant.context.fingerprint, food.context.fingerprint);
      await expectLater(
        browse(discoverQuery(categoryIds: const ['missing'])),
        throwsA(apiError('bad_request')),
      );

      final facets = await endpoints.discover.facets(
        member,
        query: discoverQuery(),
        context: food.context,
      );
      final nodes = {
        for (final count in facets.typeCounts)
          count.primaryType: count.taxonomyNodeId,
      };
      expect(nodes['Coffee shop'], 'cafes');
      expect(nodes['مقهى'], 'cafes');
      expect(nodes['COFFEE$noBreakSpace Shop$tab'], 'cafes');
      expect(nodes['Restaurant'], 'restaurants');
      expect(nodes['Japanese restaurant'], 'japanese');
      expect(nodes['City park'], 'outdoors');
      expect(nodes['Bowling alley'], 'other');
      expect(nodes[null], 'other');
      expect(
        facets.typeCounts.fold<int>(0, (sum, count) => sum + count.count),
        8,
      );
    });

    test(
      'mapping an observed type in a new revision surfaces its places',
      () async {
        await seed([
          place(
            'bowling',
            rating: 4.0,
            reviews: 5,
            primaryType: 'Bowling alley',
          ),
          place('park', rating: 4.0, reviews: 6, primaryType: 'City park'),
        ]);
        final outdoors = discoverQuery(categoryIds: const ['outdoors']);
        final before = await browse(outdoors);
        expect(placeIds(before), ['park']);

        final session = builder.build();
        try {
          await publishDiscoveryTree(session, [
            fixtureTree.first,
            taxonomyNode('outdoors', aliases: ['City park', 'Bowling alley']),
          ], revision: 2);
        } finally {
          await session.close();
        }

        await expectLater(
          endpoints.discover.facets(
            member,
            query: outdoors,
            context: before.context,
          ),
          throwsA(apiError('query_changed')),
        );
        final after = await browse(outdoors);
        expect(placeIds(after), ['park', 'bowling']);
        expect(after.context.taxonomyRevision, 2);
      },
    );

    test('review bands are disjoint and never match unknown or zero', () async {
      const counts = [0, 1, 49, 50, 99, 100, 249, 250, 499, 500, 999, 1000];
      await seed([
        for (final count in counts)
          place('n$count', rating: 4.0, reviews: count),
        place('unknown', rating: 4.0),
      ]);
      Future<Set<String>> inBands(List<DiscoverReviewBand> bands) =>
          ids(discoverQuery(reviewBands: bands));

      expect(await inBands([DiscoverReviewBand.under50]), {'n1', 'n49'});
      expect(await inBands([DiscoverReviewBand.from50]), {'n50', 'n99'});
      expect(await inBands([DiscoverReviewBand.from100]), {'n100', 'n249'});
      expect(await inBands([DiscoverReviewBand.from250]), {'n250', 'n499'});
      expect(await inBands([DiscoverReviewBand.from500]), {'n500', 'n999'});
      expect(await inBands([DiscoverReviewBand.from1000]), {'n1000'});
      expect(
        await inBands([
          DiscoverReviewBand.under50,
          DiscoverReviewBand.from1000,
        ]),
        {'n1', 'n49', 'n1000'},
      );
      expect(await inBands(const []), {
        for (final count in counts) 'n$count',
        'unknown',
      });
    });

    test('price is exact and minimum rating is an inclusive floor', () async {
      await seed([
        for (final price in [1, 2, 3, 4])
          place('price$price', reviews: 1, price: price),
        place('priceUnknown', reviews: 1),
        for (final rating in [3.4, 3.5, 3.9, 4.0, 4.4, 4.5])
          place('rating$rating', rating: rating, reviews: 1),
        place('ratingUnknown', reviews: 1),
      ]);
      expect(await ids(discoverQuery(exactPriceLevel: 2)), {'price2'});
      expect(await ids(discoverQuery(exactPriceLevel: 4)), {'price4'});
      expect(
        (await ids(discoverQuery()))
            .containsAll(['priceUnknown', 'ratingUnknown']),
        isTrue,
      );
      expect(await ids(discoverQuery(minimumRating: 3.5)), {
        'rating3.5',
        'rating3.9',
        'rating4.0',
        'rating4.4',
        'rating4.5',
      });
      expect(await ids(discoverQuery(minimumRating: 4.0)), {
        'rating4.0',
        'rating4.4',
        'rating4.5',
      });
      expect(await ids(discoverQuery(minimumRating: 4.5)), {'rating4.5'});
    });

    test(
      'hours windows use half-open local intervals and overnight spill',
      () async {
        final stale = fixtureNow.subtract(const Duration(hours: 100));
        // fixtureNow is Wednesday (day 3) 10:00 in Riyadh.
        await seed([
          place('regular', reviews: 13, hours: [period(3, 480, 1380)]),
          place('late', reviews: 12, hours: [period(3, 1080, 1381)]),
          place('overnight', reviews: 11, hours: [period(2, 1200, 120)]),
          place('dawn', reviews: 10, hours: [period(2, 1320, 390)]),
          place('elevenses', reviews: 9, hours: [period(3, 660, 900)]),
          place('early', reviews: 8, hours: [period(3, 0, 360)]),
          place('friday', reviews: 7, hours: [period(5, 540, 1020)]),
          place('thursdayNight', reviews: 6, hours: [period(4, 1320, 60)]),
          place('thursday', reviews: 5, hours: [period(4, 720, 1380)]),
          place('always', reviews: 4, hours: [period(3, 0, 1440)]),
          place('unknown', reviews: 3),
          place(
            'malformed',
            reviews: 2,
            hours: [
              OpeningPeriod(
                day: 9,
                openMinutes: 0,
                closeMinutes: 1440,
                overnight: false,
              ),
            ],
          ),
          place(
            'stale',
            reviews: 1,
            hours: [period(3, 480, 1380)],
            checkedAt: stale,
          ),
        ]);
        Future<Set<String>> inWindows(List<DiscoverHoursWindow> windows) =>
            ids(discoverQuery(hoursWindows: windows));

        expect(await inWindows([DiscoverHoursWindow.openNow]), {
          'regular',
          'always',
        });
        expect(await inWindows([DiscoverHoursWindow.openLate]), {
          'late',
          'always',
        });
        expect(await inWindows([DiscoverHoursWindow.breakfast]), {
          'regular',
          'dawn',
          'always',
        });
        expect(await inWindows([DiscoverHoursWindow.openFriday]), {
          'friday',
          'thursdayNight',
        });
        expect(
          await inWindows([
            DiscoverHoursWindow.openNow,
            DiscoverHoursWindow.openFriday,
          ]),
          {'regular', 'always', 'friday', 'thursdayNight'},
        );

        final all = await browse(discoverQuery());
        final openNow = {
          for (final item in all.items) item.place.placeId: item.openNow,
        };
        expect(openNow['regular'], isTrue);
        expect(openNow['overnight'], isFalse);
        expect(openNow['unknown'], isNull);
        expect(openNow['malformed'], isNull);
        expect(openNow['stale'], isNull);
      },
    );

    test('overnight hours roll from Sunday into Monday', () async {
      // Sunday 23:00 UTC is Monday 02:00 in Riyadh.
      pinDiscoveryClock(DateTime.utc(2026, 9, 13, 23));
      await seed([
        place('sundayNight', reviews: 3, hours: [period(7, 1320, 180)]),
        place('sundayEvening', reviews: 2, hours: [period(7, 1080, 1380)]),
        place('mondayDay', reviews: 1, hours: [period(1, 540, 1020)]),
      ]);
      expect(
        await ids(
          discoverQuery(hoursWindows: const [DiscoverHoursWindow.openNow]),
        ),
        {'sundayNight'},
      );
    });

    test('hours use each country offset at the same instant', () async {
      // 06:30 UTC: 09:30 in Riyadh, 10:30 in Dubai and Muscat.
      pinDiscoveryClock(DateTime.utc(2026, 9, 16, 6, 30));
      final tenToEleven = [period(3, 600, 660)];
      await seed([
        place('riyadh', reviews: 1, hours: tenToEleven),
        place(
          'dubai',
          reviews: 1,
          hours: tenToEleven,
          countryCode: 'AE',
          latitude: 25.2,
          longitude: 55.27,
        ),
        place(
          'muscat',
          reviews: 1,
          hours: tenToEleven,
          countryCode: 'OM',
          latitude: 23.6,
          longitude: 58.4,
        ),
      ]);
      Future<List<String>> openIn(DiscoverViewport view) async => placeIds(
        await browse(
          discoverQuery(
            viewport: view,
            hoursWindows: const [DiscoverHoursWindow.openNow],
          ),
        ),
      );
      expect(await openIn(riyadhView), isEmpty);
      expect(await openIn(dubaiView), ['dubai']);
      expect(await openIn(muscatView), ['muscat']);
      expect(
        (await browse(discoverQuery(viewport: dubaiView))).context.countryCode,
        'AE',
      );
    });

    test('text matches names and descriptions and escapes wildcards', () async {
      await seed([
        place('name', reviews: 9, name: 'Blue Door Cafe'),
        place(
          'summary',
          reviews: 8,
          summary: 'Famous for Blue   door\npastries',
        ),
        place(
          'staleSummary',
          reviews: 7,
          summary: 'A blue door by the souq',
          checkedAt: fixtureNow.subtract(const Duration(hours: 100)),
        ),
        place('review', reviews: 6, featuredReview: 'Loved the blue door'),
        place('percent', reviews: 5, name: '100% Juice'),
        place('thousand', reviews: 4, name: '1000 Juices'),
        place('underscore', reviews: 3, name: 'a_b corner'),
        place('letter', reviews: 2, name: 'axb corner'),
        place('arabic', reviews: 1, name: 'مقهى الباب الأزرق'),
      ]);
      const described = {'name', 'summary', 'staleSummary'};
      expect(await ids(discoverQuery(text: 'blue door')), described);
      expect(await ids(discoverQuery(text: '  BLUE   door ')), described);
      expect(await ids(discoverQuery(text: '100%')), {'percent'});
      expect(await ids(discoverQuery(text: 'a_b')), {'underscore'});
      expect(await ids(discoverQuery(text: 'الباب')), {'arabic'});
    });

    test('completeness requirements are ANDed over visible fields', () async {
      final stale = fixtureNow.subtract(const Duration(hours: 100));
      final hours = [period(3, 480, 1380)];
      await seed([
        place(
          'full',
          reviews: 7,
          photos: true,
          hours: hours,
          phone: '+966500000000',
          website: 'https://example.com',
          price: 2,
        ),
        place('photos', reviews: 6, photos: true),
        place(
          'badHours',
          reviews: 5,
          hours: [
            OpeningPeriod(
              day: 0,
              openMinutes: 480,
              closeMinutes: 1380,
              overnight: false,
            ),
          ],
        ),
        place('phone', reviews: 4, phone: '+966500000000'),
        place('website', reviews: 3, website: 'https://example.com'),
        place('price', reviews: 2, price: 3),
        place(
          'staleFull',
          reviews: 1,
          photos: true,
          hours: hours,
          phone: '+966500000000',
          website: 'https://example.com',
          price: 2,
          checkedAt: stale,
        ),
      ]);
      Future<Set<String>> requiring(List<DiscoverCompleteness> values) =>
          ids(discoverQuery(completeness: values));

      expect(await requiring([DiscoverCompleteness.photos]), {
        'full',
        'photos',
        'staleFull',
      });
      expect(await requiring([DiscoverCompleteness.hours]), {'full'});
      expect(await requiring([DiscoverCompleteness.contact]), {
        'full',
        'phone',
        'website',
        'staleFull',
      });
      expect(await requiring([DiscoverCompleteness.price]), {'full', 'price'});
      expect(
        await requiring([
          DiscoverCompleteness.photos,
          DiscoverCompleteness.contact,
        ]),
        {'full', 'staleFull'},
      );
    });

    test(
      'closed and quarantined places never reach results or counts',
      () async {
        await seed([
          place('open', reviews: 6, statusText: 'Open · Closes 11 PM'),
          place('permanent', reviews: 5, statusText: 'Permanently closed'),
          place('temporary', reviews: 4, statusText: 'Temporarily   Closed'),
          place('arabicPermanent', reviews: 3, statusText: 'مغلق نهائيًا'),
          place('arabicTemporary', reviews: 2, statusText: 'مغلق مؤقتًا'),
          place('quarantined', reviews: 1, quarantinedAt: fixtureNow),
        ]);
        final page = await endpoints.discover.browse(
          member,
          query: discoverQuery(),
          pageSize: 50,
          includeMap: true,
        );
        expect(placeIds(page), ['open']);
        expect(page.total, 1);
        expect(page.map?.points.map((point) => point.placeId), ['open']);
        expect(page.coverage.eligibleCatalogCount, 1);

        final facets = await endpoints.discover.facets(
          member,
          query: discoverQuery(),
          context: page.context,
        );
        expect(facets.total, 1);

        final closed = await endpoints.discover.placeContext(
          member,
          identity: PoiIdentity(
            provider: fixtureProvider,
            placeId: 'permanent',
          ),
          query: discoverQuery(),
          context: page.context,
        );
        expect(closed.eligible, isFalse);
      },
    );
  });
}
