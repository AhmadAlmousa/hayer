import 'dart:io';
import 'dart:math' as math;

import 'package:hayer_server/src/analytics/analytics_aggregation_service.dart';
import 'package:hayer_server/src/analytics/analytics_query_service.dart';
import 'package:hayer_server/src/analytics/product_analytics.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../test/integration/test_tools/serverpod_test_tools.dart';

/// Measures product analytics over a year of synthetic hourly aggregates:
/// report latency and plans, the row count the in-memory reports used to
/// load, drain throughput over a pending backlog, and pruning.
///
/// This is not part of the integration suite. It truncates the analytics and
/// operational metric tables, so run it only through
/// `scripts/benchmark-analytics.sh`, which refuses any database whose name
/// does not start with `hayer_test`.
///
/// Each generated hour holds 48 session rows (eight metrics, two modes,
/// three of six cities), 15 setup-choice rows, 12 cuisine and type rows, and
/// four place metrics for each of HAYER_BENCHMARK_PLACES_PER_HOUR places
/// drawn from a pool of 5,000: about 315 rows an hour, 2.8 million a year, at
/// the default of 60.
void main() {
  final databaseName = Platform.environment['SERVERPOD_DATABASE_NAME'] ?? '';
  if (!databaseName.startsWith('hayer_test')) {
    test(
      'Product analytics benchmark',
      () {},
      skip: 'Set SERVERPOD_DATABASE_NAME to a disposable hayer_test database.',
    );
    return;
  }
  final placesPerHour = int.parse(
    Platform.environment['HAYER_BENCHMARK_PLACES_PER_HOUR'] ?? '60',
  );
  final pendingEvents = int.parse(
    Platform.environment['HAYER_BENCHMARK_PENDING_EVENTS'] ?? '200000',
  );
  final outputPath = Platform.environment['HAYER_BENCHMARK_OUTPUT'];
  final end = analyticsHour(DateTime.now().toUtc());
  final start = end.subtract(const Duration(days: 366));

  withServerpod(
    'Product analytics benchmark',
    rollbackDatabase: RollbackDatabase.disabled,
    (builder, _) {
      final report = StringBuffer()
        ..writeln('# Product analytics benchmark (F22)')
        ..writeln('# scripts/benchmark-analytics.sh')
        ..writeln('Database: $databaseName');

      setUpAll(() async {
        final session = builder.build();
        try {
          await _truncate(session);
          final settings = await session.db.unsafeQuery('''
SELECT version() AS version,
  current_setting('jit') AS jit,
  current_setting('work_mem') AS work_mem,
  current_setting('shared_buffers') AS shared_buffers
''');
          final values = settings.single.toColumnMap();
          report
            ..writeln('Server: ${values['version']}')
            ..writeln(
              'jit=${values['jit']} work_mem=${values['work_mem']} '
              'shared_buffers=${values['shared_buffers']}',
            );
          final load = Stopwatch()..start();
          var chunkStart = start;
          while (chunkStart.isBefore(end)) {
            final chunkEnd = _earliest(
              chunkStart.add(const Duration(days: 30)),
              end.add(const Duration(hours: 1)),
            );
            await _seedHours(
              session,
              from: chunkStart,
              to: chunkEnd,
              placesPerHour: placesPerHour,
            );
            chunkStart = chunkEnd;
          }
          await session.db.unsafeExecute(
            'ANALYZE "hayer_product_analytics_hour"',
          );
          final count = (await session.db.unsafeQuery('''
SELECT COUNT(*)::bigint AS rows,
  pg_size_pretty(pg_total_relation_size('hayer_product_analytics_hour')) AS size
FROM "hayer_product_analytics_hour"
''')).single.toColumnMap();
          report.writeln(
            'Seeded ${count['rows']} hour rows (${count['size']} with indexes) '
            'from ${start.toIso8601String()} to ${end.toIso8601String()} '
            'in ${load.elapsed.inSeconds} s; $placesPerHour places an hour.',
          );
        } finally {
          await session.close();
        }
      });

      tearDownAll(() async {
        AnalyticsQueryService.statementObserver = null;
        final text = report.toString();
        if (outputPath != null) await File(outputPath).writeAsString(text);
        stdout.write(text);
      });

      test('reports', () async {
        final session = builder.build();
        try {
          final summary = CacheDashboardSummary(
            catalogCount: 0,
            freshCount: 0,
            staleCount: 0,
            quarantinedCount: 0,
            coverageCount: 0,
            pendingJobs: 0,
            cacheHitRate: 0,
            sourceSuccessRate: 0,
            calibrationVersion: 'benchmark',
            generatedAt: DateTime.now().toUtc(),
          );
          final to = end.add(const Duration(hours: 1));
          final filters = <String, AnalyticsFilter>{
            '30 days, daily': AnalyticsFilter(
              from: to.subtract(const Duration(days: 30)),
              to: to,
              granularity: AnalyticsGranularity.daily,
            ),
            '366 days, weekly': AnalyticsFilter(
              from: to.subtract(const Duration(days: 366)),
              to: to,
              granularity: AnalyticsGranularity.weekly,
            ),
            '366 days, weekly, city-1': AnalyticsFilter(
              from: to.subtract(const Duration(days: 366)),
              to: to,
              granularity: AnalyticsGranularity.weekly,
              cityKey: 'city-1',
            ),
            '90 days, daily, multiplayer': AnalyticsFilter(
              from: to.subtract(const Duration(days: 90)),
              to: to,
              granularity: AnalyticsGranularity.daily,
              mode: SessionMode.multiplayer,
            ),
          };

          report
            ..writeln()
            ..writeln('## Rows the in-memory reports loaded before F22');
          for (final entry in filters.entries) {
            final filter = entry.value;
            final rows = (await session.db.unsafeQuery(
              '''
SELECT COUNT(*)::bigint AS rows
FROM "hayer_product_analytics_hour"
WHERE "bucketStartedAt" >= CAST(@from AS timestamp)
  AND "bucketStartedAt" < CAST(@to AS timestamp)
  ${filter.mode == null ? '' : 'AND "modeKey" = @mode'}
  ${filter.cityKey == null ? '' : 'AND "cityKey" = @cityKey'}
''',
              parameters: QueryParameters.named({
                'from': filter.from.toIso8601String(),
                'to': filter.to.toIso8601String(),
                if (filter.mode != null) 'mode': filter.mode!.name,
                if (filter.cityKey != null) 'cityKey': filter.cityKey,
              }),
            )).single.toColumnMap()['rows'];
            report.writeln(
              '${entry.key}: $rows rows per range; overview loaded it twice '
              '(current and previous period).',
            );
          }
          final legacy = Stopwatch()..start();
          final loaded = await ProductAnalyticsHourRow.db.find(
            session,
            where: (table) =>
                (table.bucketStartedAt >= filters['30 days, daily']!.from) &
                (table.bucketStartedAt < to),
            orderBy: (table) => table.bucketStartedAt,
          );
          report.writeln(
            'Loading the 30-day range as the old path did: ${loaded.length} '
            'rows in ${legacy.elapsedMilliseconds} ms, before any Dart '
            'aggregation.',
          );

          report
            ..writeln()
            ..writeln('## Report latency (one warm-up, then 5 timed runs)');
          final reports = <String, Future<Object> Function(AnalyticsFilter)>{
            'overview': (filter) => AnalyticsQueryService.overview(
              session,
              filter: filter,
              cacheSummary: summary,
            ),
            'usage': (filter) =>
                AnalyticsQueryService.usage(session, filter: filter),
            'places': (filter) => AnalyticsQueryService.places(
              session,
              filter: filter,
              ranking: PlaceRanking.approval,
              minimumSamples: 5,
            ),
          };
          for (final filter in filters.entries) {
            for (final call in reports.entries) {
              await call.value(filter.value);
              final timings = <int>[];
              for (var run = 0; run < 5; run++) {
                final watch = Stopwatch()..start();
                await call.value(filter.value);
                timings.add(watch.elapsedMilliseconds);
              }
              timings.sort();
              report.writeln(
                '${call.key} · ${filter.key}: p50 ${timings[2]} ms, '
                'max ${timings.last} ms',
              );
            }
          }
          final live = Stopwatch()..start();
          await AnalyticsQueryService.live(session);
          report.writeln('live: ${live.elapsedMilliseconds} ms');

          report
            ..writeln()
            ..writeln(
              '## Statement plans, 366 days weekly '
              '(EXPLAIN ANALYZE, BUFFERS; full plan when over 100 ms)',
            );
          for (final call in reports.entries) {
            final statements = <(String, Map<String, Object?>)>[];
            AnalyticsQueryService.statementObserver = (sql, parameters) =>
                statements.add((sql, parameters));
            await call.value(filters['366 days, weekly']!);
            AnalyticsQueryService.statementObserver = null;
            for (final (index, (sql, parameters)) in statements.indexed) {
              final plan = await session.db.transaction((transaction) async {
                await session.db.unsafeExecute(
                  'SET LOCAL statement_timeout = 120000',
                  transaction: transaction,
                );
                return session.db.unsafeQuery(
                  'EXPLAIN (ANALYZE, BUFFERS) $sql',
                  parameters: QueryParameters.named(parameters),
                  transaction: transaction,
                );
              });
              final lines = [
                for (final row in plan)
                  row.toColumnMap().values.single as String,
              ];
              final execution = lines.lastWhere(
                (line) => line.startsWith('Execution Time'),
              );
              final milliseconds = double.parse(
                RegExp(r'([\d.]+) ms').firstMatch(execution)!.group(1)!,
              );
              final firstLine = sql
                  .split('\n')
                  .firstWhere((line) => line.contains('FROM "hayer_'))
                  .trim();
              report.writeln(
                '${call.key} #${index + 1} ($firstLine): '
                '${lines.firstWhere((l) => l.startsWith('Planning Time'))}; '
                '$execution',
              );
              if (milliseconds > 100) {
                report
                  ..writeln('```')
                  ..writeln(sql.trim())
                  ..writeln('---')
                  ..writeAll(lines, '\n')
                  ..writeln()
                  ..writeln('```');
              }
            }
          }
        } finally {
          await session.close();
        }
      });

      test('drain, health and pruning', () async {
        final session = builder.build();
        try {
          report
            ..writeln()
            ..writeln('## Drain, health and pruning');
          final seed = Stopwatch()..start();
          await _seedEvents(session, count: pendingEvents, end: end);
          await session.db.unsafeExecute(
            'ANALYZE "hayer_product_analytics_event"',
          );
          report.writeln(
            'Seeded $pendingEvents pending events over the last 12 hours in '
            '${seed.elapsed.inSeconds} s.',
          );

          final health = Stopwatch()..start();
          await AnalyticsAggregationService.recordHealth(session);
          report.writeln(
            'recordHealth with the whole backlog pending: '
            '${health.elapsedMilliseconds} ms',
          );

          final drained = await AnalyticsAggregationService.drain(
            session,
            budget: const Duration(minutes: 30),
          );
          final seconds = drained.elapsed.inMilliseconds / 1000;
          report.writeln(
            'drain: ${drained.processed} events in ${drained.batches} batches '
            'of ${AnalyticsAggregationService.batchSize} in '
            '${seconds.toStringAsFixed(1)} s = '
            '${(drained.processed / seconds).toStringAsFixed(0)} events/s, '
            '${(drained.elapsed.inMilliseconds / math.max(1, drained.batches)).toStringAsFixed(0)} '
            'ms a batch; backlogRemains=${drained.backlogRemains}',
          );
          final leftover = (await session.db.unsafeQuery('''
SELECT COUNT(*)::bigint AS pending
FROM "hayer_product_analytics_event"
WHERE "processedAt" IS NULL
''')).single.toColumnMap()['pending'];
          report.writeln('pending after drain: $leftover');

          final idle = Stopwatch()..start();
          final noOp = await AnalyticsAggregationService.drain(session);
          report.writeln(
            'drain with nothing pending: ${idle.elapsedMilliseconds} ms '
            '(${noOp.processed} events)',
          );

          // The seeded year starts at `start`, so a prune at
          // start + retention finds nothing to expire, and one a day later
          // expires the first seeded day.
          final retained = start.add(
            AnalyticsAggregationService.aggregateRetention,
          );
          final eventsOnly = Stopwatch()..start();
          await AnalyticsAggregationService.prune(
            session,
            now: retained,
            aggregates: false,
          );
          report.writeln(
            'prune of events only, as every pass runs it: '
            '${eventsOnly.elapsedMilliseconds} ms',
          );
          final nothingDue = Stopwatch()..start();
          final keep = await AnalyticsAggregationService.prune(
            session,
            now: retained,
          );
          report.writeln(
            'prune of events and hours with nothing expired: '
            '${nothingDue.elapsedMilliseconds} ms; deleted '
            '${keep.events} events, ${keep.hours} hours',
          );
          final oneDay = Stopwatch()..start();
          final expired = await AnalyticsAggregationService.prune(
            session,
            now: retained.add(const Duration(days: 1)),
          );
          report.writeln(
            'prune expiring the first seeded day of hours: '
            '${oneDay.elapsedMilliseconds} ms; deleted ${expired.hours} '
            'hours and ${expired.events} events '
            '(${expired.expiredPendingEvents} pending)',
          );
        } finally {
          await session.close();
        }
      });
    },
  );
}

