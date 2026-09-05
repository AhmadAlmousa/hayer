import 'package:hayer_client/hayer_client.dart';

class SetupCategory {
  const SetupCategory(
    this.id,
    this.englishLabel,
    this.arabicLabel,
    this.emoji,
    this.subcategories,
  );

  final String id;
  final String englishLabel;
  final String arabicLabel;
  final String emoji;
  final Map<String, SetupSubcategory> subcategories;

  Map<String, SetupSubcategory> get cuisines => Map.fromEntries(
    subcategories.entries.where(
      (entry) => entry.value.kind == SetupOptionKind.cuisine,
    ),
  );

  Map<String, SetupSubcategory> get types => Map.fromEntries(
    subcategories.entries.where(
      (entry) => entry.value.kind == SetupOptionKind.poiType,
    ),
  );

  String label(String languageCode) =>
      languageCode == 'ar' ? arabicLabel : englishLabel;
}

class SetupSubcategory {
  const SetupSubcategory(
    this.emoji,
    this.englishLabel,
    this.arabicLabel, {
    this.kind = SetupOptionKind.poiType,
  });

  final String emoji;
  final String englishLabel;
  final String arabicLabel;
  final SetupOptionKind kind;

  String label(String languageCode) =>
      '$emoji ${languageCode == 'ar' ? arabicLabel : englishLabel}';
}

enum SetupOptionKind { cuisine, poiType }

List<SetupCategory> setupCategoriesFromSnapshot(TaxonomySnapshot snapshot) {
  final categories =
      snapshot.items
          .where((item) => item.enabled && item.kind == TaxonomyKind.category)
          .toList()
        ..sort((left, right) => left.sortOrder.compareTo(right.sortOrder));
  return categories
      .map((category) {
        final options =
            snapshot.items
                .where(
                  (item) =>
                      item.enabled &&
                      item.kind != TaxonomyKind.category &&
                      item.parentCategoryIds.contains(category.id),
                )
                .toList()
              ..sort(
                (left, right) => left.sortOrder.compareTo(right.sortOrder),
              );
        return SetupCategory(
          category.id,
          category.labelEn,
          category.labelAr,
          category.emoji,
          {
            for (final option in options)
              option.id: SetupSubcategory(
                option.emoji,
                option.labelEn,
                option.labelAr,
                kind: option.kind == TaxonomyKind.cuisine
                    ? SetupOptionKind.cuisine
                    : SetupOptionKind.poiType,
              ),
          },
        );
      })
      .toList(growable: false);
}

