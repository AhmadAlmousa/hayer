class SetupCategory {
  const SetupCategory(this.id, this.label, this.emoji, this.subcategories);
  final String id;
  final String label;
  final String emoji;
  final Map<String, String> subcategories;
}

const setupCategories = [
  SetupCategory('restaurant', 'Restaurants', '🍽️', {
    'italian': 'Italian',
    'hamburger': 'Burgers',
    'pizza': 'Pizza',
    'sushi': 'Sushi',
    'japanese': 'Japanese',
    'chinese': 'Chinese',
    'thai': 'Thai',
    'indian': 'Indian',
    'mexican': 'Mexican',
    'mediterranean': 'Mediterranean',
    'middle_eastern': 'Middle Eastern',
    'lebanese': 'Lebanese',
    'turkish': 'Turkish',
    'greek': 'Greek',
    'korean': 'Korean',
    'american': 'American',
    'steakhouse': 'Steakhouse',
    'seafood': 'Seafood',
    'bbq': 'BBQ',
    'vegan': 'Vegan',
    'breakfast': 'Breakfast',
    'fast_food': 'Fast Food',
    'fine_dining': 'Fine Dining',
    'ramen': 'Ramen',
  }),
  SetupCategory('cafe', 'Cafes', '☕', {
    'coffee_shop': 'Coffee Shop',
    'espresso_bar': 'Espresso Bar',
    'tea_house': 'Tea House',
    'bakery': 'Bakery',
    'ice_cream': 'Ice Cream',
    'dessert': 'Dessert',
    'juice_bar': 'Juice Bar',
    'bubble_tea': 'Bubble Tea',
    'donut': 'Donuts',
  }),
  SetupCategory('things_to_do', 'Things to do', '🎯', {
    'park': 'Park',
    'museum': 'Museum',
    'art_gallery': 'Art Gallery',
    'movie_theater': 'Movie Theater',
    'bowling': 'Bowling',
    'amusement_park': 'Amusement Park',
    'zoo': 'Zoo',
    'aquarium': 'Aquarium',
    'spa': 'Spa',
    'gym': 'Gym',
    'bar': 'Bar',
    'night_club': 'Nightclub',
    'library': 'Library',
    'shopping_mall': 'Shopping Mall',
    'book_store': 'Book Store',
    'beach': 'Beach',
    'hiking': 'Hiking Trail',
    'landmark': 'Landmark',
  }),
];
