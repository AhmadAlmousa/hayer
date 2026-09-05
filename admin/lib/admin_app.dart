import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'admin_operations.dart';
import 'l10n/generated/admin_localizations.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key, required this.client, this.operations});
  final Client client;
  final AdminOperations? operations;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Hayer Cache Operations',
    debugShowCheckedModeBanner: false,
    theme: _theme(Brightness.light),
    darkTheme: _theme(Brightness.dark),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: _Dashboard(
      operations: operations ?? ServerpodAdminOperations(client),
    ),
  );

  ThemeData _theme(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0E9594),
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surfaceContainerLowest,
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class _Dashboard extends StatefulWidget {
  const _Dashboard({required this.operations});
  final AdminOperations operations;

  @override
  State<_Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<_Dashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final labels = [
      strings.overview,
      strings.catalog,
      strings.coverage,
      strings.jobs,
      strings.settings,
      strings.calibration,
      strings.audit,
    ];
    final icons = [
      Icons.dashboard_outlined,
      Icons.place_outlined,
      Icons.map_outlined,
      Icons.sync_rounded,
      Icons.tune_rounded,
      Icons.science_outlined,
      Icons.history_rounded,
    ];
    final pages = [
      _OverviewPage(operations: widget.operations),
      _CatalogPage(operations: widget.operations),
      _CoveragePage(operations: widget.operations),
      _JobsPage(operations: widget.operations),
      _PolicyPage(operations: widget.operations),
      _CalibrationPage(operations: widget.operations),
      _AuditPage(operations: widget.operations),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1000;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              strings.appName,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          body: Row(
            children: [
              if (wide)
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: (value) =>
                      setState(() => _index = value),
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (var i = 0; i < labels.length; i++)
                      NavigationRailDestination(
                        icon: Icon(icons[i]),
                        label: Text(labels[i]),
                      ),
                  ],
                ),
              Expanded(child: pages[_index]),
            ],
          ),
          drawer: wide
              ? null
              : NavigationDrawer(
                  selectedIndex: _index,
                  onDestinationSelected: (value) {
                    setState(() => _index = value);
                    Navigator.of(context).pop();
                  },
                  children: [
                    const SizedBox(height: 12),
                    for (var i = 0; i < labels.length; i++)
                      NavigationDrawerDestination(
                        icon: Icon(icons[i]),
                        label: Text(labels[i]),
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _OverviewPage extends StatefulWidget {
  const _OverviewPage({required this.operations});
  final AdminOperations operations;
  @override
  State<_OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<_OverviewPage> {
  late Future<_OverviewData> _overview = _load();

  Future<_OverviewData> _load() async {
    final values = await Future.wait<Object>([
      widget.operations.summary(),
      widget.operations.metricTrend(),
    ]);
    return _OverviewData(
      summary: values[0] as CacheDashboardSummary,
      trend: values[1] as List<MetricPoint>,
    );
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    title: 'Operational overview',
    trailing: IconButton(
      tooltip: 'Refresh overview',
      onPressed: () => setState(() => _overview = _load()),
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: FutureBuilder(
      future: _overview,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _ErrorPanel(snapshot.error!);
        final data = snapshot.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final value = data.summary;
        final cacheTrend = data.trend
            .where((point) => point.metricName == 'cache_hit_rate')
            .toList(growable: false);
        final sourceTrend = data.trend
            .where((point) => point.metricName == 'source_success_rate')
            .toList(growable: false);
        final metrics = <(String, String, IconData)>[
          ('Catalog', '${value.catalogCount}', Icons.place_outlined),
          ('Fresh', '${value.freshCount}', Icons.check_circle_outline),
          ('Stale', '${value.staleCount}', Icons.schedule_rounded),
          ('Quarantined', '${value.quarantinedCount}', Icons.block_outlined),
          ('Coverage', '${value.coverageCount}', Icons.map_outlined),
          ('Pending jobs', '${value.pendingJobs}', Icons.sync_rounded),
          (
            'Cache hit rate',
            '${(value.cacheHitRate * 100).toStringAsFixed(1)}%',
            Icons.bolt_rounded,
          ),
          (
            'Source success',
            '${(value.sourceSuccessRate * 100).toStringAsFixed(1)}%',
            Icons.health_and_safety_outlined,
          ),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 280,
                mainAxisExtent: 150,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
              ),
              itemCount: metrics.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _MetricCard(
                metrics[index].$1,
                metrics[index].$2,
                metrics[index].$3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '24-hour trends',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final cards = [
                  _TrendCard(label: 'Cache hit rate', points: cacheTrend),
                  _TrendCard(label: 'Source success', points: sourceTrend),
                ];
                if (constraints.maxWidth >= 720) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 14),
                      Expanded(child: cards[1]),
                    ],
                  );
                }
                return Column(
                  children: [cards[0], const SizedBox(height: 14), cards[1]],
                );
              },
            ),
          ],
        );
      },
    ),
  );
}

