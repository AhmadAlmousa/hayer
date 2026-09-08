import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/taxonomy_service.dart';
import 'product_analytics.dart';

abstract final class AnalyticsQueryService {
  static Future<AdminLiveUsage> live(Session session) async {
    final now = DateTime.now().toUtc();
    Expression<dynamic> active(HayerSessionRowTable table) =>
        table.status.equals(SessionStatus.active) & (table.expiresAt > now);
    final sessions = await HayerSessionRow.db.find(
      session,
      where: active,
    );
    final ids = sessions.map((row) => row.sessionId).toSet();
    final participants = ids.isEmpty
        ? const <ParticipantRow>[]
        : await ParticipantRow.db.find(
            session,
            where: (table) => table.sessionId.inSet(ids),
          );
    final activeAfter = now.subtract(const Duration(minutes: 5));
    return AdminLiveUsage(
      ongoingSessions: sessions.length,
      soloSessions: sessions
          .where((row) => row.mode == SessionMode.solo)
          .length,
      multiplayerSessions: sessions
          .where((row) => row.mode == SessionMode.multiplayer)
          .length,
      enrolledParticipants: participants.length,
      activeParticipants: participants
          .where((row) => !row.lastSeenAt.isBefore(activeAfter))
          .length,
      generatedAt: now,
    );
  }

