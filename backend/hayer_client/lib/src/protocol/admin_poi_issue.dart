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
import 'place_snapshot.dart' as _i4;
import 'package:hayer_client/src/protocol/protocol.dart' as _i5;

abstract class AdminPoiIssue implements _i1.SerializableModel {
  AdminPoiIssue._({
    required this.reportId,
    required this.placeId,
    required this.placeName,
    required this.issueType,
    this.details,
    required this.status,
    this.ownerName,
    this.resolution,
    this.sourceEvidence,
    required this.reportedSnapshot,
    this.currentSnapshot,
    this.quarantinedAt,
    this.quarantineReason,
    required this.recurrenceCount,
    required this.affectedSessionCount,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  factory AdminPoiIssue({
    required String reportId,
    required String placeId,
    required String placeName,
    required _i2.PoiIssueType issueType,
    String? details,
    required _i3.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required _i4.PlaceSnapshot reportedSnapshot,
    _i4.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    required int recurrenceCount,
    required int affectedSessionCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
  }) = _AdminPoiIssueImpl;

  factory AdminPoiIssue.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPoiIssue(
      reportId: jsonSerialization['reportId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      placeName: jsonSerialization['placeName'] as String,
      issueType: _i2.PoiIssueType.fromJson(
        (jsonSerialization['issueType'] as String),
      ),
      details: jsonSerialization['details'] as String?,
      status: _i3.PoiIssueStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      ownerName: jsonSerialization['ownerName'] as String?,
      resolution: jsonSerialization['resolution'] as String?,
      sourceEvidence: jsonSerialization['sourceEvidence'] as String?,
      reportedSnapshot: _i5.Protocol().deserialize<_i4.PlaceSnapshot>(
        jsonSerialization['reportedSnapshot'],
      ),
      currentSnapshot: jsonSerialization['currentSnapshot'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.PlaceSnapshot>(
              jsonSerialization['currentSnapshot'],
            ),
      quarantinedAt: jsonSerialization['quarantinedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['quarantinedAt'],
            ),
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
      recurrenceCount: jsonSerialization['recurrenceCount'] as int,
      affectedSessionCount: jsonSerialization['affectedSessionCount'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  String reportId;

  String placeId;

  String placeName;

  _i2.PoiIssueType issueType;

  String? details;

  _i3.PoiIssueStatus status;

  String? ownerName;

  String? resolution;

  String? sourceEvidence;

  _i4.PlaceSnapshot reportedSnapshot;

  _i4.PlaceSnapshot? currentSnapshot;

  DateTime? quarantinedAt;

  String? quarantineReason;

  int recurrenceCount;

  int affectedSessionCount;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [AdminPoiIssue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminPoiIssue copyWith({
    String? reportId,
    String? placeId,
    String? placeName,
    _i2.PoiIssueType? issueType,
    String? details,
    _i3.PoiIssueStatus? status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    _i4.PlaceSnapshot? reportedSnapshot,
    _i4.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    int? recurrenceCount,
    int? affectedSessionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminPoiIssue',
      'reportId': reportId,
      'placeId': placeId,
      'placeName': placeName,
      'issueType': issueType.toJson(),
      if (details != null) 'details': details,
      'status': status.toJson(),
      if (ownerName != null) 'ownerName': ownerName,
      if (resolution != null) 'resolution': resolution,
      if (sourceEvidence != null) 'sourceEvidence': sourceEvidence,
      'reportedSnapshot': reportedSnapshot.toJson(),
      if (currentSnapshot != null) 'currentSnapshot': currentSnapshot?.toJson(),
      if (quarantinedAt != null) 'quarantinedAt': quarantinedAt?.toJson(),
      if (quarantineReason != null) 'quarantineReason': quarantineReason,
      'recurrenceCount': recurrenceCount,
      'affectedSessionCount': affectedSessionCount,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminPoiIssueImpl extends AdminPoiIssue {
  _AdminPoiIssueImpl({
    required String reportId,
    required String placeId,
    required String placeName,
    required _i2.PoiIssueType issueType,
    String? details,
    required _i3.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required _i4.PlaceSnapshot reportedSnapshot,
    _i4.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    required int recurrenceCount,
    required int affectedSessionCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
  }) : super._(
         reportId: reportId,
         placeId: placeId,
         placeName: placeName,
         issueType: issueType,
         details: details,
         status: status,
         ownerName: ownerName,
         resolution: resolution,
         sourceEvidence: sourceEvidence,
         reportedSnapshot: reportedSnapshot,
         currentSnapshot: currentSnapshot,
         quarantinedAt: quarantinedAt,
         quarantineReason: quarantineReason,
         recurrenceCount: recurrenceCount,
         affectedSessionCount: affectedSessionCount,
         createdAt: createdAt,
         updatedAt: updatedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [AdminPoiIssue]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminPoiIssue copyWith({
    String? reportId,
    String? placeId,
    String? placeName,
    _i2.PoiIssueType? issueType,
    Object? details = _Undefined,
    _i3.PoiIssueStatus? status,
    Object? ownerName = _Undefined,
    Object? resolution = _Undefined,
    Object? sourceEvidence = _Undefined,
    _i4.PlaceSnapshot? reportedSnapshot,
    Object? currentSnapshot = _Undefined,
    Object? quarantinedAt = _Undefined,
    Object? quarantineReason = _Undefined,
    int? recurrenceCount,
    int? affectedSessionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return AdminPoiIssue(
      reportId: reportId ?? this.reportId,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      issueType: issueType ?? this.issueType,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      ownerName: ownerName is String? ? ownerName : this.ownerName,
      resolution: resolution is String? ? resolution : this.resolution,
      sourceEvidence: sourceEvidence is String?
          ? sourceEvidence
          : this.sourceEvidence,
      reportedSnapshot: reportedSnapshot ?? this.reportedSnapshot.copyWith(),
      currentSnapshot: currentSnapshot is _i4.PlaceSnapshot?
          ? currentSnapshot
          : this.currentSnapshot?.copyWith(),
      quarantinedAt: quarantinedAt is DateTime?
          ? quarantinedAt
          : this.quarantinedAt,
      quarantineReason: quarantineReason is String?
          ? quarantineReason
          : this.quarantineReason,
      recurrenceCount: recurrenceCount ?? this.recurrenceCount,
      affectedSessionCount: affectedSessionCount ?? this.affectedSessionCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
