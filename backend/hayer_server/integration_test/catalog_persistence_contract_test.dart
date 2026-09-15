import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/catalog_observation_writer.dart';
import 'package:hayer_server/src/places/catalog_persistence.dart';
import 'package:hayer_server/src/places/catalog_place_service.dart';
import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

const _latitude = 24.7136;
const _longitude = 46.6753;
const _calibrationVersion = 'catalog-contract-1';

void main() {
  withServerpod(
    'Catalog persistence and provenance contract',
    (sessionBuilder, _) {
      setUp(() => _resetTables(sessionBuilder));
      tearDown(() => _resetTables(sessionBuilder));

      test(
        'overlapping refreshes upsert atomically and preserve moderation',
        () async {
          final firstSeen = DateTime.utc(2025, 1, 2, 3, 4, 5);
          final quarantinedAt = DateTime.utc(2026, 8, 1);
          final setup = sessionBuilder.build();
          try {
            final legacy = _snapshot(
              'shared',
              categoryId: 'thai',
              checkedAt: DateTime.utc(2026, 8, 2),
            );
            await PoiCatalogRow.db.insertRow(
              setup,
              PoiCatalogRow(
                provider: 'google-web',
                providerPlaceId: legacy.placeId,
                normalizedName: legacy.name.toLowerCase(),
                name: legacy.name,
                countryCode: 'SA',
                latitude: legacy.latitude,
                longitude: legacy.longitude,
                categoryIds: const ['thai'],
                snapshot: legacy,
                calibrationVersion: 'legacy',
                sourceCheckedAt: legacy.sourceCheckedAt,
                firstSeenAt: firstSeen,
                lastSeenAt: legacy.sourceCheckedAt,
                quarantinedAt: quarantinedAt,
                quarantineReason: 'Operator review in progress.',
              ),
            );
            await PoiCategoryRow.db.insertRow(
              setup,
              PoiCategoryRow(
                provider: 'google-web',
                providerPlaceId: legacy.placeId,
                categoryId: 'thai',
                evidenceQuery: 'thai',
                firstSeenAt: firstSeen,
                lastSeenAt: legacy.sourceCheckedAt,
              ),
            );
          } finally {
            await setup.close();
          }

          final source = _BarrierSource();
          final service = _service(source);
          final sessions = [sessionBuilder.build(), sessionBuilder.build()];
          try {
            await Future.wait([
              service.buildDeck(
                sessions[0],
                categoryId: 'restaurant',
                subcategoryIds: const ['pizza'],
                latitude: _latitude,
                longitude: _longitude,
                radiusMeters: 3000,
                deckSize: 2,
                maximumPriceLevel: 2,
                countryCode: 'SA',
              ),
              service.buildDeck(
                sessions[1],
                categoryId: 'restaurant',
                subcategoryIds: const ['sushi'],
                latitude: _latitude + 0.000001,
                longitude: _longitude,
                radiusMeters: 3000,
                deckSize: 1,
                maximumPriceLevel: 3,
                countryCode: 'SA',
              ),
            ]);

            final catalog = await PoiCatalogRow.db.find(
              sessions[0],
              orderBy: (table) => table.providerPlaceId,
            );
            expect(catalog.map((row) => row.providerPlaceId), [
              'pizza-only',
              'shared',
              'sushi-only',
            ]);
            final shared = catalog.singleWhere(
              (row) => row.providerPlaceId == 'shared',
            );
            expect(shared.firstSeenAt, firstSeen);
            expect(shared.quarantinedAt, quarantinedAt);
            expect(shared.quarantineReason, 'Operator review in progress.');
            expect(shared.categoryIds, ['pizza', 'restaurant', 'sushi']);
            expect(shared.snapshot.categoryIds, shared.categoryIds);

            final evidence = await PoiCategoryRow.db.find(sessions[0]);
            Set<String> categoriesFor(String placeId) => evidence
                .where(
                  (row) =>
                      row.providerPlaceId == placeId &&
                      row.evidenceQuery.startsWith(
                        catalogEvidencePrefix(_calibrationVersion),
                      ),
                )
                .map((row) => row.categoryId)
                .toSet();
            expect(categoriesFor('shared'), {'restaurant', 'pizza', 'sushi'});
            expect(categoriesFor('pizza-only'), {'restaurant', 'pizza'});
            expect(categoriesFor('sushi-only'), {'restaurant', 'sushi'});
            expect(shared.categoryIds, isNot(contains('thai')));
          } finally {
            for (final session in sessions) {
              await session.close();
            }
          }
        },
      );

      test(
        'disjoint, union and cached requests retain exact evidence',
        () async {
          final source = _CategorySource();
          final service = _service(source);
          final session = sessionBuilder.build();
          try {
            final pizza = await _deck(
              service,
              session,
              subcategoryIds: const ['pizza'],
              deckSize: 1,
            );
            final sushi = await _deck(
              service,
              session,
              subcategoryIds: const ['sushi'],
              deckSize: 1,
            );
            final union = await _deck(
              service,
              session,
              subcategoryIds: const ['pizza', 'sushi'],
              deckSize: 2,
            );
            expect(pizza.single.placeId, 'pizza-only');
            expect(sushi.single.placeId, 'sushi-only');
            expect(union.map((place) => place.placeId), [
              'pizza-only',
              'sushi-only',
            ]);
            expect(source.calls, 4);

            final cachedPizza = await _deck(
              service,
              session,
              subcategoryIds: const ['pizza'],
              deckSize: 1,
            );
            final cachedSushi = await _deck(
              service,
              session,
              subcategoryIds: const ['sushi'],
              deckSize: 1,
            );
            final cachedUnion = await _deck(
              service,
              session,
              subcategoryIds: const ['pizza', 'sushi'],
              deckSize: 2,
            );
            expect(cachedPizza.single.placeId, 'pizza-only');
            expect(cachedSushi.single.placeId, 'sushi-only');
            expect(cachedUnion.map((place) => place.placeId), [
              'pizza-only',
              'sushi-only',
            ]);
            expect(
              source.calls,
              4,
              reason: 'All repeated requests must hit cache.',
            );

            final rows = await PoiCatalogRow.db.find(
              session,
              orderBy: (table) => table.providerPlaceId,
            );
            expect(rows[0].categoryIds, ['pizza', 'restaurant']);
            expect(rows[1].categoryIds, ['restaurant', 'sushi']);
          } finally {
            await session.close();
          }
        },
      );

      test(
        'reports a partial live refresh instead of a full success',
        () async {
          final session = sessionBuilder.build();
          try {
            final outcome = await _service(_PartialSource())
                .buildDeckWithOutcome(
                  session,
                  categoryId: 'restaurant',
                  subcategoryIds: const ['pizza', 'sushi'],
                  latitude: _latitude,
                  longitude: _longitude,
                  radiusMeters: 3000,
                  deckSize: 2,
                  maximumPriceLevel: 2,
                  countryCode: 'SA',
                );

            expect(outcome.origin, CatalogDeckOrigin.partialLive);
            expect(outcome.sourceFailureCode, 'place_source_unavailable');
            expect(outcome.deck.map((place) => place.placeId), [
              'pizza-only',
            ]);
            final coverage = await PoiCoverageRow.db.findFirstRow(
              session,
              where: (table) => table.coverageKey.equals(
                _coverageKey(
                  categoryIds: const ['pizza', 'restaurant', 'sushi'],
                  countryCode: 'SA',
                  latitude: _latitude,
                  longitude: _longitude,
                  radiusMeters: 3000,
                ),
              ),
            );
            expect(coverage?.lastFailureCode, 'place_source_unavailable');
            expect(coverage?.invalidatedAt, isNotNull);
          } finally {
            await session.close();
          }
        },
      );

      test('a forced provider failure reports stale fallback', () async {
        final session = sessionBuilder.build();
        try {
          await _deck(
            _service(_CategorySource()),
            session,
            subcategoryIds: const ['pizza'],
            deckSize: 1,
          );

          final outcome =
              await _service(
                _FailingSource(),
              ).buildDeckWithOutcome(
                session,
                categoryId: 'restaurant',
                subcategoryIds: const ['pizza'],
                latitude: _latitude,
                longitude: _longitude,
                radiusMeters: 3000,
                deckSize: 1,
                maximumPriceLevel: 2,
                countryCode: 'SA',
                forceRefresh: true,
              );

          expect(outcome.origin, CatalogDeckOrigin.staleFallback);
          expect(outcome.sourceFailureCode, 'place_source_unavailable');
          expect(outcome.deck.single.placeId, 'pizza-only');
          expect(outcome.deck.single.isStale, isTrue);
        } finally {
          await session.close();
        }
      });

      test(
        'dense cache filters category, price and radius before its bound',
        () async {
          final session = sessionBuilder.build();
          try {
            final now = DateTime.now().toUtc();
            final irrelevant = [
              for (var index = 0; index < 505; index++)
                _snapshot(
                  'irrelevant-${index.toString().padLeft(3, '0')}',
                  categoryId: 'sushi',
                  checkedAt: now,
                  reviewCount: 10000 - index,
                ),
            ];
            final eligible = _snapshot(
              'pizza-eligible',
              categoryId: 'pizza',
              checkedAt: now,
              reviewCount: 10,
              priceLevel: 2,
            );
            final expensive = _snapshot(
              'pizza-expensive',
              categoryId: 'pizza',
              checkedAt: now,
              reviewCount: 20000,
              priceLevel: 4,
            );
            final outside = _snapshot(
              'pizza-outside',
              categoryId: 'pizza',
              checkedAt: now,
              reviewCount: 30000,
              latitude: _latitude + 1,
            );
            final places = [...irrelevant, eligible, expensive, outside];
            await PoiCatalogRow.db.insert(
              session,
              [
                for (final place in places)
                  PoiCatalogRow(
                    provider: 'google-web',
                    providerPlaceId: place.placeId,
                    normalizedName: place.name.toLowerCase(),
                    name: place.name,
                    countryCode: 'SA',
                    latitude: place.latitude,
                    longitude: place.longitude,
                    categoryIds: place.categoryIds,
                    snapshot: place,
                    calibrationVersion: _calibrationVersion,
                    sourceCheckedAt: now,
                    firstSeenAt: now,
                    lastSeenAt: now,
                  ),
              ],
            );
            await PoiCategoryRow.db.insert(
              session,
              [
                for (final place in places)
                  PoiCategoryRow(
                    provider: 'google-web',
                    providerPlaceId: place.placeId,
                    categoryId: place.categoryIds.single,
                    evidenceQuery:
                        '${catalogEvidencePrefix(_calibrationVersion)}query:${place.categoryIds.single}',
                    firstSeenAt: now,
                    lastSeenAt: now,
                  ),
              ],
            );
            await PoiCoverageRow.db.insertRow(
              session,
              PoiCoverageRow(
                coverageKey: _coverageKey(
                  categoryIds: const ['pizza', 'restaurant'],
                  countryCode: 'SA',
                  latitude: _latitude,
                  longitude: _longitude,
                  radiusMeters: 3000,
                ),
                queryKey: 'pizza,restaurant',
                language: 'en',
                countryCode: 'SA',
                anchorLatitude: _latitude,
                anchorLongitude: _longitude,
                radiusMeters: 3000,
                calibrationVersion: _calibrationVersion,
                resultCount: 3,
                refreshedAt: now,
                expiresAt: now.add(const Duration(hours: 1)),
              ),
            );

            final deck = await _deck(
              _service(_NeverSource()),
              session,
              subcategoryIds: const ['pizza'],
              deckSize: 1,
            );
            expect(deck.single.placeId, 'pizza-eligible');
          } finally {
            await session.close();
          }
        },
      );

      test(
        'unevidenced observations grow only the shared catalog',
        () async {
          final session = sessionBuilder.build();
          try {
            final previous = DateTime.now().toUtc().subtract(
              const Duration(minutes: 1),
            );
            final existing = _snapshot(
              'existing-swipe-place',
              categoryId: 'pizza',
              checkedAt: previous,
            );
            await PoiCatalogRow.db.insertRow(
              session,
              PoiCatalogRow(
                provider: 'google-web',
                providerPlaceId: existing.placeId,
                normalizedName: existing.name.toLowerCase(),
                name: existing.name,
                countryCode: 'SA',
                latitude: existing.latitude,
                longitude: existing.longitude,
                categoryIds: existing.categoryIds,
                snapshot: existing,
                calibrationVersion: _calibrationVersion,
                sourceCheckedAt: previous,
                firstSeenAt: previous,
                lastSeenAt: previous,
              ),
            );
            await PoiCategoryRow.db.insertRow(
              session,
              PoiCategoryRow(
                provider: 'google-web',
                providerPlaceId: existing.placeId,
                categoryId: 'pizza',
                evidenceQuery:
                    '${catalogEvidencePrefix(_calibrationVersion)}query:pizza restaurants',
                firstSeenAt: previous,
                lastSeenAt: previous,
              ),
            );
            await PoiCoverageRow.db.insertRow(
              session,
              PoiCoverageRow(
                coverageKey: 'existing-coverage',
                queryKey: 'pizza,restaurant',
                language: 'en',
                countryCode: 'SA',
                anchorLatitude: _latitude,
                anchorLongitude: _longitude,
                radiusMeters: 3000,
                calibrationVersion: _calibrationVersion,
                resultCount: 1,
                refreshedAt: previous,
                expiresAt: previous.add(const Duration(hours: 1)),
              ),
            );

            final observedAt = DateTime.now().toUtc();
            await const CatalogObservationWriter(
              calibrationVersion: _calibrationVersion,
            ).write(
              session,
              [
                _snapshot(
                  existing.placeId,
                  categoryId: 'not-swipe-evidence',
                  checkedAt: observedAt,
                ),
                _snapshot(
                  'broad-only-place',
                  categoryId: 'not-swipe-evidence',
                  checkedAt: observedAt,
                ),
              ],
              countryCode: 'SA',
              observedAt: observedAt,
            );

            expect(await PoiCatalogRow.db.count(session), 2);
            expect(await PoiCategoryRow.db.count(session), 1);
            expect(await PoiCoverageRow.db.count(session), 1);
            final retained = await PoiCatalogRow.db.findFirstRow(
              session,
              where: (table) => table.providerPlaceId.equals(existing.placeId),
            );
            expect(retained?.categoryIds, ['pizza']);
            expect(retained?.snapshot.categoryIds, ['pizza']);
            final broad = await PoiCatalogRow.db.findFirstRow(
              session,
              where: (table) =>
                  table.providerPlaceId.equals('broad-only-place'),
            );
            expect(broad?.categoryIds, isEmpty);
            expect(broad?.snapshot.categoryIds, isEmpty);
          } finally {
            await session.close();
          }
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

CatalogPlaceService _service(PlaceSource source) => CatalogPlaceService(
  source: source,
  calibrationVersion: _calibrationVersion,
);

Future<List<PlaceSnapshot>> _deck(
  CatalogPlaceService service,
  Session session, {
  required List<String> subcategoryIds,
  required int deckSize,
}) => service.buildDeck(
  session,
  categoryId: 'restaurant',
  subcategoryIds: subcategoryIds,
  latitude: _latitude,
  longitude: _longitude,
  radiusMeters: 3000,
  deckSize: deckSize,
  maximumPriceLevel: 2,
  countryCode: 'SA',
);

PlaceSnapshot _snapshot(
  String id, {
  required String categoryId,
  required DateTime checkedAt,
  int? reviewCount,
  int priceLevel = 2,
  double latitude = _latitude,
}) => PlaceSnapshot(
  placeId: id,
  name: 'Place $id',
  categoryIds: [categoryId],
  rating: 4.5,
  reviewCount: reviewCount ?? (id == 'shared' ? 100 : 50),
  priceLevel: priceLevel,
  hours: const [],
  distanceMeters: 0,
  latitude: latitude,
  longitude: _longitude,
  photoUrls: const [],
  attributions: const ['Fixture'],
  sourceCheckedAt: checkedAt,
  isStale: false,
);

PlaceCandidate _candidate(String id) => PlaceCandidate(
  placeId: id,
  name: 'Place $id',
  rating: 4.5,
  reviewCount: id == 'shared' ? 100 : 50,
  priceLevel: 2,
  latitude: _latitude,
  longitude: _longitude,
  sourceCheckedAt: DateTime.now().toUtc(),
);

final class _BarrierSource implements PlaceSource {
  final _bothStarted = Completer<void>();
  var _started = 0;

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
    _started++;
    if (_started == 2) _bothStarted.complete();
    await _bothStarted.future;
    return [_candidate('shared'), _candidate('$categoryId-only')];
  }
}

final class _CategorySource implements PlaceSource {
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
    calls++;
    return [_candidate('$categoryId-only')];
  }
}

final class _NeverSource implements PlaceSource {
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
  }) => throw StateError('The dense candidate request should remain cached.');
}

final class _PartialSource implements PlaceSource {
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
    if (categoryId == 'sushi') {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'Fixture source failure.',
      );
    }
    return [_candidate('$categoryId-only')];
  }
}

final class _FailingSource implements PlaceSource {
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
  }) => throw const PlaceSourceException(
    'place_source_unavailable',
    'Fixture source failure.',
  );
}

String _coverageKey({
  required List<String> categoryIds,
  required String countryCode,
  required double latitude,
  required double longitude,
  required int radiusMeters,
}) => sha256
    .convert(
      utf8.encode(
        '${countryCode}_${latitude.toStringAsFixed(3)}_'
        '${longitude.toStringAsFixed(3)}_${radiusMeters}_'
        '${categoryIds.join(',')}',
      ),
    )
    .toString();

Future<void> _resetTables(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  try {
    await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_operational_metric",
  "hayer_poi_category",
  "hayer_poi_coverage",
  "hayer_poi_catalog",
  "hayer_poi_detail_refresh",
  "hayer_discovery_type_observation",
  "hayer_discovery_harvest",
  "hayer_discovery_coverage",
  "hayer_cache_settings",
  "hayer_taxonomy_version"
CASCADE
''');
  } finally {
    await session.close();
  }
}
