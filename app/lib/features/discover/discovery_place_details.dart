import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../core/providers.dart';
import '../../core/widgets/place_details_sheet.dart';
import '../../domain/discovery_area.dart';
import '../../domain/discovery_category_tree.dart';
import '../../l10n/generated/app_localizations.dart';
import '../report/report_place_issue_sheet.dart';
import '../saved/save_place_button.dart';
import 'discovery_search.dart';
import 'discovery_sort_text.dart';
import 'discovery_taxonomy_provider.dart';

/// Opens the shared details sheet for a Discover result, outside any session.
///
/// [standing] is where the place stands in [search] when that is already
/// known, as it is for a place previewed from the map; otherwise the sheet
/// asks. Reports go to the catalog by the place's catalog id.
Future<void> showDiscoveryPlaceDetails(
  BuildContext context, {
  required DiscoverPlace item,
  required DiscoverySearch search,
  required DiscoverQueryContext queryContext,
  DiscoverPlaceContext? standing,
  DiscoveryPoint? origin,
}) {
  final place = item.place;
  // The row or preview that opened the sheet can go while the sheet is open,
  // as results refresh; the navigator stays to open a report and give thanks.
  final host = Navigator.of(context).context;
  return showPlaceDetailsSheet(
    host,
    place: place,
    countryCode: queryContext.countryCode,
    mode: DiscoveryPlaceDetails(
      provider: item.provider,
      firstSeenAt: item.firstSeenAt,
      hiddenGem: item.hiddenGem,
      openNow: item.openNow,
      distanceMeters: origin == null
          ? null
          : discoveryStraightLineMeters(origin, (
              latitude: place.latitude,
              longitude: place.longitude,
            )).round(),
      standing: DiscoveryPlaceStanding(
        item: item,
        search: search,
        queryContext: queryContext,
        known: standing,
      ),
    ),
    saveButton: (place) => SavePlaceButton(place: place, prominent: true),
    onReportIssue: () => showCatalogPlaceIssue(
      context,
      catalogId: item.catalogId,
      place: place,
    ),
  );
}

/// Where a Discover result stands among every place matching its search, not
/// just the loaded rows: its rank under the chosen sort, how its rating
/// compares with the others, and where that rating falls in the view.
class DiscoveryPlaceStanding extends ConsumerStatefulWidget {
  const DiscoveryPlaceStanding({
    super.key,
    required this.item,
    required this.search,
    required this.queryContext,
    this.known,
  });

  final DiscoverPlace item;
  final DiscoverySearch search;
  final DiscoverQueryContext queryContext;

  /// The standing already fetched for this place in this search, if any.
  final DiscoverPlaceContext? known;

  @override
  ConsumerState<DiscoveryPlaceStanding> createState() =>
      _DiscoveryPlaceStandingState();
}

