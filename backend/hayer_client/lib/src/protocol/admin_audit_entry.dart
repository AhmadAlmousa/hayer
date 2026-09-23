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

abstract class AdminAuditEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminAuditEntry._({
    required this.auditId,
    required this.operatorName,
    required this.action,
    required this.targetType,
    this.targetId,
    required this.reason,
    this.beforeData,
    this.afterData,
    required this.occurredAt,
  });

  factory AdminAuditEntry({
    required String auditId,
    required String operatorName,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    required DateTime occurredAt,
  }) = _AdminAuditEntryImpl;

  factory AdminAuditEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditEntry(
      auditId: jsonSerialization['auditId'] as String,
      operatorName: jsonSerialization['operatorName'] as String,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as String?,
      reason: jsonSerialization['reason'] as String,
      beforeData: jsonSerialization['beforeData'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['beforeData'],
            ),
      afterData: jsonSerialization['afterData'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['afterData'],
            ),
      occurredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  String auditId;

  String operatorName;

  String action;

  String targetType;

  String? targetId;

  String reason;

  Map<String, String>? beforeData;

  Map<String, String>? afterData;

  DateTime occurredAt;

  /// Returns a shallow copy of this [AdminAuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminAuditEntry copyWith({
    String? auditId,
    String? operatorName,
    String? action,
    String? targetType,
    String? targetId,
    String? reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditEntry',
      'auditId': auditId,
      'operatorName': operatorName,
      'action': action,
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      'reason': reason,
      if (beforeData != null) 'beforeData': beforeData?.toJson(),
      if (afterData != null) 'afterData': afterData?.toJson(),
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditEntry',
      'auditId': auditId,
      'operatorName': operatorName,
      'action': action,
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      'reason': reason,
      if (beforeData != null) 'beforeData': beforeData?.toJson(),
      if (afterData != null) 'afterData': afterData?.toJson(),
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditEntryImpl extends AdminAuditEntry {
  _AdminAuditEntryImpl({
    required String auditId,
    required String operatorName,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    required DateTime occurredAt,
  }) : super._(
         auditId: auditId,
         operatorName: operatorName,
         action: action,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         beforeData: beforeData,
         afterData: afterData,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [AdminAuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminAuditEntry copyWith({
    String? auditId,
    String? operatorName,
    String? action,
    String? targetType,
    Object? targetId = _Undefined,
    String? reason,
    Object? beforeData = _Undefined,
    Object? afterData = _Undefined,
    DateTime? occurredAt,
  }) {
    return AdminAuditEntry(
      auditId: auditId ?? this.auditId,
      operatorName: operatorName ?? this.operatorName,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId is String? ? targetId : this.targetId,
      reason: reason ?? this.reason,
      beforeData: beforeData is Map<String, String>?
          ? beforeData
          : this.beforeData?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      afterData: afterData is Map<String, String>?
          ? afterData
          : this.afterData?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}
