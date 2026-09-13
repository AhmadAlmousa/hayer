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
import 'discover_place.dart' as _i2;
import 'discovery_rating_bucket.dart' as _i3;
import 'discover_query_context.dart' as _i4;
import 'package:hayer_server/src/generated/protocol.dart' as _i5;

abstract class DiscoverPlaceContext
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoverPlaceContext._({
    required this.eligible,
    this.place,
    this.ordinal,
    required this.total,
    this.ratingPercentile,
    this.populationCategoryId,
    required this.ratingDistribution,
    required this.context,
    required this.fetchedAt,
  });

  factory DiscoverPlaceContext({
    required bool eligible,
    _i2.DiscoverPlace? place,
    int? ordinal,
    required int total,
    double? ratingPercentile,
    String? populationCategoryId,
    required List<_i3.DiscoveryRatingBucket> ratingDistribution,
    required _i4.DiscoverQueryContext context,
    required DateTime fetchedAt,
  }) = _DiscoverPlaceContextImpl;

  factory DiscoverPlaceContext.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoverPlaceContext(
      eligible: _i1.BoolJsonExtension.fromJson(jsonSerialization['eligible']),
      place: jsonSerialization['place'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.DiscoverPlace>(
              jsonSerialization['place'],
            ),
      ordinal: jsonSerialization['ordinal'] as int?,
      total: jsonSerialization['total'] as int,
      ratingPercentile: (jsonSerialization['ratingPercentile'] as num?)
          ?.toDouble(),
      populationCategoryId:
          jsonSerialization['populationCategoryId'] as String?,
      ratingDistribution: _i5.Protocol()
          .deserialize<List<_i3.DiscoveryRatingBucket>>(
            jsonSerialization['ratingDistribution'],
          ),
      context: _i5.Protocol().deserialize<_i4.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  bool eligible;

  _i2.DiscoverPlace? place;

  int? ordinal;

  int total;

  double? ratingPercentile;

  String? populationCategoryId;

  List<_i3.DiscoveryRatingBucket> ratingDistribution;

  _i4.DiscoverQueryContext context;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [DiscoverPlaceContext]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverPlaceContext copyWith({
    bool? eligible,
    _i2.DiscoverPlace? place,
    int? ordinal,
    int? total,
    double? ratingPercentile,
    String? populationCategoryId,
    List<_i3.DiscoveryRatingBucket>? ratingDistribution,
    _i4.DiscoverQueryContext? context,
    DateTime? fetchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverPlaceContext',
      'eligible': eligible,
      if (place != null) 'place': place?.toJson(),
      if (ordinal != null) 'ordinal': ordinal,
      'total': total,
      if (ratingPercentile != null) 'ratingPercentile': ratingPercentile,
      if (populationCategoryId != null)
        'populationCategoryId': populationCategoryId,
      'ratingDistribution': ratingDistribution.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'context': context.toJson(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverPlaceContext',
      'eligible': eligible,
      if (place != null) 'place': place?.toJsonForProtocol(),
      if (ordinal != null) 'ordinal': ordinal,
      'total': total,
      if (ratingPercentile != null) 'ratingPercentile': ratingPercentile,
      if (populationCategoryId != null)
        'populationCategoryId': populationCategoryId,
      'ratingDistribution': ratingDistribution.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'context': context.toJsonForProtocol(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverPlaceContextImpl extends DiscoverPlaceContext {
  _DiscoverPlaceContextImpl({
    required bool eligible,
    _i2.DiscoverPlace? place,
    int? ordinal,
    required int total,
    double? ratingPercentile,
    String? populationCategoryId,
    required List<_i3.DiscoveryRatingBucket> ratingDistribution,
    required _i4.DiscoverQueryContext context,
    required DateTime fetchedAt,
  }) : super._(
         eligible: eligible,
         place: place,
         ordinal: ordinal,
         total: total,
         ratingPercentile: ratingPercentile,
         populationCategoryId: populationCategoryId,
         ratingDistribution: ratingDistribution,
         context: context,
         fetchedAt: fetchedAt,
       );

  /// Returns a shallow copy of this [DiscoverPlaceContext]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverPlaceContext copyWith({
    bool? eligible,
    Object? place = _Undefined,
    Object? ordinal = _Undefined,
    int? total,
    Object? ratingPercentile = _Undefined,
    Object? populationCategoryId = _Undefined,
    List<_i3.DiscoveryRatingBucket>? ratingDistribution,
    _i4.DiscoverQueryContext? context,
    DateTime? fetchedAt,
  }) {
    return DiscoverPlaceContext(
      eligible: eligible ?? this.eligible,
      place: place is _i2.DiscoverPlace? ? place : this.place?.copyWith(),
      ordinal: ordinal is int? ? ordinal : this.ordinal,
      total: total ?? this.total,
      ratingPercentile: ratingPercentile is double?
          ? ratingPercentile
          : this.ratingPercentile,
      populationCategoryId: populationCategoryId is String?
          ? populationCategoryId
          : this.populationCategoryId,
      ratingDistribution:
          ratingDistribution ??
          this.ratingDistribution.map((e0) => e0.copyWith()).toList(),
      context: context ?? this.context.copyWith(),
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
