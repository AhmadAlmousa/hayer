import 'dart:convert';

import '../generated/protocol.dart';

/// The bundled taxonomy is the cold-start and legacy-client fallback.
abstract final class PlaceTaxonomy {
  static const version = '2026-09-05.1';

  static const categories = <String, PlaceCategory>{
    'restaurant': PlaceCategory(
      id: 'restaurant',
      labelEn: 'Restaurants',
      labelAr: 'مطاعم',
      emoji: '🍽️',
      broadQuery: 'restaurants',
      arabicBroadQuery: 'مطاعم',
      subcategories: {
        'italian': PlaceSubcategory.cuisine(
          '🍝',
          'Italian',
          'إيطالي',
          'Italian restaurants',
        ),
        'hamburger': PlaceSubcategory.type(
          '🍔',
          'Burgers',
          'برغر',
          'burger restaurants',
        ),
        'pizza': PlaceSubcategory.type(
          '🍕',
          'Pizza',
          'بيتزا',
          'pizza restaurants',
        ),
        'sushi': PlaceSubcategory.type(
          '🍣',
          'Sushi',
          'سوشي',
          'sushi restaurants',
        ),
        'japanese': PlaceSubcategory.cuisine(
          '🍱',
          'Japanese',
          'ياباني',
          'Japanese restaurants',
        ),
        'chinese': PlaceSubcategory.cuisine(
          '🥡',
          'Chinese',
          'صيني',
          'Chinese restaurants',
        ),
        'thai': PlaceSubcategory.cuisine(
          '🍜',
          'Thai',
          'تايلندي',
          'Thai restaurants',
        ),
        'indian': PlaceSubcategory.cuisine(
          '🍛',
          'Indian',
          'هندي',
          'Indian restaurants',
        ),
        'mexican': PlaceSubcategory.cuisine(
          '🌮',
          'Mexican',
          'مكسيكي',
          'Mexican restaurants',
        ),
        'mediterranean': PlaceSubcategory.cuisine(
          '🫒',
          'Mediterranean',
          'متوسطي',
          'Mediterranean restaurants',
        ),
        'middle_eastern': PlaceSubcategory.cuisine(
          '🥙',
          'Middle Eastern',
          'شرق أوسطي',
          'Middle Eastern restaurants',
        ),
        'lebanese': PlaceSubcategory.cuisine(
          '🧆',
          'Lebanese',
          'لبناني',
          'Lebanese restaurants',
        ),
        'turkish': PlaceSubcategory.cuisine(
          '🥘',
          'Turkish',
          'تركي',
          'Turkish restaurants',
        ),
        'greek': PlaceSubcategory.cuisine(
          '🥗',
          'Greek',
          'يوناني',
          'Greek restaurants',
        ),
        'korean': PlaceSubcategory.cuisine(
          '🍲',
          'Korean',
          'كوري',
          'Korean restaurants',
        ),
        'american': PlaceSubcategory.cuisine(
          '🥪',
          'American',
          'أمريكي',
          'American restaurants',
        ),
        'steakhouse': PlaceSubcategory.type(
          '🥩',
          'Steakhouse',
          'ستيك',
          'steakhouses',
        ),
        'seafood': PlaceSubcategory.type(
          '🦐',
          'Seafood',
          'مأكولات بحرية',
          'seafood restaurants',
        ),
        'bbq': PlaceSubcategory.type(
          '🍖',
          'BBQ',
          'مشويات',
          'barbecue restaurants',
        ),
        'vegan': PlaceSubcategory.type(
          '🌱',
          'Vegan',
          'نباتي',
          'vegan restaurants',
        ),
        'breakfast': PlaceSubcategory.type(
          '🍳',
          'Breakfast',
          'فطور',
          'breakfast restaurants',
        ),
        'fast_food': PlaceSubcategory.type(
          '🍟',
          'Fast Food',
          'وجبات سريعة',
          'fast food restaurants',
        ),
        'fine_dining': PlaceSubcategory.type(
          '🍽️',
          'Fine Dining',
          'مطاعم فاخرة',
          'fine dining restaurants',
        ),
        'ramen': PlaceSubcategory.type(
          '🍜',
          'Ramen',
          'رامن',
          'ramen restaurants',
        ),
      },
    ),
    'cafe': PlaceCategory(
      id: 'cafe',
      labelEn: 'Cafes',
      labelAr: 'مقاهي',
      emoji: '☕',
      broadQuery: 'cafes',
      arabicBroadQuery: 'مقاهي',
      subcategories: {
        'coffee_shop': PlaceSubcategory.type(
          '☕',
          'Coffee Shop',
          'قهوة',
          'coffee shops',
        ),
        'espresso_bar': PlaceSubcategory.type(
          '☕',
          'Espresso Bar',
          'إسبريسو',
          'espresso bars',
        ),
        'tea_house': PlaceSubcategory.type(
          '🫖',
          'Tea House',
          'شاي',
          'tea houses',
        ),
        'bakery': PlaceSubcategory.type('🥐', 'Bakery', 'مخبز', 'bakeries'),
        'ice_cream': PlaceSubcategory.type(
          '🍦',
          'Ice Cream',
          'آيس كريم',
          'ice cream shops',
        ),
        'dessert': PlaceSubcategory.type(
          '🍰',
          'Dessert',
          'حلويات',
          'dessert shops',
        ),
        'juice_bar': PlaceSubcategory.type(
          '🧃',
          'Juice Bar',
          'عصائر',
          'juice bars',
        ),
        'bubble_tea': PlaceSubcategory.type(
          '🧋',
          'Bubble Tea',
          'شاي فقاعات',
          'bubble tea',
        ),
        'donut': PlaceSubcategory.type('🍩', 'Donuts', 'دونات', 'donut shops'),
      },
    ),
    'things_to_do': PlaceCategory(
      id: 'things_to_do',
      labelEn: 'Things to Do',
      labelAr: 'أماكن وتجارب',
      emoji: '🎯',
      broadQuery: 'tourist attractions and things to do',
      arabicBroadQuery: 'أماكن سياحية وأنشطة',
      subcategories: {
        'park': PlaceSubcategory.type('🌳', 'Park', 'حديقة', 'parks'),
        'museum': PlaceSubcategory.type('🏛️', 'Museum', 'متحف', 'museums'),
        'art_gallery': PlaceSubcategory.type(
          '🖼️',
          'Art Gallery',
          'معرض فني',
          'art galleries',
        ),
        'movie_theater': PlaceSubcategory.type(
          '🎬',
          'Movie Theater',
          'سينما',
          'movie theaters',
        ),
        'bowling': PlaceSubcategory.type(
          '🎳',
          'Bowling',
          'بولينغ',
          'bowling alleys',
        ),
        'amusement_park': PlaceSubcategory.type(
          '🎢',
          'Amusement Park',
          'مدينة ملاهي',
          'amusement parks',
        ),
        'zoo': PlaceSubcategory.type('🦁', 'Zoo', 'حديقة حيوان', 'zoos'),
        'aquarium': PlaceSubcategory.type(
          '🐠',
          'Aquarium',
          'أكواريوم',
          'aquariums',
        ),
        'spa': PlaceSubcategory.type('💆', 'Spa', 'سبا', 'spas'),
        'gym': PlaceSubcategory.type('🏋️', 'Gym', 'نادي رياضي', 'gyms'),
        'bar': PlaceSubcategory.type('🍹', 'Bar', 'بار', 'bars'),
        'night_club': PlaceSubcategory.type(
          '🎶',
          'Nightclub',
          'نادٍ ليلي',
          'nightclubs',
        ),
        'library': PlaceSubcategory.type('📚', 'Library', 'مكتبة', 'libraries'),
        'shopping_mall': PlaceSubcategory.type(
          '🛍️',
          'Shopping Mall',
          'مركز تسوق',
          'shopping malls',
        ),
        'book_store': PlaceSubcategory.type(
          '📖',
          'Book Store',
          'متجر كتب',
          'book stores',
        ),
        'beach': PlaceSubcategory.type('🏖️', 'Beach', 'شاطئ', 'beaches'),
        'hiking': PlaceSubcategory.type(
          '🥾',
          'Hiking Trail',
          'مسار مشي',
          'hiking trails',
        ),
        'landmark': PlaceSubcategory.type(
          '📍',
          'Landmark',
          'معلم',
          'historical landmarks',
        ),
      },
    ),
  };

