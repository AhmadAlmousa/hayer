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
import 'destination_choice_state.dart' as _ivseuofk;
import 'participant_view.dart' as _ir2xxgfs;
import 'session_result_tally.dart' as _itcvdkdx;
import 'session_view.dart' as _ivtyz9dh;

abstract class SessionProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SessionProgress._({
    required this.session,
    required this.participants,
    required this.selfParticipant,
    required this.resultTallies,
    this.destinationChoices,
  });

  factory SessionProgress({
    required _ivtyz9dh.SessionView session,
    required List<_ir2xxgfs.ParticipantView> participants,
    required _ir2xxgfs.ParticipantView selfParticipant,
    required List<_itcvdkdx.SessionResultTally> resultTallies,
    _ivseuofk.DestinationChoiceState? destinationChoices,
  }) = _SessionProgressImpl;

  factory SessionProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionProgress(
      session: _iynev3sz.Protocol().deserialize<_ivtyz9dh.SessionView>(
        jsonSerialization['session'],
      ),
      participants: _iynev3sz.Protocol()
          .deserialize<List<_ir2xxgfs.ParticipantView>>(
            jsonSerialization['participants'],
          ),
      selfParticipant: _iynev3sz.Protocol()
          .deserialize<_ir2xxgfs.ParticipantView>(
            jsonSerialization['selfParticipant'],
          ),
      resultTallies: _iynev3sz.Protocol()
          .deserialize<List<_itcvdkdx.SessionResultTally>>(
            jsonSerialization['resultTallies'],
          ),
      destinationChoices: jsonSerialization['destinationChoices'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_ivseuofk.DestinationChoiceState>(
              jsonSerialization['destinationChoices'],
            ),
    );
  }

  _ivtyz9dh.SessionView session;

  List<_ir2xxgfs.ParticipantView> participants;

  _ir2xxgfs.ParticipantView selfParticipant;

  List<_itcvdkdx.SessionResultTally> resultTallies;

  _ivseuofk.DestinationChoiceState? destinationChoices;

  /// Returns a shallow copy of this [SessionProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SessionProgress copyWith({
    _ivtyz9dh.SessionView? session,
    List<_ir2xxgfs.ParticipantView>? participants,
    _ir2xxgfs.ParticipantView? selfParticipant,
    List<_itcvdkdx.SessionResultTally>? resultTallies,
    _ivseuofk.DestinationChoiceState? destinationChoices,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SessionProgress',
      'session': session.toJsonForProtocol(),
      'participants': participants.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'selfParticipant': selfParticipant.toJsonForProtocol(),
      'resultTallies': resultTallies.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (destinationChoices != null)
        'destinationChoices': destinationChoices?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionProgressImpl extends SessionProgress {
  _SessionProgressImpl({
    required _ivtyz9dh.SessionView session,
    required List<_ir2xxgfs.ParticipantView> participants,
    required _ir2xxgfs.ParticipantView selfParticipant,
    required List<_itcvdkdx.SessionResultTally> resultTallies,
    _ivseuofk.DestinationChoiceState? destinationChoices,
  }) : super._(
         session: session,
         participants: participants,
         selfParticipant: selfParticipant,
         resultTallies: resultTallies,
         destinationChoices: destinationChoices,
       );

  /// Returns a shallow copy of this [SessionProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SessionProgress copyWith({
    _ivtyz9dh.SessionView? session,
    List<_ir2xxgfs.ParticipantView>? participants,
    _ir2xxgfs.ParticipantView? selfParticipant,
    List<_itcvdkdx.SessionResultTally>? resultTallies,
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
      destinationChoices:
          destinationChoices is _ivseuofk.DestinationChoiceState?
          ? destinationChoices
          : this.destinationChoices?.copyWith(),
    );
  }
}
