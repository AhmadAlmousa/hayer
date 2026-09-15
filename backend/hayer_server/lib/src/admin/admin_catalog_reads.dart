import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../analytics/product_analytics.dart';
import '../generated/protocol.dart';

/// Admin reads over the shared POI catalog: a filtered, ordered page with
/// its type counts, a density grid for the heat map, and everything the
/// catalog holds about one place.
///
/// The list, its type counts and the heat map take the same
/// [AdminCatalogQuery], so they always describe the same places. Each read
/// runs in one transaction under a statement timeout.
abstract final class AdminCatalogReads {
  /// The widest map view, in degrees, a read accepts.
  static const maximumSpanDegrees = 60.0;
  static const heatGridCells = 64;
  static const typeCountLimit = 30;
  static const defaultFreshHours = 72;
  static const analyticsWindow = Duration(days: 90);
  static const recentReportLimit = 10;
  static const evidenceLimit = 50;
  static const statementTimeout = Duration(seconds: 15);

  static Future<AdminCatalogPage> page(
    Session session, {
    required AdminCatalogQuery query,
    required int page,
    required int pageSize,
  }) async {
    _validate(query);
    final safePage = page.clamp(0, 100000);
    final safeSize = pageSize.clamp(1, 100);
    final filters = _Filters(query, await _freshAfter(session));
    return _read(session, (reader) async {
      final total =
          (await reader.query('''
SELECT COUNT(*)::int AS total
FROM "hayer_poi_catalog" AS catalog
WHERE ${filters.where()}
''', filters.parameters)).single['total']
              as int;
      final rows = await reader.query(
        '''
SELECT $_placeColumns
FROM "hayer_poi_catalog" AS catalog
WHERE ${filters.where()}
ORDER BY ${filters.order}, catalog."catalogId"
LIMIT @limit OFFSET @offset
''',
        {
          ...filters.parameters,
          'limit': safeSize,
          'offset': safePage * safeSize,
        },
      );
      final types = await reader.query(
        '''
SELECT catalog.primary_type AS primary_type, COUNT(*)::int AS places
FROM "hayer_poi_catalog" AS catalog
WHERE ${filters.where(withType: false)}
  AND catalog.primary_type IS NOT NULL
GROUP BY catalog.primary_type
ORDER BY places DESC, catalog.primary_type COLLATE "C"
LIMIT $typeCountLimit
''',
        filters.parameters,
      );
      return AdminCatalogPage(
        items: [for (final row in rows) _place(row)],
        total: total,
        page: safePage,
        pageSize: safeSize,
        types: [
          for (final row in types)
            AdminCatalogTypeCount(
              primaryType: row['primary_type'] as String,
              count: row['places'] as int,
            ),
        ],
        freshAfter: filters.freshAfter,
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  /// Place counts in a [heatGridCells] square grid over the query's
  /// viewport, each placed at the mean position of its places.
  static Future<AdminCatalogHeatmap> heatmap(
    Session session, {
    required AdminCatalogQuery query,
  }) async {
    final viewport = query.viewport;
    if (viewport == null) {
      throw ApiException(
        code: 'bad_request',
        message: 'The heat map needs the map bounds.',
      );
    }
    _validate(query);
    final filters = _Filters(query, await _freshAfter(session));
    return _read(session, (reader) async {
      final rows = await reader.query(
        '''
SELECT
  AVG(catalog.latitude) AS latitude,
  AVG(catalog.longitude) AS longitude,
  COUNT(*)::int AS places
FROM "hayer_poi_catalog" AS catalog
WHERE ${filters.where()}
GROUP BY
  LEAST(
    $heatGridCells - 1,
    GREATEST(0, floor((catalog.longitude - @west) / @cellWidth)::int)
  ),
  LEAST(
    $heatGridCells - 1,
    GREATEST(0, floor((catalog.latitude - @south) / @cellHeight)::int)
  )
''',
        {
          ...filters.parameters,
          'cellWidth': (viewport.east - viewport.west) / heatGridCells,
          'cellHeight': (viewport.north - viewport.south) / heatGridCells,
        },
      );
      final cells = [
        for (final row in rows)
          AdminCatalogHeatCell(
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            count: row['places'] as int,
          ),
      ];
      return AdminCatalogHeatmap(
        cells: cells,
        total: cells.fold(0, (sum, cell) => sum + cell.count),
        maximumCount: cells.fold(
          0,
          (top, cell) => cell.count > top ? cell.count : top,
        ),
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  static Future<AdminCatalogPlaceDetail> detail(
    Session session, {
    required int catalogId,
  }) async {
    final freshAfter = await _freshAfter(session);
    return _read(session, (reader) async {
      final rows = await reader.query(
        '''
SELECT
  $_placeColumns,
  catalog.snapshot::text AS snapshot_json,
  catalog."calibrationVersion",
  catalog."quarantineReason"
FROM "hayer_poi_catalog" AS catalog
WHERE catalog."catalogId" = @catalogId
''',
        {'catalogId': catalogId, 'freshAfter': freshAfter.toIso8601String()},
      );
      if (rows.isEmpty) {
        throw ApiException(
          code: 'not_found',
          message: 'That catalog place no longer exists.',
        );
      }
      final row = rows.single;
      final place = _place(row);
      final transaction = reader.transaction;
      final evidence = await PoiCategoryRow.db.find(
        session,
        where: (table) =>
            table.provider.equals(place.provider) &
            table.providerPlaceId.equals(place.placeId),
        orderBy: (table) => table.lastSeenAt,
        orderDescending: true,
        limit: evidenceLimit,
        transaction: transaction,
      );
      final refresh = await PoiDetailRefreshRow.db.findFirstRow(
        session,
        where: (table) =>
            table.provider.equals(place.provider) &
            table.providerPlaceId.equals(place.placeId),
        transaction: transaction,
      );
      final reportCount = await PoiIssueReportRow.db.count(
        session,
        where: (table) => table.placeId.equals(place.placeId),
        transaction: transaction,
      );
      final reports = await PoiIssueReportRow.db.find(
        session,
        where: (table) => table.placeId.equals(place.placeId),
        orderBy: (table) => table.createdAt,
        orderDescending: true,
        limit: recentReportLimit,
        transaction: transaction,
      );
      final deckAppearances = await SessionPlaceRow.db.count(
        session,
        where: (table) => table.placeId.equals(place.placeId),
        transaction: transaction,
      );
      final votes = (await reader.query(
        '''
SELECT
  COALESCE(SUM("total") FILTER (
    WHERE "metricName" = '${AnalyticsMetric.swipeLike}'
  ), 0) AS likes,
  COALESCE(SUM("total") FILTER (
    WHERE "metricName" = '${AnalyticsMetric.swipeDislike}'
  ), 0) AS dislikes,
  COALESCE(SUM("total") FILTER (
    WHERE "metricName" = '${AnalyticsMetric.cardImpression}'
  ), 0) AS impressions
FROM "hayer_product_analytics_hour"
WHERE "placeId" = @placeId
  AND "metricName" IN (
    '${AnalyticsMetric.swipeLike}',
    '${AnalyticsMetric.swipeDislike}',
    '${AnalyticsMetric.cardImpression}'
  )
  AND "bucketStartedAt" >= CAST(@after AS timestamp)
''',
        {
          'placeId': place.placeId,
          'after': DateTime.now()
              .toUtc()
              .subtract(analyticsWindow)
              .toIso8601String(),
        },
      )).single;
      int count(String column) => (votes[column] as double).round();
      return AdminCatalogPlaceDetail(
        place: place,
        snapshot: PlaceSnapshot.fromJson(
          jsonDecode(row['snapshot_json'] as String) as Map<String, dynamic>,
        ),
        calibrationVersion: row['calibrationVersion'] as String,
        quarantineReason: row['quarantineReason'] as String?,
        categoryEvidence: [
          for (final item in evidence)
            AdminCatalogCategoryEvidence(
              categoryId: item.categoryId,
              evidenceQuery: item.evidenceQuery,
              firstSeenAt: item.firstSeenAt,
              lastSeenAt: item.lastSeenAt,
            ),
        ],
        detailRefresh: refresh == null
            ? null
            : AdminCatalogDetailRefresh(
                state: refresh.state,
                lastAttemptAt: refresh.lastAttemptAt,
                lastCheckedAt: refresh.lastCheckedAt,
                lastSuccessAt: refresh.lastSuccessAt,
                retryAfter: refresh.retryAfter,
                lastFailureCode: refresh.lastFailureCode,
                attemptCount: refresh.attemptCount,
              ),
        reportCount: reportCount,
        recentReports: [
          for (final report in reports)
            AdminCatalogReport(
              reportId: report.reportId,
              issueType: report.issueType,
              status: report.status,
              source: report.source,
              createdAt: report.createdAt,
            ),
        ],
        deckAppearances: deckAppearances,
        likes: count('likes'),
        dislikes: count('dislikes'),
        cardImpressions: count('impressions'),
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  static void _validate(AdminCatalogQuery query) {
    final viewport = query.viewport;
    if (viewport == null) return;
    final edges = [
      viewport.south,
      viewport.west,
      viewport.north,
      viewport.east,
    ];
    if (!edges.every((edge) => edge.isFinite) ||
        viewport.south < -90 ||
        viewport.north > 90 ||
        viewport.west < -180 ||
        viewport.east > 180 ||
        viewport.south >= viewport.north ||
        viewport.west >= viewport.east ||
        viewport.north - viewport.south > maximumSpanDegrees ||
        viewport.east - viewport.west > maximumSpanDegrees) {
      throw ApiException(
        code: 'invalid_area',
        message: 'The map bounds are invalid or too large. Zoom in.',
      );
    }
  }

  static Future<DateTime> _freshAfter(Session session) async {
    final settings = await CacheSettingsRow.db.findFirstRow(
      session,
      where: (table) => table.settingsKey.equals('default'),
    );
    return DateTime.now().toUtc().subtract(
      Duration(hours: settings?.freshHours ?? defaultFreshHours),
    );
  }

  static Future<T> _read<T>(
    Session session,
    Future<T> Function(_Reader reader) body,
  ) async {
    try {
      return await session.db.transaction((transaction) async {
        await session.db.unsafeExecute(
          'SET LOCAL statement_timeout = ${statementTimeout.inMilliseconds}',
          transaction: transaction,
        );
        return body(_Reader(session, transaction));
      });
    } on DatabaseQueryException catch (error) {
      // 57014 is query_canceled, raised here by the statement timeout.
      if (error.code != '57014') rethrow;
      throw ApiException(
        code: 'rate_limited',
        message:
            'This catalog view took too long. Zoom in or narrow the filters.',
        retryAfterSeconds: 5,
      );
    }
  }

  static AdminCatalogPlace _place(Map<String, dynamic> row) {
    final mask = row['completeness_mask'] as int;
    return AdminCatalogPlace(
      catalogId: row['catalogId'] as int,
      provider: row['provider'] as String,
      placeId: row['providerPlaceId'] as String,
      name: row['name'] as String,
      primaryType: row['primary_type'] as String?,
      categoryIds: [
        for (final id in jsonDecode(row['category_ids'] as String) as List)
          id as String,
      ],
      countryCode: row['countryCode'] as String,
      latitude: row['latitude'] as double,
      longitude: row['longitude'] as double,
      rating: row['rating'] as double?,
      reviewCount: row['review_count'] as int?,
      priceLevel: row['price_level'] as int?,
      lifecycle:
          _lifecycles[row['lifecycle_status']] ??
          AdminCatalogLifecycle.notClosed,
      missing: [
        for (final MapEntry(key: field, value: bit) in _fieldBits.entries)
          if ((mask & bit) == 0) field,
      ],
      firstSeenAt: (row['firstSeenAt'] as DateTime).toUtc(),
      lastSeenAt: (row['lastSeenAt'] as DateTime).toUtc(),
      sourceCheckedAt: (row['sourceCheckedAt'] as DateTime).toUtc(),
      isStale: row['is_stale'] as bool,
      quarantinedAt: (row['quarantinedAt'] as DateTime?)?.toUtc(),
      openReportCount: row['open_reports'] as int,
    );
  }
}

/// The stored `lifecycle_status` values, which the M9-C catalog columns
/// derive from the cached status text.
const _lifecycles = {
  'unknown': AdminCatalogLifecycle.notClosed,
  'temporarily_closed': AdminCatalogLifecycle.temporarilyClosed,
  'permanently_closed': AdminCatalogLifecycle.permanentlyClosed,
};

/// The bits of the generated `completeness_mask` column.
const _fieldBits = {
  AdminCatalogField.photos: 1,
  AdminCatalogField.hours: 2,
  AdminCatalogField.phone: 4,
  AdminCatalogField.website: 8,
  AdminCatalogField.price: 16,
  AdminCatalogField.summary: 32,
};

final _openReports =
    '''
SELECT COUNT(*)::int
FROM "hayer_poi_issue_report" AS report
WHERE report."placeId" = catalog."providerPlaceId"
  AND report.status IN (
    '${PoiIssueStatus.open.name}',
    '${PoiIssueStatus.inReview.name}'
  )''';

final _placeColumns = '''
  catalog."catalogId",
  catalog.provider,
  catalog."providerPlaceId",
  catalog.name,
  catalog.primary_type,
  catalog."categoryIds"::text AS category_ids,
  catalog."countryCode",
  catalog.latitude,
  catalog.longitude,
  catalog.rating,
  catalog.review_count,
  catalog.price_level,
  catalog.lifecycle_status,
  catalog.completeness_mask,
  catalog."firstSeenAt",
  catalog."lastSeenAt",
  catalog."sourceCheckedAt",
  catalog."sourceCheckedAt" < CAST(@freshAfter AS timestamp) AS is_stale,
  catalog."quarantinedAt",
  ($_openReports) AS open_reports''';

/// The `WHERE` conditions, order and parameters one query describes.
final class _Filters {
  _Filters(this.query, this.freshAfter);

  final AdminCatalogQuery query;
  final DateTime freshAfter;

  String get _search => query.search?.trim() ?? '';
  String? get _primaryType => _trimmed(query.primaryType);
  String? get _categoryId => _trimmed(query.categoryId);

  String where({bool withType = true}) {
    final prices = {
      for (final level in query.priceLevels ?? const <int>[])
        if (level >= 0 && level <= 4) level,
    };
    final missing = [
      for (final field in query.missing ?? const <AdminCatalogField>[])
        _fieldBits[field]!,
    ].fold(0, (mask, bit) => mask | bit);
    final lifecycle = query.lifecycle;
    return [
      switch (query.status) {
        AdminCatalogStatus.active => 'catalog."quarantinedAt" IS NULL',
        AdminCatalogStatus.quarantined => 'catalog."quarantinedAt" IS NOT NULL',
        AdminCatalogStatus.all => 'TRUE',
      },
      if (query.viewport != null) ...[
        'catalog.location && '
            'ST_MakeEnvelope(@west, @south, @east, @north, 4326)::geography',
        'catalog.latitude BETWEEN @south AND @north',
        'catalog.longitude BETWEEN @west AND @east',
      ],
      if (_search.isNotEmpty)
        '(catalog.name ILIKE @pattern '
            'OR catalog."providerPlaceId" = @search '
            'OR catalog."catalogId"::text = @search)',
      if (query.freshness == AdminCatalogFreshness.fresh)
        'catalog."sourceCheckedAt" >= CAST(@freshAfter AS timestamp)',
      if (query.freshness == AdminCatalogFreshness.stale)
        'catalog."sourceCheckedAt" < CAST(@freshAfter AS timestamp)',
      if (lifecycle != null)
        "catalog.lifecycle_status = '${_lifecycles.entries.firstWhere((entry) => entry.value == lifecycle).key}'",
      if (withType && _primaryType != null)
        'catalog.primary_type = @primaryType',
      if (_categoryId != null)
        'EXISTS (SELECT 1 FROM json_array_elements_text(catalog."categoryIds") '
            'AS category(id) WHERE category.id = @categoryId)',
      if (query.minimumRating != null) 'catalog.rating >= @minimumRating',
      if (query.minimumReviews != null)
        'catalog.review_count >= @minimumReviews',
      if (prices.isNotEmpty) 'catalog.price_level IN (${prices.join(', ')})',
      if (missing != 0) '(catalog.completeness_mask & $missing) = 0',
      if (query.withOpenReports) '($_openReports) > 0',
      if (query.firstSeenAfter != null)
        'catalog."firstSeenAt" >= CAST(@firstSeenAfter AS timestamp)',
    ].join('\n  AND ');
  }

  String get order {
    final direction = query.descending ? 'DESC' : 'ASC';
    final column = switch (query.sort) {
      AdminCatalogSort.lastSeen => 'catalog."lastSeenAt"',
      AdminCatalogSort.firstSeen => 'catalog."firstSeenAt"',
      AdminCatalogSort.sourceChecked => 'catalog."sourceCheckedAt"',
      AdminCatalogSort.name => 'catalog."normalizedName"',
      AdminCatalogSort.rating => 'catalog.rating',
      AdminCatalogSort.reviewCount => 'catalog.review_count',
    };
    return '$column $direction NULLS LAST';
  }

  Map<String, Object?> get parameters {
    final viewport = query.viewport;
    return {
      if (viewport != null) ...{
        'west': viewport.west,
        'south': viewport.south,
        'east': viewport.east,
        'north': viewport.north,
      },
      'search': _search,
      'pattern': '%${_escapeLike(_search)}%',
      'freshAfter': freshAfter.toIso8601String(),
      'primaryType': _primaryType,
      'categoryId': _categoryId,
      'minimumRating': query.minimumRating,
      'minimumReviews': query.minimumReviews,
      'firstSeenAfter': query.firstSeenAfter?.toUtc().toIso8601String(),
    };
  }

  static String? _trimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  static String _escapeLike(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
}

final class _Reader {
  _Reader(this.session, this.transaction);

  final Session session;
  final Transaction transaction;

  Future<List<Map<String, dynamic>>> query(
    String sql,
    Map<String, Object?> parameters,
  ) async {
    // The PostgreSQL driver rejects named parameters a statement never uses.
    final used = {
      for (final entry in parameters.entries)
        if (RegExp('@${RegExp.escape(entry.key)}\\b').hasMatch(sql))
          entry.key: entry.value,
    };
    final rows = await session.db.unsafeQuery(
      sql,
      parameters: QueryParameters.named(used),
      transaction: transaction,
    );
    return [for (final row in rows) row.toColumnMap()];
  }
}
