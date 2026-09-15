import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/taxonomy_service.dart';
import 'product_analytics.dart';

/// Admin analytics computed in PostgreSQL over the hourly aggregates.
///
/// Each statement groups and sums in SQL and returns at most one row per
/// bucket, breakdown entry or ranked place, so a report's cost follows its
/// range and filters rather than how many place dimensions a year collects.
/// A report reads on one connection, in a transaction with a statement
/// timeout, and at most [maximumConcurrentReports] run at once, so dashboard
/// reads cannot take over the consumer API's connection pool.
abstract final class AnalyticsQueryService {
  static const maximumSpan = Duration(days: 366);

  /// Hourly buckets stop at a month, keeping a trend under 750 points per
  /// series. The dashboard offers only daily and weekly buckets.
  static const maximumHourlySpan = Duration(days: 31);
  static const maximumConcurrentReports = 2;
  static const statementTimeout = Duration(seconds: 15);

  /// Receives each report statement and its parameters. Benchmarks use it to
  /// record query plans.
  static void Function(String sql, Map<String, Object?> parameters)?
  statementObserver;

  static int _activeReports = 0;

  /// Cheap counts over active sessions, polled by the dashboard, so they run
  /// outside the report gate.
  static Future<AdminLiveUsage> live(Session session) =>
      _live(_Reader(session), DateTime.now().toUtc());

