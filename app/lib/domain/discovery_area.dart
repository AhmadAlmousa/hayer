import 'dart:math' as math;

import 'discovery_url_query.dart';

/// The width, in logical pixels, of the whole world at zoom 0 on a MapLibre
/// map.
const discoveryMapTileSize = 512.0;

/// Where Discover opens with neither a permitted location nor a remembered
/// area: central Riyadh, at city scale.
const DiscoveryPoint discoveryDefaultCenter = (
  latitude: 24.7136,
  longitude: 46.6753,
);
const discoveryDefaultZoom = 12.0;

/// The neighbourhood scale Discover opens at around a device location.
const discoveryLocationZoom = 14.0;

/// A search box centered on [center] with the requested half-span in metres.
DiscoveryViewport? discoveryViewportAround(
  DiscoveryPoint center, {
  double radiusMeters = 500,
}) {
  final latitudeSpan = radiusMeters / 110574;
  final longitudeSpan =
      radiusMeters /
      (111320 * math.cos(center.latitude * math.pi / 180).abs().clamp(.2, 1));
  return DiscoveryViewport.tryCreate(
    south: center.latitude - latitudeSpan,
    west: center.longitude - longitudeSpan,
    north: center.latitude + latitudeSpan,
    east: center.longitude + longitudeSpan,
  );
}

typedef DiscoveryPoint = ({double latitude, double longitude});
typedef DiscoveryCamera = ({double latitude, double longitude, double zoom});

// The furthest latitude from the equator Web Mercator can show.
const _maxMercatorLatitude = 85.05112878;

/// The viewport a north-up map of [width] by [height] logical pixels shows
/// with [camera].
///
/// Returns null when the map has no size, or when the view leaves the range a
/// viewport can hold, such as crossing the antimeridian.
DiscoveryViewport? discoveryViewportForCamera(
  DiscoveryCamera camera, {
  required double width,
  required double height,
}) {
  if (width <= 0 || height <= 0) return null;
  final world = discoveryMapTileSize * math.pow(2, camera.zoom);
  final x = _mercatorX(camera.longitude);
  final y = _mercatorY(camera.latitude);
  final halfWidth = width / 2 / world;
  final halfHeight = height / 2 / world;
  return DiscoveryViewport.tryCreate(
    south: _latitudeAt(y + halfHeight),
    west: _longitudeAt(x - halfWidth),
    north: _latitudeAt(y - halfHeight),
    east: _longitudeAt(x + halfWidth),
  );
}

/// The camera that shows all of [viewport] on a north-up map of [width] by
/// [height] logical pixels, as closely as the map's shape allows.
DiscoveryCamera discoveryCameraForViewport(
  DiscoveryViewport viewport, {
  required double width,
  required double height,
}) {
  final left = _mercatorX(viewport.west);
  final right = _mercatorX(viewport.east);
  final top = _mercatorY(viewport.north);
  final bottom = _mercatorY(viewport.south);
  final center = (
    latitude: _latitudeAt((top + bottom) / 2),
    longitude: _longitudeAt((left + right) / 2),
  );
  if (width <= 0 || height <= 0) {
    return (
      latitude: center.latitude,
      longitude: center.longitude,
      zoom: discoveryDefaultZoom,
    );
  }
  final zoom = math.min(
    _log2(width / (discoveryMapTileSize * (right - left))),
    _log2(height / (discoveryMapTileSize * (bottom - top))),
  );
  return (latitude: center.latitude, longitude: center.longitude, zoom: zoom);
}

/// Whether a map showing [visible] still shows the committed [viewport], as
/// opposed to a camera the user has since moved.
///
/// A map fitted to a viewport shows all of it and matches it along one axis,
/// so this holds for the camera the committed viewport put there. Panning or
/// zooming in leaves part of the viewport out of view, and zooming out makes
/// it a clearly smaller part of the map; both fail. Small differences from
/// rounding and camera settling are tolerated.
bool discoveryViewportShows(
  DiscoveryViewport visible,
  DiscoveryViewport viewport,
) {
  const edgeTolerance = 0.02;
  const fillTolerance = 0.05;
  final height = viewport.north - viewport.south;
  final width = viewport.east - viewport.west;
  final contains =
      visible.south <= viewport.south + height * edgeTolerance &&
      visible.north >= viewport.north - height * edgeTolerance &&
      visible.west <= viewport.west + width * edgeTolerance &&
      visible.east >= viewport.east - width * edgeTolerance;
  if (!contains) return false;
  final fill = math.max(
    height / (visible.north - visible.south),
    width / (visible.east - visible.west),
  );
  return fill >= 1 - fillTolerance;
}

/// The middle of [viewport]. Discover's areas are small enough that the
/// midpoint of the bounds serves as their centre.
DiscoveryPoint discoveryViewportCenter(DiscoveryViewport viewport) => (
  latitude: (viewport.south + viewport.north) / 2,
  longitude: (viewport.west + viewport.east) / 2,
);

/// A coarse key for the area [viewport] would ask the server to explore.
///
/// The server owns the canonical harvest cell: it snaps the centre to a 1 km
/// grid and rounds the span into a radius bucket, and it dedupes, cools down
/// and rate-limits on that. This is only the client's guard against asking
/// again for somewhere it has already asked about, so it approximates that
/// cell rather than reproducing it — being a little coarse or a little fine
/// costs at most one extra request that the server then answers from its own
/// coverage.
///
/// Deliberately not the viewport token, which changes on every pan.
String discoveryExploreKey(DiscoveryViewport viewport) {
  const gridDegrees = 0.01; // About 1.1 km of latitude.
  final centre = discoveryViewportCenter(viewport);
  final row = (centre.latitude / gridDegrees).round();
  final column = (centre.longitude / gridDegrees).round();
  // The span matters because a wider view asks for a wider harvest, and the
  // server buckets it; doubling steps track those buckets closely enough.
  final span = math.max(
    viewport.north - viewport.south,
    viewport.east - viewport.west,
  );
  final bucket = span <= 0 ? 0 : (math.log(span) / math.ln2).ceil();
  return '$row:$column:$bucket';
}

/// The great-circle distance between two points, in metres.
double discoveryStraightLineMeters(DiscoveryPoint from, DiscoveryPoint to) {
  const earthRadius = 6371008.8;
  double radians(double degrees) => degrees * math.pi / 180;
  final latitudeDelta = radians(to.latitude - from.latitude);
  final longitudeDelta = radians(to.longitude - from.longitude);
  final a =
      math.pow(math.sin(latitudeDelta / 2), 2) +
      math.cos(radians(from.latitude)) *
          math.cos(radians(to.latitude)) *
          math.pow(math.sin(longitudeDelta / 2), 2);
  return 2 * earthRadius * math.asin(math.min(1, math.sqrt(a)));
}

double _mercatorX(double longitude) => (longitude + 180) / 360;

double _mercatorY(double latitude) {
  final clamped = latitude.clamp(-_maxMercatorLatitude, _maxMercatorLatitude);
  final sine = math.sin(clamped * math.pi / 180);
  return 0.5 - math.log((1 + sine) / (1 - sine)) / (4 * math.pi);
}

double _longitudeAt(double x) => x * 360 - 180;

double _latitudeAt(double y) =>
    90 - 360 * math.atan(math.exp((y - 0.5) * 2 * math.pi)) / math.pi;

double _log2(double value) => math.log(value) / math.ln2;
