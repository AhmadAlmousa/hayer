import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/discovery_area.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';
import 'discovery_config_controller.dart';
import 'discovery_place_row.dart';
import 'discovery_results_controller.dart';
import 'discovery_sort_text.dart';

/// The sheet heights, as parts of the space below the status bar, that the
/// results rest at over the map.
const discoverySheetPeek = 0.2;
const discoverySheetHalf = 0.5;

/// The ranked Discover results, in a sheet dragged over the map.
class DiscoveryResultsSheet extends ConsumerWidget {
  const DiscoveryResultsSheet({
    super.key,
    required this.query,
    required this.scrollController,
    required this.sheetController,
    required this.pending,
    required this.outsideCoverage,
    required this.origin,
    required this.onApply,
  });

  /// The committed query.
  final DiscoveryUrlQuery query;
  final ScrollController scrollController;
  final DraggableScrollableController sheetController;

  /// Whether the camera has moved away from the committed area, so the
  /// results describe the previous one.
  final bool pending;

  /// Whether the committed area is outside every supported country, in which
  /// case nothing was asked of the server.
  final bool outsideCoverage;

  /// The permitted device location, for distances.
  final DiscoveryPoint? origin;

  /// Commits a changed query.
  final ValueChanged<DiscoveryUrlQuery> onApply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final results = ref.watch(discoveryResultsProvider);
    final scoring = ref.watch(
      discoveryConfigProvider.select(
        (availability) => availability.config?.scoring,
      ),
    );
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
      DiscoveryResults(:final total) when pending =>
        strings.discoveryPlacesInPreviousArea(total),
      DiscoveryResults(:final total) => strings.discoveryPlacesInView(total),
    };
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: _Header(
            title: title,
            explainer: discoverySortExplainer(context, shownSort, scoring),
            sheetController: sheetController,
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
        else if (results.search == null) ...[
          if (results.error case final error?)
            SliverToBoxAdapter(child: _failure(strings, notifier, error))
          else
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ] else ...[
          if (results.error case final error?)
            SliverToBoxAdapter(
              child: _failure(strings, notifier, error, stale: !current),
            ),
          if (current && results.items.isEmpty)
            SliverToBoxAdapter(child: _empty(strings, results)),
          SliverList.builder(
            itemCount: results.items.length,
            itemBuilder: (context, index) => Opacity(
              opacity: current ? 1 : 0.5,
              child: DiscoveryPlaceRow(
                item: results.items[index],
                countryCode: results.search?.countryCode,
                evaluatedAt: results.context!.evaluatedAt,
                scoring: scoring,
                origin: origin,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _Footer(results: results, origin: origin),
          ),
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
    final message = discoveryErrorMessage(strings, error);
    final (label, action) = switch (error.failure) {
      DiscoveryFailure.connection ||
      DiscoveryFailure.rateLimited ||
      DiscoveryFailure.unavailable => (strings.tryAgain, notifier.retry),
      DiscoveryFailure.badQuery when query.hasFilters => (
        strings.discoveryClearFilters,
        () => onApply(query.withoutFilters()),
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

  Widget _empty(AppLocalizations strings, DiscoveryResults results) {
    if (query.hasFilters) {
      return _Notice(
        key: const ValueKey('discovery-empty-filtered'),
        message: strings.discoveryEmptyFiltered,
        actionLabel: strings.discoveryClearFilters,
        onAction: () => onApply(query.withoutFilters()),
      );
    }
    // Nothing known here at all is a gap in what Hayer has explored, not a
    // place with nothing in it.
    if ((results.coverage?.eligibleCatalogCount ?? 0) == 0) {
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
      onAction: () => onApply(query.withSort(DiscoverySort.best)),
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
    required this.sheetController,
    required this.onRefresh,
  });

  final String title;
  final String? explainer;
  final DraggableScrollableController sheetController;
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
    final toggle = ListenableBuilder(
      listenable: sheetController,
      builder: (context, _) {
        final expanded =
            sheetController.isAttached && sheetController.size > 0.9;
        return OutlinedButton(
          key: const ValueKey('discovery-sheet-toggle'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            visualDensity: VisualDensity.compact,
          ),
          onPressed: () => unawaited(
            sheetController.animateTo(
              expanded ? discoverySheetHalf : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            ),
          ),
          child: Text(
            expanded ? strings.discoveryShowMap : strings.discoveryFullList,
          ),
        );
      },
    );
    // At large text sizes the actions wrap under the count instead of
    // squeezing it.
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 6),
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (large) ...[
                heading,
                Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [refresh, toggle],
                ),
              ] else
                Row(
                  children: [
                    Expanded(child: heading),
                    refresh,
                    toggle,
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
