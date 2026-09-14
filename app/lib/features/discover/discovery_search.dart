import 'package:hayer_client/hayer_client.dart';

import '../../domain/discovery_url_query.dart';

/// A committed Discover query resolved to a request the server can answer.
///
/// The link carries the viewport, sort and filters. Neither the link nor the
/// request names a country: the server resolves it from the viewport and
/// returns it in the first page's [DiscoverQueryContext].
final class DiscoverySearch {
  DiscoverySearch({required this.query})
    : assert(query.viewport != null, 'a search needs a committed viewport');

  final DiscoveryUrlQuery query;

  DiscoveryViewport get viewport => query.viewport!;

  /// The request for this search. The app's link enums and the protocol's
  /// share names, so they map by name; their link spellings never reach the
  /// server.
  DiscoverQuery toWire() => DiscoverQuery(
    viewport: DiscoverViewport(
      south: viewport.south,
      west: viewport.west,
      north: viewport.north,
      east: viewport.east,
    ),
    sort: DiscoverSort.values.byName(query.sort.name),
    categoryIds: query.categoryIds,
    reviewBands: [
      for (final band in query.reviewBands)
        DiscoverReviewBand.values.byName(band.name),
    ],
    exactPriceLevel: query.priceLevel,
    minimumRating: query.minimumRating?.value,
    hoursWindows: [
      for (final window in query.hoursWindows)
        DiscoverHoursWindow.values.byName(window.name),
    ],
    text: query.text,
    completeness: [
      for (final requirement in query.completeness)
        DiscoverCompleteness.values.byName(requirement.name),
    ],
  );

  @override
  bool operator ==(Object other) =>
      other is DiscoverySearch && other.query == query;

  @override
  int get hashCode => query.hashCode;

  @override
  String toString() => 'DiscoverySearch(${query.location})';
}
