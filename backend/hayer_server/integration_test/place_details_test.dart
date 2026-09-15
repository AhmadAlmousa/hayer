import 'dart:async';

import 'package:hayer_server/src/discovery/discovery_policy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_detail_resolver.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

typedef _Fetch = ({
  String query,
  double latitude,
  double longitude,
  String language,
  String countryCode,
});

/// Stands in for the shared Vela-derived source and counts every focused
/// provider search.
final class _FixtureSource implements FocusedPlaceSource {
  _FixtureSource(this.respond);

  final Future<List<PlaceCandidate>> Function(_Fetch fetch) respond;
  final fetches = <_Fetch>[];

  @override
  String get calibrationVersion => 'detail-fixture';

  @override
  Future<List<PlaceCandidate>> fetch({
    required String query,
    required double latitude,
    required double longitude,
    required String language,
    required String countryCode,
  }) {
    final call = (
      query: query,
      latitude: latitude,
      longitude: longitude,
      language: language,
      countryCode: countryCode,
    );
    fetches.add(call);
    return respond(call);
  }
}

final _staleCheck = fixtureNow.subtract(const Duration(days: 5));

PoiCatalogRow _complete(String id) => place(
  id,
  rating: 4.5,
  reviews: 80,
  price: 2,
  hours: [period(1, 480, 1320)],
  photos: true,
  phone: '+966 11 000 0000',
  website: 'https://example.com/$id',
  summary: 'A fixture place.',
);

PlaceCandidate _candidate(
  String id, {
  bool complete = true,
  String? phone,
  double latitude = 24.71,
}) => PlaceCandidate(
  placeId: id,
  name: 'Place $id',
  primaryType: 'Coffee shop',
  rating: 4.4,
  reviewCount: 120,
  priceLevel: complete ? 2 : null,
  priceText: complete ? r'$$' : null,
  hours: complete ? [period(1, 420, 1380)] : const [],
  latitude: latitude,
  longitude: 46.66,
  phoneNumber: phone ?? (complete ? '+966 11 111 1111' : null),
  websiteUrl: complete ? 'https://example.com/fresh/$id' : null,
  photoUrls: complete ? ['https://example.com/fresh/$id.jpg'] : const [],
  editorialSummary: complete ? 'Freshly observed.' : null,
  sourceCheckedAt: fixtureNow,
);

