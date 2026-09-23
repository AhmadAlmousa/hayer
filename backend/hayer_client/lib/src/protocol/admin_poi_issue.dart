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
import 'place_snapshot.dart' as _ikbous9x;
import 'poi_issue_source.dart' as _i8ciqmoq;
import 'poi_issue_status.dart' as _ivby6xgm;
import 'poi_issue_type.dart' as _i19nx1xx;

abstract class AdminPoiIssue
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    this.source,
    this.sessionId,
  });

  factory AdminPoiIssue({
    required String reportId,
    required String placeId,
    required String placeName,
    required _i19nx1xx.PoiIssueType issueType,
    String? details,
    required _ivby6xgm.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required _ikbous9x.PlaceSnapshot reportedSnapshot,
    _ikbous9x.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    required int recurrenceCount,
    required int affectedSessionCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
    _i8ciqmoq.PoiIssueSource? source,
    String? sessionId,
  }) = _AdminPoiIssueImpl;

  factory AdminPoiIssue.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPoiIssue(
      reportId: jsonSerialization['reportId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      placeName: jsonSerialization['placeName'] as String,
      issueType: _i19nx1xx.PoiIssueType.fromJson(
        (jsonSerialization['issueType'] as String),
      ),
      details: jsonSerialization['details'] as String?,
      status: _ivby6xgm.PoiIssueStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      ownerName: jsonSerialization['ownerName'] as String?,
      resolution: jsonSerialization['resolution'] as String?,
      sourceEvidence: jsonSerialization['sourceEvidence'] as String?,
      reportedSnapshot: _iynev3sz.Protocol()
          .deserialize<_ikbous9x.PlaceSnapshot>(
            jsonSerialization['reportedSnapshot'],
          ),
      currentSnapshot: jsonSerialization['currentSnapshot'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_ikbous9x.PlaceSnapshot>(
              jsonSerialization['currentSnapshot'],
            ),
      quarantinedAt: jsonSerialization['quarantinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['quarantinedAt'],
            ),
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
      recurrenceCount: jsonSerialization['recurrenceCount'] as int,
      affectedSessionCount: jsonSerialization['affectedSessionCount'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['resolvedAt'],
            ),
      source: jsonSerialization['source'] == null
          ? null
          : _i8ciqmoq.PoiIssueSource.fromJson(
              (jsonSerialization['source'] as String),
            ),
      sessionId: jsonSerialization['sessionId'] as String?,
    );
  }

  String reportId;

  String placeId;

  String placeName;

  _i19nx1xx.PoiIssueType issueType;

  String? details;

  _ivby6xgm.PoiIssueStatus status;

  String? ownerName;

  String? resolution;

  String? sourceEvidence;

  _ikbous9x.PlaceSnapshot reportedSnapshot;

  _ikbous9x.PlaceSnapshot? currentSnapshot;

  DateTime? quarantinedAt;

  String? quarantineReason;

  int recurrenceCount;

  int affectedSessionCount;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? resolvedAt;

  _i8ciqmoq.PoiIssueSource? source;

  String? sessionId;

  /// Returns a shallow copy of this [AdminPoiIssue]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminPoiIssue copyWith({
    String? reportId,
    String? placeId,
    String? placeName,
    _i19nx1xx.PoiIssueType? issueType,
    String? details,
    _ivby6xgm.PoiIssueStatus? status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    _ikbous9x.PlaceSnapshot? reportedSnapshot,
    _ikbous9x.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    int? recurrenceCount,
    int? affectedSessionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
    _i8ciqmoq.PoiIssueSource? source,
    String? sessionId,
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
      if (source != null) 'source': source?.toJson(),
      if (sessionId != null) 'sessionId': sessionId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
      'reportedSnapshot': reportedSnapshot.toJsonForProtocol(),
      if (currentSnapshot != null)
        'currentSnapshot': currentSnapshot?.toJsonForProtocol(),
      if (quarantinedAt != null) 'quarantinedAt': quarantinedAt?.toJson(),
      if (quarantineReason != null) 'quarantineReason': quarantineReason,
      'recurrenceCount': recurrenceCount,
      'affectedSessionCount': affectedSessionCount,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
      if (source != null) 'source': source?.toJson(),
      if (sessionId != null) 'sessionId': sessionId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminPoiIssueImpl extends AdminPoiIssue {
  _AdminPoiIssueImpl({
    required String reportId,
    required String placeId,
    required String placeName,
    required _i19nx1xx.PoiIssueType issueType,
    String? details,
    required _ivby6xgm.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required _ikbous9x.PlaceSnapshot reportedSnapshot,
    _ikbous9x.PlaceSnapshot? currentSnapshot,
    DateTime? quarantinedAt,
    String? quarantineReason,
    required int recurrenceCount,
    required int affectedSessionCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
    _i8ciqmoq.PoiIssueSource? source,
    String? sessionId,
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
         source: source,
         sessionId: sessionId,
       );

  /// Returns a shallow copy of this [AdminPoiIssue]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminPoiIssue copyWith({
    String? reportId,
    String? placeId,
    String? placeName,
    _i19nx1xx.PoiIssueType? issueType,
    Object? details = _Undefined,
    _ivby6xgm.PoiIssueStatus? status,
    Object? ownerName = _Undefined,
    Object? resolution = _Undefined,
    Object? sourceEvidence = _Undefined,
    _ikbous9x.PlaceSnapshot? reportedSnapshot,
    Object? currentSnapshot = _Undefined,
    Object? quarantinedAt = _Undefined,
    Object? quarantineReason = _Undefined,
    int? recurrenceCount,
    int? affectedSessionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
    Object? source = _Undefined,
    Object? sessionId = _Undefined,
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
      currentSnapshot: currentSnapshot is _ikbous9x.PlaceSnapshot?
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
      source: source is _i8ciqmoq.PoiIssueSource? ? source : this.source,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
    );
  }
}
