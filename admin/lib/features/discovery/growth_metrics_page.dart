import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';
import 'discovery_admin_widgets.dart';

enum _GrowthWindow {
  day('24 hours', Duration(hours: 24)),
  week('7 days', Duration(days: 7)),
  month('30 days', Duration(days: 30));

  const _GrowthWindow(this.label, this.span);

  final String label;
  final Duration span;
}

/// A growth response, or no metrics when the server does not report growth
/// yet.
class _GrowthLoad {
  const _GrowthLoad(this.metrics);

  final DiscoveryGrowthMetrics? metrics;
}

/// How the shared place catalog grows and is reused, across Swipe and
/// Discover.
///
/// Places are not split by mode; the work that found or refreshed them is.
class DiscoveryGrowthPage extends StatefulWidget {
  const DiscoveryGrowthPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<DiscoveryGrowthPage> createState() => _DiscoveryGrowthPageState();
}

class _DiscoveryGrowthPageState extends State<DiscoveryGrowthPage> {
  _GrowthWindow _window = _GrowthWindow.week;
  late Future<_GrowthLoad> _future = _load();
  DateTime? _generatedAt;
  String? _period;

  Future<_GrowthLoad> _load() async {
    final to = DateTime.now().toUtc();
    try {
      final value = await widget.operations.discoveryGrowthMetrics(
        from: to.subtract(_window.span),
        to: to,
      );
      if (mounted) {
        setState(() {
          _generatedAt = value.generatedAt;
          _period = '${_day(value.from)} – ${_day(value.to)}';
        });
      }
      return _GrowthLoad(value);
    } catch (error) {
      if (isDiscoveryUnavailable(error)) return const _GrowthLoad(null);
      rethrow;
    }
  }

  void _reload() => setState(() {
    _future = _load();
  });

  @override
  Widget build(BuildContext context) => AdminPageFrame(
    title: 'Catalog growth',
    subtitle: 'How the shared place catalog grows and is reused, by the mode and operation that started the work',
    generatedAt: _generatedAt,
    period: _period,
    trailing: IconButton(
      tooltip: 'Refresh catalog growth',
      onPressed: _reload,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final window in _GrowthWindow.values)
              ChoiceChip(
                label: Text('Last ${window.label}'),
                selected: _window == window,
                onSelected: (_) {
                  _window = window;
                  _reload();
                },
              ),
          ],
        ),
        const SizedBox(height: 18),
        AdminAsyncSection<_GrowthLoad>(
          future: _future,
          builder: (context, load) {
            final metrics = load.metrics;
            return metrics == null
                ? const DiscoveryUnavailableNotice(
                    'This server does not report catalog growth yet. Figures '
                    'appear once growth and reuse are recorded.',
                  )
                : _GrowthBody(metrics);
          },
        ),
      ],
    ),
  );
}

class _GrowthBody extends StatelessWidget {
  const _GrowthBody(this.metrics);

  final DiscoveryGrowthMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final net = metrics.catalogPlacesAtEnd - metrics.catalogPlacesAtStart;
    final sectionStyle = Theme.of(context).textTheme.titleLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Catalog', style: sectionStyle),
        const SizedBox(height: 4),
        const Text(
          'The catalog keeps places for reuse, but retention and quarantine '
          'take some out, so its size can fall while new places arrive.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _GrowthTile(
              key: const Key('growth-catalog'),
              label: 'Catalog places',
              value: formatDiscoveryCount(metrics.catalogPlacesAtEnd),
              detail:
                  'From ${formatDiscoveryCount(metrics.catalogPlacesAtStart)} '
                  'at the start',
              icon: Icons.place_outlined,
            ),
            _GrowthTile(
              key: const Key('growth-net-change'),
              label: 'Net change',
              value: net > 0
                  ? '+${formatDiscoveryCount(net)}'
                  : formatDiscoveryCount(net),
              icon: net < 0
                  ? Icons.trending_down_rounded
                  : Icons.trending_up_rounded,
            ),
            _GrowthTile(
              label: 'New places',
              value: formatDiscoveryCount(metrics.newCatalogPlaces),
              icon: Icons.add_location_alt_outlined,
            ),
            _GrowthTile(
              label: 'Quarantined',
              value: formatDiscoveryCount(metrics.quarantinedPlaces),
              icon: Icons.block_outlined,
            ),
            _GrowthTile(
              label: 'Removed',
              value: formatDiscoveryCount(metrics.removedPlaces),
              icon: Icons.delete_outline_rounded,
            ),
            _GrowthTile(
              label: 'Cells explored',
              value: formatDiscoveryCount(metrics.exploredCells),
              icon: Icons.grid_on_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text('Reuse', style: sectionStyle),
        const SizedBox(height: 4),
        const Text(
          'Cache hits against misses, and the requests that still had to reach '
          'the provider.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _GrowthTile(
              key: const Key('growth-hit-rate'),
              label: 'Cache hit rate',
              value: _hitRate(metrics.cacheHits, metrics.cacheMisses),
              detail:
                  '${formatDiscoveryCount(metrics.cacheHits)} hits, '
                  '${formatDiscoveryCount(metrics.cacheMisses)} misses',
              icon: Icons.cached_rounded,
            ),
            _GrowthTile(
              label: 'Observations',
              value: formatDiscoveryCount(metrics.observations),
              icon: Icons.visibility_outlined,
            ),
            _GrowthTile(
              label: 'Detail refreshes',
              value: formatDiscoveryCount(metrics.detailRefreshes),
              icon: Icons.refresh_rounded,
            ),
            _GrowthTile(
              label: 'Upstream requests',
              value: formatDiscoveryCount(metrics.upstreamRequests),
              icon: Icons.cloud_download_outlined,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _BreakdownCard(metrics.breakdowns),
      ],
    );
  }
}

