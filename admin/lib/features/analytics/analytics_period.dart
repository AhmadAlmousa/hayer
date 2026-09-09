import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

/// Human description of the window a figure covers, e.g. `1 Sep – 30 Sep 2026`.
///
/// Every number on these pages is scoped by the filter bar, but the filter sat
/// apart from the results, so a reader could not tell what a figure covered.
String describePeriod(AnalyticsFilter filter) {
  final from = filter.from.toLocal();
  final to = filter.to.toLocal();
  final sameYear = from.year == to.year;
  final start = sameYear
      ? DateFormat.MMMd().format(from)
      : DateFormat.yMMMd().format(from);
  return '$start – ${DateFormat.yMMMd().format(to)}';
}

/// Whole days the filter spans, at least one.
int periodDays(AnalyticsFilter filter) {
  final span = filter.to.difference(filter.from).inHours;
  final days = (span / 24).round();
  return days < 1 ? 1 : days;
}

/// What a delta is measured against, e.g. `vs previous 30 days`.
///
/// The tile used to say only "vs previous", leaving the comparison window
/// unstated and the figure open to misreading when the filter changed.
String describeComparison(AnalyticsFilter filter) {
  final days = periodDays(filter);
  return days == 1 ? 'vs previous day' : 'vs previous $days days';
}

/// Bucket size behind each point of a trend.
String describeGranularity(AnalyticsGranularity granularity) =>
    switch (granularity) {
      AnalyticsGranularity.hourly => 'hourly buckets',
      AnalyticsGranularity.daily => 'daily buckets',
      AnalyticsGranularity.weekly => 'weekly buckets',
    };

/// How far behind [generatedAt] the view is, as an operator-facing phrase.
String describeLag(DateTime generatedAt, {DateTime? now}) {
  final elapsed = (now ?? DateTime.now().toUtc()).difference(
    generatedAt.toUtc(),
  );
  final stamp = DateFormat.yMMMd().add_Hm().format(generatedAt.toLocal());
  if (elapsed.inSeconds < 90) return 'Data as of $stamp · just now';
  if (elapsed.inMinutes < 60) {
    return 'Data as of $stamp · ${elapsed.inMinutes} min behind';
  }
  if (elapsed.inHours < 48) {
    return 'Data as of $stamp · ${elapsed.inHours} h behind';
  }
  return 'Data as of $stamp · ${elapsed.inDays} days behind';
}

/// Whether the rollup is far enough behind to warrant an operator's attention.
///
/// Historical analytics roll up every five minutes, so a lag beyond a few
/// rollup intervals means the pipeline, not the dashboard, is the problem.
bool isLagConcerning(DateTime generatedAt, {DateTime? now}) =>
    (now ?? DateTime.now().toUtc()).difference(generatedAt.toUtc()) >
    const Duration(minutes: 20);
