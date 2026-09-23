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
import 'admin_poi_issue.dart' as _i38jre17;

abstract class AdminPoiIssuePage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminPoiIssuePage._({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.openCount,
    required this.inReviewCount,
    required this.resolvedCount,
    required this.dismissedCount,
  });

  factory AdminPoiIssuePage({
    required List<_i38jre17.AdminPoiIssue> items,
    required int total,
    required int page,
    required int pageSize,
    required int openCount,
    required int inReviewCount,
    required int resolvedCount,
    required int dismissedCount,
  }) = _AdminPoiIssuePageImpl;

  factory AdminPoiIssuePage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPoiIssuePage(
      items: _iynev3sz.Protocol().deserialize<List<_i38jre17.AdminPoiIssue>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
      openCount: jsonSerialization['openCount'] as int,
      inReviewCount: jsonSerialization['inReviewCount'] as int,
      resolvedCount: jsonSerialization['resolvedCount'] as int,
      dismissedCount: jsonSerialization['dismissedCount'] as int,
    );
  }

  List<_i38jre17.AdminPoiIssue> items;

  int total;

  int page;

  int pageSize;

  int openCount;

  int inReviewCount;

  int resolvedCount;

  int dismissedCount;

  /// Returns a shallow copy of this [AdminPoiIssuePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminPoiIssuePage copyWith({
    List<_i38jre17.AdminPoiIssue>? items,
    int? total,
    int? page,
    int? pageSize,
    int? openCount,
    int? inReviewCount,
    int? resolvedCount,
    int? dismissedCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminPoiIssuePage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'openCount': openCount,
      'inReviewCount': inReviewCount,
      'resolvedCount': resolvedCount,
      'dismissedCount': dismissedCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminPoiIssuePage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'openCount': openCount,
      'inReviewCount': inReviewCount,
      'resolvedCount': resolvedCount,
      'dismissedCount': dismissedCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminPoiIssuePageImpl extends AdminPoiIssuePage {
  _AdminPoiIssuePageImpl({
    required List<_i38jre17.AdminPoiIssue> items,
    required int total,
    required int page,
    required int pageSize,
    required int openCount,
    required int inReviewCount,
    required int resolvedCount,
    required int dismissedCount,
  }) : super._(
         items: items,
         total: total,
         page: page,
         pageSize: pageSize,
         openCount: openCount,
         inReviewCount: inReviewCount,
         resolvedCount: resolvedCount,
         dismissedCount: dismissedCount,
       );

  /// Returns a shallow copy of this [AdminPoiIssuePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminPoiIssuePage copyWith({
    List<_i38jre17.AdminPoiIssue>? items,
    int? total,
    int? page,
    int? pageSize,
    int? openCount,
    int? inReviewCount,
    int? resolvedCount,
    int? dismissedCount,
  }) {
    return AdminPoiIssuePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      openCount: openCount ?? this.openCount,
      inReviewCount: inReviewCount ?? this.inReviewCount,
      resolvedCount: resolvedCount ?? this.resolvedCount,
      dismissedCount: dismissedCount ?? this.dismissedCount,
    );
  }
}
