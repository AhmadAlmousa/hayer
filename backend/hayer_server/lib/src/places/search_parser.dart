import 'calibration.dart';
import '../generated/protocol.dart' show OpeningPeriod;
import 'google_response.dart';
import 'place_candidate.dart';

class SearchParseResult {
  const SearchParseResult({
    required this.places,
    required this.structurallyValid,
  });

  final List<PlaceCandidate> places;
  final bool structurallyValid;
}

class SearchParser {
  const SearchParser(
    this.calibration, {
    this.photoLimit = defaultPhotoLimit,
    this.photoWidth = defaultPhotoWidth,
  });

  /// What the parser keeps when nobody has configured it. Both are policy in
  /// production; these only cover parser tests and the brief window before a
  /// source reads the settings row.
  static const defaultPhotoLimit = 6;
  static const defaultPhotoWidth = 1200;

  final PlaceCalibration calibration;

  /// How many photos to keep per place, from [PhotoPolicy.fetchCount].
  final int photoLimit;

  /// The pixel width photo URLs are rewritten to, from [PhotoPolicy.width].
  final int photoWidth;

  SearchParseResult parse(String body, {required DateTime checkedAt}) {
    final response = GoogleResponse.parse(body);
    final list = response.at(
      calibration.paths[PlaceCalibrationPath.results],
    );
    final focused = response.at(
      calibration.paths[PlaceCalibrationPath.single],
    );
    final entries = <Object?>[];
    if (list is List && list.isNotEmpty) {
      entries.addAll(list);
    }
    if (entries.isEmpty) {
      final atThisPlace = response.at(
        calibration.paths[PlaceCalibrationPath.atThisPlace],
      );
      if (atThisPlace is List) {
        for (final item in atThisPlace) {
          if (item is List && item.isNotEmpty) {
            entries.add([null, item.first]);
          }
        }
      }
    }
    if (entries.isEmpty && focused is List) {
      entries.add([null, focused]);
    }
    final validShape = list is List || focused is List;
    final places = entries
        .map((entry) => _parseEntry(response, entry, checkedAt))
        .whereType<PlaceCandidate>()
        .toList(growable: false);
    return SearchParseResult(places: places, structurallyValid: validShape);
  }

  PlaceCandidate? _parseEntry(
    GoogleResponse response,
    Object? entry,
    DateTime checkedAt,
  ) {
    final name = response.stringAt(
      calibration.paths[PlaceCalibrationPath.name],
      from: entry,
    );
    final latitude = response.doubleAt(
      calibration.paths[PlaceCalibrationPath.lat],
      from: entry,
    );
    final longitude = response.doubleAt(
      calibration.paths[PlaceCalibrationPath.lng],
      from: entry,
    );
    final featureId = response.stringAt(
      calibration.paths[PlaceCalibrationPath.featureId],
      from: entry,
    );
    final rawPlaceId = response.stringAt(
      calibration.paths[PlaceCalibrationPath.placeId],
      from: entry,
    );
    final placeId = rawPlaceId ?? featureId;
    if (name == null ||
        latitude == null ||
        longitude == null ||
        placeId == null) {
      return null;
    }
    final status =
        response.stringAt(
          calibration.paths[PlaceCalibrationPath.openStatus],
          from: entry,
        ) ??
        response.stringAt(
          calibration.paths[PlaceCalibrationPath.statusRich],
          from: entry,
        ) ??
        response.stringAt(
          calibration.paths[PlaceCalibrationPath.status118],
          from: entry,
        );
    final priceText = response.stringAt(
      calibration.paths[PlaceCalibrationPath.priceText],
      from: entry,
    );
    final website = _safeHttps(
      response.stringAt(
        calibration.paths[PlaceCalibrationPath.website],
        from: entry,
      ),
    );
    final photos = _photos(
      response.at(
        calibration.paths[PlaceCalibrationPath.photos],
        from: entry,
      ),
    );
    return PlaceCandidate(
      placeId: placeId,
      featureId: featureId,
      name: name,
      primaryType: response.stringAt(
        calibration.paths[PlaceCalibrationPath.category],
        from: entry,
      ),
      rating: response.doubleAt(
        calibration.paths[PlaceCalibrationPath.rating],
        from: entry,
      ),
      reviewCount: response.intAt(
        calibration.paths[PlaceCalibrationPath.reviewCount],
        from: entry,
      ),
      priceLevel: _priceLevel(priceText),
      priceText: priceText,
      isOpen: _openState(status),
      statusText: status,
      hours: _hours(response, entry),
      latitude: latitude,
      longitude: longitude,
      address: response.stringAt(
        calibration.paths[PlaceCalibrationPath.address],
        from: entry,
      ),
      formattedAddress: response.stringAt(
        calibration.paths[PlaceCalibrationPath.address],
        from: entry,
      ),
      phoneNumber: response.stringAt(
        calibration.paths[PlaceCalibrationPath.phone],
        from: entry,
      ),
      websiteUrl: website,
      mapsUrl:
          'https://www.google.com/maps/search/?api=1&query_place_id=${Uri.encodeQueryComponent(placeId)}',
      photoUrls: photos,
      featuredReview: response.stringAt(
        calibration.paths[PlaceCalibrationPath.featuredReview],
        from: entry,
      ),
      editorialSummary: response.stringAt(
        calibration.paths[PlaceCalibrationPath.editorialSummary],
        from: entry,
      ),
      sourceCheckedAt: checkedAt.toUtc(),
    );
  }

