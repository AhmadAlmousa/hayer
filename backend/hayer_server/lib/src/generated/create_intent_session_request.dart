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
import 'client_analytics_context.dart' as _iae9jhcw;
import 'consensus_rule.dart' as _idhfk3qj;
import 'matching_timing.dart' as _inbmjteu;
import 'place_intent_query.dart' as _i151h6s7;
import 'session_mode.dart' as _i7rc03rf;

abstract class CreateIntentSessionRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CreateIntentSessionRequest._({
    required this.mode,
    required this.intent,
    this.displayName,
    required this.consensusRule,
    required this.matchingTiming,
    this.analyticsContext,
  });

  factory CreateIntentSessionRequest({
    required _i7rc03rf.SessionMode mode,
    required _i151h6s7.PlaceIntentQuery intent,
    String? displayName,
    required _idhfk3qj.ConsensusRule consensusRule,
    required _inbmjteu.MatchingTiming matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
  }) = _CreateIntentSessionRequestImpl;

  factory CreateIntentSessionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateIntentSessionRequest(
      mode: _i7rc03rf.SessionMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      intent: _i66y2smk.Protocol().deserialize<_i151h6s7.PlaceIntentQuery>(
        jsonSerialization['intent'],
      ),
      displayName: jsonSerialization['displayName'] as String?,
      consensusRule: _idhfk3qj.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _inbmjteu.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      analyticsContext: jsonSerialization['analyticsContext'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_iae9jhcw.ClientAnalyticsContext>(
              jsonSerialization['analyticsContext'],
            ),
    );
  }

  _i7rc03rf.SessionMode mode;

  _i151h6s7.PlaceIntentQuery intent;

  String? displayName;

  _idhfk3qj.ConsensusRule consensusRule;

  _inbmjteu.MatchingTiming matchingTiming;

  _iae9jhcw.ClientAnalyticsContext? analyticsContext;

  /// Returns a shallow copy of this [CreateIntentSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CreateIntentSessionRequest copyWith({
    _i7rc03rf.SessionMode? mode,
    _i151h6s7.PlaceIntentQuery? intent,
    String? displayName,
    _idhfk3qj.ConsensusRule? consensusRule,
    _inbmjteu.MatchingTiming? matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateIntentSessionRequest',
      'mode': mode.toJson(),
      'intent': intent.toJson(),
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateIntentSessionRequest',
      'mode': mode.toJson(),
      'intent': intent.toJsonForProtocol(),
      if (displayName != null) 'displayName': displayName,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateIntentSessionRequestImpl extends CreateIntentSessionRequest {
  _CreateIntentSessionRequestImpl({
    required _i7rc03rf.SessionMode mode,
    required _i151h6s7.PlaceIntentQuery intent,
    String? displayName,
    required _idhfk3qj.ConsensusRule consensusRule,
    required _inbmjteu.MatchingTiming matchingTiming,
    _iae9jhcw.ClientAnalyticsContext? analyticsContext,
  }) : super._(
         mode: mode,
         intent: intent,
         displayName: displayName,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
         analyticsContext: analyticsContext,
       );

  /// Returns a shallow copy of this [CreateIntentSessionRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CreateIntentSessionRequest copyWith({
    _i7rc03rf.SessionMode? mode,
    _i151h6s7.PlaceIntentQuery? intent,
    Object? displayName = _Undefined,
    _idhfk3qj.ConsensusRule? consensusRule,
    _inbmjteu.MatchingTiming? matchingTiming,
    Object? analyticsContext = _Undefined,
  }) {
    return CreateIntentSessionRequest(
      mode: mode ?? this.mode,
      intent: intent ?? this.intent.copyWith(),
      displayName: displayName is String? ? displayName : this.displayName,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
      analyticsContext: analyticsContext is _iae9jhcw.ClientAnalyticsContext?
          ? analyticsContext
          : this.analyticsContext?.copyWith(),
    );
  }
}
