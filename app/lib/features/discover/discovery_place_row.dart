import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../core/gcc_currency_symbol.dart';
import '../../core/place_photo_cache.dart';
import '../../domain/discovery_area.dart';
import '../../l10n/generated/app_localizations.dart';
import '../setup/setup_data.dart';
import '../saved/save_place_button.dart';

/// Below this known rating a row warns that a place is rated poorly.
const discoveryLowRating = 4.0;

/// Above this many reviews a row calls a place out as very popular.
const discoveryManyReviews = 20000;

enum DiscoveryTagKind {
  hiddenGem,
  ratedBelow,
  manyReviews,
  openNow,
  closedNow,
  hoursUnknown,
}

typedef DiscoveryTag = ({DiscoveryTagKind kind, int? value});

/// The one thing a result row says about a place, by priority: a hidden gem,
/// a low rating, a very high review count, then its hours at query time.
DiscoveryTag discoveryTagFor(DiscoverPlace item) {
  final place = item.place;
  if (item.hiddenGem) {
    return (kind: DiscoveryTagKind.hiddenGem, value: place.reviewCount);
  }
  if (place.rating case final rating? when rating < discoveryLowRating) {
    return (kind: DiscoveryTagKind.ratedBelow, value: null);
  }
  if (place.reviewCount case final count? when count > discoveryManyReviews) {
    return (kind: DiscoveryTagKind.manyReviews, value: count);
  }
  return switch (item.openNow) {
    true => (kind: DiscoveryTagKind.openNow, value: null),
    false => (kind: DiscoveryTagKind.closedNow, value: null),
    null => (kind: DiscoveryTagKind.hoursUnknown, value: null),
  };
}

/// One ranked Discover result.
class DiscoveryPlaceRow extends StatelessWidget {
  const DiscoveryPlaceRow({
    super.key,
    required this.item,
    required this.countryCode,
    this.origin,
    this.selected = false,
    this.onTap,
    this.onReport,
  });

  final DiscoverPlace item;

  /// The searched area's country, which sets the price symbol.
  final String? countryCode;

  /// The permitted device location distances are measured from, if any.
  final DiscoveryPoint? origin;

  /// Whether this place is the one selected on the map.
  final bool selected;
  final VoidCallback? onTap;

  /// Reports a problem with the place's data, from a button beside it when
  /// set.
  final VoidCallback? onReport;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: Material(
      color: selected
          ? Theme.of(context).colorScheme.primaryContainer
          : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: _content(context),
      ),
    ),
  );

  Widget _content(BuildContext context) {
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
    final hasPrice =
        place.priceLevel != null || (place.priceText?.isNotEmpty ?? false);
    final price = hasPrice
        ? GccPriceLevel(
            countryCode: countryCode,
            level: place.priceLevel,
            fallbackText: place.priceText,
            color: colors.onSurfaceVariant,
            size: 12,
          )
        : null;
    final (tagText, tagColor) = discoveryTagLabel(context, item);
    final rankedName = '${formatCount(context, item.ordinal)}. ${place.name}';
    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      fontSize: 15,
      fontWeight: FontWeight.w900,
    );
    final tagStyle = TextStyle(
      fontSize: 11.5,
      fontWeight: FontWeight.w700,
      color: tagColor,
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
    final report = switch (onReport) {
      final onReport? => IconButton(
        key: ValueKey('discovery-report-${item.catalogId}'),
        tooltip: strings.reportDataIssue,
        onPressed: onReport,
        icon: const Icon(Icons.outlined_flag_rounded),
      ),
      null => null,
    };
    if (MediaQuery.textScalerOf(context).scale(14) > 20) {
      // At large text sizes everything stacks beside the thumbnail and wraps,
      // so nothing is pushed off a narrow screen.
      return Padding(
        key: ValueKey('discovery-row-${item.catalogId}'),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DiscoveryPlaceThumbnail(place: place),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rankedName, style: titleStyle),
                  if (meta.isNotEmpty || price != null)
                    Wrap(
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (meta.isNotEmpty) Text(meta, style: muted),
                        ?price,
                      ],
                    ),
                  Text(tagText, style: tagStyle),
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
            SavePlaceButton(place: place, iconOnly: true),
            ?report,
          ],
        ),
      );
    }
    return Padding(
      key: ValueKey('discovery-row-${item.catalogId}'),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          DiscoveryPlaceThumbnail(place: place),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rankedName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
                if (meta.isNotEmpty || price != null)
                  Row(
                    children: [
                      if (meta.isNotEmpty)
                        Flexible(
                          child: Text(
                            meta,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: muted,
                          ),
                        ),
                      if (meta.isNotEmpty && price != null)
                        Text(' · ', style: muted),
                      ?price,
                    ],
                  ),
                Text(
                  tagText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: tagStyle,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              rating,
              if (reviews != null)
                Text(reviews, style: muted.copyWith(fontSize: 11)),
            ],
          ),
          SavePlaceButton(place: place, iconOnly: true),
          ?report,
        ],
      ),
    );
  }
}