  static Future<AdminAnalyticsOverview> overview(
    Session session, {
    required AnalyticsFilter filter,
    required CacheDashboardSummary cacheSummary,
  }) async {
    _validate(filter);
    final period = filter.to.difference(filter.from);
    final previousFilter = filter.copyWith(
      from: filter.from.subtract(period),
      to: filter.from,
    );
    final rows = await _load(session, filter);
    final previous = await _load(session, previousFilter);
    final taxonomy = await TaxonomyService.activeItems(session);
    final labels = {for (final item in taxonomy) item.id: item.labelEn};
    final sessions = _sum(rows, AnalyticsMetric.sessionCreated);
    final participants = _sum(rows, AnalyticsMetric.participantJoined);
    final decisions = _sum(rows, AnalyticsMetric.decisionCompleted);
    final matches = _sum(rows, AnalyticsMetric.matchCompleted);
    final previousSessions = _sum(previous, AnalyticsMetric.sessionCreated);
    final previousParticipants = _sum(
      previous,
      AnalyticsMetric.participantJoined,
    );
    final previousDecisions = _sum(
      previous,
      AnalyticsMetric.decisionCompleted,
    );
    final previousMatches = _sum(previous, AnalyticsMetric.matchCompleted);
    return AdminAnalyticsOverview(
      live: await live(session),
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
          _average(rows, AnalyticsMetric.decisionTimeSeconds),
          _average(previous, AnalyticsMetric.decisionTimeSeconds),
          'seconds',
        ),
      ],
      sessionTrend: _trend(
        rows,
        AnalyticsMetric.sessionCreated,
        filter.granularity,
        series: (row) => row.modeKey,
      ),
      modeBreakdown: _breakdown(
        rows,
        AnalyticsMetric.sessionCreated,
        key: (row) => row.modeKey,
        label: (row) => _title(row.modeKey),
      ),
      participantModeBreakdown: _breakdown(
        rows,
        AnalyticsMetric.participantJoined,
        key: (row) => row.modeKey,
        label: (row) => _title(row.modeKey),
      ),
      topCities: _breakdown(
        rows,
        AnalyticsMetric.sessionCreated,
        key: (row) => row.cityKey,
        label: (row) => row.cityName,
        limit: 8,
      ),
      topCategories: _breakdown(
        rows,
        AnalyticsMetric.sessionCreated,
        key: (row) => row.categoryId,
        label: (row) => labels[row.categoryId] ?? row.categoryId,
        limit: 8,
      ),
      topCuisines: _taxonomyBreakdown(
        rows,
        TaxonomyKind.cuisine,
        labels,
      ),
      topTypes: _taxonomyBreakdown(rows, TaxonomyKind.poiType, labels),
      cacheSummary: cacheSummary,
      generatedAt: DateTime.now().toUtc(),
    );
  }

  static Future<AdminUsageAnalytics> usage(
    Session session, {
    required AnalyticsFilter filter,
  }) async {
    _validate(filter);
    final rows = await _load(session, filter);
    return AdminUsageAnalytics(
      averageSwipeDepth: _average(rows, AnalyticsMetric.swipeDepth),
      sessionTrend: _trend(
        rows,
        AnalyticsMetric.sessionCreated,
        filter.granularity,
        series: (row) => row.modeKey,
      ),
      participantTrend: _trend(
        rows,
        AnalyticsMetric.participantJoined,
        filter.granularity,
      ),
      decisionTrend: _trend(
        rows,
        AnalyticsMetric.decisionCompleted,
        filter.granularity,
      ),
      peakUsage: _heat(rows),
      groupSizes: _choiceBreakdown(rows, AnalyticsMetric.groupSize),
      radiusChoices: _choiceBreakdown(rows, AnalyticsMetric.radiusSelected),
      deckSizeChoices: _choiceBreakdown(
        rows,
        AnalyticsMetric.deckSizeSelected,
      ),
      priceChoices: _choiceBreakdown(rows, AnalyticsMetric.priceSelected),
      visitChoices: _choiceBreakdown(rows, AnalyticsMetric.visitScheduled),
      qualityBreakdown: [
        ..._simpleMetricBreakdown(rows, const {
          AnalyticsMetric.staleDeck: 'Stale fallback',
          AnalyticsMetric.underfilledDeck: 'Underfilled deck',
        }),
      ],
      generatedAt: DateTime.now().toUtc(),
    );
  }

  static Future<AdminPlaceAnalytics> places(
    Session session, {
    required AnalyticsFilter filter,
    required PlaceRanking ranking,
    required int minimumSamples,
  }) async {
    _validate(filter);
    final rows = await _load(session, filter);
    final taxonomy = await TaxonomyService.activeItems(session);
    final labels = {for (final item in taxonomy) item.id: item.labelEn};
    final values = <String, _PlaceAggregate>{};
    for (final row in rows.where((row) => row.placeId.isNotEmpty)) {
      final value = values.putIfAbsent(
        row.placeId,
        () => _PlaceAggregate(row.placeId, row.placeName),
      );
      switch (row.metricName) {
        case AnalyticsMetric.swipeLike:
          value.likes += row.total;
        case AnalyticsMetric.swipeDislike:
          value.dislikes += row.total;
        case AnalyticsMetric.legacyDeckExposure:
        case AnalyticsMetric.deckIncluded:
          value.exposures += row.total;
        case AnalyticsMetric.cardImpression:
          value.impressions += row.total;
      }
    }
    final safeMinimum = minimumSamples.clamp(1, 10000);
    final items = values.values
        .where((value) => value.votes >= safeMinimum)
        .map((value) => value.view())
        .toList();
    int compare(PlaceInsight left, PlaceInsight right) => switch (ranking) {
      PlaceRanking.liked => right.likes.compareTo(left.likes),
      PlaceRanking.disliked => right.dislikes.compareTo(left.dislikes),
      PlaceRanking.approval => right.approvalRate.compareTo(left.approvalRate),
      PlaceRanking.rejection => left.approvalRate.compareTo(right.approvalRate),
    };
    items.sort((left, right) {
      final ranked = compare(left, right);
      return ranked != 0
          ? ranked
          : (right.likes + right.dislikes).compareTo(
              left.likes + left.dislikes,
            );
    });
    return AdminPlaceAnalytics(
      items: items.take(50).toList(growable: false),
      topCuisines: _taxonomyBreakdown(
        rows,
        TaxonomyKind.cuisine,
        labels,
      ),
      topTypes: _taxonomyBreakdown(rows, TaxonomyKind.poiType, labels),
      generatedAt: DateTime.now().toUtc(),
    );
  }

  static Future<List<ProductAnalyticsHourRow>> _load(
    Session session,
    AnalyticsFilter filter,
  ) => ProductAnalyticsHourRow.db.find(
    session,
    where: (table) {
      var expression =
          (table.bucketStartedAt >= filter.from.toUtc()) &
          (table.bucketStartedAt < filter.to.toUtc());
      if (filter.mode != null) {
        expression = expression & table.modeKey.equals(filter.mode!.name);
      }
      if (filter.cityKey?.trim().isNotEmpty == true) {
        expression = expression & table.cityKey.equals(filter.cityKey!.trim());
      }
      if (filter.categoryId?.trim().isNotEmpty == true) {
        expression =
            expression & table.categoryId.equals(filter.categoryId!.trim());
      }
      return expression;
    },
    orderBy: (table) => table.bucketStartedAt,
  );

  static void _validate(AnalyticsFilter filter) {
    final span = filter.to.difference(filter.from);
    if (!filter.to.isAfter(filter.from) || span > const Duration(days: 366)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Choose a reporting range between one hour and 12 months.',
      );
    }
  }

  static double _sum(List<ProductAnalyticsHourRow> rows, String metric) => rows
      .where((row) => row.metricName == metric)
      .fold(0, (total, row) => total + row.total);

  static double _average(
    List<ProductAnalyticsHourRow> rows,
    String metric,
  ) {
    final selected = rows.where((row) => row.metricName == metric);
    final samples = selected.fold<int>(
      0,
      (total, row) => total + row.sampleCount,
    );
    return samples == 0
        ? 0
        : selected.fold<double>(0, (total, row) => total + row.total) / samples;
  }

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

  static List<AnalyticsPoint> _trend(
    List<ProductAnalyticsHourRow> rows,
    String metric,
    AnalyticsGranularity granularity, {
    String Function(ProductAnalyticsHourRow)? series,
  }) {
    final grouped = <String, _PointAggregate>{};
    for (final row in rows.where((row) => row.metricName == metric)) {
      final bucket = analyticsBucket(row.bucketStartedAt, granularity);
      final key = series?.call(row) ?? metric;
      grouped
              .putIfAbsent(
                '${bucket.toIso8601String()}:$key',
                () => _PointAggregate(bucket, key, _title(key)),
              )
              .value +=
          row.total;
    }
    final values = grouped.values.map((value) => value.view()).toList()
      ..sort(
        (left, right) => left.bucketStartedAt.compareTo(right.bucketStartedAt),
      );
    return values;
  }

  static List<AnalyticsBreakdown> _taxonomyBreakdown(
    List<ProductAnalyticsHourRow> rows,
    TaxonomyKind kind,
    Map<String, String> labels,
  ) => _breakdown(
    rows.where((row) => row.taxonomyKind == kind.name).toList(),
    AnalyticsMetric.taxonomySelected,
    key: (row) => row.taxonomyId,
    label: (row) => labels[row.taxonomyId] ?? row.taxonomyId,
    limit: 10,
  );

  static List<AnalyticsBreakdown> _choiceBreakdown(
    List<ProductAnalyticsHourRow> rows,
    String metric,
  ) => _breakdown(
    rows,
    metric,
    key: (row) => row.taxonomyId,
    label: (row) => row.taxonomyId,
  );

  static List<AnalyticsBreakdown> _breakdown(
    List<ProductAnalyticsHourRow> rows,
    String metric, {
    required String Function(ProductAnalyticsHourRow) key,
    required String Function(ProductAnalyticsHourRow) label,
    int limit = 12,
  }) {
    final grouped = <String, _BreakdownAggregate>{};
    for (final row in rows.where((row) => row.metricName == metric)) {
      grouped.putIfAbsent(
          key(row),
          () => _BreakdownAggregate(key(row), label(row)),
        )
        ..value += row.total
        ..samples += row.sampleCount;
    }
    final total = grouped.values.fold<double>(
      0,
      (sum, item) => sum + item.value,
    );
    final result = grouped.values.map((item) => item.view(total)).toList()
      ..sort((left, right) => right.value.compareTo(left.value));
    return result.take(limit).toList(growable: false);
  }

  static List<AnalyticsBreakdown> _simpleMetricBreakdown(
    List<ProductAnalyticsHourRow> rows,
    Map<String, String> metrics,
  ) {
    final values = <_BreakdownAggregate>[];
    for (final entry in metrics.entries) {
      final matching = rows.where((row) => row.metricName == entry.key);
      values.add(
        _BreakdownAggregate(entry.key, entry.value)
          ..value = matching.fold(0, (sum, row) => sum + row.total)
          ..samples = matching.fold(0, (sum, row) => sum + row.sampleCount),
      );
    }
    final total = max(1.0, _sum(rows, AnalyticsMetric.sessionCreated));
    return values.map((item) => item.view(total)).toList(growable: false);
  }

  static List<AnalyticsHeatCell> _heat(List<ProductAnalyticsHourRow> rows) {
    final values = <String, double>{};
    for (final row in rows.where(
      (row) => row.metricName == AnalyticsMetric.sessionCreated,
    )) {
      final local = row.bucketStartedAt.toUtc().add(const Duration(hours: 3));
      final key = '${local.weekday}:${local.hour}';
      values.update(
        key,
        (value) => value + row.total,
        ifAbsent: () => row.total,
      );
    }
    return [
      for (final entry in values.entries)
        AnalyticsHeatCell(
          weekday: int.parse(entry.key.split(':').first),
          hour: int.parse(entry.key.split(':').last),
          value: entry.value,
        ),
    ];
  }

  static String _title(String value) => value.isEmpty
      ? 'Unknown'
      : '${value[0].toUpperCase()}${value.substring(1)}';
}

