import '../generated/protocol.dart';
import 'place_candidate.dart';

/// Turns raw provider candidates into catalog observations for callers that
/// persist without Swipe's selection: detail refreshes and harvests.
abstract final class PlaceObservation {
  static bool isValid(PlaceCandidate place) =>
      place.placeId.trim().isNotEmpty &&
      place.placeId.length <= 500 &&
      place.name.trim().isNotEmpty &&
      place.latitude.isFinite &&
      place.longitude.isFinite &&
      place.latitude.abs() <= 90 &&
      place.longitude.abs() <= 180;

  /// A fresh snapshot of [place] observed at [observedAt]. [categoryIds]
  /// carries a Swipe query's category only for a genuine Swipe query result.
  static PlaceSnapshot snapshot(
    PlaceCandidate place,
    DateTime observedAt, {
    List<String> categoryIds = const [],
  }) => PlaceSnapshot(
    placeId: place.placeId,
    featureId: place.featureId,
    name: place.name,
    primaryType: place.primaryType,
    categoryIds: categoryIds,
    rating: place.rating,
    reviewCount: place.reviewCount,
    priceLevel: place.priceLevel,
    priceText: place.priceText,
    isOpen: place.isOpen,
    statusText: place.statusText,
    hours: place.hours,
    distanceMeters: 0,
    latitude: place.latitude,
    longitude: place.longitude,
    address: place.address,
    formattedAddress: place.formattedAddress,
    phoneNumber: place.phoneNumber,
    websiteUrl: place.websiteUrl,
    mapsUrl: place.mapsUrl,
    photoUrls: place.photoUrls,
    featuredReview: place.featuredReview,
    editorialSummary: place.editorialSummary,
    attributions: place.attributions,
    sourceCheckedAt: observedAt,
    isStale: false,
  );
}
