import 'package:material_ui/material_ui.dart';

final class IntentCopy {
  IntentCopy(BuildContext context)
    : ar = Localizations.localeOf(context).languageCode == 'ar';

  final bool ar;

  String get what => ar ? 'ماذا؟' : 'WHAT?';
  String get whatPrompt => ar
      ? 'ماذا تريد أن تفعل أو أين تريد أن تذهب؟'
      : 'What are you in the mood for?';
  String get categorySearch => ar ? 'ابحث في الفئات' : 'Search categories';
  String get continueLabel => ar ? 'متابعة' : 'Continue';
  String get where => ar ? 'أين؟' : 'WHERE?';
  String get wherePrompt => ar ? 'أين نبحث؟' : 'Where should we look?';
  String get currentLocation => ar ? 'موقعي الحالي' : 'Current location';
  String get chooseArea => ar ? 'اختيار منطقة أخرى' : 'Choose another area';
  String get confirmArea => ar ? 'استخدام هذه المنطقة' : 'Use this area';
  String get whatNext => ar ? 'ماذا بعد؟' : 'WHAT NEXT?';
  String get whatNextPrompt => ar
      ? 'كيف تريد استخدام هذا البحث؟'
      : 'How do you want to use this search?';
  String get quickPick => ar ? 'اختيار سريع' : 'Quick Pick';
  String get quickPickDescription =>
      ar ? 'ابدأ بعشرة أماكن الآن.' : 'Start with 10 places now.';
  String get explore => ar ? 'استكشاف' : 'Explore';
  String get exploreDescription => ar
      ? 'افتح الخريطة والنتائج ضمن بحثك.'
      : 'Browse the map and results in your search.';
  String get decideTogether => ar ? 'قرروا معًا' : 'Decide Together';
  String get decideTogetherDescription => ar
      ? 'أنشئ غرفة وشاركها مع أصدقائك.'
      : 'Create a room and invite friends.';
  String get tenMore => ar ? '١٠ أماكن أخرى' : '10 more';
  String get refine => ar ? 'تخصيص اختياري' : 'Refine (optional)';
  String get defaults =>
      ar ? 'الإعدادات الافتراضية مناسبة' : 'Sensible defaults are ready';
  String get roomRules => ar ? 'قواعد الغرفة' : 'Room rules';
  String get displayName => ar ? 'اسمك' : 'Your name';
  String get createRoom => ar ? 'إنشاء الغرفة' : 'Create room';
  String get replaceSelection =>
      ar ? 'تغيير نوع البحث؟' : 'Change search group?';
  String get replaceSelectionBody => ar
      ? 'اختيار هذه الفئة سيستبدل الفئات المحددة حاليًا.'
      : 'Choosing this category replaces your current category selection.';
  String get replace => ar ? 'استبدال' : 'Replace';
  String get cancel => ar ? 'إلغاء' : 'Cancel';
  String get noCategories =>
      ar ? 'تعذر تحميل الفئات.' : 'Categories could not be loaded.';
  String get tryAgain => ar ? 'إعادة المحاولة' : 'Try again';
  String get join => ar ? 'انضمام' : 'Join';
  String get saved => ar ? 'المحفوظة' : 'Saved';
}
