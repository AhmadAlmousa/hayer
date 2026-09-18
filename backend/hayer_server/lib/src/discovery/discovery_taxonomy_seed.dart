import '../generated/protocol.dart';

/// The Discover vocabulary shipped with the app.
///
/// Discover's tree is nested to whatever depth the vocabulary needs: a place
/// returned as a "Lebanese restaurant" belongs under
/// Food & Drinks → Restaurants → Middle Eastern → Lebanese, and appears in the
/// category sheet at each of those levels. The nine roots are the owner's
/// locked domains; everything under them is content, published through the
/// ordinary draft → validate → publish lifecycle rather than a migration, so
/// an operator can edit it afterwards without a deploy.
///
/// Aliases are the provider's own category strings, normalized by
/// [DiscoveryTaxonomyService.normalizeAlias]. They are deliberately partial:
/// a source returns thousands of spellings and no seed can list them all.
/// `DiscoveryTypeAutoMapper` reads what the harvest actually observed and
/// attaches the rest to these nodes, which is why each node carries the plain
/// head noun a spelling is likely to end with.
///
/// Every alias must be unique across the whole tree, or
/// `DiscoveryTaxonomyService.validate` rejects the document. The seed is
/// checked against that rule by `discovery_taxonomy_seed_test.dart`.
abstract final class DiscoveryTaxonomySeed {
  static List<DiscoveryTaxonomyNode> roots() => [
    _node(
      'food',
      'Food & Drinks',
      'الأطعمة والمشروبات',
      '🍹',
      children: [
        _node(
          'food_restaurants',
          'Restaurants',
          'المطاعم',
          '🍽️',
          aliases: [
            'restaurant',
            'مطعم',
            'diner',
            'eatery',
            'buffet restaurant',
            'family restaurant',
            'fine dining restaurant',
            'food court',
          ],
          children: [
            _node(
              'food_middle_eastern',
              'Middle Eastern',
              'مأكولات شرق أوسطية',
              '🥙',
              aliases: [
                'middle eastern restaurant',
                'arab restaurant',
                'levantine restaurant',
                'mediterranean restaurant',
                'مطعم شرق أوسطي',
              ],
              children: [
                _leaf('food_lebanese', 'Lebanese', 'لبناني', '🇱🇧', [
                  'lebanese restaurant',
                  'مطعم لبناني',
                ]),
                _leaf('food_syrian', 'Syrian', 'سوري', '🥘', [
                  'syrian restaurant',
                  'مطعم سوري',
                ]),
                _leaf('food_egyptian', 'Egyptian', 'مصري', '🫓', [
                  'egyptian restaurant',
                  'koshary restaurant',
                  'مطعم مصري',
                ]),
                _leaf('food_yemeni', 'Yemeni', 'يمني', '🍲', [
                  'yemeni restaurant',
                  'مطعم يمني',
                ]),
                _leaf('food_saudi', 'Saudi', 'سعودي', '🫖', [
                  'saudi restaurant',
                  'najdi restaurant',
                  'مطعم سعودي',
                ]),
                _leaf('food_turkish', 'Turkish', 'تركي', '🥙', [
                  'turkish restaurant',
                  'مطعم تركي',
                ]),
                _leaf('food_persian', 'Persian', 'إيراني', '🍛', [
                  'persian restaurant',
                  'iranian restaurant',
                  'مطعم إيراني',
                ]),
                _leaf('food_iraqi', 'Iraqi', 'عراقي', '🍢', [
                  'iraqi restaurant',
                  'مطعم عراقي',
                ]),
                _leaf('food_palestinian', 'Palestinian', 'فلسطيني', '🫒', [
                  'palestinian restaurant',
                  'jordanian restaurant',
                ]),
                _leaf('food_moroccan', 'Moroccan', 'مغربي', '🍯', [
                  'moroccan restaurant',
                  'tagine restaurant',
                ]),
                _leaf('food_grills', 'Grills & Kebab', 'مشاوي', '🍖', [
                  'kebab shop',
                  'grill restaurant',
                  'barbecue restaurant',
                  'mandi restaurant',
                  'kabsa restaurant',
                  'مشاوي',
                ]),
                _leaf('food_shawarma', 'Shawarma & Falafel', 'شاورما', '🌯', [
                  'shawarma restaurant',
                  'falafel restaurant',
                  'شاورما',
                ]),
              ],
            ),
            _node(
              'food_asian',
              'Asian',
              'مأكولات آسيوية',
              '🍜',
              aliases: ['asian restaurant', 'asian fusion restaurant'],
              children: [
                _leaf('food_chinese', 'Chinese', 'صيني', '🥡', [
                  'chinese restaurant',
                  'dim sum restaurant',
                  'مطعم صيني',
                ]),
                _leaf('food_japanese', 'Japanese', 'ياباني', '🍣', [
                  'japanese restaurant',
                  'sushi restaurant',
                  'ramen restaurant',
                  'مطعم ياباني',
                ]),
                _leaf('food_korean', 'Korean', 'كوري', '🍚', [
                  'korean restaurant',
                ]),
                _leaf('food_thai', 'Thai', 'تايلندي', '🍤', [
                  'thai restaurant',
                ]),
                _leaf('food_vietnamese', 'Vietnamese', 'فيتنامي', '🍜', [
                  'vietnamese restaurant',
                ]),
                _leaf('food_indian', 'Indian', 'هندي', '🍛', [
                  'indian restaurant',
                  'pakistani restaurant',
                  'biryani restaurant',
                  'مطعم هندي',
                ]),
                _leaf('food_filipino', 'Filipino', 'فلبيني', '🍢', [
                  'filipino restaurant',
                  'indonesian restaurant',
                  'malaysian restaurant',
                ]),
              ],
            ),
            _node(
              'food_western',
              'European & American',
              'مأكولات غربية',
              '🍝',
              aliases: ['european restaurant', 'western restaurant'],
              children: [
                _leaf('food_italian', 'Italian', 'إيطالي', '🍝', [
                  'italian restaurant',
                  'trattoria',
                  'مطعم إيطالي',
                ]),
                _leaf('food_pizza', 'Pizza', 'بيتزا', '🍕', [
                  'pizza restaurant',
                  'pizzeria',
                  'بيتزا',
                ]),
                _leaf('food_french', 'French', 'فرنسي', '🥐', [
                  'french restaurant',
                  'bistro',
                ]),
                _leaf(
                  'food_spanish',
                  'Spanish & Greek',
                  'إسباني ويوناني',
                  '🥘',
                  [
                    'spanish restaurant',
                    'greek restaurant',
                    'tapas restaurant',
                  ],
                ),
                _leaf('food_american', 'American', 'أمريكي', '🍔', [
                  'american restaurant',
                  'steak house',
                  'bbq restaurant',
                ]),
                _leaf('food_mexican', 'Mexican & Latin', 'مكسيكي', '🌮', [
                  'mexican restaurant',
                  'taco restaurant',
                  'brazilian restaurant',
                ]),
              ],
            ),
            _leaf('food_seafood', 'Seafood', 'مأكولات بحرية', '🦐', [
              'seafood restaurant',
              'fish restaurant',
              'مطعم أسماك',
            ]),
            _leaf('food_fast', 'Fast food', 'وجبات سريعة', '🍟', [
              'fast food restaurant',
              'burger restaurant',
              'fried chicken restaurant',
              'sandwich shop',
              'hot dog restaurant',
              'وجبات سريعة',
            ]),
            _leaf('food_breakfast', 'Breakfast & Brunch', 'فطور', '🍳', [
              'breakfast restaurant',
              'brunch restaurant',
              'فطور',
            ]),
            _leaf('food_vegetarian', 'Vegetarian & Vegan', 'نباتي', '🥗', [
              'vegetarian restaurant',
              'vegan restaurant',
              'salad shop',
              'health food restaurant',
            ]),
          ],
        ),
        _node(
          'food_cafes',
          'Cafés & Coffee',
          'المقاهي',
          '☕',
          aliases: [
            'cafe',
            'coffee shop',
            'مقهى',
            'espresso bar',
            'coffee roasters',
            'tea house',
            'bubble tea shop',
            'juice shop',
          ],
          children: [
            _leaf(
              'food_specialty_coffee',
              'Specialty coffee',
              'قهوة مختصة',
              '🫘',
              [
                'specialty coffee shop',
                'قهوة مختصة',
              ],
            ),
            _leaf('food_shisha', 'Shisha lounges', 'مقاهي الشيشة', '💨', [
              'hookah lounge',
              'shisha cafe',
              'شيشة',
            ]),
          ],
        ),
        _node(
          'food_bakery',
          'Bakeries & Desserts',
          'المخابز والحلويات',
          '🧁',
          aliases: [
            'bakery',
            'مخبز',
            'patisserie',
            'dessert shop',
            'cake shop',
            'حلويات',
          ],
          children: [
            _leaf('food_ice_cream', 'Ice cream', 'آيس كريم', '🍦', [
              'ice cream shop',
              'frozen yogurt shop',
              'gelato shop',
            ]),
            _leaf('food_chocolate', 'Chocolate & sweets', 'شوكولاتة', '🍫', [
              'chocolate shop',
              'candy store',
              'donut shop',
            ]),
          ],
        ),
        _node(
          'food_grocery',
          'Groceries & Markets',
          'البقالة والأسواق',
          '🛒',
          aliases: [
            'grocery store',
            'supermarket',
            'hypermarket',
            'بقالة',
            'سوبرماركت',
            'convenience store',
            'farmers market',
          ],
          children: [
            _leaf('food_butcher', 'Butchers & fishmongers', 'ملاحم', '🥩', [
              'butcher shop',
              'fish market',
              'ملحمة',
            ]),
            _leaf('food_spices', 'Spices & nuts', 'العطارة والمكسرات', '🌶️', [
              'spice shop',
              'nut store',
              'dried fruit store',
              'عطارة',
            ]),
          ],
        ),
      ],
    ),
    _node(
      'todo',
      'Things to Do',
      'أنشطة ومعالم',
      '🏰',
      children: [
        _leaf('todo_landmarks', 'Landmarks & viewpoints', 'المعالم', '🗼', [
          'tourist attraction',
          'landmark',
          'معلم سياحي',
          'monument',
          'observation deck',
          'scenic point',
          'viewpoint',
        ]),
        _leaf('todo_heritage', 'Heritage sites', 'المواقع التراثية', '🏛️', [
          'historical landmark',
          'historical place',
          'heritage site',
          'castle',
          'fort',
          'palace',
          'archaeological site',
          'قلعة',
          'موقع تراثي',
        ]),
        _node(
          'todo_museums',
          'Museums & galleries',
          'المتاحف والمعارض',
          '🖼️',
          aliases: ['museum', 'متحف'],
          children: [
            _leaf('todo_art_museum', 'Art', 'الفنون', '🎨', [
              'art museum',
              'art gallery',
              'معرض فني',
            ]),
            _leaf('todo_science_museum', 'Science & nature', 'العلوم', '🔬', [
              'science museum',
              'history museum',
              'planetarium',
              'aquarium',
              'zoo',
              'حديقة حيوان',
            ]),
          ],
        ),
        _node(
          'todo_parks',
          'Parks & nature',
          'الحدائق والطبيعة',
          '🌳',
          aliases: ['park', 'حديقة', 'national park', 'garden', 'playground'],
          children: [
            _leaf('todo_beaches', 'Beaches & waterfronts', 'الشواطئ', '🏖️', [
              'beach',
              'corniche',
              'waterfront',
              'شاطئ',
              'كورنيش',
            ]),
            _leaf(
              'todo_desert',
              'Desert & mountains',
              'الصحراء والجبال',
              '🏜️',
              [
                'desert',
                'dunes',
                'mountain',
                'valley',
                'waterfall',
                'oasis',
                'صحراء',
              ],
            ),
            _leaf(
              'todo_botanical',
              'Botanical gardens',
              'الحدائق النباتية',
              '🌺',
              [
                'botanical garden',
                'public garden',
              ],
            ),
          ],
        ),
        _leaf('todo_family', 'Family fun', 'ترفيه عائلي', '🎡', [
          'amusement park',
          'theme park',
          'water park',
          'family entertainment center',
          'arcade',
          'trampoline park',
          'ملاهي',
        ]),
        _leaf('todo_culture', 'Cultural centres', 'المراكز الثقافية', '🎭', [
          'cultural center',
          'exhibition center',
          'library',
          'مركز ثقافي',
        ]),
      ],
    ),
    _node(
      'stay',
      'Accommodation',
      'أماكن الإقامة',
      '🏨',
      children: [
        _leaf('stay_hotels', 'Hotels', 'الفنادق', '🏨', [
          'hotel',
          'فندق',
          'resort hotel',
          'resort',
          'motel',
          'boutique hotel',
        ]),
        _leaf(
          'stay_apartments',
          'Apartments & suites',
          'الشقق المفروشة',
          '🛏️',
          [
            'apartment hotel',
            'serviced apartment',
            'furnished apartment',
            'شقق مفروشة',
          ],
        ),
        _leaf('stay_budget', 'Hostels & guest houses', 'النزل', '🎒', [
          'hostel',
          'guest house',
          'bed and breakfast',
        ]),
        _leaf('stay_retreats', 'Chalets & camps', 'الاستراحات والمخيمات', '⛺', [
          'chalet',
          'rest house',
          'campground',
          'camp',
          'استراحة',
          'مخيم',
        ]),
      ],
    ),
    _node(
      'ent',
      'Entertainment',
      'الترفيه',
      '🍿',
      children: [
        _leaf('ent_cinema', 'Cinemas', 'السينما', '🎬', [
          'movie theater',
          'cinema',
          'سينما',
        ]),
        _leaf('ent_live', 'Live venues', 'العروض الحية', '🎤', [
          'concert hall',
          'theater',
          'opera house',
          'live music venue',
          'event venue',
          'مسرح',
        ]),
        _leaf('ent_gaming', 'Gaming & indoor play', 'الألعاب', '🎮', [
          'video game arcade',
          'esports arena',
          'escape room',
          'billiards hall',
          'bowling alley',
          'ألعاب',
        ]),
        _leaf('ent_nightlife', 'Lounges & nightlife', 'السهرات', '🌙', [
          'night club',
          'lounge',
          'bar',
          'karaoke bar',
        ]),
      ],
    ),
    _node(
      'wellness',
      'Wellness',
      'العافية',
      '😌',
      children: [
        _leaf('wellness_spa', 'Spas & hammams', 'المنتجعات الصحية', '💆', [
          'spa',
          'massage',
          'hammam',
          'sauna',
          'wellness center',
          'منتجع صحي',
        ]),
        _leaf('wellness_salon', 'Salons & barbers', 'الصالونات', '💇', [
          'beauty salon',
          'hair salon',
          'barber shop',
          'nail salon',
          'صالون',
          'حلاق',
        ]),
        _leaf('wellness_clinics', 'Clinics & pharmacies', 'العيادات', '🩺', [
          'clinic',
          'medical center',
          'hospital',
          'dentist',
          'pharmacy',
          'optician',
          'physiotherapist',
          'veterinary care',
          'صيدلية',
          'عيادة',
        ]),
      ],
    ),
    _node(
      'tours',
      'Tours & Travel',
      'الجولات والسفر',
      '🚌',
      children: [
        _leaf('tours_operators', 'Tours & guides', 'الجولات', '🧭', [
          'tour operator',
          'tour agency',
          'sightseeing tour agency',
          'desert safari',
          'boat tour agency',
          'رحلات سياحية',
        ]),
        _leaf('tours_agencies', 'Travel agencies', 'وكالات السفر', '✈️', [
          'travel agency',
          'وكالة سفر',
        ]),
        _leaf('tours_transport', 'Getting around', 'التنقل', '🚉', [
          'car rental agency',
          'airport',
          'train station',
          'bus station',
          'taxi service',
          'مطار',
          'محطة قطار',
        ]),
      ],
    ),
    _node(
      'shopping',
      'Shopping',
      'التسوق',
      '🛍️',
      children: [
        _leaf('shopping_malls', 'Malls & department stores', 'المولات', '🏬', [
          'shopping mall',
          'department store',
          'outlet mall',
          'مركز تسوق',
          'مول',
        ]),
        _leaf('shopping_fashion', 'Fashion & beauty', 'الأزياء', '👗', [
          'clothing store',
          'shoe store',
          'jewelry store',
          'watch store',
          'perfume store',
          'cosmetics store',
          'bag shop',
          'tailor',
          'عطور',
          'ملابس',
        ]),
        _leaf('shopping_electronics', 'Electronics', 'الإلكترونيات', '📱', [
          'electronics store',
          'mobile phone store',
          'computer store',
          'camera store',
          'إلكترونيات',
        ]),
        _leaf('shopping_home', 'Home & garden', 'المنزل', '🛋️', [
          'furniture store',
          'home goods store',
          'hardware store',
          'kitchen supply store',
          'carpet store',
          'antique store',
          'florist',
          'أثاث',
        ]),
        _leaf('shopping_books', 'Books & gifts', 'الكتب والهدايا', '📚', [
          'book store',
          'stationery store',
          'gift shop',
          'toy store',
          'souvenir shop',
          'art supply store',
          'مكتبة',
        ]),
        _leaf('shopping_souq', 'Souqs & markets', 'الأسواق الشعبية', '🏺', [
          'souq',
          'bazaar',
          'flea market',
          'سوق شعبي',
        ]),
      ],
    ),
    _node(
      'sports',
      'Activities & Sports',
      'الأنشطة والرياضة',
      '⚽',
      children: [
        _leaf('sports_gyms', 'Gyms & studios', 'النوادي الرياضية', '🏋️', [
          'gym',
          'fitness center',
          'yoga studio',
          'pilates studio',
          'martial arts school',
          'boxing gym',
          'crossfit box',
          'نادي رياضي',
        ]),
        _leaf('sports_courts', 'Courts & fields', 'الملاعب', '🏟️', [
          'stadium',
          'soccer field',
          'padel court',
          'tennis court',
          'basketball court',
          'sports complex',
          'ice rink',
          'swimming pool',
          'ملعب',
        ]),
        _leaf('sports_outdoor', 'Outdoor & adventure', 'المغامرات', '🥾', [
          'hiking area',
          'climbing gym',
          'go-kart track',
          'horse riding school',
          'shooting range',
          'golf course',
          'dive shop',
          'water sports center',
          'cycling park',
        ]),
      ],
    ),
    _node(
      'religion',
      'Religion & Worship',
      'الدين والعبادة',
      '⛩️',
      children: [
        _leaf('religion_mosques', 'Mosques', 'المساجد', '🕌', [
          'mosque',
          'grand mosque',
          'مسجد',
          'جامع',
        ]),
        _leaf(
          'religion_other',
          'Other places of worship',
          'دور عبادة أخرى',
          '🛐',
          [
            'church',
            'temple',
            'shrine',
            'islamic center',
          ],
        ),
      ],
    ),
  ];

  static DiscoveryTaxonomyNode _node(
    String id,
    String labelEn,
    String labelAr,
    String emoji, {
    List<String> aliases = const [],
    List<DiscoveryTaxonomyNode> children = const [],
  }) => DiscoveryTaxonomyNode(
    id: id,
    labelEn: labelEn,
    labelAr: labelAr,
    emoji: emoji,
    typeAliases: [...aliases],
    children: [...children],
  );

  static DiscoveryTaxonomyNode _leaf(
    String id,
    String labelEn,
    String labelAr,
    String emoji,
    List<String> aliases,
  ) => _node(id, labelEn, labelAr, emoji, aliases: aliases);
}
