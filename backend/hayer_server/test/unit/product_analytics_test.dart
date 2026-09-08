import 'package:hayer_server/src/analytics/product_analytics.dart';
import 'package:hayer_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('daily buckets use the Asia/Riyadh boundary', () {
    final value = DateTime.utc(2026, 9, 5, 22, 15);

    expect(
      analyticsBucket(value, AnalyticsGranularity.daily),
      DateTime.utc(2026, 9, 5, 21),
    );
  });

  test('weekly buckets begin on Sunday in Asia/Riyadh', () {
    final saturdayEveningUtc = DateTime.utc(2026, 9, 5, 22);

    expect(
      analyticsBucket(saturdayEveningUtc, AnalyticsGranularity.weekly),
      DateTime.utc(2026, 9, 5, 21),
    );
  });

  test('hour compaction always truncates in UTC', () {
    expect(
      analyticsHour(DateTime.utc(2026, 9, 5, 10, 59, 59)),
      DateTime.utc(2026, 9, 5, 10),
    );
  });

  test('client events retain bounded journey and schema metadata', () {
    final context = ClientAnalyticsContext(
      journeyId: '01991ed0-38ab-7d18-9f25-c1f73842a876',
      schemaVersion: 1,
      appBuild: 7,
      platform: 'android',
      language: 'ar',
    );

    final row = ProductAnalyticsRecorder.clientEvent(
      eventId: '01991ed0-38ab-7d18-9f25-c1f73842a877',
      occurredAt: DateTime.utc(2026, 9, 8, 10),
      metricName: AnalyticsMetric.cardImpression,
      context: context,
      placeId: 'place-1',
      deckPosition: 0,
      visibleMilliseconds: 500,
    ).toRow();

    expect(row.metricName, 'card_impression');
    expect(row.origin, AnalyticsOrigin.client);
    expect(row.eventSchemaVersion, 1);
    expect(row.journeyId, context.journeyId);
    expect(row.appBuild, 7);
    expect(row.platform, 'android');
    expect(row.language, 'ar');
    expect(row.deckPosition, 0);
    expect(row.visibleMilliseconds, 500);
    expect(row.receivedAt, isNotNull);
  });
}