  static List<AdminTaxonomyItem> baselineItems() {
    final items = <AdminTaxonomyItem>[];
    var categoryOrder = 0;
    for (final category in categories.values) {
      items.add(
        AdminTaxonomyItem(
          id: category.id,
          kind: TaxonomyKind.category,
          parentCategoryIds: const [],
          labelEn: category.labelEn,
          labelAr: category.labelAr,
          emoji: category.emoji,
          searchQueryEn: category.broadQuery,
          searchQueryAr: category.arabicBroadQuery,
          sortOrder: categoryOrder++,
          enabled: true,
        ),
      );
      var optionOrder = 0;
      for (final option in category.subcategories.entries) {
        items.add(
          AdminTaxonomyItem(
            id: option.key,
            kind: option.value.kind,
            parentCategoryIds: [category.id],
            labelEn: option.value.labelEn,
            labelAr: option.value.labelAr,
            emoji: option.value.emoji,
            searchQueryEn: option.value.query,
            searchQueryAr: option.value.arabicQuery,
            sortOrder: optionOrder++,
            enabled: true,
          ),
        );
      }
    }
    return items;
  }

  static List<PlaceQuery> resolve(
    String categoryId,
    List<String> subcategoryIds, {
    List<AdminTaxonomyItem>? items,
  }) {
    if (items == null) {
      final category = categories[categoryId];
      if (category == null) throw ArgumentError.value(categoryId, 'categoryId');
      if (subcategoryIds.isEmpty) {
        return [
          PlaceQuery(
            query: category.broadQuery,
            arabicFallbackQuery: category.arabicBroadQuery,
            categoryId: categoryId,
          ),
        ];
      }
      return _legacyOptions(category, categoryId, subcategoryIds);
    }
    final byId = {for (final item in items) item.id: item};
    final category = byId[categoryId];
    if (category == null ||
        category.kind != TaxonomyKind.category ||
        !category.enabled) {
      throw ArgumentError.value(categoryId, 'categoryId');
    }
    if (subcategoryIds.isEmpty) {
      return [
        PlaceQuery(
          query: category.searchQueryEn,
          arabicFallbackQuery: category.searchQueryAr,
          categoryId: categoryId,
        ),
      ];
    }
    if (subcategoryIds.length > 5) {
      throw ArgumentError.value(
        subcategoryIds,
        'subcategoryIds',
        'At most five are supported.',
      );
    }
    final seen = <String>{};
    return subcategoryIds
        .map((id) {
          final item = byId[id];
          if (!seen.add(id)) {
            throw ArgumentError.value(id, 'subcategoryIds', 'Duplicate ID.');
          }
          if (item == null ||
              item.kind == TaxonomyKind.category ||
              !item.enabled ||
              !item.parentCategoryIds.contains(categoryId)) {
            throw ArgumentError.value(
              id,
              'subcategoryIds',
              'Unknown for $categoryId.',
            );
          }
          return PlaceQuery(
            query: item.searchQueryEn,
            arabicFallbackQuery: item.searchQueryAr,
            categoryId: id,
          );
        })
        .toList(growable: false);
  }

