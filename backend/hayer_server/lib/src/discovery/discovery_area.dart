import 'dart:math' as math;

import '../generated/protocol.dart';

/// One committed Discover area snapped to its canonical harvest cell.
final class DiscoveryHarvestCell {
  const DiscoveryHarvestCell({
    required this.countryCode,
    required this.row,
    required this.column,
    required this.latitude,
    required this.longitude,
    required this.radiusMeters,
  });

  final String countryCode;

  /// Kilometres north of the equator, rounded.
  final int row;

  /// Kilometres east of the prime meridian along [row]'s latitude, rounded.
  final int column;

  final double latitude;
  final double longitude;
  final int radiusMeters;

  String get cellId => '$row:$column';

  /// The footprint claimed for the harvest: the square extending
  /// [radiusMeters] from the centre in each direction.
  DiscoverViewport get bounds {
    final latitudeSpan = radiusMeters / DiscoveryArea.metresPerDegreeLatitude;
    final longitudeSpan =
        radiusMeters / DiscoveryArea.metresPerDegreeLongitude(latitude);
    return DiscoverViewport(
      south: latitude - latitudeSpan,
      west: longitude - longitudeSpan,
      north: latitude + latitudeSpan,
      east: longitude + longitudeSpan,
    );
  }
}

/// Validates Discover areas and snaps them to harvest cells.
///
/// Cells use a local equirectangular projection: one degree of latitude is
/// 110,574 m, and one degree of longitude is 111,320 m times the cosine of the
/// cell row's own latitude. The centre snaps to the nearest kilometre north,
/// then to the nearest kilometre east along that row, so every camera whose
/// centre rounds to the same row and column shares a cell.
abstract final class DiscoveryArea {
  static const metresPerDegreeLatitude = 110574.0;
  static const metresPerDegreeLongitudeAtEquator = 111320.0;
  static const gridMetres = 1000.0;

  /// Harvest radii: the viewport's half-diagonal rounded up to the next
  /// bucket, clamped at the largest.
  static const radiusBucketsMeters = [1000, 2000, 5000, 10000];

  static double metresPerDegreeLongitude(double latitude) =>
      metresPerDegreeLongitudeAtEquator * math.cos(latitude * math.pi / 180);

  static void validateViewport(DiscoverViewport viewport) {
    if (!viewport.south.isFinite ||
        !viewport.west.isFinite ||
        !viewport.north.isFinite ||
        !viewport.east.isFinite ||
        viewport.south < -90 ||
        viewport.north > 90 ||
        viewport.west < -180 ||
        viewport.east > 180 ||
        viewport.south >= viewport.north ||
        viewport.west >= viewport.east ||
        viewport.north - viewport.south > 15 ||
        viewport.east - viewport.west > 15) {
      throw ApiException(
        code: 'invalid_area',
        message: 'The map bounds are invalid or too large.',
      );
    }
  }

  /// Resolves the supported country from the viewport centre. Kuwait, Qatar
  /// and Bahrain are checked before the larger boxes that overlap them.
  static String? countryFor(DiscoverViewport viewport) {
    final latitude = (viewport.south + viewport.north) / 2;
    final longitude = (viewport.west + viewport.east) / 2;
    bool inside(double south, double north, double west, double east) =>
        latitude >= south &&
        latitude <= north &&
        longitude >= west &&
        longitude <= east;
    if (inside(28.3, 30.2, 46.2, 48.8)) return 'KW';
    if (inside(24.3, 26.3, 50.6, 52.0)) return 'QA';
    if (inside(25.5, 26.4, 50.3, 51.0)) return 'BH';
    if (inside(22.5, 26.5, 50.5, 56.5)) return 'AE';
    if (inside(16.5, 26.5, 51.5, 60.0)) return 'OM';
    if (inside(16.0, 32.3, 34.4, 55.7)) return 'SA';
    return null;
  }

  /// Validates [viewport] and an optional country [hint], returning the
  /// supported country the viewport centre lies in.
  static String resolveCountry(DiscoverViewport viewport, String? hint) {
    validateViewport(viewport);
    final countryCode = countryFor(viewport);
    if (countryCode == null) {
      throw ApiException(
        code: 'unsupported_area',
        message: 'Discover currently supports GCC areas only.',
      );
    }
    final normalized = hint?.trim().toUpperCase();
    if (normalized != null &&
        normalized.isNotEmpty &&
        normalized != countryCode) {
      throw ApiException(
        code: 'unsupported_area',
        message: 'The supplied country does not match this map area.',
      );
    }
    return countryCode;
  }

  static DiscoveryHarvestCell cell(
    DiscoverViewport viewport, {
    required String countryCode,
  }) {
    final centreLatitude = (viewport.south + viewport.north) / 2;
    final centreLongitude = (viewport.west + viewport.east) / 2;
    final row = (centreLatitude * metresPerDegreeLatitude / gridMetres).round();
    final latitude = row * gridMetres / metresPerDegreeLatitude;
    final longitudeMetres = metresPerDegreeLongitude(latitude);
    final column = (centreLongitude * longitudeMetres / gridMetres).round();
    final longitude = column * gridMetres / longitudeMetres;
    final halfDiagonal = haversineMeters(
      centreLatitude,
      centreLongitude,
      viewport.north,
      viewport.east,
    );
    final radius = radiusBucketsMeters.firstWhere(
      (bucket) => bucket >= halfDiagonal,
      orElse: () => radiusBucketsMeters.last,
    );
    return DiscoveryHarvestCell(
      countryCode: countryCode,
      row: row,
      column: column,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radius,
    );
  }

  static double haversineMeters(
    double latitudeA,
    double longitudeA,
    double latitudeB,
    double longitudeB,
  ) {
    const earthRadius = 6371008.8;
    double radians(double degrees) => degrees * math.pi / 180;
    final dLatitude = radians(latitudeB - latitudeA);
    final dLongitude = radians(longitudeB - longitudeA);
    final a =
        math.pow(math.sin(dLatitude / 2), 2) +
        math.cos(radians(latitudeA)) *
            math.cos(radians(latitudeB)) *
            math.pow(math.sin(dLongitude / 2), 2);
    return 2 * earthRadius * math.asin(math.min(1, math.sqrt(a)));
  }
}
