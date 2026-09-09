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
import 'session_view.dart' as _i2;
import 'participant_view.dart' as _i3;
import 'session_result_tally.dart' as _i4;
import 'destination_choice_state.dart' as _i5;
import 'package:hayer_client/src/protocol/protocol.dart' as _i6;

abstract class SessionProgress implements _i1.SerializableModel {
  SessionProgress._({
    required this.session,
    required this.participants,
    required this.selfParticipant,
    required this.resultTallies,
    this.destinationChoices,
  });

  factory SessionProgress({
    required _i2.SessionView session,
    required List<_i3.ParticipantView> participants,
    required _i3.ParticipantView selfParticipant,
    required List<_i4.SessionResultTally> resultTallies,
    _i5.DestinationChoiceState? destinationChoices,
  }) = _SessionProgressImpl;

  factory SessionProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionProgress(
      session: _i6.Protocol().deserialize<_i2.SessionView>(
        jsonSerialization['session'],
      ),
      participants: _i6.Protocol().deserialize<List<_i3.ParticipantView>>(
        jsonSerialization['participants'],
      ),
      selfParticipant: _i6.Protocol().deserialize<_i3.ParticipantView>(
        jsonSerialization['selfParticipant'],
      ),
      resultTallies: _i6.Protocol().deserialize<List<_i4.SessionResultTally>>(
        jsonSerialization['resultTallies'],
      ),
      destinationChoices: jsonSerialization['destinationChoices'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.DestinationChoiceState>(
              jsonSerialization['destinationChoices'],
            ),
    );
  }

  _i2.SessionView session;

  List<_i3.ParticipantView> participants;

  _i3.ParticipantView selfParticipant;

  List<_i4.SessionResultTally> resultTallies;

  _i5.DestinationChoiceState? destinationChoices;

  /// Returns a shallow copy of this [SessionProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionProgress copyWith({
    _i2.SessionView? session,
    List<_i3.ParticipantView>? participants,
    _i3.ParticipantView? selfParticipant,
    List<_i4.SessionResultTally>? resultTallies,
    _i5.DestinationChoiceState? destinationChoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionProgress',
      'session': session.toJson(),
      'participants': participants.toJson(valueToJson: (v) => v.toJson()),
      'selfParticipant': selfParticipant.toJson(),
      'resultTallies': resultTallies.toJson(valueToJson: (v) => v.toJson()),
      if (destinationChoices != null)
        'destinationChoices': destinationChoices?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionProgressImpl extends SessionProgress {
  _SessionProgressImpl({
    required _i2.SessionView session,
    required List<_i3.ParticipantView> participants,
    required _i3.ParticipantView selfParticipant,
    required List<_i4.SessionResultTally> resultTallies,
    _i5.DestinationChoiceState? destinationChoices,
  }) : super._(
         session: session,
         participants: participants,
         selfParticipant: selfParticipant,
         resultTallies: resultTallies,
         destinationChoices: destinationChoices,
       );

  /// Returns a shallow copy of this [SessionProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SessionProgress copyWith({
    _i2.SessionView? session,
    List<_i3.ParticipantView>? participants,
    _i3.ParticipantView? selfParticipant,
    List<_i4.SessionResultTally>? resultTallies,
    Object? destinationChoices = _Undefined,
  }) {
    return SessionProgress(
      session: session ?? this.session.copyWith(),
      participants:
          participants ?? this.participants.map((e0) => e0.copyWith()).toList(),
      selfParticipant: selfParticipant ?? this.selfParticipant.copyWith(),
      resultTallies:
          resultTallies ??
          this.resultTallies.map((e0) => e0.copyWith()).toList(),
      destinationChoices: destinationChoices is _i5.DestinationChoiceState?
          ? destinationChoices
          : this.destinationChoices?.copyWith(),
    );
  }
}
