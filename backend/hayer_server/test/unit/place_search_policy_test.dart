import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/place_search_policy.dart';
import 'package:test/test.dart';

void main() {
  const policy = PlaceSearchPolicy();
  final checkedAt = DateTime.utc(2026, 8, 31);

  PlaceCandidate place(
    String id, {
    double latitude = 24.7136,
    double longitude = 46.6753,
    int reviews = 10,
    double rating = 4,
    int? price,
    String? status,
    String category = 'pizza',
  }) => PlaceCandidate(
    placeId: id,
    name: 'Place $id',
    latitude: latitude,
    longitude: longitude,
    reviewCount: reviews,
    rating: rating,
    priceLevel: price,
    statusText: status,
    sourceCheckedAt: checkedAt,
    evidenceCategoryId: category,
  );

  test('applies radius, closure, price and stable ranking', () {
    final selected = policy.select(
      candidates: [
        place('low', reviews: 5),
        place('top', reviews: 100),
        place('too-pricey', reviews: 500, price: 4),
        place('unknown-price', reviews: 50),
        place('closed', reviews: 999, status: 'Permanently closed'),
        place('far', latitude: 25.5, reviews: 1000),
      ],
      anchorLatitude: 24.7136,
      anchorLongitude: 46.6753,
      radiusMeters: 3000,
      deckSize: 10,
      maximumPriceLevel: 2,
    );

    expect(selected.map((item) => item.placeId), [
      'top',
      'unknown-price',
      'low',
    ]);
  });

  test('round robins category groups for deck diversity', () {
    final selected = policy.select(
      candidates: [
        place('p1', reviews: 100, category: 'pizza'),
        place('p2', reviews: 90, category: 'pizza'),
        place('s1', reviews: 5, category: 'sushi'),
        place('s2', reviews: 4, category: 'sushi'),
      ],
      anchorLatitude: 24.7136,
      anchorLongitude: 46.6753,
      radiusMeters: 3000,
      deckSize: 4,
    );

    expect(selected.map((item) => item.placeId), ['p1', 's1', 'p2', 's2']);
  });

  test('hides dynamic fields when serving a stale snapshot', () {
    final selected = policy.select(
      candidates: [place('stale', status: 'Open now')],
      anchorLatitude: 24.7136,
      anchorLongitude: 46.6753,
      radiusMeters: 3000,
      deckSize: 1,
      stale: true,
    );

    expect(selected.single.isStale, isTrue);
    expect(selected.single.statusText, isNull);
    expect(selected.single.isOpen, isNull);
    expect(selected.single.rating, isNull);
    expect(selected.single.reviewCount, isNull);
    expect(selected.single.priceLevel, isNull);
  });
}
