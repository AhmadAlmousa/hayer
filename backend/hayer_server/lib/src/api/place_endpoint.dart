import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../discovery/discovery_contract.dart';
import '../places/place_detail_resolver.dart';
import '../places/poi_issue_report_service.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/reverse_geocoding_service.dart';
import '../places/route_estimate_policy_service.dart';
import '../security/rate_limiter.dart';

class PlaceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _geocoder = ReverseGeocodingService.shared;

  /// Shared place details for Swipe and Discover. Available whether or not
  /// Discover is enabled.
  Future<PlaceDetailResult> details(
    Session session, {
    required PoiIdentity identity,
    String? sessionId,
  }) => PlaceDetailResolver.resolve(
    session,
    identity: identity,
    sessionId: sessionId,
  );

  Future<String> reportCatalogIssue(
    Session session, {
    required int catalogId,
    required PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) async {
    await DiscoveryContract.requireEnabled(session);
    return PoiIssueReportService.reportCatalogPlace(
      session,
      catalogId: catalogId,
      issueType: issueType,
      details: details,
      idempotencyKey: idempotencyKey,
    );
  }

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
      return await places.search.suggest(
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
  }) async => (await _reverseGeocode(
    session,
    latitude: latitude,
    longitude: longitude,
    languageCode: languageCode,
  )).formattedAddress;

  Future<ReverseGeocodeResult> reverseGeocodeDetails(
    Session session, {
    required double latitude,
    required double longitude,
    String languageCode = 'en',
  }) async {
    final location = await _reverseGeocode(
      session,
      latitude: latitude,
      longitude: longitude,
      languageCode: languageCode,
    );
    return ReverseGeocodeResult(
      formattedAddress: location.formattedAddress,
      locality: location.locality,
      city: location.city,
      region: location.region,
      countryCode: location.countryCode,
    );
  }

  Future<ResolvedLocation> _reverseGeocode(
    Session session, {
    required double latitude,
    required double longitude,
    required String languageCode,
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
      return await _geocoder.reverseDetails(
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

  Future<RouteEstimate> routeEstimate(
    Session session, {
    required String sessionId,
    required String placeId,
    double? originLatitude,
    double? originLongitude,
  }) async {
    if ((originLatitude == null) != (originLongitude == null)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Both origin coordinates are required.',
      );
    }
    if (originLatitude != null &&
        (!_validLatitude(originLatitude) ||
            !_validLongitude(originLongitude!))) {
      throw ApiException(
        code: 'bad_request',
        message: 'The location coordinates are invalid.',
      );
    }
    final userId = session.authenticated!.userIdentifier;
    await RateLimiter.check(
      session,
      operation: 'route-estimate',
      subject: userId,
      limit: 60,
      window: const Duration(minutes: 1),
    );
    final sessionRow = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    if (sessionRow == null) {
      throw ApiException(code: 'not_found', message: 'Session not found.');
    }
    final membership = await ParticipantRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.userId.equals(userId),
    );
    if (membership == null) {
      throw ApiException(
        code: 'forbidden',
        message: 'You are not a participant in this session.',
      );
    }
    final policy = await RouteEstimatePolicyService.load(session);
    if (!policy.enabled) {
      throw ApiException(
        code: 'route_estimates_disabled',
        message: 'Route estimates are disabled.',
      );
    }
    if (originLatitude != null &&
        (sessionRow.mode != SessionMode.multiplayer ||
            !policy.allowParticipantLocation)) {
      throw ApiException(
        code: 'personal_location_disabled',
        message: 'Personal route origins are disabled for this session.',
      );
    }
    final place = await SessionPlaceRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.placeId.equals(placeId),
    );
    if (place == null) {
      throw ApiException(
        code: 'not_found',
        message: 'Place not found in this session.',
      );
    }
    final settings = await RouteEstimatePolicyService.settings(session);
    try {
      final services = await PlaceServices.forSession(session);
      final estimate = await services.routes.estimate(
        originLatitude: originLatitude ?? sessionRow.anchorLatitude,
        originLongitude: originLongitude ?? sessionRow.anchorLongitude,
        destinationLatitude: place.snapshot.latitude,
        destinationLongitude: place.snapshot.longitude,
        countryCode: sessionRow.countryCode,
        cacheMinutes: policy.cacheMinutes,
        requestsPerMinute: settings?.routeRequestsPerMinute ?? 30,
        burst: settings?.routeBurst ?? 6,
      );
      return RouteEstimate(
        distanceMeters: estimate.distanceMeters,
        durationSeconds: estimate.durationSeconds,
        trafficAware: estimate.trafficAware,
        checkedAt: estimate.checkedAt,
      );
    } on PlaceSourceException catch (error) {
      throw ApiException(code: error.code, message: error.message);
    }
  }

  Future<String> reportIssue(
    Session session, {
    required String sessionId,
    required String placeId,
    required PoiIssueType issueType,
    String? details,
    required String idempotencyKey,
  }) => PoiIssueReportService.reportSessionPlace(
    session,
    sessionId: sessionId,
    placeId: placeId,
    issueType: issueType,
    details: details,
    idempotencyKey: idempotencyKey,
  );

  String _country(String value) {
    final normalized = value.trim().toUpperCase();
    const supported = {'SA', 'AE', 'KW', 'QA', 'BH', 'OM'};
    return supported.contains(normalized) ? normalized : 'SA';
  }

  bool _validLatitude(double value) =>
      value.isFinite && value >= -90 && value <= 90;

  bool _validLongitude(double value) =>
      value.isFinite && value >= -180 && value <= 180;
}