class _CatalogPage extends StatefulWidget {
  const _CatalogPage({required this.operations});
  final AdminOperations operations;
  @override
  State<_CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<_CatalogPage> {
  final _search = TextEditingController();
  CatalogPlacePage? _page;
  Object? _error;
  bool _quarantined = false;
  int _pageIndex = 0;
  MapLibreMapController? _map;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await widget.operations.catalog(
        page: _pageIndex,
        pageSize: 25,
        query: _search.text,
        includeQuarantined: _quarantined,
      );
      if (!mounted) return;
      setState(() {
        _page = value;
        _error = null;
      });
      await _drawPlaces(value.items);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  Future<void> _drawPlaces(List<PlaceSnapshot> places) async {
    final controller = _map;
    if (controller == null) return;
    await controller.clearCircles();
    for (final place in places) {
      await controller.addCircle(
        CircleOptions(
          geometry: LatLng(place.latitude, place.longitude),
          circleColor: '#0E9594',
          circleRadius: 7,
          circleStrokeColor: '#FFFFFF',
          circleStrokeWidth: 2,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    title: 'POI catalog',
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _search,
                onSubmitted: (_) {
                  _pageIndex = 0;
                  _load();
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search name',
                ),
              ),
            ),
            const SizedBox(width: 12),
            FilterChip(
              label: const Text('Include quarantine'),
              selected: _quarantined,
              onSelected: (value) {
                setState(() => _quarantined = value);
                _load();
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 280,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: MapLibreMap(
              styleString: 'https://tiles.openfreemap.org/styles/liberty',
              initialCameraPosition: const CameraPosition(
                target: LatLng(24.7, 46.7),
                zoom: 4.4,
              ),
              onMapCreated: (controller) {
                _map = controller;
                _drawPlaces(_page?.items ?? const []);
              },
              onStyleLoadedCallback: () =>
                  _drawPlaces(_page?.items ?? const []),
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (_error != null)
          _ErrorPanel(_error!)
        else if (_page == null)
          const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          )
        else if (_page!.items.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text('No catalog data has been collected yet.'),
          )
        else
          for (final place in _page!.items)
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(place.name.characters.first.toUpperCase()),
                ),
                title: Text(
                  place.name,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  '${place.primaryType ?? 'Unknown type'} • ${place.latitude.toStringAsFixed(4)}, ${place.longitude.toStringAsFixed(4)}',
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (action) => _placeAction(place, action),
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'quarantine',
                      child: Text('Quarantine'),
                    ),
                    const PopupMenuItem(
                      value: 'restore',
                      child: Text('Restore'),
                    ),
                  ],
                ),
              ),
            ),
        if (_page != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${_pageIndex * 25 + 1}–${(_pageIndex * 25 + _page!.items.length)} of ${_page!.total}',
              ),
              IconButton(
                onPressed: _pageIndex == 0
                    ? null
                    : () {
                        _pageIndex--;
                        _load();
                      },
                icon: const Icon(Icons.chevron_left),
              ),
              IconButton(
                onPressed: (_pageIndex + 1) * 25 >= _page!.total
                    ? null
                    : () {
                        _pageIndex++;
                        _load();
                      },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
      ],
    ),
  );

  Future<void> _placeAction(PlaceSnapshot place, String action) async {
    final reason = await _reasonDialog(
      context,
      '${action == 'restore' ? 'Restore' : 'Quarantine'} ${place.name}',
    );
    if (reason == null) return;
    try {
      if (action == 'restore') {
        await widget.operations.restore(
          providerPlaceId: place.placeId,
          reason: reason,
        );
      } else {
        await widget.operations.quarantine(
          providerPlaceId: place.placeId,
          reason: reason,
        );
      }
      await _load();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }
}

