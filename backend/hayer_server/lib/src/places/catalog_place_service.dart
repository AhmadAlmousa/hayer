import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'catalog_spatial_query.dart';
import 'google_web_place_source.dart';
import 'place_candidate.dart';
import 'place_search_policy.dart';
import 'place_search_service.dart';
import 'place_source.dart';
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
  static final Map<String, Future<List<PlaceSnapshot>>> _inFlightRefreshes = {};

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
    final rows = await PoiCatalogRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(placeIds.toSet()) &
          table.countryCode.equals(countryCode) &
          table.quarantinedAt.equals(null),
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
  }) async {
    final queries = await TaxonomyService.resolve(
      session,
      categoryId,
      subcategoryIds,
    );
    final settings = await _settings(session);
    final now = DateTime.now().toUtc();
    final requiredCategoryIds = subcategoryIds.isEmpty
        ? {categoryId}
        : subcategoryIds.toSet();
    final persistedCategoryIds = {categoryId, ...subcategoryIds};
    final coverageCategories = persistedCategoryIds.toList()..sort();
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
        coverage.resultCount >= deckSize;
    final nearby = await _nearbyCatalog(
      session,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      countryCode: countryCode,
      seenAfter: now.subtract(Duration(days: settings.staleFallbackDays)),
    );
    final freshAfter = now.subtract(Duration(hours: settings.freshHours));
    final fresh = nearby
        .where(
          (row) =>
              !row.sourceCheckedAt.isBefore(freshAfter) &&
              row.categoryIds.any(requiredCategoryIds.contains),
        )
        .map(_candidateFromRow)
        .toList(growable: false);
    final cachedDeck = policy.select(
      candidates: fresh,
      anchorLatitude: latitude,
      anchorLongitude: longitude,
      radiusMeters: radiusMeters,
      deckSize: deckSize,
      maximumPriceLevel: maximumPriceLevel,
    );
    if (coverageIsFresh && cachedDeck.length >= deckSize) {
      await _metric(session, 'cache_hit_rate', 1);
      return cachedDeck;
    }

    final refreshKey = [
      countryCode,
      latitude.toStringAsFixed(3),
      longitude.toStringAsFixed(3),
      radiusMeters,
      requiredCategoryIds.toList()..sort(),
      deckSize,
      maximumPriceLevel ?? 'any',
    ].join(':');
    Future<List<PlaceSnapshot>>? refresh;
    try {
      refresh = _inFlightRefreshes.putIfAbsent(
        refreshKey,
        () => _refresh(
          session,
          settings: settings,
          categoryId: categoryId,
          subcategoryIds: subcategoryIds,
          categoryIds: persistedCategoryIds,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          deckSize: deckSize,
          maximumPriceLevel: maximumPriceLevel,
          countryCode: countryCode,
          now: now,
          queries: queries,
        ),
      );
      final live = await refresh;
      await _metric(session, 'cache_hit_rate', 0);
      await _metric(session, 'source_success_rate', 1);
      return live;
    } on PlaceSourceException {
      await _metric(session, 'source_success_rate', 0);
      final stale = nearby
          .where((row) => row.categoryIds.any(requiredCategoryIds.contains))
          .map(_candidateFromRow)
          .toList(growable: false);
      final fallback = policy.select(
        candidates: stale,
        anchorLatitude: latitude,
        anchorLongitude: longitude,
        radiusMeters: radiusMeters,
        deckSize: deckSize,
        maximumPriceLevel: maximumPriceLevel,
        stale: true,
      );
      if (fallback.isNotEmpty) return fallback;
      rethrow;
    } finally {
      if (identical(_inFlightRefreshes[refreshKey], refresh)) {
        _inFlightRefreshes.remove(refreshKey)?.ignore();
      }
    }
  }

  Future<List<PlaceSnapshot>> _refresh(
    Session session, {
    required _CatalogSettings settings,
    required String categoryId,
    required List<String> subcategoryIds,
    required Set<String> categoryIds,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required int deckSize,
    required int? maximumPriceLevel,
    required String countryCode,
    required DateTime now,
    required List<PlaceQuery> queries,
  }) async {
    final typedSource = source;
    if (typedSource is GoogleWebPlaceSource) {
      typedSource.configureRateLimit(
        requestsPerMinute: settings.globalRequestsPerMinute,
        burst: settings.globalBurst,
      );
    }
    final liveSearch = PlaceSearchService(
      source: source,
      concurrency: settings.perCreationConcurrency,
    );
    final deadline = DateTime.now().add(const Duration(seconds: 30));
    PlaceSourceException? failure;
    for (var attempt = 0; attempt < settings.extractorAttempts; attempt++) {
      final remaining = deadline.difference(DateTime.now());
      if (remaining <= Duration.zero) break;
      try {
        final live = await liveSearch
            .buildDeck(
              categoryId: categoryId,
              subcategoryIds: subcategoryIds,
              latitude: latitude,
              longitude: longitude,
              radiusMeters: radiusMeters,
              deckSize: deckSize,
              maximumPriceLevel: maximumPriceLevel,
              countryCode: countryCode,
              queries: queries,
            )
            .timeout(remaining);
        await _persist(
          session,
          live,
          categoryIds: categoryIds,
          countryCode: countryCode,
          latitude: latitude,
          longitude: longitude,
          radiusMeters: radiusMeters,
          now: now,
          freshHours: settings.freshHours,
        );
        return live;
      } on PlaceSourceException catch (error) {
        failure = error;
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
  }

  Future<List<PoiCatalogRow>> _nearbyCatalog(
    Session session, {
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required String countryCode,
    required DateTime seenAfter,
  }) async {
    final parameters = QueryParameters.named({
      'country': countryCode,
      'seenAfter': seenAfter,
      'longitude': longitude,
      'latitude': latitude,
      'radius': radiusMeters,
    });
    late final DatabaseResult spatialRows;
    try {
      spatialRows = await session.db.unsafeQuery(
        nearbyCatalogByLocationSql,
        parameters: parameters,
      );
    } on DatabaseQueryException catch (error, stackTrace) {
      if (!isMissingCatalogLocation(error)) rethrow;
      session.log(
        'PostGIS location column is unavailable; using coordinate fallback.',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      spatialRows = await session.db.unsafeQuery(
        nearbyCatalogByCoordinatesSql,
        parameters: parameters,
      );
    }
    final identities = spatialRows
        .map((row) => row.toColumnMap()['providerPlaceId'] as String)
        .toSet();
    if (identities.isEmpty) return const [];
    return PoiCatalogRow.db.find(
      session,
      where: (table) =>
          table.provider.equals('google-web') &
          table.providerPlaceId.inSet(identities),
      limit: 500,
    );
  }

  Future<void> _persist(
    Session session,
    List<PlaceSnapshot> places, {
    required Set<String> categoryIds,
    required String countryCode,
    required double latitude,
    required double longitude,
    required int radiusMeters,
    required DateTime now,
    required int freshHours,
  }) async {
    final queryKey = categoryIds.toList()..sort();
    final coverageKey = _coverageKey(
      categoryIds: queryKey,
      countryCode: countryCode,
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
    );
    await session.db.transaction((transaction) async {
      for (final place in places) {
        final existing = await PoiCatalogRow.db.findFirstRow(
          session,
          where: (table) =>
              table.provider.equals('google-web') &
              table.providerPlaceId.equals(place.placeId),
          transaction: transaction,
        );
        final mergedCategories = {
          ...?existing?.categoryIds,
          ...place.categoryIds,
          ...categoryIds,
        }.toList();
        final snapshot = place.copyWith(
          categoryIds: mergedCategories,
          sourceCheckedAt: now,
          isStale: false,
        );
        final row = PoiCatalogRow(
          id: existing?.id,
          provider: 'google-web',
          providerPlaceId: place.placeId,
          featureId: place.featureId,
          normalizedName: _normalizeName(place.name),
          name: place.name,
          countryCode: countryCode,
          latitude: place.latitude,
          longitude: place.longitude,
          categoryIds: mergedCategories,
          snapshot: snapshot,
          calibrationVersion: calibrationVersion,
          sourceCheckedAt: now,
          firstSeenAt: existing?.firstSeenAt ?? now,
          lastSeenAt: now,
          quarantinedAt: existing?.quarantinedAt,
          quarantineReason: existing?.quarantineReason,
        );
        if (existing == null) {
          await PoiCatalogRow.db.insertRow(
            session,
            row,
            transaction: transaction,
          );
        } else {
          await PoiCatalogRow.db.updateRow(
            session,
            row,
            transaction: transaction,
          );
        }
        for (final category in categoryIds) {
          final evidence = await PoiCategoryRow.db.findFirstRow(
            session,
            where: (table) =>
                table.provider.equals('google-web') &
                table.providerPlaceId.equals(place.placeId) &
                table.categoryId.equals(category),
            transaction: transaction,
          );
          final categoryRow = PoiCategoryRow(
            id: evidence?.id,
            provider: 'google-web',
            providerPlaceId: place.placeId,
            categoryId: category,
            evidenceQuery: category,
            firstSeenAt: evidence?.firstSeenAt ?? now,
            lastSeenAt: now,
          );
          if (evidence == null) {
            await PoiCategoryRow.db.insertRow(
              session,
              categoryRow,
              transaction: transaction,
            );
          } else {
            await PoiCategoryRow.db.updateRow(
              session,
              categoryRow,
              transaction: transaction,
            );
          }
        }
      }
      final existingCoverage = await PoiCoverageRow.db.findFirstRow(
        session,
        where: (table) => table.coverageKey.equals(coverageKey),
        transaction: transaction,
      );
      final coverage = PoiCoverageRow(
        id: existingCoverage?.id,
        coverageKey: coverageKey,
        queryKey: queryKey.join(','),
        language: 'en',
        countryCode: countryCode,
        anchorLatitude: latitude,
        anchorLongitude: longitude,
        radiusMeters: radiusMeters,
        calibrationVersion: calibrationVersion,
        resultCount: places.length,
        refreshedAt: now,
        expiresAt: now.add(Duration(hours: freshHours)),
      );
      if (existingCoverage == null) {
        await PoiCoverageRow.db.insertRow(
          session,
          coverage,
          transaction: transaction,
        );
      } else {
        await PoiCoverageRow.db.updateRow(
          session,
          coverage,
          transaction: transaction,
        );
      }
    });
  }

  PlaceCandidate _candidateFromRow(PoiCatalogRow row) {
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
      evidenceCategoryId: row.categoryIds.firstOrNull,
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

  String _normalizeName(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

  String _coverageKey({
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
}

class _CatalogSettings {
  const _CatalogSettings({
    required this.freshHours,
    required this.staleFallbackDays,
    required this.extractorAttempts,
    required this.perCreationConcurrency,
    required this.globalRequestsPerMinute,
    required this.globalBurst,
  });
  final int freshHours;
  final int staleFallbackDays;
  final int extractorAttempts;
  final int perCreationConcurrency;
  final int globalRequestsPerMinute;
  final int globalBurst;
}
