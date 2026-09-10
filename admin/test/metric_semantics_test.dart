import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/analytics/analytics_period.dart';
import 'package:hayer_admin/features/analytics/metric_semantics.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  group('metric polarity', () {
    test('a slower average decision time reads as worse, not better', () {
      // Behavior under test: the tile used to paint every increase green, so a
      // decision time trending up looked like an improvement.
      expect(metricVerdict('decision_time', 4.2), MetricVerdict.worse);
      expect(metricVerdict('decision_time', -4.2), MetricVerdict.better);
    });

    test('more sessions reads as better', () {
      expect(metricVerdict('sessions', 12), MetricVerdict.better);
      expect(metricVerdict('sessions', -12), MetricVerdict.worse);
    });

    test('group size carries no verdict in either direction', () {
      // Larger rooms are a usage characteristic, not a quality signal.
      expect(
        metricVerdict('participants_per_session', 1.5),
        MetricVerdict.none,
      );
      expect(
        metricVerdict('participants_per_session', -1.5),
        MetricVerdict.none,
      );
    });

    test('an unchanged metric never carries a verdict', () {
      expect(metricVerdict('sessions', 0), MetricVerdict.none);
      expect(metricVerdict('decision_time', 0), MetricVerdict.none);
    });

    test('a metric this dashboard does not know stays neutral', () {
      // A KPI added server-side must not be given a polarity we cannot justify.
      expect(metricVerdict('some_future_metric', 99), MetricVerdict.none);
    });
  });

  group('denominators', () {
    final kpis = [
      _kpi('sessions', 400),
      _kpi('completion_rate', 62),
      _kpi('match_rate', 48),
    ];

    test('a rate resolves the sibling KPI holding its denominator', () {
      expect(metricBasis(kpis[1], kpis), 400);
    });

    test('match rate reports no basis because the response omits it', () {
      // Its denominator is completed decisions, which the overview does not
      // expose. The tile must not invent one.
      expect(metricBasis(kpis[2], kpis), isNull);
    });

    test('a missing sibling yields no basis rather than a wrong one', () {
      expect(metricBasis(kpis[1], [kpis[1]]), isNull);
    });
  });

  group('small-cohort suppression', () {
    test('withholds shares drawn from too few samples', () {
      final result = suppressSmallCohorts([
        _breakdown('riyadh', 120),
        _breakdown('jeddah', 2),
        _breakdown('dammam', 5),
      ]);
      expect(result.shown.map((value) => value.key), ['riyadh', 'dammam']);
      expect(result.withheld, 1);
    });

    test('keeps everything when every cohort is large enough', () {
      final result = suppressSmallCohorts([
        _breakdown('riyadh', 120),
        _breakdown('jeddah', 90),
      ]);
      expect(result.shown, hasLength(2));
      expect(result.withheld, 0);
    });
  });

  group('period and lag', () {
    final filter = AnalyticsFilter(
      from: DateTime.utc(2026, 9, 1),
      to: DateTime.utc(2026, 9, 30),
      granularity: AnalyticsGranularity.daily,
    );

    test('a delta names the window it is compared against', () {
      // "vs previous" alone left the comparison unstated.
      expect(describeComparison(filter), 'vs previous 29 days');
    });

    test('a single-day window reads in the singular', () {
      expect(
        describeComparison(
          AnalyticsFilter(
            from: DateTime.utc(2026, 9, 1),
            to: DateTime.utc(2026, 9, 2),
            granularity: AnalyticsGranularity.hourly,
          ),
        ),
        'vs previous day',
      );
    });

    test('lag is measured, not asserted', () {
      final generated = DateTime.utc(2026, 9, 30, 12);
      expect(
        describeLag(generated, now: DateTime.utc(2026, 9, 30, 12, 35)),
        contains('35 min behind'),
      );
      expect(
        describeLag(generated, now: DateTime.utc(2026, 9, 30, 12, 0, 10)),
        contains('just now'),
      );
    });

    test('a stalled rollup is flagged, a healthy one is not', () {
      final generated = DateTime.utc(2026, 9, 30, 12);
      expect(
        isLagConcerning(generated, now: DateTime.utc(2026, 9, 30, 12, 6)),
        isFalse,
      );
      expect(
        isLagConcerning(generated, now: DateTime.utc(2026, 9, 30, 13)),
        isTrue,
      );
    });
  });
}

AnalyticsKpi _kpi(String key, double value) => AnalyticsKpi(
  key: key,
  label: key,
  value: value,
  previousValue: 0,
  unit: '',
);

AnalyticsBreakdown _breakdown(String key, int samples) => AnalyticsBreakdown(
  key: key,
  label: key,
  value: samples.toDouble(),
  percentage: 10,
  sampleCount: samples,
);
