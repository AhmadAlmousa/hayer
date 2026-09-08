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
import 'place_snapshot.dart' as _i3;
import 'participant_view.dart' as _i4;
import 'route_estimate_policy.dart' as _i5;
import 'destination_choice_state.dart' as _i6;
import 'package:hayer_client/src/protocol/protocol.dart' as _i7;

abstract class SessionBundle implements _i1.SerializableModel {
  SessionBundle._({
    required this.session,
    required this.deck,
    required this.participants,
    required this.selfParticipant,
    this.routeEstimatePolicy,
    this.destinationChoices,
  });

  factory SessionBundle({
    required _i2.SessionView session,
    required List<_i3.PlaceSnapshot> deck,
    required List<_i4.ParticipantView> participants,
    required _i4.ParticipantView selfParticipant,
    _i5.RouteEstimatePolicy? routeEstimatePolicy,
    _i6.DestinationChoiceState? destinationChoices,
  }) = _SessionBundleImpl;

  factory SessionBundle.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionBundle(
      session: _i7.Protocol().deserialize<_i2.SessionView>(
        jsonSerialization['session'],
      ),
      deck: _i7.Protocol().deserialize<List<_i3.PlaceSnapshot>>(
        jsonSerialization['deck'],
      ),
      participants: _i7.Protocol().deserialize<List<_i4.ParticipantView>>(
        jsonSerialization['participants'],
      ),
      selfParticipant: _i7.Protocol().deserialize<_i4.ParticipantView>(
        jsonSerialization['selfParticipant'],
      ),
      routeEstimatePolicy: jsonSerialization['routeEstimatePolicy'] == null
          ? null
          : _i7.Protocol().deserialize<_i5.RouteEstimatePolicy>(
              jsonSerialization['routeEstimatePolicy'],
            ),
      destinationChoices: jsonSerialization['destinationChoices'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.DestinationChoiceState>(
              jsonSerialization['destinationChoices'],
            ),
    );
  }

  _i2.SessionView session;

  List<_i3.PlaceSnapshot> deck;

  List<_i4.ParticipantView> participants;

  _i4.ParticipantView selfParticipant;

  _i5.RouteEstimatePolicy? routeEstimatePolicy;

  _i6.DestinationChoiceState? destinationChoices;

  /// Returns a shallow copy of this [SessionBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionBundle copyWith({
    _i2.SessionView? session,
    List<_i3.PlaceSnapshot>? deck,
    List<_i4.ParticipantView>? participants,
    _i4.ParticipantView? selfParticipant,
    _i5.RouteEstimatePolicy? routeEstimatePolicy,
    _i6.DestinationChoiceState? destinationChoices,
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionBundleImpl extends SessionBundle {
  _SessionBundleImpl({
    required _i2.SessionView session,
    required List<_i3.PlaceSnapshot> deck,
    required List<_i4.ParticipantView> participants,
    required _i4.ParticipantView selfParticipant,
    _i5.RouteEstimatePolicy? routeEstimatePolicy,
    _i6.DestinationChoiceState? destinationChoices,
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
  @_i1.useResult
  @override
  SessionBundle copyWith({
    _i2.SessionView? session,
    List<_i3.PlaceSnapshot>? deck,
    List<_i4.ParticipantView>? participants,
    _i4.ParticipantView? selfParticipant,
    Object? routeEstimatePolicy = _Undefined,
    Object? destinationChoices = _Undefined,
  }) {
    return SessionBundle(
      session: session ?? this.session.copyWith(),
      deck: deck ?? this.deck.map((e0) => e0.copyWith()).toList(),
      participants:
          participants ?? this.participants.map((e0) => e0.copyWith()).toList(),
      selfParticipant: selfParticipant ?? this.selfParticipant.copyWith(),
      routeEstimatePolicy: routeEstimatePolicy is _i5.RouteEstimatePolicy?
          ? routeEstimatePolicy
          : this.routeEstimatePolicy?.copyWith(),
      destinationChoices: destinationChoices is _i6.DestinationChoiceState?
          ? destinationChoices
          : this.destinationChoices?.copyWith(),
    );
  }
}
