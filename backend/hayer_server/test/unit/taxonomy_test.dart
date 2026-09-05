import 'package:hayer_server/src/places/taxonomy.dart';
import 'package:hayer_server/src/generated/protocol.dart';
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

  test(
    'bundled taxonomy has valid bilingual categories, cuisines, and types',
    () {
      final items = PlaceTaxonomy.baselineItems();

      expect(PlaceTaxonomy.validate(items), isEmpty);
      expect(items.any((item) => item.kind == TaxonomyKind.category), isTrue);
      expect(items.any((item) => item.kind == TaxonomyKind.cuisine), isTrue);
      expect(items.any((item) => item.kind == TaxonomyKind.poiType), isTrue);
      expect(items.every((item) => item.labelAr.isNotEmpty), isTrue);
    },
  );

  test('dynamic taxonomy retains selected-query OR semantics', () {
    final result = PlaceTaxonomy.resolve(
      'restaurant',
      const ['italian', 'pizza'],
      items: PlaceTaxonomy.baselineItems(),
    );

    expect(result.map((query) => query.query), [
      'Italian restaurants',
      'pizza restaurants',
    ]);
  });
}
