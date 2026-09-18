import 'dart:async';

import 'package:flutter/rendering.dart' show ScrollCacheExtent;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart' show DiscoverPlace;
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/discovery_area.dart';
import '../../domain/discovery_category_tree.dart';
import '../../domain/discovery_coverage.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import '../report/report_place_issue_sheet.dart';
import 'discovery_config_controller.dart';
import 'discovery_coverage_controller.dart';
import 'discovery_coverage_strip.dart';
import 'discovery_filter_text.dart';
import 'discovery_place_details.dart';
import 'discovery_place_preview.dart';
import 'discovery_place_row.dart';
import 'discovery_results_controller.dart';
import 'discovery_selection_controller.dart';
import 'discovery_sort_text.dart';
import 'discovery_taxonomy_provider.dart';

/// The share of the screen the results take, the map taking the rest.
///
/// Fixed rather than dragged: the sheet used to be draggable over a full-bleed
/// map, and the owner asked for a layout that never lands in an in-between
/// state. Both halves are always usable, so neither has to be uncovered.
const discoveryResultsShare = 0.5;

const _revealDuration = Duration(milliseconds: 250);

/// The ranked Discover results, filling the lower half of the screen.
class DiscoveryResultsSheet extends ConsumerStatefulWidget {
  const DiscoveryResultsSheet({
    super.key,
    required this.query,
    required this.scrollController,
    required this.origin,
    required this.onApply,
  });

  /// The committed query.
  final DiscoveryUrlQuery query;
  final ScrollController scrollController;

  /// The permitted device location, for distances.
  final DiscoveryPoint? origin;

  /// Commits a changed query.
  final ValueChanged<DiscoveryUrlQuery> onApply;

  @override
  ConsumerState<DiscoveryResultsSheet> createState() =>
      _DiscoveryResultsSheetState();
}

class _DiscoveryResultsSheetState extends ConsumerState<DiscoveryResultsSheet> {
  /// The selected row, which a tapped pin scrolls into view.
  final _selectedRow = GlobalKey();

  /// Scrolls the selected place's row into view. The list is always on
  /// screen now, so there is no sheet to raise first.
  Future<void> _reveal() async {
    final place = ref.read(discoverySelectionProvider).place;
    if (place == null) return;
    final items = ref.read(discoveryResultsProvider).items;
    final index = items.indexWhere((item) => item.catalogId == place.catalogId);
    if (index < 0) return;
    // Rows are built only as they near the viewport, so a row further down
    // is first brought close by estimate.
    for (var attempt = 0; attempt < 3; attempt++) {
      if (!mounted || _selectedRow.currentContext != null) break;
      final scroll = widget.scrollController;
      if (!scroll.hasClients) return;
      final position = scroll.position;
      final estimate =
          (position.maxScrollExtent + position.viewportDimension) *
          index /
          items.length;
      scroll.jumpTo(
        estimate.clamp(position.minScrollExtent, position.maxScrollExtent),
      );
      await WidgetsBinding.instance.endOfFrame;
    }
    final row = _selectedRow.currentContext;
    if (!mounted || row == null || !row.mounted) return;
    await Scrollable.ensureVisible(
      row,
      alignment: 0.1,
      duration: _revealDuration,
      curve: Curves.easeOutCubic,
    );
  }

