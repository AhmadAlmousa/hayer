import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart'
    show DiscoverPlace, DiscoveryMapMode, DiscoveryMapPoint, LocationSuggestion;
import 'package:material_ui/material_ui.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../core/public_links.dart';
import '../../core/widgets/location_search_field.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_category_tree.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_area_labels.dart';
import 'discovery_category_sheet.dart';
import 'discovery_config_controller.dart';
import 'discovery_coverage_controller.dart';
import 'discovery_filter_bar.dart';
import 'discovery_filter_sheet.dart';
import 'discovery_map.dart';
import 'discovery_place_card.dart';
import 'discovery_place_details.dart';
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';
import '../intent/place_intent_controller.dart';
import 'discovery_search.dart';
import 'discovery_selection_controller.dart';
import 'discovery_sort_text.dart';
import 'discovery_taxonomy_provider.dart';

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

  /// Committing the camera on every frame of a pan would put a history entry
  /// and a query behind each one. This waits for the map to settle.
  Timer? _settle;

  /// The canonical cell the last exploration was asked for, so panning inside
  /// one does not ask again. Null until an area has been reported.
  String? _exploredKey;

  /// Earlier committed locations from this visit, most recent last.
  final _history = <String>[];

  /// The area bar's search field, while it is open.
  final _areaSearch = TextEditingController();
  final _areaSearchField = GlobalKey<LocationSearchFieldState>();
  bool _searchingArea = false;

  late DiscoveryLinkParse _link;

  /// The permitted device location distances are measured from.
  DiscoveryPoint? _origin;
  DiscoveryPoint? _sortOrigin;

  String? _areaLabel;
  String? _labelKey;
  String? _normalizedTo;
  Size? _mapSize;
  bool _resolvingStart = false;
  bool _locating = false;
  bool _showingPlaceSheet = false;

  DiscoveryUrlQuery get _query => _link.query;

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
    _link = DiscoveryUrlQuery.parse(widget.uri.queryParameters);
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
    _settle?.cancel();
    _areaSearch.dispose();
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
    if (_query.sort == DiscoverySort.distanceCurrent &&
        (_sortOrigin ?? _origin) == null) {
      // A shared link contains no private device coordinates. If this device
      // has no permitted location, keep the distance order usable.
      unawaited(_resolveCurrentDistanceSort());
      return;
    }
    final location = _query.location;
    if (!_spells(widget.uri, location) && _normalizedTo != location) {
      _normalizedTo = location;
      // A different spelling of the same query is not a new search.
      Router.neglect(context, () => context.go(location));
      return;
    }
    if (_normalizeCategories()) return;
    final taxonomy = ref.read(discoveryTaxonomyProvider).value;
    if (taxonomy != null) {
      ref.read(placeIntentProvider.notifier).adoptDiscovery(taxonomy, _query);
    }
    _labelArea(viewport);
    unawaited(ref.read(discoveryAreaStoreProvider).write(viewport));
    ref
        .read(discoveryResultsProvider.notifier)
        .show(DiscoverySearch(query: _query, origin: _sortOrigin ?? _origin));
    _explore(viewport);
  }

  /// Asks the server to harvest [viewport] if it has not already been asked
  /// for the same place. The selected category has its own source search in
  /// the browse request; this broader harvest stays gated by canonical cell.
  void _explore(DiscoveryViewport viewport) {
    final key = discoveryExploreKey(viewport);
    if (key == _exploredKey) return;
    _exploredKey = key;
    ref.read(discoveryCoverageProvider.notifier).ensure(viewport);
  }

  /// Opens a link without a viewport at the permitted device location, else
  /// the last area searched here, else the default city. Browsing never asks
  /// for location permission.
  Future<void> _openStartingArea() async {
    if (_resolvingStart) return;
    _resolvingStart = true;
    try {
      final saved = await ref.read(discoveryAreaStoreProvider).read();
      final center =
          await _permittedLocation() ??
          (saved == null
              ? discoveryDefaultCenter
              : discoveryViewportCenter(saved));
      final viewport = discoveryViewportAround(center);
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
    if (mounted && origin != null) {
      setState(() => _origin = origin);
      if (_query.sort == DiscoverySort.distanceCurrent) _commit();
    }
  }

  Future<void> _resolveCurrentDistanceSort() async {
    final position = await _permittedLocation();
    if (!mounted || _query.sort != DiscoverySort.distanceCurrent) return;
    if (position != null) {
      setState(() => _sortOrigin = position);
      _commit();
    } else {
      final location = _query.withSort(DiscoverySort.distanceArea).location;
      _normalizedTo = location;
      Router.neglect(context, () => context.go(location));
      _notify(AppLocalizations.of(context)!.discoverySortLocationUnavailable);
    }
  }

  /// How long the camera must rest before its area becomes the query.
  static const _browseDebounce = Duration(milliseconds: 400);

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

  /// Commits [next] without a history entry.
  ///
  /// Following the camera would otherwise put one entry behind every pan, and
  /// back out of Discover a pan at a time.
  void _follow(DiscoveryUrlQuery next) {
    final location = next.location;
    if (location == _query.location) return;
    _normalizedTo = location;
    Router.neglect(context, () => context.go(location));
  }

  /// Runs the search for wherever the map has come to rest.
  ///
  /// A changed viewport becomes a new query. The server searches that area
  /// and reuses a matching catalog search when one is still fresh; [_explore]
  /// separately queues the broader area harvest once per canonical cell.
  void _cameraSettled(DiscoveryViewport visible) {
    _settle?.cancel();
    _settle = Timer(_browseDebounce, () {
      if (!mounted) return;
      final committed = _query.viewport;
      if (committed != null && discoveryViewportShows(visible, committed)) {
        return;
      }
      _follow(_query.withViewport(visible));
    });
  }

  void _back(bool didPop, Object? result) {
    if (didPop || _history.isEmpty) return;
    context.go(_history.removeLast());
  }

  /// Moves the search to a place chosen by name. Unlike following the camera,
  /// this is a search the user asked for, so it keeps its history entry.
  void _goToSuggestion(LocationSuggestion suggestion) {
    final size = _mapSize ?? MediaQuery.sizeOf(context);
    final viewport = discoveryViewportForCamera(
      (
        latitude: suggestion.latitude,
        longitude: suggestion.longitude,
        zoom: discoveryLocationZoom,
      ),
      width: size.width > 0 ? size.width : 400.0,
      height: size.height > 0 ? size.height : 800.0,
    );
    _closeAreaSearch();
    if (viewport == null) return;
    _settle?.cancel();
    _apply(_query.withViewport(viewport));
  }

  void _closeAreaSearch() {
    _areaSearchField.currentState?.clearSuggestions();
    _areaSearch.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) setState(() => _searchingArea = false);
  }

  Future<void> _showSelectedPlace() async {
    if (_showingPlaceSheet || !mounted) return;
    _showingPlaceSheet = true;
    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (sheetContext) => SizedBox(
          height: MediaQuery.sizeOf(sheetContext).height * .55,
          child: DiscoveryPlaceCard(
            origin: _origin,
            onClose: () => Navigator.of(sheetContext).pop(),
          ),
        ),
      );
    } finally {
      _showingPlaceSheet = false;
      if (mounted) ref.read(discoverySelectionProvider.notifier).clear();
    }
  }

  void _selectPoint(DiscoveryMapPoint point) {
    ref.read(discoverySelectionProvider.notifier).selectPoint(point);
    if (ref.read(discoverySelectionProvider).place != null) {
      unawaited(_showSelectedPlace());
    }
  }

  Future<void> _selectRow(DiscoverPlace item) async {
    final results = ref.read(discoveryResultsProvider);
    final search = results.search;
    final queryContext = results.context;
    if (search == null || queryContext == null) return;
    ref.read(discoverySelectionProvider.notifier).selectRow(item);
    try {
      await showDiscoveryPlaceDetails(
        context,
        item: item,
        search: search,
        queryContext: queryContext,
        origin: _origin,
      );
    } finally {
      if (mounted) ref.read(discoverySelectionProvider.notifier).clear();
    }
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
                    padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
                    child: Text(
                      '✨ ${strings.discoverySortTitle}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                    child: Text(strings.discoverySortHelp),
                  ),
                  for (final sort in DiscoverySort.values)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 2,
                      ),
                      child: Card(
                        color: _query.sort == sort
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null,
                        child: RadioListTile<DiscoverySort>(
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
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (chosen == null || !mounted) return;
    if (chosen == DiscoverySort.distanceCurrent) {
      final position = await ref
          .read(locationWarmupProvider)
          .locate(requestPermission: true, refresh: true);
      if (!mounted) return;
      if (position == null) {
        _notify(AppLocalizations.of(context)!.locationPermissionRequired);
        return;
      }
      setState(() {
        _origin = (latitude: position.latitude, longitude: position.longitude);
        _sortOrigin = _origin;
      });
    } else {
      _sortOrigin = null;
    }
    if (chosen == _query.sort) {
      if (chosen == DiscoverySort.distanceCurrent) _commit();
    } else {
      _apply(_query.withSort(chosen));
    }
  }

  Future<void> _openFilters() async {
    if (_query.viewport == null) return;
    final applied = await showDiscoveryFilterSheet(context, committed: _query);
    if (applied != null && mounted) _apply(applied);
  }

  Future<void> _openCategories() async {
    final ids = await showDiscoveryCategorySheet(context, committed: _query);
    if (ids != null && mounted) _apply(_query.withCategories(ids));
  }

  /// Takes out of the link any category the published tree no longer has,
  /// with a notice, and any a selected parent already includes. Returns
  /// whether the link was replaced.
  bool _normalizeCategories() {
    if (_query.categoryIds.isEmpty) return false;
    final snapshot = ref.read(discoveryTaxonomyProvider).value;
    final config = ref.read(discoveryConfigProvider).config;
    // Only the tree the configuration names can say an id is gone.
    if (snapshot == null ||
        config == null ||
        snapshot.roots.isEmpty ||
        snapshot.revision != config.taxonomyRevision) {
      return false;
    }
    final (:ids, :unknown) = DiscoveryCategoryTree(
      roots: snapshot.roots,
      otherId: config.limits.otherCategoryId,
    ).normalize(_query.categoryIds);
    if (ids.length == _query.categoryIds.length) return false;
    if (unknown.isNotEmpty) {
      _notify(AppLocalizations.of(context)!.discoveryCategoriesRemoved);
    }
    final location = _query.withCategories(ids).location;
    _normalizedTo = location;
    // Correcting a link is not a new search.
    Router.neglect(context, () => context.go(location));
    return true;
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

  /// Shares the committed search as a public link. The link holds the area,
  /// sort and filters, and nothing about where this device is.
  Future<void> _share() async {
    final strings = AppLocalizations.of(context)!;
    final link = hayerPublicUri(_query.location);
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(
      ShareParams(
        text: strings.discoveryShareMessage(link.toString()),
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  void _quickPick() {
    final snapshot = ref.read(discoveryTaxonomyProvider).value;
    final adopted =
        snapshot != null &&
        ref.read(placeIntentProvider.notifier).adoptDiscovery(snapshot, _query);
    if (!adopted) {
      _notify(
        Localizations.localeOf(context).languageCode == 'ar'
            ? 'اختر فئات من مجموعة واحدة وقرّب الخريطة إلى 10 كم أو أقل.'
            : 'Choose categories from one group and zoom to 10 km or less.',
      );
      return;
    }
    context.go('/next');
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
    // The link's categories can be checked once the tree is known.
    ref.listen(discoveryTaxonomyProvider, (_, next) {
      if (next.hasValue) _commit();
    });
    ref.listen(
      discoverySelectionProvider.select((selection) => selection.departures),
      (previous, next) {
        if (next > (previous ?? 0)) _notify(strings.discoverySelectionGone);
      },
    );
    final places = ref.watch(
      discoveryResultsProvider.select((results) => results.map),
    );
    final selected = ref.watch(
      discoverySelectionProvider.select((selection) => selection.place?.marker),
    );
    // The places the list has reached, so their pins are drawn as its rows
    // rather than as one more rating.
    final ranks = {
      for (final item in ref.watch(
        discoveryResultsProvider.select((results) => results.items),
      ))
        item.catalogId: item.ordinal,
    };
    final viewport = _query.viewport;
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
                            onVisibleViewport: _cameraSettled,
                            places: places,
                            selected: selected,
                            ranks: ranks,
                            myLocationEnabled: _origin != null,
                            onPlace: _selectPoint,
                          ),
                  ),
                  if (places?.mode == DiscoveryMapMode.aggregates)
                    Positioned(
                      left: 12,
                      right: 12,
                      top: 160,
                      child: Center(
                        child: Material(
                          key: const ValueKey('discovery-zoom-in'),
                          color: colors.inverseSurface,
                          shape: const StadiumBorder(),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            child: Text(
                              strings.discoveryZoomInForPlaces,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: colors.onInverseSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight * .65,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (_searchingArea)
                                Material(
                                  color: colors.surface,
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      12,
                                      4,
                                      12,
                                      8,
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.centerEnd,
                                          child: IconButton(
                                            key: const ValueKey(
                                              'discovery-close-search',
                                            ),
                                            tooltip: MaterialLocalizations.of(
                                              context,
                                            ).closeButtonTooltip,
                                            onPressed: _closeAreaSearch,
                                            icon: const Icon(
                                              Icons.close_rounded,
                                            ),
                                          ),
                                        ),
                                        LocationSearchField(
                                          key: _areaSearchField,
                                          controller: _areaSearch,
                                          autofocus: true,
                                          latitude: _origin?.latitude,
                                          longitude: _origin?.longitude,
                                          onSelected: _goToSuggestion,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                _AreaBar(
                                  title: viewport == null
                                      ? strings.discoveryThisArea
                                      : strings.discoveryAreaThisView(area),
                                  locating: _locating,
                                  onLocate: _locate,
                                  onShare: viewport == null ? null : _share,
                                  onSearch: () =>
                                      setState(() => _searchingArea = true),
                                ),
                              const SizedBox(height: 6),
                              DiscoveryFilterBar(
                                query: _query,
                                onSort: _chooseSort,
                                onFilters: _openFilters,
                                onCategories: _openCategories,
                                onApply: _apply,
                              ),
                              if (viewport != null &&
                                  _query.categoryIds.isNotEmpty)
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: TextButton.icon(
                                    key: const ValueKey('discover-quick-pick'),
                                    onPressed: _quickPick,
                                    icon: const Icon(Icons.bolt_rounded),
                                    label: Text(
                                      Localizations.localeOf(context)
                                                  .languageCode ==
                                              'ar'
                                          ? 'اختيار سريع لهذه الأماكن'
                                          : 'Quick Pick these places',
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    key: const ValueKey('discovery-results-draggable'),
                    initialChildSize: .28,
                    minChildSize: .16,
                    maxChildSize: .9,
                    snap: true,
                    snapSizes: const [.28, .55],
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
                        origin: _origin,
                        onApply: _apply,
                        onSelectRow: _selectRow,
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
    required this.onShare,
    required this.onSearch,
  });

  final String title;
  final bool locating;
  final VoidCallback onLocate;

  /// Shares the committed search, while there is one.
  final VoidCallback? onShare;

  final VoidCallback onSearch;

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
              child: InkWell(
                key: const ValueKey('discovery-area-search'),
                onTap: onSearch,
                borderRadius: BorderRadius.circular(20),
                // As tall as the buttons beside it, so the bar keeps the
                // height it had before its title became a control.
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        ExcludeSemantics(
                          child: Icon(
                            Icons.search_rounded,
                            size: 18,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 6),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              key: const ValueKey('discovery-share'),
              tooltip: strings.discoveryShareSearch,
              onPressed: onShare,
              icon: const Icon(Icons.share_rounded),
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
