import '../generated/protocol.dart';

/// Provider-neutral place data before it becomes a session-owned snapshot.
class PlaceCandidate {
  const PlaceCandidate({
    required this.placeId,
    this.featureId,
    required this.name,
    this.primaryType,
    this.categoryIds = const [],
    this.rating,
    this.reviewCount,
    this.priceLevel,
    this.priceText,
    this.isOpen,
    this.statusText,
    this.hours = const [],
    required this.latitude,
    required this.longitude,
    this.address,
    this.formattedAddress,
    this.phoneNumber,
    this.websiteUrl,
    this.mapsUrl,
    this.photoUrls = const [],
    this.featuredReview,
    this.editorialSummary,
    this.attributions = const ['Google Maps'],
    required this.sourceCheckedAt,
    this.evidenceCategoryIds = const [],
  });

  final String placeId;
  final String? featureId;
  final String name;
  final String? primaryType;
  final List<String> categoryIds;
  final double? rating;
  final int? reviewCount;
  final int? priceLevel;
  final String? priceText;
  final bool? isOpen;
  final String? statusText;
  final List<OpeningPeriod> hours;
  final double latitude;
  final double longitude;
  final String? address;
  final String? formattedAddress;
  final String? phoneNumber;
  final String? websiteUrl;
  final String? mapsUrl;
  final List<String> photoUrls;
  final String? featuredReview;
  final String? editorialSummary;
  final List<String> attributions;
  final DateTime sourceCheckedAt;
  final List<String> evidenceCategoryIds;

  PlaceCandidate copyWith({
    List<String>? categoryIds,
    List<String>? evidenceCategoryIds,
  }) => PlaceCandidate(
    placeId: placeId,
    featureId: featureId,
    name: name,
    primaryType: primaryType,
    categoryIds: categoryIds ?? this.categoryIds,
    rating: rating,
    reviewCount: reviewCount,
    priceLevel: priceLevel,
    priceText: priceText,
    isOpen: isOpen,
    statusText: statusText,
    hours: hours,
    latitude: latitude,
    longitude: longitude,
    address: address,
    formattedAddress: formattedAddress,
    phoneNumber: phoneNumber,
    websiteUrl: websiteUrl,
    mapsUrl: mapsUrl,
    photoUrls: photoUrls,
    featuredReview: featuredReview,
    editorialSummary: editorialSummary,
    attributions: attributions,
    sourceCheckedAt: sourceCheckedAt,
    evidenceCategoryIds: evidenceCategoryIds ?? this.evidenceCategoryIds,
  );
}
