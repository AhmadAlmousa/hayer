// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get savedPlaces => 'الأماكن المحفوظة';

  @override
  String get wantToTry => 'أبغى أجربه';

  @override
  String get favorites => 'المفضلة';

  @override
  String get savePlace => 'حفظ المكان';

  @override
  String get removeSavedPlace => 'إزالة من الأماكن المحفوظة';

  @override
  String get savedPlaceConfirmation => 'حُفظ في «أبغى أجربه».';

  @override
  String get removedSavedPlaceConfirmation => 'أُزيل من الأماكن المحفوظة.';

  @override
  String get savedPlaceFailed => 'تعذّر تحديث الأماكن المحفوظة على هذا الجهاز.';

  @override
  String get privateOnDeviceTitle => 'خاص على هذا الجهاز';

  @override
  String get privateOnDeviceMessage =>
      'تبقى الأماكن والملاحظات المحفوظة على هذا الجهاز. لا تتزامن ولا يمكن تصديرها حالياً، وقد تُفقد عند مسح بيانات التطبيق أو إزالة حيّر.';

  @override
  String get noSavedPlaces =>
      'ما فيه أماكن هنا بعد. احفظ مكاناً أثناء السحب أو من النتائج.';

  @override
  String get selectForShortlist => 'اختر أماكن لقائمة قصيرة';

  @override
  String selectedPlacesCount(int count) {
    return 'تم اختيار $count';
  }

  @override
  String startShortlist(int count) {
    return 'ابدأ بالقائمة ($count)';
  }

  @override
  String get minimumShortlist => 'اختر مكانين على الأقل لبدء قائمة قصيرة.';

  @override
  String get editSavedPlace => 'تعديل المكان المحفوظ';

  @override
  String get privateNote => 'ملاحظة خاصة';

  @override
  String get privateNoteHint => 'لا يراها غيرك على هذا الجهاز.';

  @override
  String get deleteSavedPlace => 'حذف المكان المحفوظ';

  @override
  String get saveChanges => 'حفظ التعديلات';

  @override
  String get startShortlistTitle => 'ابدأ من الأماكن المحفوظة';

  @override
  String shortlistSelectedCount(int count) {
    return 'ستبدأ الغرفة بـ $count أماكن محفوظة.';
  }

  @override
  String get freshIdeas => 'أضف 5 اقتراحات جديدة';

  @override
  String get freshIdeasDescription =>
      'سيبحث حيّر قريباً عن خمسة أماكن جديدة كحد أقصى. تبقى أماكنك المحفوظة في الغرفة حتى لو تعذّر البحث.';

  @override
  String get shortlistAreaTooWide =>
      'اختر أماكن محفوظة تقع ضمن نطاق بحث واحد بنصف قطر 10 كم.';

  @override
  String get shortlistCategoryUnavailable =>
      'لم تعد لهذه الأماكن المحفوظة فئة مدعومة.';

  @override
  String get shortlistUnavailable =>
      'بعض الأماكن المحفوظة لم تعد متاحة لهذه الغرفة. عدّل قائمتك وحاول مرة ثانية.';

  @override
  String get createShortlistRoom => 'إنشاء غرفة القائمة';

  @override
  String get placeDetails => 'التفاصيل';

  @override
  String get myChoice => 'اختياري';

  @override
  String choiceVotes(String count) {
    return '$count أصوات';
  }

  @override
  String choiceProgress(String chosen, String total) {
    return 'اختار $chosen من $total';
  }

  @override
  String get chooseDestination => 'وين نروح؟';

  @override
  String get choiceHint =>
      'اضغط «اختياري» على مكانك المفضل. يفوز الأكثر أصواتًا، وعند التعادل يحسم اختيار المضيف النتيجة. تقدر تغيّر اختيارك.';

  @override
  String get leadingChoice => 'المكان المتصدّر';

  @override
  String get groupChoice => 'اختيار المجموعة';

  @override
  String get choiceTie => 'تعادل — ننتظر اختيار المضيف';

  @override
  String get choiceHostTie => 'اختر أحد الأماكن المتعادلة لحسم النتيجة.';

  @override
  String get choiceHostDecided => 'حسم اختيار المضيف التعادل.';

  @override
  String get choiceSaving => 'جارٍ الحفظ…';

  @override
  String get choiceFailed =>
      'تعذّر تأكيد اختيارك. راجع آخر الأصوات وحاول مرة ثانية.';

  @override
  String get choiceConflict =>
      'تغيّر اختيارك من جهاز آخر. يظهر الآن آخر اختيار.';

  @override
  String get choiceNotReady => 'يفتح الاختيار بعد ما يخلص الجميع التمرير.';

  @override
  String get choiceClosed => 'انتهى التصويت. هذه الاختيارات المحفوظة.';

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
  String get currentLocation => 'الموقع المحدد';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get searchingLocations => 'جارٍ البحث عن المواقع';

  @override
  String get noLocationResults =>
      'لم نجد مواقع. جرّب منطقة أخرى أو استخدم موقعك الحالي.';

  @override
  String get locationSearchFailed =>
      'البحث عن المواقع غير متاح. حاول مرة أخرى أو استخدم موقعك الحالي.';

  @override
  String get refreshFailed =>
      'توقفت التحديثات مؤقتًا. نعرض آخر معلومات محفوظة للجلسة.';

  @override
  String get liveUpdatesPaused =>
      'التحديثات المباشرة متوقفة مؤقتًا. نواصل التحقق من التغييرات.';

  @override
  String get liveUpdatesUnreachable =>
      'تعذّر الاتصال بالخادم. هذه آخر حالة تم تحميلها.';

  @override
  String get refreshNow => 'تحديث الآن';

  @override
  String get startingHayer => 'جارٍ تجهيز حاير…';

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
  String get finalSwipePending =>
      'تم حفظ اختيارك الأخير على هذا الجهاز. أعد الاتصال لإكمال المزامنة قبل عرض النتيجة.';

  @override
  String get retrySync => 'إعادة المزامنة';

  @override
  String get swipeSaveFailed =>
      'تعذّر حفظ هذا الاختيار على الجهاز. حاول مرة أخرى.';

  @override
  String get swipeRejected =>
      'تعذّر على الخادم قبول هذا الاختيار. حدّث الجلسة وحاول مرة أخرى.';

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
  String get cuisinesLabel => 'المطابخ';

  @override
  String get poiTypesLabel => 'أنواع الأماكن';

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

  @override
  String get routeOriginTitle => 'من وين نحسب وقت مشوارك؟';

  @override
  String get routeOriginDescription =>
      'يتغير الوقت والمسافة الظاهرة لك فقط، وتبقى أماكن المجموعة وتصويتاتها كما هي.';

  @override
  String get useHostLocation => 'استخدم موقع المضيف';

  @override
  String get useHostLocationDescription =>
      'تكون التقديرات من منطقة البحث المشتركة للجميع.';

  @override
  String get useMyLocation => 'استخدم موقعي الحالي';

  @override
  String get useMyLocationDescription => 'احسب تقديراتي من مكاني الآن.';

  @override
  String get routeOriginSetting => 'تقدير مشوارك';

  @override
  String get routeDistanceUnavailable => 'المسافة غير متاحة';

  @override
  String get currentLocationUnavailableUsingHost =>
      'تعذر تحديد موقعك، لذلك سنستخدم موقع المضيف.';

  @override
  String distanceMetersLabel(String distance) {
    return '$distance م';
  }

  @override
  String distanceKilometersLabel(String distance) {
    return '$distance كم';
  }

  @override
  String approximateRouteEstimate(int minutes, String distance) {
    return '~$minutes د · $distance';
  }

  @override
  String get reportDataIssue => 'الإبلاغ عن خطأ في البيانات';

  @override
  String get reportDataIssueExplanation =>
      'استخدم هذا للأخطاء الواقعية في بيانات المكان، وليس لأن المكان لا يناسب ذوقك.';

  @override
  String get reportReasonRequired => 'اختر نوع الخطأ الواقعي.';

  @override
  String get reportWrongCategory => 'تصنيف غير صحيح';

  @override
  String get reportClosed => 'المكان مغلق';

  @override
  String get reportWrongLocation => 'الموقع غير صحيح';

  @override
  String get reportDuplicate => 'مكان مكرر';

  @override
  String get reportMisleadingPhoto => 'صورة مضللة';

  @override
  String get reportOtherDataIssue => 'خطأ آخر في البيانات';

  @override
  String get reportDetailsLabel => 'التفاصيل (اختياري)';

  @override
  String get reportDetailsHint => 'ما الذي ينبغي أن يتحقق منه المراجع؟';

  @override
  String get reportDetailsRequired => 'يرجى وصف الخطأ الآخر في البيانات.';

  @override
  String get reportDetailsLength => 'أدخل من 4 إلى 500 حرف.';

  @override
  String get reportPrivacyHint => 'لا تُدرج معلومات شخصية أو حساسة.';

  @override
  String get submitReport => 'إرسال للمراجعة';

  @override
  String get reportThanks => 'شكراً، أُرسل بلاغك للمراجعة.';

  @override
  String get reportRateLimited => 'أرسلت عدة بلاغات. حاول مرة أخرى لاحقاً.';

  @override
  String get reportFailed => 'تعذر إرسال البلاغ. حاول مرة أخرى.';

  @override
  String get dataAndPrivacy => 'بياناتك';

  @override
  String get dataIntro =>
      'ما يُرسله حيّر، وما يبقى على هذا الجهاز، وما تراه مجموعتك.';

  @override
  String get dataIdentityTitle => 'بدون حساب';

  @override
  String get dataIdentityBody =>
      'لا يطلب حيّر بريداً إلكترونياً ولا رقم جوال ولا كلمة مرور. يسجّل التطبيق الدخول بهوية مجهولة ويحفظها على هذا الجهاز. والاسم الذي تكتبه عند إنشاء غرفة أو الانضمام إليها يظهر لتلك الغرفة، ولا يُتحقق منه.';

  @override
  String get dataLocationTitle => 'الموقع';

  @override
  String get dataLocationBody =>
      'يُرسَل موقع البحث الذي تختاره — موقعك الحالي أو مكان بحثت عنه — إلى حيّر مع نطاق البحث للعثور على الأماكن القريبة. العناوين من OpenStreetMap، وتفاصيل الأماكن وصورها وتقييماتها من خرائط Google. وإذا طلبت زمن الوصول من مكانك، يُرسَل موقعك مع الطلب. لا يتتبع حيّر موقعك في الخلفية.';

  @override
  String get dataGroupTitle => 'ما تراه مجموعتك';

  @override
  String get dataGroupBody =>
      'يرى من في غرفتك الاسم الذي انضممت به، وإلى أين وصلت في البطاقات، وهل أنهيتها. وتعرض النتائج كم شخصاً أعجبه كل مكان وكم اختاره، دون إظهار من أعجبه أو من اختاره.';

  @override
  String get dataDeviceTitle => 'ما يبقى على هذا الجهاز';

  @override
  String get dataDeviceBody =>
      'تبقى هنا الأماكن المحفوظة وملاحظاتها، والاسم الذي استخدمته آخر مرة، والغرفة التي يمكنك متابعتها، وأي سحبات لم تصل إلى الخادم بعد. لا شيء يتزامن مع حساب، لذا تُحذف بإزالة حيّر.';

  @override
  String get dataMeasurementTitle => 'القياس';

  @override
  String get dataMeasurementBody =>
      'يحصي حيّر استخداماً مجهولاً — الغرف التي بدأت، والبطاقات التي ظهرت، والقرارات التي اتُخذت — بمعرّف عشوائي يغطي غرفة واحدة ثم يُهمَل، مع إصدار التطبيق والمنصة واللغة. لا يحمل هوية دائمة للجهاز ولا يرتبط بأماكنك المحفوظة أو ملاحظاتك.';

  @override
  String get dataEraseTitle => 'حذف البيانات من هذا الجهاز';

  @override
  String get dataEraseBody =>
      'يحذف المسح الأماكن المحفوظة وملاحظاتها، والاسم المحفوظ، والغرفة القابلة للمتابعة، وتسجيل الدخول المجهول. تنتهي صلاحية الغرف على الخادم من تلقاء نفسها، والمسح هنا لا يحذف ما سجّله الخادم سابقاً.';

  @override
  String get dataEraseAction => 'امسح البيانات من هذا الجهاز';

  @override
  String get dataEraseConfirmTitle => 'مسح البيانات من هذا الجهاز؟';

  @override
  String get dataEraseConfirmBody => 'لا يمكن التراجع عن هذا.';

  @override
  String dataErasePendingWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'هناك $count سحبات لم تصل إلى الخادم بعد وستُفقد.',
      one: 'هناك سحبة لم تصل إلى الخادم بعد وستُفقد.',
    );
    return '$_temp0';
  }

  @override
  String get dataEraseKeep => 'احتفظ بالبيانات';

  @override
  String get dataEraseConfirm => 'امسح';

  @override
  String get dataErased => 'مُسحت بيانات هذا الجهاز.';

  @override
  String get dataEraseFailed => 'تعذر مسح كل شيء. حاول مرة أخرى.';

  @override
  String get homeTimeQuestion => 'كم عندك وقت؟';

  @override
  String get inAHurry => 'مستعجل';

  @override
  String get inAHurryDescription =>
      'اختر الجو، اسحب البطاقات، وقرّر خلال دقيقة';

  @override
  String inAHurryCards(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count بطاقة',
      many: '$count بطاقة',
      few: '$count بطاقات',
      two: 'بطاقتان',
      one: 'بطاقة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get inAHurrySoloOrGroup => 'وحدك أو مع مجموعة';

  @override
  String get inAHurryDuration => '~60 ثانية';

  @override
  String get gotTime => 'عندي وقت';

  @override
  String get gotTimeDescription => 'تصفّح كل الأماكن على الخريطة على طريقتك';

  @override
  String get gotTimeSortAndFilter => 'ترتيب وتصفية';

  @override
  String get gotTimeHiddenGems => 'جواهر مخفية';

  @override
  String get gotTimeFullMap => 'الخريطة كاملة';

  @override
  String get discoveryUnavailable => '«عندي وقت» غير متاح حالياً. حاول لاحقاً.';
}
