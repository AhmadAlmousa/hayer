import 'package:hayer_server/src/admin/refresh_job_service.dart';
import 'package:hayer_server/src/discovery/discovery_area.dart';
import 'package:hayer_server/src/discovery/discovery_harvest_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/place_candidate.dart';
import 'package:hayer_server/src/places/provider_operation.dart';
import 'package:hayer_server/src/places/taxonomy_service.dart';
import 'package:serverpod/serverpod.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';
import 'discovery_fixtures.dart';

// Shared fixtures for the Discover harvest PostGIS suites.

const harvestCalibration = 'harvest-fixture';

typedef HarvestFetch = ({
  String query,
  String language,
  int offset,
  double latitude,
  double longitude,
  int radiusMeters,
  String countryCode,
});

/// Stands in for the shared Vela-derived source. Each page spends one
/// upstream request where the transport's admission would, and is recorded
/// only once that request was allowed.
final class FixtureHarvestSource implements HarvestPageSource {
  FixtureHarvestSource(this.respond);

  final Future<List<PlaceCandidate>> Function(HarvestFetch fetch) respond;
  final fetches = <HarvestFetch>[];

  @override
  int get pageSize => 5;

  @override
  String get calibrationVersion => harvestCalibration;

  @override
  Future<List<PlaceCandidate>> fetchPage({
    required String query,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String language,
    required String countryCode,
    required int offset,
  }) {
    ProviderOperation.current?.takeRequest();
    final fetch = (
      query: query,
      language: language,
      offset: offset,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      countryCode: countryCode,
    );
    fetches.add(fetch);
    return respond(fetch);
  }
}

/// The harvest cell of a small central-Riyadh view.
DiscoveryHarvestCell riyadhCell() => DiscoveryArea.cell(
  cellView(
    const DiscoveryHarvestCell(
      countryCode: 'SA',
      row: 0,
      column: 0,
      latitude: 24.7136,
      longitude: 46.6753,
      radiusMeters: 1000,
    ),
  ),
  countryCode: 'SA',
);

/// A 600 m view centred [northMetres] and [eastMetres] from [cell]'s centre,
/// which snaps back to [cell] while both offsets stay under 500 m.
DiscoverViewport cellView(
  DiscoveryHarvestCell cell, {
  double northMetres = 0,
  double eastMetres = 0,
}) {
  const half = 300.0;
  final latitude =
      cell.latitude + northMetres / DiscoveryArea.metresPerDegreeLatitude;
  final longitudeMetres = DiscoveryArea.metresPerDegreeLongitude(
    cell.latitude,
  );
  final longitude = cell.longitude + eastMetres / longitudeMetres;
  return DiscoverViewport(
    south: latitude - half / DiscoveryArea.metresPerDegreeLatitude,
    west: longitude - half / longitudeMetres,
    north: latitude + half / DiscoveryArea.metresPerDegreeLatitude,
    east: longitude + half / longitudeMetres,
  );
}

PlaceCandidate harvestCandidate(
  String id,
  DiscoveryHarvestCell cell, {
  String primaryType = 'Coffee shop',
}) => PlaceCandidate(
  placeId: id,
  name: 'Place $id',
  primaryType: primaryType,
  rating: 4.4,
  reviewCount: 40,
  priceLevel: 2,
  latitude: cell.latitude,
  longitude: cell.longitude,
  sourceCheckedAt: fixtureNow,
);

Future<void> resetHarvests(Session session) async {
  await session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_discovery_harvest",
  "hayer_discovery_coverage",
  "hayer_discovery_harvest_manifest",
  "hayer_discovery_type_observation",
  "hayer_refresh_job",
  "hayer_idempotency",
  "hayer_admin_audit",
  "hayer_operational_metric",
  "hayer_poi_category",
  "hayer_poi_coverage"
''');
  await resetDiscovery(session);
}

/// The Swipe categories a harvest's compatibility pass queries, in order.
Future<List<AdminTaxonomyItem>> swipeCategories(Session session) async =>
    (await TaxonomyService.activeItems(session))
        .where((item) => item.kind == TaxonomyKind.category && item.enabled)
        .toList()
      ..sort((a, b) {
        final byOrder = a.sortOrder.compareTo(b.sortOrder);
        return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
      });

/// Claims and runs every queued refresh job, as the worker loop does.
Future<void> runHarvests(TestSessionBuilder builder) async {
  final session = builder.build();
  try {
    while (true) {
      final job = await RefreshJobService.claimNext(session);
      if (job == null) return;
      await RefreshJobService.executeClaimed(session, job);
    }
  } finally {
    await session.close();
  }
}
