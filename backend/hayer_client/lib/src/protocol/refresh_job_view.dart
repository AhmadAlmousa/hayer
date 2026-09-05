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
import 'job_status.dart' as _i2;

abstract class RefreshJobView implements _i1.SerializableModel {
  RefreshJobView._({
    required this.jobId,
    required this.coverageKey,
    required this.status,
    required this.requestedBy,
    required this.reason,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.errorCode,
  });

  factory RefreshJobView({
    required String jobId,
    required String coverageKey,
    required _i2.JobStatus status,
    required String requestedBy,
    required String reason,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
  }) = _RefreshJobViewImpl;

  factory RefreshJobView.fromJson(Map<String, dynamic> jsonSerialization) {
    return RefreshJobView(
      jobId: jsonSerialization['jobId'] as String,
      coverageKey: jsonSerialization['coverageKey'] as String,
      status: _i2.JobStatus.fromJson((jsonSerialization['status'] as String)),
      requestedBy: jsonSerialization['requestedBy'] as String,
      reason: jsonSerialization['reason'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      errorCode: jsonSerialization['errorCode'] as String?,
    );
  }

  String jobId;

  String coverageKey;

  _i2.JobStatus status;

  String requestedBy;

  String reason;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  String? errorCode;

  /// Returns a shallow copy of this [RefreshJobView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RefreshJobView copyWith({
    String? jobId,
    String? coverageKey,
    _i2.JobStatus? status,
    String? requestedBy,
    String? reason,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RefreshJobView',
      'jobId': jobId,
      'coverageKey': coverageKey,
      'status': status.toJson(),
      'requestedBy': requestedBy,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (errorCode != null) 'errorCode': errorCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RefreshJobViewImpl extends RefreshJobView {
  _RefreshJobViewImpl({
    required String jobId,
    required String coverageKey,
    required _i2.JobStatus status,
    required String requestedBy,
    required String reason,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
  }) : super._(
         jobId: jobId,
         coverageKey: coverageKey,
         status: status,
         requestedBy: requestedBy,
         reason: reason,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
         errorCode: errorCode,
       );

  /// Returns a shallow copy of this [RefreshJobView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RefreshJobView copyWith({
    String? jobId,
    String? coverageKey,
    _i2.JobStatus? status,
    String? requestedBy,
    String? reason,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? errorCode = _Undefined,
  }) {
    return RefreshJobView(
      jobId: jobId ?? this.jobId,
      coverageKey: coverageKey ?? this.coverageKey,
      status: status ?? this.status,
      requestedBy: requestedBy ?? this.requestedBy,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      errorCode: errorCode is String? ? errorCode : this.errorCode,
    );
  }
}
