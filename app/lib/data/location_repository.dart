import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';

class LocationRepository {
  LocationRepository({required this.client});

  final Client client;

  Future<List<LocationSuggestion>> suggest({
    required String query,
    double? latitude,
    double? longitude,
  }) => withAnonymousAuthentication(
    client,
    () => client.place.suggest(
      query: query,
      latitude: latitude,
      longitude: longitude,
      countryCode: 'SA',
    ),
  ).timeout(const Duration(seconds: 12));

  Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => withAnonymousAuthentication(
    client,
    () => client.place.reverseGeocode(
      latitude: latitude,
      longitude: longitude,
      languageCode: languageCode,
    ),
  ).timeout(const Duration(seconds: 8));

  /// The same reverse-geocoding read, with the address's parts kept apart.
  Future<ReverseGeocodeResult> reverseGeocodeDetails({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => withAnonymousAuthentication(
    client,
    () => client.place.reverseGeocodeDetails(
      latitude: latitude,
      longitude: longitude,
      languageCode: languageCode,
    ),
  ).timeout(const Duration(seconds: 8));
}
