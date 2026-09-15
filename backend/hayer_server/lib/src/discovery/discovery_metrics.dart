import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Aggregate growth and reuse counters for the shared catalog, attributed to
/// the mode and operation that started the work. Stored places are never
/// partitioned by mode; only these counters are.
///
/// Counters live in `hayer_operational_metric` under `growth.*` names in
/// hourly buckets, so a window counts the buckets that start inside it, and
/// maintenance keeps 90 days of them.
abstract final class DiscoveryMetrics {
  static const _prefix = 'growth.';
  static const _removed = 'growth.removedPlaces';
  static const maximumWindow = Duration(days: 90);

  /// Records non-zero counters. A metrics failure is logged, never raised.
  static Future<void> record(
    Session session, {
    required DiscoveryMetricMode mode,
    required DiscoveryMetricOperation operation,
    int observations = 0,
    int newCatalogPlaces = 0,
    int cacheHits = 0,
    int cacheMisses = 0,
    int detailRefreshes = 0,
    int upstreamRequests = 0,
  }) async {
    final counters = {
      'observations': observations,
      'newCatalogPlaces': newCatalogPlaces,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'detailRefreshes': detailRefreshes,
      'upstreamRequests': upstreamRequests,
    };
    final bucket = _bucket(DateTime.now().toUtc());
    final rows = [
      for (final counter in counters.entries)
        if (counter.value > 0)
          OperationalMetricRow(
            bucketStartedAt: bucket,
            metricName: '$_prefix${counter.key}',
            dimensions: {'mode': mode.name, 'operation': operation.name},
            metricValue: counter.value.toDouble(),
            sampleCount: 1,
          ),
    ];
    if (rows.isEmpty) return;
    await _insert(session, rows);
  }

  /// Records catalog places deleted by retention pruning.
  static Future<void> recordRemovedPlaces(
    Session session,
    int count, {
    Transaction? transaction,
  }) async {
    if (count <= 0) return;
    await _insert(session, [
      OperationalMetricRow(
        bucketStartedAt: _bucket(DateTime.now().toUtc()),
        metricName: _removed,
        dimensions: const {},
        metricValue: count.toDouble(),
        sampleCount: 1,
      ),
    ], transaction: transaction);
  }

