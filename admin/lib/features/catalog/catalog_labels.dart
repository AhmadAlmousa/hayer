import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';

// The dashboard is English-only, so dates use intl's default locale data
// rather than the widget locale.
String formatCatalogDate(DateTime value) =>
    DateFormat.yMd().add_Hm().format(value.toLocal());

/// How long before [now] [value] was, in the coarsest unit that reads well.
String describeCatalogAge(DateTime value, DateTime now) {
  final age = now.difference(value);
  if (age.inMinutes < 1) return 'just now';
  if (age.inMinutes < 60) return '${age.inMinutes} min ago';
  if (age.inHours < 48) return '${age.inHours} h ago';
  return '${age.inDays} days ago';
}

String catalogSortLabel(AdminCatalogSort sort) => switch (sort) {
  AdminCatalogSort.lastSeen => 'Last seen in results',
  AdminCatalogSort.firstSeen => 'First cached',
  AdminCatalogSort.sourceChecked => 'Cached',
  AdminCatalogSort.name => 'Name',
  AdminCatalogSort.rating => 'Rating',
  AdminCatalogSort.reviewCount => 'Review count',
};

String catalogStatusLabel(AdminCatalogStatus status) => switch (status) {
  AdminCatalogStatus.active => 'Active',
  AdminCatalogStatus.quarantined => 'Quarantined',
  AdminCatalogStatus.all => 'All',
};

String catalogFreshnessLabel(AdminCatalogFreshness freshness) =>
    switch (freshness) {
      AdminCatalogFreshness.any => 'Any age',
      AdminCatalogFreshness.fresh => 'Fresh',
      AdminCatalogFreshness.stale => 'Stale',
    };

String catalogLifecycleLabel(AdminCatalogLifecycle? lifecycle) =>
    switch (lifecycle) {
      null => 'Any closure',
      AdminCatalogLifecycle.notClosed => 'Not marked closed',
      AdminCatalogLifecycle.temporarilyClosed => 'Temporarily closed',
      AdminCatalogLifecycle.permanentlyClosed => 'Permanently closed',
    };

String catalogFieldLabel(AdminCatalogField field) => switch (field) {
  AdminCatalogField.photos => 'photos',
  AdminCatalogField.hours => 'hours',
  AdminCatalogField.phone => 'phone',
  AdminCatalogField.website => 'website',
  AdminCatalogField.price => 'price',
  AdminCatalogField.summary => 'summary',
};

String catalogRefreshStateLabel(PlaceDetailRefreshState state) =>
    switch (state) {
      PlaceDetailRefreshState.notNeeded => 'Not needed',
      PlaceDetailRefreshState.refreshing => 'Refreshing now',
      PlaceDetailRefreshState.succeeded => 'Succeeded',
      PlaceDetailRefreshState.noMatch => 'No exact match',
      PlaceDetailRefreshState.failed => 'Failed',
      PlaceDetailRefreshState.budgetExceeded => 'Provider budget exceeded',
    };

String catalogIssueTypeLabel(PoiIssueType type) => switch (type) {
  PoiIssueType.wrongCategory => 'Wrong category',
  PoiIssueType.closed => 'Closed',
  PoiIssueType.wrongLocation => 'Wrong location',
  PoiIssueType.duplicate => 'Duplicate',
  PoiIssueType.misleadingPhoto => 'Misleading photo',
  PoiIssueType.other => 'Other',
};

String catalogIssueStatusLabel(PoiIssueStatus status) => switch (status) {
  PoiIssueStatus.open => 'Open',
  PoiIssueStatus.inReview => 'In review',
  PoiIssueStatus.resolved => 'Resolved',
  PoiIssueStatus.dismissed => 'Dismissed',
};

String catalogPriceLabel(int level) => level == 0 ? 'Free' : r'$' * level;

/// The place's type, rating, price and country on one line.
String catalogPlaceSummary(AdminCatalogPlace place) {
  final rating = place.rating;
  final reviews = place.reviewCount;
  final price = place.priceLevel;
  return [
    place.primaryType ?? 'Unknown type',
    if (rating != null)
      '★ ${rating.toStringAsFixed(1)}'
          '${reviews == null ? '' : ' (${NumberFormat.decimalPattern().format(reviews)})'}',
    if (price != null) catalogPriceLabel(price),
    place.countryCode,
  ].join(' · ');
}

/// When the place was last cached from its source, first cached, and last
/// returned by a search or harvest.
String catalogCacheLine(AdminCatalogPlace place, DateTime now) =>
    'Cached ${formatCatalogDate(place.sourceCheckedAt)} '
    '(${describeCatalogAge(place.sourceCheckedAt, now)}) · '
    'first cached ${formatCatalogDate(place.firstSeenAt)} · '
    'last seen in results ${formatCatalogDate(place.lastSeenAt)}';
