import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';
import 'location_warmup.dart';

class RouteEstimateRepository {
  const RouteEstimateRepository({
    required this.client,
    required this.location,
    this.storage = const FlutterSecureStorage(),
  });

  final Client client;
  final LocationWarmup location;
  final FlutterSecureStorage storage;
  static final Map<String, RouteOriginMode> _memoryOrigins = {};

  Future<RouteOriginMode?> readOrigin(String sessionId) async {
    final key = _key(sessionId);
    try {
      final value = await storage.read(key: key);
      final origin = switch (value) {
        'sessionAnchor' => RouteOriginMode.sessionAnchor,
        'participantLocation' => RouteOriginMode.participantLocation,
        _ => null,
      };
      if (origin != null) _memoryOrigins[key] = origin;
      return origin ?? _memoryOrigins[key];
    } catch (_) {
      return _memoryOrigins[key];
    }
  }

  Future<void> saveOrigin(String sessionId, RouteOriginMode origin) async {
    final key = _key(sessionId);
    _memoryOrigins[key] = origin;
    try {
      await storage.write(key: key, value: origin.name);
    } catch (_) {
      // The in-memory preference keeps this session usable when secure storage
      // is unavailable (for example, a restricted browser context).
    }
  }

  Future<bool> prepareOrigin(RouteOriginMode origin) async {
    if (origin == RouteOriginMode.sessionAnchor) return true;
    return await location.locate(requestPermission: true, refresh: true) !=
        null;
  }

  int? straightLineDistance({
    required PlaceSnapshot place,
    required RouteOriginMode origin,
  }) {
    if (origin == RouteOriginMode.sessionAnchor) return place.distanceMeters;
    final position = location.latest;
    if (position == null) return null;
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      place.latitude,
      place.longitude,
    ).round();
  }

  Future<RouteEstimate> estimate({
    required String sessionId,
    required String placeId,
    required RouteOriginMode origin,
  }) async {
    final position = origin == RouteOriginMode.participantLocation
        ? location.latest ?? await location.locate()
        : null;
    if (origin == RouteOriginMode.participantLocation && position == null) {
      throw StateError('Current location is unavailable.');
    }
    return withAnonymousAuthentication(
      client,
      () => client.place.routeEstimate(
        sessionId: sessionId,
        placeId: placeId,
        originLatitude: position?.latitude,
        originLongitude: position?.longitude,
      ),
    );
  }

  String _key(String sessionId) => 'hayer.route-origin.$sessionId';
}