  static Future<DiscoveryGrowthMetrics> growth(
    Session session, {
    required DateTime from,
    required DateTime to,
  }) async {
    final start = from.toUtc();
    final end = to.toUtc();
    if (!end.isAfter(start) || end.difference(start) > maximumWindow) {
      throw ApiException(
        code: 'bad_request',
        message:
            'Choose a window of at most 90 days that ends after it starts.',
      );
    }
    final window = QueryParameters.named({
      'from': start.toIso8601String(),
      'to': end.toIso8601String(),
    });

    final catalog = (await session.db.unsafeQuery('''
SELECT
  COUNT(*) FILTER (WHERE "firstSeenAt" < CAST(@from AS timestamp)) AS before_start,
  COUNT(*) FILTER (WHERE "firstSeenAt" < CAST(@to AS timestamp)) AS before_end,
  COUNT(*) FILTER (
    WHERE "firstSeenAt" >= CAST(@from AS timestamp)
      AND "firstSeenAt" < CAST(@to AS timestamp)
  ) AS new_places,
  COUNT(*) FILTER (
    WHERE "quarantinedAt" >= CAST(@from AS timestamp)
      AND "quarantinedAt" < CAST(@to AS timestamp)
  ) AS quarantined
FROM "hayer_poi_catalog"
''', parameters: window)).single.toColumnMap();

    final removed = (await session.db.unsafeQuery('''
SELECT
  COALESCE(SUM("metricValue") FILTER (
    WHERE "bucketStartedAt" >= CAST(@from AS timestamp)
  ), 0) AS since_start,
  COALESCE(SUM("metricValue") FILTER (
    WHERE "bucketStartedAt" >= CAST(@to AS timestamp)
  ), 0) AS since_end
FROM "hayer_operational_metric"
WHERE "metricName" = '$_removed'
''', parameters: window)).single.toColumnMap();

    final explored = (await session.db.unsafeQuery('''
SELECT COUNT(DISTINCT ("countryCode", "cellId", "radiusMeters")) AS cells
FROM "hayer_discovery_harvest"
WHERE "completedAt" >= CAST(@from AS timestamp)
  AND "completedAt" < CAST(@to AS timestamp)
  AND "state" IN ('succeeded', 'partial')
''', parameters: window)).single.toColumnMap();

    final counters = await session.db.unsafeQuery('''
SELECT
  "metricName" AS name,
  "dimensions"::jsonb ->> 'mode' AS mode,
  "dimensions"::jsonb ->> 'operation' AS operation,
  SUM("metricValue") AS total
FROM "hayer_operational_metric"
WHERE "metricName" LIKE 'growth.%'
  AND "metricName" <> '$_removed'
  AND "bucketStartedAt" >= CAST(@from AS timestamp)
  AND "bucketStartedAt" < CAST(@to AS timestamp)
GROUP BY 1, 2, 3
''', parameters: window);

    final breakdowns =
        <(DiscoveryMetricMode, DiscoveryMetricOperation), Map<String, int>>{};
    for (final row in counters) {
      final values = row.toColumnMap();
      final mode = _byName(DiscoveryMetricMode.values, values['mode']);
      final operation = _byName(
        DiscoveryMetricOperation.values,
        values['operation'],
      );
      if (mode == null || operation == null) continue;
      final name = (values['name']! as String).substring(_prefix.length);
      breakdowns.putIfAbsent((mode, operation), () => {})[name] =
          (values['total'] as num).round();
    }
    final keys = breakdowns.keys.toList()
      ..sort((a, b) {
        final byMode = a.$1.index.compareTo(b.$1.index);
        return byMode != 0 ? byMode : a.$2.index.compareTo(b.$2.index);
      });
    final items = [
      for (final key in keys)
        DiscoveryGrowthMetricBreakdown(
          mode: key.$1,
          operation: key.$2,
          observations: breakdowns[key]!['observations'] ?? 0,
          newCatalogPlaces: breakdowns[key]!['newCatalogPlaces'] ?? 0,
          cacheHits: breakdowns[key]!['cacheHits'] ?? 0,
          cacheMisses: breakdowns[key]!['cacheMisses'] ?? 0,
          detailRefreshes: breakdowns[key]!['detailRefreshes'] ?? 0,
          upstreamRequests: breakdowns[key]!['upstreamRequests'] ?? 0,
        ),
    ];
    int total(int Function(DiscoveryGrowthMetricBreakdown item) value) =>
        items.fold(0, (sum, item) => sum + value(item));
    int integer(Object? value) => (value as num?)?.round() ?? 0;
    final removedSinceStart = integer(removed['since_start']);
    final removedSinceEnd = integer(removed['since_end']);

    return DiscoveryGrowthMetrics(
      from: start,
      to: end,
      catalogPlacesAtStart:
          integer(catalog['before_start']) + removedSinceStart,
      catalogPlacesAtEnd: integer(catalog['before_end']) + removedSinceEnd,
      newCatalogPlaces: integer(catalog['new_places']),
      quarantinedPlaces: integer(catalog['quarantined']),
      removedPlaces: removedSinceStart - removedSinceEnd,
      exploredCells: integer(explored['cells']),
      observations: total((item) => item.observations),
      cacheHits: total((item) => item.cacheHits),
      cacheMisses: total((item) => item.cacheMisses),
      detailRefreshes: total((item) => item.detailRefreshes),
      upstreamRequests: total((item) => item.upstreamRequests),
      breakdowns: items,
      generatedAt: DateTime.now().toUtc(),
    );
  }

  static Future<void> _insert(
    Session session,
    List<OperationalMetricRow> rows, {
    Transaction? transaction,
  }) async {
    try {
      await OperationalMetricRow.db.insert(
        session,
        rows,
        transaction: transaction,
      );
    } catch (error, stackTrace) {
      if (transaction != null) rethrow;
      session.log(
        'Recording catalog growth metrics failed.',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  static DateTime _bucket(DateTime value) =>
      DateTime.utc(value.year, value.month, value.day, value.hour);

  static T? _byName<T extends Enum>(List<T> values, Object? name) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return null;
  }
}
