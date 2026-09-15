import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../admin_operations.dart';
import 'catalog_labels.dart';
import 'catalog_map.dart';
import 'catalog_place_panel.dart';

/// The admin POI catalog: a map of places or their density, a filtered and
/// ordered list that can follow the map, and an info card holding
/// everything the catalog caches about the selected place.
class CatalogPage extends StatefulWidget {
  const CatalogPage({
    super.key,
    required this.operations,
    this.query = '',
    this.mapBuilder = defaultCatalogMapBuilder,
    this.now,
  });

  final AdminOperations operations;

  /// Search this page opens on, supplied by whatever linked here.
  final String query;

  /// Builds the map; tests replace MapLibre with a stand-in.
  final CatalogMapBuilder mapBuilder;

  /// The clock for ages and first-cached windows; tests pin it.
  final DateTime Function()? now;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  static const _pageSize = 25;
  static const _wideWidth = 1100.0;
  static const _ratingOptions = <double?>[null, 3, 3.5, 4, 4.5];
  static const _reviewOptions = <int?>[null, 10, 50, 100, 500, 1000];
  static const _firstCachedOptions = <int?>[null, 1, 7, 30];

  final _search = TextEditingController();
  final _category = TextEditingController();

  AdminCatalogSort _sort = AdminCatalogSort.lastSeen;
  bool _descending = true;
  AdminCatalogStatus _status = AdminCatalogStatus.active;
  AdminCatalogFreshness _freshness = AdminCatalogFreshness.any;
  AdminCatalogLifecycle? _lifecycle;
  String? _primaryType;
  double? _minimumRating;
  int? _minimumReviews;
  int? _firstCachedDays;
  final _prices = <int>{};
  final _missing = <AdminCatalogField>{};
  bool _openReports = false;

  bool _limitToMap = false;
  CatalogMapMode _mode = CatalogMapMode.points;
  DiscoverViewport? _viewport;
  bool _viewportTooWide = false;

  AdminCatalogPage? _page;
  Object? _error;
  int _pageIndex = 0;
  int _listGeneration = 0;

  AdminCatalogHeatmap? _heat;
  Object? _heatError;
  int _heatGeneration = 0;

  int? _selectedId;
  CatalogMapFocus? _focus;
  int _focusToken = 0;
  bool _wide = true;

  DateTime get _now => (widget.now ?? DateTime.now)().toUtc();

  @override
  void initState() {
    super.initState();
    _search.text = widget.query;
    unawaited(_load());
  }