class _PointAggregate {
  _PointAggregate(this.bucket, this.key, this.label);

  final DateTime bucket;
  final String key;
  final String label;
  double value = 0;

  AnalyticsPoint view() => AnalyticsPoint(
    bucketStartedAt: bucket,
    seriesKey: key,
    seriesLabel: label,
    value: value,
  );
}

class _BreakdownAggregate {
  _BreakdownAggregate(this.key, this.label);

  final String key;
  final String label;
  double value = 0;
  int samples = 0;

  AnalyticsBreakdown view(double total) => AnalyticsBreakdown(
    key: key,
    label: label,
    value: value,
    percentage: total <= 0 ? 0 : value / total * 100,
    sampleCount: samples,
  );
}

class _PlaceAggregate {
  _PlaceAggregate(this.placeId, this.name);

  final String placeId;
  final String name;
  double likes = 0;
  double dislikes = 0;
  double exposures = 0;
  double impressions = 0;

  int get votes => max(0, (likes + dislikes).round());

  PlaceInsight view() => PlaceInsight(
    placeId: placeId,
    name: name.isEmpty ? 'Unnamed place' : name,
    likes: max(0, likes.round()),
    dislikes: max(0, dislikes.round()),
    deckAppearances: max(0, exposures.round()),
    cardImpressions: max(0, impressions.round()),
    approvalRate: votes == 0 ? 0 : max(0, likes) / votes * 100,
  );
}
