import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../discovery/discovery_metrics.dart';
import '../generated/protocol.dart';
import 'catalog_observation_writer.dart';
import 'catalog_persistence.dart';
import 'catalog_spatial_query.dart';
import 'google_web_place_source.dart';
import 'place_candidate.dart';
import 'place_search_policy.dart';
import 'place_search_service.dart';
import 'place_source.dart';
import 'provider_operation.dart';
import 'search_parser.dart';
import 'taxonomy.dart';
import 'taxonomy_service.dart';

class CatalogPlaceService {
  const CatalogPlaceService({
    required this.source,
    required this.calibrationVersion,
    this.policy = const PlaceSearchPolicy(),
  });

  final PlaceSource source;
  final String calibrationVersion;
  final PlaceSearchPolicy policy;
  static final Map<String, Future<_LiveCatalogRefresh>> _inFlightRefreshes = {};

  Future<List<PlaceSnapshot>> resolveShortlist(
    Session session, {
    required List<String> placeIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    int? maximumPriceLevel,
    required String countryCode,
  }) async {
    if (placeIds.isEmpty) return const [];
    final anchor = GeographyPoint(
      longitude: longitude,
      latitude: latitude,
    );
    final rows = await PoiCatalogRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(placeIds.toSet()) &
          table.countryCode.equals(countryCode) &
          table.quarantinedAt.equals(null) &
          table.location.distanceWithin(anchor, radiusMeters.toDouble()),
      limit: placeIds.length,
    );
    final settings = await _settings(session);
    final now = DateTime.now().toUtc();
    final retainedAfter = now.subtract(
      Duration(days: settings.staleFallbackDays),
    );
    final retained = rows
        .where((row) => !row.lastSeenAt.isBefore(retainedAfter))
        .toList(growable: false);
    final freshAfter = now.subtract(Duration(hours: settings.freshHours));
    final selected = policy.select(
      candidates: retained.map(_candidateFromRow),
      anchorLatitude: latitude,
      anchorLongitude: longitude,
      radiusMeters: radiusMeters,
      deckSize: placeIds.length,
      maximumPriceLevel: maximumPriceLevel,
      stale: retained.any((row) => row.sourceCheckedAt.isBefore(freshAfter)),
    );
    final selectedById = {
      for (final place in selected) place.placeId: place,
    };
    return [
      for (final placeId in placeIds) ?selectedById[placeId],
    ];
  }

  Future<List<PlaceSnapshot>> buildDeck(
    Session session, {
    required String categoryId,
    required List<String> subcategoryIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int deckSize,
    int? maximumPriceLevel,
    required String countryCode,
  }) async => (await buildDeckWithOutcome(
    session,
    categoryId: categoryId,
    subcategoryIds: subcategoryIds,
    latitude: latitude,
    longitude: longitude,
    radiusMeters: radiusMeters,
    deckSize: deckSize,
    maximumPriceLevel: maximumPriceLevel,
    countryCode: countryCode,
  )).deck;

  /// Builds a deck and reports whether it came from a complete live refresh,
  /// a partial live refresh, a fresh cache hit, or stale fallback.
  ///
  /// Dashboard refresh jobs set [forceRefresh] so a cache hit can never be
  /// mistaken for a successful source refresh. [onProviderOperation] exposes
  /// only an operation this call created; a coalesced refresh owned by another
  /// caller remains bounded by its existing deadline instead.
  Future<CatalogDeckOutcome> buildDeckWithOutcome(
    Session session, {
    required String categoryId,
    required List<String> subcategoryIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int deckSize,
    int? maximumPriceLevel,
    required String countryCode,
    bool forceRefresh = false,
    bool preserveFreshCachedSnapshots = false,
    bool allowShortFreshCache = false,
    void Function(ProviderOperation operation)? onProviderOperation,
    List<PlaceQuery>? queryOverride,
    Set<String>? requiredCategoryIdsOverride,
  }) async {
    final queries =
        queryOverride ??
        await TaxonomyService.resolve(
          session,
          categoryId,
          subcategoryIds,
        );
    final settings = await _settings(session);
    final now = DateTime.now().toUtc();
    final requiredCategoryIds =
        requiredCategoryIdsOverride ??
        (subcategoryIds.isEmpty ? {categoryId} : subcategoryIds.toSet());
    final coverageCategories = {categoryId, ...subcategoryIds}.toList()..sort();
    final coverageKey = _coverageKey(
      categoryIds: coverageCategories,
      countryCode: countryCode,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
    );
    final coverage = await PoiCoverageRow.db.findFirstRow(
      session,
      where: (table) => table.coverageKey.equals(coverageKey),
    );
    final coverageIsFresh =
        coverage != null &&
        coverage.invalidatedAt == null &&
        coverage.calibrationVersion == calibrationVersion &&
        coverage.expiresAt.isAfter(now) &&
        coverage.resultCount >= (allowShortFreshCache ? 1 : deckSize);
    final nearby = await _nearbyCatalog(
      session,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      countryCode: countryCode,
      seenAfter: now.subtract(Duration(days: settings.staleFallbackDays)),
      requiredCategoryIds: requiredCategoryIds,
      maximumPriceLevel: maximumPriceLevel,
    );
    final freshAfter = now.subtract(Duration(hours: settings.freshHours));
    final fresh = nearby
        .where((place) => !place.sourceCheckedAt.isBefore(freshAfter))
        .toList(growable: false);
    final cachedDeck = policy.select(
      candidates: fresh,
      anchorLatitude: latitude,
      anchorLongitude: longitude,
      radiusMeters: radiusMeters,
      deckSize: deckSize,
      maximumPriceLevel: maximumPriceLevel,
    );
    if (!forceRefresh &&
        coverageIsFresh &&
        (allowShortFreshCache
            ? cachedDeck.isNotEmpty
            : cachedDeck.length >= deckSize)) {
      await _metric(session, 'cache_hit_rate', 1);
      await DiscoveryMetrics.record(
        session,
        mode: DiscoveryMetricMode.swipe,
        operation: DiscoveryMetricOperation.search,
        cacheHits: 1,
      );
      return CatalogDeckOutcome(
        deck: cachedDeck,
        origin: CatalogDeckOrigin.freshCache,
      );
    }

    final refreshKey =
        catalogRefreshKey(
          calibrationVersion: calibrationVersion,
          parentCategoryId: categoryId,
          queries: queries,
          countryCode: countryCode,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          deckSize: deckSize,
          maximumPriceLevel: maximumPriceLevel,
        ) +
        (preserveFreshCachedSnapshots ? '|preserve-fresh-cache' : '');
    Future<_LiveCatalogRefresh>? refresh;
    try {
      refresh = _inFlightRefreshes.putIfAbsent(
        refreshKey,
        () => _refresh(
          session,
          settings: settings,
          categoryId: categoryId,
          subcategoryIds: subcategoryIds,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          deckSize: deckSize,
          maximumPriceLevel: maximumPriceLevel,
          countryCode: countryCode,
          now: now,
          queries: queries,
          requiredCategoryIds: requiredCategoryIds,
          preserveFreshCachedSnapshots: preserveFreshCachedSnapshots,
          onProviderOperation: onProviderOperation,
        ),
      );
      final live = await refresh;
      await _metric(session, 'cache_hit_rate', 0);
      await DiscoveryMetrics.record(
        session,
        mode: DiscoveryMetricMode.swipe,
        operation: DiscoveryMetricOperation.search,
        cacheMisses: 1,
      );
      await _metric(
        session,
        'source_success_rate',
        live.partialFailureCode == null ? 1 : 0,
      );
      return CatalogDeckOutcome(
        deck: live.deck,
        origin: live.partialFailureCode == null
            ? CatalogDeckOrigin.live
            : CatalogDeckOrigin.partialLive,
        sourceFailureCode: live.partialFailureCode,
      );
    } on PlaceSourceException catch (error) {
      await _metric(session, 'source_success_rate', 0);
      final fallback = policy.select(
        candidates: nearby,
        anchorLatitude: latitude,
        anchorLongitude: longitude,
        radiusMeters: radiusMeters,
        deckSize: deckSize,
        maximumPriceLevel: maximumPriceLevel,
        stale: true,
      );
      if (fallback.isNotEmpty) {
        return CatalogDeckOutcome(
          deck: fallback,
          origin: CatalogDeckOrigin.staleFallback,
          sourceFailureCode: error.code,
        );
      }
      rethrow;
    } finally {
      if (identical(_inFlightRefreshes[refreshKey], refresh)) {
        _inFlightRefreshes.remove(refreshKey)?.ignore();
      }
    }
  }

  Future<_LiveCatalogRefresh> _refresh(
    Session session, {
    required _CatalogSettings settings,
    required String categoryId,
    required List<String> subcategoryIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int deckSize,
    required int? maximumPriceLevel,
    required String countryCode,
    required DateTime now,
    required List<PlaceQuery> queries,
    required Set<String> requiredCategoryIds,
    required bool preserveFreshCachedSnapshots,
    void Function(ProviderOperation operation)? onProviderOperation,
  }) async {
    final typedSource = source;
    if (typedSource is GoogleWebPlaceSource) {
      typedSource.configureRateLimit(
        requestsPerMinute: settings.globalRequestsPerMinute,
        burst: settings.globalBurst,
      );
      typedSource.configurePhotos(
        count: settings.photoFetchCount,
        width: settings.photoWidth,
      );
    }
    final liveSearch = PlaceSearchService(
      source: source,
      concurrency: settings.perCreationConcurrency,
    );
    ProviderOperation? sourceOperation;
    try {
      final live = await ProviderOperation.run(
        () async {
          final operation = ProviderOperation.current!;
          PlaceSourceException? failure;
          for (
            var attempt = 0;
            attempt < settings.extractorAttempts;
            attempt++
          ) {
            operation.check();
            try {
              return await liveSearch.buildDeckWithObservations(
                categoryId: categoryId,
                subcategoryIds: subcategoryIds,
                latitude: latitude,
                longitude: longitude,
                radiusMeters: radiusMeters,
                deckSize: deckSize,
                maximumPriceLevel: maximumPriceLevel,
                countryCode: countryCode,
                queries: queries,
              );
            } on PlaceSourceException catch (error) {
              failure = error;
              if (error.code == 'rate_limited') break;
            } on TimeoutException catch (error) {
              failure = PlaceSourceException(
                'place_source_unavailable',
                'Place search exceeded the 30-second deadline.',
                cause: error,
              );
              break;
            }
          }
          throw failure ??
              const PlaceSourceException(
                'place_source_unavailable',
                'Place search exceeded the 30-second deadline.',
              );
        },
        onCreate: (operation) {
          sourceOperation = operation;
          onProviderOperation?.call(operation);
        },
      );
      // A completed source operation is persisted outside its cancellation
      // scope, so the request keeps awaiting an already-started DB transaction.
      final preservedPlaceIds = preserveFreshCachedSnapshots
          ? await _freshCachedPlaceIds(
              session,
              live.observed,
              countryCode: countryCode,
              freshAfter: now.subtract(Duration(hours: settings.freshHours)),
            )
          : const <String>{};
      await _persist(
        session,
        live.observed,
        parentCategoryId: categoryId,
        queries: queries,
        countryCode: countryCode,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        now: now,
        freshHours: settings.freshHours,
        partialFailureCode: live.partialFailureCode,
        preserveExistingCatalogRows: preservedPlaceIds,
      );
      // The provider can still return a place operators quarantined. Keep it
      // out of new decks, as the cache does, by choosing from the fresh
      // catalog rows this refresh just wrote.
      var deck = live.deck;
      if (deck.isNotEmpty &&
          await PoiCatalogRow.db.count(
                session,
                where: (table) =>
                    table.provider.equals('google-web') &
                    table.providerPlaceId.inSet({
                      for (final place in deck) place.placeId,
                    }) &
                    table.quarantinedAt.notEquals(null),
              ) >
              0) {
        final freshAfter = now.subtract(Duration(hours: settings.freshHours));
        final nearby = await _nearbyCatalog(
          session,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          countryCode: countryCode,
          seenAfter: now.subtract(Duration(days: settings.staleFallbackDays)),
          requiredCategoryIds: requiredCategoryIds,
          maximumPriceLevel: maximumPriceLevel,
        );
        deck = policy.select(
          candidates: nearby
              .where((place) => !place.sourceCheckedAt.isBefore(freshAfter))
              .toList(growable: false),
          anchorLatitude: latitude,
          anchorLongitude: longitude,
          radiusMeters: radiusMeters,
          deckSize: deckSize,
          maximumPriceLevel: maximumPriceLevel,
        );
      }
      return _LiveCatalogRefresh(
        deck: deck,
        partialFailureCode: live.partialFailureCode,
      );
    } finally {
      if (sourceOperation case final operation?) {
        await DiscoveryMetrics.record(
          session,
          mode: DiscoveryMetricMode.swipe,
          operation: DiscoveryMetricOperation.search,
          upstreamRequests: math.min(
            operation.requestCount,
            operation.maximumRequests,
          ),
        );
      }
    }
  }

  Future<List<PlaceCandidate>> _nearbyCatalog(
    Session session, {
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String countryCode,
    required DateTime seenAfter,
    required Set<String> requiredCategoryIds,
    required int? maximumPriceLevel,
  }) async {
    final sortedCategoryIds = requiredCategoryIds.toList()..sort();
    final evidencePrefix = catalogEvidencePrefix(calibrationVersion);
    final parameters = QueryParameters.named({
      'country': countryCode,
      'seenAfter': seenAfter,
      'longitude': longitude,
      'latitude': latitude,
      'radius': radiusMeters,
      'categoryIds': jsonEncode(sortedCategoryIds),
      'evidencePrefix': evidencePrefix,
      'maximumPriceLevel': maximumPriceLevel ?? -1,
    });
    final spatialRows = await session.db.unsafeQuery(
      nearbyCatalogByLocationSql,
      parameters: parameters,
    );
    final identities = spatialRows
        .map((row) => row.toColumnMap()['providerPlaceId'] as String)
        .toSet();
    if (identities.isEmpty) return const [];
    final rows = await PoiCatalogRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(identities) &
          table.countryCode.equals(countryCode) &
          table.quarantinedAt.equals(null),
      limit: 500,
    );
    final evidenceRows = await PoiCategoryRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(identities) &
          table.categoryId.inSet(requiredCategoryIds),
      limit: identities.length * requiredCategoryIds.length,
    );
    final evidenceByPlace = <String, Set<String>>{};
    for (final evidence in evidenceRows) {
      if (evidence.lastSeenAt.isBefore(seenAfter) ||
          !evidence.evidenceQuery.startsWith(evidencePrefix)) {
        continue;
      }
      (evidenceByPlace[evidence.providerPlaceId] ??= {}).add(
        evidence.categoryId,
      );
    }
    return [
      for (final row in rows)
        if (evidenceByPlace[row.providerPlaceId]?.isNotEmpty ?? false)
          _candidateFromRow(
            row,
            evidenceCategoryIds: evidenceByPlace[row.providerPlaceId]!.toList()
              ..sort(),
          ),
    ];
  }

  Future<Set<String>> _freshCachedPlaceIds(
    Session session,
    List<PlaceSnapshot> places, {
    required String countryCode,
    required DateTime freshAfter,
  }) async {
    final placeIds = {for (final place in places) place.placeId};
    if (placeIds.isEmpty) return const {};
    final rows = await PoiCatalogRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(placeIds) &
          table.countryCode.equals(countryCode) &
          table.quarantinedAt.equals(null),
      limit: placeIds.length,
    );
    return {
      for (final row in rows)
        if (row.calibrationVersion == calibrationVersion &&
            !row.sourceCheckedAt.isBefore(freshAfter))
          row.providerPlaceId,
    };
  }

  Future<void> _persist(
    Session session,
    List<PlaceSnapshot> places, {
    required String parentCategoryId,
    required List<PlaceQuery> queries,
    required String countryCode,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required DateTime now,
    required int freshHours,
    required String? partialFailureCode,
    required Set<String> preserveExistingCatalogRows,
  }) async {
    final queryKey = {
      parentCategoryId,
      ...queries.map((query) => query.categoryId),
    }.toList()..sort();
    final coverageKey = _coverageKey(
      categoryIds: queryKey,
      countryCode: countryCode,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
    );
    await CatalogObservationWriter(
      calibrationVersion: calibrationVersion,
    ).write(
      session,
      places,
      countryCode: countryCode,
      observedAt: now,
      evidence: CatalogObservationEvidence(
        parentCategoryId: parentCategoryId,
        queries: queries,
      ),
      preserveExistingCatalogRows: preserveExistingCatalogRows,
      coverage: CatalogObservationCoverage(
        coverageKey: coverageKey,
        queryKey: queryKey.join(','),
        countryCode: countryCode,
        latitude: latitude,
        longitude: longitude,
        radiusMeters: radiusMeters,
        refreshedAt: now,
        expiresAt: now.add(Duration(hours: freshHours)),
        failureCode: partialFailureCode,
      ),
      metrics: const CatalogObservationMetrics(
        mode: DiscoveryMetricMode.swipe,
        operation: DiscoveryMetricOperation.search,
      ),
    );
  }

  PlaceCandidate _candidateFromRow(
    PoiCatalogRow row, {
    List<String> evidenceCategoryIds = const [],
  }) {
    final place = row.snapshot;
    return PlaceCandidate(
      placeId: place.placeId,
      featureId: place.featureId,
      name: place.name,
      primaryType: place.primaryType,
      categoryIds: row.categoryIds,
      rating: place.rating,
      reviewCount: place.reviewCount,
      priceLevel: place.priceLevel,
      priceText: place.priceText,
      isOpen: place.isOpen,
      statusText: place.statusText,
      hours: place.hours,
      latitude: row.latitude,
      longitude: row.longitude,
      address: place.address,
      formattedAddress: place.formattedAddress,
      phoneNumber: place.phoneNumber,
      websiteUrl: place.websiteUrl,
      mapsUrl: place.mapsUrl,
      photoUrls: place.photoUrls,
      featuredReview: place.featuredReview,
      editorialSummary: place.editorialSummary,
      attributions: place.attributions,
      sourceCheckedAt: row.sourceCheckedAt,
      evidenceCategoryIds: evidenceCategoryIds,
    );
  }

  Future<_CatalogSettings> _settings(Session session) async {
    final row = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    return _CatalogSettings(
      freshHours: row?.freshHours ?? 72,
      staleFallbackDays: row?.staleFallbackDays ?? 30,
      extractorAttempts: row?.extractorAttempts ?? 2,
      perCreationConcurrency: row?.perCreationConcurrency ?? 3,
      globalRequestsPerMinute: row?.globalRequestsPerMinute ?? 30,
      globalBurst: row?.globalBurst ?? 6,
      photoFetchCount: row?.photoFetchCount ?? SearchParser.defaultPhotoLimit,
      photoWidth: row?.photoWidth ?? SearchParser.defaultPhotoWidth,
    );
  }

  Future<void> _metric(Session session, String name, double value) async {
    final bucket = DateTime.now().toUtc();
    final bucketStart = DateTime.utc(
      bucket.year,
      bucket.month,
      bucket.day,
      bucket.hour,
    );
    await OperationalMetricRow.db.insertRow(
      session,
      OperationalMetricRow(
        bucketStartedAt: bucketStart,
        metricName: name,
        dimensions: const {},
        metricValue: value,
        sampleCount: 1,
      ),
    );
  }

  String _coverageKey({
    required List<String> categoryIds,
    required String countryCode,
    required double latitude,
    required double longitude,
    required int radiusMeters,
  }) => catalogCoverageKey(
    categoryIds: categoryIds,
    countryCode: countryCode,
    latitude: latitude,
    longitude: longitude,
    radiusMeters: radiusMeters,
  );
}

