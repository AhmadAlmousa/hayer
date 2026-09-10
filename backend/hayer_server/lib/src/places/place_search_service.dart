import '../generated/protocol.dart';
import 'place_candidate.dart';
import 'place_search_policy.dart';
import 'place_source.dart';
import 'taxonomy.dart';

class PlaceSearchService {
  const PlaceSearchService({
    required this.source,
    this.policy = const PlaceSearchPolicy(),
    this.concurrency = 3,
  });

  final PlaceSource source;
  final PlaceSearchPolicy policy;
  final int concurrency;

  Future<List<PlaceSnapshot>> buildDeck({
    required String categoryId,
    required List<String> subcategoryIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int deckSize,
    int? maximumPriceLevel,
    required String countryCode,
    List<PlaceQuery>? queries,
  }) async {
    final resolvedQueries =
        queries ?? PlaceTaxonomy.resolve(categoryId, subcategoryIds);
    final candidates = <PlaceCandidate>[];
    PlaceSourceException? sourceFailure;
    var selected = <PlaceSnapshot>[];
    for (var start = 0; start < resolvedQueries.length; start += concurrency) {
      final batch = resolvedQueries.skip(start).take(concurrency).toList();
      final results = await Future.wait(
        batch.map(
          (query) async {
            try {
              final places = await source.search(
                query: query.query,
                categoryId: query.categoryId,
                latitude: latitude,
                longitude: longitude,
                radiusMeters: radiusMeters,
                desiredCount: deckSize,
                language: 'en',
                countryCode: countryCode,
              );
              return _withEvidence(places, query.categoryId);
            } on PlaceSourceException catch (error) {
              sourceFailure ??= error;
              return const <PlaceCandidate>[];
            }
          },
        ),
      );
      for (final result in results) {
        candidates.addAll(result);
      }
      selected = policy.select(
        candidates: candidates,
        anchorLatitude: latitude,
        anchorLongitude: longitude,
        radiusMeters: radiusMeters,
        deckSize: deckSize,
        maximumPriceLevel: maximumPriceLevel,
      );
      if (selected.length >= deckSize) break;
    }
    final fallback = resolvedQueries.length == 1
        ? resolvedQueries.single.arabicFallbackQuery
        : null;
    if (selected.length < deckSize && fallback != null) {
      try {
        candidates.addAll(
          _withEvidence(
            await source.search(
              query: fallback,
              categoryId: resolvedQueries.single.categoryId,
              latitude: latitude,
              longitude: longitude,
              radiusMeters: radiusMeters,
              desiredCount: deckSize - selected.length,
              language: 'ar',
              countryCode: countryCode,
            ),
            resolvedQueries.single.categoryId,
          ),
        );
        selected = policy.select(
          candidates: candidates,
          anchorLatitude: latitude,
          anchorLongitude: longitude,
          radiusMeters: radiusMeters,
          deckSize: deckSize,
          maximumPriceLevel: maximumPriceLevel,
        );
      } on PlaceSourceException catch (error) {
        sourceFailure ??= error;
      }
    }
    final failure = sourceFailure;
    if (selected.isEmpty && failure != null) throw failure;
    return selected;
  }

  List<PlaceCandidate> _withEvidence(
    List<PlaceCandidate> places,
    String categoryId,
  ) => [
    for (final place in places)
      place.copyWith(
        categoryIds: {...place.categoryIds, categoryId}.toList(),
        evidenceCategoryIds: {
          ...place.evidenceCategoryIds,
          categoryId,
        }.toList(),
      ),
  ];

  Future<List<LocationSuggestion>> suggest({
    required String input,
    double? latitude,
    double? longitude,
    String countryCode = 'sa',
  }) async {
    final query = input.trim();
    if (query.length < 3) return const [];
    final places = await source.search(
      query: query,
      categoryId: 'location',
      latitude: latitude ?? 24.7136,
      longitude: longitude ?? 46.6753,
      radiusMeters: 50000,
      desiredCount: 8,
      language: 'en',
      countryCode: countryCode,
    );
    return places
        .take(8)
        .map((place) {
          final secondary = place.formattedAddress ?? place.address;
          return LocationSuggestion(
            placeId: place.placeId,
            mainText: place.name,
            secondaryText: secondary,
            fullText: secondary == null
                ? place.name
                : '${place.name}, $secondary',
            latitude: place.latitude,
            longitude: place.longitude,
            countryCode: countryCode.toUpperCase(),
          );
        })
        .toList(growable: false);
  }
}
