import 'package:hayer_server/src/discovery/discovery_policy_service.dart';
import 'package:hayer_server/src/discovery/discovery_taxonomy_service.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:hayer_server/src/places/discovery_query.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

// Shared fixtures for the Discover PostGIS acceptance suites.

const fixtureProvider = 'google-web';

/// Wednesday 16 September 2026, 07:00 UTC: 10:00 in Riyadh, 11:00 in Dubai
/// and Muscat.
final fixtureNow = DateTime.utc(2026, 9, 16, 7);

final riyadhView = DiscoverViewport(
  south: 24.6,
  west: 46.5,
  north: 24.8,
  east: 46.8,
);

final dubaiView = DiscoverViewport(
  south: 25.0,
  west: 55.1,
  north: 25.3,
  east: 55.4,
);

final muscatView = DiscoverViewport(
  south: 23.5,
  west: 58.3,
  north: 23.7,
  east: 58.6,
);

TestSessionBuilder discoveryMember(
  TestSessionBuilder builder, [
  String user = 'discovery-member',
]) => builder.copyWith(
  authentication: AuthenticationOverride.authenticationInfo(
    user,
    const <Scope>{},
  ),
);

void pinDiscoveryClock(DateTime instant) =>
    DiscoveryQuery.clock = () => instant;

void restoreDiscoveryClock() =>
    DiscoveryQuery.clock = () => DateTime.now().toUtc();

TypeMatcher<ApiException> apiError(String code) =>
    isA<ApiException>().having((error) => error.code, 'code', code);

DiscoveryTaxonomyNode taxonomyNode(
  String id, {
  List<String> aliases = const [],
  List<DiscoveryTaxonomyNode> children = const [],
}) => DiscoveryTaxonomyNode(
  id: id,
  labelEn: id,
  labelAr: 'تصنيف $id',
  emoji: '📍',
  typeAliases: aliases,
  children: children,
);

/// Food with an interior Restaurants node that carries its own alias, and a
/// sibling Outdoors root. Bowling alleys stay unmapped.
final fixtureTree = [
  taxonomyNode(
    'food',
    children: [
      taxonomyNode('cafes', aliases: ['Coffee shop', 'مقهى']),
      taxonomyNode(
        'restaurants',
        aliases: ['Restaurant'],
        children: [
          taxonomyNode('japanese', aliases: ['Japanese restaurant']),
        ],
      ),
    ],
  ),
  taxonomyNode('outdoors', aliases: ['City park']),
];

Future<void> resetDiscovery(Session session) async {
  await RateLimitRow.db.deleteWhere(session, where: (_) => Constant.bool(true));
  await session.db.unsafeExecute('DELETE FROM "hayer_poi_catalog"');
  await CacheSettingsRow.db.deleteWhere(
    session,
    where: (_) => Constant.bool(true),
  );
  await DiscoveryTaxonomyVersionRow.db.deleteWhere(
    session,
    where: (_) => Constant.bool(true),
  );
}

/// Enables Discover with generous request budgets, then applies [adjust].
/// Every call stores a new policy revision.
Future<void> useDiscoveryPolicy(
  Session session, [
  DiscoveryPolicy Function(DiscoveryPolicy discovery)? adjust,
]) async {
  final existing = await DiscoveryPolicyService.settings(session);
  final current = existing == null
      ? DiscoveryPolicyService.defaultPolicy()
      : DiscoveryPolicyService.fromRow(existing);
  var discovery = current.discovery!.copyWith(
    enabled: true,
    browseRequestsPerMinute: 600,
    facetRequestsPerMinute: 600,
  );
  if (adjust != null) discovery = adjust(discovery);
  final row = DiscoveryPolicyService.toRow(
    current.copyWith(discovery: discovery),
    existing: existing,
    updatedBy: 'discovery-test',
    updatedAt: DateTime.now().toUtc(),
  );
  if (existing == null) {
    await CacheSettingsRow.db.insertRow(session, row);
  } else {
    await CacheSettingsRow.db.updateRow(session, row);
  }
}

