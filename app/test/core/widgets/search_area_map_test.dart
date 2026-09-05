import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/search_area_map.dart';

void main() {
  test('search radius polygon is closed and follows the requested radius', () {
    final polygon = searchRadiusPolygon(24.7136, 46.6753, 3000);

    expect(polygon.length, 73);
    expect(polygon.first.latitude, closeTo(polygon.last.latitude, 1e-10));
    expect(polygon.first.longitude, closeTo(polygon.last.longitude, 1e-10));
    expect(
      _distanceMeters(
        24.7136,
        46.6753,
        polygon.first.latitude,
        polygon.first.longitude,
      ),
      closeTo(3000, 1),
    );
  });

  test('radius handle is placed on the requested circle edge', () {
    final handle = radiusHandlePoint(24.7136, 46.6753, 3000);

    expect(
      distanceMeters(
        24.7136,
        46.6753,
        handle.latitude,
        handle.longitude,
      ),
      closeTo(3000, 1),
    );
    expect(handle.longitude, greaterThan(46.6753));
  });

  test('radius bounds contain the entire rendered circle', () {
    final polygon = searchRadiusPolygon(24.7136, 46.6753, 10000);
    final bounds = searchRadiusBounds(24.7136, 46.6753, 10000);

    expect(polygon.every(bounds.contains), isTrue);
    expect(bounds.southwest.latitude, lessThan(24.7136));
    expect(bounds.northeast.latitude, greaterThan(24.7136));
  });
}

double _distanceMeters(
  double latitudeA,
  double longitudeA,
  double latitudeB,
  double longitudeB,
) {
  const earthRadius = 6371000.0;
  final latA = latitudeA * math.pi / 180;
  final latB = latitudeB * math.pi / 180;
  final deltaLat = (latitudeB - latitudeA) * math.pi / 180;
  final deltaLon = (longitudeB - longitudeA) * math.pi / 180;
  final haversine =
      math.sin(deltaLat / 2) * math.sin(deltaLat / 2) +
      math.cos(latA) *
          math.cos(latB) *
          math.sin(deltaLon / 2) *
          math.sin(deltaLon / 2);
  return earthRadius *
      2 *
      math.atan2(math.sqrt(haversine), math.sqrt(1 - haversine));
}
