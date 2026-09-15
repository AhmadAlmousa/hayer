import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

abstract final class AnalyticsMetric {
  static const journeyStarted = 'journey_started';
  static const sessionCreated = 'session_created';
  static const participantJoined = 'participant_joined';
  static const participantCompleted = 'participant_completed';
  static const swipeLike = 'swipe_like';
  static const swipeDislike = 'swipe_dislike';
  static const deckIncluded = 'deck_included';
  static const legacyDeckExposure = 'deck_exposure';
  static const cardImpression = 'card_impression';
  static const placeDetailsOpened = 'place_details_opened';
  static const resultsViewed = 'results_viewed';
  static const choiceConfirmed = 'choice_confirmed';
  static const choiceChanged = 'choice_changed';
  static const noMatchCompleted = 'no_match_completed';
  static const outboxQueued = 'outbox_queued';
  static const syncRecovered = 'sync_recovered';
  static const syncTerminalFailure = 'sync_terminal_failure';
  static const decisionCompleted = 'decision_completed';
  static const decisionTimeSeconds = 'decision_time_seconds';
  static const matchCompleted = 'match_completed';
  static const placeMatched = 'place_matched';
  static const groupSize = 'group_size';
  static const swipeDepth = 'swipe_depth';
  static const taxonomySelected = 'taxonomy_selected';
  static const radiusSelected = 'radius_selected';
  static const deckSizeSelected = 'deck_size_selected';
  static const priceSelected = 'price_selected';
  static const visitScheduled = 'visit_scheduled';
  static const staleDeck = 'stale_deck';
  static const underfilledDeck = 'underfilled_deck';
  static const shortlistUsed = 'shortlist_used';
}

abstract final class AnalyticsOrigin {
  static const server = 'server';
  static const client = 'client';
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
    this.receivedAt,
    this.eventSchemaVersion = 1,
    this.origin = AnalyticsOrigin.server,
    this.journeyId,
    this.appBuild,
    this.platform,
    this.language,
    this.outcomeCode,
    this.deckPosition,
    this.visibleMilliseconds,
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
  final DateTime? receivedAt;
  final int eventSchemaVersion;
  final String origin;
  final String? journeyId;
  final int? appBuild;
  final String? platform;
  final String? language;
  final String? outcomeCode;
  final int? deckPosition;
  final int? visibleMilliseconds;

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
    receivedAt: receivedAt?.toUtc() ?? DateTime.now().toUtc(),
    eventSchemaVersion: eventSchemaVersion,
    origin: origin,
    journeyId: journeyId,
    appBuild: appBuild,
    platform: platform,
    language: language,
    outcomeCode: outcomeCode,
    deckPosition: deckPosition,
    visibleMilliseconds: visibleMilliseconds,
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
    ClientAnalyticsContext? context,
    String origin = AnalyticsOrigin.server,
    String? outcomeCode,
    int? deckPosition,
    int? visibleMilliseconds,
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
    eventSchemaVersion: context?.schemaVersion ?? 1,
    origin: origin,
    journeyId: context == null ? null : _bounded(context.journeyId, 64),
    appBuild: context?.appBuild,
    platform: context == null ? null : _bounded(context.platform, 24),
    language: context == null ? null : _bounded(context.language, 16),
    outcomeCode: outcomeCode == null ? null : _bounded(outcomeCode, 64),
    deckPosition: deckPosition,
    visibleMilliseconds: visibleMilliseconds,
  );

  static AnalyticsEvent clientEvent({
    required String eventId,
    required DateTime occurredAt,
    required String metricName,
    required ClientAnalyticsContext context,
    HayerSessionRow? sessionRow,
    String placeId = '',
    String placeName = '',
    String? outcomeCode,
    int? deckPosition,
    int? visibleMilliseconds,
  }) => AnalyticsEvent(
    eventId: eventId,
    occurredAt: occurredAt,
    metricName: metricName,
    modeKey: sessionRow?.mode.name ?? 'unknown',
    countryCode: sessionRow?.countryCode ?? 'unknown',
    cityKey: sessionRow?.cityKey ?? 'unknown',
    cityName: sessionRow?.cityName ?? 'Unknown',
    categoryId: sessionRow?.categoryId ?? 'unknown',
    placeId: _bounded(placeId, 128),
    placeName: _bounded(placeName, 160),
    eventSchemaVersion: context.schemaVersion,
    origin: AnalyticsOrigin.client,
    journeyId: _bounded(context.journeyId, 64),
    appBuild: context.appBuild,
    platform: _bounded(context.platform, 24),
    language: _bounded(context.language, 16),
    outcomeCode: outcomeCode == null ? null : _bounded(outcomeCode, 64),
    deckPosition: deckPosition,
    visibleMilliseconds: visibleMilliseconds,
  );

  static String _bounded(String value, int maximum) =>
      value.length <= maximum ? value : value.substring(0, maximum);
}

DateTime analyticsHour(DateTime value) {
  final utc = value.toUtc();
  return DateTime.utc(utc.year, utc.month, utc.day, utc.hour);
}

/// Reports use Asia/Riyadh, which keeps a fixed UTC+3 offset all year.
const analyticsReportingOffset = Duration(hours: 3);

DateTime analyticsBucket(DateTime value, AnalyticsGranularity granularity) {
  const offset = analyticsReportingOffset;
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
