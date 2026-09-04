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

  String label(String languageCode) =>
      languageCode == 'ar' ? arabicLabel : englishLabel;
}

class SetupSubcategory {
  const SetupSubcategory(this.emoji, this.englishLabel, this.arabicLabel);

  final String emoji;
  final String englishLabel;
  final String arabicLabel;

  String label(String languageCode) =>
      '$emoji ${languageCode == 'ar' ? arabicLabel : englishLabel}';
}

const setupCategories = [
  SetupCategory('restaurant', 'Restaurants', 'مطاعم', '🍽️', {
    'italian': SetupSubcategory('🍝', 'Italian', 'إيطالي'),
    'hamburger': SetupSubcategory('🍔', 'Burgers', 'برغر'),
    'pizza': SetupSubcategory('🍕', 'Pizza', 'بيتزا'),
    'sushi': SetupSubcategory('🍣', 'Sushi', 'سوشي'),
    'japanese': SetupSubcategory('🍱', 'Japanese', 'ياباني'),
    'chinese': SetupSubcategory('🥡', 'Chinese', 'صيني'),
    'thai': SetupSubcategory('🍜', 'Thai', 'تايلندي'),
    'indian': SetupSubcategory('🍛', 'Indian', 'هندي'),
    'mexican': SetupSubcategory('🌮', 'Mexican', 'مكسيكي'),
    'mediterranean': SetupSubcategory('🫒', 'Mediterranean', 'متوسطي'),
    'middle_eastern': SetupSubcategory('🥙', 'Middle Eastern', 'شرق أوسطي'),
    'lebanese': SetupSubcategory('🧆', 'Lebanese', 'لبناني'),
    'turkish': SetupSubcategory('🥘', 'Turkish', 'تركي'),
    'greek': SetupSubcategory('🥗', 'Greek', 'يوناني'),
    'korean': SetupSubcategory('🍲', 'Korean', 'كوري'),
    'american': SetupSubcategory('🥪', 'American', 'أمريكي'),
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
