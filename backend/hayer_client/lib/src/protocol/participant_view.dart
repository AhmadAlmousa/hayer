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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class ParticipantView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ParticipantView._({
    required this.participantId,
    required this.displayName,
    required this.isHost,
    required this.currentIndex,
    required this.hasCompleted,
    required this.lastSeenAt,
  });

  factory ParticipantView({
    required String participantId,
    required String displayName,
    required bool isHost,
    required int currentIndex,
    required bool hasCompleted,
    required DateTime lastSeenAt,
  }) = _ParticipantViewImpl;

  factory ParticipantView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParticipantView(
      participantId: jsonSerialization['participantId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      isHost: _isc.BoolJsonExtension.fromJson(jsonSerialization['isHost']),
      currentIndex: jsonSerialization['currentIndex'] as int,
      hasCompleted: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['hasCompleted'],
      ),
      lastSeenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  String participantId;

  String displayName;

  bool isHost;

  int currentIndex;

  bool hasCompleted;

  DateTime lastSeenAt;

  /// Returns a shallow copy of this [ParticipantView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ParticipantView copyWith({
    String? participantId,
    String? displayName,
    bool? isHost,
    int? currentIndex,
    bool? hasCompleted,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParticipantView',
      'participantId': participantId,
      'displayName': displayName,
      'isHost': isHost,
      'currentIndex': currentIndex,
      'hasCompleted': hasCompleted,
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ParticipantView',
      'participantId': participantId,
      'displayName': displayName,
      'isHost': isHost,
      'currentIndex': currentIndex,
      'hasCompleted': hasCompleted,
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ParticipantViewImpl extends ParticipantView {
  _ParticipantViewImpl({
    required String participantId,
    required String displayName,
    required bool isHost,
    required int currentIndex,
    required bool hasCompleted,
    required DateTime lastSeenAt,
  }) : super._(
         participantId: participantId,
         displayName: displayName,
         isHost: isHost,
         currentIndex: currentIndex,
         hasCompleted: hasCompleted,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [ParticipantView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ParticipantView copyWith({
    String? participantId,
    String? displayName,
    bool? isHost,
    int? currentIndex,
    bool? hasCompleted,
    DateTime? lastSeenAt,
  }) {
    return ParticipantView(
      participantId: participantId ?? this.participantId,
      displayName: displayName ?? this.displayName,
      isHost: isHost ?? this.isHost,
      currentIndex: currentIndex ?? this.currentIndex,
      hasCompleted: hasCompleted ?? this.hasCompleted,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
