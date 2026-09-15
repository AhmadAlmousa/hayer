import '../generated/protocol.dart';

/// How a stored place snapshot is presented by Swipe and Discover alike.
abstract final class PlaceDetailView {
  /// The snapshot as of its source check. A stale one hides the fields that
  /// go out of date, exactly as Swipe's `PlaceSearchPolicy` does for a stale
  /// candidate, so both modes show the same place the same way.
  static PlaceSnapshot present(PlaceSnapshot place, {required bool fresh}) =>
      fresh ? place.copyWith(isStale: false) : stale(place);

  static PlaceSnapshot stale(PlaceSnapshot place) => place.copyWith(
    rating: null,
    reviewCount: null,
    priceLevel: null,
    priceText: null,
    isOpen: null,
    statusText: null,
    hours: const [],
    phoneNumber: null,
    featuredReview: null,
    isStale: true,
  );

  /// The optional detail fields [place] cannot show.
  static List<PlaceDetailField> missingFields(PlaceSnapshot place) => [
    if (place.photoUrls.isEmpty) PlaceDetailField.photos,
    if (place.hours.isEmpty) PlaceDetailField.hours,
    if (_blank(place.phoneNumber)) PlaceDetailField.phone,
    if (_blank(place.websiteUrl)) PlaceDetailField.website,
    if (place.priceLevel == null && _blank(place.priceText))
      PlaceDetailField.price,
    if (_blank(place.editorialSummary)) PlaceDetailField.description,
  ];

  static bool _blank(String? value) => value == null || value.trim().isEmpty;
}
