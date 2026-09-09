import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../../admin_operations.dart';
import 'analytics_period.dart';
import 'metric_semantics.dart';

class AnalyticsOverviewPage extends StatefulWidget {
  const AnalyticsOverviewPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<AnalyticsOverviewPage> createState() => _AnalyticsOverviewPageState();
}

class _AnalyticsOverviewPageState extends State<AnalyticsOverviewPage> {
  late AnalyticsFilter _filter = defaultAnalyticsFilter();
  late Future<AdminAnalyticsOverview> _future = _load();
  AdminLiveUsage? _live;
  DateTime? _generatedAt;
  Timer? _liveTimer;
  Timer? _historyTimer;

  @override
  void initState() {
    super.initState();
    _liveTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => unawaited(_refreshLive()),
    );
    _historyTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => _reload(),
    );
  }

  @override
  void dispose() {
    _liveTimer?.cancel();
    _historyTimer?.cancel();
    super.dispose();
  }

  // The frame renders outside the FutureBuilder, so the response's own
  // timestamp is lifted into state to drive the freshness line.
  Future<AdminAnalyticsOverview> _load() async {
    final value = await widget.operations.analyticsOverview(_filter);
    if (mounted) setState(() => _generatedAt = value.generatedAt);
    return value;
  }

  Future<void> _refreshLive() async {
    try {
      final value = await widget.operations.liveUsage();
      if (mounted) setState(() => _live = value);
    } catch (_) {}
  }

  void _reload() => setState(() {
    _live = null;
    _future = _load();
  });

  @override
  Widget build(BuildContext context) => AdminPageFrame(
    title: 'Overview',
    subtitle: 'Anonymous product signals · Asia/Riyadh',
    generatedAt: _generatedAt,
    period: describePeriod(_filter),
    trailing: IconButton(
      tooltip: 'Refresh analytics',
      onPressed: _reload,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnalyticsFilterBar(
          value: _filter,
          onChanged: (value) {
            _filter = value;
            _reload();
          },
        ),
        const SizedBox(height: 18),
        AdminAsyncSection(
          future: _future,
          builder: (context, data) {
            return _OverviewBody(
              data: data,
              live: _live ?? data.live,
              comparison: describeComparison(_filter),
            );
          },
        ),
      ],
    ),
  );
}

class _OverviewBody extends StatelessWidget {
  const _OverviewBody({
    required this.data,
    required this.live,
    required this.comparison,
  });

