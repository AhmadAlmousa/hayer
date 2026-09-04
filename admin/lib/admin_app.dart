import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'l10n/generated/admin_localizations.dart';

class AdminCredentials {
  const AdminCredentials({required this.operatorName, required this.secret});
  final String operatorName;
  final String secret;
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key, required this.client});
  final Client client;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Hayer Cache Operations',
    debugShowCheckedModeBanner: false,
    theme: _theme(Brightness.light),
    darkTheme: _theme(Brightness.dark),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: _Dashboard(
      client: client,
      credentials: const AdminCredentials(operatorName: 'nginx', secret: ''),
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
  const _Dashboard({required this.client, required this.credentials});
  final Client client;
  final AdminCredentials credentials;

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
      strings.settings,
      strings.calibration,
    ];
    final icons = [
      Icons.dashboard_outlined,
      Icons.place_outlined,
      Icons.tune_rounded,
      Icons.science_outlined,
    ];
    final pages = [
      _OverviewPage(client: widget.client, credentials: widget.credentials),
      _CatalogPage(client: widget.client, credentials: widget.credentials),
      _PolicyPage(client: widget.client, credentials: widget.credentials),
      _CalibrationPage(client: widget.client, credentials: widget.credentials),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 800;
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
          bottomNavigationBar: wide
              ? null
              : NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: (value) =>
                      setState(() => _index = value),
                  destinations: [
                    for (var i = 0; i < labels.length; i++)
                      NavigationDestination(
                        icon: Icon(icons[i]),
                        label: labels[i],
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _OverviewPage extends StatefulWidget {
  const _OverviewPage({required this.client, required this.credentials});
  final Client client;
  final AdminCredentials credentials;
  @override
  State<_OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<_OverviewPage> {
  late Future<CacheDashboardSummary> _summary = _load();
  Future<CacheDashboardSummary> _load() =>
      widget.client.admin.summary(credentials: widget.credentials.secret);

  @override
  Widget build(BuildContext context) => _PageShell(
    title: 'Operational overview',
    trailing: IconButton(
      onPressed: () => setState(() => _summary = _load()),
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: FutureBuilder(
      future: _summary,
      builder: (context, snapshot) {
        if (snapshot.hasError) return _ErrorPanel(snapshot.error!);
        final value = snapshot.data;
        if (value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.count(
          crossAxisCount: MediaQuery.sizeOf(context).width > 1100 ? 4 : 2,
          childAspectRatio: 1.7,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _MetricCard(
              'Catalog',
              '${value.catalogCount}',
              Icons.place_outlined,
            ),
            _MetricCard(
              'Fresh',
              '${value.freshCount}',
              Icons.check_circle_outline,
            ),
            _MetricCard('Stale', '${value.staleCount}', Icons.schedule_rounded),
            _MetricCard(
              'Quarantined',
              '${value.quarantinedCount}',
              Icons.block_outlined,
            ),
            _MetricCard(
              'Coverage',
              '${value.coverageCount}',
              Icons.map_outlined,
            ),
            _MetricCard(
              'Pending jobs',
              '${value.pendingJobs}',
              Icons.sync_rounded,
            ),
            _MetricCard(
              'Cache hit rate',
              '${(value.cacheHitRate * 100).toStringAsFixed(1)}%',
              Icons.bolt_rounded,
            ),
            _MetricCard(
              'Source success',
              '${(value.sourceSuccessRate * 100).toStringAsFixed(1)}%',
              Icons.health_and_safety_outlined,
            ),
          ],
        );
      },
    ),
  );
}

class _CatalogPage extends StatefulWidget {
  const _CatalogPage({required this.client, required this.credentials});
  final Client client;
  final AdminCredentials credentials;
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
      final value = await widget.client.admin.catalog(
        credentials: widget.credentials.secret,
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
        await widget.client.admin.restore(
          credentials: widget.credentials.secret,
          operatorName: widget.credentials.operatorName,
          providerPlaceId: place.placeId,
          reason: reason,
        );
      } else {
        await widget.client.admin.quarantine(
          credentials: widget.credentials.secret,
          operatorName: widget.credentials.operatorName,
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

class _PolicyPage extends StatefulWidget {
  const _PolicyPage({required this.client, required this.credentials});
  final Client client;
  final AdminCredentials credentials;
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
      final value = await widget.client.admin.policy(
        credentials: widget.credentials.secret,
      );
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
      final updated = await widget.client.admin.updatePolicy(
        credentials: widget.credentials.secret,
        operatorName: widget.credentials.operatorName,
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
  const _CalibrationPage({required this.client, required this.credentials});
  final Client client;
  final AdminCredentials credentials;
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
      final value = await widget.client.admin.validateCalibration(
        credentials: widget.credentials.secret,
        operatorName: widget.credentials.operatorName,
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
      await widget.client.admin.activateCalibration(
        credentials: widget.credentials.secret,
        operatorName: widget.credentials.operatorName,
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
      await widget.client.admin.rollbackCalibration(
        credentials: widget.credentials.secret,
        operatorName: widget.credentials.operatorName,
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
  const _PageShell({required this.title, required this.child, this.trailing});
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
  final controller = TextEditingController();
  final value = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        maxLength: 500,
        decoration: const InputDecoration(labelText: 'Required reason'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.trim().length >= 4) {
              Navigator.pop(context, controller.text.trim());
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    ),
  );
  controller.dispose();
  return value;
}
