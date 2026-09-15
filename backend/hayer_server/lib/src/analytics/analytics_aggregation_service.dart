import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'product_analytics.dart';

/// What one drain pass did.
final class AnalyticsDrainResult {
  const AnalyticsDrainResult({
    required this.processed,
    required this.batches,
    required this.backlogRemains,
    required this.elapsed,
  });

  final int processed;
  final int batches;

  /// The pass spent its time budget while batches were still full.
  final bool backlogRemains;
  final Duration elapsed;
}

/// What one prune pass deleted.
final class AnalyticsPruneResult {
  const AnalyticsPruneResult({
    required this.events,
    required this.expiredPendingEvents,
    required this.hours,
  });

  final int events;

  /// Events deleted at the end of retention without ever being aggregated.
  final int expiredPendingEvents;
  final int hours;
}

/// Compacts anonymous events into bounded hourly reporting dimensions.
///
/// A batch claims the oldest pending events with `SKIP LOCKED`, marks them
/// processed and upserts their hourly groups: two statements in one
/// transaction, so a failed batch leaves every one of its events pending. A
/// pass drains until the backlog is empty or [passBudget] is spent, and [run]
/// starts another pass shortly afterwards while a backlog remains, so
/// throughput follows ingestion rather than a fixed batch count per tick.
///
/// Raw events keep their 14-day retention whether or not they were
/// aggregated. An event still pending by then means draining has failed for
/// two weeks, and journey IDs must not outlive that window, so it is deleted,
/// counted under [expiredPendingEventsMetric] and logged.
abstract final class AnalyticsAggregationService {
  static const batchSize = 1000;
  static const passBudget = Duration(seconds: 20);
  static const backlogRetryDelay = Duration(seconds: 10);
  static const eventRetention = Duration(days: 14);
  static const aggregateRetention = Duration(days: 365);

  /// Hourly aggregates have no index led by their bucket, so expiring them
  /// scans the table. Retention is counted in days; a few scans a day do.
  static const aggregatePruneInterval = Duration(hours: 6);
  static const pruneBatchSize = 5000;

  /// Pending events are counted up to this cap, so the gauge stays cheap
  /// during a large backlog.
  static const pendingCountCap = 100000;

  /// An older pending event is logged as a lagging drain.
  static const lagWarning = Duration(minutes: 15);

  static const pendingEventsMetric = 'analytics.pendingEvents';
  static const oldestPendingSecondsMetric = 'analytics.oldestPendingSeconds';
  static const aggregatedEventsMetric = 'analytics.aggregatedEvents';
  static const drainMillisecondsMetric = 'analytics.drainMilliseconds';
  static const drainFailuresMetric = 'analytics.drainFailures';
  static const expiredPendingEventsMetric = 'analytics.expiredPendingEvents';

  static bool _running = false;
  static DateTime? _aggregatesPrunedAt;

