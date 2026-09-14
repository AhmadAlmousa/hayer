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
);

typedef BrowseRequest = ({
  DiscoverQuery query,
  DiscoverQueryContext? context,
  String? cursor,
  int pageSize,
  bool includeMap,
});

typedef FacetsRequest = ({DiscoverQuery query, DiscoverQueryContext context});

typedef PlaceContextRequest = ({
  PoiIdentity identity,
  DiscoverQuery query,
  DiscoverQueryContext context,
});

typedef DeepenRequest = ({DiscoverViewport viewport, String idempotencyKey});

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

  final facetsRequests = <FacetsRequest>[];

  /// Answers facets instead of [testFacets] in the request's context.
  Future<DiscoverFacets> Function(FacetsRequest request)? onFacets;

  @override
  Future<DiscoverFacets> facets({
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    final request = (query: query, context: context);
    facetsRequests.add(request);
    return (onFacets ??
        (request) async => testFacets(context: request.context))(
      request,
    );
  }

  int taxonomyCalls = 0;

  /// Answers the taxonomy read instead of [testTaxonomy].
  Future<DiscoveryTaxonomySnapshot> Function()? onTaxonomy;

  @override
  Future<DiscoveryTaxonomySnapshot> taxonomy() async {
    taxonomyCalls++;
    return (onTaxonomy ?? () async => testTaxonomy())();
  }

  final placeContextRequests = <PlaceContextRequest>[];

  /// Answers place context instead of an eligible [testPlaceContext].
  Future<DiscoverPlaceContext> Function(PlaceContextRequest request)?
  onPlaceContext;

  @override
  Future<DiscoverPlaceContext> placeContext({
    required PoiIdentity identity,
    required DiscoverQuery query,
    required DiscoverQueryContext context,
  }) async {
    final request = (identity: identity, query: query, context: context);
    placeContextRequests.add(request);
    return (onPlaceContext ??
        (request) async => testPlaceContext(context: request.context))(
      request,
    );
  }

  final ensureAreaRequests = <DiscoverViewport>[];

  /// Answers reporting an area instead of an idle [testReceipt].
  Future<DiscoveryAreaReceipt> Function(DiscoverViewport viewport)?
  onEnsureArea;

  @override
  Future<DiscoveryAreaReceipt> ensureArea({
    required DiscoverViewport viewport,
  }) async {
    ensureAreaRequests.add(viewport);
    return (onEnsureArea ?? (_) async => testReceipt())(viewport);
  }

  final deepenRequests = <DeepenRequest>[];

  /// Answers Deepen instead of a receipt for a started exploration.
  Future<DiscoveryAreaReceipt> Function(DeepenRequest request)? onDeepen;

  @override
  Future<DiscoveryAreaReceipt> deepen({
    required DiscoverViewport viewport,
    required String idempotencyKey,
  }) async {
    final request = (viewport: viewport, idempotencyKey: idempotencyKey);
    deepenRequests.add(request);
    return (onDeepen ??
        (_) async => testReceipt(
          job: testHarvestJob(trigger: DiscoveryHarvestTrigger.deepen),
        ))(request);
  }

  final harvestStatusRequests = <String>[];

  /// Answers an exploration check instead of a finished [testHarvestJob].
  Future<DiscoveryHarvestStatus> Function(String jobId)? onHarvestStatus;

  @override
  Future<DiscoveryHarvestStatus> harvestStatus({required String jobId}) async {
    harvestStatusRequests.add(jobId);
    return (onHarvestStatus ??
        (jobId) async => testHarvestJob(
          jobId: jobId,
          state: DiscoveryHarvestState.succeeded,
          completed: 9,
        ))(jobId);
  }
}

DiscoverQueryContext testQueryContext({
  String countryCode = 'SA',
  int policyRevision = 1,
  int taxonomyRevision = 1,
}) => DiscoverQueryContext(
  fingerprint: 'fingerprint',
  countryCode: countryCode,
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
  DiscoveryMapPayload? map,
  DiscoveryCoverage? coverage,
}) {
  final places = items ?? [for (var id = 1; id <= 3; id++) testPlace(id)];
  return DiscoverBrowsePage(
    items: places,
    total: total ?? places.length,
    context: context ?? testQueryContext(),
    fetchedAt: testEvaluatedAt,
    nextCursor: nextCursor,
    map: includeMap
        ? map ??
              DiscoveryMapPayload(
                mode: DiscoveryMapMode.points,
                points: const [],
                aggregates: const [],
              )
        : null,
    coverage: coverage ?? testCoverage(eligible: eligible),
  );
}

