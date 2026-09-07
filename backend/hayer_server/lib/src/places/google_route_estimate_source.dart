import 'dart:async';
import 'dart:collection';

import 'calibration.dart';
import 'directions_parser.dart';
import 'directions_pb.dart';
import 'google_web_session.dart';
import 'place_source.dart';

class GoogleRouteEstimateSource {
  GoogleRouteEstimateSource({
    required this.calibration,
    required GoogleWebSession webSession,
  }) : _session = webSession,
       _pb = DirectionsPb(calibration);

  static const _maximumCacheEntries = 2000;

  final PlaceCalibration calibration;
  final GoogleWebSession _session;
  final DirectionsPb _pb;
  final DirectionsParser _parser = const DirectionsParser();
  final _RouteRequestGate _rateGate = _RouteRequestGate();
  final LinkedHashMap<String, _CachedRouteEstimate> _cache = LinkedHashMap();
  final Map<String, Future<RouteEstimateData>> _inFlight = {};

  Future<RouteEstimateData> estimate({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
    required String countryCode,
    required int cacheMinutes,
    required int requestsPerMinute,
    required int burst,
  }) {
    final key = [
      calibration.version,
      countryCode.toUpperCase(),
      originLatitude.toStringAsFixed(4),
      originLongitude.toStringAsFixed(4),
      destinationLatitude.toStringAsFixed(4),
      destinationLongitude.toStringAsFixed(4),
    ].join('|');
    final now = DateTime.now().toUtc();
    final cached = _cache.remove(key);
    if (cached != null &&
        now.difference(cached.savedAt).inMinutes < cacheMinutes) {
      _cache[key] = cached;
      return Future.value(cached.value);
    }
    return _inFlight.putIfAbsent(
      key,
      () =>
          _fetch(
                originLatitude: originLatitude,
                originLongitude: originLongitude,
                destinationLatitude: destinationLatitude,
                destinationLongitude: destinationLongitude,
                countryCode: countryCode,
                requestsPerMinute: requestsPerMinute,
                burst: burst,
              )
              .then((value) {
                _cache[key] = _CachedRouteEstimate(
                  value,
                  DateTime.now().toUtc(),
                );
                while (_cache.length > _maximumCacheEntries) {
                  _cache.remove(_cache.keys.first);
                }
                return value;
              })
              .whenComplete(() => _inFlight.remove(key)),
    );
  }

  Future<RouteEstimateData> _fetch({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
    required String countryCode,
    required int requestsPerMinute,
    required int burst,
  }) async {
    try {
      if (!_rateGate.tryAcquire(
        requestsPerMinute: requestsPerMinute,
        burst: burst,
      )) {
        throw const PlaceSourceException(
          'route_unavailable',
          'Route estimates are busy. Straight-line distance is still available.',
        );
      }
      final response = await _session.directions(
        pb: _pb.build(
          originLatitude: originLatitude,
          originLongitude: originLongitude,
          destinationLatitude: destinationLatitude,
          destinationLongitude: destinationLongitude,
        ),
        region: countryCode.toLowerCase(),
      );
      if (response.statusCode == 429) {
        throw const PlaceSourceException(
          'route_unavailable',
          'The route source rate limit was reached.',
        );
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw PlaceSourceException(
          'route_unavailable',
          'The route source returned HTTP ${response.statusCode}.',
        );
      }
      final finalUri = response.request?.url;
      if (finalUri != null &&
          (!calibration.allowedRequestHosts.contains(
                finalUri.host.toLowerCase(),
              ) ||
              finalUri.path.toLowerCase().contains('consent'))) {
        throw const PlaceSourceException(
          'route_unavailable',
          'The route source returned an unexpected redirect.',
        );
      }
      if (response.bodyBytes.length > 5 * 1024 * 1024) {
        throw const PlaceSourceException(
          'route_unavailable',
          'The route response exceeded the safe size limit.',
        );
      }
      return _parser.parse(
        response.body,
        checkedAt: DateTime.now().toUtc(),
      );
    } on PlaceSourceException {
      rethrow;
    } on TimeoutException catch (error) {
      throw PlaceSourceException(
        'route_unavailable',
        'The route estimate timed out.',
        cause: error,
      );
    } catch (error) {
      throw PlaceSourceException(
        'route_unavailable',
        'The route estimate is temporarily unavailable.',
        cause: error,
      );
    }
  }
}

class _CachedRouteEstimate {
  const _CachedRouteEstimate(this.value, this.savedAt);

  final RouteEstimateData value;
  final DateTime savedAt;
}

class _RouteRequestGate {
  int _requestsPerMinute = 30;
  int _burst = 6;
  double _tokens = 6;
  DateTime _lastRefill = DateTime.now();

  bool tryAcquire({required int requestsPerMinute, required int burst}) {
    _refill();
    _requestsPerMinute = requestsPerMinute.clamp(1, 300);
    _burst = burst.clamp(1, 30);
    _tokens = _tokens.clamp(0, _burst.toDouble());
    if (_tokens < 1) return false;
    _tokens -= 1;
    return true;
  }

  void _refill() {
    final now = DateTime.now();
    final seconds = now.difference(_lastRefill).inMicroseconds / 1000000;
    _lastRefill = now;
    _tokens = (_tokens + seconds * _requestsPerMinute / 60).clamp(
      0,
      _burst.toDouble(),
    );
  }
}