class _CoveragePage extends StatefulWidget {
  const _CoveragePage({required this.operations});

  final AdminOperations operations;

  @override
  State<_CoveragePage> createState() => _CoveragePageState();
}

class _CoveragePageState extends State<_CoveragePage> {
  final _search = TextEditingController();
  CoveragePage? _page;
  CatalogPrunePreview? _prune;
  Object? _error;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final values = await Future.wait<Object>([
        widget.operations.coverage(
          page: _pageIndex,
          pageSize: 25,
          query: _search.text,
        ),
        widget.operations.prunePreview(),
      ]);
      if (!mounted) return;
      setState(() {
        _page = values[0] as CoveragePage;
        _prune = values[1] as CatalogPrunePreview;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    key: const Key('coverage-page'),
    title: 'Coverage',
    trailing: IconButton(
      tooltip: 'Refresh coverage list',
      onPressed: _load,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  _pageIndex = 0;
                  _load();
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  labelText: 'Search key, query, or country',
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: (_prune?.eligibleCount ?? 0) == 0 ? null : _pruneNow,
              icon: const Icon(Icons.delete_sweep_outlined),
              label: Text('Prune ${_prune?.eligibleCount ?? 0} eligible'),
            ),
            if (_prune != null)
              Text(
                'Retention: ${_prune!.retentionDays} days',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        const SizedBox(height: 16),
        if (_error != null)
          _ErrorPanel(_error!)
        else if (_page == null)
          const Center(child: CircularProgressIndicator())
        else if (_page!.items.isEmpty)
          const _EmptyPanel(
            icon: Icons.map_outlined,
            message: 'No coverage records match this search.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _page!.items.length,
            itemBuilder: (context, index) {
              final coverage = _page!.items[index];
              final state = _coverageState(coverage);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${coverage.countryCode} · ${coverage.queryKey}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SelectableText(
                                  coverage.coverageKey,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          _StatusChip(label: state.$1, color: state.$2),
                          PopupMenuButton<String>(
                            tooltip: 'Coverage actions',
                            onSelected: (action) =>
                                _coverageAction(coverage, action),
                            itemBuilder: (context) => const [
                              PopupMenuItem(
                                value: 'refresh',
                                child: Text('Queue refresh'),
                              ),
                              PopupMenuItem(
                                value: 'invalidate',
                                child: Text('Invalidate'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _MetaText(
                            icon: Icons.pin_drop_outlined,
                            value:
                                '${coverage.anchorLatitude.toStringAsFixed(4)}, '
                                '${coverage.anchorLongitude.toStringAsFixed(4)}',
                          ),
                          _MetaText(
                            icon: Icons.radio_button_checked,
                            value: '${coverage.radiusMeters} m',
                          ),
                          _MetaText(
                            icon: Icons.place_outlined,
                            value: '${coverage.resultCount} places',
                          ),
                          _MetaText(
                            icon: Icons.science_outlined,
                            value: coverage.calibrationVersion,
                          ),
                          _MetaText(
                            icon: Icons.schedule_rounded,
                            value:
                                'Expires ${_formatDate(context, coverage.expiresAt)}',
                          ),
                        ],
                      ),
                      if (coverage.lastFailureCode != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Last failure: ${coverage.lastFailureCode}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        if (_page != null)
          _Pager(
            page: _pageIndex,
            pageSize: 25,
            total: _page!.total,
            onPrevious: _pageIndex == 0
                ? null
                : () {
                    _pageIndex--;
                    _load();
                  },
            onNext: (_pageIndex + 1) * 25 >= _page!.total
                ? null
                : () {
                    _pageIndex++;
                    _load();
                  },
          ),
      ],
    ),
  );

  (String, Color) _coverageState(CoverageRecord value) {
    final scheme = Theme.of(context).colorScheme;
    if (value.invalidatedAt != null) return ('Invalidated', scheme.error);
    if (value.lastFailureCode != null) return ('Failed', scheme.error);
    if (value.expiresAt.isBefore(DateTime.now().toUtc())) {
      return ('Stale', scheme.tertiary);
    }
    return ('Fresh', scheme.primary);
  }

  Future<void> _coverageAction(CoverageRecord coverage, String action) async {
    final title = action == 'refresh'
        ? 'Queue refresh for ${coverage.queryKey}'
        : 'Invalidate ${coverage.queryKey}';
    final reason = await _reasonDialog(context, title);
    if (reason == null) return;
    try {
      if (action == 'refresh') {
        await widget.operations.refreshCoverage(
          coverageKey: coverage.coverageKey,
          reason: reason,
        );
      } else {
        await widget.operations.invalidateCoverage(
          coverageKey: coverage.coverageKey,
          reason: reason,
        );
      }
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              action == 'refresh' ? 'Refresh queued' : 'Coverage invalidated',
            ),
          ),
        );
      }
    } catch (error) {
      if (mounted) _showError(context, error);
    }
  }

  Future<void> _pruneNow() async {
    final count = _prune?.eligibleCount ?? 0;
    final reason = await _reasonDialog(
      context,
      'Permanently prune $count unreferenced records',
    );
    if (reason == null) return;
    try {
      final removed = await widget.operations.pruneCatalog(reason: reason);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pruned $removed catalog records')),
        );
      }
    } catch (error) {
      if (mounted) _showError(context, error);
    }
  }
}

