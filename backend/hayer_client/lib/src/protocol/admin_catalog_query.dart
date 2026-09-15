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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'discover_viewport.dart' as _i2;
import 'admin_catalog_sort.dart' as _i3;
import 'admin_catalog_status.dart' as _i4;
import 'admin_catalog_freshness.dart' as _i5;
import 'admin_catalog_lifecycle.dart' as _i6;
import 'admin_catalog_field.dart' as _i7;
import 'package:hayer_client/src/protocol/protocol.dart' as _i8;

abstract class AdminCatalogQuery implements _i1.SerializableModel {
  AdminCatalogQuery._({
    this.viewport,
    this.search,
    required this.sort,
    required this.descending,
    required this.status,
    required this.freshness,
    this.lifecycle,
    this.primaryType,
    this.categoryId,
    this.minimumRating,
    this.minimumReviews,
    this.priceLevels,
    this.missing,
    required this.withOpenReports,
    this.firstSeenAfter,
  });

  factory AdminCatalogQuery({
    _i2.DiscoverViewport? viewport,
    String? search,
    required _i3.AdminCatalogSort sort,
    required bool descending,
    required _i4.AdminCatalogStatus status,
    required _i5.AdminCatalogFreshness freshness,
    _i6.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_i7.AdminCatalogField>? missing,
    required bool withOpenReports,
    DateTime? firstSeenAfter,
  }) = _AdminCatalogQueryImpl;

