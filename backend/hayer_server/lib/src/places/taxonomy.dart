class PlaceTaxonomy {
  const PlaceTaxonomy._();

  static const version = '2026-08-31.1';

  static const categories = <String, PlaceCategory>{
    'restaurant': PlaceCategory(
      id: 'restaurant',
      label: 'Restaurant',
      emoji: '🍽️',
      broadQuery: 'restaurants',
      arabicBroadQuery: 'مطاعم',
      subcategories: {
        'italian': PlaceSubcategory('Italian', 'Italian restaurants'),
        'hamburger': PlaceSubcategory('Burgers', 'burger restaurants'),
        'pizza': PlaceSubcategory('Pizza', 'pizza restaurants'),
        'sushi': PlaceSubcategory('Sushi', 'sushi restaurants'),
        'japanese': PlaceSubcategory('Japanese', 'Japanese restaurants'),
        'chinese': PlaceSubcategory('Chinese', 'Chinese restaurants'),
        'thai': PlaceSubcategory('Thai', 'Thai restaurants'),
        'indian': PlaceSubcategory('Indian', 'Indian restaurants'),
        'mexican': PlaceSubcategory('Mexican', 'Mexican restaurants'),
        'mediterranean': PlaceSubcategory(
          'Mediterranean',
          'Mediterranean restaurants',
        ),
        'middle_eastern': PlaceSubcategory(
          'Middle Eastern',
          'Middle Eastern restaurants',
        ),
        'lebanese': PlaceSubcategory('Lebanese', 'Lebanese restaurants'),
        'turkish': PlaceSubcategory('Turkish', 'Turkish restaurants'),
        'greek': PlaceSubcategory('Greek', 'Greek restaurants'),
        'korean': PlaceSubcategory('Korean', 'Korean restaurants'),
        'american': PlaceSubcategory('American', 'American restaurants'),
        'steakhouse': PlaceSubcategory('Steakhouse', 'steakhouses'),
        'seafood': PlaceSubcategory('Seafood', 'seafood restaurants'),
        'bbq': PlaceSubcategory('BBQ', 'barbecue restaurants'),
        'vegan': PlaceSubcategory('Vegan', 'vegan restaurants'),
        'breakfast': PlaceSubcategory('Breakfast', 'breakfast restaurants'),
        'fast_food': PlaceSubcategory('Fast Food', 'fast food restaurants'),
        'fine_dining': PlaceSubcategory(
          'Fine Dining',
          'fine dining restaurants',
        ),
        'ramen': PlaceSubcategory('Ramen', 'ramen restaurants'),
      },
    ),
    'cafe': PlaceCategory(
      id: 'cafe',
      label: 'Cafe',
      emoji: '☕',
      broadQuery: 'cafes',
      arabicBroadQuery: 'مقاهي',
      subcategories: {
        'coffee_shop': PlaceSubcategory('Coffee Shop', 'coffee shops'),
        'espresso_bar': PlaceSubcategory('Espresso Bar', 'espresso bars'),
        'tea_house': PlaceSubcategory('Tea House', 'tea houses'),
        'bakery': PlaceSubcategory('Bakery', 'bakeries'),
        'ice_cream': PlaceSubcategory('Ice Cream', 'ice cream shops'),
        'dessert': PlaceSubcategory('Dessert', 'dessert shops'),
        'juice_bar': PlaceSubcategory('Juice Bar', 'juice bars'),
        'bubble_tea': PlaceSubcategory('Bubble Tea', 'bubble tea'),
        'donut': PlaceSubcategory('Donuts', 'donut shops'),
      },
    ),
    'things_to_do': PlaceCategory(
      id: 'things_to_do',
      label: 'Things to Do',
      emoji: '🎯',
      broadQuery: 'tourist attractions and things to do',
      arabicBroadQuery: 'أماكن سياحية وأنشطة',
      subcategories: {
        'park': PlaceSubcategory('Park', 'parks'),
        'museum': PlaceSubcategory('Museum', 'museums'),
        'art_gallery': PlaceSubcategory('Art Gallery', 'art galleries'),
        'movie_theater': PlaceSubcategory('Movie Theater', 'movie theaters'),
        'bowling': PlaceSubcategory('Bowling', 'bowling alleys'),
        'amusement_park': PlaceSubcategory('Amusement Park', 'amusement parks'),
        'zoo': PlaceSubcategory('Zoo', 'zoos'),
        'aquarium': PlaceSubcategory('Aquarium', 'aquariums'),
        'spa': PlaceSubcategory('Spa', 'spas'),
        'gym': PlaceSubcategory('Gym', 'gyms'),
        'bar': PlaceSubcategory('Bar', 'bars'),
        'night_club': PlaceSubcategory('Nightclub', 'nightclubs'),
        'library': PlaceSubcategory('Library', 'libraries'),
        'shopping_mall': PlaceSubcategory('Shopping Mall', 'shopping malls'),
        'book_store': PlaceSubcategory('Book Store', 'book stores'),
        'beach': PlaceSubcategory('Beach', 'beaches'),
        'hiking': PlaceSubcategory('Hiking Trail', 'hiking trails'),
        'landmark': PlaceSubcategory('Landmark', 'historical landmarks'),
      },
    ),
  };

  static List<PlaceQuery> resolve(
    String categoryId,
    List<String> subcategoryIds,
  ) {
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
          final subcategory = category.subcategories[id];
          if (subcategory == null) {
            throw ArgumentError.value(
              id,
              'subcategoryIds',
              'Unknown for $categoryId.',
            );
          }
          return PlaceQuery(query: subcategory.query, categoryId: id);
        })
        .toList(growable: false);
  }
}

class PlaceCategory {
  const PlaceCategory({
    required this.id,
    required this.label,
    required this.emoji,
    required this.broadQuery,
    this.arabicBroadQuery,
    required this.subcategories,
  });

  final String id;
  final String label;
  final String emoji;
  final String broadQuery;
  final String? arabicBroadQuery;
  final Map<String, PlaceSubcategory> subcategories;
}

class PlaceSubcategory {
  const PlaceSubcategory(this.label, this.query);
  final String label;
  final String query;
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