class _DiscoveryPlaceStandingState
    extends ConsumerState<DiscoveryPlaceStanding> {
  DiscoverPlaceContext? _standing;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _standing = widget.known;
    if (_standing == null) unawaited(_load());
  }

  Future<void> _load() async {
    final item = widget.item;
    try {
      final standing = await ref
          .read(discoveryRepositoryProvider)
          .placeContext(
            identity: PoiIdentity(
              provider: item.provider,
              placeId: item.place.placeId,
            ),
            query: widget.search.toWire(),
            context: widget.queryContext,
          );
      if (mounted) setState(() => _standing = standing);
    } catch (error) {
      if (mounted) setState(() => _error = error);
    }
  }

  void _retry() {
    setState(() => _error = null);
    unawaited(_load());
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final standing = _standing;
    final error = _error;
    final Widget child;
    if (standing != null && standing.eligible) {
      child = _standingDetails(context, strings, standing);
    } else if (standing != null) {
      child = Text(strings.discoveryStandingIneligible);
    } else if (error is ApiException && error.code == 'query_changed') {
      // The same question would get the same answer; the results behind
      // the sheet are already starting over.
      child = Text(strings.discoveryStandingChanged);
    } else if (error != null) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.discoveryStandingFailed),
          TextButton(onPressed: _retry, child: Text(strings.tryAgain)),
        ],
      );
    } else {
      child = LinearProgressIndicator(
        semanticsLabel: strings.discoveryStandingLoading,
      );
    }
    return Card.filled(
      key: const ValueKey('discovery-standing'),
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _standingDetails(
    BuildContext context,
    AppLocalizations strings,
    DiscoverPlaceContext standing,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final population = _population(context, strings, standing);
    final percentile = _percentileSentence(
      context,
      strings,
      standing.ratingPercentile,
      population,
    );
    final distribution = standing.ratingDistribution;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (standing.ordinal case final ordinal?) ...[
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                strings.discoveryStandingRank(formatCount(context, ordinal)),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
              Text(
                population == null
                    ? strings.discoveryStandingOfPlaces(standing.total)
                    : strings.discoveryStandingOfCategory(
                        standing.total,
                        population,
                      ),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Text(
            strings.discoveryStandingSortedBy(
              discoverySortLabel(strings, widget.search.query.sort),
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
        if (distribution.isNotEmpty || percentile != null) ...[
          if (standing.ordinal != null) const SizedBox(height: 14),
          Text(
            strings.discoveryStandingHeading,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if (distribution.isNotEmpty) ...[
            const SizedBox(height: 8),
            DiscoveryRatingStrip(
              buckets: distribution,
              rating: widget.item.place.rating,
            ),
          ],
          if (percentile != null) ...[
            const SizedBox(height: 6),
            Text(percentile),
          ],
        ],
      ],
    );
  }

  /// The category the compared places are, when the server says they are
  /// one; otherwise they are described simply as places.
  String? _population(
    BuildContext context,
    AppLocalizations strings,
    DiscoverPlaceContext standing,
  ) {
    final id = standing.populationCategoryId;
    if (id == null) return null;
    final tree = ref.watch(discoveryCategoryNamesProvider);
    if (tree == null) return null;
    if (id == tree.otherId) return strings.discoveryCategoryOther;
    return switch (tree.nodeFor(id)) {
      final node? => discoveryCategoryLabel(
        node,
        Localizations.localeOf(context).languageCode,
      ),
      null => null,
    };
  }

  String? _percentileSentence(
    BuildContext context,
    AppLocalizations strings,
    double? percentile,
    String? population,
  ) {
    if (percentile == null) return null;
    if (percentile <= 0) {
      return population == null
          ? strings.discoveryPercentileNonePlaces
          : strings.discoveryPercentileNoneCategory(population);
    }
    final percent = discoveryPercentileText(
      percentile,
      Localizations.localeOf(context).toLanguageTag(),
    );
    return population == null
        ? strings.discoveryPercentilePlaces(percent)
        : strings.discoveryPercentileCategory(percent, population);
  }
}

/// [percentile], from 0 to 100, as a percentage for [locale].
///
/// Rounded down, so a place is never said to beat more places than it does:
/// to whole percents from one percent, and to tenths below it, so a place
/// above a few of many peers does not read as above none.
String discoveryPercentileText(double percentile, String locale) {
  final value = percentile.clamp(0, 100).toDouble();
  final shown = value >= 1
      ? value.floorToDouble()
      : (value * 10).floorToDouble() / 10;
  return (NumberFormat.percentPattern(
    locale,
  )..maximumFractionDigits = 1).format(shown / 100);
}

/// The index of the bucket [rating] falls in, or -1 when none holds it.
///
/// Each bucket includes its minimum and excludes its maximum, except that
/// the top of the last bucket, a perfect rating, belongs to it.
int discoveryRatingBucketIndex(
  List<DiscoveryRatingBucket> buckets,
  double rating,
) {
  for (var index = 0; index < buckets.length; index++) {
    final bucket = buckets[index];
    if (rating >= bucket.minimumInclusive && rating < bucket.maximumExclusive) {
      return index;
    }
  }
  if (buckets.isNotEmpty && rating == buckets.last.maximumExclusive) {
    return buckets.length - 1;
  }
  return -1;
}

/// How ratings are spread across a search, with the place's own highlighted.
class DiscoveryRatingStrip extends StatelessWidget {
  const DiscoveryRatingStrip({
    super.key,
    required this.buckets,
    required this.rating,
  });

  final List<DiscoveryRatingBucket> buckets;

  /// The place's rating, whose bucket is highlighted.
  final double? rating;

  static const _height = 44.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final most = buckets.fold(
      0,
      (most, bucket) => math.max(most, bucket.count),
    );
    final own = switch (rating) {
      final rating? => discoveryRatingBucketIndex(buckets, rating),
      null => -1,
    };
    final label = NumberFormat('0.0', locale);
    final axis = theme.textTheme.bodySmall?.copyWith(
      color: colors.onSurfaceVariant,
    );
    // The sentence beside the strip says what it shows.
    return ExcludeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: _height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var index = 0; index < buckets.length; index++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        key: ValueKey(
                          index == own
                              ? 'discovery-rating-bucket-own'
                              : 'discovery-rating-bucket-$index',
                        ),
                        height: most == 0
                            ? 4
                            : 4 + (_height - 4) * buckets[index].count / most,
                        decoration: BoxDecoration(
                          color: index == own
                              ? colors.primary
                              : colors.outlineVariant,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(label.format(buckets.first.minimumInclusive), style: axis),
              const Spacer(),
              Text(label.format(buckets.last.maximumExclusive), style: axis),
            ],
          ),
        ],
      ),
    );
  }
}