  factory AdminCatalogQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogQuery(
      viewport: jsonSerialization['viewport'] == null
          ? null
          : _i8.Protocol().deserialize<_i2.DiscoverViewport>(
              jsonSerialization['viewport'],
            ),
      search: jsonSerialization['search'] as String?,
      sort: _i3.AdminCatalogSort.fromJson(
        (jsonSerialization['sort'] as String),
      ),
      descending: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['descending'],
      ),
      status: _i4.AdminCatalogStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      freshness: _i5.AdminCatalogFreshness.fromJson(
        (jsonSerialization['freshness'] as String),
      ),
      lifecycle: jsonSerialization['lifecycle'] == null
          ? null
          : _i6.AdminCatalogLifecycle.fromJson(
              (jsonSerialization['lifecycle'] as String),
            ),
      primaryType: jsonSerialization['primaryType'] as String?,
      categoryId: jsonSerialization['categoryId'] as String?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      minimumReviews: jsonSerialization['minimumReviews'] as int?,
      priceLevels: jsonSerialization['priceLevels'] == null
          ? null
          : _i8.Protocol().deserialize<List<int>>(
              jsonSerialization['priceLevels'],
            ),
      missing: jsonSerialization['missing'] == null
          ? null
          : _i8.Protocol().deserialize<List<_i7.AdminCatalogField>>(
              jsonSerialization['missing'],
            ),
      withOpenReports: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['withOpenReports'],
      ),
      firstSeenAfter: jsonSerialization['firstSeenAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['firstSeenAfter'],
            ),
    );
  }

  _i2.DiscoverViewport? viewport;

  String? search;

  _i3.AdminCatalogSort sort;

  bool descending;

  _i4.AdminCatalogStatus status;

  _i5.AdminCatalogFreshness freshness;

  _i6.AdminCatalogLifecycle? lifecycle;

  String? primaryType;

  String? categoryId;

  double? minimumRating;

  int? minimumReviews;

  List<int>? priceLevels;

  List<_i7.AdminCatalogField>? missing;

  bool withOpenReports;

  DateTime? firstSeenAfter;

  /// Returns a shallow copy of this [AdminCatalogQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminCatalogQuery copyWith({
    _i2.DiscoverViewport? viewport,
    String? search,
    _i3.AdminCatalogSort? sort,
    bool? descending,
    _i4.AdminCatalogStatus? status,
    _i5.AdminCatalogFreshness? freshness,
    _i6.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_i7.AdminCatalogField>? missing,
    bool? withOpenReports,
    DateTime? firstSeenAfter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogQuery',
      if (viewport != null) 'viewport': viewport?.toJson(),
      if (search != null) 'search': search,
      'sort': sort.toJson(),
      'descending': descending,
      'status': status.toJson(),
      'freshness': freshness.toJson(),
      if (lifecycle != null) 'lifecycle': lifecycle?.toJson(),
      if (primaryType != null) 'primaryType': primaryType,
      if (categoryId != null) 'categoryId': categoryId,
      if (minimumRating != null) 'minimumRating': minimumRating,
      if (minimumReviews != null) 'minimumReviews': minimumReviews,
      if (priceLevels != null) 'priceLevels': priceLevels?.toJson(),
      if (missing != null)
        'missing': missing?.toJson(valueToJson: (v) => v.toJson()),
      'withOpenReports': withOpenReports,
      if (firstSeenAfter != null) 'firstSeenAfter': firstSeenAfter?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogQueryImpl extends AdminCatalogQuery {
  _AdminCatalogQueryImpl({
    _i2.DiscoverViewport? viewport,
    String? search,
    required _i3.AdminCatalogSort sort,
    required bool descending,
    required _i4.AdminCatalogStatus status,
    required _i5.AdminCatalogFreshness freshness,
    _i6.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_i7.AdminCatalogField>? missing,
    required bool withOpenReports,
    DateTime? firstSeenAfter,
  }) : super._(
         viewport: viewport,
         search: search,
         sort: sort,
         descending: descending,
         status: status,
         freshness: freshness,
         lifecycle: lifecycle,
         primaryType: primaryType,
         categoryId: categoryId,
         minimumRating: minimumRating,
         minimumReviews: minimumReviews,
         priceLevels: priceLevels,
         missing: missing,
         withOpenReports: withOpenReports,
         firstSeenAfter: firstSeenAfter,
       );

  /// Returns a shallow copy of this [AdminCatalogQuery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminCatalogQuery copyWith({
    Object? viewport = _Undefined,
    Object? search = _Undefined,
    _i3.AdminCatalogSort? sort,
    bool? descending,
    _i4.AdminCatalogStatus? status,
    _i5.AdminCatalogFreshness? freshness,
    Object? lifecycle = _Undefined,
    Object? primaryType = _Undefined,
    Object? categoryId = _Undefined,
    Object? minimumRating = _Undefined,
    Object? minimumReviews = _Undefined,
    Object? priceLevels = _Undefined,
    Object? missing = _Undefined,
    bool? withOpenReports,
    Object? firstSeenAfter = _Undefined,
  }) {
    return AdminCatalogQuery(
      viewport: viewport is _i2.DiscoverViewport?
          ? viewport
          : this.viewport?.copyWith(),
      search: search is String? ? search : this.search,
      sort: sort ?? this.sort,
      descending: descending ?? this.descending,
      status: status ?? this.status,
      freshness: freshness ?? this.freshness,
      lifecycle: lifecycle is _i6.AdminCatalogLifecycle?
          ? lifecycle
          : this.lifecycle,
      primaryType: primaryType is String? ? primaryType : this.primaryType,
      categoryId: categoryId is String? ? categoryId : this.categoryId,
      minimumRating: minimumRating is double?
          ? minimumRating
          : this.minimumRating,
      minimumReviews: minimumReviews is int?
          ? minimumReviews
          : this.minimumReviews,
      priceLevels: priceLevels is List<int>?
          ? priceLevels
          : this.priceLevels?.map((e0) => e0).toList(),
      missing: missing is List<_i7.AdminCatalogField>?
          ? missing
          : this.missing?.map((e0) => e0).toList(),
      withOpenReports: withOpenReports ?? this.withOpenReports,
      firstSeenAfter: firstSeenAfter is DateTime?
          ? firstSeenAfter
          : this.firstSeenAfter,
    );
  }
}
