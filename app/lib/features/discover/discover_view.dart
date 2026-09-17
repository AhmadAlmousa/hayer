import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart'
    show DiscoveryHarvestState, DiscoveryMapMode, LocationSuggestion;
import 'package:material_ui/material_ui.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/providers.dart';
import '../../core/public_links.dart';
import '../../core/widgets/location_search_field.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_category_tree.dart';
import '../../domain/discovery_coverage.dart';
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
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';
import 'discovery_search.dart';
import 'discovery_selection_controller.dart';
import 'discovery_sort_text.dart';
import 'discovery_taxonomy_provider.dart';

/// How long entering Discover waits for an already permitted location before
/// opening somewhere else.
const _locationWait = Duration(seconds: 3);

/// How long a moved map rests before its area is searched.
///
/// Long enough that panning across a city is one search rather than a dozen,
/// short enough that stopping somewhere feels like arriving.
const _autoSearchDelay = Duration(milliseconds: 700);

/// The least room above the sheet the selected place's card is drawn in.
///
/// Raising the sheet over the whole map leaves nowhere to put the card, so
/// under this it gives way to the list rather than being squeezed into a
/// sliver of it.
const _cardMinimumRoom = 140.0;

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

  /// Searches the area the map has settled on, once it has rested.
  Timer? _autoSearch;

  /// The area bar's search field, while it is open.
  final _areaSearch = TextEditingController();
  final _areaSearchField = GlobalKey<LocationSearchFieldState>();
  bool _searchingArea = false;

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
    _autoSearch?.cancel();
    _areaSearch.dispose();
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
    if (_normalizeCategories()) return;
    _labelArea(viewport);
    unawaited(ref.read(discoveryAreaStoreProvider).write(viewport));
    ref
        .read(discoveryResultsProvider.notifier)
        .show(DiscoverySearch(query: _query));
    // Reported once per committed area; sorts and filters keep the area.
    ref.read(discoveryCoverageProvider.notifier).ensure(viewport);
  }

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

  /// Takes the area the map has come to rest on, and searches it once it has
  /// stayed there.
  ///
  /// Committing an area moves the camera to it, which comes to rest in turn;
  /// [discoveryViewportShows] recognises that as the area already shown, so a
  /// search cannot start another one.
  void _settled(DiscoveryViewport visible) {
    setState(() => _visible = visible);
    _autoSearch?.cancel();
    if (!_pending) return;
    _autoSearch = Timer(_autoSearchDelay, () {
      if (!mounted || !_pending) return;
      if (_visible case final rested?) _searchAutomatically(rested);
    });
  }

  /// Commits [visible] without a history entry: panning is not a step to go
  /// back through, and Back must still leave Discover rather than retrace
  /// every drag of the map.
  void _searchAutomatically(DiscoveryViewport visible) {
    final location = _query.withViewport(visible).location;
    if (location == _query.location) return;
    Router.neglect(context, () => context.go(location));
  }

  /// Moves the search to a place chosen by name. Unlike panning, this is a
  /// search the user asked for, so it keeps its history entry.
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
    _autoSearch?.cancel();
    _apply(_query.withViewport(viewport));
  }

  void _closeAreaSearch() {
    _areaSearchField.currentState?.clearSuggestions();
    _areaSearch.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    if (mounted) setState(() => _searchingArea = false);
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
    ref.listen(discoveryCoverageProvider.select((coverage) => coverage.job), (
      previous,
      next,
    ) {
      final found =
          next?.state == DiscoveryHarvestState.succeeded ||
          next?.state == DiscoveryHarvestState.partial;
      if (found &&
          previous?.jobId == next?.jobId &&
          !discoveryHarvestFinished(previous!.state)) {
        _notify(strings.discoveryExplorationUpdated);
      }
    });
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
                            onVisibleViewport: _settled,
                            places: places,
                            selected: selected,
                            ranks: ranks,
                            myLocationEnabled: _origin != null,
                            onPlace: ref
                                .read(discoverySelectionProvider.notifier)
                                .selectPoint,
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
                          onShare: viewport == null ? null : _share,
                          searching: _searchingArea,
                          onSearch: () => setState(() => _searchingArea = true),
                          onCloseSearch: _closeAreaSearch,
                        ),
                        if (_searchingArea)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Material(
                              color: colors.surface,
                              elevation: 3,
                              borderRadius: BorderRadius.circular(20),
                              clipBehavior: Clip.antiAlias,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  8,
                                  12,
                                  8,
                                ),
                                child: LocationSearchField(
                                  key: _areaSearchField,
                                  controller: _areaSearch,
                                  autofocus: true,
                                  latitude: _origin?.latitude,
                                  longitude: _origin?.longitude,
                                  onSelected: _goToSuggestion,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                        DiscoveryFilterBar(
                          query: _query,
                          onSort: _chooseSort,
                          onFilters: _openFilters,
                          onCategories: _openCategories,
                          onApply: _apply,
                        ),
                        if (places?.mode == DiscoveryMapMode.aggregates &&
                            !pending)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
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
                        // A moved map searches itself, so this says what is
                        // happening rather than asking for a tap.
                        if (pending)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Material(
                                key: const ValueKey(
                                  'discovery-searching-area',
                                ),
                                color: colors.inverseSurface,
                                shape: const StadiumBorder(),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: colors.onInverseSurface,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        strings.discoverySearchingThisArea,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: colors.onInverseSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // The selected place rides just above the sheet's top edge.
                  // The padding around it lets taps through to the map.
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _sheet,
                      builder: (context, child) {
                        final covered =
                            constraints.maxHeight *
                            (_sheet.isAttached
                                ? _sheet.size
                                : discoverySheetHalf);
                        if (constraints.maxHeight - covered <
                            _cardMinimumRoom) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 12,
                            right: 12,
                            bottom: covered + 8,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: child,
                          ),
                        );
                      },
                      child: DiscoveryPlaceCard(origin: _origin),
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
    required this.onShare,
    required this.searching,
    required this.onSearch,
    required this.onCloseSearch,
  });

  final String title;
  final bool locating;
  final VoidCallback onLocate;

  /// Shares the committed search, while there is one.
  final VoidCallback? onShare;

  /// Whether the area is being searched by name, which the bar offers a way
  /// out of instead of a way in.
  final bool searching;
  final VoidCallback onSearch;
  final VoidCallback onCloseSearch;

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
                onTap: searching ? onCloseSearch : onSearch,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
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
            if (searching)
              IconButton(
                key: const ValueKey('discovery-close-search'),
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                onPressed: onCloseSearch,
                icon: const Icon(Icons.close_rounded),
              )
            else
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
