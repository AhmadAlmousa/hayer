import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_category_tree.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';

/// A review band's exact bounds, such as "50–99" or "1,000+".
String discoveryReviewBandLabel(
  BuildContext context,
  DiscoveryReviewBand band,
) {
  final strings = AppLocalizations.of(context)!;
  final from = formatCount(context, band.minimum);
  return switch (band.maximum) {
    final maximum? => strings.discoveryReviewBandRange(
      from,
      formatCount(context, maximum),
    ),
    null => strings.discoveryReviewBandOpen(from),
  };
}

String discoveryRatingLabel(
  BuildContext context,
  DiscoveryMinimumRating rating,
) => AppLocalizations.of(context)!.discoveryRatingAtLeast(
  NumberFormat(
    '0.#',
    Localizations.localeOf(context).toLanguageTag(),
  ).format(rating.value),
);

String discoveryHoursLabel(
  AppLocalizations strings,
  DiscoveryHoursWindow window,
) => switch (window) {
  DiscoveryHoursWindow.openNow => strings.discoveryHoursOpenNow,
  DiscoveryHoursWindow.openLate => strings.discoveryHoursOpenLate,
  DiscoveryHoursWindow.breakfast => strings.discoveryHoursBreakfast,
  DiscoveryHoursWindow.openFriday => strings.discoveryHoursFriday,
};

String discoveryCompletenessLabel(
  AppLocalizations strings,
  DiscoveryCompleteness requirement,
) => switch (requirement) {
  DiscoveryCompleteness.photos => strings.discoveryHasPhotos,
  DiscoveryCompleteness.hours => strings.discoveryHasHours,
  DiscoveryCompleteness.contact => strings.discoveryHasContact,
  DiscoveryCompleteness.price => strings.discoveryHasPrice,
};

/// Category [id]'s name in the app's language: its label in [tree], Other,
/// or a generic name while the tree is not known.
String discoveryCategoryName(
  BuildContext context,
  String id,
  DiscoveryCategoryTree? tree,
) {
  final strings = AppLocalizations.of(context)!;
  if (tree != null && id == tree.otherId) return strings.discoveryCategoryOther;
  return switch (tree?.nodeFor(id)) {
    final node? => discoveryCategoryLabel(
      node,
      Localizations.localeOf(context).languageCode,
    ),
    null => strings.discoveryCategoryFallback,
  };
}

/// Each filter [query] applies, named briefly, so an empty result can say
/// which filters left nothing.
List<String> discoveryFilterNames(
  BuildContext context,
  DiscoveryUrlQuery query, {
  DiscoveryCategoryTree? categories,
}) {
  final strings = AppLocalizations.of(context)!;
  return [
    for (final id in query.categoryIds)
      discoveryCategoryName(context, id, categories),
    if (query.text.isNotEmpty) strings.discoveryTextQuery(query.text),
    for (final band in query.reviewBands)
      strings.discoveryReviewsCompact(discoveryReviewBandLabel(context, band)),
    if (query.priceLevel case final level?)
      strings.discoveryPriceLevelName(formatCount(context, level)),
    if (query.minimumRating case final rating?)
      discoveryRatingLabel(context, rating),
    for (final window in query.hoursWindows)
      discoveryHoursLabel(strings, window),
    for (final requirement in query.completeness)
      discoveryCompletenessLabel(strings, requirement),
  ];
}