  static Future<void> run(Serverpod pod) async {
    if (_running) return;
    _running = true;
    var backlogRemains = false;
    final session = await pod.createSession(enableLogging: true);
    try {
      AnalyticsDrainResult? drained;
      try {
        drained = await drain(session);
        backlogRemains = drained.backlogRemains;
      } catch (error, stackTrace) {
        session.log(
          'Product analytics aggregation failed.',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
      }
      AnalyticsPruneResult? pruned;
      try {
        final now = DateTime.now().toUtc();
        final prunedAt = _aggregatesPrunedAt;
        final aggregates =
            prunedAt == null ||
            now.difference(prunedAt) >= aggregatePruneInterval;
        pruned = await prune(session, now: now, aggregates: aggregates);
        if (aggregates) _aggregatesPrunedAt = now;
      } catch (error, stackTrace) {
        session.log(
          'Product analytics pruning failed.',
          level: LogLevel.error,
          exception: error,
          stackTrace: stackTrace,
        );
      }
      try {
        await recordHealth(session, drained: drained, pruned: pruned);
      } catch (error, stackTrace) {
        session.log(
          'Recording product analytics health failed.',
          level: LogLevel.warning,
          exception: error,
          stackTrace: stackTrace,
        );
      }
    } finally {
      await session.close();
      _running = false;
    }
    if (backlogRemains) {
      Timer(backlogRetryDelay, () => unawaited(run(pod)));
    }
  }

  /// Aggregates pending events, oldest first, until none are left or
  /// [budget] is spent.
  static Future<AnalyticsDrainResult> drain(
    Session session, {
    Duration budget = passBudget,
    int limit = batchSize,
  }) async {
    final watch = Stopwatch()..start();
    var processed = 0;
    var batches = 0;
    var backlogRemains = false;
    while (true) {
      final count = await _processBatch(session, limit);
      if (count == 0) break;
      processed += count;
      batches++;
      if (count < limit) break;
      if (watch.elapsed >= budget) {
        backlogRemains = true;
        break;
      }
    }
    return AnalyticsDrainResult(
      processed: processed,
      batches: batches,
      backlogRemains: backlogRemains,
      elapsed: watch.elapsed,
    );
  }

  static Future<int> _processBatch(Session session, int limit) =>
      session.db.transaction((transaction) async {
        final claimed = await session.db.unsafeQuery(
          '''
WITH claimed AS (
  SELECT "id"
  FROM "hayer_product_analytics_event"
  WHERE "processedAt" IS NULL
  ORDER BY "occurredAt"
  LIMIT @limit
  FOR UPDATE SKIP LOCKED
)
UPDATE "hayer_product_analytics_event" AS event
SET "processedAt" = CAST(@now AS timestamp)
FROM claimed
WHERE event."id" = claimed."id"
RETURNING
  event."occurredAt", event."metricName", event."modeKey",
  event."countryCode", event."cityKey", event."cityName",
  event."categoryId", event."taxonomyKind", event."taxonomyId",
  event."placeId", event."placeName", event."value", event."sampleCount"
''',
          parameters: QueryParameters.named({
            'limit': limit,
            'now': DateTime.now().toUtc().toIso8601String(),
          }),
          transaction: transaction,
        );
        if (claimed.isEmpty) return 0;
        final groups = <String, _Aggregate>{};
        for (final row in claimed) {
          final event = row.toColumnMap();
          final bucket = analyticsHour(event['occurredAt'] as DateTime);
          final dimensions = [
            for (final column in _dimensionColumns) event[column] as String,
          ];
          final key = analyticsAggregateKey(bucket, dimensions);
          groups.putIfAbsent(key, () => _Aggregate(key, bucket, dimensions))
            ..total += (event['value'] as num).toDouble()
            ..sampleCount += (event['sampleCount'] as num).toInt();
        }
        // Upserting in key order keeps two concurrent batches from locking
        // the same hour rows in opposite orders.
        final aggregates = groups.values.toList()
          ..sort((left, right) => left.key.compareTo(right.key));
        await session.db.unsafeQuery(
          '''
INSERT INTO "hayer_product_analytics_hour" (
  "aggregateKey", "bucketStartedAt", "metricName", "modeKey", "countryCode",
  "cityKey", "cityName", "categoryId", "taxonomyKind", "taxonomyId",
  "placeId", "placeName", "total", "sampleCount", "updatedAt"
)
SELECT
  aggregate."aggregateKey", aggregate."bucketStartedAt",
  aggregate."metricName", aggregate."modeKey", aggregate."countryCode",
  aggregate."cityKey", aggregate."cityName", aggregate."categoryId",
  aggregate."taxonomyKind", aggregate."taxonomyId", aggregate."placeId",
  aggregate."placeName", CAST(aggregate."total" AS double precision),
  aggregate."sampleCount", CAST(@now AS timestamp)
FROM jsonb_to_recordset(CAST(@aggregates AS jsonb)) AS aggregate(
  "aggregateKey" text,
  "bucketStartedAt" timestamp,
  "metricName" text,
  "modeKey" text,
  "countryCode" text,
  "cityKey" text,
  "cityName" text,
  "categoryId" text,
  "taxonomyKind" text,
  "taxonomyId" text,
  "placeId" text,
  "placeName" text,
  "total" text,
  "sampleCount" bigint
)
ORDER BY aggregate."aggregateKey"
ON CONFLICT ("aggregateKey") DO UPDATE SET
  "total" = "hayer_product_analytics_hour"."total" + EXCLUDED."total",
  "sampleCount" =
    "hayer_product_analytics_hour"."sampleCount" + EXCLUDED."sampleCount",
  "updatedAt" = EXCLUDED."updatedAt"
''',
          parameters: QueryParameters.named({
            'aggregates': jsonEncode([
              for (final aggregate in aggregates) aggregate.toJson(),
            ]),
            'now': DateTime.now().toUtc().toIso8601String(),
          }),
          transaction: transaction,
        );
        return claimed.length;
      });

  /// Deletes raw events past [eventRetention], pending or not, and, when
  /// [aggregates] is set, hourly aggregates past [aggregateRetention]. Each
  /// table is deleted a bounded batch at a time within [budget].
  static Future<AnalyticsPruneResult> prune(
    Session session, {
    DateTime? now,
    bool aggregates = true,
    Duration budget = passBudget,
    int limit = pruneBatchSize,
  }) async {
    final at = (now ?? DateTime.now()).toUtc();
    final watch = Stopwatch()..start();
    var events = 0;
    var expiredPending = 0;
    while (true) {
      final row = (await session.db.unsafeQuery(
        '''
WITH expired AS (
  DELETE FROM "hayer_product_analytics_event"
  WHERE "id" IN (
    SELECT "id"
    FROM "hayer_product_analytics_event"
    WHERE "occurredAt" < CAST(@cutoff AS timestamp)
    LIMIT @limit
  )
  RETURNING "processedAt"
)
SELECT
  COUNT(*)::int AS deleted,
  (COUNT(*) FILTER (WHERE "processedAt" IS NULL))::int AS pending
FROM expired
''',
        parameters: QueryParameters.named({
          'cutoff': at.subtract(eventRetention).toIso8601String(),
          'limit': limit,
        }),
      )).single.toColumnMap();
      final deleted = row['deleted'] as int;
      events += deleted;
      expiredPending += row['pending'] as int;
      if (deleted < limit || watch.elapsed >= budget) break;
    }
    if (expiredPending > 0) {
      session.log(
        'Deleted $expiredPending product analytics events that reached '
        '${eventRetention.inDays}-day retention without being aggregated.',
        level: LogLevel.warning,
      );
    }
    var hours = 0;
    while (aggregates && watch.elapsed < budget) {
      final row = (await session.db.unsafeQuery(
        '''
WITH expired AS (
  DELETE FROM "hayer_product_analytics_hour"
  WHERE "id" IN (
    SELECT "id"
    FROM "hayer_product_analytics_hour"
    WHERE "bucketStartedAt" < CAST(@cutoff AS timestamp)
    LIMIT @limit
  )
  RETURNING 1
)
SELECT COUNT(*)::int AS deleted FROM expired
''',
        parameters: QueryParameters.named({
          'cutoff': at.subtract(aggregateRetention).toIso8601String(),
          'limit': limit,
        }),
      )).single.toColumnMap();
      final deleted = row['deleted'] as int;
      hours += deleted;
      if (deleted < limit) break;
    }
    return AnalyticsPruneResult(
      events: events,
      expiredPendingEvents: expiredPending,
      hours: hours,
    );
  }

  /// Records the backlog, its oldest event's age and what this pass did in
  /// hourly operational metrics.
  static Future<void> recordHealth(
    Session session, {
    AnalyticsDrainResult? drained,
    AnalyticsPruneResult? pruned,
    DateTime? now,
  }) async {
    final at = (now ?? DateTime.now()).toUtc();
    final backlog = (await session.db.unsafeQuery(
      '''
SELECT
  (
    SELECT COUNT(*)::int
    FROM (
      SELECT 1
      FROM "hayer_product_analytics_event"
      WHERE "processedAt" IS NULL
      LIMIT @cap
    ) AS capped
  ) AS pending,
  (
    SELECT MIN("occurredAt")
    FROM "hayer_product_analytics_event"
    WHERE "processedAt" IS NULL
  ) AS oldest
''',
      parameters: QueryParameters.named({'cap': pendingCountCap}),
    )).single.toColumnMap();
    final pending = backlog['pending'] as int;
    final oldest = backlog['oldest'] as DateTime?;
    final oldestAge = oldest == null
        ? Duration.zero
        : at.difference(oldest.toUtc());
    final bucket = analyticsHour(at);
    OperationalMetricRow metric(String name, num value) => OperationalMetricRow(
      bucketStartedAt: bucket,
      metricName: name,
      dimensions: const {},
      metricValue: value.toDouble(),
      sampleCount: 1,
    );
    await OperationalMetricRow.db.insert(session, [
      metric(pendingEventsMetric, pending),
      metric(oldestPendingSecondsMetric, max(0, oldestAge.inSeconds)),
      if (drained == null) metric(drainFailuresMetric, 1),
      if (drained != null && drained.processed > 0) ...[
        metric(aggregatedEventsMetric, drained.processed),
        metric(drainMillisecondsMetric, drained.elapsed.inMilliseconds),
      ],
      if (pruned != null && pruned.expiredPendingEvents > 0)
        metric(expiredPendingEventsMetric, pruned.expiredPendingEvents),
    ]);
    if (oldestAge > lagWarning) {
      final count = pending >= pendingCountCap
          ? 'at least $pending'
          : '$pending';
      session.log(
        'Product analytics are ${oldestAge.inMinutes} minutes behind, with '
        '$count events pending.',
        level: LogLevel.warning,
      );
    }
  }
}

/// The hour row key for [bucket] and the dimension values in
/// `_dimensionColumns` order.
///
/// Unchanged from the first implementation, which hashes the joined parts'
/// UTF-16 code units rather than their UTF-8 bytes. Stored hours carry keys
/// made that way, and an event for one of those hours must find its row.
String analyticsAggregateKey(DateTime bucket, List<String> dimensions) => sha256
    .convert(
      [
        bucket.toUtc().toIso8601String(),
        ...dimensions,
      ].join(String.fromCharCode(0x1f)).codeUnits,
    )
    .toString();

const _dimensionColumns = [
  'metricName',
  'modeKey',
  'countryCode',
  'cityKey',
  'cityName',
  'categoryId',
  'taxonomyKind',
  'taxonomyId',
  'placeId',
  'placeName',
];

final class _Aggregate {
  _Aggregate(this.key, this.bucketStartedAt, this.dimensions);

  final String key;
  final DateTime bucketStartedAt;
  final List<String> dimensions;
  double total = 0;
  int sampleCount = 0;

  Map<String, Object> toJson() => {
    'aggregateKey': key,
    'bucketStartedAt': bucketStartedAt.toIso8601String(),
    for (var index = 0; index < _dimensionColumns.length; index++)
      _dimensionColumns[index]: dimensions[index],
    // As text, so NaN and infinities survive JSON; PostgreSQL parses both.
    'total': total.toString(),
    'sampleCount': sampleCount,
  };
}
