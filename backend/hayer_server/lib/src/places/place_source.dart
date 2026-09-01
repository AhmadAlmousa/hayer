import 'place_candidate.dart';

abstract interface class PlaceSource {
  Future<List<PlaceCandidate>> search({
    required String query,
    required String categoryId,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int desiredCount,
    required String language,
    required String countryCode,
  });
}

class PlaceSourceException implements Exception {
  const PlaceSourceException(this.code, this.message, {this.cause});
  final String code;
  final String message;
  final Object? cause;

  @override
  String toString() => 'PlaceSourceException($code, $message)';
}