DiscoverViewport testWireViewport([DiscoveryViewport? viewport]) {
  final box = viewport ?? testViewport;
  return DiscoverViewport(
    south: box.south,
    west: box.west,
    north: box.north,
    east: box.east,
  );
}

DiscoveryCoverage testCoverage({
  int eligible = 100,
  List<DiscoveryCoverageFootprint> footprints = const [],
  List<DiscoveryHarvestStatus> pendingJobs = const [],
}) => DiscoveryCoverage(
  eligibleCatalogCount: eligible,
  footprints: footprints,
  pendingJobs: pendingJobs,
);

/// A harvest cell over [bounds], or the whole test viewport, that last
/// succeeded at [lastSuccessAt] with every query group complete unless
/// [incomplete] names some.
DiscoveryCoverageFootprint testFootprint({
  DiscoveryViewport? bounds,
  String cellId = 'cell-1',
  DateTime? lastAttemptAt,
  DateTime? lastSuccessAt,
  List<String> incomplete = const [],
  DateTime? retryAfter,
}) => DiscoveryCoverageFootprint(
  cellId: cellId,
  bounds: testWireViewport(bounds),
  manifestRevision: 1,
  completedQueryGroups: const ['food', 'things'],
  incompleteQueryGroups: incomplete,
  lastAttemptAt: lastAttemptAt ?? lastSuccessAt,
  lastSuccessAt: lastSuccessAt,
  retryAfter: retryAfter,
);

DiscoveryHarvestStatus testHarvestJob({
  String jobId = 'job-1',
  DiscoveryHarvestState state = DiscoveryHarvestState.running,
  DiscoveryHarvestTrigger trigger = DiscoveryHarvestTrigger.committedSearch,
  int completed = 2,
  int total = 9,
  DateTime? retryAfter,
}) => DiscoveryHarvestStatus(
  jobId: jobId,
  state: state,
  trigger: trigger,
  bounds: testWireViewport(),
  manifestRevision: 1,
  completedQueries: completed,
  totalQueries: total,
  observedPlaces: completed * 4,
  fetchedAt: testEvaluatedAt,
  retryAfter: retryAfter,
);

DiscoveryAreaReceipt testReceipt({
  DiscoveryCoverage? coverage,
  DiscoveryHarvestStatus? job,
  DateTime? retryAfter,
  DateTime? fetchedAt,
}) => DiscoveryAreaReceipt(
  coverage: coverage ?? testCoverage(),
  job: job,
  retryAfter: retryAfter,
  fetchedAt: fetchedAt ?? testEvaluatedAt,
);

DiscoveryMapPoint testMapPoint(
  int id, {
  double? rating = 4.3,
  bool hiddenGem = false,
  double latitude = 24.71,
  double longitude = 46.71,
}) => DiscoveryMapPoint(
  catalogId: id,
  provider: 'google-web',
  placeId: 'place-$id',
  name: 'Place $id',
  latitude: latitude,
  longitude: longitude,
  rating: rating,
  hiddenGem: hiddenGem,
);

DiscoveryMapPayload testPointsMap(Iterable<int> ids) => DiscoveryMapPayload(
  mode: DiscoveryMapMode.points,
  points: [for (final id in ids) testMapPoint(id)],
  aggregates: const [],
);

DiscoverPlaceContext testPlaceContext({
  bool eligible = true,
  DiscoverPlace? place,
  int? ordinal = 120,
  int total = 240,
  DiscoverQueryContext? context,
}) => DiscoverPlaceContext(
  eligible: eligible,
  place: eligible ? place : null,
  ordinal: eligible ? ordinal : null,
  total: total,
  ratingPercentile: eligible ? 62.5 : null,
  populationCategoryId: null,
  ratingDistribution: const [],
  context: context ?? testQueryContext(),
  fetchedAt: testEvaluatedAt,
);

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

/// A geocoder that answers [place], or fails while [place] is null.
class FakeLocationRepository extends Fake implements LocationRepository {
  ReverseGeocodeResult? place;
  int calls = 0;