  // A second link to this page rebuilds the same state object, so a newly
  // carried search has to be applied here as well as in initState.
  @override
  void didUpdateWidget(covariant CatalogPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query == widget.query) return;
    _search.text = widget.query;
    _restart();
  }

  @override
  void dispose() {
    _search.dispose();
    _category.dispose();
    super.dispose();
  }

  /// The list's query, or with [map] the heat map's, which always takes the
  /// visible bounds.
  AdminCatalogQuery _query({required bool map}) {
    final search = _search.text.trim();
    final category = _category.text.trim();
    final days = _firstCachedDays;
    return AdminCatalogQuery(
      viewport: map || _limitToMap ? _viewport : null,
      search: search.isEmpty ? null : search,
      sort: _sort,
      descending: _descending,
      status: _status,
      freshness: _freshness,
      lifecycle: _lifecycle,
      primaryType: _primaryType,
      categoryId: category.isEmpty ? null : category,
      minimumRating: _minimumRating,
      minimumReviews: _minimumReviews,
      priceLevels: _prices.isEmpty ? null : (_prices.toList()..sort()),
      missing: _missing.isEmpty
          ? null
          : AdminCatalogField.values.where(_missing.contains).toList(),
      withOpenReports: _openReports,
      firstSeenAfter: days == null ? null : _now.subtract(Duration(days: days)),
    );
  }

  Future<void> _load() async {
    final generation = ++_listGeneration;
    try {
      final page = await widget.operations.catalogPlaces(
        query: _query(map: false),
        page: _pageIndex,
        pageSize: _pageSize,
      );
      if (!mounted || generation != _listGeneration) return;
      setState(() {
        _page = page;
        _error = null;
      });
    } catch (error) {
      if (mounted && generation == _listGeneration) {
        setState(() => _error = error);
      }
    }
  }

  Future<void> _loadHeat() async {
    if (_mode != CatalogMapMode.heat || _viewport == null) return;
    final generation = ++_heatGeneration;
    try {
      final heat = await widget.operations.catalogHeatmap(_query(map: true));
      if (!mounted || generation != _heatGeneration) return;
      setState(() {
        _heat = heat;
        _heatError = null;
      });
    } catch (error) {
      if (mounted && generation == _heatGeneration) {
        setState(() => _heatError = error);
      }
    }
  }

  /// Applies a change to the filters or order, then loads from page one.
  void _update(VoidCallback change) {
    setState(change);
    _restart();
  }

  void _restart() {
    _pageIndex = 0;
    unawaited(_load());
    unawaited(_loadHeat());
  }

  /// Reloads the current page and heat map after a place changed.
  void _reload() {
    unawaited(_load());
    unawaited(_loadHeat());
  }

  void _viewportChanged(DiscoverViewport viewport) {
    final tooWide =
        viewport.north - viewport.south > catalogMaximumSpanDegrees ||
        viewport.east - viewport.west > catalogMaximumSpanDegrees;
    setState(() {
      _viewportTooWide = tooWide;
      _viewport = tooWide ? null : viewport;
      if (tooWide) _heat = null;
    });
    if (_limitToMap) {
      _pageIndex = 0;
      unawaited(_load());
    }
    unawaited(_loadHeat());
  }

  void _setMode(CatalogMapMode mode) {
    setState(() => _mode = mode);
    unawaited(_loadHeat());
  }

  void _showOnMap(AdminCatalogPlace place) => setState(
    () => _focus = (
      token: ++_focusToken,
      latitude: place.latitude,
      longitude: place.longitude,
    ),
  );

  /// Opens the info card for [catalogId]: beside the list on wide screens,
  /// in a dialog otherwise.
  void _select(int catalogId, {AdminCatalogPlace? showOnMap}) {
    setState(() => _selectedId = catalogId);
    if (showOnMap != null) _showOnMap(showOnMap);
    if (_wide) return;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720, maxHeight: 860),
            child: CatalogPlacePanel(
              operations: widget.operations,
              catalogId: catalogId,
              now: _now,
              onChanged: _reload,
              onShowOnMap: (place) {
                Navigator.of(dialogContext).pop();
                _showOnMap(place);
              },
              onClose: () => Navigator.of(dialogContext).pop(),
            ),
          ),
        ),
      ),
    );
  }

  int get _activeFilterCount => [
    _freshness != AdminCatalogFreshness.any,
    _lifecycle != null,
    _primaryType != null,
    _category.text.trim().isNotEmpty,
    _minimumRating != null,
    _minimumReviews != null,
    _firstCachedDays != null,
    _prices.isNotEmpty,
    _missing.isNotEmpty,
    _openReports,
  ].where((active) => active).length;

  void _clearFilters() => _update(() {
    _freshness = AdminCatalogFreshness.any;
    _lifecycle = null;
    _primaryType = null;
    _category.clear();
    _minimumRating = null;
    _minimumReviews = null;
    _firstCachedDays = null;
    _prices.clear();
    _missing.clear();
    _openReports = false;
  });

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      _wide = constraints.maxWidth >= _wideWidth;
      final browser = ListView(
        key: const Key('catalog-browser'),
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'POI catalog',
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          _controls(context),
          const SizedBox(height: 14),
          _mapSection(context),
          const SizedBox(height: 14),
          ..._results(context),
        ],
      );
      if (!_wide) return browser;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: browser),
          const VerticalDivider(width: 1),
          SizedBox(width: 460, child: _detailPanel(context)),
        ],
      );
    },
  );

  Widget _controls(BuildContext context) {
    final types = {
      for (final type in _page?.types ?? const <AdminCatalogTypeCount>[])
        type.primaryType: type.count,
    };
    final activeFilters = _activeFilterCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 340,
              child: TextField(
                key: const Key('catalog-search'),
                controller: _search,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _restart(),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  labelText: 'Search name, place id or catalog id',
                ),
              ),
            ),
            _dropdown<AdminCatalogSort>(
              key: const Key('catalog-sort'),
              label: 'Sort by',
              value: _sort,
              values: AdminCatalogSort.values,
              describe: catalogSortLabel,
              onChanged: (value) => _update(() => _sort = value),
            ),
            IconButton(
              key: const Key('catalog-sort-direction'),
              tooltip: _descending ? 'Descending' : 'Ascending',
              onPressed: () => _update(() => _descending = !_descending),
              icon: Icon(
                _descending
                    ? Icons.arrow_downward_rounded
                    : Icons.arrow_upward_rounded,
              ),
            ),
            SegmentedButton<AdminCatalogStatus>(
              key: const Key('catalog-status'),
              segments: [
                for (final status in AdminCatalogStatus.values)
                  ButtonSegment(
                    value: status,
                    label: Text(catalogStatusLabel(status)),
                  ),
              ],
              selected: {_status},
              onSelectionChanged: (value) =>
                  _update(() => _status = value.single),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ExpansionTile(
          key: const Key('catalog-more-filters'),
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 12),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          title: Text(
            activeFilters == 0
                ? 'More filters'
                : 'More filters ($activeFilters active)',
          ),
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _dropdown<AdminCatalogFreshness>(
                  key: const Key('catalog-freshness'),
                  label: 'Cache age',
                  value: _freshness,
                  values: AdminCatalogFreshness.values,
                  describe: catalogFreshnessLabel,
                  onChanged: (value) => _update(() => _freshness = value),
                ),
                _dropdown<AdminCatalogLifecycle?>(
                  key: const Key('catalog-lifecycle'),
                  label: 'Closure',
                  value: _lifecycle,
                  values: [null, ...AdminCatalogLifecycle.values],
                  describe: catalogLifecycleLabel,
                  onChanged: (value) => _update(() => _lifecycle = value),
                ),
                _dropdown<String?>(
                  key: const Key('catalog-type'),
                  label: 'Primary type',
                  width: 260,
                  value: _primaryType,
                  values: [
                    null,
                    ...types.keys,
                    if (_primaryType != null &&
                        !types.containsKey(_primaryType))
                      _primaryType,
                  ],
                  describe: (type) => type == null
                      ? 'All types'
                      : types[type] == null
                      ? type
                      : '$type (${types[type]})',
                  onChanged: (value) => _update(() => _primaryType = value),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    key: const Key('catalog-category'),
                    controller: _category,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => _update(() {}),
                    decoration: const InputDecoration(labelText: 'Category id'),
                  ),
                ),
                _dropdown<double?>(
                  key: const Key('catalog-rating'),
                  label: 'Rating',
                  value: _minimumRating,
                  values: _ratingOptions,
                  describe: (value) => value == null
                      ? 'Any rating'
                      : '${value.toStringAsFixed(1)}+',
                  onChanged: (value) => _update(() => _minimumRating = value),
                ),
                _dropdown<int?>(
                  key: const Key('catalog-reviews'),
                  label: 'Reviews',
                  value: _minimumReviews,
                  values: _reviewOptions,
                  describe: (value) =>
                      value == null ? 'Any reviews' : '$value+ reviews',
                  onChanged: (value) => _update(() => _minimumReviews = value),
                ),
                _dropdown<int?>(
                  key: const Key('catalog-first-cached'),
                  label: 'First cached',
                  value: _firstCachedDays,
                  values: _firstCachedOptions,
                  describe: (days) => switch (days) {
                    null => 'Any time',
                    1 => 'Last 24 hours',
                    _ => 'Last $days days',
                  },
                  onChanged: (value) => _update(() => _firstCachedDays = value),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var level = 1; level <= 4; level++)
                  FilterChip(
                    key: Key('catalog-price-$level'),
                    label: Text(catalogPriceLabel(level)),
                    selected: _prices.contains(level),
                    onSelected: (selected) => _update(
                      () =>
                          selected ? _prices.add(level) : _prices.remove(level),
                    ),
                  ),
                for (final field in AdminCatalogField.values)
                  FilterChip(
                    key: Key('catalog-missing-${field.name}'),
                    label: Text('Missing ${catalogFieldLabel(field)}'),
                    selected: _missing.contains(field),
                    onSelected: (selected) => _update(
                      () => selected
                          ? _missing.add(field)
                          : _missing.remove(field),
                    ),
                  ),
                FilterChip(
                  key: const Key('catalog-open-reports'),
                  avatar: const Icon(Icons.outlined_flag_rounded, size: 18),
                  label: const Text('With open reports'),
                  selected: _openReports,
                  onSelected: (selected) =>
                      _update(() => _openReports = selected),
                ),
              ],
            ),
            if (activeFilters > 0)
              TextButton.icon(
                key: const Key('catalog-clear-filters'),
                onPressed: _clearFilters,
                icon: const Icon(Icons.filter_alt_off_outlined),
                label: const Text('Clear filters'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _dropdown<T>({
    required Key key,
    required String label,
    required T value,
    required List<T> values,
    required String Function(T value) describe,
    required ValueChanged<T> onChanged,
    double width = 210,
  }) => SizedBox(
    width: width,
    child: InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          key: key,
          value: value,
          isDense: true,
          isExpanded: true,
          items: [
            for (final item in values)
              DropdownMenuItem<T>(
                value: item,
                child: Text(describe(item), overflow: TextOverflow.ellipsis),
              ),
          ],
          onChanged: (selected) {
            if (selected is T) onChanged(selected);
          },
        ),
      ),
    ),
  );

  String? get _mapNote {
    if (_viewportTooWide) {
      return 'Zoom in: this view is too wide to limit the list or draw the '
          'heat map.';
    }
    if (_mode == CatalogMapMode.heat) {
      if (_heatError != null) return 'The heat map could not load: $_heatError';
      if (_viewport == null) return 'Move the map to draw the heat map.';
      final heat = _heat;
      if (heat != null) {
        return '${heat.total} matching places in view; the busiest area '
            'holds ${heat.maximumCount}.';
      }
    }
    if (_limitToMap && _viewport == null) {
      return 'The list covers the whole catalog until the map reports its '
          'view.';
    }
    return null;
  }

  Widget _mapSection(BuildContext context) {
    final note = _mapNote;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SegmentedButton<CatalogMapMode>(
              key: const Key('catalog-map-mode'),
              segments: const [
                ButtonSegment(
                  value: CatalogMapMode.points,
                  icon: Icon(Icons.place_outlined),
                  label: Text('Places'),
                ),
                ButtonSegment(
                  value: CatalogMapMode.heat,
                  icon: Icon(Icons.local_fire_department_outlined),
                  label: Text('Heat map'),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (value) => _setMode(value.single),
            ),
            FilterChip(
              key: const Key('catalog-limit-to-map'),
              avatar: const Icon(Icons.crop_free_rounded, size: 18),
              label: const Text('Limit list to map view'),
              selected: _limitToMap,
              onSelected: (selected) {
                setState(() => _limitToMap = selected);
                _pageIndex = 0;
                unawaited(_load());
              },
            ),
          ],
        ),
        if (note != null) ...[
          const SizedBox(height: 8),
          Text(
            note,
            key: const Key('catalog-map-note'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        const SizedBox(height: 10),
        SizedBox(
          height: 420,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: widget.mapBuilder(
              CatalogMapData(
                mode: _mode,
                places: _page?.items ?? const [],
                heatmap: _mode == CatalogMapMode.heat ? _heat : null,
                selectedCatalogId: _selectedId,
                focus: _focus,
                onViewport: _viewportChanged,
                onPlace: _select,
              ),
            ),
          ),
        ),
        if (_mode == CatalogMapMode.heat)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Text('Fewer places'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(colors: catalogHeatColors),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('More places'),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _results(BuildContext context) {
    final page = _page;
    final error = _error;
    if (page == null) {
      return [
        if (error != null)
          _ErrorCard(error)
        else
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          ),
      ];
    }
    final inView = _limitToMap && _viewport != null;
    return [
      Text(
        '${page.total} ${page.total == 1 ? 'place' : 'places'}'
        '${inView ? ' in the map view' : ''} · stale when cached before '
        '${formatCatalogDate(page.freshAfter)}',
        key: const Key('catalog-summary'),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(height: 8),
      // A failed reload keeps the places already shown.
      if (error != null) _ErrorCard(error),
      if (page.items.isEmpty)
        const Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: Text('No catalog places match these filters.')),
        ),
      for (final place in page.items) _placeTile(context, place),
      _pagination(page),
    ];
  }

  Widget _placeTile(BuildContext context, AdminCatalogPlace place) {
    final theme = Theme.of(context);
    final selected = place.catalogId == _selectedId;
    final badges = catalogPlaceBadges(context, place);
    return Card(
      key: ValueKey('catalog-place-${place.catalogId}'),
      color: selected ? theme.colorScheme.secondaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _select(place.catalogId, showOnMap: place),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(catalogPlaceSummary(place)),
                    const SizedBox(height: 6),
                    Text(
                      catalogCacheLine(place, _now),
                      key: ValueKey('catalog-cache-${place.catalogId}'),
                      style: theme.textTheme.bodySmall,
                    ),
                    if (badges.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(spacing: 6, runSpacing: 6, children: badges),
                    ],
                  ],
                ),
              ),
              PopupMenuButton<bool>(
                key: ValueKey('catalog-actions-${place.catalogId}'),
                tooltip: 'Place actions',
                onSelected: (restore) => _placeAction(place, restore),
                itemBuilder: (_) => [
                  if (place.quarantinedAt == null)
                    const PopupMenuItem(value: false, child: Text('Quarantine'))
                  else
                    const PopupMenuItem(value: true, child: Text('Restore')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pagination(AdminCatalogPage page) {
    if (page.total == 0) return const SizedBox.shrink();
    final first = page.page * page.pageSize + 1;
    final last = page.page * page.pageSize + page.items.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('$first–$last of ${page.total}'),
        IconButton(
          tooltip: 'Previous page',
          onPressed: _pageIndex == 0
              ? null
              : () {
                  _pageIndex--;
                  unawaited(_load());
                },
          icon: const Icon(Icons.chevron_left),
        ),
        IconButton(
          tooltip: 'Next page',
          onPressed: last >= page.total
              ? null
              : () {
                  _pageIndex++;
                  unawaited(_load());
                },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _detailPanel(BuildContext context) {
    final catalogId = _selectedId;
    if (catalogId == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Select a place in the list or on the map to see everything the '
            'catalog holds about it.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return CatalogPlacePanel(
      key: ValueKey('catalog-panel-$catalogId'),
      operations: widget.operations,
      catalogId: catalogId,
      now: _now,
      onChanged: _reload,
      onShowOnMap: _showOnMap,
      onClose: () => setState(() => _selectedId = null),
    );
  }

  Future<void> _placeAction(AdminCatalogPlace place, bool restore) async {
    final reason = await showCatalogReasonDialog(
      context,
      '${restore ? 'Restore' : 'Quarantine'} ${place.name}',
    );
    if (reason == null || !mounted) return;
    try {
      if (restore) {
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
      _reload();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      }
    }
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard(this.error);

  final Object error;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Text('Could not load the catalog: $error'),
    ),
  );
}