/// The one line a place is tagged with, and the colour it is written in.
///
/// The row and the map's card both say the same thing about a place, so they
/// say it from here.
(String, Color) discoveryTagLabel(
  BuildContext context,
  DiscoverPlace item,
) {
  final strings = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context).toLanguageTag();
  final colors = Theme.of(context).colorScheme;
  final tag = discoveryTagFor(item);
  // Scheme colours rather than the design's green and coral, which are too
  // faint for text this small on a light surface.
  return switch (tag) {
    (kind: DiscoveryTagKind.hiddenGem, value: final count?) => (
      strings.discoveryTagHiddenGem(formatCount(context, count)),
      colors.primary,
    ),
    (kind: DiscoveryTagKind.hiddenGem, value: _) => (
      strings.discoveryTagHiddenGemPlain,
      colors.primary,
    ),
    (kind: DiscoveryTagKind.ratedBelow, value: _) => (
      strings.discoveryTagRatedBelow(
        NumberFormat('0.0', locale).format(discoveryLowRating),
      ),
      colors.error,
    ),
    (kind: DiscoveryTagKind.manyReviews, :final value) => (
      strings.discoveryTagManyReviews(
        NumberFormat.compact(locale: locale).format(value ?? 0),
      ),
      colors.onSurfaceVariant,
    ),
    (kind: DiscoveryTagKind.openNow, value: _) => (
      strings.openNow,
      colors.primary,
    ),
    (kind: DiscoveryTagKind.closedNow, value: _) => (
      strings.closedNow,
      colors.error,
    ),
    (kind: DiscoveryTagKind.hoursUnknown, value: _) => (
      strings.unknownHours,
      colors.onSurfaceVariant,
    ),
  };
}

/// Each swipe category and category option by id, pointing at its category.
final _categoryOf = {
  for (final category in setupCategories) ...{
    category.id: category,
    for (final option in category.subcategories.keys) option: category,
  },
};

/// A place photo, with its category emoji when an image is unavailable.
class DiscoveryPlaceThumbnail extends ConsumerWidget {
  const DiscoveryPlaceThumbnail({super.key, required this.place});

  final PlaceSnapshot place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    SetupCategory? category;
    var emoji = '📍';
    for (final id in place.categoryIds) {
      if (_categoryOf[id] case final match?) {
        category = match;
        emoji = match.subcategories[id]?.emoji ?? match.emoji;
        break;
      }
    }
    final fallback = Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: switch (category?.id) {
          'restaurant' => colors.primaryContainer,
          'cafe' => colors.secondaryContainer,
          _ => colors.surfaceContainerHighest,
        },
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 26),
        textScaler: TextScaler.noScaling,
      ),
    );
    if (place.photoUrls.isEmpty) return ExcludeSemantics(child: fallback);
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          imageUrl: place.photoUrls.first,
          cacheManager: ref.read(placePhotoCacheProvider),
          width: 56,
          height: 56,
          memCacheWidth: (56 * MediaQuery.devicePixelRatioOf(context)).round(),
          fit: BoxFit.cover,
          placeholder: (_, _) => fallback,
          errorWidget: (_, _, _) => fallback,
        ),
      ),
    );
  }
}