  final AdminAnalyticsOverview data;
  final AdminLiveUsage live;
  final String comparison;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('Live now', style: _sectionStyle(context)),
      const SizedBox(height: 10),
      _ResponsiveGrid(
        extent: 230,
        height: 126,
        children: [
          MetricTile(
            label: 'Ongoing sessions',
            value: '${live.ongoingSessions}',
            icon: Icons.podcasts_rounded,
            accent: Colors.teal,
          ),
          MetricTile(
            label: 'Solo / multiplayer',
            value: '${live.soloSessions} / ${live.multiplayerSessions}',
            icon: Icons.groups_2_outlined,
          ),
          MetricTile(
            label: 'Participants enrolled',
            value: '${live.enrolledParticipants}',
            icon: Icons.group_add_outlined,
          ),
          MetricTile(
            label: 'Active in last 5 min',
            value: '${live.activeParticipants}',
            icon: Icons.bolt_rounded,
          ),
        ],
      ),
      const SizedBox(height: 24),
      Text('Selected period', style: _sectionStyle(context)),
      const SizedBox(height: 10),
      _ResponsiveGrid(
        extent: 230,
        height: 145,
        children: [
          for (final value in data.kpis)
            KpiTile(value: value, comparison: comparison, siblings: data.kpis),
        ],
      ),
      const SizedBox(height: 24),
      ResponsivePair(
        first: ChartCard(
          title: 'Sessions over time',
          subtitle: 'Tap or hover to inspect a bucket',
          child: AnalyticsLineChart(points: data.sessionTrend),
        ),
        second: ChartCard(
          title: 'Solo vs multiplayer',
          child: BreakdownDonut(values: data.modeBreakdown),
        ),
      ),
      const SizedBox(height: 16),
      BreakdownCard(
        title: 'Participants by session mode',
        values: data.participantModeBreakdown,
      ),
      const SizedBox(height: 16),
      ResponsivePair(
        first: BreakdownCard(
          title: 'Most popular cities',
          values: data.topCities,
        ),
        second: BreakdownCard(
          title: 'Most selected categories',
          values: data.topCategories,
        ),
      ),
      const SizedBox(height: 16),
      ResponsivePair(
        first: BreakdownCard(title: 'Top cuisines', values: data.topCuisines),
        second: BreakdownCard(title: 'Top place types', values: data.topTypes),
      ),
      const SizedBox(height: 16),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Wrap(
            spacing: 26,
            runSpacing: 12,
            children: [
              _SmallFact(
                'Cache hit',
                '${(data.cacheSummary.cacheHitRate * 100).toStringAsFixed(1)}%',
              ),
              _SmallFact(
                'Source success',
                '${(data.cacheSummary.sourceSuccessRate * 100).toStringAsFixed(1)}%',
              ),
              _SmallFact('Fresh POIs', '${data.cacheSummary.freshCount}'),
              _SmallFact(
                'Pending refreshes',
                '${data.cacheSummary.pendingJobs}',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

class UsageAnalyticsPage extends StatefulWidget {
  const UsageAnalyticsPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<UsageAnalyticsPage> createState() => _UsageAnalyticsPageState();
}

class _UsageAnalyticsPageState extends State<UsageAnalyticsPage> {
  late AnalyticsFilter _filter = defaultAnalyticsFilter();
  late Future<AdminUsageAnalytics> _future = _load();
  DateTime? _generatedAt;

  Future<AdminUsageAnalytics> _load() async {
    final value = await widget.operations.usageAnalytics(_filter);
    if (mounted) setState(() => _generatedAt = value.generatedAt);
    return value;
  }

  void _reload() => setState(() => _future = _load());

  @override
  Widget build(BuildContext context) => AdminPageFrame(
    title: 'Usage',
    subtitle:
        'Sessions, participation, completion, setup choices, and peak hours',
    generatedAt: _generatedAt,
    period:
        '${describePeriod(_filter)} · ${describeGranularity(_filter.granularity)}',
    trailing: IconButton(
      tooltip: 'Refresh usage',
      onPressed: _reload,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnalyticsFilterBar(
          value: _filter,
          onChanged: (value) {
            _filter = value;
            _reload();
          },
        ),
        const SizedBox(height: 18),
        AdminAsyncSection(
          future: _future,
          builder: (context, data) {
            return Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: 260,
                    height: 126,
                    child: MetricTile(
                      label: 'Average completed swipe depth',
                      value: data.averageSwipeDepth.toStringAsFixed(1),
                      icon: Icons.swipe_rounded,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ChartCard(
                  title: 'Sessions by mode',
                  child: AnalyticsLineChart(points: data.sessionTrend),
                ),
                const SizedBox(height: 16),
                ResponsivePair(
                  first: ChartCard(
                    title: 'Participants joining',
                    child: AnalyticsLineChart(points: data.participantTrend),
                  ),
                  second: ChartCard(
                    title: 'Decisions completed',
                    child: AnalyticsLineChart(points: data.decisionTrend),
                  ),
                ),
                const SizedBox(height: 16),
                PeakUsageCard(values: data.peakUsage),
                const SizedBox(height: 16),
                ResponsivePair(
                  first: BreakdownCard(
                    title: 'Group size',
                    values: data.groupSizes,
                  ),
                  second: BreakdownCard(
                    title: 'Search radius (metres)',
                    values: data.radiusChoices,
                  ),
                ),
                const SizedBox(height: 16),
                ResponsivePair(
                  first: BreakdownCard(
                    title: 'Deck size',
                    values: data.deckSizeChoices,
                  ),
                  second: BreakdownCard(
                    title: 'Price preference',
                    values: data.priceChoices,
                  ),
                ),
                const SizedBox(height: 16),
                ResponsivePair(
                  first: BreakdownCard(
                    title: 'Visit timing',
                    values: data.visitChoices,
                  ),
                  second: BreakdownCard(
                    title: 'Cache-quality impact',
                    values: data.qualityBreakdown,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class PlaceAnalyticsPage extends StatefulWidget {
  const PlaceAnalyticsPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<PlaceAnalyticsPage> createState() => _PlaceAnalyticsPageState();
}

class _PlaceAnalyticsPageState extends State<PlaceAnalyticsPage> {
  late AnalyticsFilter _filter = defaultAnalyticsFilter();
  PlaceRanking _ranking = PlaceRanking.liked;
  int _minimumSamples = 5;
  late Future<AdminPlaceAnalytics> _future = _load();
  DateTime? _generatedAt;

  Future<AdminPlaceAnalytics> _load() async {
    final value = await widget.operations.placeAnalytics(
      filter: _filter,
      ranking: _ranking,
      minimumSamples: _minimumSamples,
    );
    if (mounted) setState(() => _generatedAt = value.generatedAt);
    return value;
  }

  void _reload() => setState(() => _future = _load());

  @override
  Widget build(BuildContext context) => AdminPageFrame(
    title: 'Places',
    subtitle: 'Vote totals and rates; rankings exclude low-sample places',
    generatedAt: _generatedAt,
    period: '${describePeriod(_filter)} · n ≥ $_minimumSamples votes',
    trailing: IconButton(
      tooltip: 'Refresh place insights',
      onPressed: _reload,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnalyticsFilterBar(
          value: _filter,
          onChanged: (value) {
            _filter = value;
            _reload();
          },
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 220,
              child: DropdownButtonFormField<PlaceRanking>(
                initialValue: _ranking,
                decoration: const InputDecoration(labelText: 'Rank places by'),
                items: const [
                  DropdownMenuItem(
                    value: PlaceRanking.liked,
                    child: Text('Most liked'),
                  ),
                  DropdownMenuItem(
                    value: PlaceRanking.disliked,
                    child: Text('Most disliked'),
                  ),
                  DropdownMenuItem(
                    value: PlaceRanking.approval,
                    child: Text('Highest approval'),
                  ),
                  DropdownMenuItem(
                    value: PlaceRanking.rejection,
                    child: Text('Highest rejection'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  _ranking = value;
                  _reload();
                },
              ),
            ),
            Text('Minimum votes: $_minimumSamples'),
            SizedBox(
              width: 220,
              child: Slider(
                value: _minimumSamples.toDouble(),
                min: 1,
                max: 50,
                divisions: 49,
                label: '$_minimumSamples',
                onChanged: (value) =>
                    setState(() => _minimumSamples = value.round()),
                onChangeEnd: (_) => _reload(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        AdminAsyncSection(
          future: _future,
          builder: (context, data) {
            return Column(
              children: [
                ResponsivePair(
                  first: BreakdownCard(
                    title: 'Top cuisines',
                    values: data.topCuisines,
                  ),
                  second: BreakdownCard(
                    title: 'Top place types',
                    values: data.topTypes,
                  ),
                ),
                const SizedBox(height: 16),
                _PlaceTable(items: data.items),
              ],
            );
          },
        ),
      ],
    ),
  );
}

class AnalyticsFilterBar extends StatefulWidget {
  const AnalyticsFilterBar({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final AnalyticsFilter value;
  final ValueChanged<AnalyticsFilter> onChanged;

  @override
  State<AnalyticsFilterBar> createState() => _AnalyticsFilterBarState();
}

class _AnalyticsFilterBarState extends State<AnalyticsFilterBar> {
  late final _city = TextEditingController(text: widget.value.cityKey ?? '');
  late final _category = TextEditingController(
    text: widget.value.categoryId ?? '',
  );
  int _days = 30;

  @override
  void dispose() {
    _city.dispose();
    _category.dispose();
    super.dispose();
  }

  void _apply({
    int? days,
    AnalyticsGranularity? granularity,
    SessionMode? mode,
    bool clearMode = false,
  }) {
    _days = days ?? _days;
    final now = DateTime.now().toUtc();
    widget.onChanged(
      AnalyticsFilter(
        from: now.subtract(Duration(days: _days)),
        to: now,
        granularity: granularity ?? widget.value.granularity,
        mode: clearMode ? null : mode ?? widget.value.mode,
        cityKey: _blankToNull(_city.text),
        categoryId: _blankToNull(_category.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DropdownButton<int>(
            value: _days,
            items: const [
              DropdownMenuItem(value: 7, child: Text('Last 7 days')),
              DropdownMenuItem(value: 30, child: Text('Last 30 days')),
              DropdownMenuItem(value: 90, child: Text('Last 90 days')),
              DropdownMenuItem(value: 365, child: Text('Last 12 months')),
            ],
            onChanged: (value) => _apply(days: value),
          ),
          SegmentedButton<AnalyticsGranularity>(
            segments: const [
              ButtonSegment(
                value: AnalyticsGranularity.daily,
                label: Text('Daily'),
              ),
              ButtonSegment(
                value: AnalyticsGranularity.weekly,
                label: Text('Weekly'),
              ),
            ],
            selected: {widget.value.granularity},
            onSelectionChanged: (values) => _apply(granularity: values.single),
          ),
          DropdownButton<SessionMode?>(
            value: widget.value.mode,
            hint: const Text('All modes'),
            items: const [
              DropdownMenuItem(value: null, child: Text('All modes')),
              DropdownMenuItem(value: SessionMode.solo, child: Text('Solo')),
              DropdownMenuItem(
                value: SessionMode.multiplayer,
                child: Text('Multiplayer'),
              ),
            ],
            onChanged: (value) => _apply(mode: value, clearMode: value == null),
          ),
          SizedBox(
            width: 160,
            child: TextField(
              controller: _city,
              decoration: const InputDecoration(
                labelText: 'City key',
                isDense: true,
              ),
              onSubmitted: (_) => _apply(),
            ),
          ),
          SizedBox(
            width: 160,
            child: TextField(
              controller: _category,
              decoration: const InputDecoration(
                labelText: 'Category ID',
                isDense: true,
              ),
              onSubmitted: (_) => _apply(),
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: _apply,
            icon: const Icon(Icons.filter_alt_outlined),
            label: const Text('Apply'),
          ),
        ],
      ),
    ),
  );
}

AnalyticsFilter defaultAnalyticsFilter() {
  final now = DateTime.now().toUtc();
  return AnalyticsFilter(
    from: now.subtract(const Duration(days: 30)),
    to: now,
    granularity: AnalyticsGranularity.daily,
  );
}

class AdminPageFrame extends StatelessWidget {
  const AdminPageFrame({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.trailing,
    this.generatedAt,
    this.period,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? trailing;

  /// When the response was produced. Rendered as a measured lag, replacing the
  /// page's former claim that data "refreshes every 5 minutes" — a promise the
  /// page could not verify and that hid a stalled rollup.
  final DateTime? generatedAt;

  /// The window the figures cover, so a reader never has to infer it from the
  /// filter bar.
  final String? period;

  Widget? _freshness(BuildContext context) {
    final stamp = generatedAt;
    if (stamp == null && period == null) return null;
    final scheme = Theme.of(context).colorScheme;
    final concerning = stamp != null && isLagConcerning(stamp);
    final parts = [
      if (period != null) 'Period $period',
      if (stamp != null) describeLag(stamp),
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          if (concerning) ...[
            Icon(Icons.warning_amber_rounded, size: 16, color: scheme.error),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              parts.join(' · '),
              key: const Key('admin-data-freshness'),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: concerning ? scheme.error : scheme.onSurfaceVariant,
                fontWeight: concerning ? FontWeight.w800 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                      ?_freshness(context),
                    ],
                  ),
                ),
                ?trailing,
              ],
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    ),
  );
}

/// Renders [future] without discarding what is already on screen.
///
/// Each page previously swapped its whole body for a spinner on every filter
/// change, so an operator lost the figures they were comparing against, and a
/// failed reload replaced good data with an error panel. A reload now keeps the
/// last successful response visible and marks it as refreshing or stale.
class AdminAsyncSection<T> extends StatefulWidget {
  const AdminAsyncSection({
    super.key,
    required this.future,
    required this.builder,
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T value) builder;

  @override
  State<AdminAsyncSection<T>> createState() => _AdminAsyncSectionState<T>();
}

class _AdminAsyncSectionState<T> extends State<AdminAsyncSection<T>> {
  T? _value;
  Object? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _watch();
  }

  @override
  void didUpdateWidget(covariant AdminAsyncSection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.future, widget.future)) _watch();
  }

  void _watch() {
    final future = widget.future;
    _loading = true;
    _error = null;
    future.then(
      (value) {
        // A response for a filter the operator has already moved on from must
        // not overwrite the current one.
        if (!mounted || !identical(future, widget.future)) return;
        setState(() {
          _value = value;
          _error = null;
          _loading = false;
        });
      },
      onError: (Object error) {
        if (!mounted || !identical(future, widget.future)) return;
        setState(() {
          _error = error;
          _loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = _value;
    final error = _error;
    if (value == null) {
      if (error != null) return AdminErrorPanel(error);
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_loading)
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: LinearProgressIndicator(
              key: Key('admin-section-refreshing'),
              minHeight: 2,
            ),
          ),
        if (error != null) ...[
          AdminStaleBanner(error),
          const SizedBox(height: 8),
        ],
        widget.builder(context, value),
      ],
    );
  }
}

/// Says that what is on screen is the last good response, not the current one.
class AdminStaleBanner extends StatelessWidget {
  const AdminStaleBanner(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      key: const Key('admin-stale-banner'),
      color: colors.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: colors.onErrorContainer),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Showing the last successful load. Refresh failed: $error',
                style: TextStyle(color: colors.onErrorContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminErrorPanel extends StatelessWidget {
  const AdminErrorPanel(this.error, {super.key});

  final Object error;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Text('Could not load this view: $error'),
    ),
  );
}

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? accent;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent ?? Theme.of(context).colorScheme.primary),
          const Spacer(),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    ),
  );
}

class KpiTile extends StatelessWidget {
  const KpiTile({
    super.key,
    required this.value,
    required this.comparison,
    this.siblings = const [],
  });

  final AnalyticsKpi value;

  /// What the delta is measured against, e.g. `vs previous 30 days`.
  final String comparison;

  /// The other KPIs in the same response, used to resolve a rate's denominator.
  final List<AnalyticsKpi> siblings;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final delta = value.value - value.previousValue;
    final rising = delta > 0;
    final verdict = metricVerdict(value.key, delta);
    // Direction and verdict are separate: an arrow says which way the metric
    // moved, colour says whether that is good. Reading every rise as good is
    // what made a slower average decision time look like an improvement.
    final deltaColor = switch (verdict) {
      MetricVerdict.better => colors.tertiary,
      MetricVerdict.worse => colors.error,
      MetricVerdict.none => colors.onSurfaceVariant,
    };
    final verdictWord = switch (verdict) {
      MetricVerdict.better => 'better',
      MetricVerdict.worse => 'worse',
      MetricVerdict.none => 'no change in direction',
    };
    final basis = metricBasis(value, siblings);
    final basisNoun = metricSemanticsFor(value.key).basisNoun;
    final change = delta == 0
        ? 'No change $comparison'
        : '${rising ? 'Up' : 'Down'} '
              '${_formatKpi(delta.abs(), value.unit)} $comparison';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Semantics(
          label:
              '${value.label}: ${_formatKpi(value.value, value.unit)}. '
              '$change, $verdictWord.'
              '${basis == null ? '' : ' Based on ${basis.round()} $basisNoun.'}',
          excludeSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value.label, maxLines: 1, overflow: TextOverflow.ellipsis),
              const Spacer(),
              Text(
                _formatKpi(value.value, value.unit),
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              if (basis != null)
                Text(
                  'n = ${basis.round()} $basisNoun',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(
                    delta == 0
                        ? Icons.remove_rounded
                        : rising
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 15,
                    color: deltaColor,
                  ),
                  Expanded(
                    child: Text(
                      ' $change',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: deltaColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          if (subtitle != null)
            Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 14),
          SizedBox(height: 260, child: child),
        ],
      ),
    ),
  );
}

class AnalyticsLineChart extends StatelessWidget {
  const AnalyticsLineChart({super.key, required this.points});

  final List<AnalyticsPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const Center(child: Text('No data in this period'));
    }
    final buckets =
        points.map((point) => point.bucketStartedAt).toSet().toList()..sort();
    final series = points.map((point) => point.seriesKey).toSet().toList()
      ..sort();
    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.tertiary,
      Colors.orange,
      Colors.indigo,
    ];
    return LineChart(
      LineChartData(
        minY: 0,
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (spots) => [
              for (final spot in spots)
                LineTooltipItem(
                  '${series[spot.barIndex]}\n${spot.y.toStringAsFixed(0)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ],
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 36),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: max(1, (buckets.length / 5).ceil()).toDouble(),
              getTitlesWidget: (value, meta) {
                final index = value.round();
                if (index < 0 || index >= buckets.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat.MMMd().format(buckets[index].toLocal()),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          for (var s = 0; s < series.length; s++)
            LineChartBarData(
              color: colors[s % colors.length],
              barWidth: 3,
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: s == 0,
                color: colors[s % colors.length].withValues(alpha: .09),
              ),
              spots: [
                for (var i = 0; i < buckets.length; i++)
                  FlSpot(
                    i.toDouble(),
                    points
                        .where(
                          (point) =>
                              point.seriesKey == series[s] &&
                              point.bucketStartedAt == buckets[i],
                        )
                        .fold(0, (sum, point) => sum + point.value),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class BreakdownDonut extends StatelessWidget {
  const BreakdownDonut({super.key, required this.values});

  final List<AnalyticsBreakdown> values;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const Center(child: Text('No data in this period'));
    }
    final scheme = Theme.of(context).colorScheme;
    final (shown: shown, withheld: withheld) = suppressSmallCohorts(values);
    if (shown.isEmpty) {
      return Center(
        child: Text(
          '$withheld cohorts withheld (n < $minimumCohortSamples)',
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
      );
    }
    // Enough distinct fills that a slice and its legend entry stay paired; the
    // previous three cycled, so a fourth slice reused the first colour.
    final fills = [
      scheme.primary,
      scheme.tertiary,
      scheme.secondary,
      scheme.primaryContainer,
      scheme.tertiaryContainer,
      scheme.secondaryContainer,
    ];
    final labels = [
      scheme.onPrimary,
      scheme.onTertiary,
      scheme.onSecondary,
      scheme.onPrimaryContainer,
      scheme.onTertiaryContainer,
      scheme.onSecondaryContainer,
    ];
    return Row(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 48,
              sectionsSpace: 3,
              sections: [
                for (var i = 0; i < shown.length; i++)
                  PieChartSectionData(
                    value: shown[i].value,
                    color: fills[i % fills.length],
                    radius: 45,
                    title: '${shown[i].percentage.toStringAsFixed(0)}%',
                    titleStyle: TextStyle(
                      // Paired with its fill so the label keeps contrast in
                      // both themes rather than assuming white on every slice.
                      color: labels[i % labels.length],
                      fontWeight: FontWeight.w800,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < shown.length; i++)
                _Legend(
                  color: fills[i % fills.length],
                  label:
                      '${shown[i].label} · ${shown[i].value.round()} '
                      '(n = ${shown[i].sampleCount})',
                ),
              if (withheld > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '$withheld withheld (n < $minimumCohortSamples)',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class BreakdownCard extends StatelessWidget {
  const BreakdownCard({super.key, required this.title, required this.values});

  final String title;
  final List<AnalyticsBreakdown> values;

  static const _visibleRows = 8;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (shown: reportable, withheld: withheld) = suppressSmallCohorts(
      values,
    );
    final truncated = reportable.length > _visibleRows
        ? reportable.length - _visibleRows
        : 0;
    // Anything the card is not showing is stated, so a truncated or suppressed
    // list never reads as the whole picture.
    final notes = [
      if (truncated > 0) '$truncated more not shown',
      if (withheld > 0) '$withheld withheld (n < $minimumCohortSamples)',
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 14),
            if (values.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 26),
                child: Center(child: Text('No data in this period')),
              )
            else ...[
              for (final value in reportable.take(_visibleRows)) ...[
                Tooltip(
                  message:
                      '${value.value.toStringAsFixed(0)} selections · '
                      '${value.percentage.toStringAsFixed(1)}% of '
                      '${value.sampleCount} samples',
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        value.value.toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      // A share is unreadable without the count behind it:
                      // 50% of four is not 50% of four thousand.
                      Text(
                        '  n = ${value.sampleCount}',
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: (value.percentage / 100).clamp(0, 1),
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 10),
              ],
              if (notes.isNotEmpty)
                Text(
                  notes.join(' · '),
                  key: const Key('breakdown-footnote'),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class PeakUsageCard extends StatelessWidget {
  const PeakUsageCard({super.key, required this.values});

  final List<AnalyticsHeatCell> values;

  @override
  Widget build(BuildContext context) {
    final maximum = values.fold<double>(
      0,
      (value, item) => max(value, item.value),
    );
    final byKey = {
      for (final value in values) '${value.weekday}:${value.hour}': value.value,
    };
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Peak usage heatmap',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            const Text('Asia/Riyadh; Sunday–Saturday reporting weeks'),
            const SizedBox(height: 14),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 42),
                      for (var hour = 0; hour < 24; hour++)
                        SizedBox(
                          width: 24,
                          child: Text(
                            hour % 3 == 0 ? '$hour' : '',
                            style: const TextStyle(fontSize: 9),
                          ),
                        ),
                    ],
                  ),
                  for (var day = 1; day <= 7; day++)
                    Row(
                      children: [
                        SizedBox(
                          width: 42,
                          child: Text(
                            days[day - 1],
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                        for (var hour = 0; hour < 24; hour++)
                          Tooltip(
                            message:
                                '${days[day - 1]} ${hour.toString().padLeft(2, '0')}:00 · ${(byKey['$day:$hour'] ?? 0).round()} sessions',
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context).colorScheme.primary
                                    .withValues(
                                      alpha: maximum == 0
                                          ? .04
                                          : .08 +
                                                .82 *
                                                    (byKey['$day:$hour'] ?? 0) /
                                                    maximum,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceTable extends StatelessWidget {
  const _PlaceTable({required this.items});

  final List<PlaceInsight> items;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Place ranking',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Text('No places meet the minimum sample threshold.'),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('#')),
                  DataColumn(label: Text('Place')),
                  DataColumn(label: Text('Likes'), numeric: true),
                  DataColumn(label: Text('Dislikes'), numeric: true),
                  DataColumn(label: Text('Approval'), numeric: true),
                  DataColumn(label: Text('Deck inclusions'), numeric: true),
                  DataColumn(label: Text('Card impressions'), numeric: true),
                ],
                rows: [
                  for (var i = 0; i < items.length; i++)
                    DataRow(
                      cells: [
                        DataCell(Text('${i + 1}')),
                        DataCell(
                          SizedBox(
                            width: 280,
                            child: Text(
                              items[i].name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(Text('${items[i].likes}')),
                        DataCell(Text('${items[i].dislikes}')),
                        DataCell(
                          Text('${items[i].approvalRate.toStringAsFixed(1)}%'),
                        ),
                        DataCell(Text('${items[i].deckAppearances}')),
                        DataCell(Text('${items[i].cardImpressions}')),
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

class ResponsivePair extends StatelessWidget {
  const ResponsivePair({super.key, required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => constraints.maxWidth >= 780
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: first),
              const SizedBox(width: 16),
              Expanded(child: second),
            ],
          )
        : Column(children: [first, const SizedBox(height: 16), second]),
  );
}

/// How far the viewer has scaled text, as a plain multiplier.
double gridTextScale(BuildContext context) =>
    MediaQuery.textScalerOf(context).scale(14) / 14;

/// Height for a grid cell whose design height is [designHeight] at 100% text.
///
/// These grids set a fixed `mainAxisExtent`, so a tile that grows past it
/// overflows instead of scrolling: at 200% text a KPI tile overran its cell by
/// 130 pixels. Cell text scales linearly while the card's padding does not, so
/// scaling the whole cell leaves headroom that grows with the scale factor —
/// the padding is paid once at any size. The extra constant absorbs rounding
/// and the fixed gaps between rows within a tile.
double gridCellHeight(BuildContext context, double designHeight) {
  final scale = gridTextScale(context);
  if (scale <= 1) return designHeight;
  return designHeight * scale + 12;
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({
    required this.children,
    required this.extent,
    required this.height,
  });

  final List<Widget> children;
  final double extent;
  final double height;

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: extent * gridTextScale(context),
      mainAxisExtent: gridCellHeight(context, height),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemCount: children.length,
    itemBuilder: (context, index) => children[index],
  );
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 7),
        Expanded(child: Text(label)),
      ],
    ),
  );
}

class _SmallFact extends StatelessWidget {
  const _SmallFact(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: Theme.of(context).textTheme.titleLarge
            ?.copyWith(fontWeight: FontWeight.w900),
      ),
      Text(label),
    ],
  );
}

TextStyle? _sectionStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge
        ?.copyWith(fontWeight: FontWeight.w900);

String? _blankToNull(String value) =>
    value.trim().isEmpty ? null : value.trim();

String _formatKpi(double value, String unit) => switch (unit) {
  'percent' => '${value.toStringAsFixed(1)}%',
  'seconds' =>
    value >= 60
        ? '${(value / 60).toStringAsFixed(1)} min'
        : '${value.toStringAsFixed(0)} sec',
  'average' => value.toStringAsFixed(1),
  _ => NumberFormat.compact().format(value),
};
