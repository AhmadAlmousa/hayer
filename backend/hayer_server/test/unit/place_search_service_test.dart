import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_search_service.dart';
import 'package:hayer_server/src/places/place_source.dart';
import 'package:test/test.dart';

void main() {
  test('keeps results when one selected-category query fails', () async {
    final source = _FakePlaceSource(failures: {'sushi restaurants'});

    final deck = await _service(source).buildDeck(
      categoryId: 'restaurant',
      subcategoryIds: const ['pizza', 'sushi'],
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 5000,
      deckSize: 10,
      countryCode: 'SA',
    );

    expect(deck.map((place) => place.name), ['pizza restaurants']);
  });

  test('reports source failure when every query fails', () async {
    final source = _FakePlaceSource(
      failures: {'pizza restaurants', 'sushi restaurants'},
    );

    await expectLater(
      _service(source).buildDeck(
        categoryId: 'restaurant',
        subcategoryIds: const ['pizza', 'sushi'],
        latitude: 24.7136,
        longitude: 46.6753,
        radiusMeters: 5000,
        deckSize: 10,
        countryCode: 'SA',
      ),
      throwsA(
        isA<PlaceSourceException>().having(
          (error) => error.code,
          'code',
          'place_source_unavailable',
        ),
      ),
    );
  });

  test('keeps an English underfill when Arabic fallback fails', () async {
    final source = _FakePlaceSource(failures: {'مطاعم'});

    final deck = await _service(source).buildDeck(
      categoryId: 'restaurant',
      subcategoryIds: const [],
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 5000,
      deckSize: 10,
      countryCode: 'SA',
    );

    expect(deck.map((place) => place.name), ['restaurants']);
  });

  test('stops starting query batches once the deck is full', () async {
    final source = _FakePlaceSource();

    final deck = await _service(source).buildDeck(
      categoryId: 'restaurant',
      subcategoryIds: const ['pizza', 'sushi', 'italian', 'thai'],
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 5000,
      deckSize: 2,
      countryCode: 'SA',
    );

    expect(deck, hasLength(2));
    expect(source.queries, hasLength(3));
    expect(source.queries, isNot(contains('Thai restaurants')));
  });

  test('records the specific query category even for a bare source', () async {
    final deck = await _service(_BarePlaceSource()).buildDeck(
      categoryId: 'restaurant',
      subcategoryIds: const ['pizza'],
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 5000,
      deckSize: 1,
      countryCode: 'SA',
    );

    expect(deck.single.categoryIds, contains('pizza'));
    expect(deck.single.categoryIds, isNot(contains('sushi')));
  });
}

PlaceSearchService _service(PlaceSource source) =>
    PlaceSearchService(source: source, concurrency: 3);

class _FakePlaceSource implements PlaceSource {
  _FakePlaceSource({this.failures = const {}});

  final Set<String> failures;
  final List<String> queries = [];

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
    queries.add(query);
    if (failures.contains(query)) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'Temporary fixture failure.',
      );
    }
    return [
      PlaceCandidate(
        placeId: query,
        name: query,
        categoryIds: [categoryId],
        reviewCount: 10,
        latitude: latitude,
        longitude: longitude,
        sourceCheckedAt: DateTime.utc(2026, 9),
        evidenceCategoryIds: [categoryId],
      ),
    ];
  }
}

class _BarePlaceSource implements PlaceSource {
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
  }) async => [
    PlaceCandidate(
      placeId: 'bare',
      name: 'Bare source place',
      latitude: latitude,
      longitude: longitude,
      sourceCheckedAt: DateTime.utc(2026, 9),
    ),
  ];
}
