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
}
