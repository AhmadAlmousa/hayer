import 'dart:async';

import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

void main() {
  withServerpod('Discover request validation and budgets', (
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
      int pageSize = 10,
    }) => endpoints.discover.browse(
      member,
      query: query,
      pageSize: pageSize,
      includeMap: false,
    );

    tearDown(() async {
      final session = builder.build();
      try {
        await resetDiscovery(session);
      } finally {
        await session.close();
      }
    });

    test(
      'bad bounds are invalid_area; other areas are unsupported_area',
      () async {
        await seed(const []);
        for (final view in [
          DiscoverViewport(south: 24.8, west: 46.5, north: 24.6, east: 46.8),
          DiscoverViewport(south: 24.6, west: 46.8, north: 24.8, east: 46.5),
          DiscoverViewport(south: 10, west: 40, north: 26, east: 50),
          DiscoverViewport(south: 20, west: 36, north: 26, east: 52),
          DiscoverViewport(south: 89, west: 46.5, north: 91, east: 46.8),
          DiscoverViewport(south: 24.6, west: 179.9, north: 24.8, east: 180.1),
        ]) {
          await expectLater(
            browse(discoverQuery(viewport: view)),
            throwsA(apiError('invalid_area')),
            reason: '$view',
          );
        }
        await expectLater(
          browse(
            discoverQuery(
              viewport: DiscoverViewport(
                south: 48.8,
                west: 2.2,
                north: 48.9,
                east: 2.4,
              ),
            ),
          ),
          throwsA(apiError('unsupported_area')),
        );
        await expectLater(
          browse(discoverQuery(countryCode: 'AE')),
          throwsA(apiError('unsupported_area')),
        );
        final hinted = await browse(discoverQuery(countryCode: 'sa'));
        expect(hinted.context.countryCode, 'SA');
      },
    );

    test('malformed pages, filters and identities are bad_request', () async {
      await seed([place('a', rating: 4.0, reviews: 10)]);
      final badRequest = throwsA(apiError('bad_request'));
      await expectLater(browse(discoverQuery(), pageSize: 0), badRequest);
      await expectLater(browse(discoverQuery(), pageSize: 101), badRequest);
      await expectLater(
        browse(
          discoverQuery(categoryIds: [for (var i = 0; i < 51; i++) 'cafes']),
        ),
        badRequest,
      );
      await expectLater(browse(discoverQuery(text: 'م' * 257)), badRequest);
      expect((await browse(discoverQuery(text: 'م' * 256))).total, 0);
      await expectLater(browse(discoverQuery(exactPriceLevel: 0)), badRequest);
      await expectLater(browse(discoverQuery(exactPriceLevel: 5)), badRequest);
      await expectLater(browse(discoverQuery(minimumRating: 5.5)), badRequest);
      await expectLater(
        browse(discoverQuery(categoryIds: const ['nope'])),
        badRequest,
      );
      final page = await browse(discoverQuery(), pageSize: 100);
      expect(page.items, hasLength(1));
      await expectLater(
        endpoints.discover.placeContext(
          member,
          identity: PoiIdentity(provider: fixtureProvider, placeId: ' '),
          query: discoverQuery(),
          context: page.context,
        ),
        badRequest,
      );
    });

    test('browse, facets and place context spend separate budgets', () async {
      await seed(
        [place('a', rating: 4.0, reviews: 10)],
        policy: (discovery) => discovery.copyWith(
          browseRequestsPerMinute: 2,
          facetRequestsPerMinute: 2,
        ),
      );
      final query = discoverQuery();
      final rateLimited = throwsA(
        apiError('rate_limited').having(
          (error) => error.retryAfterSeconds,
          'retryAfterSeconds',
          inInclusiveRange(1, 60),
        ),
      );

      final first = await browse(query);
      await browse(query);
      await expectLater(browse(query), rateLimited);

      Future<DiscoverFacets> facets() => endpoints.discover.facets(
        member,
        query: query,
        context: first.context,
      );
      await facets();
      await facets();
      await expectLater(facets(), rateLimited);

      final context = await endpoints.discover.placeContext(
        member,
        identity: PoiIdentity(provider: fixtureProvider, placeId: 'a'),
        query: query,
        context: first.context,
      );
      expect(context.eligible, isTrue);
    });
  });

  withServerpod(
    'Discover statement timeout',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final member = discoveryMember(builder, 'discovery-timeout');

      tearDown(() async {
        final session = builder.build();
        try {
          await resetDiscovery(session);
        } finally {
          await session.close();
        }
      });

      test('a statement timeout is rate_limited with a retry wait', () async {
        final setup = builder.build();
        try {
          await seedDiscovery(
            setup,
            policy: (discovery) =>
                discovery.copyWith(queryTimeoutMilliseconds: 100),
          );
        } finally {
          await setup.close();
        }

        // Holding a lock on the catalog makes the Discover statement wait
        // past its timeout, which PostgreSQL reports as query_canceled.
        final locker = builder.build();
        final locked = Completer<void>();
        final release = Completer<void>();
        final holder = locker.db.transaction((transaction) async {
          await locker.db.unsafeExecute(
            'LOCK TABLE "hayer_poi_catalog" IN ACCESS EXCLUSIVE MODE',
            transaction: transaction,
          );
          locked.complete();
          await release.future;
        });
        try {
          await locked.future;
          await expectLater(
            endpoints.discover.browse(
              member,
              query: discoverQuery(),
              pageSize: 10,
              includeMap: false,
            ),
            throwsA(
              apiError('rate_limited').having(
                (error) => error.retryAfterSeconds,
                'retryAfterSeconds',
                5,
              ),
            ),
          );
        } finally {
          release.complete();
          await holder;
          await locker.close();
        }
      });
    },
  );
}
