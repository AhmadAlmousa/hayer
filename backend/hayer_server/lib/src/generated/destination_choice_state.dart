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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;

abstract class DestinationChoiceState
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DestinationChoiceState._({
    required this.eligiblePlaceIds,
    required this.counts,
    this.myPlaceId,
    required this.myRevision,
    this.winnerPlaceId,
    required this.tiedPlaceIds,
    required this.chosenCount,
    required this.participantCount,
    required this.canChoose,
    required this.isComplete,
    required this.hostBrokeTie,
  });

  factory DestinationChoiceState({
    required List<String> eligiblePlaceIds,
    required Map<String, int> counts,
    String? myPlaceId,
    required int myRevision,
    String? winnerPlaceId,
    required List<String> tiedPlaceIds,
    required int chosenCount,
    required int participantCount,
    required bool canChoose,
    required bool isComplete,
    required bool hostBrokeTie,
  }) = _DestinationChoiceStateImpl;

  factory DestinationChoiceState.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DestinationChoiceState(
      eligiblePlaceIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['eligiblePlaceIds'],
      ),
      counts: _i66y2smk.Protocol().deserialize<Map<String, int>>(
        jsonSerialization['counts'],
      ),
      myPlaceId: jsonSerialization['myPlaceId'] as String?,
      myRevision: jsonSerialization['myRevision'] as int,
      winnerPlaceId: jsonSerialization['winnerPlaceId'] as String?,
      tiedPlaceIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['tiedPlaceIds'],
      ),
      chosenCount: jsonSerialization['chosenCount'] as int,
      participantCount: jsonSerialization['participantCount'] as int,
      canChoose: _is.BoolJsonExtension.fromJson(jsonSerialization['canChoose']),
      isComplete: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isComplete'],
      ),
      hostBrokeTie: _is.BoolJsonExtension.fromJson(
        jsonSerialization['hostBrokeTie'],
      ),
    );
  }

  List<String> eligiblePlaceIds;

  Map<String, int> counts;

  String? myPlaceId;

  int myRevision;

  String? winnerPlaceId;

  List<String> tiedPlaceIds;

  int chosenCount;

  int participantCount;

  bool canChoose;

  bool isComplete;

  bool hostBrokeTie;

  /// Returns a shallow copy of this [DestinationChoiceState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DestinationChoiceState copyWith({
    List<String>? eligiblePlaceIds,
    Map<String, int>? counts,
    String? myPlaceId,
    int? myRevision,
    String? winnerPlaceId,
    List<String>? tiedPlaceIds,
    int? chosenCount,
    int? participantCount,
    bool? canChoose,
    bool? isComplete,
    bool? hostBrokeTie,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DestinationChoiceState',
      'eligiblePlaceIds': eligiblePlaceIds.toJson(),
      'counts': counts.toJson(),
      if (myPlaceId != null) 'myPlaceId': myPlaceId,
      'myRevision': myRevision,
      if (winnerPlaceId != null) 'winnerPlaceId': winnerPlaceId,
      'tiedPlaceIds': tiedPlaceIds.toJson(),
      'chosenCount': chosenCount,
      'participantCount': participantCount,
      'canChoose': canChoose,
      'isComplete': isComplete,
      'hostBrokeTie': hostBrokeTie,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DestinationChoiceState',
      'eligiblePlaceIds': eligiblePlaceIds.toJson(),
      'counts': counts.toJson(),
      if (myPlaceId != null) 'myPlaceId': myPlaceId,
      'myRevision': myRevision,
      if (winnerPlaceId != null) 'winnerPlaceId': winnerPlaceId,
      'tiedPlaceIds': tiedPlaceIds.toJson(),
      'chosenCount': chosenCount,
      'participantCount': participantCount,
      'canChoose': canChoose,
      'isComplete': isComplete,
      'hostBrokeTie': hostBrokeTie,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DestinationChoiceStateImpl extends DestinationChoiceState {
  _DestinationChoiceStateImpl({
    required List<String> eligiblePlaceIds,
    required Map<String, int> counts,
    String? myPlaceId,
    required int myRevision,
    String? winnerPlaceId,
    required List<String> tiedPlaceIds,
    required int chosenCount,
    required int participantCount,
    required bool canChoose,
    required bool isComplete,
    required bool hostBrokeTie,
  }) : super._(
         eligiblePlaceIds: eligiblePlaceIds,
         counts: counts,
         myPlaceId: myPlaceId,
         myRevision: myRevision,
         winnerPlaceId: winnerPlaceId,
         tiedPlaceIds: tiedPlaceIds,
         chosenCount: chosenCount,
         participantCount: participantCount,
         canChoose: canChoose,
         isComplete: isComplete,
         hostBrokeTie: hostBrokeTie,
       );

  /// Returns a shallow copy of this [DestinationChoiceState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DestinationChoiceState copyWith({
    List<String>? eligiblePlaceIds,
    Map<String, int>? counts,
    Object? myPlaceId = _Undefined,
    int? myRevision,
    Object? winnerPlaceId = _Undefined,
    List<String>? tiedPlaceIds,
    int? chosenCount,
    int? participantCount,
    bool? canChoose,
    bool? isComplete,
    bool? hostBrokeTie,
  }) {
    return DestinationChoiceState(
      eligiblePlaceIds:
          eligiblePlaceIds ?? this.eligiblePlaceIds.map((e0) => e0).toList(),
      counts:
          counts ??
          this.counts.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      myPlaceId: myPlaceId is String? ? myPlaceId : this.myPlaceId,
      myRevision: myRevision ?? this.myRevision,
      winnerPlaceId: winnerPlaceId is String?
          ? winnerPlaceId
          : this.winnerPlaceId,
      tiedPlaceIds: tiedPlaceIds ?? this.tiedPlaceIds.map((e0) => e0).toList(),
      chosenCount: chosenCount ?? this.chosenCount,
      participantCount: participantCount ?? this.participantCount,
      canChoose: canChoose ?? this.canChoose,
      isComplete: isComplete ?? this.isComplete,
      hostBrokeTie: hostBrokeTie ?? this.hostBrokeTie,
    );
  }
}