const setupCategories = [
  SetupCategory('restaurant', 'Restaurants', 'مطاعم', '🍽️', {
    'italian': SetupSubcategory(
      '🍝',
      'Italian',
      'إيطالي',
      kind: SetupOptionKind.cuisine,
    ),
    'hamburger': SetupSubcategory('🍔', 'Burgers', 'برغر'),
    'pizza': SetupSubcategory('🍕', 'Pizza', 'بيتزا'),
    'sushi': SetupSubcategory('🍣', 'Sushi', 'سوشي'),
    'japanese': SetupSubcategory(
      '🍱',
      'Japanese',
      'ياباني',
      kind: SetupOptionKind.cuisine,
    ),
    'chinese': SetupSubcategory(
      '🥡',
      'Chinese',
      'صيني',
      kind: SetupOptionKind.cuisine,
    ),
    'thai': SetupSubcategory(
      '🍜',
      'Thai',
      'تايلندي',
      kind: SetupOptionKind.cuisine,
    ),
    'indian': SetupSubcategory(
      '🍛',
      'Indian',
      'هندي',
      kind: SetupOptionKind.cuisine,
    ),
    'mexican': SetupSubcategory(
      '🌮',
      'Mexican',
      'مكسيكي',
      kind: SetupOptionKind.cuisine,
    ),
    'mediterranean': SetupSubcategory(
      '🫒',
      'Mediterranean',
      'متوسطي',
      kind: SetupOptionKind.cuisine,
    ),
    'middle_eastern': SetupSubcategory(
      '🥙',
      'Middle Eastern',
      'شرق أوسطي',
      kind: SetupOptionKind.cuisine,
    ),
    'lebanese': SetupSubcategory(
      '🧆',
      'Lebanese',
      'لبناني',
      kind: SetupOptionKind.cuisine,
    ),
    'turkish': SetupSubcategory(
      '🥘',
      'Turkish',
      'تركي',
      kind: SetupOptionKind.cuisine,
    ),
    'greek': SetupSubcategory(
      '🥗',
      'Greek',
      'يوناني',
      kind: SetupOptionKind.cuisine,
    ),
    'korean': SetupSubcategory(
      '🍲',
      'Korean',
      'كوري',
      kind: SetupOptionKind.cuisine,
    ),
    'american': SetupSubcategory(
      '🥪',
      'American',
      'أمريكي',
      kind: SetupOptionKind.cuisine,
    ),
    'steakhouse': SetupSubcategory('🥩', 'Steakhouse', 'ستيك'),
    'seafood': SetupSubcategory('🦐', 'Seafood', 'مأكولات بحرية'),
    'bbq': SetupSubcategory('🍖', 'BBQ', 'مشويات'),
    'vegan': SetupSubcategory('🌱', 'Vegan', 'نباتي'),
    'breakfast': SetupSubcategory('🍳', 'Breakfast', 'فطور'),
    'fast_food': SetupSubcategory('🍟', 'Fast Food', 'وجبات سريعة'),
    'fine_dining': SetupSubcategory('🍽️', 'Fine Dining', 'مطاعم فاخرة'),
    'ramen': SetupSubcategory('🍜', 'Ramen', 'رامن'),
  }),
  SetupCategory('cafe', 'Cafes', 'مقاهي', '☕', {
    'coffee_shop': SetupSubcategory('☕', 'Coffee Shop', 'قهوة'),
    'espresso_bar': SetupSubcategory('☕', 'Espresso Bar', 'إسبريسو'),
    'tea_house': SetupSubcategory('🫖', 'Tea House', 'شاي'),
    'bakery': SetupSubcategory('🥐', 'Bakery', 'مخبز'),
    'ice_cream': SetupSubcategory('🍦', 'Ice Cream', 'آيس كريم'),
    'dessert': SetupSubcategory('🍰', 'Dessert', 'حلويات'),
    'juice_bar': SetupSubcategory('🧃', 'Juice Bar', 'عصائر'),
    'bubble_tea': SetupSubcategory('🧋', 'Bubble Tea', 'شاي فقاعات'),
    'donut': SetupSubcategory('🍩', 'Donuts', 'دونات'),
  }),
  SetupCategory('things_to_do', 'Things to do', 'أماكن وتجارب', '🎯', {
    'park': SetupSubcategory('🌳', 'Park', 'حديقة'),
    'museum': SetupSubcategory('🏛️', 'Museum', 'متحف'),
    'art_gallery': SetupSubcategory('🖼️', 'Art Gallery', 'معرض فني'),
    'movie_theater': SetupSubcategory('🎬', 'Movie Theater', 'سينما'),
    'bowling': SetupSubcategory('🎳', 'Bowling', 'بولينغ'),
    'amusement_park': SetupSubcategory('🎢', 'Amusement Park', 'مدينة ملاهي'),
    'zoo': SetupSubcategory('🦁', 'Zoo', 'حديقة حيوان'),
    'aquarium': SetupSubcategory('🐠', 'Aquarium', 'أكواريوم'),
    'spa': SetupSubcategory('💆', 'Spa', 'سبا'),
    'gym': SetupSubcategory('🏋️', 'Gym', 'نادي رياضي'),
    'bar': SetupSubcategory('🍹', 'Bar', 'بار'),
    'night_club': SetupSubcategory('🎶', 'Nightclub', 'نادٍ ليلي'),
    'library': SetupSubcategory('📚', 'Library', 'مكتبة'),
    'shopping_mall': SetupSubcategory('🛍️', 'Shopping Mall', 'مركز تسوق'),
    'book_store': SetupSubcategory('📖', 'Book Store', 'متجر كتب'),
    'beach': SetupSubcategory('🏖️', 'Beach', 'شاطئ'),
    'hiking': SetupSubcategory('🥾', 'Hiking Trail', 'مسار مشي'),
    'landmark': SetupSubcategory('📍', 'Landmark', 'معلم'),
  }),
];
