import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/setup/setup_data.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('published taxonomy maps bilingual cuisines and types for setup', () {
    final categories = setupCategoriesFromSnapshot(
      TaxonomySnapshot(
        version: 'test',
        items: [
          TaxonomyItem(
            id: 'food',
            kind: TaxonomyKind.category,
            parentCategoryIds: const [],
            labelEn: 'Food',
            labelAr: 'طعام',
            emoji: '🍽️',
            sortOrder: 0,
            enabled: true,
          ),
          TaxonomyItem(
            id: 'saudi',
            kind: TaxonomyKind.cuisine,
            parentCategoryIds: const ['food'],
            labelEn: 'Saudi',
            labelAr: 'سعودي',
            emoji: '🇸🇦',
            sortOrder: 0,
            enabled: true,
          ),
          TaxonomyItem(
            id: 'food_truck',
            kind: TaxonomyKind.poiType,
            parentCategoryIds: const ['food'],
            labelEn: 'Food truck',
            labelAr: 'عربة طعام',
            emoji: '🚚',
            sortOrder: 1,
            enabled: true,
          ),
        ],
      ),
    );

    expect(categories.single.label('ar'), 'طعام');
    expect(categories.single.cuisines.keys, ['saudi']);
    expect(categories.single.types.keys, ['food_truck']);
    expect(categories.single.cuisines['saudi']!.label('ar'), '🇸🇦 سعودي');
  });
}