  List<String> _photos(Object? block) {
    if (block is! List) return const [];
    final urls = <String>{};
    for (final photo in block) {
      final raw = GoogleResponse(photo).stringAt(const [6, 0]);
      final uri = raw == null ? null : Uri.tryParse(raw);
      if (uri != null && calibration.isAllowedImage(uri)) {
        urls.add(_withWidth(uri, photoWidth).toString());
      }
      if (urls.length >= photoLimit) break;
    }
    return urls.toList(growable: false);
  }

  Uri _withWidth(Uri uri, int width) {
    final value = uri.toString().replaceFirst(
      RegExp(r'=w\d+(?:-h\d+)?[^?]*$'),
      '=w$width',
    );
    return Uri.parse(value);
  }

  String? _safeHttps(String? raw) {
    if (raw == null) return null;
    final uri = Uri.tryParse(raw);
    return uri?.scheme == 'https' ? uri.toString() : null;
  }

  int? _priceLevel(String? text) {
    if (text == null) return null;
    final compact = text.trim();
    final lowerBound = int.tryParse(
      RegExp(r'\d+').firstMatch(compact)?.group(0) ?? '',
    );
    if (lowerBound != null) {
      if (lowerBound < 10) return 1;
      if (lowerBound < 20) return 2;
      if (lowerBound < 35) return 3;
      return 4;
    }
    final symbols = RegExp(r'[$€£¥₩₹﷼]').allMatches(compact).length;
    return symbols == 0 ? null : symbols.clamp(1, 4);
  }

  bool? _openState(String? status) {
    if (status == null) return null;
    final normalized = _normalizedLabel(status);
    if (normalized.contains('temporarily closed') ||
        normalized.contains('permanently closed') ||
        normalized.contains('مغلق')) {
      return false;
    }
    if (normalized.contains('open') || normalized.contains('مفتوح')) {
      return true;
    }
    if (normalized.contains('closed')) return false;
    return null;
  }