class _GrowthTile extends StatelessWidget {
  const _GrowthTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.detail,
  });

  final String label;
  final String value;
  final IconData icon;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final detail = this.detail;
    return SizedBox(
      width: 230,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: gridCellHeight(context, 132)),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(height: 10),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(label),
                if (detail != null)
                  Text(
                    detail,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard(this.breakdowns);

  final List<DiscoveryGrowthMetricBreakdown> breakdowns;

  @override
  Widget build(BuildContext context) {
    final rows = [...breakdowns]
      ..sort((left, right) {
        final byMode = left.mode.index.compareTo(right.mode.index);
        return byMode != 0
            ? byMode
            : left.operation.index.compareTo(right.operation.index);
      });
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'By mode and operation',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            const Text(
              'Work counts toward the mode and operation that started it. The '
              'places themselves are shared by both modes.',
            ),
            const SizedBox(height: 12),
            if (rows.isEmpty)
              const Text('No attributed work in this period.')
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Mode')),
                    DataColumn(label: Text('Operation')),
                    DataColumn(label: Text('Observations'), numeric: true),
                    DataColumn(label: Text('New places'), numeric: true),
                    DataColumn(label: Text('Cache hit rate'), numeric: true),
                    DataColumn(label: Text('Detail refreshes'), numeric: true),
                    DataColumn(label: Text('Upstream requests'), numeric: true),
                  ],
                  rows: [
                    for (final row in rows)
                      DataRow(
                        cells: [
                          DataCell(Text(_modeLabel(row.mode))),
                          DataCell(Text(_operationLabel(row.operation))),
                          DataCell(
                            Text(formatDiscoveryCount(row.observations)),
                          ),
                          DataCell(
                            Text(formatDiscoveryCount(row.newCatalogPlaces)),
                          ),
                          DataCell(
                            Text(_hitRate(row.cacheHits, row.cacheMisses)),
                          ),
                          DataCell(
                            Text(formatDiscoveryCount(row.detailRefreshes)),
                          ),
                          DataCell(
                            Text(formatDiscoveryCount(row.upstreamRequests)),
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

/// The hit rate from its own hits and misses, as the contract asks, rather
/// than from a percentage whose denominator the page cannot see.
String _hitRate(int hits, int misses) {
  final lookups = hits + misses;
  if (lookups == 0) return 'No lookups';
  return '${(hits / lookups * 100).toStringAsFixed(1)}%';
}

String _day(DateTime value) => DateFormat.yMMMd().format(value.toLocal());

String _modeLabel(DiscoveryMetricMode mode) => switch (mode) {
  DiscoveryMetricMode.swipe => 'Swipe',
  DiscoveryMetricMode.discovery => 'Discover',
};

String _operationLabel(DiscoveryMetricOperation operation) =>
    switch (operation) {
      DiscoveryMetricOperation.browse => 'Browse',
      DiscoveryMetricOperation.search => 'Search',
      DiscoveryMetricOperation.harvest => 'Harvest',
      DiscoveryMetricOperation.detailRefresh => 'Detail refresh',
    };