  /// Opens a loaded row's details, in the search and context it was loaded
  /// in.
  void _openDetails(DiscoverPlace item) {
    final results = ref.read(discoveryResultsProvider);
    final search = results.search;
    final queryContext = results.context;
    if (search == null || queryContext == null) return;
    unawaited(
      showDiscoveryPlaceDetails(
        context,
        item: item,
        search: search,
        queryContext: queryContext,
        origin: widget.origin,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = widget.query;
    final strings = AppLocalizations.of(context)!;
    final results = ref.watch(discoveryResultsProvider);
    ref.listen(
      discoverySelectionProvider.select((selection) => selection.reveals),
      (previous, next) {
        if (next != previous) unawaited(_reveal());
      },
    );
    final selection = ref.watch(discoverySelectionProvider);
    final selector = ref.read(discoverySelectionProvider.notifier);
    // A previewed place is not one of the rows, so no row is highlighted.
    final selectedId = selection.previewing ? null : selection.place?.catalogId;
    // Only the server decides what Discover covers. Rows kept from a covered
    // area say nothing about one it does not, so they give way to the notice.
    final outsideCoverage =
        results.error?.failure == DiscoveryFailure.unsupportedArea;
    final scoring = ref.watch(
      discoveryConfigProvider.select(
        (availability) => availability.config?.scoring,
      ),
    );
    final viewport = query.viewport;
    final exploration = ref.watch(discoveryCoverageProvider);
    final exploring =
        viewport != null &&
        discoveryExplorationStatus(
              viewport: viewport,
              results: results,
              exploration: exploration,
              now: ref.read(discoveryClockProvider)(),
            )?.kind ==
            DiscoveryCoverageKind.exploring;
    final notifier = ref.read(discoveryResultsProvider.notifier);
    // Rows from an earlier query stay visible, dimmed, until the committed
    // query's first page replaces them.
    final current = results.search?.query == query;
    final shownSort = results.search?.query.sort ?? query.sort;
    final title = switch (results) {
      _ when outsideCoverage => strings.discoveryThisArea,
      DiscoveryResults(search: null, error: null) =>
        strings.discoveryLoadingPlaces,
      DiscoveryResults(search: null) => strings.discoveryThisArea,
      DiscoveryResults(:final total) => strings.discoveryPlacesInView(total),
    };
    return CustomScrollView(
      controller: widget.scrollController,
      // The list is half a screen rather than a sheet that can be dragged to
      // fill one, so the default 250dp of off-screen cache is a smaller share
      // of it than it used to be. A larger one keeps the next rows built as
      // the half is scrolled, and keeps the coverage strip alive just above
      // the fold while a selected row is revealed.
      scrollCacheExtent: const ScrollCacheExtent.pixels(800),
      slivers: [
        SliverToBoxAdapter(
          child: _Header(
            title: title,
            explainer: discoverySortExplainer(context, shownSort, scoring),
            onRefresh: outsideCoverage ? null : notifier.refresh,
          ),
        ),
        if (results.loading != null && !outsideCoverage)
          SliverToBoxAdapter(
            child: LinearProgressIndicator(
              semanticsLabel: strings.discoveryLoadingPlaces,
            ),
          ),
        if (outsideCoverage)
          SliverToBoxAdapter(
            child: _Notice(message: strings.discoveryUnsupportedArea),
          )
        else ...[
          if (viewport != null)
            SliverToBoxAdapter(
              child: DiscoveryCoverageStrip(viewport: viewport),
            ),
          SliverToBoxAdapter(
            child: DiscoveryPlacePreview(origin: widget.origin),
          ),
          if (results.search == null)
            SliverToBoxAdapter(
              child: switch (results.error) {
                final error? => _failure(strings, notifier, error),
                null => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
              },
            )
          else ...[
            if (results.error case final error?)
              SliverToBoxAdapter(
                child: _failure(strings, notifier, error, stale: !current),
              ),
            if (current && results.items.isEmpty)
              SliverToBoxAdapter(
                child: _empty(
                  context,
                  strings,
                  results,
                  ref.watch(discoveryCategoryNamesProvider),
                  exploring: exploring,
                ),
              ),
            SliverList.builder(
              itemCount: results.items.length,
              itemBuilder: (context, index) {
                final item = results.items[index];
                final selected = item.catalogId == selectedId;
                return Opacity(
                  opacity: current ? 1 : 0.5,
                  child: DiscoveryPlaceRow(
                    key: selected ? _selectedRow : null,
                    item: item,
                    countryCode: results.context?.countryCode,
                    evaluatedAt: results.context!.evaluatedAt,
                    scoring: scoring,
                    origin: widget.origin,
                    selected: selected,
                    onTap: () => selector.selectRow(item),
                    onDetails: selected ? () => _openDetails(item) : null,
                    // Worst rated is where a wrong rating or a closed place
                    // is most likely to be noticed, so reporting is direct.
                    onReport:
                        results.search?.query.sort == DiscoverySort.worstRated
                        ? () => showCatalogPlaceIssue(
                            // The screen's context, which outlives a row
                            // rebuilt while the report is open.
                            this.context,
                            catalogId: item.catalogId,
                            place: item.place,
                          )
                        : null,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
              child: _Footer(results: results, origin: widget.origin),
            ),
          ],
        ],
        SliverPadding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom + 16,
          ),
        ),
      ],
    );
  }

  Widget _failure(
    AppLocalizations strings,
    DiscoveryResultsController notifier,
    DiscoveryError error, {
    bool stale = false,
  }) {
    final query = widget.query;
    final message = discoveryErrorMessage(strings, error);
    final (label, action) = switch (error.failure) {
      DiscoveryFailure.connection ||
      DiscoveryFailure.rateLimited ||
      DiscoveryFailure.unavailable => (strings.tryAgain, notifier.retry),
      DiscoveryFailure.badQuery when query.hasFilters => (
        strings.discoveryClearFilters,
        () => widget.onApply(query.withoutFilters()),
      ),
      _ => (null, null),
    };
    return _Notice(
      key: const ValueKey('discovery-failure'),
      message: message,
      detail: stale ? strings.discoveryShowingPrevious : null,
      actionLabel: label,
      onAction: action,
    );
  }

  Widget _empty(
    BuildContext context,
    AppLocalizations strings,
    DiscoveryResults results,
    DiscoveryCategoryTree? categories, {
    required bool exploring,
  }) {
    final query = widget.query;
    if (query.hasFilters) {
      return _Notice(
        key: const ValueKey('discovery-empty-filtered'),
        message: strings.discoveryEmptyFiltered,
        detail: strings.discoveryFiltersInPlay(
          discoveryFilterNames(
            context,
            query,
            categories: categories,
          ).join(' · '),
        ),
        actionLabel: strings.discoveryClearFilters,
        onAction: () => widget.onApply(query.withoutFilters()),
      );
    }
    // Nothing known here at all is a gap in what Hayer has explored, not a
    // place with nothing in it.
    if ((results.coverage?.eligibleCatalogCount ?? 0) == 0) {
      if (exploring) {
        return _Notice(
          key: const ValueKey('discovery-empty-exploring'),
          message: strings.discoveryEmptyExploring,
        );
      }
      return _Notice(
        key: const ValueKey('discovery-empty-unexplored'),
        message: strings.discoveryEmptyUnexplored,
        detail: strings.discoveryEmptyUnexploredHint,
      );
    }
    return _Notice(
      key: const ValueKey('discovery-empty-sort'),
      message: strings.discoveryEmptySort(
        discoverySortLabel(strings, query.sort),
      ),
      actionLabel: query.sort == DiscoverySort.best
          ? null
          : strings.discoveryShowBest,
      onAction: () => widget.onApply(query.withSort(DiscoverySort.best)),
    );
  }
}

String discoveryErrorMessage(AppLocalizations strings, DiscoveryError error) =>
    switch (error.failure) {
      DiscoveryFailure.connection => strings.discoveryLoadFailed,
      DiscoveryFailure.rateLimited => switch (error.retryAfter) {
        final wait? => strings.discoveryRateLimited(
          wait.inSeconds.clamp(1, 3600),
        ),
        null => strings.discoveryRateLimitedShort,
      },
      DiscoveryFailure.invalidArea => strings.discoveryInvalidArea,
      DiscoveryFailure.unsupportedArea => strings.discoveryUnsupportedArea,
      DiscoveryFailure.badQuery => strings.discoveryBadQuery,
      DiscoveryFailure.unavailable => strings.discoveryUnavailable,
    };

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.explainer,
    required this.onRefresh,
  });

