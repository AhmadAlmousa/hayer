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
import 'package:serverpod/serverpod.dart' as _is;
import 'discovery_metric_mode.dart' as _iwc51qy2;
import 'discovery_metric_operation.dart' as _ipgnhxya;

abstract class DiscoveryGrowthMetricBreakdown
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryGrowthMetricBreakdown._({
    required this.mode,
    required this.operation,
    required this.observations,
    required this.newCatalogPlaces,
    required this.cacheHits,
    required this.cacheMisses,
    required this.detailRefreshes,
    required this.upstreamRequests,
  });

  factory DiscoveryGrowthMetricBreakdown({
    required _iwc51qy2.DiscoveryMetricMode mode,
    required _ipgnhxya.DiscoveryMetricOperation operation,
    required int observations,
    required int newCatalogPlaces,
    required int cacheHits,
    required int cacheMisses,
    required int detailRefreshes,
    required int upstreamRequests,
  }) = _DiscoveryGrowthMetricBreakdownImpl;

  factory DiscoveryGrowthMetricBreakdown.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryGrowthMetricBreakdown(
      mode: _iwc51qy2.DiscoveryMetricMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      operation: _ipgnhxya.DiscoveryMetricOperation.fromJson(
        (jsonSerialization['operation'] as String),
      ),
      observations: jsonSerialization['observations'] as int,
      newCatalogPlaces: jsonSerialization['newCatalogPlaces'] as int,
      cacheHits: jsonSerialization['cacheHits'] as int,
      cacheMisses: jsonSerialization['cacheMisses'] as int,
      detailRefreshes: jsonSerialization['detailRefreshes'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
    );
  }

  _iwc51qy2.DiscoveryMetricMode mode;

  _ipgnhxya.DiscoveryMetricOperation operation;

  int observations;

  int newCatalogPlaces;

  int cacheHits;

  int cacheMisses;

  int detailRefreshes;

  int upstreamRequests;

  /// Returns a shallow copy of this [DiscoveryGrowthMetricBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryGrowthMetricBreakdown copyWith({
    _iwc51qy2.DiscoveryMetricMode? mode,
    _ipgnhxya.DiscoveryMetricOperation? operation,
    int? observations,
    int? newCatalogPlaces,
    int? cacheHits,
    int? cacheMisses,
    int? detailRefreshes,
    int? upstreamRequests,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryGrowthMetricBreakdown',
      'mode': mode.toJson(),
      'operation': operation.toJson(),
      'observations': observations,
      'newCatalogPlaces': newCatalogPlaces,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'detailRefreshes': detailRefreshes,
      'upstreamRequests': upstreamRequests,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryGrowthMetricBreakdown',
      'mode': mode.toJson(),
      'operation': operation.toJson(),
      'observations': observations,
      'newCatalogPlaces': newCatalogPlaces,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'detailRefreshes': detailRefreshes,
      'upstreamRequests': upstreamRequests,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DiscoveryGrowthMetricBreakdownImpl
    extends DiscoveryGrowthMetricBreakdown {
  _DiscoveryGrowthMetricBreakdownImpl({
    required _iwc51qy2.DiscoveryMetricMode mode,
    required _ipgnhxya.DiscoveryMetricOperation operation,
    required int observations,
    required int newCatalogPlaces,
    required int cacheHits,
    required int cacheMisses,
    required int detailRefreshes,
    required int upstreamRequests,
  }) : super._(
         mode: mode,
         operation: operation,
         observations: observations,
         newCatalogPlaces: newCatalogPlaces,
         cacheHits: cacheHits,
         cacheMisses: cacheMisses,
         detailRefreshes: detailRefreshes,
         upstreamRequests: upstreamRequests,
       );

  /// Returns a shallow copy of this [DiscoveryGrowthMetricBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryGrowthMetricBreakdown copyWith({
    _iwc51qy2.DiscoveryMetricMode? mode,
    _ipgnhxya.DiscoveryMetricOperation? operation,
    int? observations,
    int? newCatalogPlaces,
    int? cacheHits,
    int? cacheMisses,
    int? detailRefreshes,
    int? upstreamRequests,
  }) {
    return DiscoveryGrowthMetricBreakdown(
      mode: mode ?? this.mode,
      operation: operation ?? this.operation,
      observations: observations ?? this.observations,
      newCatalogPlaces: newCatalogPlaces ?? this.newCatalogPlaces,
      cacheHits: cacheHits ?? this.cacheHits,
      cacheMisses: cacheMisses ?? this.cacheMisses,
      detailRefreshes: detailRefreshes ?? this.detailRefreshes,
      upstreamRequests: upstreamRequests ?? this.upstreamRequests,
    );
  }
}