/// Supersedes the active Discover tree and activates [roots] at [revision].
Future<void> publishDiscoveryTree(
  Session session,
  List<DiscoveryTaxonomyNode> roots, {
  required int revision,
}) async {
  final active = await DiscoveryTaxonomyVersionRow.db.find(
    session,
    where: (table) => table.status.equals(TaxonomyStatus.active),
  );
  for (final row in active) {
    await DiscoveryTaxonomyVersionRow.db.updateRow(
      session,
      row.copyWith(status: TaxonomyStatus.superseded),
    );
  }
  final now = DateTime.now().toUtc();
  await DiscoveryTaxonomyVersionRow.db.insertRow(
    session,
    DiscoveryTaxonomyVersionRow(
      version: 'fixture-$revision',
      revision: revision,
      status: TaxonomyStatus.active,
      documentJson: DiscoveryTaxonomyService.encode(roots),
      validationPassed: true,
      validationErrors: const [],
      createdBy: 'discovery-test',
      createdAt: now,
      validatedAt: now,
      publishedAt: now,
    ),
  );
}

Future<void> seedDiscovery(
  Session session, {
  List<PoiCatalogRow> places = const [],
  DiscoveryPolicy Function(DiscoveryPolicy discovery)? policy,
  List<DiscoveryTaxonomyNode>? tree,
}) async {
  await resetDiscovery(session);
  await useDiscoveryPolicy(session, policy);
  await publishDiscoveryTree(session, tree ?? fixtureTree, revision: 1);
  if (places.isNotEmpty) await PoiCatalogRow.db.insert(session, places);
}

/// A weekly period; overnight follows the parser's close-before-open rule
/// unless given.
OpeningPeriod period(int day, int open, int close, {bool? overnight}) =>
    OpeningPeriod(
      day: day,
      openMinutes: open,
      closeMinutes: close,
      overnight: overnight ?? close <= open,
    );

/// A fresh Riyadh catalog row checked an hour before [fixtureNow].
PoiCatalogRow place(
  String id, {
  String? name,
  double? rating,
  int? reviews,
  int? price,
  String? primaryType = 'Coffee shop',
  List<OpeningPeriod> hours = const [],
  String? statusText,
  bool photos = false,
  String? phone,
  String? website,
  String? summary,
  String? featuredReview,
  double? latitude,
  double? longitude,
  String countryCode = 'SA',
  DateTime? firstSeenAt,
  DateTime? checkedAt,
  DateTime? quarantinedAt,
}) {
  final checked = checkedAt ?? fixtureNow.subtract(const Duration(hours: 1));
  final offset = id.codeUnits.fold<int>(0, (sum, unit) => sum + unit) % 997;
  final snapshot = PlaceSnapshot(
    placeId: id,
    name: name ?? 'Place $id',
    primaryType: primaryType,
    categoryIds: const [],
    rating: rating,
    reviewCount: reviews,
    priceLevel: price,
    priceText: price == null ? null : r'$' * price,
    statusText: statusText,
    hours: hours,
    distanceMeters: 0,
    latitude: latitude ?? 24.70 + offset / 100000,
    longitude: longitude ?? 46.65 + offset / 100000,
    phoneNumber: phone,
    websiteUrl: website,
    photoUrls: photos ? ['https://example.com/$id.jpg'] : const [],
    featuredReview: featuredReview,
    editorialSummary: summary,
    attributions: const ['Fixture'],
    sourceCheckedAt: checked,
    isStale: false,
  );
  return PoiCatalogRow(
    provider: fixtureProvider,
    providerPlaceId: id,
    normalizedName: snapshot.name.toLowerCase(),
    name: snapshot.name,
    countryCode: countryCode,
    latitude: snapshot.latitude,
    longitude: snapshot.longitude,
    location: GeographyPoint(
      longitude: snapshot.longitude,
      latitude: snapshot.latitude,
    ),
    categoryIds: const [],
    snapshot: snapshot,
    calibrationVersion: 'fixture',
    sourceCheckedAt: checked,
    firstSeenAt: firstSeenAt ?? DateTime.utc(2026, 9, 1),
    lastSeenAt: checked,
    quarantinedAt: quarantinedAt,
    quarantineReason: quarantinedAt == null ? null : 'fixture',
  );
}