  static List<PlaceQuery> _legacyOptions(
    PlaceCategory category,
    String categoryId,
    List<String> subcategoryIds,
  ) {
    if (subcategoryIds.length > 5) {
      throw ArgumentError.value(
        subcategoryIds,
        'subcategoryIds',
        'At most five are supported.',
      );
    }
    final seen = <String>{};
    return subcategoryIds
        .map((id) {
          if (!seen.add(id)) {
            throw ArgumentError.value(id, 'subcategoryIds', 'Duplicate ID.');
          }
          final item = category.subcategories[id];
          if (item == null) {
            throw ArgumentError.value(
              id,
              'subcategoryIds',
              'Unknown for $categoryId.',
            );
          }
          return PlaceQuery(query: item.query, categoryId: id);
        })
        .toList(growable: false);
  }

  static List<String> validate(List<AdminTaxonomyItem> items) {
    final errors = <String>[];
    if (items.isEmpty || items.length > 250) {
      errors.add('Taxonomy must contain between 1 and 250 items.');
      return errors;
    }
    final ids = <String>{};
    for (final item in items) {
      if (!RegExp(r'^[a-z][a-z0-9_]{1,63}$').hasMatch(item.id)) {
        errors.add('${item.id}: ID must be a stable lowercase slug.');
      } else if (!ids.add(item.id)) {
        errors.add('${item.id}: ID is duplicated.');
      }
      if (item.labelEn.trim().isEmpty || item.labelEn.trim().length > 80) {
        errors.add(
          '${item.id}: English label is required and limited to 80 characters.',
        );
      }
      if (item.labelAr.trim().isEmpty || item.labelAr.trim().length > 80) {
        errors.add(
          '${item.id}: Arabic label is required and limited to 80 characters.',
        );
      }
      if (item.emoji.runes.isEmpty || item.emoji.runes.length > 8) {
        errors.add(
          '${item.id}: Emoji is required and limited to 8 code points.',
        );
      }
      if (item.searchQueryEn.trim().length < 2 ||
          item.searchQueryEn.trim().length > 120) {
        errors.add(
          '${item.id}: English search query must be 2–120 characters.',
        );
      }
      if (item.searchQueryAr != null &&
          item.searchQueryAr!.trim().length > 120) {
        errors.add(
          '${item.id}: Arabic search query is limited to 120 characters.',
        );
      }
      if (item.sortOrder < 0 || item.sortOrder > 10000) {
        errors.add('${item.id}: Sort order is outside the supported range.');
      }
    }
    final categoryIds = {
      for (final item in items.where(
        (value) => value.kind == TaxonomyKind.category,
      ))
        item.id,
    };
    if (categoryIds.isEmpty) errors.add('At least one category is required.');
    for (final item in items) {
      if (item.kind == TaxonomyKind.category &&
          item.parentCategoryIds.isNotEmpty) {
        errors.add('${item.id}: Categories cannot have parent categories.');
      }
      if (item.kind != TaxonomyKind.category &&
          item.parentCategoryIds.isEmpty) {
        errors.add(
          '${item.id}: Cuisine and type entries need a parent category.',
        );
      }
      for (final parent in item.parentCategoryIds) {
        if (!categoryIds.contains(parent)) {
          errors.add('${item.id}: Unknown parent category $parent.');
        }
      }
    }
    return errors;
  }

