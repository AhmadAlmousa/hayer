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
import 'session_event_type.dart' as _i2;

abstract class SessionEvent implements _i1.SerializableModel {
  SessionEvent._({
    required this.sessionId,
    required this.type,
    required this.revision,
    required this.occurredAt,
  });

  factory SessionEvent({
    required String sessionId,
    required _i2.SessionEventType type,
    required int revision,
    required DateTime occurredAt,
  }) = _SessionEventImpl;

  factory SessionEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionEvent(
      sessionId: jsonSerialization['sessionId'] as String,
      type: _i2.SessionEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      revision: jsonSerialization['revision'] as int,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  String sessionId;

  _i2.SessionEventType type;

  int revision;

  DateTime occurredAt;

  /// Returns a shallow copy of this [SessionEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionEvent copyWith({
    String? sessionId,
    _i2.SessionEventType? type,
    int? revision,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionEvent',
      'sessionId': sessionId,
      'type': type.toJson(),
      'revision': revision,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SessionEventImpl extends SessionEvent {
  _SessionEventImpl({
    required String sessionId,
    required _i2.SessionEventType type,
    required int revision,
    required DateTime occurredAt,
  }) : super._(
         sessionId: sessionId,
         type: type,
         revision: revision,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [SessionEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SessionEvent copyWith({
    String? sessionId,
    _i2.SessionEventType? type,
    int? revision,
    DateTime? occurredAt,
  }) {
    return SessionEvent(
      sessionId: sessionId ?? this.sessionId,
      type: type ?? this.type,
      revision: revision ?? this.revision,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}
