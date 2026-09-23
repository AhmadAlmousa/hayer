/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import 'opening_period.dart' as _iutwk5y0;

abstract class PlaceSnapshot
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlaceSnapshot._({
    required this.placeId,
    this.featureId,
    required this.name,
    this.primaryType,
    required this.categoryIds,
    this.rating,
    this.reviewCount,
    this.priceLevel,
    this.priceText,
    this.isOpen,
    this.statusText,
    required this.hours,
    required this.distanceMeters,
    required this.latitude,
    required this.longitude,
    this.address,
    this.formattedAddress,
    this.phoneNumber,
    this.websiteUrl,
    this.mapsUrl,
    required this.photoUrls,
    this.featuredReview,
    this.editorialSummary,
    required this.attributions,
    required this.sourceCheckedAt,
    required this.isStale,
  });

  factory PlaceSnapshot({
    required String placeId,
    String? featureId,
    required String name,
    String? primaryType,
    required List<String> categoryIds,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    String? priceText,
    bool? isOpen,
    String? statusText,
    required List<_iutwk5y0.OpeningPeriod> hours,
    required int distanceMeters,
    required double latitude,
    required double longitude,
    String? address,
    String? formattedAddress,
    String? phoneNumber,
    String? websiteUrl,
    String? mapsUrl,
    required List<String> photoUrls,
    String? featuredReview,
    String? editorialSummary,
    required List<String> attributions,
    required DateTime sourceCheckedAt,
    required bool isStale,
  }) = _PlaceSnapshotImpl;

  factory PlaceSnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlaceSnapshot(
      placeId: jsonSerialization['placeId'] as String,
      featureId: jsonSerialization['featureId'] as String?,
      name: jsonSerialization['name'] as String,
      primaryType: jsonSerialization['primaryType'] as String?,
      categoryIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      rating: (jsonSerialization['rating'] as num?)?.toDouble(),
      reviewCount: jsonSerialization['reviewCount'] as int?,
      priceLevel: jsonSerialization['priceLevel'] as int?,
      priceText: jsonSerialization['priceText'] as String?,
      isOpen: jsonSerialization['isOpen'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isOpen']),
      statusText: jsonSerialization['statusText'] as String?,
      hours: _i66y2smk.Protocol().deserialize<List<_iutwk5y0.OpeningPeriod>>(
        jsonSerialization['hours'],
      ),
      distanceMeters: jsonSerialization['distanceMeters'] as int,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      address: jsonSerialization['address'] as String?,
      formattedAddress: jsonSerialization['formattedAddress'] as String?,
      phoneNumber: jsonSerialization['phoneNumber'] as String?,
      websiteUrl: jsonSerialization['websiteUrl'] as String?,
      mapsUrl: jsonSerialization['mapsUrl'] as String?,
      photoUrls: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['photoUrls'],
      ),
      featuredReview: jsonSerialization['featuredReview'] as String?,
      editorialSummary: jsonSerialization['editorialSummary'] as String?,
      attributions: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['attributions'],
      ),
      sourceCheckedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['sourceCheckedAt'],
      ),
      isStale: _is.BoolJsonExtension.fromJson(jsonSerialization['isStale']),
    );
  }

  String placeId;

  String? featureId;

  String name;

  String? primaryType;

  List<String> categoryIds;

  double? rating;

  int? reviewCount;

  int? priceLevel;

  String? priceText;

  bool? isOpen;

  String? statusText;

  List<_iutwk5y0.OpeningPeriod> hours;

  int distanceMeters;

  double latitude;

  double longitude;

  String? address;

  String? formattedAddress;

  String? phoneNumber;

  String? websiteUrl;

  String? mapsUrl;

  List<String> photoUrls;

  String? featuredReview;

  String? editorialSummary;

  List<String> attributions;

  DateTime sourceCheckedAt;

  bool isStale;

  /// Returns a shallow copy of this [PlaceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlaceSnapshot copyWith({
    String? placeId,
    String? featureId,
    String? name,
    String? primaryType,
    List<String>? categoryIds,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    String? priceText,
    bool? isOpen,
    String? statusText,
    List<_iutwk5y0.OpeningPeriod>? hours,
    int? distanceMeters,
    double? latitude,
    double? longitude,
    String? address,
    String? formattedAddress,
    String? phoneNumber,
    String? websiteUrl,
    String? mapsUrl,
    List<String>? photoUrls,
    String? featuredReview,
    String? editorialSummary,
    List<String>? attributions,
    DateTime? sourceCheckedAt,
    bool? isStale,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlaceSnapshot',
      'placeId': placeId,
      if (featureId != null) 'featureId': featureId,
      'name': name,
      if (primaryType != null) 'primaryType': primaryType,
      'categoryIds': categoryIds.toJson(),
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (priceLevel != null) 'priceLevel': priceLevel,
      if (priceText != null) 'priceText': priceText,
      if (isOpen != null) 'isOpen': isOpen,
      if (statusText != null) 'statusText': statusText,
      'hours': hours.toJson(valueToJson: (v) => v.toJson()),
      'distanceMeters': distanceMeters,
      'latitude': latitude,
      'longitude': longitude,
      if (address != null) 'address': address,
      if (formattedAddress != null) 'formattedAddress': formattedAddress,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (mapsUrl != null) 'mapsUrl': mapsUrl,
      'photoUrls': photoUrls.toJson(),
      if (featuredReview != null) 'featuredReview': featuredReview,
      if (editorialSummary != null) 'editorialSummary': editorialSummary,
      'attributions': attributions.toJson(),
      'sourceCheckedAt': sourceCheckedAt.toJson(),
      'isStale': isStale,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlaceSnapshot',
      'placeId': placeId,
      if (featureId != null) 'featureId': featureId,
      'name': name,
      if (primaryType != null) 'primaryType': primaryType,
      'categoryIds': categoryIds.toJson(),
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (priceLevel != null) 'priceLevel': priceLevel,
      if (priceText != null) 'priceText': priceText,
      if (isOpen != null) 'isOpen': isOpen,
      if (statusText != null) 'statusText': statusText,
      'hours': hours.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'distanceMeters': distanceMeters,
      'latitude': latitude,
      'longitude': longitude,
      if (address != null) 'address': address,
      if (formattedAddress != null) 'formattedAddress': formattedAddress,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (mapsUrl != null) 'mapsUrl': mapsUrl,
      'photoUrls': photoUrls.toJson(),
      if (featuredReview != null) 'featuredReview': featuredReview,
      if (editorialSummary != null) 'editorialSummary': editorialSummary,
      'attributions': attributions.toJson(),
      'sourceCheckedAt': sourceCheckedAt.toJson(),
      'isStale': isStale,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlaceSnapshotImpl extends PlaceSnapshot {
  _PlaceSnapshotImpl({
    required String placeId,
    String? featureId,
    required String name,
    String? primaryType,
    required List<String> categoryIds,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    String? priceText,
    bool? isOpen,
    String? statusText,
    required List<_iutwk5y0.OpeningPeriod> hours,
    required int distanceMeters,
    required double latitude,
    required double longitude,
    String? address,
    String? formattedAddress,
    String? phoneNumber,
    String? websiteUrl,
    String? mapsUrl,
    required List<String> photoUrls,
    String? featuredReview,
    String? editorialSummary,
    required List<String> attributions,
    required DateTime sourceCheckedAt,
    required bool isStale,
  }) : super._(
         placeId: placeId,
         featureId: featureId,
         name: name,
         primaryType: primaryType,
         categoryIds: categoryIds,
         rating: rating,
         reviewCount: reviewCount,
         priceLevel: priceLevel,
         priceText: priceText,
         isOpen: isOpen,
         statusText: statusText,
         hours: hours,
         distanceMeters: distanceMeters,
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
         isStale: isStale,
       );

  /// Returns a shallow copy of this [PlaceSnapshot]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlaceSnapshot copyWith({
    String? placeId,
    Object? featureId = _Undefined,
    String? name,
    Object? primaryType = _Undefined,
    List<String>? categoryIds,
    Object? rating = _Undefined,
    Object? reviewCount = _Undefined,
    Object? priceLevel = _Undefined,
    Object? priceText = _Undefined,
    Object? isOpen = _Undefined,
    Object? statusText = _Undefined,
    List<_iutwk5y0.OpeningPeriod>? hours,
    int? distanceMeters,
    double? latitude,
    double? longitude,
    Object? address = _Undefined,
    Object? formattedAddress = _Undefined,
    Object? phoneNumber = _Undefined,
    Object? websiteUrl = _Undefined,
    Object? mapsUrl = _Undefined,
    List<String>? photoUrls,
    Object? featuredReview = _Undefined,
    Object? editorialSummary = _Undefined,
    List<String>? attributions,
    DateTime? sourceCheckedAt,
    bool? isStale,
  }) {
    return PlaceSnapshot(
      placeId: placeId ?? this.placeId,
      featureId: featureId is String? ? featureId : this.featureId,
      name: name ?? this.name,
      primaryType: primaryType is String? ? primaryType : this.primaryType,
      categoryIds: categoryIds ?? this.categoryIds.map((e0) => e0).toList(),
      rating: rating is double? ? rating : this.rating,
      reviewCount: reviewCount is int? ? reviewCount : this.reviewCount,
      priceLevel: priceLevel is int? ? priceLevel : this.priceLevel,
      priceText: priceText is String? ? priceText : this.priceText,
      isOpen: isOpen is bool? ? isOpen : this.isOpen,
      statusText: statusText is String? ? statusText : this.statusText,
      hours: hours ?? this.hours.map((e0) => e0.copyWith()).toList(),
      distanceMeters: distanceMeters ?? this.distanceMeters,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address is String? ? address : this.address,
      formattedAddress: formattedAddress is String?
          ? formattedAddress
          : this.formattedAddress,
      phoneNumber: phoneNumber is String? ? phoneNumber : this.phoneNumber,
      websiteUrl: websiteUrl is String? ? websiteUrl : this.websiteUrl,
      mapsUrl: mapsUrl is String? ? mapsUrl : this.mapsUrl,
      photoUrls: photoUrls ?? this.photoUrls.map((e0) => e0).toList(),
      featuredReview: featuredReview is String?
          ? featuredReview
          : this.featuredReview,
      editorialSummary: editorialSummary is String?
          ? editorialSummary
          : this.editorialSummary,
      attributions: attributions ?? this.attributions.map((e0) => e0).toList(),
      sourceCheckedAt: sourceCheckedAt ?? this.sourceCheckedAt,
      isStale: isStale ?? this.isStale,
    );
  }
}
