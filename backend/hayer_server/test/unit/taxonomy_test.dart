import 'package:hayer_server/src/places/taxonomy.dart';
import 'package:test/test.dart';

void main() {
  test('uses broad query when no subcategory is selected', () {
    final result = PlaceTaxonomy.resolve('restaurant', const []);
    expect(result.single.query, 'restaurants');
    expect(result.single.arabicFallbackQuery, isNotNull);
  });

  test('rejects unknown and excessive subcategory IDs', () {
    expect(
      () => PlaceTaxonomy.resolve('cafe', const ['unknown']),
      throwsArgumentError,
    );
    expect(
      () => PlaceTaxonomy.resolve(
        'restaurant',
        const ['pizza', 'sushi', 'thai', 'indian', 'mexican', 'vegan'],
      ),
      throwsArgumentError,
    );
  });
}
