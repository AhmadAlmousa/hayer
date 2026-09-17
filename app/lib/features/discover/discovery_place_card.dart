import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../core/place_links.dart';
import '../../domain/discovery_area.dart';
import '../../l10n/generated/app_localizations.dart';
import '../saved/save_place_button.dart';
import 'discovery_config_controller.dart';
import 'discovery_place_details.dart';
import 'discovery_place_row.dart';
import 'discovery_results_controller.dart';
import 'discovery_results_sheet.dart';
import 'discovery_selection_controller.dart';

/// The selected place, shown over the map.
///
/// Tapping a pin or a row selects a place, and this is what that selection
/// looks like: what the place is, how it is rated, and the two things worth
/// doing without opening anything — directions and saving — with the full
/// details a tap away. A place the loaded pages have not reached is previewed
/// from its own context, so selecting a far pin costs one read rather than
/// every page before it.
///
/// It says the same things a row says, in its own layout rather than by
/// reusing the row: the selected place is often one of the visible rows, and
/// two widgets carrying one row's keys would be one tree with two of each.
class DiscoveryPlaceCard extends ConsumerWidget {
  const DiscoveryPlaceCard({super.key, this.origin});

  /// The permitted device location, for distances.
  final DiscoveryPoint? origin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(discoverySelectionProvider);
    final place = selection.place;
    if (place == null) return const SizedBox.shrink();
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final notifier = ref.read(discoverySelectionProvider.notifier);
    final results = ref.watch(discoveryResultsProvider);
    final scoring = ref.watch(
      discoveryConfigProvider.select(
        (availability) => availability.config?.scoring,
      ),
    );

    // The selected place is either one of the loaded rows or a previewed one.
    DiscoverPlace? item;
    for (final row in results.items) {
      if (row.catalogId == place.catalogId) {
        item = row;
        break;
      }
    }
    item ??= selection.preview?.place;
    final queryContext = results.context ?? selection.preview?.context;

    final Widget body;
    if (item != null && queryContext != null) {
      body = _Place(
        item: item,
        countryCode: queryContext.countryCode,
        evaluatedAt: queryContext.evaluatedAt,
        scoring: scoring,
        origin: origin,
        onDetails: () => _openDetails(context, ref, item!),
      );
    } else if (selection.previewError case final error?) {
      body = _Padded(
        children: [
          _Name(name: place.name),
          Text(
            error.failure == DiscoveryFailure.connection
                ? strings.discoveryPlaceLoadFailed
                : discoveryErrorMessage(strings, error),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: notifier.retryPreview,
              child: Text(strings.tryAgain),
            ),
          ),
        ],
      );
    } else {
      body = _Padded(
        children: [
          _Name(name: place.name),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            semanticsLabel: strings.discoveryLoadingPlace,
          ),
        ],
      );
    }

    return Material(
      key: const ValueKey('discovery-place-card'),
      color: colors.surface,
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              ExcludeSemantics(
                child: Icon(
                  Icons.place_rounded,
                  size: 18,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  strings.discoveryPreviewTitle,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colors.primary,
                  ),
                ),
              ),
              IconButton(
                key: const ValueKey('discovery-card-close'),
                tooltip: strings.discoveryClearSelection,
                onPressed: notifier.clear,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          // The card is bounded by the space above the sheet; at large text
          // sizes its contents scroll inside that rather than overflow it.
          Flexible(child: SingleChildScrollView(child: body)),
        ],
      ),
    );
  }

  /// Opens the full details, in the search and context the place was loaded
  /// in. A previewed place already knows where it stands, so the sheet does
  /// not ask again.
  void _openDetails(BuildContext context, WidgetRef ref, DiscoverPlace item) {
    final results = ref.read(discoveryResultsProvider);
    final selection = ref.read(discoverySelectionProvider);
    final search = results.search;
    final queryContext = results.context ?? selection.preview?.context;
    if (search == null || queryContext == null) return;
    unawaited(
      showDiscoveryPlaceDetails(
        context,
        item: item,
        search: search,
        queryContext: queryContext,
        standing: selection.preview,
        origin: origin,
      ),
    );
  }
}

/// The selected place itself: what it is, how it is rated, and what to do.
class _Place extends StatelessWidget {
  const _Place({
    required this.item,
    required this.countryCode,
    required this.evaluatedAt,
    required this.scoring,
    required this.origin,
    required this.onDetails,
  });

  final DiscoverPlace item;
  final String? countryCode;
  final DateTime evaluatedAt;
  final DiscoveryScoring? scoring;
  final DiscoveryPoint? origin;
  final VoidCallback onDetails;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final place = item.place;
    final muted = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: colors.onSurfaceVariant,
    );
    final origin = this.origin;
    final meta = [
      if (place.primaryType?.trim() case final type? when type.isNotEmpty) type,
      if (origin != null)
        strings.discoveryDistanceAway(
          formatDistance(
            context,
            discoveryStraightLineMeters(origin, (
              latitude: place.latitude,
              longitude: place.longitude,
            )).round(),
          ),
        ),
    ].join(' · ');
    final (tagText, tagColor) = discoveryTagLabel(
      context,
      item,
      evaluatedAt: evaluatedAt,
      scoring: scoring,
    );
    final rating = switch (place.rating) {
      final value? => Text(
        '★ ${NumberFormat('0.0', locale).format(value)}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: colors.primary,
        ),
      ),
      null => Text(strings.discoveryNoRating, style: muted),
    };
    final reviews = switch (place.reviewCount) {
      final count? => strings.discoveryReviewsCompact(
        NumberFormat.compact(locale: locale).format(count),
      ),
      null => null,
    };
    // At large text sizes everything stacks beside the thumbnail, so the
    // rating never squeezes the name off a narrow screen.
    final large = MediaQuery.textScalerOf(context).scale(14) > 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiscoveryPlaceThumbnail(place: place),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${formatCount(context, item.ordinal)}. ${place.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (meta.isNotEmpty)
                      Text(
                        meta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: muted,
                      ),
                    Text(
                      tagText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: tagColor,
                      ),
                    ),
                    if (large)
                      Wrap(
                        spacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          rating,
                          if (reviews != null) Text(reviews, style: muted),
                        ],
                      ),
                  ],
                ),
              ),
              if (!large) ...[
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    rating,
                    if (reviews != null)
                      Text(reviews, style: muted.copyWith(fontSize: 11)),
                  ],
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 4,
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton.icon(
                key: ValueKey('discovery-card-directions-${item.catalogId}'),
                onPressed: () =>
                    unawaited(launchPlaceNavigation(context, place)),
                icon: const Icon(Icons.directions_rounded),
                label: Text(strings.directions),
              ),
              SavePlaceButton(place: place),
              FilledButton.tonalIcon(
                // Its own key: the selected place's row carries a details
                // button too, and one finder must never mean both.
                key: ValueKey('discovery-card-details-${item.catalogId}'),
                onPressed: onDetails,
                icon: const Icon(Icons.info_outline_rounded),
                label: Text(strings.placeDetails),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Text(
    name,
    style: Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
  );
}

class _Padded extends StatelessWidget {
  const _Padded({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}