  List<OpeningPeriod> _hours(GoogleResponse response, Object? entry) {
    Object? block = response.at(
      calibration.paths[PlaceCalibrationPath.hours203],
      from: entry,
    );
    if (block is! List || block.isEmpty) {
      block = response.at(
        calibration.paths[PlaceCalibrationPath.hours118],
        from: entry,
      );
    }
    if (block is! List) return const [];
    final periods = <OpeningPeriod>[];
    for (final day in block) {
      if (day is! List || day.isEmpty) continue;
      final dayIndex = _dayIndex(day.first);
      if (dayIndex == null) continue;
      final ranges = GoogleResponse(day).at(const [3]);
      if (ranges is! List) continue;
      for (final range in ranges) {
        final label = GoogleResponse(range).stringAt(const [0]);
        if (label == null || _isClosedLabel(label)) continue;
        if (_isAlwaysOpenLabel(label)) {
          periods.add(
            OpeningPeriod(
              day: dayIndex,
              openMinutes: 0,
              closeMinutes: 1440,
              overnight: false,
            ),
          );
          continue;
        }
        final parts = label.split(RegExp(r'\s*[–—-]\s*'));
        if (parts.length != 2) continue;
        final open = _timeMinutes(parts[0]);
        final close = _timeMinutes(parts[1]);
        if (open == null || close == null) continue;
        periods.add(
          OpeningPeriod(
            day: dayIndex,
            openMinutes: open,
            closeMinutes: close,
            overnight: close <= open,
          ),
        );
      }
    }
    return periods;
  }

  int? _dayIndex(Object? value) {
    if (value is! String) return null;
    return const {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
      'الاثنين': 1,
      'الثلاثاء': 2,
      'الاربعاء': 3,
      'الخميس': 4,
      'الجمعة': 5,
      'السبت': 6,
      'الاحد': 7,
    }[_normalizedLabel(value)];
  }

  int? _timeMinutes(String value) {
    final normalized = _normalizedLabel(
      value,
    ).replaceAll('.', '').toUpperCase();
    final match = RegExp(
      r'^(\d{1,2})(?::(\d{1,2}))?\s*(AM|PM|ص|م)$',
      caseSensitive: false,
    ).firstMatch(normalized);
    if (match == null) return null;
    var hour = int.parse(match.group(1)!);
    final minute = int.tryParse(match.group(2) ?? '0') ?? 0;
    final meridiem = match.group(3)!.toUpperCase();
    if (hour < 1 || hour > 12 || minute > 59) return null;
    if (hour == 12) hour = 0;
    if (meridiem == 'PM' || meridiem == 'م') hour += 12;
    return hour * 60 + minute;
  }

  bool _isClosedLabel(String label) {
    final normalized = _normalizedLabel(label);
    return normalized.contains('closed') || normalized.contains('مغلق');
  }

  bool _isAlwaysOpenLabel(String label) {
    final normalized = _normalizedLabel(label);
    return normalized.contains('24 hours') ||
        normalized.contains('على مدار الساعة') ||
        (normalized.contains('24') && normalized.contains('ساعة'));
  }

  String _normalizedLabel(String value) => value
      .toLowerCase()
      .replaceAll(RegExp('[\u064B-\u065F\u0670\u0640]'), '')
      .replaceAll(RegExp('[آأإ]'), 'ا')
      .replaceAll('\u00a0', ' ')
      .replaceAll('\u202f', ' ')
      .replaceAll('٠', '0')
      .replaceAll('١', '1')
      .replaceAll('٢', '2')
      .replaceAll('٣', '3')
      .replaceAll('٤', '4')
      .replaceAll('٥', '5')
      .replaceAll('٦', '6')
      .replaceAll('٧', '7')
      .replaceAll('٨', '8')
      .replaceAll('٩', '9')
      .replaceAll('۰', '0')
      .replaceAll('۱', '1')
      .replaceAll('۲', '2')
      .replaceAll('۳', '3')
      .replaceAll('۴', '4')
      .replaceAll('۵', '5')
      .replaceAll('۶', '6')
      .replaceAll('۷', '7')
      .replaceAll('۸', '8')
      .replaceAll('۹', '9')
      .trim();
}
