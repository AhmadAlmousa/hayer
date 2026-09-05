import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

abstract final class AnalyticsMetric {
  static const sessionCreated = 'session_created';
  static const participantJoined = 'participant_joined';
  static const participantCompleted = 'participant_completed';
  static const swipeLike = 'swipe_like';
  static const swipeDislike = 'swipe_dislike';
  static const deckExposure = 'deck_exposure';
  static const decisionCompleted = 'decision_completed';
  static const decisionTimeSeconds = 'decision_time_seconds';
  static const matchCompleted = 'match_completed';
  static const groupSize = 'group_size';
  static const swipeDepth = 'swipe_depth';
  static const taxonomySelected = 'taxonomy_selected';
  static const radiusSelected = 'radius_selected';
  static const deckSizeSelected = 'deck_size_selected';
  static const priceSelected = 'price_selected';
  static const visitScheduled = 'visit_scheduled';
  static const staleDeck = 'stale_deck';
  static const underfilledDeck = 'underfilled_deck';
}

class AnalyticsEvent {
  const AnalyticsEvent({
    required this.eventId,
    required this.occurredAt,
    required this.metricName,
    required this.modeKey,
    required this.countryCode,
    required this.cityKey,
    required this.cityName,
    required this.categoryId,
    this.taxonomyKind = '',
    this.taxonomyId = '',
    this.placeId = '',
    this.placeName = '',
    this.value = 1,
    this.sampleCount = 1,
  });

  final String eventId;
  final DateTime occurredAt;
  final String metricName;
  final String modeKey;
  final String countryCode;
  final String cityKey;
  final String cityName;
  final String categoryId;
  final String taxonomyKind;
  final String taxonomyId;
  final String placeId;
  final String placeName;
  final double value;
  final int sampleCount;

  ProductAnalyticsEventRow toRow() => ProductAnalyticsEventRow(
    eventId: eventId,
    occurredAt: occurredAt.toUtc(),
    metricName: metricName,
    modeKey: modeKey,
    countryCode: countryCode,
    cityKey: cityKey,
    cityName: cityName,
    categoryId: categoryId,
    taxonomyKind: taxonomyKind,
    taxonomyId: taxonomyId,
    placeId: placeId,
    placeName: placeName,
    value: value,
    sampleCount: sampleCount,
  );
}

abstract final class ProductAnalyticsRecorder {
  static Future<void> record(
    Session session,
    Iterable<AnalyticsEvent> events, {
    Transaction? transaction,
  }) async {
    final rows = events.map((event) => event.toRow()).toList(growable: false);
    if (rows.isEmpty) return;
    await ProductAnalyticsEventRow.db.insert(
      session,
      rows,
      transaction: transaction,
      ignoreConflicts: true,
    );
  }

  static AnalyticsEvent event({
    required String eventId,
    required DateTime occurredAt,
    required String metricName,
    required HayerSessionRow sessionRow,
    String taxonomyKind = '',
    String taxonomyId = '',
    String placeId = '',
    String placeName = '',
    double value = 1,
    int sampleCount = 1,
  }) => AnalyticsEvent(
    eventId: eventId,
    occurredAt: occurredAt,
    metricName: metricName,
    modeKey: sessionRow.mode.name,
    countryCode: sessionRow.countryCode,
    cityKey: sessionRow.cityKey ?? 'unknown',
    cityName: sessionRow.cityName ?? 'Unknown',
    categoryId: sessionRow.categoryId,
    taxonomyKind: taxonomyKind,
    taxonomyId: taxonomyId,
    placeId: placeId,
    placeName: _bounded(placeName, 160),
    value: value,
    sampleCount: sampleCount,
  );

  static String _bounded(String value, int maximum) =>
      value.length <= maximum ? value : value.substring(0, maximum);
}

DateTime analyticsHour(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day, utc.hour);
}

DateTime analyticsBucket(DateTime value, AnalyticsGranularity granularity) {
  const offset = Duration(hours: 3);
  final riyadh = value.toUtc().add(offset);
  late final DateTime localBucket;
  switch (granularity) {
    case AnalyticsGranularity.hourly:
      localBucket = DateTime.utc(
        riyadh.year,
        riyadh.month,
        riyadh.day,
        riyadh.hour,
      );
    case AnalyticsGranularity.daily:
      localBucket = DateTime.utc(riyadh.year, riyadh.month, riyadh.day);
    case AnalyticsGranularity.weekly:
      // DateTime.sunday is 7; Sunday is the first reporting day.
      final daysSinceSunday = riyadh.weekday % 7;
      localBucket = DateTime.utc(
        riyadh.year,
        riyadh.month,
        riyadh.day,
      ).subtract(Duration(days: daysSinceSunday));
  }
  return localBucket.subtract(offset);
}