class _JobsPage extends StatefulWidget {
  const _JobsPage({required this.operations});

  final AdminOperations operations;

  @override
  State<_JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<_JobsPage> {
  final _search = TextEditingController();
  RefreshJobPage? _page;
  Object? _error;
  JobStatus? _status;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await widget.operations.refreshJobs(
        page: _pageIndex,
        pageSize: 25,
        query: _search.text,
        status: _status,
      );
      if (!mounted) return;
      setState(() {
        _page = value;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    key: const Key('jobs-page'),
    title: 'Refresh jobs',
    trailing: IconButton(
      tooltip: 'Refresh jobs',
      onPressed: _load,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  _pageIndex = 0;
                  _load();
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  labelText: 'Search job, coverage, or operator',
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Status'),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<JobStatus?>(
                    value: _status,
                    isDense: true,
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<JobStatus?>(
                        value: null,
                        child: Text('All statuses'),
                      ),
                      for (final status in JobStatus.values)
                        DropdownMenuItem<JobStatus?>(
                          value: status,
                          child: Text(_jobStatusLabel(status)),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                        _pageIndex = 0;
                      });
                      _load();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_error != null)
          _ErrorPanel(_error!)
        else if (_page == null)
          const Center(child: CircularProgressIndicator())
        else if (_page!.items.isEmpty)
          const _EmptyPanel(
            icon: Icons.sync_rounded,
            message: 'No refresh jobs match these filters.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _page!.items.length,
            itemBuilder: (context, index) {
              final job = _page!.items[index];
              final cancellable =
                  job.status == JobStatus.pending ||
                  job.status == JobStatus.running;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(end: 12),
                            child: Icon(_jobStatusIcon(job.status)),
                          ),
                          Expanded(
                            child: SelectableText(
                              job.jobId,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          _StatusChip(
                            label: _jobStatusLabel(job.status),
                            color: _jobStatusColor(context, job.status),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SelectableText(job.coverageKey),
                      const SizedBox(height: 6),
                      Text('${job.requestedBy} · ${job.reason}'),
                      Text('Created ${_formatDate(context, job.createdAt)}'),
                      if (job.errorCode != null)
                        Text(
                          'Error: ${job.errorCode}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      if (cancellable)
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () => _cancel(job),
                            child: const Text('Cancel'),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        if (_page != null)
          _Pager(
            page: _pageIndex,
            pageSize: 25,
            total: _page!.total,
            onPrevious: _pageIndex == 0
                ? null
                : () {
                    _pageIndex--;
                    _load();
                  },
            onNext: (_pageIndex + 1) * 25 >= _page!.total
                ? null
                : () {
                    _pageIndex++;
                    _load();
                  },
          ),
      ],
    ),
  );

  Future<void> _cancel(RefreshJobView job) async {
    final reason = await _reasonDialog(context, 'Cancel refresh ${job.jobId}');
    if (reason == null) return;
    try {
      await widget.operations.cancelRefreshJob(
        jobId: job.jobId,
        reason: reason,
      );
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Refresh cancelled')));
      }
    } catch (error) {
      if (mounted) _showError(context, error);
    }
  }
}

class _AuditPage extends StatefulWidget {
  const _AuditPage({required this.operations});

  final AdminOperations operations;

  @override
  State<_AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<_AuditPage> {
  final _search = TextEditingController();
  AdminAuditPage? _page;
  Object? _error;
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await widget.operations.auditLog(
        page: _pageIndex,
        pageSize: 25,
        query: _search.text,
      );
      if (!mounted) return;
      setState(() {
        _page = value;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    key: const Key('audit-page'),
    title: 'Audit log',
    trailing: IconButton(
      tooltip: 'Refresh audit log',
      onPressed: _load,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: TextField(
              controller: _search,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) {
                _pageIndex = 0;
                _load();
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                labelText: 'Search operator, action, target, or reason',
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_error != null)
          _ErrorPanel(_error!)
        else if (_page == null)
          const Center(child: CircularProgressIndicator())
        else if (_page!.items.isEmpty)
          const _EmptyPanel(
            icon: Icons.history_rounded,
            message: 'No audit entries match this search.',
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _page!.items.length,
            itemBuilder: (context, index) {
              final entry = _page!.items[index];
              return Card(
                child: ExpansionTile(
                  leading: const Icon(Icons.manage_search_rounded),
                  title: Text(
                    entry.action,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    '${entry.operatorName} · ${entry.targetType}'
                    '${entry.targetId == null ? '' : ' · ${entry.targetId}'}\n'
                    '${_formatDate(context, entry.occurredAt)}',
                  ),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reason: ${entry.reason}'),
                    if (entry.beforeData != null) ...[
                      const SizedBox(height: 8),
                      SelectableText('Before: ${entry.beforeData}'),
                    ],
                    if (entry.afterData != null) ...[
                      const SizedBox(height: 8),
                      SelectableText('After: ${entry.afterData}'),
                    ],
                  ],
                ),
              );
            },
          ),
        if (_page != null)
          _Pager(
            page: _pageIndex,
            pageSize: 25,
            total: _page!.total,
            onPrevious: _pageIndex == 0
                ? null
                : () {
                    _pageIndex--;
                    _load();
                  },
            onNext: (_pageIndex + 1) * 25 >= _page!.total
                ? null
                : () {
                    _pageIndex++;
                    _load();
                  },
          ),
      ],
    ),
  );
}

class _PolicyPage extends StatefulWidget {
  const _PolicyPage({required this.operations});
  final AdminOperations operations;
  @override
  State<_PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<_PolicyPage> {
  CachePolicy? _policy;
  final _controllers = List.generate(7, (_) => TextEditingController());
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final value in _controllers) {
      value.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final value = await widget.operations.policy();
      final values = [
        value.freshHours,
        value.staleFallbackDays,
        value.retentionDays,
        value.extractorAttempts,
        value.perCreationConcurrency,
        value.globalRequestsPerMinute,
        value.globalBurst,
      ];
      for (var index = 0; index < values.length; index++) {
        _controllers[index].text = '${values[index]}';
      }
      setState(() => _policy = value);
    } catch (error) {
      setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Fresh hours',
      'Stale fallback days',
      'Retention days',
      'Extractor attempts',
      'Per-creation concurrency',
      'Global requests/minute',
      'Global burst',
    ];
    return _PageShell(
      title: 'Cache policy',
      child: _policy == null
          ? (_error == null
                ? const Center(child: CircularProgressIndicator())
                : _ErrorPanel(_error!))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    for (var index = 0; index < labels.length; index++)
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: labels[index]),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Save policy'),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _save() async {
    final reason = await _reasonDialog(context, 'Save cache policy');
    if (reason == null) return;
    try {
      final values = _controllers
          .map((value) => int.parse(value.text))
          .toList();
      final now = DateTime.now().toUtc();
      final updated = await widget.operations.updatePolicy(
        reason: reason,
        policy: CachePolicy(
          version: _policy!.version,
          freshHours: values[0],
          staleFallbackDays: values[1],
          retentionDays: values[2],
          extractorAttempts: values[3],
          perCreationConcurrency: values[4],
          globalRequestsPerMinute: values[5],
          globalBurst: values[6],
          updatedAt: now,
        ),
      );
      setState(() => _policy = updated);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }
}

class _CalibrationPage extends StatefulWidget {
  const _CalibrationPage({required this.operations});
  final AdminOperations operations;
  @override
  State<_CalibrationPage> createState() => _CalibrationPageState();
}

class _CalibrationPageState extends State<_CalibrationPage> {
  final _version = TextEditingController();
  final _document = TextEditingController();
  CalibrationValidation? _validation;

  @override
  void dispose() {
    _version.dispose();
    _document.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _PageShell(
    title: 'Calibration',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _version,
          decoration: const InputDecoration(labelText: 'Version'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _document,
          minLines: 14,
          maxLines: 24,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
          decoration: const InputDecoration(
            labelText: 'Calibration JSON',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          children: [
            FilledButton.icon(
              onPressed: _validate,
              icon: const Icon(Icons.fact_check_outlined),
              label: const Text('Validate + live canary'),
            ),
            OutlinedButton.icon(
              onPressed:
                  _validation?.fixturePassed == true &&
                      _validation?.liveCanaryPassed == true
                  ? _activate
                  : null,
              icon: const Icon(Icons.publish_outlined),
              label: const Text('Activate'),
            ),
            OutlinedButton.icon(
              onPressed: _rollback,
              icon: const Icon(Icons.restore_outlined),
              label: const Text('Rollback to version'),
            ),
          ],
        ),
        if (_validation != null)
          Card(
            child: ListTile(
              leading: Icon(
                _validation!.fixturePassed
                    ? Icons.check_circle
                    : Icons.error_outline,
                color: _validation!.fixturePassed
                    ? Colors.green
                    : Theme.of(context).colorScheme.error,
              ),
              title: Text(
                _validation!.fixturePassed && _validation!.liveCanaryPassed
                    ? 'Schema and live canary passed'
                    : 'Validation failed',
              ),
              subtitle: _validation!.errors.isEmpty
                  ? null
                  : Text(_validation!.errors.join('\n')),
            ),
          ),
      ],
    ),
  );

  Future<void> _validate() async {
    try {
      final value = await widget.operations.validateCalibration(
        version: _version.text.trim(),
        documentJson: _document.text,
      );
      setState(() => _validation = value);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _activate() async {
    final reason = await _reasonDialog(
      context,
      'Activate calibration ${_version.text}',
    );
    if (reason == null) return;
    try {
      await widget.operations.activateCalibration(
        version: _version.text.trim(),
        reason: reason,
      );
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Calibration activated')));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }

  Future<void> _rollback() async {
    final version = _version.text.trim();
    final reason = await _reasonDialog(context, 'Rollback to $version');
    if (reason == null) return;
    try {
      await widget.operations.rollbackCalibration(
        version: version,
        reason: reason,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Calibration $version restored')),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }
}

class _PageShell extends StatelessWidget {
  const _PageShell({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });
  final String title;
  final Widget child;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1280),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    ),
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard(this.label, this.value, this.icon);
  final String label;
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const Spacer(),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    ),
  );
}

class _OverviewData {
  const _OverviewData({required this.summary, required this.trend});

  final CacheDashboardSummary summary;
  final List<MetricPoint> trend;
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.label, required this.points});

  final String label;
  final List<MetricPoint> points;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final latest = points.lastOrNull?.metricValue;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  latest == null
                      ? 'No samples'
                      : '${(latest * 100).toStringAsFixed(1)}%',
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 110,
              child: points.isEmpty
                  ? const Center(child: Text('No data in the last 24 hours'))
                  : CustomPaint(
                      painter: _TrendPainter(
                        values: points
                            .map((point) => point.metricValue)
                            .toList(growable: false),
                        color: color,
                      ),
                      child: const SizedBox.expand(),
                    ),
            ),
            if (points.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '${_formatDate(context, points.first.bucketStartedAt)} – '
                '${_formatDate(context, points.last.bucketStartedAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  const _TrendPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = color.withValues(alpha: 0.16)
      ..strokeWidth = 1;
    for (final fraction in const [0.0, 0.5, 1.0]) {
      final y = size.height * fraction;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final stroke = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final fill = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final path = Path();
    final fillPath = Path()..moveTo(0, size.height);
    for (var index = 0; index < values.length; index++) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * index / (values.length - 1);
      final y = size.height * (1 - values[index].clamp(0, 1));
      if (index == 0) {
        path.moveTo(x, y);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(fillPath, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(_TrendPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.color != color;
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontWeight: FontWeight.w800),
    ),
  );
}

class _MetaText extends StatelessWidget {
  const _MetaText({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [Icon(icon, size: 17), const SizedBox(width: 5), Text(value)],
  );
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

class _Pager extends StatelessWidget {
  const _Pager({
    required this.page,
    required this.pageSize,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });

  final int page;
  final int pageSize;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final first = total == 0 ? 0 : page * pageSize + 1;
    final last = (page * pageSize + pageSize).clamp(0, total);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('$first–$last of $total'),
        IconButton(
          tooltip: 'Previous page',
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          tooltip: 'Next page',
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

String _formatDate(BuildContext context, DateTime value) {
  final locale = Localizations.localeOf(context).languageCode;
  return DateFormat.yMd(locale).add_Hm().format(value.toLocal());
}

String _jobStatusLabel(JobStatus status) => switch (status) {
  JobStatus.pending => 'Pending',
  JobStatus.running => 'Running',
  JobStatus.succeeded => 'Succeeded',
  JobStatus.failed => 'Failed',
  JobStatus.cancelled => 'Cancelled',
};

IconData _jobStatusIcon(JobStatus status) => switch (status) {
  JobStatus.pending => Icons.schedule_rounded,
  JobStatus.running => Icons.sync_rounded,
  JobStatus.succeeded => Icons.check_circle_outline,
  JobStatus.failed => Icons.error_outline,
  JobStatus.cancelled => Icons.cancel_outlined,
};

Color _jobStatusColor(BuildContext context, JobStatus status) {
  final scheme = Theme.of(context).colorScheme;
  return switch (status) {
    JobStatus.pending => scheme.tertiary,
    JobStatus.running => scheme.primary,
    JobStatus.succeeded => Colors.green.shade700,
    JobStatus.failed => scheme.error,
    JobStatus.cancelled => scheme.outline,
  };
}

void _showError(BuildContext context, Object error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error')));
}

class _ErrorPanel extends StatelessWidget {
  const _ErrorPanel(this.error);
  final Object error;
  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(padding: const EdgeInsets.all(18), child: Text('$error')),
  );
}

Future<String?> _reasonDialog(BuildContext context, String title) async {
  return showDialog<String>(
    context: context,
    builder: (context) => _ReasonDialog(title: title),
  );
}

class _ReasonDialog extends StatefulWidget {
  const _ReasonDialog({required this.title});

  final String title;

  @override
  State<_ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<_ReasonDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _controller,
      autofocus: true,
      maxLength: 500,
      onChanged: (_) => setState(() {}),
      decoration: const InputDecoration(labelText: 'Required reason'),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: _controller.text.trim().length < 4
            ? null
            : () => Navigator.pop(context, _controller.text.trim()),
        child: const Text('Confirm'),
      ),
    ],
  );
}
