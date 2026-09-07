import 'google_response.dart';

class RouteEstimateData {
  const RouteEstimateData({
    required this.distanceMeters,
    required this.durationSeconds,
    required this.trafficAware,
    required this.checkedAt,
  });

  final int distanceMeters;
  final int durationSeconds;
  final bool trafficAware;
  final DateTime checkedAt;
}

class DirectionsParser {
  const DirectionsParser();

  RouteEstimateData parse(String body, {required DateTime checkedAt}) {
    final response = GoogleResponse.parse(body);
    final routes = response.at(const [0, 1]);
    if (routes is! List) {
      throw const FormatException('Directions routes are missing.');
    }
    final estimates = <RouteEstimateData>[];
    for (final route in routes) {
      final distance = response.doubleAt(const [0, 2, 0], from: route);
      final normalDuration = response.doubleAt(const [0, 3, 0], from: route);
      final trafficDuration = response.doubleAt(
        const [0, 10, 0, 0],
        from: route,
      );
      if (distance == null ||
          normalDuration == null ||
          !distance.isFinite ||
          !normalDuration.isFinite ||
          distance <= 0 ||
          normalDuration <= 0) {
        continue;
      }
      final hasTraffic =
          trafficDuration != null &&
          trafficDuration.isFinite &&
          trafficDuration > 0;
      estimates.add(
        RouteEstimateData(
          distanceMeters: distance.round(),
          durationSeconds: (hasTraffic ? trafficDuration : normalDuration)
              .round(),
          trafficAware: hasTraffic,
          checkedAt: checkedAt.toUtc(),
        ),
      );
    }
    if (estimates.isEmpty) {
      throw const FormatException('No usable directions route was returned.');
    }
    estimates.sort(
      (left, right) => left.durationSeconds.compareTo(right.durationSeconds),
    );
    return estimates.first;
  }
}
