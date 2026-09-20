import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Loads and validates the persisted policy shared by Swipe and Discover.
abstract final class DiscoveryPolicyService {
  static DiscoveryScoring defaultScoring() => DiscoveryScoring(
    bestFormula: DiscoveryBestFormula.popularityWeighted,
    gemMinimumRating: 4.5,
    gemMinimumReviews: 1,
    gemMaximumReviewsExclusive: 500,
    bayesianPriorReviews: 100,
    bayesianMeanRating: 4.0,
    bestMinimumReviews: 1,
    topRatedMinimumReviews: 0,
    worstRatedMinimumReviews: 0,
    recentlyAddedDays: 45,
  );

  static DiscoveryPolicy defaultDiscovery() => DiscoveryPolicy(
    enabled: false,
    scoring: defaultScoring(),
    harvestMaximumRequests: 24,
    harvestDesiredCandidatesPerQuery: 50,
    harvestMaximumSeconds: 300,
    harvestCooldownMinutes: 60,
    // Exploring used to need a Search this area tap, so three an hour was a
    // generous allowance. It now follows the camera into any area that has no
    // fresh coverage, and three would run out in a minute of browsing. Still
    // admin-tunable, and a denial leaves cached results on screen.
    userHarvestsPerHour: 12,
    browseRequestsPerMinute: 30,
    facetRequestsPerMinute: 60,
    queryTimeoutMilliseconds: 2000,
    maximumPageSize: 100,
    maximumMapPoints: 2000,
    // Newly observed provider types attach themselves to the Discover tree.
    // Off, every new type counts under Other until an operator maps it.
    typeAutoMapEnabled: true,
  );

  static PlaceDetailPolicy defaultDetailRefresh() => PlaceDetailPolicy(
    maximumRequests: 3,
    maximumSeconds: 20,
    cooldownMinutes: 60,
  );

  static PhotoPolicy defaultPhotos() =>
      PhotoPolicy(fetchCount: 6, width: 1200, cacheCount: 400, cacheDays: 14);

  static CachePolicy defaultPolicy() => CachePolicy(
    version: 0,
    freshHours: 72,
    staleFallbackDays: 30,
    retentionDays: 365,
    extractorAttempts: 2,
    perCreationConcurrency: 3,
    globalRequestsPerMinute: 30,
    globalBurst: 6,
    routeEstimatesEnabled: true,
    allowParticipantLocation: true,
    defaultRouteOrigin: RouteOriginMode.sessionAnchor,
    routeEstimateCacheMinutes: 10,
    routeRequestsPerMinute: 30,
    routeBurst: 6,
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    discovery: defaultDiscovery(),
    detailRefresh: defaultDetailRefresh(),
    photos: defaultPhotos(),
  );

  static Future<CacheSettingsRow?> settings(
    Session session, {
    Transaction? transaction,
    LockMode? lockMode,
  }) => CacheSettingsRow.db.findFirstRow(
    session,
    where: (table) => table.settingsKey.equals('default'),
    transaction: transaction,
    lockMode: lockMode,
  );

  static Future<CachePolicy> load(Session session) async {
    final row = await settings(session);
    return row == null ? defaultPolicy() : fromRow(row);
  }

  static CachePolicy fromRow(CacheSettingsRow row) => CachePolicy(
    version: row.version,
    freshHours: row.freshHours,
    staleFallbackDays: row.staleFallbackDays,
    retentionDays: row.retentionDays,
    extractorAttempts: row.extractorAttempts,
    perCreationConcurrency: row.perCreationConcurrency,
    globalRequestsPerMinute: row.globalRequestsPerMinute,
    globalBurst: row.globalBurst,
    routeEstimatesEnabled: row.routeEstimatesEnabled,
    allowParticipantLocation: row.allowParticipantLocation,
    defaultRouteOrigin: row.defaultRouteOrigin,
    routeEstimateCacheMinutes: row.routeEstimateCacheMinutes,
    routeRequestsPerMinute: row.routeRequestsPerMinute,
    routeBurst: row.routeBurst,
    updatedAt: row.updatedAt,
    discovery: DiscoveryPolicy(
      enabled: row.discoveryEnabled,
      scoring: DiscoveryScoring(
        bestFormula: row.discoveryBestFormula,
        gemMinimumRating: row.discoveryGemMinimumRating,
        gemMinimumReviews: row.discoveryGemMinimumReviews,
        gemMaximumReviewsExclusive: row.discoveryGemMaximumReviewsExclusive,
        bayesianPriorReviews: row.discoveryBayesianPriorReviews,
        bayesianMeanRating: row.discoveryBayesianMeanRating,
        bestMinimumReviews: row.discoveryBestMinimumReviews,
        topRatedMinimumReviews: row.discoveryTopRatedMinimumReviews,
        worstRatedMinimumReviews: row.discoveryWorstRatedMinimumReviews,
        recentlyAddedDays: row.discoveryRecentlyAddedDays,
      ),
      harvestMaximumRequests: row.discoveryHarvestMaximumRequests,
      harvestDesiredCandidatesPerQuery:
          row.discoveryHarvestDesiredCandidatesPerQuery,
      harvestMaximumSeconds: row.discoveryHarvestMaximumSeconds,
      harvestCooldownMinutes: row.discoveryHarvestCooldownMinutes,
      userHarvestsPerHour: row.discoveryUserHarvestsPerHour,
      browseRequestsPerMinute: row.discoveryBrowseRequestsPerMinute,
      facetRequestsPerMinute: row.discoveryFacetRequestsPerMinute,
      queryTimeoutMilliseconds: row.discoveryQueryTimeoutMilliseconds,
      maximumPageSize: row.discoveryMaximumPageSize,
      maximumMapPoints: row.discoveryMaximumMapPoints,
      typeAutoMapEnabled: row.discoveryTypeAutoMapEnabled,
    ),
    detailRefresh: PlaceDetailPolicy(
      maximumRequests: row.detailRefreshMaximumRequests,
      maximumSeconds: row.detailRefreshMaximumSeconds,
      cooldownMinutes: row.detailRefreshCooldownMinutes,
    ),
    photos: PhotoPolicy(
      fetchCount: row.photoFetchCount,
      width: row.photoWidth,
      cacheCount: row.photoCacheCount,
      cacheDays: row.photoCacheDays,
    ),
  );

