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
  const SearchParser(this.calibration);

  final PlaceCalibration calibration;

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
        urls.add(_withWidth(uri, 1600).toString());
      }
      if (urls.length == 3) break;
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
    final normalized = status.toLowerCase();
    if (normalized.contains('temporarily closed') ||
        normalized.contains('permanently closed')) {
      return false;
    }
    if (normalized.contains('open')) return true;
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
        if (label == null || label.toLowerCase().contains('closed')) continue;
        if (label.toLowerCase().contains('24 hours')) {
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
    }[value.toLowerCase()];
  }

  int? _timeMinutes(String value) {
    final match = RegExp(
      r'^(\d{1,2})(?::(\d{2}))?\s*([AP]M)$',
      caseSensitive: false,
    ).firstMatch(value.trim());
    if (match == null) return null;
    var hour = int.parse(match.group(1)!);
    final minute = int.tryParse(match.group(2) ?? '0') ?? 0;
    final meridiem = match.group(3)!.toUpperCase();
    if (hour == 12) hour = 0;
    if (meridiem == 'PM') hour += 12;
    return hour * 60 + minute;
  }
}
