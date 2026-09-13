import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'bounded_provider_http.dart';
import 'place_source.dart';
import 'provider_admission.dart';
import 'provider_operation.dart';

class ReverseGeocodingException implements Exception {
  const ReverseGeocodingException(this.message);

  final String message;

  @override
  String toString() => 'ReverseGeocodingException: $message';
}

/// Resolves coordinates through the public OpenStreetMap Nominatim service.
///
/// Requests are serialized and spaced apart to respect the public service's
/// usage policy. Results are cached so nearby repeat lookups do not leave the
/// Hayer backend.
class ReverseGeocodingService {
  ReverseGeocodingService({
    http.Client? client,
    this.minimumInterval = const Duration(seconds: 1),
    this.cacheDuration = const Duration(minutes: 30),
    this.maximumCacheEntries = 2000,
    this.lookupTimeout = const Duration(seconds: 8),
    Uri? endpoint,
    DateTime Function()? clock,
  }) : _transport = BoundedProviderHttp(
         client: client,
         admission: ProviderAdmission(
           maximumConcurrent: 1,
           maximumQueued: 8,
           maximumConcurrentPerOperation: 1,
           requestsPerMinute: 60,
           burst: 1,
           minimumInterval: minimumInterval,
         ),
       ),
       endpoint =
           endpoint ?? Uri.https('nominatim.openstreetmap.org', '/reverse'),
       _clock = clock ?? DateTime.now;

  static final shared = ReverseGeocodingService(
    endpoint: Uri.parse(
      Platform.environment['HAYER_GEOCODER_ENDPOINT'] ??
          'https://nominatim.openstreetmap.org/reverse',
    ),
  );

  final BoundedProviderHttp _transport;
  final int maximumCacheEntries;
  final Duration lookupTimeout;
  final Duration minimumInterval;
  final Duration cacheDuration;
  final Uri endpoint;
  final DateTime Function() _clock;
  final LinkedHashMap<String, _CachedLocation> _cache = LinkedHashMap();
  final Map<String, Future<ResolvedLocation>> _inFlight = {};
  int get cachedLocations => _cache.length;
  int get pendingLookups => _inFlight.length;
  ProviderAdmission get admission => _transport.admission;

