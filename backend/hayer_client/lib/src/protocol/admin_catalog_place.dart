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
import 'package:hayer_client/src/protocol/protocol.dart' as _iynev3sz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'admin_catalog_field.dart' as _iyzxy41v;
import 'admin_catalog_lifecycle.dart' as _ilk0q4cv;

abstract class AdminCatalogPlace
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminCatalogPlace._({
    required this.catalogId,
    required this.provider,
    required this.placeId,
    required this.name,
    this.primaryType,
    required this.categoryIds,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    this.rating,
    this.reviewCount,
    this.priceLevel,
    required this.lifecycle,
    required this.missing,
    required this.firstSeenAt,
    required this.lastSeenAt,
    required this.sourceCheckedAt,
    required this.isStale,
    this.quarantinedAt,
    required this.openReportCount,
  });

  factory AdminCatalogPlace({
    required int catalogId,
    required String provider,
    required String placeId,
    required String name,
    String? primaryType,
    required List<String> categoryIds,
    required String countryCode,
    required double latitude,
    required double longitude,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    required _ilk0q4cv.AdminCatalogLifecycle lifecycle,
    required List<_iyzxy41v.AdminCatalogField> missing,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
    required DateTime sourceCheckedAt,
    required bool isStale,
    DateTime? quarantinedAt,
    required int openReportCount,
  }) = _AdminCatalogPlaceImpl;

  factory AdminCatalogPlace.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogPlace(
      catalogId: jsonSerialization['catalogId'] as int,
      provider: jsonSerialization['provider'] as String,
      placeId: jsonSerialization['placeId'] as String,
      name: jsonSerialization['name'] as String,
      primaryType: jsonSerialization['primaryType'] as String?,
      categoryIds: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      countryCode: jsonSerialization['countryCode'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      rating: (jsonSerialization['rating'] as num?)?.toDouble(),
      reviewCount: jsonSerialization['reviewCount'] as int?,
      priceLevel: jsonSerialization['priceLevel'] as int?,
      lifecycle: _ilk0q4cv.AdminCatalogLifecycle.fromJson(
        (jsonSerialization['lifecycle'] as String),
      ),
      missing: _iynev3sz.Protocol()
          .deserialize<List<_iyzxy41v.AdminCatalogField>>(
            jsonSerialization['missing'],
          ),
      firstSeenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
      sourceCheckedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['sourceCheckedAt'],
      ),
      isStale: _isc.BoolJsonExtension.fromJson(jsonSerialization['isStale']),
      quarantinedAt: jsonSerialization['quarantinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['quarantinedAt'],
            ),
      openReportCount: jsonSerialization['openReportCount'] as int,
    );
  }

  int catalogId;

  String provider;

  String placeId;

  String name;

  String? primaryType;

  List<String> categoryIds;

  String countryCode;

  double latitude;

  double longitude;

  double? rating;

  int? reviewCount;

  int? priceLevel;

  _ilk0q4cv.AdminCatalogLifecycle lifecycle;

  List<_iyzxy41v.AdminCatalogField> missing;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  DateTime sourceCheckedAt;

  bool isStale;

  DateTime? quarantinedAt;

  int openReportCount;

  /// Returns a shallow copy of this [AdminCatalogPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminCatalogPlace copyWith({
    int? catalogId,
    String? provider,
    String? placeId,
    String? name,
    String? primaryType,
    List<String>? categoryIds,
    String? countryCode,
    double? latitude,
    double? longitude,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    _ilk0q4cv.AdminCatalogLifecycle? lifecycle,
    List<_iyzxy41v.AdminCatalogField>? missing,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    DateTime? sourceCheckedAt,
    bool? isStale,
    DateTime? quarantinedAt,
    int? openReportCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogPlace',
      'catalogId': catalogId,
      'provider': provider,
      'placeId': placeId,
      'name': name,
      if (primaryType != null) 'primaryType': primaryType,
      'categoryIds': categoryIds.toJson(),
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (priceLevel != null) 'priceLevel': priceLevel,
      'lifecycle': lifecycle.toJson(),
      'missing': missing.toJson(valueToJson: (v) => v.toJson()),
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
      'sourceCheckedAt': sourceCheckedAt.toJson(),
      'isStale': isStale,
      if (quarantinedAt != null) 'quarantinedAt': quarantinedAt?.toJson(),
      'openReportCount': openReportCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogPlace',
      'catalogId': catalogId,
      'provider': provider,
      'placeId': placeId,
      'name': name,
      if (primaryType != null) 'primaryType': primaryType,
      'categoryIds': categoryIds.toJson(),
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'reviewCount': reviewCount,
      if (priceLevel != null) 'priceLevel': priceLevel,
      'lifecycle': lifecycle.toJson(),
      'missing': missing.toJson(valueToJson: (v) => v.toJson()),
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
      'sourceCheckedAt': sourceCheckedAt.toJson(),
      'isStale': isStale,
      if (quarantinedAt != null) 'quarantinedAt': quarantinedAt?.toJson(),
      'openReportCount': openReportCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogPlaceImpl extends AdminCatalogPlace {
  _AdminCatalogPlaceImpl({
    required int catalogId,
    required String provider,
    required String placeId,
    required String name,
    String? primaryType,
    required List<String> categoryIds,
    required String countryCode,
    required double latitude,
    required double longitude,
    double? rating,
    int? reviewCount,
    int? priceLevel,
    required _ilk0q4cv.AdminCatalogLifecycle lifecycle,
    required List<_iyzxy41v.AdminCatalogField> missing,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
    required DateTime sourceCheckedAt,
    required bool isStale,
    DateTime? quarantinedAt,
    required int openReportCount,
  }) : super._(
         catalogId: catalogId,
         provider: provider,
         placeId: placeId,
         name: name,
         primaryType: primaryType,
         categoryIds: categoryIds,
         countryCode: countryCode,
         latitude: latitude,
         longitude: longitude,
         rating: rating,
         reviewCount: reviewCount,
         priceLevel: priceLevel,
         lifecycle: lifecycle,
         missing: missing,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
         sourceCheckedAt: sourceCheckedAt,
         isStale: isStale,
         quarantinedAt: quarantinedAt,
         openReportCount: openReportCount,
       );

  /// Returns a shallow copy of this [AdminCatalogPlace]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminCatalogPlace copyWith({
    int? catalogId,
    String? provider,
    String? placeId,
    String? name,
    Object? primaryType = _Undefined,
    List<String>? categoryIds,
    String? countryCode,
    double? latitude,
    double? longitude,
    Object? rating = _Undefined,
    Object? reviewCount = _Undefined,
    Object? priceLevel = _Undefined,
    _ilk0q4cv.AdminCatalogLifecycle? lifecycle,
    List<_iyzxy41v.AdminCatalogField>? missing,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    DateTime? sourceCheckedAt,
    bool? isStale,
    Object? quarantinedAt = _Undefined,
    int? openReportCount,
  }) {
    return AdminCatalogPlace(
      catalogId: catalogId ?? this.catalogId,
      provider: provider ?? this.provider,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      primaryType: primaryType is String? ? primaryType : this.primaryType,
      categoryIds: categoryIds ?? this.categoryIds.map((e0) => e0).toList(),
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating is double? ? rating : this.rating,
      reviewCount: reviewCount is int? ? reviewCount : this.reviewCount,
      priceLevel: priceLevel is int? ? priceLevel : this.priceLevel,
      lifecycle: lifecycle ?? this.lifecycle,
      missing: missing ?? this.missing.map((e0) => e0).toList(),
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      sourceCheckedAt: sourceCheckedAt ?? this.sourceCheckedAt,
      isStale: isStale ?? this.isStale,
      quarantinedAt: quarantinedAt is DateTime?
          ? quarantinedAt
          : this.quarantinedAt,
      openReportCount: openReportCount ?? this.openReportCount,
    );
  }
}
