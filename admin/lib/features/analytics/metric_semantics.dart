import 'package:hayer_client/hayer_client.dart';

/// Whether a rise in a metric is an improvement, a regression, or neither.
///
/// `AnalyticsKpi` carries no polarity, so the dashboard has to supply it. The
/// tile previously painted every increase as good, which reads a rising average
/// decision time as an improvement.
enum MetricDirection { higherIsBetter, lowerIsBetter, neutral }

/// How a metric should be read: which way is good, and what it is a share of.
class MetricSemantics {
  const MetricSemantics({
    required this.direction,
    this.basisKey,
    this.basisNoun,
  });

  final MetricDirection direction;

  /// Key of the KPI in the same response that supplies this metric's
  /// denominator, when one is derivable. `null` means the response does not
  /// carry it and the tile must not imply a sample size it cannot show.
  final String? basisKey;

  /// What the denominator counts, for display next to the value.
  final String? basisNoun;
}

/// Semantics for the KPI keys `AnalyticsQueryService` emits.
///
/// Rates name the KPI holding their denominator so a percentage is never shown
/// without the count it is drawn from. `match_rate` is deliberately absent a
/// basis: its denominator is completed decisions, which the overview response
/// does not expose. Adding a sample count to `AnalyticsKpi` is the open
/// back-end handoff that would close that gap.
const _semantics = <String, MetricSemantics>{
  'sessions': MetricSemantics(direction: MetricDirection.higherIsBetter),
  'participants': MetricSemantics(direction: MetricDirection.higherIsBetter),
  'completion_rate': MetricSemantics(
    direction: MetricDirection.higherIsBetter,
    basisKey: 'sessions',
    basisNoun: 'sessions',
  ),
  'match_rate': MetricSemantics(direction: MetricDirection.higherIsBetter),
  // Group size is a usage characteristic, not a quality signal: neither
  // direction is an improvement, so the tile stays neutral rather than
  // colouring a shift toward larger rooms as good.
  'participants_per_session': MetricSemantics(
    direction: MetricDirection.neutral,
    basisKey: 'sessions',
    basisNoun: 'sessions',
  ),
  'decision_time': MetricSemantics(direction: MetricDirection.lowerIsBetter),
};

/// Semantics for [key]. Unknown keys read as neutral so a metric added
/// server-side is never given a polarity this dashboard cannot justify.
MetricSemantics metricSemanticsFor(String key) =>
    _semantics[key] ??
    const MetricSemantics(direction: MetricDirection.neutral);

/// Whether a change of [delta] in [key] is an improvement, a regression, or
/// carries no verdict. A delta of zero never has a verdict.
enum MetricVerdict { better, worse, none }

MetricVerdict metricVerdict(String key, double delta) {
  if (delta == 0) return MetricVerdict.none;
  return switch (metricSemanticsFor(key).direction) {
    MetricDirection.higherIsBetter =>
      delta > 0 ? MetricVerdict.better : MetricVerdict.worse,
    MetricDirection.lowerIsBetter =>
      delta < 0 ? MetricVerdict.better : MetricVerdict.worse,
    MetricDirection.neutral => MetricVerdict.none,
  };
}

/// The denominator for [kpi] drawn from [all], or `null` when the response does
/// not carry one.
double? metricBasis(AnalyticsKpi kpi, List<AnalyticsKpi> all) {
  final basisKey = metricSemanticsFor(kpi.key).basisKey;
  if (basisKey == null) return null;
  for (final candidate in all) {
    if (candidate.key == basisKey) return candidate.value;
  }
  return null;
}

/// Smallest cohort the dashboard will report as a share.
///
/// Below this, a percentage invites a conclusion the sample cannot support, so
/// the row is withheld and counted instead. This is a presentation floor: real
/// suppression belongs in the query service, which is a back-end handoff.
const int minimumCohortSamples = 5;

/// Breakdown rows large enough to report, and how many were withheld.
({List<AnalyticsBreakdown> shown, int withheld}) suppressSmallCohorts(
  List<AnalyticsBreakdown> values,
) {
  final shown = <AnalyticsBreakdown>[];
  var withheld = 0;
  for (final value in values) {
    if (value.sampleCount < minimumCohortSamples) {
      withheld++;
    } else {
      shown.add(value);
    }
  }
  return (shown: shown, withheld: withheld);
}
