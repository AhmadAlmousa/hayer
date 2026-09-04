import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/reverse_geocoding_service.dart';
import '../security/rate_limiter.dart';

class PlaceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _geocoder = ReverseGeocodingService();

  Future<List<LocationSuggestion>> suggest(
    Session session, {
    required String query,
    double? latitude,
    double? longitude,
    String countryCode = 'SA',
  }) async {
    final input = query.trim();
    if (input.length < 3) return const [];
    if (input.length > 120) {
      throw ApiException(
        code: 'bad_request',
        message: 'The search text is too long.',
      );
    }
    await RateLimiter.check(
      session,
      operation: 'place-suggest',
      subject: session.authenticated!.userIdentifier,
      limit: 30,
      window: const Duration(minutes: 1),
    );
    try {
      final places = await PlaceServices.forSession(session);
      return places.search.suggest(
        input: input,
        latitude: latitude,
        longitude: longitude,
        countryCode: _country(countryCode),
      );
    } on PlaceSourceException catch (error) {
      throw ApiException(code: error.code, message: error.message);
    }
  }

  Future<String> reverseGeocode(
    Session session, {
    required double latitude,
    required double longitude,
    String languageCode = 'en',
  }) async {
    if (!latitude.isFinite ||
        !longitude.isFinite ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      throw ApiException(
        code: 'bad_request',
        message: 'The location coordinates are invalid.',
      );
    }
    await RateLimiter.check(
      session,
      operation: 'reverse-geocode',
      subject: session.authenticated!.userIdentifier,
      limit: 10,
      window: const Duration(minutes: 1),
    );
    try {
      return await _geocoder.reverse(
        latitude: latitude,
        longitude: longitude,
        languageCode: const {'ar', 'en'}.contains(languageCode)
            ? languageCode
            : 'en',
      );
    } on ReverseGeocodingException catch (error) {
      throw ApiException(code: 'location_unavailable', message: error.message);
    }
  }

  String _country(String value) {
    final normalized = value.trim().toUpperCase();
    const supported = {'SA', 'AE', 'KW', 'QA', 'BH', 'OM'};
    return supported.contains(normalized) ? normalized : 'SA';
  }
}
