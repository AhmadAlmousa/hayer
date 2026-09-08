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
import 'client_analytics_context.dart' as _i2;
import 'package:hayer_client/src/protocol/protocol.dart' as _i3;

abstract class SwipeCommand implements _i1.SerializableModel {
  SwipeCommand._({
    required this.sessionId,
    required this.placeId,
    required this.liked,
    required this.swipeIndex,
    required this.clientSwipedAt,
    required this.idempotencyKey,
    this.analyticsContext,
  });

  factory SwipeCommand({
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    required DateTime clientSwipedAt,
    required String idempotencyKey,
    _i2.ClientAnalyticsContext? analyticsContext,
  }) = _SwipeCommandImpl;

  factory SwipeCommand.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwipeCommand(
      sessionId: jsonSerialization['sessionId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      liked: _i1.BoolJsonExtension.fromJson(jsonSerialization['liked']),
      swipeIndex: jsonSerialization['swipeIndex'] as int,
      clientSwipedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['clientSwipedAt'],
      ),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      analyticsContext: jsonSerialization['analyticsContext'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.ClientAnalyticsContext>(
              jsonSerialization['analyticsContext'],
            ),
    );
  }

  String sessionId;

  String placeId;

  bool liked;

  int swipeIndex;

  DateTime clientSwipedAt;

  String idempotencyKey;

  _i2.ClientAnalyticsContext? analyticsContext;

  /// Returns a shallow copy of this [SwipeCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SwipeCommand copyWith({
    String? sessionId,
    String? placeId,
    bool? liked,
    int? swipeIndex,
    DateTime? clientSwipedAt,
    String? idempotencyKey,
    _i2.ClientAnalyticsContext? analyticsContext,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwipeCommand',
      'sessionId': sessionId,
      'placeId': placeId,
      'liked': liked,
      'swipeIndex': swipeIndex,
      'clientSwipedAt': clientSwipedAt.toJson(),
      'idempotencyKey': idempotencyKey,
      if (analyticsContext != null)
        'analyticsContext': analyticsContext?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwipeCommandImpl extends SwipeCommand {
  _SwipeCommandImpl({
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    required DateTime clientSwipedAt,
    required String idempotencyKey,
    _i2.ClientAnalyticsContext? analyticsContext,
  }) : super._(
         sessionId: sessionId,
         placeId: placeId,
         liked: liked,
         swipeIndex: swipeIndex,
         clientSwipedAt: clientSwipedAt,
         idempotencyKey: idempotencyKey,
         analyticsContext: analyticsContext,
       );

  /// Returns a shallow copy of this [SwipeCommand]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SwipeCommand copyWith({
    String? sessionId,
    String? placeId,
    bool? liked,
    int? swipeIndex,
    DateTime? clientSwipedAt,
    String? idempotencyKey,
    Object? analyticsContext = _Undefined,
  }) {
    return SwipeCommand(
      sessionId: sessionId ?? this.sessionId,
      placeId: placeId ?? this.placeId,
      liked: liked ?? this.liked,
      swipeIndex: swipeIndex ?? this.swipeIndex,
      clientSwipedAt: clientSwipedAt ?? this.clientSwipedAt,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      analyticsContext: analyticsContext is _i2.ClientAnalyticsContext?
          ? analyticsContext
          : this.analyticsContext?.copyWith(),
    );
  }
}
