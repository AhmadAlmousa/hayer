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
import 'admin_catalog_freshness.dart' as _i26vn4oa;
import 'admin_catalog_lifecycle.dart' as _ilk0q4cv;
import 'admin_catalog_sort.dart' as _i5jj2ihb;
import 'admin_catalog_status.dart' as _ihehxtqf;
import 'discover_viewport.dart' as _i1okvcdc;

abstract class AdminCatalogQuery
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _i1okvcdc.DiscoverViewport? viewport,
    String? search,
    required _i5jj2ihb.AdminCatalogSort sort,
    required bool descending,
    required _ihehxtqf.AdminCatalogStatus status,
    required _i26vn4oa.AdminCatalogFreshness freshness,
    _ilk0q4cv.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_iyzxy41v.AdminCatalogField>? missing,
    required bool withOpenReports,
    DateTime? firstSeenAfter,
  }) = _AdminCatalogQueryImpl;

  factory AdminCatalogQuery.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogQuery(
      viewport: jsonSerialization['viewport'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_i1okvcdc.DiscoverViewport>(
              jsonSerialization['viewport'],
            ),
      search: jsonSerialization['search'] as String?,
      sort: _i5jj2ihb.AdminCatalogSort.fromJson(
        (jsonSerialization['sort'] as String),
      ),
      descending: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['descending'],
      ),
      status: _ihehxtqf.AdminCatalogStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      freshness: _i26vn4oa.AdminCatalogFreshness.fromJson(
        (jsonSerialization['freshness'] as String),
      ),
      lifecycle: jsonSerialization['lifecycle'] == null
          ? null
          : _ilk0q4cv.AdminCatalogLifecycle.fromJson(
              (jsonSerialization['lifecycle'] as String),
            ),
      primaryType: jsonSerialization['primaryType'] as String?,
      categoryId: jsonSerialization['categoryId'] as String?,
      minimumRating: (jsonSerialization['minimumRating'] as num?)?.toDouble(),
      minimumReviews: jsonSerialization['minimumReviews'] as int?,
      priceLevels: jsonSerialization['priceLevels'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<List<int>>(
              jsonSerialization['priceLevels'],
            ),
      missing: jsonSerialization['missing'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<List<_iyzxy41v.AdminCatalogField>>(
              jsonSerialization['missing'],
            ),
      withOpenReports: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['withOpenReports'],
      ),
      firstSeenAfter: jsonSerialization['firstSeenAfter'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['firstSeenAfter'],
            ),
    );
  }

  _i1okvcdc.DiscoverViewport? viewport;

  String? search;

  _i5jj2ihb.AdminCatalogSort sort;

  bool descending;

  _ihehxtqf.AdminCatalogStatus status;

  _i26vn4oa.AdminCatalogFreshness freshness;

  _ilk0q4cv.AdminCatalogLifecycle? lifecycle;

  String? primaryType;

  String? categoryId;

  double? minimumRating;

  int? minimumReviews;

  List<int>? priceLevels;

  List<_iyzxy41v.AdminCatalogField>? missing;

  bool withOpenReports;

  DateTime? firstSeenAfter;

  /// Returns a shallow copy of this [AdminCatalogQuery]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminCatalogQuery copyWith({
    _i1okvcdc.DiscoverViewport? viewport,
    String? search,
    _i5jj2ihb.AdminCatalogSort? sort,
    bool? descending,
    _ihehxtqf.AdminCatalogStatus? status,
    _i26vn4oa.AdminCatalogFreshness? freshness,
    _ilk0q4cv.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_iyzxy41v.AdminCatalogField>? missing,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogQuery',
      if (viewport != null) 'viewport': viewport?.toJsonForProtocol(),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogQueryImpl extends AdminCatalogQuery {
  _AdminCatalogQueryImpl({
    _i1okvcdc.DiscoverViewport? viewport,
    String? search,
    required _i5jj2ihb.AdminCatalogSort sort,
    required bool descending,
    required _ihehxtqf.AdminCatalogStatus status,
    required _i26vn4oa.AdminCatalogFreshness freshness,
    _ilk0q4cv.AdminCatalogLifecycle? lifecycle,
    String? primaryType,
    String? categoryId,
    double? minimumRating,
    int? minimumReviews,
    List<int>? priceLevels,
    List<_iyzxy41v.AdminCatalogField>? missing,
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
  @_isc.useResult
  @override
  AdminCatalogQuery copyWith({
    Object? viewport = _Undefined,
    Object? search = _Undefined,
    _i5jj2ihb.AdminCatalogSort? sort,
    bool? descending,
    _ihehxtqf.AdminCatalogStatus? status,
    _i26vn4oa.AdminCatalogFreshness? freshness,
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
      viewport: viewport is _i1okvcdc.DiscoverViewport?
          ? viewport
          : this.viewport?.copyWith(),
      search: search is String? ? search : this.search,
      sort: sort ?? this.sort,
      descending: descending ?? this.descending,
      status: status ?? this.status,
      freshness: freshness ?? this.freshness,
      lifecycle: lifecycle is _ilk0q4cv.AdminCatalogLifecycle?
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
      missing: missing is List<_iyzxy41v.AdminCatalogField>?
          ? missing
          : this.missing?.map((e0) => e0).toList(),
      withOpenReports: withOpenReports ?? this.withOpenReports,
      firstSeenAfter: firstSeenAfter is DateTime?
          ? firstSeenAfter
          : this.firstSeenAfter,
    );
  }
}