  static String encode(List<AdminTaxonomyItem> items) => jsonEncode(
    items.map((item) => item.toJsonForProtocol()).toList(growable: false),
  );

  static List<AdminTaxonomyItem> decode(String source) {
    final value = jsonDecode(source);
    if (value is! List) {
      throw const FormatException('Taxonomy document must be a list.');
    }
    return value
        .map(
          (item) =>
              AdminTaxonomyItem.fromJson((item as Map).cast<String, dynamic>()),
        )
        .toList(growable: false);
  }

  static TaxonomySnapshot publicSnapshot(
    String version,
    List<AdminTaxonomyItem> items,
  ) {
    final enabledCategories = {
      for (final item in items)
        if (item.enabled && item.kind == TaxonomyKind.category) item.id,
    };
    final visible =
        items
            .where(
              (item) =>
                  item.enabled &&
                  (item.kind == TaxonomyKind.category ||
                      item.parentCategoryIds.any(enabledCategories.contains)),
            )
            .map(
              (item) => TaxonomyItem(
                id: item.id,
                kind: item.kind,
                parentCategoryIds: List.of(item.parentCategoryIds),
                labelEn: item.labelEn,
                labelAr: item.labelAr,
                emoji: item.emoji,
                sortOrder: item.sortOrder,
                enabled: item.enabled,
              ),
            )
            .toList()
          ..sort((left, right) {
            final byKind = left.kind.index.compareTo(right.kind.index);
            if (byKind != 0) return byKind;
            final byOrder = left.sortOrder.compareTo(right.sortOrder);
            return byOrder != 0 ? byOrder : left.id.compareTo(right.id);
          });
    return TaxonomySnapshot(version: version, items: visible);
  }
}

class PlaceCategory {
  const PlaceCategory({
    required this.id,
    required this.labelEn,
    required this.labelAr,
    required this.emoji,
    required this.broadQuery,
    this.arabicBroadQuery,
    required this.subcategories,
  });

  final String id;
  final String labelEn;
  final String labelAr;
  final String emoji;
  final String broadQuery;
  final String? arabicBroadQuery;
  final Map<String, PlaceSubcategory> subcategories;
}

class PlaceSubcategory {
  const PlaceSubcategory.cuisine(
    this.emoji,
    this.labelEn,
    this.labelAr,
    this.query, {
    this.arabicQuery,
  }) : kind = TaxonomyKind.cuisine;

  const PlaceSubcategory.type(
    this.emoji,
    this.labelEn,
    this.labelAr,
    this.query, {
    this.arabicQuery,
  }) : kind = TaxonomyKind.poiType;

  final TaxonomyKind kind;
  final String emoji;
  final String labelEn;
  final String labelAr;
  final String query;
  final String? arabicQuery;
}

class PlaceQuery {
  const PlaceQuery({
    required this.query,
    required this.categoryId,
    this.arabicFallbackQuery,
  });

  final String query;
  final String categoryId;
  final String? arabicFallbackQuery;
}
