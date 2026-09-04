// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'حيّر';

  @override
  String get tagline => 'اسحب أقل. وقرّروا معاً.';

  @override
  String get newSearch => 'بحث جديد';

  @override
  String get joinSession => 'انضم إلى جلسة';

  @override
  String get sessionCode => 'رمز الجلسة';

  @override
  String get displayName => 'الاسم الظاهر';

  @override
  String get join => 'انضم';

  @override
  String get switchToLightTheme => 'التبديل إلى المظهر الفاتح';

  @override
  String get switchToDarkTheme => 'التبديل إلى المظهر الداكن';

  @override
  String get setupWhatTitle => 'وش ودّك فيه؟';

  @override
  String get setupWhereTitle => 'وين نروح؟';

  @override
  String get setupOptionsTitle => 'خصّص بطاقاتك';

  @override
  String get setupModeTitle => 'كيف بنقرر؟';

  @override
  String get setupTimelineType => 'النوع';

  @override
  String get setupTimelineWhere => 'المكان';

  @override
  String get setupTimelineOptions => 'الخيارات';

  @override
  String get setupTimelineMode => 'النمط';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get backLabel => 'رجوع';

  @override
  String get restaurants => 'مطاعم';

  @override
  String get cafes => 'مقاهي';

  @override
  String get thingsToDo => 'أماكن وتجارب';

  @override
  String get useCurrentLocation => 'استخدم موقعي الحالي';

  @override
  String get locatingYou => 'نحدد عنوانك…';

  @override
  String get currentLocation => 'موقعي الحالي';

  @override
  String get locationPermissionRequired =>
      'يلزم السماح بالوصول إلى الموقع لاستخدام موقعك الحالي.';

  @override
  String get locationAddressAttribution => 'العنوان من OpenStreetMap';

  @override
  String get searchLocation => 'ابحث عن مكان أو حي';

  @override
  String get radius => 'نطاق البحث';

  @override
  String get price => 'الحد الأعلى للسعر';

  @override
  String get priceDescription =>
      'اعرض كل الأماكن، أو حدد أعلى مستوى سعر يناسبك.';

  @override
  String get deckSize => 'عدد البطاقات';

  @override
  String get deckSizeDescription => 'اختر عدد الأماكن التي تريد السحب بينها.';

  @override
  String get visitTime => 'متى بتروحون؟';

  @override
  String get visitTimeDescription =>
      'اختر اليوم والوقت، وحيّر يستبعد الأماكن المعروفة بأنها مغلقة وقتها.';

  @override
  String get anyTime => 'أي وقت';

  @override
  String get chooseVisitTime => 'اختر اليوم والوقت';

  @override
  String get customTime => 'وقت مخصص';

  @override
  String get clearVisitTime => 'إلغاء الوقت';

  @override
  String placesCount(int count) {
    return '$count أماكن';
  }

  @override
  String get anyPrice => 'الكل';

  @override
  String priceLevelValue(int level) {
    return 'المستوى $level';
  }

  @override
  String get solo => 'فردي';

  @override
  String get soloDescription => 'قرار سريع لك وحدك';

  @override
  String get multiplayer => 'مجموعة';

  @override
  String get multiplayerDescription => 'ادعُ أصحابك وابحثوا عن تطابق';

  @override
  String get majority => 'الأغلبية';

  @override
  String get majorityTip => 'يتطابق المكان عندما يعجب أكثر من نصف المجموعة.';

  @override
  String get unanimous => 'بالإجماع';

  @override
  String get unanimousTip => 'يتطابق المكان فقط عندما يعجب الجميع.';

  @override
  String get stopOnFirstMatch => 'توقف عند أول تطابق';

  @override
  String get startSwiping => 'ابدأ السحب';

  @override
  String get createSession => 'أنشئ الجلسة';

  @override
  String get findingPlaces => 'نبحث عن أفضل الأماكن…';

  @override
  String get bestEffortGcc => 'الخدمة خارج السعودية ما زالت تجريبية.';

  @override
  String get cachedPlacesWarning =>
      'بعض تفاصيل الأماكن محفوظة وقد لا تكون محدثة.';

  @override
  String get underfilledDeck =>
      'وجدنا أماكن أقل من المطلوب. جرّب نطاقاً أكبر أو فئة أوسع.';

  @override
  String get temporarySourceError =>
      'مصدر الأماكن غير متاح مؤقتاً. حاول مرة أخرى.';

  @override
  String get serverUnavailable =>
      'تعذّر الاتصال بخادم حيّر. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get serverRequestFailed =>
      'تعذّر على خادم حيّر إكمال الطلب. حاول مرة أخرى.';

  @override
  String get noPlaces => 'لم نجد أماكن مناسبة. جرّب نطاقاً أكبر أو فئة أوسع.';

  @override
  String get lobby => 'غرفة الجلسة';

  @override
  String get shareCode => 'مشاركة الرمز';

  @override
  String get participants => 'المشاركون';

  @override
  String get viewResults => 'عرض النتائج';

  @override
  String get results => 'النتائج';

  @override
  String get navigate => 'الاتجاهات';

  @override
  String get sharePicks => 'مشاركة الاختيارات';

  @override
  String get shareResults => 'مشاركة النتائج';

  @override
  String get details => 'التفاصيل';

  @override
  String get sourceAttribution => 'معلومات الأماكن من خرائط Google';

  @override
  String get like => 'أعجبني';

  @override
  String get pass => 'تخطي';

  @override
  String get openNow => 'مفتوح الآن';

  @override
  String get closedNow => 'مغلق الآن';

  @override
  String get unknownHours => 'ساعات العمل غير متوفرة';

  @override
  String get noPhoto => 'لا توجد صورة';

  @override
  String get waitingForGroup => 'قد تتغير النتائج حتى ينتهي الآخرون.';

  @override
  String get everyoneFinished => 'انتهى الجميع';

  @override
  String get noLikes =>
      'لم تعجبك أي أماكن. ابدأ بحثاً جديداً للمحاولة مرة أخرى.';

  @override
  String get noGroupMatch => 'لا يوجد مكان متطابق للمجموعة.';

  @override
  String get sessionExpired => 'انتهت صلاحية هذه الجلسة.';

  @override
  String get offlineQueued =>
      'تم الحفظ دون اتصال، وستتم المزامنة عند عودة الشبكة.';

  @override
  String get updateRequired => 'حدّث تطبيق حيّر للمتابعة.';

  @override
  String get downloadUpdate => 'تنزيل التحديث';

  @override
  String get resumeSession => 'متابعة الجلسة';

  @override
  String get resumeSoloSession => 'جلسة فردية';

  @override
  String get resumeMultiplayerSession => 'جلسة جماعية';

  @override
  String createdAt(String time) {
    return 'أُنشئت $time';
  }

  @override
  String get endSoloSessionTitle => 'إنهاء هذه الجلسة الفردية؟';

  @override
  String get endSoloSessionMessage => 'سيتم حذف البطاقات وتقدم السحب نهائياً.';

  @override
  String get keepSwiping => 'متابعة السحب';

  @override
  String get endSession => 'إنهاء الجلسة';

  @override
  String get endSessionFailed => 'تعذر إنهاء الجلسة. حاول مرة أخرى.';

  @override
  String get installHayerTitle => 'استمتعت بالاختيار مع حيّر؟';

  @override
  String get installHayerMessage =>
      'ثبّت التطبيق للانضمام بشكل أسرع ولقرار مجموعتك القادم.';

  @override
  String get getItOnGooglePlay => 'احصل عليه من Google Play';

  @override
  String get downloadOnAppStore => 'حمّله من App Store';

  @override
  String get resumeFailed => 'الجلسة المحفوظة لم تعد متاحة.';

  @override
  String get allLabel => 'كل';

  @override
  String typesCount(int count) {
    return '$count أنواع';
  }

  @override
  String get showQrCode => 'عرض رمز QR';

  @override
  String get qrLabel => 'QR';

  @override
  String get sessionQrTitle => 'رمز QR للجلسة';

  @override
  String get codeCopied => 'تم نسخ الرمز';

  @override
  String get copyLabel => 'نسخ';

  @override
  String get shareLabel => 'مشاركة';

  @override
  String joinMySession(String url) {
    return 'انضم إلى جلستي في حيّر: $url';
  }

  @override
  String get firstMatch => 'أول تطابق';

  @override
  String get matchFoundTitle => 'لقينا تطابق!';

  @override
  String get matchFoundCelebration => 'أول تطابق—تم القرار!';

  @override
  String get fullDeck => 'كل البطاقات';

  @override
  String get host => 'المضيف';

  @override
  String get done => 'انتهى';

  @override
  String participantProgress(int current, int total) {
    return '$current/$total';
  }

  @override
  String get couldNotLoadSession => 'تعذر تحميل الجلسة. حاول مرة أخرى.';

  @override
  String get couldNotLoadResults => 'تعذر تحميل النتائج. حاول مرة أخرى.';

  @override
  String get groupResults => 'نتائج المجموعة';

  @override
  String get yourPicks => 'اختياراتك';

  @override
  String codeLabel(String code) {
    return 'الرمز $code';
  }

  @override
  String participantsCount(int count) {
    return '$count مشاركين';
  }

  @override
  String matchesCount(int count) {
    return '$count تطابقات';
  }

  @override
  String completedCount(int completed, int total) {
    return 'انتهى $completed/$total';
  }

  @override
  String groupProgress(int completed, int total) {
    return 'أكمل $completed/$total';
  }

  @override
  String get sortBy => 'الترتيب حسب:';

  @override
  String get rating => 'التقييم';

  @override
  String get reviews => 'المراجعات';

  @override
  String get distance => 'المسافة';

  @override
  String reviewsCount(int count) {
    return '$count مراجعة';
  }

  @override
  String likedPercent(int percent, int likes, int voters) {
    return '$percent٪ · أعجب $likes/$voters';
  }

  @override
  String get ourGroupPicks => 'اختيارات مجموعة حيّر';

  @override
  String get myPicks => 'اختياراتي في حيّر';

  @override
  String participantsCompleted(int completed, int total) {
    return 'أكمل $completed/$total مشاركين';
  }

  @override
  String get hayerPicks => 'اختيارات حيّر';

  @override
  String get weeklyHours => 'ساعات الأسبوع';

  @override
  String get website => 'الموقع الإلكتروني';

  @override
  String get directions => 'الاتجاهات';

  @override
  String checkedAt(String time) {
    return 'تم التحقق $time';
  }

  @override
  String get cachedDetailsHidden =>
      'التفاصيل محفوظة؛ تم إخفاء الحقول المتغيرة.';

  @override
  String get closed => 'مغلق';

  @override
  String selectedTime(String time) {
    return 'المحدد $time';
  }

  @override
  String get midnight => 'منتصف الليل';

  @override
  String get scanQrCode => 'مسح رمز QR';

  @override
  String get scanInstructions => 'استخدم كاميرا جهازك لمسح رمز QR لجلسة حيّر.';

  @override
  String get openingScanner => 'جارٍ فتح الماسح…';

  @override
  String get enterCodeInstead => 'أدخل الرمز يدوياً';

  @override
  String get invalidQrCode => 'رمز QR هذا ليس رابط جلسة حيّر.';

  @override
  String get scannerUnavailable => 'مسح QR متاح في تطبيقي Android وiOS.';

  @override
  String get cameraPermissionNeeded => 'يلزم السماح للكاميرا لمسح رمز الجلسة.';

  @override
  String get cameraStartFailed =>
      'تعذر تشغيل الكاميرا. ارجع وأدخل الرمز يدوياً.';

  @override
  String get joinFailed => 'تعذر الانضمام إلى هذه الجلسة.';

  @override
  String get invalidSessionCode => 'أدخل رمز جلسة صالحاً.';

  @override
  String get invalidDisplayName => 'أدخل اسماً ظاهراً من حرفين إلى 30 حرفاً.';

  @override
  String get undoLastSwipe => 'تراجع عن آخر سحب';

  @override
  String cardProgress(int current, int total) {
    return 'البطاقة $current من $total';
  }

  @override
  String get likeStamp => 'أعجبني';

  @override
  String get passStamp => 'تخطي';

  @override
  String get openInGoogleMaps => 'فتح في خرائط Google';

  @override
  String get openWebsite => 'فتح الموقع الإلكتروني';

  @override
  String get placeFallback => 'مكان';

  @override
  String get futureVisitTime => 'اختر وقت زيارة في المستقبل.';

  @override
  String get noSavedSession => 'لا توجد جلسة محفوظة بعد.';

  @override
  String get whatsNew => 'ما الجديد';

  @override
  String get couldNotOpenDirections => 'تعذر فتح الاتجاهات.';

  @override
  String get mapEditHint =>
      'خريطة نطاق البحث. اسحب نقطة المركز لتحريك النطاق ومقبض الحافة لتغيير حجمه.';

  @override
  String mapSelectedHint(String distance) {
    return 'خريطة نطاق البحث المحدد، بنصف قطر $distance.';
  }

  @override
  String dragMapHint(String distance) {
    return 'اسحب المركز أو الحافة · $distance';
  }

  @override
  String radiusDistance(String distance) {
    return 'نصف القطر $distance';
  }
}