DateTime _earliest(DateTime left, DateTime right) =>
    left.isBefore(right) ? left : right;

Future<void> _truncate(Session session) => session.db.unsafeExecute('''
TRUNCATE TABLE
  "hayer_product_analytics_event",
  "hayer_product_analytics_hour",
  "hayer_operational_metric"
''');

/// Inserts the synthetic hours in [from, to). Every block's key hashes all
/// of its varying dimensions, so keys are unique.
Future<void> _seedHours(
  Session session, {
  required DateTime from,
  required DateTime to,
  required int placesPerHour,
}) async {
  const columns = '''
"aggregateKey", "bucketStartedAt", "metricName", "modeKey", "countryCode",
"cityKey", "cityName", "categoryId", "taxonomyKind", "taxonomyId",
"placeId", "placeName", "total", "sampleCount", "updatedAt"''';
  const hours = '''
generate_series(
  CAST(@from AS timestamp),
  CAST(@to AS timestamp) - INTERVAL '1 hour',
  INTERVAL '1 hour'
) AS h(hour)
CROSS JOIN LATERAL (
  SELECT (EXTRACT(EPOCH FROM h.hour)::bigint / 3600) AS n
) AS hn''';
  final parameters = {
    'from': from.toIso8601String(),
    'to': to.toIso8601String(),
    'places': placesPerHour,
  };
  Future<void> insert(String select) => session.db.unsafeQuery(
    'INSERT INTO "hayer_product_analytics_hour" ($columns)\n$select',
    parameters: QueryParameters.named({
      for (final entry in parameters.entries)
        if (select.contains('@${entry.key}')) entry.key: entry.value,
    }),
  );

  await insert('''
SELECT
  md5(concat_ws('|', 'session', h.hour, m.metric, mo.mode, c.i)),
  h.hour, m.metric, mo.mode, 'SA',
  'city-' || ((hn.n + c.i * 2) % 6), 'City ' || ((hn.n + c.i * 2) % 6),
  (ARRAY['restaurants', 'cafes', 'desserts'])[1 + (hn.n + c.i) % 3],
  '', '', '', '',
  1 + (hn.n + c.i) % 4, 1 + hn.n % 2, now()
FROM $hours
CROSS JOIN unnest(ARRAY[
  'session_created', 'participant_joined', 'decision_completed',
  'match_completed', 'decision_time_seconds', 'swipe_depth',
  'stale_deck', 'underfilled_deck'
]) AS m(metric)
CROSS JOIN unnest(ARRAY['solo', 'multiplayer']) AS mo(mode)
CROSS JOIN generate_series(0, 2) AS c(i)
''');
  await insert('''
SELECT
  md5(concat_ws('|', 'choice', h.hour, m.metric, v.value)),
  h.hour, m.metric, 'multiplayer', 'SA', 'city-' || (hn.n % 6),
  'City ' || (hn.n % 6), 'restaurants', '', v.value, '', '',
  1 + hn.n % 3, 1, now()
FROM $hours
CROSS JOIN unnest(ARRAY[
  'group_size', 'radius_selected', 'deck_size_selected', 'price_selected',
  'visit_scheduled'
]) AS m(metric)
CROSS JOIN unnest(ARRAY['2', '4', '6']) AS v(value)
''');
  await insert('''
SELECT
  md5(concat_ws('|', 'taxonomy', h.hour, k.kind, t.i)),
  h.hour, 'taxonomy_selected', 'solo', 'SA', 'city-' || (hn.n % 6),
  'City ' || (hn.n % 6), 'restaurants', k.kind, k.kind || '-' || t.i,
  '', '', 1 + (hn.n + t.i) % 3, 1, now()
FROM $hours
CROSS JOIN unnest(ARRAY['cuisine', 'poiType']) AS k(kind)
CROSS JOIN generate_series(0, 5) AS t(i)
''');
  await insert('''
SELECT
  md5(concat_ws('|', 'place', h.hour, m.metric, p.i)),
  h.hour, m.metric, (ARRAY['solo', 'multiplayer'])[1 + p.i % 2], 'SA',
  'city-' || (p.i % 6), 'City ' || (p.i % 6), 'restaurants', '', '',
  'place-' || ((hn.n * 37 + p.i * 101) % 5000),
  'Place ' || ((hn.n * 37 + p.i * 101) % 5000),
  1 + (hn.n + p.i) % 3, 1, now()
FROM $hours
CROSS JOIN unnest(ARRAY[
  'swipe_like', 'swipe_dislike', 'deck_included', 'card_impression'
]) AS m(metric)
CROSS JOIN generate_series(0, @places - 1) AS p(i)
''');
}

