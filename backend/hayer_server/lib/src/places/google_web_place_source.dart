import 'dart:async';

import 'calibration.dart';
import 'google_web_session.dart';
import 'place_candidate.dart';
import 'place_source.dart';
import 'search_parser.dart';
import 'search_pb.dart';

class GoogleWebPlaceSource implements PlaceSource {
  GoogleWebPlaceSource({
    required this.calibration,
    GoogleWebSession? webSession,
  }) : _session = webSession ?? GoogleWebSession(calibration: calibration),
       _parser = SearchParser(calibration),
       _pb = SearchPb(calibration);

  final PlaceCalibration calibration;
  final GoogleWebSession _session;
  final SearchParser _parser;
  final SearchPb _pb;
  final _RequestRateGate _rateGate = _RequestRateGate();

  void configureRateLimit({
    required int requestsPerMinute,
    required int burst,
  }) => _rateGate.configure(
    requestsPerMinute: requestsPerMinute,
    burst: burst,
  );

  @override
  Future<List<PlaceCandidate>> search({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int desiredCount,
    required String language,
    required String countryCode,
  }) async {
    try {
      final first = await _page(
        query: query,
        categoryId: categoryId,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        language: language,
        countryCode: countryCode,
        offset: 0,
      );
      final places = [...first];
      if (desiredCount > places.length &&
          first.length >= calibration.pageSize - 3) {
        final pages = await Future.wait([
          _page(
            query: query,
            categoryId: categoryId,
            latitude: latitude,
            longitude: longitude,
            radiusMeters: radiusMeters,
            language: language,
            countryCode: countryCode,
            offset: calibration.pageSize,
          ),
          if (desiredCount > calibration.pageSize * 2)
            _page(
              query: query,
              categoryId: categoryId,
              latitude: latitude,
              longitude: longitude,
              radiusMeters: radiusMeters,
              language: language,
              countryCode: countryCode,
              offset: calibration.pageSize * 2,
            ),
        ]);
        for (final page in pages) {
          places.addAll(page);
        }
      }
      return places;
    } on PlaceSourceException {
      rethrow;
    } on TimeoutException catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place search timed out.',
        cause: error,
      );
    } on FormatException catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place response could not be parsed.',
        cause: error,
      );
    } catch (error) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'Place search is temporarily unavailable.',
        cause: error,
      );
    }
  }

  Future<List<PlaceCandidate>> _page({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String language,
    required String countryCode,
    required int offset,
  }) async {
    final pb = _pb.build(
      query: query,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      offset: offset,
    );
    await _rateGate.acquire();
    final response = await _session.search(
      query: query,
      pb: pb,
      language: language,
      region: countryCode.toLowerCase(),
    );
    if (response.statusCode == 429) {
      throw const PlaceSourceException(
        'rate_limited',
        'The place source rate limit was reached.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw PlaceSourceException(
        'place_source_unavailable',
        'The place source returned HTTP ${response.statusCode}.',
      );
    }
    final finalUri = response.request?.url;
    if (finalUri == null ||
        !calibration.allowedRequestHosts.contains(
          finalUri.host.toLowerCase(),
        ) ||
        finalUri.path.toLowerCase().contains('consent')) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The place source returned an unexpected redirect.',
      );
    }
    if (response.bodyBytes.length > 5 * 1024 * 1024) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The place source response exceeded the safe size limit.',
      );
    }
    final parsed = _parser.parse(
      response.body,
      checkedAt: DateTime.now().toUtc(),
    );
    if (!parsed.structurallyValid) {
      throw const PlaceSourceException(
        'place_source_unavailable',
        'The active place calibration no longer matches the response.',
      );
    }
    return parsed.places
        .map(
          (place) => place.copyWith(
            categoryIds: {...place.categoryIds, categoryId}.toList(),
            evidenceCategoryId: categoryId,
          ),
        )
        .toList(growable: false);
  }

  void close() => _session.close();
}

class _RequestRateGate {
  int _requestsPerMinute = 30;
  int _burst = 6;
  double _tokens = 6;
  DateTime _lastRefill = DateTime.now();
  Future<void> _tail = Future<void>.value();

  void configure({required int requestsPerMinute, required int burst}) {
    _refill();
    _requestsPerMinute = requestsPerMinute.clamp(1, 300);
    _burst = burst.clamp(1, 30);
    _tokens = _tokens.clamp(0, _burst.toDouble());
  }

  Future<void> acquire() {
    final turn = _tail.then((_) => _acquireOne());
    _tail = turn.catchError((_) {});
    return turn;
  }

  Future<void> _acquireOne() async {
    while (true) {
      _refill();
      if (_tokens >= 1) {
        _tokens -= 1;
        return;
      }
      final seconds = (1 - _tokens) * 60 / _requestsPerMinute;
      await Future<void>.delayed(
        Duration(milliseconds: (seconds * 1000).ceil().clamp(10, 60000)),
      );
    }
  }

  void _refill() {
    final now = DateTime.now();
    final elapsedSeconds = now.difference(_lastRefill).inMicroseconds / 1000000;
    _lastRefill = now;
    _tokens = (_tokens + elapsedSeconds * _requestsPerMinute / 60).clamp(
      0,
      _burst.toDouble(),
    );
  }
}