  static Future<AdminAnalyticsOverview> overview(
    Session session, {
    required AnalyticsFilter filter,
    required CacheDashboardSummary cacheSummary,
  }) async {
    _validate(filter);
    final labels = await _taxonomyLabels(session);
    return _report(session, (reader) async {
      final scope = _Scope(filter);
      final totals = await _totals(reader, scope, const [
        AnalyticsMetric.sessionCreated,
        AnalyticsMetric.participantJoined,
        AnalyticsMetric.decisionCompleted,
        AnalyticsMetric.matchCompleted,
        AnalyticsMetric.decisionTimeSeconds,
      ], withPrevious: true);
      double sum(String metric) => totals.sum(metric);
      double previous(String metric) => totals.sum(metric, previous: true);
      final sessions = sum(AnalyticsMetric.sessionCreated);
      final participants = sum(AnalyticsMetric.participantJoined);
      final decisions = sum(AnalyticsMetric.decisionCompleted);
      final matches = sum(AnalyticsMetric.matchCompleted);
      final previousSessions = previous(AnalyticsMetric.sessionCreated);
      final previousParticipants = previous(AnalyticsMetric.participantJoined);
      final previousDecisions = previous(AnalyticsMetric.decisionCompleted);
      final previousMatches = previous(AnalyticsMetric.matchCompleted);
      return AdminAnalyticsOverview(
        live: await _live(reader, DateTime.now().toUtc()),
        kpis: [
          _kpi('sessions', 'Sessions', sessions, previousSessions, 'count'),
          _kpi(
            'participants',
            'Participants',
            participants,
            previousParticipants,
            'count',
          ),
          _kpi(
            'completion_rate',
            'Decision completion',
            _rate(decisions, sessions),
            _rate(previousDecisions, previousSessions),
            'percent',
          ),
          _kpi(
            'match_rate',
            'Match rate',
            _rate(matches, decisions),
            _rate(previousMatches, previousDecisions),
            'percent',
          ),
          _kpi(
            'participants_per_session',
            'Participants / session',
            sessions == 0 ? 0 : participants / sessions,
            previousSessions == 0 ? 0 : previousParticipants / previousSessions,
            'average',
          ),
          _kpi(
            'decision_time',
            'Average decision time',
            totals.average(AnalyticsMetric.decisionTimeSeconds),
            totals.average(AnalyticsMetric.decisionTimeSeconds, previous: true),
            'seconds',
          ),
        ],
        sessionTrend: await _trend(
          reader,
          scope,
          AnalyticsMetric.sessionCreated,
          series: 'modeKey',
        ),
        modeBreakdown: await _breakdown(
          reader,
          scope,
          AnalyticsMetric.sessionCreated,
          key: 'modeKey',
          label: _title,
        ),
        participantModeBreakdown: await _breakdown(
          reader,
          scope,
          AnalyticsMetric.participantJoined,
          key: 'modeKey',
          label: _title,
        ),
        topCities: await _breakdown(
          reader,
          scope,
          AnalyticsMetric.sessionCreated,
          key: 'cityKey',
          latestLabel: 'cityName',
          limit: 8,
        ),
        topCategories: await _breakdown(
          reader,
          scope,
          AnalyticsMetric.sessionCreated,
          key: 'categoryId',
          label: (key) => labels[key] ?? key,
          limit: 8,
        ),
        topCuisines: await _taxonomyBreakdown(
          reader,
          scope,
          TaxonomyKind.cuisine,
          labels,
        ),
        topTypes: await _taxonomyBreakdown(
          reader,
          scope,
          TaxonomyKind.poiType,
          labels,
        ),
        cacheSummary: cacheSummary,
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  static Future<AdminUsageAnalytics> usage(
    Session session, {
    required AnalyticsFilter filter,
  }) async {
    _validate(filter);
    return _report(session, (reader) async {
      final scope = _Scope(filter);
      final totals = await _totals(reader, scope, const [
        AnalyticsMetric.sessionCreated,
        AnalyticsMetric.swipeDepth,
        AnalyticsMetric.staleDeck,
        AnalyticsMetric.underfilledDeck,
      ]);
      final sessions = max(1.0, totals.sum(AnalyticsMetric.sessionCreated));
      return AdminUsageAnalytics(
        averageSwipeDepth: totals.average(AnalyticsMetric.swipeDepth),
        sessionTrend: await _trend(
          reader,
          scope,
          AnalyticsMetric.sessionCreated,
          series: 'modeKey',
        ),
        participantTrend: await _trend(
          reader,
          scope,
          AnalyticsMetric.participantJoined,
        ),
        decisionTrend: await _trend(
          reader,
          scope,
          AnalyticsMetric.decisionCompleted,
        ),
        peakUsage: await _heat(reader, scope),
        groupSizes: await _choiceBreakdown(
          reader,
          scope,
          AnalyticsMetric.groupSize,
        ),
        radiusChoices: await _choiceBreakdown(
          reader,
          scope,
          AnalyticsMetric.radiusSelected,
        ),
        deckSizeChoices: await _choiceBreakdown(
          reader,
          scope,
          AnalyticsMetric.deckSizeSelected,
        ),
        priceChoices: await _choiceBreakdown(
          reader,
          scope,
          AnalyticsMetric.priceSelected,
        ),
        visitChoices: await _choiceBreakdown(
          reader,
          scope,
          AnalyticsMetric.visitScheduled,
        ),
        qualityBreakdown: [
          for (final entry in const {
            AnalyticsMetric.staleDeck: 'Stale fallback',
            AnalyticsMetric.underfilledDeck: 'Underfilled deck',
          }.entries)
            AnalyticsBreakdown(
              key: entry.key,
              label: entry.value,
              value: totals.sum(entry.key),
              percentage: totals.sum(entry.key) / sessions * 100,
              sampleCount: totals.samples(entry.key),
            ),
        ],
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  static Future<AdminPlaceAnalytics> places(
    Session session, {
    required AnalyticsFilter filter,
    required PlaceRanking ranking,
    required int minimumSamples,
  }) async {
    _validate(filter);
    final labels = await _taxonomyLabels(session);
    return _report(session, (reader) async {
      final scope = _Scope(filter);
      final metrics = _literals(const [
        AnalyticsMetric.swipeLike,
        AnalyticsMetric.swipeDislike,
        AnalyticsMetric.legacyDeckExposure,
        AnalyticsMetric.deckIncluded,
        AnalyticsMetric.cardImpression,
      ]);
      final order = switch (ranking) {
        PlaceRanking.liked => 'likes_count DESC',
        PlaceRanking.disliked => 'dislikes_count DESC',
        PlaceRanking.approval => 'approval DESC',
        PlaceRanking.rejection => 'approval ASC',
      };
      final rows = await reader.query(
        '''
WITH totals AS (
  SELECT
    "placeId" AS place_id,
    COALESCE(SUM("total") FILTER (
      WHERE "metricName" = ${_literal(AnalyticsMetric.swipeLike)}
    ), 0) AS likes,
    COALESCE(SUM("total") FILTER (
      WHERE "metricName" = ${_literal(AnalyticsMetric.swipeDislike)}
    ), 0) AS dislikes,
    COALESCE(SUM("total") FILTER (
      WHERE "metricName" IN (
        ${_literal(AnalyticsMetric.legacyDeckExposure)},
        ${_literal(AnalyticsMetric.deckIncluded)}
      )
    ), 0) AS exposures,
    COALESCE(SUM("total") FILTER (
      WHERE "metricName" = ${_literal(AnalyticsMetric.cardImpression)}
    ), 0) AS impressions
  FROM "hayer_product_analytics_hour"
  WHERE "placeId" <> ''
    AND "metricName" IN ($metrics)
    AND ${scope.conditions()}
  GROUP BY "placeId"
), counted AS (
  SELECT
    totals.*,
    GREATEST(0, ROUND(CAST(likes AS numeric)))::bigint AS likes_count,
    GREATEST(0, ROUND(CAST(dislikes AS numeric)))::bigint AS dislikes_count,
    GREATEST(0, ROUND(CAST(likes + dislikes AS numeric)))::bigint AS votes
  FROM totals
), ranked AS (
  SELECT
    counted.*,
    CASE
      WHEN votes = 0 THEN 0
      ELSE GREATEST(0, likes) / votes * 100
    END AS approval
  FROM counted
  WHERE votes >= @minimum
  ORDER BY $order, likes_count + dislikes_count DESC, place_id COLLATE "C"
  LIMIT 50
)
SELECT ranked.*, latest.name
FROM ranked
LEFT JOIN LATERAL (
  SELECT "placeName" AS name
  FROM "hayer_product_analytics_hour"
  WHERE "placeId" = ranked.place_id
    AND "placeName" <> ''
    AND "metricName" IN ($metrics)
    AND ${scope.conditions()}
  ORDER BY "bucketStartedAt" DESC
  LIMIT 1
) AS latest ON true
ORDER BY $order, likes_count + dislikes_count DESC, place_id COLLATE "C"
''',
        {...scope.parameters, 'minimum': minimumSamples.clamp(1, 10000)},
      );
      return AdminPlaceAnalytics(
        items: [
          for (final row in rows)
            PlaceInsight(
              placeId: row['place_id'] as String,
              name: row['name'] as String? ?? 'Unnamed place',
              likes: row['likes_count'] as int,
              dislikes: row['dislikes_count'] as int,
              deckAppearances: max(0, (row['exposures'] as double).round()),
              cardImpressions: max(0, (row['impressions'] as double).round()),
              approvalRate: (row['approval'] as num).toDouble(),
            ),
        ],
        topCuisines: await _taxonomyBreakdown(
          reader,
          scope,
          TaxonomyKind.cuisine,
          labels,
        ),
        topTypes: await _taxonomyBreakdown(
          reader,
          scope,
          TaxonomyKind.poiType,
          labels,
        ),
        generatedAt: DateTime.now().toUtc(),
      );
    });
  }

  static Future<T> _report<T>(
    Session session,
    Future<T> Function(_Reader reader) body,
  ) async {
    if (_activeReports >= maximumConcurrentReports) {
      throw ApiException(
        code: 'rate_limited',
        message:
            'Other analytics reports are still loading. Try again shortly.',
        retryAfterSeconds: 5,
      );
    }
    _activeReports++;
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
            'This report took too long. Choose a shorter period or a '
            'narrower filter.',
        retryAfterSeconds: 5,
      );
    } finally {
      _activeReports--;
    }
  }

  static Future<AdminLiveUsage> _live(_Reader reader, DateTime now) async {
    final row = (await reader.query(
      '''
SELECT
  COUNT(*)::int AS ongoing,
  (COUNT(*) FILTER (
    WHERE room."mode" = ${_literal(SessionMode.solo.name)}
  ))::int AS solo,
  (COUNT(*) FILTER (
    WHERE room."mode" = ${_literal(SessionMode.multiplayer.name)}
  ))::int AS multiplayer,
  COALESCE(SUM(members.enrolled), 0)::int AS enrolled,
  COALESCE(SUM(members.active), 0)::int AS active
FROM "hayer_session" AS room
CROSS JOIN LATERAL (
  SELECT
    COUNT(*) AS enrolled,
    COUNT(*) FILTER (
      WHERE participant."lastSeenAt" >= CAST(@activeAfter AS timestamp)
    ) AS active
  FROM "hayer_participant" AS participant
  WHERE participant."sessionId" = room."sessionId"
) AS members
WHERE room."status" = ${_literal(SessionStatus.active.name)}
  AND room."expiresAt" > CAST(@now AS timestamp)
''',
      {
        'now': now.toIso8601String(),
        'activeAfter': now
            .subtract(const Duration(minutes: 5))
            .toIso8601String(),
      },
    )).single;
    return AdminLiveUsage(
      ongoingSessions: row['ongoing'] as int,
      soloSessions: row['solo'] as int,
      multiplayerSessions: row['multiplayer'] as int,
      enrolledParticipants: row['enrolled'] as int,
      activeParticipants: row['active'] as int,
      generatedAt: now,
    );
  }

  static Future<_Totals> _totals(
    _Reader reader,
    _Scope scope,
    List<String> metrics, {
    bool withPrevious = false,
  }) async {
    final rows = await reader.query('''
SELECT
  "metricName" AS metric,
  COALESCE(SUM("total") FILTER (
    WHERE "bucketStartedAt" >= CAST(@from AS timestamp)
  ), 0) AS total,
  COALESCE(SUM("sampleCount") FILTER (
    WHERE "bucketStartedAt" >= CAST(@from AS timestamp)
  ), 0)::bigint AS samples,
  COALESCE(SUM("total") FILTER (
    WHERE "bucketStartedAt" < CAST(@from AS timestamp)
  ), 0) AS previous_total,
  COALESCE(SUM("sampleCount") FILTER (
    WHERE "bucketStartedAt" < CAST(@from AS timestamp)
  ), 0)::bigint AS previous_samples
FROM "hayer_product_analytics_hour"
WHERE "metricName" IN (${_literals(metrics)})
  AND ${scope.conditions(withPrevious: withPrevious)}
GROUP BY "metricName"
''', scope.parameters);
    return _Totals({for (final row in rows) row['metric'] as String: row});
  }

  static Future<List<AnalyticsPoint>> _trend(
    _Reader reader,
    _Scope scope,
    String metric, {
    String? series,
  }) async {
    final rows = await reader.query('''
SELECT
  ${_bucketExpression(scope.filter.granularity)} AS bucket,
  ${series == null ? "''" : '"$series"'} AS series,
  SUM("total") AS value
FROM "hayer_product_analytics_hour"
WHERE "metricName" = ${_literal(metric)}
  AND ${scope.conditions()}
GROUP BY 1, 2
ORDER BY 1${series == null ? '' : ', "$series" COLLATE "C"'}
''', scope.parameters);
    return [
      for (final row in rows)
        if (series == null ? metric : row['series'] as String case final key)
          AnalyticsPoint(
            bucketStartedAt: (row['bucket'] as DateTime).toUtc(),
            seriesKey: key,
            seriesLabel: _title(key),
            value: row['value'] as double,
          ),
    ];
  }

  /// The start of the reporting bucket holding an hour row, in UTC. Buckets
  /// follow [analyticsBucket]: Riyadh days, and weeks starting on Sunday.
  static String _bucketExpression(AnalyticsGranularity granularity) {
    final offset = "INTERVAL '${analyticsReportingOffset.inHours} hours'";
    final local = '("bucketStartedAt" + $offset)';
    return switch (granularity) {
      AnalyticsGranularity.hourly => "date_trunc('hour', \"bucketStartedAt\")",
      AnalyticsGranularity.daily => "date_trunc('day', $local) - $offset",
      // DOW counts days since Sunday, which starts the reporting week.
      AnalyticsGranularity.weekly =>
        "date_trunc('day', $local) "
            '- make_interval(days => EXTRACT(DOW FROM $local)::int) '
            '- $offset',
    };
  }

  static Future<List<AnalyticsBreakdown>> _taxonomyBreakdown(
    _Reader reader,
    _Scope scope,
    TaxonomyKind kind,
    Map<String, String> labels,
  ) => _breakdown(
    reader,
    scope,
    AnalyticsMetric.taxonomySelected,
    key: 'taxonomyId',
    label: (key) => labels[key] ?? key,
    condition: '"taxonomyKind" = ${_literal(kind.name)}',
    limit: 10,
  );

  static Future<List<AnalyticsBreakdown>> _choiceBreakdown(
    _Reader reader,
    _Scope scope,
    String metric,
  ) => _breakdown(
    reader,
    scope,
    metric,
    key: 'taxonomyId',
    label: (key) => key,
  );

  /// The [limit] largest groups of [metric] by the [key] column, each with
  /// its share of every group's total. A group is named by [label], or else
  /// by the [latestLabel] column's most recent value in the range.
  static Future<List<AnalyticsBreakdown>> _breakdown(
    _Reader reader,
    _Scope scope,
    String metric, {
    required String key,
    String Function(String key)? label,
    String? latestLabel,
    String? condition,
    int limit = 12,
  }) async {
    final where = [
      '"metricName" = ${_literal(metric)}',
      scope.conditions(),
      ?condition,
    ].join('\n    AND ');
    final rows = await reader.query('''
WITH grouped AS (
  SELECT
    "$key" AS group_key,
    SUM("total") AS value,
    SUM("sampleCount")::bigint AS samples,
    SUM(SUM("total")) OVER () AS grand_total
  FROM "hayer_product_analytics_hour"
  WHERE $where
  GROUP BY "$key"
  ORDER BY value DESC, "$key" COLLATE "C"
  LIMIT $limit
)
SELECT grouped.*${latestLabel == null ? '' : ', latest.label'}
FROM grouped
${latestLabel == null ? '' : '''
LEFT JOIN LATERAL (
  SELECT "$latestLabel" AS label
  FROM "hayer_product_analytics_hour"
  WHERE "$key" = grouped.group_key
    AND $where
  ORDER BY "bucketStartedAt" DESC
  LIMIT 1
) AS latest ON true
'''}ORDER BY grouped.value DESC, grouped.group_key COLLATE "C"
''', scope.parameters);
    return [
      for (final row in rows)
        if ((row['group_key'] as String, row['value'] as double) case (
          final groupKey,
          final value,
        ))
          AnalyticsBreakdown(
            key: groupKey,
            label: label?.call(groupKey) ?? row['label'] as String? ?? groupKey,
            value: value,
            percentage: switch (row['grand_total'] as double) {
              <= 0 => 0,
              final total => value / total * 100,
            },
            sampleCount: row['samples'] as int,
          ),
    ];
  }

  static Future<List<AnalyticsHeatCell>> _heat(
    _Reader reader,
    _Scope scope,
  ) async {
    final local =
        '"bucketStartedAt" + '
        "INTERVAL '${analyticsReportingOffset.inHours} hours'";
    final rows = await reader.query('''
SELECT
  EXTRACT(ISODOW FROM $local)::int AS weekday,
  EXTRACT(HOUR FROM $local)::int AS local_hour,
  SUM("total") AS value
FROM "hayer_product_analytics_hour"
WHERE "metricName" = ${_literal(AnalyticsMetric.sessionCreated)}
  AND ${scope.conditions()}
GROUP BY 1, 2
ORDER BY 1, 2
''', scope.parameters);
    return [
      for (final row in rows)
        AnalyticsHeatCell(
          weekday: row['weekday'] as int,
          hour: row['local_hour'] as int,
          value: row['value'] as double,
        ),
    ];
  }

  static void _validate(AnalyticsFilter filter) {
    final span = filter.to.difference(filter.from);
    if (!filter.to.isAfter(filter.from) || span > maximumSpan) {
      throw ApiException(
        code: 'bad_request',
        message: 'Choose a reporting range between one hour and 12 months.',
      );
    }
    if (filter.granularity == AnalyticsGranularity.hourly &&
        span > maximumHourlySpan) {
      throw ApiException(
        code: 'bad_request',
        message:
            'Hourly buckets cover at most 31 days. Choose daily or weekly '
            'buckets for a longer range.',
      );
    }
  }

  static Future<Map<String, String>> _taxonomyLabels(Session session) async => {
    for (final item in await TaxonomyService.activeItems(session))
      item.id: item.labelEn,
  };

  static AnalyticsKpi _kpi(
    String key,
    String label,
    double value,
    double previous,
    String unit,
  ) => AnalyticsKpi(
    key: key,
    label: label,
    value: value,
    previousValue: previous,
    unit: unit,
  );

  static double _rate(double numerator, double denominator) =>
      denominator <= 0 ? 0 : numerator / denominator * 100;

  static String _title(String value) => value.isEmpty
      ? 'Unknown'
      : '${value[0].toUpperCase()}${value.substring(1)}';

  /// Metric names, enum names and taxonomy kinds are code constants, inlined
  /// so the planner sees them. Anything else is refused.
  static String _literal(String value) {
    if (!RegExp(r'^[A-Za-z0-9_]+$').hasMatch(value)) {
      throw ArgumentError.value(value, 'value', 'Not a SQL-safe constant');
    }
    return "'$value'";
  }

  static String _literals(List<String> values) =>
      values.map(_literal).join(', ');
}

/// The reporting range and filters shared by a report's statements.
final class _Scope {
  _Scope(this.filter);

  final AnalyticsFilter filter;

  String? get _cityKey => _trimmed(filter.cityKey);
  String? get _categoryId => _trimmed(filter.categoryId);

  /// Conditions on hour rows. [withPrevious] starts the range at the
  /// previous period, which is as long as the current one and ends where it
  /// begins.
  String conditions({bool withPrevious = false}) => [
    '"bucketStartedAt" >= '
        'CAST(@${withPrevious ? 'previousFrom' : 'from'} AS timestamp)',
    '"bucketStartedAt" < CAST(@to AS timestamp)',
    if (filter.mode != null) '"modeKey" = @mode',
    if (_cityKey != null) '"cityKey" = @cityKey',
    if (_categoryId != null) '"categoryId" = @categoryId',
  ].join('\n  AND ');

  Map<String, Object?> get parameters {
    final from = filter.from.toUtc();
    final to = filter.to.toUtc();
    return {
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'previousFrom': from.subtract(to.difference(from)).toIso8601String(),
      'mode': filter.mode?.name,
      'cityKey': _cityKey,
      'categoryId': _categoryId,
    };
  }

  static String? _trimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}

/// Runs a report's statements on one transaction, or on the session's pool
/// when there is none.
final class _Reader {
  _Reader(this.session, [this.transaction]);

  final Session session;
  final Transaction? transaction;

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
    AnalyticsQueryService.statementObserver?.call(sql, used);
    final rows = await session.db.unsafeQuery(
      sql,
      parameters: QueryParameters.named(used),
      transaction: transaction,
    );
    return [for (final row in rows) row.toColumnMap()];
  }
}

final class _Totals {
  _Totals(this._rows);

  final Map<String, Map<String, dynamic>> _rows;

  double sum(String metric, {bool previous = false}) =>
      (_rows[metric]?[previous ? 'previous_total' : 'total'] as double?) ?? 0;

  int samples(String metric, {bool previous = false}) =>
      (_rows[metric]?[previous ? 'previous_samples' : 'samples'] as int?) ?? 0;

  /// The total per sample, as the aggregator sums both.
  double average(String metric, {bool previous = false}) {
    final count = samples(metric, previous: previous);
    return count == 0 ? 0 : sum(metric, previous: previous) / count;
  }
}
