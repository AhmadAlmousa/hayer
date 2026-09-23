import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/display_formatters.dart';
import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';

String discoverySortLabel(AppLocalizations strings, DiscoverySort sort) =>
    switch (sort) {
      DiscoverySort.best => strings.discoverySortBest,
      DiscoverySort.topRated => strings.discoverySortTopRated,
      DiscoverySort.mostReviewed => strings.discoverySortMostReviewed,
      DiscoverySort.hiddenGems => strings.discoverySortHiddenGems,
      DiscoverySort.worstRated => strings.discoverySortWorstRated,
      DiscoverySort.recentlyDiscovered => strings.discoverySortRecent,
      DiscoverySort.distanceArea => strings.discoverySortDistanceArea,
      DiscoverySort.distanceCurrent => strings.discoverySortDistanceCurrent,
    };

/// The sentence under the result count saying how [sort] ranks places.
///
/// Thresholds come from the server's scoring policy, so the sentence changes
/// when the policy does. Null when the sentence needs a threshold and no
/// policy is known.
String? discoverySortExplainer(
  BuildContext context,
  DiscoverySort sort,
  DiscoveryScoring? scoring,
) {
  final strings = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context).toLanguageTag();
  return switch (sort) {
    DiscoverySort.best => strings.discoveryExplainBest,
    DiscoverySort.topRated => switch (scoring?.topRatedMinimumReviews) {
      final minimum? when minimum > 1 =>
        strings.discoveryExplainTopRatedMinimum(formatCount(context, minimum)),
      _ => strings.discoveryExplainTopRated,
    },
    DiscoverySort.mostReviewed => strings.discoveryExplainMostReviewed,
    DiscoverySort.hiddenGems =>
      scoring == null
          ? null
          : strings.discoveryExplainHiddenGems(
              NumberFormat('0.0#', locale).format(scoring.gemMinimumRating),
              formatCount(context, scoring.gemMaximumReviewsExclusive),
            ),
    DiscoverySort.worstRated => switch (scoring?.worstRatedMinimumReviews) {
      final minimum? when minimum > 1 =>
        strings.discoveryExplainWorstRatedMinimum(
          formatCount(context, minimum),
        ),
      _ => strings.discoveryExplainWorstRated,
    },
    DiscoverySort.recentlyDiscovered => strings.discoveryExplainRecent,
    DiscoverySort.distanceArea => strings.discoveryExplainDistanceArea,
    DiscoverySort.distanceCurrent => strings.discoveryExplainDistanceCurrent,
  };
}
