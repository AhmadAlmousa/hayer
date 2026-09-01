import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../security/rate_limiter.dart';

class PlaceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

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

  String _country(String value) {
    final normalized = value.trim().toUpperCase();
    const supported = {'SA', 'AE', 'KW', 'QA', 'BH', 'OM'};
    return supported.contains(normalized) ? normalized : 'SA';
  }
}
