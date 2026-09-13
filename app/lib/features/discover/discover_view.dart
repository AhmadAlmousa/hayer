import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/providers.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_area_labels.dart';
import 'discovery_config_controller.dart';
import 'discovery_map.dart';
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';
import 'discovery_search.dart';
import 'discovery_sort_text.dart';

/// How long entering Discover waits for an already permitted location before
/// opening somewhere else.
const _locationWait = Duration(seconds: 3);

/// The Discover map, its results and the controls over them.
///
/// The link is the committed query. Every applied change goes through the
/// router, and this reacts to the link it is given: the same page stays in
/// place, so the map and the loaded results survive a change of query.
///
/// Android keeps one history entry per applied change here, so Back steps
/// through earlier searches before it leaves. The browser keeps that history
/// itself on the web.
class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({super.key, required this.uri});

  final Uri uri;

  @override
  ConsumerState<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  final _map = GlobalKey<DiscoveryMapState>();
  final _sheet = DraggableScrollableController();

  /// Earlier committed locations from this visit, most recent last.
  final _history = <String>[];

  late DiscoveryLinkParse _link;

  /// The area the map last came to rest on, or null until it does for the
  /// committed viewport.
  DiscoveryViewport? _visible;

  /// The permitted device location distances are measured from.
  DiscoveryPoint? _origin;

  String? _areaLabel;
  String? _labelKey;
  String? _normalizedTo;
  Size? _mapSize;
  bool _resolvingStart = false;
  bool _locating = false;

  DiscoveryUrlQuery get _query => _link.query;

  bool get _pending {
    final committed = _query.viewport;
    final visible = _visible;
    return committed != null &&
        visible != null &&
        !discoveryViewportShows(visible, committed);
  }

  bool get _outsideCoverage {
    final viewport = _query.viewport;
    return viewport != null && _countryFor(viewport) == null;
  }

  @override
  void initState() {
    super.initState();
    _link = DiscoveryUrlQuery.parse(widget.uri.queryParameters);
    unawaited(_loadOrigin());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_link.issues.isNotEmpty) {
        _notify(AppLocalizations.of(context)!.discoveryLinkPartlyApplied);
      }
      _commit();
    });
  }

  @override
  void didUpdateWidget(DiscoverView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.uri == oldWidget.uri) return;
    final previous = _query.viewport?.token;
    _link = DiscoveryUrlQuery.parse(widget.uri.queryParameters);
    // Until the map settles on the new area, it is not known to have moved.
    if (_query.viewport?.token != previous) _visible = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _commit();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_query.viewport case final viewport?) _labelArea(viewport);
  }

  @override
  void dispose() {
    _sheet.dispose();
    super.dispose();
  }

  /// Acts on the committed link: supplies a missing viewport, puts the link in
  /// canonical form, then shows its results.
  void _commit() {
    final viewport = _query.viewport;
    if (viewport == null) {
      unawaited(_openStartingArea());
      return;
    }
    final location = _query.location;
    if (!_spells(widget.uri, location) && _normalizedTo != location) {
      _normalizedTo = location;
      // A different spelling of the same query is not a new search.
      Router.neglect(context, () => context.go(location));
      return;
    }
    _labelArea(viewport);
    unawaited(ref.read(discoveryAreaStoreProvider).write(viewport));
    final country = _countryFor(viewport);
    if (country == null) return;
    ref
        .read(discoveryResultsProvider.notifier)
        .show(DiscoverySearch(query: _query, countryCode: country));
  }

  String? _countryFor(DiscoveryViewport viewport) => discoveryCountryFor(
    viewport,
    ref.read(discoveryConfigProvider).config?.supportedCountries ?? const [],
  );

  /// Opens a link without a viewport at the permitted device location, else
  /// the last area searched here, else the default city. Browsing never asks
  /// for location permission.
  Future<void> _openStartingArea() async {
    if (_resolvingStart) return;
    _resolvingStart = true;
    try {
      final size = _mapSize ?? MediaQuery.sizeOf(context);
      final width = size.width > 0 ? size.width : 400.0;
      final height = size.height > 0 ? size.height : 800.0;
      DiscoveryViewport? viewport;
      if (await _permittedLocation() case final point?) {
        viewport = discoveryViewportForCamera(
          (
            latitude: point.latitude,
            longitude: point.longitude,
            zoom: discoveryLocationZoom,
          ),
          width: width,
          height: height,
        );
      }
      viewport ??= await ref.read(discoveryAreaStoreProvider).read();
      viewport ??= discoveryViewportForCamera(
        (
          latitude: discoveryDefaultCenter.latitude,
          longitude: discoveryDefaultCenter.longitude,
          zoom: discoveryDefaultZoom,
        ),
        width: width,
        height: height,
      );
      if (!mounted || viewport == null || _query.viewport != null) return;
      final location = _query.withViewport(viewport).location;
      // The starting area is a default, not a search the user made.
      Router.neglect(context, () => context.go(location));
    } finally {
      _resolvingStart = false;
    }
  }

  Future<DiscoveryPoint?> _permittedLocation() async {
    final warmup = ref.read(locationWarmupProvider);
    final position =
        warmup.latest ??
        await warmup.ready.timeout(_locationWait, onTimeout: () => null);
    return position == null
        ? null
        : (latitude: position.latitude, longitude: position.longitude);
  }

  Future<void> _loadOrigin() async {
    final origin = await _permittedLocation();
    if (mounted && origin != null) setState(() => _origin = origin);
  }

  void _labelArea(DiscoveryViewport viewport) {
    final language = Localizations.localeOf(context).languageCode;
    final key = '${viewport.token}|$language';
    if (_labelKey == key) return;
    _labelKey = key;
    _areaLabel = null;
    unawaited(
      ref.read(discoveryAreaLabelsProvider).labelFor(viewport, language).then((
        label,
      ) {
        if (mounted && _labelKey == key) setState(() => _areaLabel = label);
      }),
    );
  }

  /// Commits [next] as a new search, one history entry per change.
  void _apply(DiscoveryUrlQuery next) {
    final current = _query.location;
    final location = next.location;
    if (location == current) return;
    if (!kIsWeb) _history.add(current);
    context.go(location);
  }

  void _back(bool didPop, Object? result) {
    if (didPop || _history.isEmpty) return;
    context.go(_history.removeLast());
  }

  void _searchThisArea() {
    if (_visible case final visible?) _apply(_query.withViewport(visible));
  }

  Future<void> _locate() async {
    setState(() => _locating = true);
    try {
      final position = await ref
          .read(locationWarmupProvider)
          .locate(requestPermission: true, refresh: true);
      if (!mounted) return;
      if (position == null) {
        _notify(AppLocalizations.of(context)!.locationPermissionRequired);
        return;
      }
      final point = (
        latitude: position.latitude,
        longitude: position.longitude,
      );
      setState(() => _origin = point);
      // Only the camera moves; the new area is searched when the user asks.
      await _map.currentState?.recenter(point);
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<void> _chooseSort() async {
    final scoring = ref.read(discoveryConfigProvider).config?.scoring;
    final chosen = await showModalBottomSheet<DiscoverySort>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final strings = AppLocalizations.of(context)!;
        return SafeArea(
          child: SingleChildScrollView(
            child: RadioGroup<DiscoverySort>(
              groupValue: _query.sort,
              onChanged: (sort) => Navigator.of(context).pop(sort),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                    child: Text(
                      strings.discoverySortTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  for (final sort in DiscoverySort.values)
                    RadioListTile<DiscoverySort>(
                      key: ValueKey('discovery-sort-${sort.name}'),
                      value: sort,
                      title: Text(discoverySortLabel(strings, sort)),
                      subtitle: switch (discoverySortExplainer(
                        context,
                        sort,
                        scoring,
                      )) {
                        final explainer? => Text(explainer),
                        null => null,
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (chosen != null && mounted) _apply(_query.withSort(chosen));
  }

  void _notify(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  /// Whether [uri] already spells [location], parameter by parameter.
  static bool _spells(Uri uri, String location) {
    final canonical = Uri.parse(location);
    final actual = uri.queryParametersAll;
    final expected = canonical.queryParametersAll;
    return uri.path == canonical.path &&
        listEquals(actual.keys.toList(), expected.keys.toList()) &&
        actual.keys.every((key) => listEquals(actual[key], expected[key]));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    ref.listen(discoveryResultsProvider.select((results) => results.restarts), (
      previous,
      next,
    ) {
      if (next > (previous ?? 0)) _notify(strings.discoveryResultsChanged);
    });
    final viewport = _query.viewport;
    final pending = _pending;
    final area = _areaLabel ?? strings.discoveryThisArea;
    return PopScope(
      canPop: kIsWeb || _history.isEmpty,
      onPopInvokedWithResult: _back,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              _mapSize = constraints.biggest;
              return Stack(
                children: [
                  Positioned.fill(
                    child: viewport == null
                        ? ColoredBox(color: colors.surfaceContainerHighest)
                        : DiscoveryMap(
                            key: _map,
                            viewport: viewport,
                            onVisibleViewport: (visible) =>
                                setState(() => _visible = visible),
                          ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    top: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _AreaBar(
                          title: viewport == null
                              ? strings.discoveryThisArea
                              : pending
                              ? strings.discoveryPreviousArea(area)
                              : strings.discoveryAreaThisView(area),
                          locating: _locating,
                          onLocate: _locate,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: FilledButton.icon(
                            key: const ValueKey('discovery-sort'),
                            style: FilledButton.styleFrom(
                              minimumSize: const Size(0, 40),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              visualDensity: VisualDensity.compact,
                              elevation: 2,
                            ),
                            onPressed: _chooseSort,
                            icon: const Icon(Icons.swap_vert_rounded),
                            label: Text(
                              discoverySortLabel(strings, _query.sort),
                            ),
                          ),
                        ),
                        if (pending)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FilledButton.icon(
                                key: const ValueKey('discovery-search-area'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: colors.inverseSurface,
                                  foregroundColor: colors.onInverseSurface,
                                  minimumSize: const Size(0, 36),
                                  visualDensity: VisualDensity.compact,
                                  elevation: 2,
                                ),
                                onPressed: _searchThisArea,
                                icon: const Icon(Icons.refresh_rounded),
                                label: Text(strings.discoverySearchThisArea),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  DraggableScrollableSheet(
                    controller: _sheet,
                    initialChildSize: discoverySheetHalf,
                    minChildSize: discoverySheetPeek,
                    snap: true,
                    snapSizes: const [discoverySheetPeek, discoverySheetHalf],
                    builder: (context, scrollController) => Material(
                      color: colors.surface,
                      elevation: 8,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: DiscoveryResultsSheet(
                        query: _query,
                        scrollController: scrollController,
                        sheetController: _sheet,
                        pending: pending,
                        outsideCoverage: _outsideCoverage,
                        origin: _origin,
                        onApply: _apply,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// The floating bar naming the committed area.
class _AreaBar extends StatelessWidget {
  const _AreaBar({
    required this.title,
    required this.locating,
    required this.onLocate,
  });

  final String title;
  final bool locating;
  final VoidCallback onLocate;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      elevation: 3,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          children: [
            const BackButton(),
            Expanded(
              child: Text(
                title,
                key: const ValueKey('discovery-area-title'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton.filledTonal(
              tooltip: strings.discoveryShowMyLocation,
              onPressed: locating ? null : onLocate,
              icon: const Icon(Icons.my_location_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
