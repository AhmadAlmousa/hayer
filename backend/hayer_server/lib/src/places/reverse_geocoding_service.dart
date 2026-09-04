import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

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
    Uri? endpoint,
    DateTime Function()? clock,
  }) : _client = client ?? http.Client(),
       endpoint =
           endpoint ?? Uri.https('nominatim.openstreetmap.org', '/reverse'),
       _clock = clock ?? DateTime.now;

  final http.Client _client;
  final Duration minimumInterval;
  final Duration cacheDuration;
  final Uri endpoint;
  final DateTime Function() _clock;
  final Map<String, _CachedAddress> _cache = {};
  final Map<String, Future<String>> _inFlight = {};
  Future<void> _requestQueue = Future.value();
  DateTime? _nextRequestAt;

  Future<String> reverse({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) {
    final key =
        '${latitude.toStringAsFixed(4)}:'
        '${longitude.toStringAsFixed(4)}:$languageCode';
    final cached = _cache[key];
    if (cached != null && cached.expiresAt.isAfter(_clock())) {
      return Future.value(cached.address);
    }
    return _inFlight.putIfAbsent(key, () async {
      try {
        final address = await _enqueueRequest(
          latitude: latitude,
          longitude: longitude,
          languageCode: languageCode,
        );
        _cache[key] = _CachedAddress(
          address: address,
          expiresAt: _clock().add(cacheDuration),
        );
        return address;
      } finally {
        unawaited(_inFlight.remove(key));
      }
    });
  }

  Future<String> _enqueueRequest({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) {
    final completer = Completer<String>();
    _requestQueue = _requestQueue.then((_) async {
      final next = _nextRequestAt;
      if (next != null) {
        final delay = next.difference(_clock());
        if (delay > Duration.zero) await Future<void>.delayed(delay);
      }
      _nextRequestAt = _clock().add(minimumInterval);
      try {
        completer.complete(
          await _request(
            latitude: latitude,
            longitude: longitude,
            languageCode: languageCode,
          ),
        );
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<String> _request({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    final uri = endpoint.replace(
      queryParameters: {
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
      response = await _client
          .get(
            uri,
            headers: const {
              'Accept': 'application/json',
              'User-Agent':
                  'Hayer/0.1 (+https://hayer.almou.sa; support@almou.sa)',
              'Referer': 'https://hayer.almou.sa/',
            },
          )
          .timeout(const Duration(seconds: 8));
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
      return _formatAddress(body);
    } on FormatException {
      throw const ReverseGeocodingException(
        'The address service returned unreadable data.',
      );
    }
  }

  String _formatAddress(Map<String, dynamic> body) {
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
    if (unique.isNotEmpty) return unique.join(', ');
    final displayName = body['display_name'];
    if (displayName is String && displayName.trim().isNotEmpty) {
      return displayName.trim();
    }
    throw const ReverseGeocodingException(
      'No readable address was found for this location.',
    );
  }

  String? _first(Map<String, dynamic> values, List<String> keys) {
    for (final key in keys) {
      final value = values[key];
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }
}

class _CachedAddress {
  const _CachedAddress({required this.address, required this.expiresAt});

  final String address;
  final DateTime expiresAt;
}
