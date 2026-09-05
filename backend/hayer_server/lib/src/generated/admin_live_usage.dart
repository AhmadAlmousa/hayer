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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class AdminLiveUsage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminLiveUsage._({
    required this.ongoingSessions,
    required this.soloSessions,
    required this.multiplayerSessions,
    required this.enrolledParticipants,
    required this.activeParticipants,
    required this.generatedAt,
  });

  factory AdminLiveUsage({
    required int ongoingSessions,
    required int soloSessions,
    required int multiplayerSessions,
    required int enrolledParticipants,
    required int activeParticipants,
    required DateTime generatedAt,
  }) = _AdminLiveUsageImpl;

  factory AdminLiveUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminLiveUsage(
      ongoingSessions: jsonSerialization['ongoingSessions'] as int,
      soloSessions: jsonSerialization['soloSessions'] as int,
      multiplayerSessions: jsonSerialization['multiplayerSessions'] as int,
      enrolledParticipants: jsonSerialization['enrolledParticipants'] as int,
      activeParticipants: jsonSerialization['activeParticipants'] as int,
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  int ongoingSessions;

  int soloSessions;

  int multiplayerSessions;

  int enrolledParticipants;

  int activeParticipants;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminLiveUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminLiveUsage copyWith({
    int? ongoingSessions,
    int? soloSessions,
    int? multiplayerSessions,
    int? enrolledParticipants,
    int? activeParticipants,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminLiveUsage',
      'ongoingSessions': ongoingSessions,
      'soloSessions': soloSessions,
      'multiplayerSessions': multiplayerSessions,
      'enrolledParticipants': enrolledParticipants,
      'activeParticipants': activeParticipants,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminLiveUsage',
      'ongoingSessions': ongoingSessions,
      'soloSessions': soloSessions,
      'multiplayerSessions': multiplayerSessions,
      'enrolledParticipants': enrolledParticipants,
      'activeParticipants': activeParticipants,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminLiveUsageImpl extends AdminLiveUsage {
  _AdminLiveUsageImpl({
    required int ongoingSessions,
    required int soloSessions,
    required int multiplayerSessions,
    required int enrolledParticipants,
    required int activeParticipants,
    required DateTime generatedAt,
  }) : super._(
         ongoingSessions: ongoingSessions,
         soloSessions: soloSessions,
         multiplayerSessions: multiplayerSessions,
         enrolledParticipants: enrolledParticipants,
         activeParticipants: activeParticipants,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminLiveUsage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminLiveUsage copyWith({
    int? ongoingSessions,
    int? soloSessions,
    int? multiplayerSessions,
    int? enrolledParticipants,
    int? activeParticipants,
    DateTime? generatedAt,
  }) {
    return AdminLiveUsage(
      ongoingSessions: ongoingSessions ?? this.ongoingSessions,
      soloSessions: soloSessions ?? this.soloSessions,
      multiplayerSessions: multiplayerSessions ?? this.multiplayerSessions,
      enrolledParticipants: enrolledParticipants ?? this.enrolledParticipants,
      activeParticipants: activeParticipants ?? this.activeParticipants,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
