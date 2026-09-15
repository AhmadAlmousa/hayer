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
import 'poi_issue_type.dart' as _i2;
import 'poi_issue_status.dart' as _i3;
import 'poi_issue_source.dart' as _i4;

abstract class AdminCatalogReport implements _i1.SerializableModel {
  AdminCatalogReport._({
    required this.reportId,
    required this.issueType,
    required this.status,
    required this.source,
    required this.createdAt,
  });

  factory AdminCatalogReport({
    required String reportId,
    required _i2.PoiIssueType issueType,
    required _i3.PoiIssueStatus status,
    required _i4.PoiIssueSource source,
    required DateTime createdAt,
  }) = _AdminCatalogReportImpl;

  factory AdminCatalogReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogReport(
      reportId: jsonSerialization['reportId'] as String,
      issueType: _i2.PoiIssueType.fromJson(
        (jsonSerialization['issueType'] as String),
      ),
      status: _i3.PoiIssueStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      source: _i4.PoiIssueSource.fromJson(
        (jsonSerialization['source'] as String),
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String reportId;

  _i2.PoiIssueType issueType;

  _i3.PoiIssueStatus status;

  _i4.PoiIssueSource source;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminCatalogReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminCatalogReport copyWith({
    String? reportId,
    _i2.PoiIssueType? issueType,
    _i3.PoiIssueStatus? status,
    _i4.PoiIssueSource? source,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogReport',
      'reportId': reportId,
      'issueType': issueType.toJson(),
      'status': status.toJson(),
      'source': source.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminCatalogReportImpl extends AdminCatalogReport {
  _AdminCatalogReportImpl({
    required String reportId,
    required _i2.PoiIssueType issueType,
    required _i3.PoiIssueStatus status,
    required _i4.PoiIssueSource source,
    required DateTime createdAt,
  }) : super._(
         reportId: reportId,
         issueType: issueType,
         status: status,
         source: source,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminCatalogReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminCatalogReport copyWith({
    String? reportId,
    _i2.PoiIssueType? issueType,
    _i3.PoiIssueStatus? status,
    _i4.PoiIssueSource? source,
    DateTime? createdAt,
  }) {
    return AdminCatalogReport(
      reportId: reportId ?? this.reportId,
      issueType: issueType ?? this.issueType,
      status: status ?? this.status,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