void main() {
  withServerpod(
    'Shared place details',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, endpoints) {
      final discoverUser = discoveryMember(builder, 'detail-discover');
      final swipeUser = discoveryMember(builder, 'detail-swipe');
      final outsider = discoveryMember(builder, 'detail-outsider');
      final productionSource = PlaceDetailResolver.sourceFor;
      late _FixtureSource source;

      void useSource(
        Future<List<PlaceCandidate>> Function(_Fetch fetch) respond,
      ) {
        source = _FixtureSource(respond);
        PlaceDetailResolver.sourceFor = (_, _) async => source;
      }

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

      Future<void> reset() => withSession((session) async {
        await session.db.unsafeExecute(
          'TRUNCATE TABLE "hayer_poi_detail_refresh", "hayer_session" CASCADE',
        );
        await session.db.unsafeExecute('DELETE FROM "hayer_poi_category"');
        await session.db.unsafeExecute('DELETE FROM "hayer_poi_coverage"');
        await resetDiscovery(session);
      });

      setUp(() async {
        await reset();
        PlaceDetailResolver.clock = () => fixtureNow;
        pinDiscoveryClock(fixtureNow);
        useSource((_) async => const []);
      });

      tearDown(() async {
        PlaceDetailResolver.sourceFor = productionSource;
        PlaceDetailResolver.clock = () => DateTime.now().toUtc();
        restoreDiscoveryClock();
        await reset();
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

      Future<PoiCatalogRow?> catalogRow(String id) => withSession(
        (session) => PoiCatalogRow.db.findFirstRow(
          session,
          where: (table) => table.providerPlaceId.equals(id),
        ),
      );

      Future<PoiDetailRefreshRow?> refreshRow(String id) => withSession(
        (session) => PoiDetailRefreshRow.db.findFirstRow(
          session,
          where: (table) => table.providerPlaceId.equals(id),
        ),
      );

      Future<void> useDetailPolicy(
        Session session,
        PlaceDetailPolicy detail,
      ) async {
        final existing = await DiscoveryPolicyService.settings(session);
        final current = existing == null
            ? DiscoveryPolicyService.defaultPolicy()
            : DiscoveryPolicyService.fromRow(existing);
        final row = DiscoveryPolicyService.toRow(
          current.copyWith(detailRefresh: detail),
          existing: existing,
          updatedBy: 'detail-test',
          updatedAt: DateTime.now().toUtc(),
        );
        if (existing == null) {
          await CacheSettingsRow.db.insertRow(session, row);
        } else {
          await CacheSettingsRow.db.updateRow(session, row);
        }
      }

      test(
        'fresh complete places need no provider request, with Discover off',
        () async {
          await withSession(
            (session) => PoiCatalogRow.db.insertRow(session, _complete('full')),
          );
          final config = await endpoints.bootstrap.discoveryConfig(builder);
          expect(config.enabled, isFalse);
          expect(config.detailsAvailable, isTrue);

          for (final user in [discoverUser, swipeUser]) {
            final result = await details(user, 'full');
            expect(result.refreshState, PlaceDetailRefreshState.notNeeded);
            expect(result.identity.provider, fixtureProvider);
            expect(result.identity.placeId, 'full');
            expect(result.stale, isFalse);
            expect(result.missingFields, isEmpty);
            expect(result.place.phoneNumber, '+966 11 000 0000');
            expect(result.retryAfter, isNull);
            expect(result.fetchedAt, fixtureNow);
          }
          expect(source.fetches, isEmpty);
          expect(await refreshRow('full'), isNull);
        },
      );

      test(
        'a missing-field check runs once and serves every user and mode',
        () async {
          final gap = place('gap', rating: 4.1, reviews: 12);
          await withSession((session) async {
            await PoiCatalogRow.db.insertRow(session, gap);
            await insertSwipeSession(
              session,
              sessionId: 'detail-session',
              code: 'DET001',
              userId: 'detail-swipe',
              places: [gap.snapshot.copyWith(distanceMeters: 250)],
            );
          });
          useSource(
            (_) async => [
              _candidate('gap'),
              _candidate('neighbour', latitude: 24.72),
            ],
          );

          final first = await details(discoverUser, 'gap');
          expect(first.refreshState, PlaceDetailRefreshState.succeeded);
          final fetch = source.fetches.single;
          expect(fetch.query, 'Place gap');
          expect(fetch.language, 'en');
          expect(fetch.countryCode, 'SA');
          expect(fetch.latitude, gap.latitude);
          expect(fetch.longitude, gap.longitude);
          expect(first.place.phoneNumber, '+966 11 111 1111');
          expect(first.missingFields, isEmpty);
          expect(first.lastAttemptAt, fixtureNow);
          expect(first.lastSuccessAt, fixtureNow);
          expect(first.retryAfter, isNull);

          // The canonical record and a neighbouring observation are stored,
          // without manufacturing Swipe evidence or coverage.
          final stored = await catalogRow('gap');
          expect(stored!.snapshot.phoneNumber, '+966 11 111 1111');
          expect(stored.sourceCheckedAt, fixtureNow);
          expect(stored.calibrationVersion, 'detail-fixture');
          expect(stored.firstSeenAt, gap.firstSeenAt);
          expect(await catalogRow('neighbour'), isNotNull);
          await withSession((session) async {
            expect(await PoiCategoryRow.db.count(session), 0);
            expect(await PoiCoverageRow.db.count(session), 0);
          });

          final fromSwipe = await details(
            swipeUser,
            'gap',
            sessionId: 'detail-session',
          );
          expect(fromSwipe.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(fromSwipe.place.phoneNumber, '+966 11 111 1111');
          expect(fromSwipe.place.distanceMeters, 250);
          expect(source.fetches, hasLength(1));

          // The swipe session keeps its own snapshot, order and revision.
          await withSession((session) async {
            final deckPlace = await SessionPlaceRow.db.findFirstRow(
              session,
              where: (table) => table.sessionId.equals('detail-session'),
            );
            expect(deckPlace!.snapshot.phoneNumber, isNull);
            expect(deckPlace.deckOrder, 0);
            final room = await HayerSessionRow.db.findFirstRow(
              session,
              where: (table) => table.sessionId.equals('detail-session'),
            );
            expect(room!.revision, 3);
          });

          // Discover reads the same refreshed record without another request.
          await withSession((session) async {
            await useDiscoveryPolicy(session);
            await publishDiscoveryTree(session, fixtureTree, revision: 1);
          });
          final page = await endpoints.discover.browse(
            discoverUser,
            query: discoverQuery(),
            pageSize: 10,
            includeMap: false,
          );
          final listed = page.items.singleWhere(
            (item) => item.place.placeId == 'gap',
          );
          expect(listed.place.phoneNumber, '+966 11 111 1111');
          expect(placeIds(page), contains('neighbour'));
          expect(source.fetches, hasLength(1));
        },
      );

      test(
        'a stale place without an exact match keeps its record and cools down',
        () async {
          final old = place(
            'old',
            rating: 4.2,
            reviews: 30,
            phone: '+966 11 222 2222',
            photos: true,
            checkedAt: _staleCheck,
          );
          await withSession(
            (session) => PoiCatalogRow.db.insertRow(session, old),
          );
          useSource((_) async => [_candidate('elsewhere')]);

          final result = await details(discoverUser, 'old');
          expect(result.refreshState, PlaceDetailRefreshState.noMatch);
          expect(result.stale, isTrue);
          expect(result.place.isStale, isTrue);
          expect(result.place.rating, isNull);
          expect(result.place.phoneNumber, isNull);
          expect(result.place.photoUrls, old.snapshot.photoUrls);
          expect(result.place.sourceCheckedAt, _staleCheck);
          expect(
            result.missingFields,
            containsAll([PlaceDetailField.hours, PlaceDetailField.phone]),
          );
          expect(result.retryAfter, fixtureNow.add(const Duration(hours: 1)));

          final stored = await catalogRow('old');
          expect(stored!.sourceCheckedAt, _staleCheck);
          expect(stored.snapshot.rating, 4.2);
          expect(await catalogRow('elsewhere'), isNotNull);
          final refresh = await refreshRow('old');
          expect(refresh!.state, PlaceDetailRefreshState.noMatch);
          expect(refresh.lastFailureCode, 'no_match');
          expect(refresh.lastCheckedAt, fixtureNow);
          expect(refresh.lastSuccessAt, isNull);
          expect(refresh.leaseToken, isNull);

          final again = await details(swipeUser, 'old');
          expect(again.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(again.retryAfter, result.retryAfter);
          expect(source.fetches, hasLength(1));

          PlaceDetailResolver.clock = () =>
              fixtureNow.add(const Duration(minutes: 61));
          final retried = await details(discoverUser, 'old');
          expect(retried.refreshState, PlaceDetailRefreshState.noMatch);
          expect(source.fetches, hasLength(2));
          expect((await refreshRow('old'))!.attemptCount, 2);
        },
      );

      test(
        'source failures and a busy provider keep the stored snapshot',
        () async {
          await withSession(
            (session) => PoiCatalogRow.db.insert(session, [
              place('down', rating: 4.0, reviews: 5, checkedAt: _staleCheck),
              place('busy', checkedAt: _staleCheck),
            ]),
          );
          useSource(
            (fetch) async => throw PlaceSourceException(
              fetch.query == 'Place busy'
                  ? 'rate_limited'
                  : 'place_source_unavailable',
              'Fixture failure.',
            ),
          );

          final failed = await details(discoverUser, 'down');
          expect(failed.refreshState, PlaceDetailRefreshState.failed);
          expect(failed.place.name, 'Place down');
          expect(failed.retryAfter, fixtureNow.add(const Duration(hours: 1)));
          final down = await refreshRow('down');
          expect(down!.state, PlaceDetailRefreshState.failed);
          expect(down.lastFailureCode, 'place_source_unavailable');
          expect(down.lastCheckedAt, isNull);
          expect((await catalogRow('down'))!.sourceCheckedAt, _staleCheck);

          final busy = await details(discoverUser, 'busy');
          expect(busy.refreshState, PlaceDetailRefreshState.budgetExceeded);
          expect(busy.retryAfter, fixtureNow.add(const Duration(minutes: 1)));
          expect((await refreshRow('busy'))!.lastFailureCode, 'rate_limited');

          final cooling = await details(swipeUser, 'down');
          expect(cooling.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(source.fetches, hasLength(2));
        },
      );

      test(
        'an exact match that still lacks fields is not searched again soon',
        () async {
          await withSession(
            (session) => PoiCatalogRow.db.insertRow(session, place('partial')),
          );
          useSource(
            (_) async => [
              _candidate('partial', complete: false, phone: '+966 11 333 3333'),
            ],
          );

          final result = await details(discoverUser, 'partial');
          expect(result.refreshState, PlaceDetailRefreshState.succeeded);
          expect(result.place.phoneNumber, '+966 11 333 3333');
          expect(result.missingFields, [
            PlaceDetailField.photos,
            PlaceDetailField.hours,
            PlaceDetailField.website,
            PlaceDetailField.price,
            PlaceDetailField.description,
          ]);
          expect(result.retryAfter, fixtureNow.add(const Duration(hours: 1)));

          // Past the cooldown but inside the freshness window, the provider
          // has already been asked about the missing fields.
          PlaceDetailResolver.clock = () =>
              fixtureNow.add(const Duration(hours: 2));
          final later = await details(swipeUser, 'partial');
          expect(later.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(later.retryAfter, isNull);
          expect(source.fetches, hasLength(1));

          // Once the record itself is stale it is searched again.
          PlaceDetailResolver.clock = () =>
              fixtureNow.add(const Duration(hours: 73));
          final stale = await details(swipeUser, 'partial');
          expect(stale.refreshState, PlaceDetailRefreshState.succeeded);
          expect(source.fetches, hasLength(2));
        },
      );

      test('concurrent opens share one lease', () async {
        await withSession(
          (session) => PoiCatalogRow.db.insertRow(
            session,
            place('race', checkedAt: _staleCheck),
          ),
        );
        final started = Completer<void>();
        final release = Completer<void>();
        useSource((_) async {
          started.complete();
          await release.future;
          return [_candidate('race')];
        });

        final first = details(discoverUser, 'race');
        await started.future;
        final lease = await refreshRow('race');
        expect(lease!.state, PlaceDetailRefreshState.refreshing);
        // The default 20-second policy is capped at the 10-second contract,
        // and the lease adds a 30-second margin.
        expect(
          lease.leaseExpiresAt,
          fixtureNow.add(const Duration(seconds: 40)),
        );

        final second = await details(swipeUser, 'race');
        expect(second.refreshState, PlaceDetailRefreshState.refreshing);
        expect(second.place.isStale, isTrue);

        release.complete();
        expect((await first).refreshState, PlaceDetailRefreshState.succeeded);
        final third = await details(outsider, 'race');
        expect(third.refreshState, PlaceDetailRefreshState.notNeeded);
        expect(third.stale, isFalse);
        expect(source.fetches, hasLength(1));
      });

      test('the stored policy deadline bounds a slow source', () async {
        await withSession((session) async {
          await PoiCatalogRow.db.insertRow(
            session,
            place('slow', checkedAt: _staleCheck),
          );
          await useDetailPolicy(
            session,
            PlaceDetailPolicy(
              maximumRequests: 3,
              maximumSeconds: 1,
              cooldownMinutes: 15,
            ),
          );
        });
        useSource((_) async {
          await Future<void>.delayed(const Duration(seconds: 4));
          return [_candidate('slow')];
        });

        final watch = Stopwatch()..start();
        final result = await details(discoverUser, 'slow');
        expect(watch.elapsed, lessThan(const Duration(seconds: 3)));
        expect(result.refreshState, PlaceDetailRefreshState.failed);
        expect(result.retryAfter, fixtureNow.add(const Duration(minutes: 15)));
        expect((await catalogRow('slow'))!.sourceCheckedAt, _staleCheck);
      });

      test(
        'a user past the refresh budget is served without a refresh',
        () async {
          await withSession((session) async {
            await PoiCatalogRow.db.insertRow(
              session,
              place('budget', checkedAt: _staleCheck),
            );
            final now = DateTime.now().toUtc();
            await RateLimitRow.db.insertRow(
              session,
              RateLimitRow(
                counterKey: 'place-detail-refresh:detail-discover',
                attemptCount: PlaceDetailResolver.refreshesPerUserPerHour,
                windowStartedAt: now,
                expiresAt: now.add(const Duration(hours: 1)),
              ),
            );
          });

          final result = await details(discoverUser, 'budget');
          expect(result.refreshState, PlaceDetailRefreshState.budgetExceeded);
          expect(
            result.retryAfter!.isAfter(
              fixtureNow.add(const Duration(minutes: 59)),
            ),
            isTrue,
          );
          expect(source.fetches, isEmpty);
          expect(await refreshRow('budget'), isNull);

          // Another user's budget still allows the refresh.
          final other = await details(swipeUser, 'budget');
          expect(other.refreshState, PlaceDetailRefreshState.noMatch);
          expect(source.fetches, hasLength(1));
        },
      );

      test(
        'identities and sessions are validated before any refresh',
        () async {
          final hidden = place(
            'hidden',
            checkedAt: _staleCheck,
            quarantinedAt: fixtureNow.subtract(const Duration(days: 1)),
          );
          final orphan = place(
            'orphan',
            phone: '+966 11 444 4444',
            checkedAt: _staleCheck,
          ).snapshot.copyWith(distanceMeters: 90);
          await withSession((session) async {
            await PoiCatalogRow.db.insertRow(session, hidden);
            await insertSwipeSession(
              session,
              sessionId: 'auth-session',
              code: 'DET002',
              userId: 'detail-swipe',
              places: [hidden.snapshot, orphan],
            );
          });
          useSource((_) async => [_candidate('orphan')]);

          await expectLater(
            endpoints.place.details(
              swipeUser,
              identity: PoiIdentity(provider: fixtureProvider, placeId: ' '),
            ),
            throwsA(apiError('bad_request')),
          );
          await expectLater(
            details(swipeUser, 'orphan', sessionId: ''),
            throwsA(apiError('bad_request')),
          );
          await expectLater(
            endpoints.place.details(
              swipeUser,
              identity: PoiIdentity(provider: 'other', placeId: 'orphan'),
            ),
            throwsA(apiError('not_found')),
          );
          await expectLater(
            details(discoverUser, 'unknown'),
            throwsA(apiError('not_found')),
          );
          await expectLater(
            details(discoverUser, 'hidden'),
            throwsA(apiError('not_found')),
          );
          await expectLater(
            details(discoverUser, 'orphan'),
            throwsA(apiError('not_found')),
          );
          await expectLater(
            details(outsider, 'orphan', sessionId: 'auth-session'),
            throwsA(apiError('forbidden')),
          );
          await expectLater(
            details(swipeUser, 'unknown', sessionId: 'auth-session'),
            throwsA(apiError('not_found')),
          );
          expect(source.fetches, isEmpty);

          // A quarantined record stays readable from the session showing it,
          // but is never refreshed.
          final quarantined = await details(
            swipeUser,
            'hidden',
            sessionId: 'auth-session',
          );
          expect(quarantined.refreshState, PlaceDetailRefreshState.notNeeded);
          expect(quarantined.stale, isTrue);
          expect(source.fetches, isEmpty);

          // A place the catalog no longer holds is refreshed from the
          // session's trusted name and location, into the catalog only.
          final refreshed = await details(
            swipeUser,
            'orphan',
            sessionId: 'auth-session',
          );
          expect(refreshed.refreshState, PlaceDetailRefreshState.succeeded);
          expect(refreshed.place.distanceMeters, 90);
          expect(source.fetches.single.query, 'Place orphan');
          expect((await catalogRow('orphan'))!.countryCode, 'SA');
          await withSession((session) async {
            final deckPlace = await SessionPlaceRow.db.findFirstRow(
              session,
              where: (table) => table.placeId.equals('orphan'),
            );
            expect(deckPlace!.snapshot.phoneNumber, '+966 11 444 4444');
          });
        },
      );
    },
  );
}
