import 'package:hayer_server/src/places/catalog_place_service.dart';
import 'package:hayer_server/src/places/taxonomy.dart';
import 'package:test/test.dart';

void main() {
  const pizza = PlaceQuery(query: 'pizza restaurants', categoryId: 'pizza');

  String key({
    double latitude = 24.7136,
    int radiusMeters = 3000,
    int deckSize = 20,
    int? maximumPriceLevel,
    List<PlaceQuery> queries = const [pizza],
  }) => catalogRefreshKey(
    calibrationVersion: 'calibration-1',
    parentCategoryId: 'restaurant',
    queries: queries,
    countryCode: 'SA',
    latitude: latitude,
    longitude: 46.6753,
    radiusMeters: radiusMeters,
    deckSize: deckSize,
    maximumPriceLevel: maximumPriceLevel,
  );

  test('only exactly equivalent selection requests coalesce', () {
    expect(key(), key());
    expect(key(latitude: 24.7136001), isNot(key()));
    expect(key(radiusMeters: 2999), isNot(key()));
    expect(key(deckSize: 19), isNot(key()));
    expect(key(maximumPriceLevel: 2), isNot(key()));
    expect(
      key(
        queries: const [
          PlaceQuery(query: 'sushi restaurants', categoryId: 'sushi'),
          pizza,
        ],
      ),
      isNot(
        key(
          queries: const [
            pizza,
            PlaceQuery(query: 'sushi restaurants', categoryId: 'sushi'),
          ],
        ),
      ),
    );
  });
}
