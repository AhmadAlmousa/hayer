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
import 'discovery_growth_metric_breakdown.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class DiscoveryGrowthMetrics
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryGrowthMetrics._({
    required this.from,
    required this.to,
    required this.catalogPlacesAtStart,
    required this.catalogPlacesAtEnd,
    required this.newCatalogPlaces,
    required this.quarantinedPlaces,
    required this.removedPlaces,
    required this.exploredCells,
    required this.observations,
    required this.cacheHits,
    required this.cacheMisses,
    required this.detailRefreshes,
    required this.upstreamRequests,
    required this.breakdowns,
    required this.generatedAt,
  });

  factory DiscoveryGrowthMetrics({
    required DateTime from,
    required DateTime to,
    required int catalogPlacesAtStart,
    required int catalogPlacesAtEnd,
    required int newCatalogPlaces,
    required int quarantinedPlaces,
    required int removedPlaces,
    required int exploredCells,
    required int observations,
    required int cacheHits,
    required int cacheMisses,
    required int detailRefreshes,
    required int upstreamRequests,
    required List<_i2.DiscoveryGrowthMetricBreakdown> breakdowns,
    required DateTime generatedAt,
  }) = _DiscoveryGrowthMetricsImpl;

  factory DiscoveryGrowthMetrics.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryGrowthMetrics(
      from: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      catalogPlacesAtStart: jsonSerialization['catalogPlacesAtStart'] as int,
      catalogPlacesAtEnd: jsonSerialization['catalogPlacesAtEnd'] as int,
      newCatalogPlaces: jsonSerialization['newCatalogPlaces'] as int,
      quarantinedPlaces: jsonSerialization['quarantinedPlaces'] as int,
      removedPlaces: jsonSerialization['removedPlaces'] as int,
      exploredCells: jsonSerialization['exploredCells'] as int,
      observations: jsonSerialization['observations'] as int,
      cacheHits: jsonSerialization['cacheHits'] as int,
      cacheMisses: jsonSerialization['cacheMisses'] as int,
      detailRefreshes: jsonSerialization['detailRefreshes'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
      breakdowns: _i3.Protocol()
          .deserialize<List<_i2.DiscoveryGrowthMetricBreakdown>>(
            jsonSerialization['breakdowns'],
          ),
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  DateTime from;

  DateTime to;

  int catalogPlacesAtStart;

  int catalogPlacesAtEnd;

  int newCatalogPlaces;

  int quarantinedPlaces;

  int removedPlaces;

  int exploredCells;

  int observations;

  int cacheHits;

  int cacheMisses;

  int detailRefreshes;

  int upstreamRequests;

  List<_i2.DiscoveryGrowthMetricBreakdown> breakdowns;

  DateTime generatedAt;

  /// Returns a shallow copy of this [DiscoveryGrowthMetrics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryGrowthMetrics copyWith({
    DateTime? from,
    DateTime? to,
    int? catalogPlacesAtStart,
    int? catalogPlacesAtEnd,
    int? newCatalogPlaces,
    int? quarantinedPlaces,
    int? removedPlaces,
    int? exploredCells,
    int? observations,
    int? cacheHits,
    int? cacheMisses,
    int? detailRefreshes,
    int? upstreamRequests,
    List<_i2.DiscoveryGrowthMetricBreakdown>? breakdowns,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryGrowthMetrics',
      'from': from.toJson(),
      'to': to.toJson(),
      'catalogPlacesAtStart': catalogPlacesAtStart,
      'catalogPlacesAtEnd': catalogPlacesAtEnd,
      'newCatalogPlaces': newCatalogPlaces,
      'quarantinedPlaces': quarantinedPlaces,
      'removedPlaces': removedPlaces,
      'exploredCells': exploredCells,
      'observations': observations,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'detailRefreshes': detailRefreshes,
      'upstreamRequests': upstreamRequests,
      'breakdowns': breakdowns.toJson(valueToJson: (v) => v.toJson()),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryGrowthMetrics',
      'from': from.toJson(),
      'to': to.toJson(),
      'catalogPlacesAtStart': catalogPlacesAtStart,
      'catalogPlacesAtEnd': catalogPlacesAtEnd,
      'newCatalogPlaces': newCatalogPlaces,
      'quarantinedPlaces': quarantinedPlaces,
      'removedPlaces': removedPlaces,
      'exploredCells': exploredCells,
      'observations': observations,
      'cacheHits': cacheHits,
      'cacheMisses': cacheMisses,
      'detailRefreshes': detailRefreshes,
      'upstreamRequests': upstreamRequests,
      'breakdowns': breakdowns.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryGrowthMetricsImpl extends DiscoveryGrowthMetrics {
  _DiscoveryGrowthMetricsImpl({
    required DateTime from,
    required DateTime to,
    required int catalogPlacesAtStart,
    required int catalogPlacesAtEnd,
    required int newCatalogPlaces,
    required int quarantinedPlaces,
    required int removedPlaces,
    required int exploredCells,
    required int observations,
    required int cacheHits,
    required int cacheMisses,
    required int detailRefreshes,
    required int upstreamRequests,
    required List<_i2.DiscoveryGrowthMetricBreakdown> breakdowns,
    required DateTime generatedAt,
  }) : super._(
         from: from,
         to: to,
         catalogPlacesAtStart: catalogPlacesAtStart,
         catalogPlacesAtEnd: catalogPlacesAtEnd,
         newCatalogPlaces: newCatalogPlaces,
         quarantinedPlaces: quarantinedPlaces,
         removedPlaces: removedPlaces,
         exploredCells: exploredCells,
         observations: observations,
         cacheHits: cacheHits,
         cacheMisses: cacheMisses,
         detailRefreshes: detailRefreshes,
         upstreamRequests: upstreamRequests,
         breakdowns: breakdowns,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [DiscoveryGrowthMetrics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryGrowthMetrics copyWith({
    DateTime? from,
    DateTime? to,
    int? catalogPlacesAtStart,
    int? catalogPlacesAtEnd,
    int? newCatalogPlaces,
    int? quarantinedPlaces,
    int? removedPlaces,
    int? exploredCells,
    int? observations,
    int? cacheHits,
    int? cacheMisses,
    int? detailRefreshes,
    int? upstreamRequests,
    List<_i2.DiscoveryGrowthMetricBreakdown>? breakdowns,
    DateTime? generatedAt,
  }) {
    return DiscoveryGrowthMetrics(
      from: from ?? this.from,
      to: to ?? this.to,
      catalogPlacesAtStart: catalogPlacesAtStart ?? this.catalogPlacesAtStart,
      catalogPlacesAtEnd: catalogPlacesAtEnd ?? this.catalogPlacesAtEnd,
      newCatalogPlaces: newCatalogPlaces ?? this.newCatalogPlaces,
      quarantinedPlaces: quarantinedPlaces ?? this.quarantinedPlaces,
      removedPlaces: removedPlaces ?? this.removedPlaces,
      exploredCells: exploredCells ?? this.exploredCells,
      observations: observations ?? this.observations,
      cacheHits: cacheHits ?? this.cacheHits,
      cacheMisses: cacheMisses ?? this.cacheMisses,
      detailRefreshes: detailRefreshes ?? this.detailRefreshes,
      upstreamRequests: upstreamRequests ?? this.upstreamRequests,
      breakdowns:
          breakdowns ?? this.breakdowns.map((e0) => e0.copyWith()).toList(),
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
