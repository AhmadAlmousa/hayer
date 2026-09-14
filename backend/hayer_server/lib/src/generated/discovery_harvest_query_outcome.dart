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
import 'discovery_harvest_query_kind.dart' as _i2;
import 'discovery_harvest_query_state.dart' as _i3;

abstract class DiscoveryHarvestQueryOutcome
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryHarvestQueryOutcome._({
    required this.entryId,
    required this.kind,
    required this.query,
    required this.languageCode,
    required this.state,
    required this.pagesAttempted,
    required this.observedPlaces,
    required this.upstreamRequests,
    this.failureCode,
  });

  factory DiscoveryHarvestQueryOutcome({
    required String entryId,
    required _i2.DiscoveryHarvestQueryKind kind,
    required String query,
    required String languageCode,
    required _i3.DiscoveryHarvestQueryState state,
    required int pagesAttempted,
    required int observedPlaces,
    required int upstreamRequests,
    String? failureCode,
  }) = _DiscoveryHarvestQueryOutcomeImpl;

  factory DiscoveryHarvestQueryOutcome.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryHarvestQueryOutcome(
      entryId: jsonSerialization['entryId'] as String,
      kind: _i2.DiscoveryHarvestQueryKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      query: jsonSerialization['query'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      state: _i3.DiscoveryHarvestQueryState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      pagesAttempted: jsonSerialization['pagesAttempted'] as int,
      observedPlaces: jsonSerialization['observedPlaces'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
      failureCode: jsonSerialization['failureCode'] as String?,
    );
  }

  String entryId;

  _i2.DiscoveryHarvestQueryKind kind;

  String query;

  String languageCode;

  _i3.DiscoveryHarvestQueryState state;

  int pagesAttempted;

  int observedPlaces;

  int upstreamRequests;

  String? failureCode;

  /// Returns a shallow copy of this [DiscoveryHarvestQueryOutcome]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryHarvestQueryOutcome copyWith({
    String? entryId,
    _i2.DiscoveryHarvestQueryKind? kind,
    String? query,
    String? languageCode,
    _i3.DiscoveryHarvestQueryState? state,
    int? pagesAttempted,
    int? observedPlaces,
    int? upstreamRequests,
    String? failureCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestQueryOutcome',
      'entryId': entryId,
      'kind': kind.toJson(),
      'query': query,
      'languageCode': languageCode,
      'state': state.toJson(),
      'pagesAttempted': pagesAttempted,
      'observedPlaces': observedPlaces,
      'upstreamRequests': upstreamRequests,
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryHarvestQueryOutcome',
      'entryId': entryId,
      'kind': kind.toJson(),
      'query': query,
      'languageCode': languageCode,
      'state': state.toJson(),
      'pagesAttempted': pagesAttempted,
      'observedPlaces': observedPlaces,
      'upstreamRequests': upstreamRequests,
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestQueryOutcomeImpl extends DiscoveryHarvestQueryOutcome {
  _DiscoveryHarvestQueryOutcomeImpl({
    required String entryId,
    required _i2.DiscoveryHarvestQueryKind kind,
    required String query,
    required String languageCode,
    required _i3.DiscoveryHarvestQueryState state,
    required int pagesAttempted,
    required int observedPlaces,
    required int upstreamRequests,
    String? failureCode,
  }) : super._(
         entryId: entryId,
         kind: kind,
         query: query,
         languageCode: languageCode,
         state: state,
         pagesAttempted: pagesAttempted,
         observedPlaces: observedPlaces,
         upstreamRequests: upstreamRequests,
         failureCode: failureCode,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestQueryOutcome]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryHarvestQueryOutcome copyWith({
    String? entryId,
    _i2.DiscoveryHarvestQueryKind? kind,
    String? query,
    String? languageCode,
    _i3.DiscoveryHarvestQueryState? state,
    int? pagesAttempted,
    int? observedPlaces,
    int? upstreamRequests,
    Object? failureCode = _Undefined,
  }) {
    return DiscoveryHarvestQueryOutcome(
      entryId: entryId ?? this.entryId,
      kind: kind ?? this.kind,
      query: query ?? this.query,
      languageCode: languageCode ?? this.languageCode,
      state: state ?? this.state,
      pagesAttempted: pagesAttempted ?? this.pagesAttempted,
      observedPlaces: observedPlaces ?? this.observedPlaces,
      upstreamRequests: upstreamRequests ?? this.upstreamRequests,
      failureCode: failureCode is String? ? failureCode : this.failureCode,
    );
  }
}