enum CatalogDeckOrigin { freshCache, live, partialLive, staleFallback }

class CatalogDeckOutcome {
  const CatalogDeckOutcome({
    required this.deck,
    required this.origin,
    this.sourceFailureCode,
  });

  final List<PlaceSnapshot> deck;
  final CatalogDeckOrigin origin;
  final String? sourceFailureCode;
}

class _LiveCatalogRefresh {
  const _LiveCatalogRefresh({
    required this.deck,
    required this.partialFailureCode,
  });

  final List<PlaceSnapshot> deck;
  final String? partialFailureCode;
}

/// The Swipe coverage key for sorted [categoryIds] around an anchor. Discover
/// harvests reuse it to write coverage Swipe reads.
String catalogCoverageKey({
  required List<String> categoryIds,
  required String countryCode,
  required double latitude,
  required double longitude,
  required int radiusMeters,
}) => sha256
    .convert(
      '${countryCode}_${latitude.toStringAsFixed(3)}_'
              '${longitude.toStringAsFixed(3)}_${radiusMeters}_'
              '${categoryIds.join(',')}'
          .codeUnits,
    )
    .toString();

String catalogRefreshKey({
  required String calibrationVersion,
  required String parentCategoryId,
  required List<PlaceQuery> queries,
  required String countryCode,
  required double latitude,
  required double longitude,
  required int radiusMeters,
  required int deckSize,
  required int? maximumPriceLevel,
}) {
  final request = <String, Object?>{
    'calibrationVersion': calibrationVersion,
    'parentCategoryId': parentCategoryId,
    'queries': [
      for (final query in queries)
        {
          'categoryId': query.categoryId,
          'query': query.query,
          'arabicFallbackQuery': query.arabicFallbackQuery,
        },
    ],
    'countryCode': countryCode,
    'latitude': latitude,
    'longitude': longitude,
    'radiusMeters': radiusMeters,
    'deckSize': deckSize,
    'maximumPriceLevel': maximumPriceLevel,
  };
  return sha256.convert(utf8.encode(jsonEncode(request))).toString();
}

class _CatalogSettings {
  const _CatalogSettings({
    required this.freshHours,
    required this.staleFallbackDays,
    required this.extractorAttempts,
    required this.perCreationConcurrency,
    required this.globalRequestsPerMinute,
    required this.globalBurst,
    required this.photoFetchCount,
    required this.photoWidth,
  });
  final int freshHours;
  final int staleFallbackDays;
  final int extractorAttempts;
  final int perCreationConcurrency;
  final int globalRequestsPerMinute;
  final int globalBurst;
  final int photoFetchCount;
  final int photoWidth;
}
