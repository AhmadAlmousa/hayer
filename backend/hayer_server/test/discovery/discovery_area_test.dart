import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

DiscoverViewport _around(double latitude, double longitude, double halfMetres) {
  final latitudeSpan = halfMetres / DiscoveryArea.metresPerDegreeLatitude;
  final longitudeSpan =
      halfMetres / DiscoveryArea.metresPerDegreeLongitude(latitude);
  return DiscoverViewport(
    south: latitude - latitudeSpan,
    west: longitude - longitudeSpan,
    north: latitude + latitudeSpan,
    east: longitude + longitudeSpan,
  );
}

Matcher _apiError(String code) =>
    isA<ApiException>().having((error) => error.code, 'code', code);

void main() {
  group('canonical harvest cells', () {
    test('snap the centre to the kilometre grid along its own row', () {
      final cell = DiscoveryArea.cell(
        _around(24.7136, 46.6753, 400),
        countryCode: 'SA',
      );
      expect(cell.cellId, '${cell.row}:${cell.column}');
      expect(
        cell.row,
        (24.7136 * DiscoveryArea.metresPerDegreeLatitude / 1000).round(),
      );
      expect(
        cell.latitude * DiscoveryArea.metresPerDegreeLatitude / 1000,
        closeTo(cell.row, 1e-9),
      );
      expect(
        cell.longitude *
            DiscoveryArea.metresPerDegreeLongitude(cell.latitude) /
            1000,
        closeTo(cell.column, 1e-9),
      );
      // The snapped centre is within half a kilometre of the camera centre
      // on each axis.
      expect(
        DiscoveryArea.haversineMeters(24.7136, 46.6753, cell.latitude, 46.6753),
        lessThanOrEqualTo(500),
      );
      expect(
        DiscoveryArea.haversineMeters(
          cell.latitude,
          46.6753,
          cell.latitude,
          cell.longitude,
        ),
        lessThanOrEqualTo(501),
      );
    });

    test('nearby cameras in one cell and radius bucket share a cell', () {
      final grid = DiscoveryArea.cell(
        _around(24.7136, 46.6753, 400),
        countryCode: 'SA',
      );
      final northEast = DiscoveryArea.cell(
        _around(
          grid.latitude + 150 / DiscoveryArea.metresPerDegreeLatitude,
          grid.longitude +
              150 / DiscoveryArea.metresPerDegreeLongitude(grid.latitude),
          450,
        ),
        countryCode: 'SA',
      );
      final southWest = DiscoveryArea.cell(
        _around(
          grid.latitude - 150 / DiscoveryArea.metresPerDegreeLatitude,
          grid.longitude -
              150 / DiscoveryArea.metresPerDegreeLongitude(grid.latitude),
          350,
        ),
        countryCode: 'SA',
      );
      expect(northEast.cellId, grid.cellId);
      expect(southWest.cellId, grid.cellId);
      expect(
        {
          grid.radiusMeters,
          northEast.radiusMeters,
          southWest.radiusMeters,
        },
        {1000},
      );

      final nextCell = DiscoveryArea.cell(
        _around(
          grid.latitude + 1100 / DiscoveryArea.metresPerDegreeLatitude,
          grid.longitude,
          400,
        ),
        countryCode: 'SA',
      );
      expect(nextCell.row, grid.row + 1);
    });

    test('round the half-diagonal up to 1, 2, 5 or 10 km', () {
      int radius(double halfSide) => DiscoveryArea.cell(
        _around(24.7136, 46.6753, halfSide),
        countryCode: 'SA',
      ).radiusMeters;
      // A square's half-diagonal is its half-side times √2.
      expect(radius(600), 1000);
      expect(radius(800), 2000);
      expect(radius(1400), 2000);
      expect(radius(1500), 5000);
      expect(radius(3500), 5000);
      expect(radius(3600), 10000);
      expect(radius(40000), 10000);
    });

    test('footprints extend the radius from the centre on each axis', () {
      // The cell math uses fixed metres per degree; spherical haversine reads
      // about half a percent longer at this latitude.
      final cell = DiscoveryArea.cell(
        _around(25.2048, 55.2708, 3000),
        countryCode: 'AE',
      );
      final bounds = cell.bounds;
      expect(cell.radiusMeters, 5000);
      expect(
        DiscoveryArea.haversineMeters(
          cell.latitude,
          cell.longitude,
          bounds.north,
          cell.longitude,
        ),
        closeTo(5000, 40),
      );
      expect(
        DiscoveryArea.haversineMeters(
          cell.latitude,
          cell.longitude,
          cell.latitude,
          bounds.east,
        ),
        closeTo(5000, 40),
      );
    });
  });

  group('area validation', () {
    test('rejects invalid bounds and unsupported or mismatched areas', () {
      expect(
        () => DiscoveryArea.resolveCountry(
          DiscoverViewport(south: 25, west: 46, north: 24, east: 47),
          null,
        ),
        throwsA(_apiError('invalid_area')),
      );
      expect(
        () => DiscoveryArea.resolveCountry(
          DiscoverViewport(south: 48.8, west: 2.2, north: 48.9, east: 2.4),
          null,
        ),
        throwsA(_apiError('unsupported_area')),
      );
      final riyadh = _around(24.7136, 46.6753, 1000);
      expect(DiscoveryArea.resolveCountry(riyadh, ' sa '), 'SA');
      expect(
        () => DiscoveryArea.resolveCountry(riyadh, 'AE'),
        throwsA(_apiError('unsupported_area')),
      );
    });
  });
}