  /// Resolves nullable additive sections against their persisted values.
  ///
  /// Older generated clients omit these fields. Treating omission as a reset
  /// would let an unrelated policy edit disable or weaken Discover settings.
  static CachePolicy resolveAdditiveSections(
    CachePolicy incoming,
    CacheSettingsRow? existing,
  ) {
    final current = existing == null ? defaultPolicy() : fromRow(existing);
    return incoming.copyWith(
      discovery: incoming.discovery ?? current.discovery,
      detailRefresh: incoming.detailRefresh ?? current.detailRefresh,
      photos: incoming.photos ?? current.photos,
    );
  }

  static CacheSettingsRow toRow(
    CachePolicy policy, {
    required CacheSettingsRow? existing,
    required String updatedBy,
    required DateTime updatedAt,
  }) {
    final discovery = policy.discovery!;
    final scoring = discovery.scoring;
    final detail = policy.detailRefresh!;
    final photos = policy.photos!;
    return CacheSettingsRow(
      id: existing?.id,
      settingsKey: 'default',
      version: policy.version + 1,
      freshHours: policy.freshHours,
      staleFallbackDays: policy.staleFallbackDays,
      retentionDays: policy.retentionDays,
      extractorAttempts: policy.extractorAttempts,
      perCreationConcurrency: policy.perCreationConcurrency,
      globalRequestsPerMinute: policy.globalRequestsPerMinute,
      globalBurst: policy.globalBurst,
      routeEstimatesEnabled: policy.routeEstimatesEnabled,
      allowParticipantLocation: policy.allowParticipantLocation,
      defaultRouteOrigin: policy.defaultRouteOrigin,
      routeEstimateCacheMinutes: policy.routeEstimateCacheMinutes,
      routeRequestsPerMinute: policy.routeRequestsPerMinute,
      routeBurst: policy.routeBurst,
      discoveryEnabled: discovery.enabled,
      discoveryBestFormula: scoring.bestFormula,
      discoveryGemMinimumRating: scoring.gemMinimumRating,
      discoveryGemMinimumReviews: scoring.gemMinimumReviews,
      discoveryGemMaximumReviewsExclusive: scoring.gemMaximumReviewsExclusive,
      discoveryBayesianPriorReviews: scoring.bayesianPriorReviews,
      discoveryBayesianMeanRating: scoring.bayesianMeanRating,
      discoveryBestMinimumReviews: scoring.bestMinimumReviews,
      discoveryTopRatedMinimumReviews: scoring.topRatedMinimumReviews,
      discoveryWorstRatedMinimumReviews: scoring.worstRatedMinimumReviews,
      discoveryRecentlyAddedDays: scoring.recentlyAddedDays,
      discoveryHarvestMaximumRequests: discovery.harvestMaximumRequests,
      discoveryHarvestDesiredCandidatesPerQuery:
          discovery.harvestDesiredCandidatesPerQuery,
      discoveryHarvestMaximumSeconds: discovery.harvestMaximumSeconds,
      discoveryHarvestCooldownMinutes: discovery.harvestCooldownMinutes,
      discoveryUserHarvestsPerHour: discovery.userHarvestsPerHour,
      discoveryBrowseRequestsPerMinute: discovery.browseRequestsPerMinute,
      discoveryFacetRequestsPerMinute: discovery.facetRequestsPerMinute,
      discoveryQueryTimeoutMilliseconds: discovery.queryTimeoutMilliseconds,
      discoveryMaximumPageSize: discovery.maximumPageSize,
      discoveryMaximumMapPoints: discovery.maximumMapPoints,
      discoveryTypeAutoMapEnabled: discovery.typeAutoMapEnabled,
      detailRefreshMaximumRequests: detail.maximumRequests,
      detailRefreshMaximumSeconds: detail.maximumSeconds,
      detailRefreshCooldownMinutes: detail.cooldownMinutes,
      photoFetchCount: photos.fetchCount,
      photoWidth: photos.width,
      photoCacheCount: photos.cacheCount,
      photoCacheDays: photos.cacheDays,
      updatedBy: updatedBy,
      updatedAt: updatedAt,
    );
  }