  final String title;
  final String? explainer;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final heading = Semantics(
      header: true,
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
    final refresh = IconButton(
      tooltip: strings.discoveryRefresh,
      onPressed: onRefresh,
      icon: const Icon(Icons.refresh_rounded),
    );
    // At large text sizes the actions wrap under the count instead of
    // squeezing it.
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (large) ...[
                heading,
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: refresh,
                ),
              ] else
                Row(
                  children: [
                    Expanded(child: heading),
                    refresh,
                  ],
                ),
              if (explainer case final explainer?)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 12),
                  child: Text(
                    explainer,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    super.key,
    required this.message,
    this.detail,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final String? detail;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if (detail case final detail?)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(detail, style: theme.textTheme.bodyMedium),
            ),
          if (actionLabel case final label?)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FilledButton.tonal(
                onPressed: onAction,
                child: Text(label),
              ),
            ),
        ],
      ),
    );
  }
}

class _Footer extends ConsumerWidget {
  const _Footer({required this.results, required this.origin});

  final DiscoveryResults results;
  final DiscoveryPoint? origin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final notifier = ref.read(discoveryResultsProvider.notifier);
    final note = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final fetchedAt = results.fetchedAt;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: [
          if (results.loadingMore)
            const Padding(
              padding: EdgeInsets.all(12),
              child: CircularProgressIndicator(),
            )
          else if (results.moreError != null) ...[
            Text(strings.discoveryMoreFailed),
            TextButton(
              onPressed: notifier.retry,
              child: Text(strings.tryAgain),
            ),
          ] else if (results.hasMore)
            // Built only once the list is scrolled near its end.
            _LoadMoreTrigger(
              key: ValueKey((results.restarts, results.items.length)),
              onVisible: notifier.loadMore,
            ),
          if (results.items.any((item) => item.place.isStale))
            Text(
              strings.cachedPlacesWarning,
              style: note,
              textAlign: TextAlign.center,
            ),
          if (origin != null && results.items.isNotEmpty)
            Text(
              strings.discoveryStraightLineNote,
              style: note,
              textAlign: TextAlign.center,
            ),
          if (fetchedAt != null)
            Text(
              strings.discoveryCountedAt(
                DateFormat.jm(
                  Localizations.localeOf(context).toLanguageTag(),
                ).format(fetchedAt.toLocal()),
              ),
              style: note,
              textAlign: TextAlign.center,
            ),
          Text(
            strings.sourceAttribution,
            style: note,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LoadMoreTrigger extends StatefulWidget {
  const _LoadMoreTrigger({super.key, required this.onVisible});

  final Future<void> Function() onVisible;

  @override
  State<_LoadMoreTrigger> createState() => _LoadMoreTriggerState();
}

class _LoadMoreTriggerState extends State<_LoadMoreTrigger> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(widget.onVisible());
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox(height: 1);
}