  Future<String> reverse({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async => (await reverseDetails(
    latitude: latitude,
    longitude: longitude,
    languageCode: languageCode,
  )).formattedAddress;

  Future<ResolvedLocation> reverseDetails({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) {
    final key =
        '${latitude.toStringAsFixed(4)}:'
        '${longitude.toStringAsFixed(4)}:$languageCode';
    _cache.removeWhere((_, value) => !value.expiresAt.isAfter(_clock()));
    final cached = _cache.remove(key);
    if (cached != null && cached.expiresAt.isAfter(_clock())) {
      _cache[key] = cached;
      return Future.value(cached.location);
    }
    final existing = _inFlight[key];
    if (existing != null) return existing;
    if (_inFlight.length >= 9) {
      return Future.error(
        const ReverseGeocodingException(
          'The address service is busy. Please try again shortly.',
        ),
      );
    }
    return _inFlight.putIfAbsent(key, () async {
      try {
        final location = await ProviderOperation.run(
          () => _request(
            latitude: latitude,
            longitude: longitude,
            languageCode: languageCode,
          ),
          timeout: lookupTimeout,
          maximumRequests: 4,
        );
        _cache[key] = _CachedLocation(
          location: location,
          expiresAt: _clock().add(cacheDuration),
        );
        while (_cache.length > maximumCacheEntries) {
          _cache.remove(_cache.keys.first);
        }
        return location;
      } on PlaceSourceException catch (error) {
        throw ReverseGeocodingException(
          error.code == 'rate_limited'
              ? 'The address service is busy. Please try again shortly.'
              : 'The address lookup timed out or exceeded its limits.',
        );
      } finally {
        unawaited(_inFlight.remove(key));
      }
    });
  }

  Future<ResolvedLocation> _request({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    final uri = endpoint.replace(
      queryParameters: {
        ...endpoint.queryParameters,
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'format': 'jsonv2',
        'addressdetails': '1',
        'zoom': '18',
        'accept-language': languageCode,
      },
    );
    late final http.Response response;
    try {
      response = await _transport.get(
        uri,
        maximumBytes: 128 * 1024,
        timeout: lookupTimeout,
        validate: (target) {
          if (target.scheme != 'https' ||
              target.userInfo.isNotEmpty ||
              target.origin != endpoint.origin) {
            throw const ReverseGeocodingException(
              'The address service endpoint or redirect is invalid.',
            );
          }
        },
        headers: const {
          'Accept': 'application/json',
          'User-Agent': 'Hayer/0.1 (+https://hayer.almou.sa; support@almou.sa)',
          'Referer': 'https://hayer.almou.sa/',
        },
      );
    } on TimeoutException {
      throw const ReverseGeocodingException('The address lookup timed out.');
    } on http.ClientException {
      throw const ReverseGeocodingException(
        'The address service could not be reached.',
      );
    }
    if (response.statusCode != 200 || response.bodyBytes.length > 128 * 1024) {
      throw const ReverseGeocodingException(
        'The address service returned an invalid response.',
      );
    }
    try {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      if (body is! Map<String, dynamic>) {
        throw const FormatException('Expected a JSON object.');
      }
      return _location(body);
    } on FormatException {
      throw const ReverseGeocodingException(
        'The address service returned unreadable data.',
      );
    }
  }

  ResolvedLocation _location(Map<String, dynamic> body) {
    final rawAddress = body['address'];
    final address = rawAddress is Map
        ? rawAddress.cast<String, dynamic>()
        : const <String, dynamic>{};
    final road = _first(address, const [
      'road',
      'pedestrian',
      'residential',
      'footway',
      'neighbourhood',
    ]);
    final houseNumber = _first(address, const ['house_number']);
    final locality = _first(address, const [
      'suburb',
      'neighbourhood',
      'quarter',
      'city_district',
    ]);
    final city = _first(address, const [
      'city',
      'town',
      'village',
      'municipality',
      'county',
    ]);
    final state = _first(address, const ['state', 'region']);
    final country = _first(address, const ['country']);
    final street = [
      houseNumber,
      road,
    ].whereType<String>().where((value) => value.isNotEmpty).join(' ');
    final values = <String>[
      if (street.isNotEmpty) street,
      ?locality,
      ?city,
      ?state,
      ?country,
    ];
    final unique = <String>[];
    for (final value in values) {
      if (!unique.any((item) => item.toLowerCase() == value.toLowerCase())) {
        unique.add(value);
      }
    }
    final formattedAddress = unique.isNotEmpty
        ? unique.join(', ')
        : body['display_name'] is String &&
              (body['display_name'] as String).trim().isNotEmpty
        ? (body['display_name'] as String).trim()
        : null;
    if (formattedAddress != null) {
      return ResolvedLocation(
        formattedAddress: formattedAddress,
        city: city,
        region: state,
        countryCode: _first(address, const ['country_code'])?.toUpperCase(),
      );
    }
    throw const ReverseGeocodingException(
      'No readable address was found for this location.',
    );
  }

  void close() => _transport.close();

  String? _first(Map<String, dynamic> values, List<String> keys) {
    for (final key in keys) {
      final value = values[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }
}

class ResolvedLocation {
  const ResolvedLocation({
    required this.formattedAddress,
    this.city,
    this.region,
    this.countryCode,
  });

  final String formattedAddress;
  final String? city;
  final String? region;
  final String? countryCode;
}

class _CachedLocation {
  const _CachedLocation({required this.location, required this.expiresAt});

  final ResolvedLocation location;
  final DateTime expiresAt;
}