  static void validate(CachePolicy policy) {
    final discovery = policy.discovery;
    final detail = policy.detailRefresh;
    final photos = policy.photos;
    if (policy.freshHours < 1 ||
        policy.freshHours > 720 ||
        policy.staleFallbackDays < 1 ||
        policy.staleFallbackDays > 180 ||
        policy.freshHours > policy.staleFallbackDays * 24 ||
        policy.retentionDays < 30 ||
        policy.retentionDays < policy.staleFallbackDays ||
        policy.retentionDays > 730 ||
        policy.extractorAttempts < 1 ||
        policy.extractorAttempts > 3 ||
        policy.perCreationConcurrency < 1 ||
        policy.perCreationConcurrency > 5 ||
        policy.globalRequestsPerMinute < 1 ||
        policy.globalRequestsPerMinute > 300 ||
        policy.globalBurst < 1 ||
        policy.globalBurst > 30 ||
        policy.routeEstimateCacheMinutes < 1 ||
        policy.routeEstimateCacheMinutes > 120 ||
        policy.routeRequestsPerMinute < 1 ||
        policy.routeRequestsPerMinute > 300 ||
        policy.routeBurst < 1 ||
        policy.routeBurst > 30 ||
        (!policy.allowParticipantLocation &&
            policy.defaultRouteOrigin == RouteOriginMode.participantLocation) ||
        discovery == null ||
        detail == null ||
        photos == null ||
        !_validDiscovery(discovery) ||
        !_validDetail(detail) ||
        !_validPhotos(photos)) {
      throw ApiException(
        code: 'bad_request',
        message: 'One or more policy values are outside safe bounds.',
      );
    }
  }

  /// Bounds photo counts and widths. The ceilings matter: each extra photo is
  /// another URL stored on every catalog row and another file on every device
  /// that opens the place, and the width multiplies both.
  static bool _validPhotos(PhotoPolicy policy) =>
      policy.fetchCount >= 1 &&
      policy.fetchCount <= 10 &&
      policy.width >= 400 &&
      policy.width <= 2400 &&
      policy.cacheCount >= 20 &&
      policy.cacheCount <= 2000 &&
      policy.cacheDays >= 1 &&
      policy.cacheDays <= 90;

  static bool _validDiscovery(DiscoveryPolicy policy) {
    final scoring = policy.scoring;
    return scoring.gemMinimumRating >= 0 &&
        scoring.gemMinimumRating <= 5 &&
        scoring.gemMinimumReviews >= 1 &&
        scoring.gemMinimumReviews < scoring.gemMaximumReviewsExclusive &&
        scoring.gemMaximumReviewsExclusive <= 10000000 &&
        scoring.bayesianPriorReviews >= 1 &&
        scoring.bayesianPriorReviews <= 10000000 &&
        scoring.bayesianMeanRating >= 0 &&
        scoring.bayesianMeanRating <= 5 &&
        scoring.bestMinimumReviews >= 0 &&
        scoring.bestMinimumReviews <= 10000000 &&
        scoring.topRatedMinimumReviews >= 0 &&
        scoring.topRatedMinimumReviews <= 10000000 &&
        scoring.worstRatedMinimumReviews >= 0 &&
        scoring.worstRatedMinimumReviews <= 10000000 &&
        scoring.recentlyAddedDays >= 1 &&
        scoring.recentlyAddedDays <= 3650 &&
        policy.harvestMaximumRequests >= 1 &&
        policy.harvestMaximumRequests <= 100 &&
        policy.harvestDesiredCandidatesPerQuery >= 1 &&
        policy.harvestDesiredCandidatesPerQuery <= 500 &&
        policy.harvestMaximumSeconds >= 1 &&
        policy.harvestMaximumSeconds <= 600 &&
        policy.harvestCooldownMinutes >= 1 &&
        policy.harvestCooldownMinutes <= 10080 &&
        policy.userHarvestsPerHour >= 1 &&
        policy.userHarvestsPerHour <= 60 &&
        policy.browseRequestsPerMinute >= 1 &&
        policy.browseRequestsPerMinute <= 600 &&
        policy.facetRequestsPerMinute >= 1 &&
        policy.facetRequestsPerMinute <= 600 &&
        policy.queryTimeoutMilliseconds >= 100 &&
        policy.queryTimeoutMilliseconds <= 30000 &&
        policy.maximumPageSize >= 1 &&
        policy.maximumPageSize <= 100 &&
        policy.maximumMapPoints >= 1 &&
        policy.maximumMapPoints <= 5000;
  }

  static bool _validDetail(PlaceDetailPolicy policy) =>
      policy.maximumRequests >= 1 &&
      policy.maximumRequests <= 20 &&
      policy.maximumSeconds >= 1 &&
      policy.maximumSeconds <= 120 &&
      policy.cooldownMinutes >= 1 &&
      policy.cooldownMinutes <= 10080;
}
