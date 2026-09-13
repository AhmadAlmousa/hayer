import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hayer_app/data/discovery_area_store.dart';
import 'package:hayer_app/data/discovery_repository.dart';
import 'package:hayer_app/data/location_repository.dart';
import 'package:hayer_app/data/location_warmup.dart';
import 'package:hayer_app/domain/discovery_url_query.dart';
import 'package:hayer_app/features/discover/discovery_search.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:material_ui/material_ui.dart';

/// The Riyadh viewport the Discover tests search.
final testViewport = DiscoveryViewport.tryCreate(
  south: 24.6,
  west: 46.6,
  north: 24.8,
  east: 46.8,
)!;

final testEvaluatedAt = DateTime.utc(2026, 9, 13, 12);

DiscoverySearch testSearch({
  DiscoverySort sort = DiscoverySort.best,
  DiscoveryViewport? viewport,
}) => DiscoverySearch(
  query: DiscoveryUrlQuery(viewport: viewport ?? testViewport, sort: sort),
  countryCode: 'SA',
);

typedef BrowseRequest = ({
  DiscoverQuery query,
  DiscoverQueryContext? context,
  String? cursor,
  int pageSize,
  bool includeMap,
});

/// Answers browse with [onBrowse], or with three places by default, and
/// records every request.
class FakeDiscoveryRepository extends Fake implements DiscoveryRepository {
  final requests = <BrowseRequest>[];

  Future<DiscoverBrowsePage> Function(BrowseRequest request)? onBrowse;

  @override
  Future<DiscoverBrowsePage> browse({
    required DiscoverQuery query,
    DiscoverQueryContext? context,
    String? cursor,
    required int pageSize,
    required bool includeMap,
  }) async {
    final request = (
      query: query,
      context: context,
      cursor: cursor,
      pageSize: pageSize,
      includeMap: includeMap,
    );
    requests.add(request);
    return (onBrowse ?? (_) async => testBrowsePage())(request);
  }
}

DiscoverQueryContext testQueryContext({
  int policyRevision = 1,
  int taxonomyRevision = 1,
}) => DiscoverQueryContext(
  fingerprint: 'fingerprint',
  policyRevision: policyRevision,
  taxonomyRevision: taxonomyRevision,
  evaluatedAt: testEvaluatedAt,
);

DiscoverBrowsePage testBrowsePage({
  List<DiscoverPlace>? items,
  int? total,
  DiscoverQueryContext? context,
  String? nextCursor,
  int eligible = 100,
  bool includeMap = true,
}) {
  final places = items ?? [for (var id = 1; id <= 3; id++) testPlace(id)];
  return DiscoverBrowsePage(
    items: places,
    total: total ?? places.length,
    context: context ?? testQueryContext(),
    fetchedAt: testEvaluatedAt,
    nextCursor: nextCursor,
    map: includeMap
        ? DiscoveryMapPayload(
            mode: DiscoveryMapMode.points,
            points: const [],
            aggregates: const [],
          )
        : null,
    coverage: DiscoveryCoverage(
      eligibleCatalogCount: eligible,
      footprints: const [],
      pendingJobs: const [],
    ),
  );
}

DiscoverPlace testPlace(
  int id, {
  int? ordinal,
  String? name,
  double? rating = 4.3,
  int? reviewCount = 1200,
  bool hiddenGem = false,
  bool? openNow = true,
  DateTime? firstSeenAt,
  List<String> categoryIds = const ['cafe', 'coffee_shop'],
  int? priceLevel = 2,
  String? primaryType = 'Coffee shop',
  bool isStale = false,
  double latitude = 24.71,
  double longitude = 46.71,
}) => DiscoverPlace(
  catalogId: id,
  provider: 'google-web',
  place: PlaceSnapshot(
    placeId: 'place-$id',
    name: name ?? 'Place $id',
    primaryType: primaryType,
    categoryIds: categoryIds,
    rating: rating,
    reviewCount: reviewCount,
    priceLevel: priceLevel,
    hours: const [],
    distanceMeters: 0,
    latitude: latitude,
    longitude: longitude,
    photoUrls: const [],
    attributions: const ['Google Maps'],
    sourceCheckedAt: DateTime.utc(2026, 9, 1),
    isStale: isStale,
  ),
  ordinal: ordinal ?? id,
  firstSeenAt: firstSeenAt ?? DateTime.utc(2025, 1, 1),
  hiddenGem: hiddenGem,
  openNow: openNow,
);

final class MemoryDiscoveryAreaStore implements DiscoveryAreaStore {
  DiscoveryViewport? viewport;

  @override
  Future<DiscoveryViewport?> read() async => viewport;

  @override
  Future<void> write(DiscoveryViewport viewport) async =>
      this.viewport = viewport;
}

/// A device whose location is [position] when permission was already given,
/// and [granted] once the user allows it.
class FakeLocationWarmup extends Fake implements LocationWarmup {
  Position? position;
  Position? granted;
  int prompts = 0;

  @override
  Position? get latest => position;

  @override
  Future<Position?> get ready async => position;

  @override
  Future<Position?> locate({
    bool requestPermission = false,
    bool refresh = false,
  }) async {
    if (requestPermission) prompts++;
    return requestPermission ? granted ?? position : position;
  }
}

Position testPosition(double latitude, double longitude) => Position(
  latitude: latitude,
  longitude: longitude,
  timestamp: DateTime.utc(2026),
  accuracy: 30,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

/// A geocoder that answers [address], or fails while [address] is null.
class FakeLocationRepository extends Fake implements LocationRepository {
  String? address;
  int calls = 0;

  @override
  Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    calls++;
    return address ?? (throw Exception('geocoder unavailable'));
  }
}

/// A MapLibre platform that draws nothing and never creates a controller.
class FakeMapPlatform extends Fake implements MapLibrePlatform {
  @override
  Widget buildView(
    Map<String, dynamic> creationParams,
    OnPlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  ) => const SizedBox.expand();

  @override
  void dispose() {}
}

/// Installs [FakeMapPlatform] for the current test.
void useFakeMapPlatform() {
  final original = MapLibrePlatform.createInstance;
  MapLibrePlatform.createInstance = FakeMapPlatform.new;
  addTearDown(() => MapLibrePlatform.createInstance = original);
}
