import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/domain/discovery_area.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';

DiscoveryViewport _box(double south, double west, double north, double east) =>
    DiscoveryViewport.tryCreate(
      south: south,
      west: west,
      north: north,
      east: east,
    )!;

void main() {
  group('cameras and viewports', () {
    test('a camera shows the area its map covers at that zoom', () {
      // At zoom 0 a map 512 pixels wide spans the world from east to west.
      final world = discoveryViewportForCamera(
        (latitude: 0, longitude: 0, zoom: 0),
        width: 512,
        height: 256,
      )!;

      expect(world.west, -180);
      expect(world.east, 180);
      expect(world.south, closeTo(-66.51326, 1e-4));
      expect(world.north, closeTo(66.51326, 1e-4));
    });

    test('each zoom level halves the span', () {
      DiscoveryViewport at(double zoom) => discoveryViewportForCamera(
        (latitude: 24.7, longitude: 46.7, zoom: zoom),
        width: 400,
        height: 800,
      )!;

      expect(
        at(13).east - at(13).west,
        closeTo((at(12).east - at(12).west) / 2, 1e-4),
      );
    });

    test('the camera for a viewport shows all of it and fills one axis', () {
      final riyadh = _box(24.6, 46.6, 24.8, 46.8);

      final camera = discoveryCameraForViewport(
        riyadh,
        width: 400,
        height: 800,
      );
      final shown = discoveryViewportForCamera(
        camera,
        width: 400,
        height: 800,
      )!;

      // A tall map is limited by the viewport's width.
      expect(shown.west, closeTo(riyadh.west, 1e-4));
      expect(shown.east, closeTo(riyadh.east, 1e-4));
      expect(shown.south, lessThan(riyadh.south));
      expect(shown.north, greaterThan(riyadh.north));
      expect(discoveryViewportShows(shown, riyadh), isTrue);
    });

    test('a map without a size, or a view across the antimeridian, has no '
        'viewport', () {
      expect(
        discoveryViewportForCamera(
          (latitude: 24.7, longitude: 46.7, zoom: 12),
          width: 0,
          height: 800,
        ),
        isNull,
      );
      expect(
        discoveryViewportForCamera(
          (latitude: 0, longitude: 179.9, zoom: 5),
          width: 400,
          height: 400,
        ),
        isNull,
      );
    });
  });

  group('whether a map still shows the committed area', () {
    final committed = _box(24.6, 46.6, 24.8, 46.8);

    test('the camera fitted to it does', () {
      expect(
        discoveryViewportShows(_box(24.6, 46.5, 24.8, 46.9), committed),
        isTrue,
      );
    });

    test('a camera settling a hair off does', () {
      expect(
        discoveryViewportShows(
          _box(24.60001, 46.59999, 24.80001, 46.80001),
          committed,
        ),
        isTrue,
      );
    });

    test('a pan does not', () {
      expect(
        discoveryViewportShows(_box(24.65, 46.6, 24.85, 46.8), committed),
        isFalse,
      );
    });

    test('zooming in does not', () {
      expect(
        discoveryViewportShows(_box(24.65, 46.65, 24.75, 46.75), committed),
        isFalse,
      );
    });

    test('zooming well out does not', () {
      expect(
        discoveryViewportShows(_box(24.4, 46.4, 25.0, 47.0), committed),
        isFalse,
      );
    });
  });

  test('straight-line distance follows the Earth', () {
    const riyadh = (latitude: 24.0, longitude: 46.0);

    // A degree of latitude is about 111.2 km.
    expect(
      discoveryStraightLineMeters(riyadh, (latitude: 25.0, longitude: 46.0)),
      closeTo(111195, 50),
    );
    expect(discoveryStraightLineMeters(riyadh, riyadh), 0);
  });
}