/// Inserts [count] pending events over the 12 hours before [end], spread
/// over six metrics and 500 places so batches upsert many distinct hours.
Future<void> _seedEvents(
  Session session, {
  required int count,
  required DateTime end,
}) => session.db.unsafeQuery(
  '''
INSERT INTO "hayer_product_analytics_event" (
  "eventId", "occurredAt", "metricName", "modeKey", "countryCode",
  "cityKey", "cityName", "categoryId", "taxonomyKind", "taxonomyId",
  "placeId", "placeName", "value", "sampleCount", "receivedAt"
)
SELECT
  md5('benchmark-event-' || e.i),
  CAST(@end AS timestamp) - make_interval(secs => (e.i * 43200.0) / @count),
  (ARRAY[
    'swipe_like', 'swipe_dislike', 'deck_included', 'card_impression',
    'session_created', 'participant_joined'
  ])[1 + e.i % 6],
  (ARRAY['solo', 'multiplayer'])[1 + e.i % 2], 'SA',
  'city-' || (e.i % 6), 'City ' || (e.i % 6), 'restaurants', '', '',
  CASE WHEN e.i % 6 < 4 THEN 'place-' || (e.i % 500) ELSE '' END,
  CASE WHEN e.i % 6 < 4 THEN 'Place ' || (e.i % 500) ELSE '' END,
  1, 1, now()
FROM generate_series(0, @count - 1) AS e(i)
''',
  parameters: QueryParameters.named({
    'end': end.toIso8601String(),
    'count': count,
  }),
);