  @override
  Future<ReverseGeocodeResult> reverseGeocodeDetails({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) async {
    calls++;
    return place ?? (throw Exception('geocoder unavailable'));
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

DiscoveryTaxonomyNode testCategory(
  String id,
  String labelEn,
  String labelAr, {
  String emoji = '',
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: labelEn,
  labelAr: labelAr,
  emoji: emoji,
  typeAliases: aliases,
  children: children,
);

/// Food and Drinks, with cafes and a Japanese branch; Things to do; Wellness.
List<DiscoveryTaxonomyNode> testCategoryRoots() => [
  testCategory(
    'food',
    'Food & Drinks',
    'الطعام والمشروبات',
    emoji: '🍹',
    children: [
      testCategory(
        'cafes',
        'Cafes',
        'المقاهي',
        emoji: '☕',
        aliases: ['Cafe'],
        children: [
          testCategory(
            'coffee',
            'Coffee shop',
            'مقهى قهوة مختصة',
            aliases: ['Coffee shop'],
          ),
          testCategory('tea', 'Tea house', 'بيت شاي', aliases: ['Tea house']),
        ],
      ),
      testCategory(
        'restaurants',
        'Restaurants',
        'المطاعم',
        emoji: '🍽️',
        children: [
          testCategory(
            'japanese',
            'Japanese',
            'ياباني',
            emoji: '🍱',
            aliases: ['Japanese restaurant'],
            children: [
              testCategory(
                'sushi',
                'Sushi',
                'سوشي',
                emoji: '🍣',
                aliases: ['Sushi restaurant'],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  testCategory(
    'things',
    'Things to do',
    'أنشطة',
    emoji: '🎯',
    children: [
      testCategory('museum', 'Museum', 'متحف', aliases: ['Museum']),
    ],
  ),
  testCategory(
    'wellness',
    'Wellness',
    'العافية',
    emoji: '💆',
    children: [
      testCategory('spa', 'Spa', 'منتجع صحي', aliases: ['Spa']),
    ],
  ),
];

/// Cafes hold 2 places of their own and coffee shops 10; Japanese holds 3 of
/// its own and sushi 4; 5 places map to nothing. That makes Food and Drinks
/// 19 and the view 24, with tea, Things to do and Wellness empty.
List<DiscoveryTypeCount> testTypeCounts() => [
  DiscoveryTypeCount(primaryType: 'Cafe', taxonomyNodeId: 'cafes', count: 2),
  DiscoveryTypeCount(
    primaryType: 'Coffee shop',
    taxonomyNodeId: 'coffee',
    count: 10,
  ),
  DiscoveryTypeCount(
    primaryType: 'Japanese restaurant',
    taxonomyNodeId: 'japanese',
    count: 3,
  ),
  DiscoveryTypeCount(
    primaryType: 'Sushi restaurant',
    taxonomyNodeId: 'sushi',
    count: 4,
  ),
  DiscoveryTypeCount(
    primaryType: 'Car wash',
    taxonomyNodeId: 'other',
    count: 3,
  ),
  DiscoveryTypeCount(primaryType: null, taxonomyNodeId: 'other', count: 2),
];

DiscoveryTaxonomySnapshot testTaxonomy({
  int revision = 1,
  List<DiscoveryTaxonomyNode>? roots,
}) => DiscoveryTaxonomySnapshot(
  revision: revision,
  roots: roots ?? testCategoryRoots(),
  fetchedAt: testEvaluatedAt,
);

/// Facets over [testTypeCounts]. Review bands hold 2, 4, 6, 8, 10 and 12
/// places from the lowest up.
DiscoverFacets testFacets({
  int total = 24,
  DiscoverQueryContext? context,
  List<DiscoveryTypeCount>? typeCounts,
  List<DiscoveryPriceCount>? priceCounts,
  List<DiscoveryMinimumRatingCount>? minimumRatingCounts,
}) => DiscoverFacets(
  total: total,
  context: context ?? testQueryContext(),
  fetchedAt: testEvaluatedAt,
  typeCounts: typeCounts ?? testTypeCounts(),
  reviewBandCounts: [
    for (final (index, band) in DiscoverReviewBand.values.indexed)
      DiscoveryReviewBandCount(band: band, count: (index + 1) * 2),
  ],
  priceCounts:
      priceCounts ??
      [
        DiscoveryPriceCount(priceLevel: 1, count: 4),
        DiscoveryPriceCount(priceLevel: 2, count: 6),
        DiscoveryPriceCount(priceLevel: null, count: 14),
      ],
  ratingDistribution: const [],
  minimumRatingCounts:
      minimumRatingCounts ??
      [
        DiscoveryMinimumRatingCount(minimumRating: 3.5, count: 20),
        DiscoveryMinimumRatingCount(minimumRating: 4, count: 12),
        DiscoveryMinimumRatingCount(minimumRating: 4.5, count: 5),
      ],
  unknownRatingCount: 1,
);