/// Inserts [count] fresh, rated places spread over [riyadhView] in SQL, for
/// map thresholds too large to build row by row.
Future<void> insertGridPlaces(
  Session session, {
  required int count,
  int offset = 0,
}) => session.db.unsafeExecute(
  '''
INSERT INTO "hayer_poi_catalog" (
  "provider", "providerPlaceId", "featureId", "normalizedName", "name",
  "countryCode", "latitude", "longitude", "categoryIds", "snapshot",
  "calibrationVersion", "sourceCheckedAt", "firstSeenAt", "lastSeenAt"
)
SELECT
  'google-web', id, NULL, id, id, 'SA', latitude, longitude, '[]'::json,
  json_build_object(
    'placeId', id, 'name', id, 'primaryType', 'Coffee shop',
    'categoryIds', json_build_array(), 'rating', 4.0, 'reviewCount', 10,
    'hours', json_build_array(), 'distanceMeters', 0,
    'latitude', latitude, 'longitude', longitude,
    'photoUrls', json_build_array(), 'attributions', json_build_array(),
    'sourceCheckedAt', CAST(@checked AS text), 'isStale', false
  ),
  'fixture', CAST(@checked AS timestamp), CAST(@checked AS timestamp),
  CAST(@checked AS timestamp)
FROM (
  SELECT
    'grid-' || lpad(n::text, 5, '0') AS id,
    24.61 + (n % 100) * 0.0018 AS latitude,
    46.51 + (n / 100) * 0.0028 AS longitude
  FROM generate_series(CAST(@first AS integer), CAST(@last AS integer)) AS n
) generated
''',
  parameters: QueryParameters.named({
    'checked': fixtureNow.subtract(const Duration(hours: 1)).toIso8601String(),
    'first': offset,
    'last': offset + count - 1,
  }),
);

DiscoverQuery discoverQuery({
  DiscoverViewport? viewport,
  String? countryCode,
  DiscoverSort sort = DiscoverSort.mostReviewed,
  List<String> categoryIds = const [],
  List<DiscoverReviewBand> reviewBands = const [],
  int? exactPriceLevel,
  double? minimumRating,
  List<DiscoverHoursWindow> hoursWindows = const [],
  String text = '',
  List<DiscoverCompleteness> completeness = const [],
}) => DiscoverQuery(
  viewport: viewport ?? riyadhView,
  countryCode: countryCode,
  sort: sort,
  categoryIds: categoryIds,
  reviewBands: reviewBands,
  exactPriceLevel: exactPriceLevel,
  minimumRating: minimumRating,
  hoursWindows: hoursWindows,
  text: text,
  completeness: completeness,
);

List<String> placeIds(DiscoverBrowsePage page) => [
  for (final item in page.items) item.place.placeId,
];

/// Every page of [query], following cursors from a fresh first page.
Future<List<DiscoverBrowsePage>> browseAll(
  TestEndpoints endpoints,
  TestSessionBuilder member,
  DiscoverQuery query, {
  int pageSize = 2,
}) async {
  final pages = <DiscoverBrowsePage>[];
  DiscoverBrowsePage? page;
  do {
    page = await endpoints.discover.browse(
      member,
      query: query,
      context: page?.context,
      cursor: page?.nextCursor,
      pageSize: pageSize,
      includeMap: false,
    );
    pages.add(page);
  } while (page.nextCursor != null);
  return pages;
}

/// A solo swipe session owned by [userId], whose deck holds [places] in order.
Future<void> insertSwipeSession(
  Session session, {
  required String sessionId,
  required String code,
  required String userId,
  required List<PlaceSnapshot> places,
}) async {
  await HayerSessionRow.db.insertRow(
    session,
    HayerSessionRow(
      sessionId: sessionId,
      code: code,
      hostUserId: userId,
      mode: SessionMode.solo,
      categoryId: 'restaurant',
      subcategoryIds: const [],
      anchorLatitude: 24.7,
      anchorLongitude: 46.65,
      countryCode: 'SA',
      radiusMeters: 500,
      deckSizeRequested: 10,
      deckSizeActual: places.length,
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.instant,
      status: SessionStatus.active,
      revision: 3,
      createdAt: fixtureNow,
      expiresAt: fixtureNow.add(const Duration(days: 1)),
    ),
  );
  await ParticipantRow.db.insertRow(
    session,
    ParticipantRow(
      participantId: '$sessionId-host',
      sessionId: sessionId,
      userId: userId,
      displayName: 'Host',
      normalizedName: 'host',
      isHost: true,
      currentIndex: 0,
      hasCompleted: false,
      lastSeenAt: fixtureNow,
    ),
  );
  for (final (index, snapshot) in places.indexed) {
    await SessionPlaceRow.db.insertRow(
      session,
      SessionPlaceRow(
        sessionId: sessionId,
        placeId: snapshot.placeId,
        deckOrder: index,
        snapshot: snapshot,
      ),
    );
  }
}
