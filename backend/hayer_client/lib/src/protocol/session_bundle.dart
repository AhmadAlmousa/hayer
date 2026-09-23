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
import 'place_snapshot.dart' as _ikbous9x;
import 'route_estimate_policy.dart' as _i3152jei;
import 'session_view.dart' as _ivtyz9dh;

abstract class SessionBundle
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SessionBundle._({
    required this.session,
    required this.deck,
    required this.participants,
    required this.selfParticipant,
    this.routeEstimatePolicy,
    this.destinationChoices,
  });

  factory SessionBundle({
    required _ivtyz9dh.SessionView session,
    required List<_ikbous9x.PlaceSnapshot> deck,
    required List<_ir2xxgfs.ParticipantView> participants,
    required _ir2xxgfs.ParticipantView selfParticipant,
    _i3152jei.RouteEstimatePolicy? routeEstimatePolicy,
    _ivseuofk.DestinationChoiceState? destinationChoices,
  }) = _SessionBundleImpl;

  factory SessionBundle.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionBundle(
      session: _iynev3sz.Protocol().deserialize<_ivtyz9dh.SessionView>(
        jsonSerialization['session'],
      ),
      deck: _iynev3sz.Protocol().deserialize<List<_ikbous9x.PlaceSnapshot>>(
        jsonSerialization['deck'],
      ),
      participants: _iynev3sz.Protocol()
          .deserialize<List<_ir2xxgfs.ParticipantView>>(
            jsonSerialization['participants'],
          ),
      selfParticipant: _iynev3sz.Protocol()
          .deserialize<_ir2xxgfs.ParticipantView>(
            jsonSerialization['selfParticipant'],
          ),
      routeEstimatePolicy: jsonSerialization['routeEstimatePolicy'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_i3152jei.RouteEstimatePolicy>(
              jsonSerialization['routeEstimatePolicy'],
            ),
      destinationChoices: jsonSerialization['destinationChoices'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_ivseuofk.DestinationChoiceState>(
              jsonSerialization['destinationChoices'],
            ),
    );
  }

  _ivtyz9dh.SessionView session;

  List<_ikbous9x.PlaceSnapshot> deck;

  List<_ir2xxgfs.ParticipantView> participants;

  _ir2xxgfs.ParticipantView selfParticipant;

  _i3152jei.RouteEstimatePolicy? routeEstimatePolicy;

  _ivseuofk.DestinationChoiceState? destinationChoices;

  /// Returns a shallow copy of this [SessionBundle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SessionBundle copyWith({
    _ivtyz9dh.SessionView? session,
    List<_ikbous9x.PlaceSnapshot>? deck,
    List<_ir2xxgfs.ParticipantView>? participants,
    _ir2xxgfs.ParticipantView? selfParticipant,
    _i3152jei.RouteEstimatePolicy? routeEstimatePolicy,
    _ivseuofk.DestinationChoiceState? destinationChoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionBundle',
      'session': session.toJson(),
      'deck': deck.toJson(valueToJson: (v) => v.toJson()),
      'participants': participants.toJson(valueToJson: (v) => v.toJson()),
      'selfParticipant': selfParticipant.toJson(),
      if (routeEstimatePolicy != null)
        'routeEstimatePolicy': routeEstimatePolicy?.toJson(),
      if (destinationChoices != null)
        'destinationChoices': destinationChoices?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SessionBundle',
      'session': session.toJsonForProtocol(),
      'deck': deck.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'participants': participants.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'selfParticipant': selfParticipant.toJsonForProtocol(),
      if (routeEstimatePolicy != null)
        'routeEstimatePolicy': routeEstimatePolicy?.toJsonForProtocol(),
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

class _SessionBundleImpl extends SessionBundle {
  _SessionBundleImpl({
    required _ivtyz9dh.SessionView session,
    required List<_ikbous9x.PlaceSnapshot> deck,
    required List<_ir2xxgfs.ParticipantView> participants,
    required _ir2xxgfs.ParticipantView selfParticipant,
    _i3152jei.RouteEstimatePolicy? routeEstimatePolicy,
    _ivseuofk.DestinationChoiceState? destinationChoices,
  }) : super._(
         session: session,
         deck: deck,
         participants: participants,
         selfParticipant: selfParticipant,
         routeEstimatePolicy: routeEstimatePolicy,
         destinationChoices: destinationChoices,
       );

  /// Returns a shallow copy of this [SessionBundle]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SessionBundle copyWith({
    _ivtyz9dh.SessionView? session,
    List<_ikbous9x.PlaceSnapshot>? deck,
    List<_ir2xxgfs.ParticipantView>? participants,
    _ir2xxgfs.ParticipantView? selfParticipant,
    Object? routeEstimatePolicy = _Undefined,
    Object? destinationChoices = _Undefined,
  }) {
    return SessionBundle(
      session: session ?? this.session.copyWith(),
      deck: deck ?? this.deck.map((e0) => e0.copyWith()).toList(),
      participants:
          participants ?? this.participants.map((e0) => e0.copyWith()).toList(),
      selfParticipant: selfParticipant ?? this.selfParticipant.copyWith(),
      routeEstimatePolicy: routeEstimatePolicy is _i3152jei.RouteEstimatePolicy?
          ? routeEstimatePolicy
          : this.routeEstimatePolicy?.copyWith(),
      destinationChoices:
          destinationChoices is _ivseuofk.DestinationChoiceState?
          ? destinationChoices
          : this.destinationChoices?.copyWith(),
    );
  }
}
