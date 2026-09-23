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
import 'discover_place.dart' as _iyut1oys;
import 'discover_query_context.dart' as _ixfyrpmf;
import 'discovery_rating_bucket.dart' as _iinjfol4;

abstract class DiscoverPlaceContext
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    _iyut1oys.DiscoverPlace? place,
    int? ordinal,
    required int total,
    double? ratingPercentile,
    String? populationCategoryId,
    required List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution,
    required _ixfyrpmf.DiscoverQueryContext context,
    required DateTime fetchedAt,
  }) = _DiscoverPlaceContextImpl;

  factory DiscoverPlaceContext.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoverPlaceContext(
      eligible: _is.BoolJsonExtension.fromJson(jsonSerialization['eligible']),
      place: jsonSerialization['place'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_iyut1oys.DiscoverPlace>(
              jsonSerialization['place'],
            ),
      ordinal: jsonSerialization['ordinal'] as int?,
      total: jsonSerialization['total'] as int,
      ratingPercentile: (jsonSerialization['ratingPercentile'] as num?)
          ?.toDouble(),
      populationCategoryId:
          jsonSerialization['populationCategoryId'] as String?,
      ratingDistribution: _i66y2smk.Protocol()
          .deserialize<List<_iinjfol4.DiscoveryRatingBucket>>(
            jsonSerialization['ratingDistribution'],
          ),
      context: _i66y2smk.Protocol().deserialize<_ixfyrpmf.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  bool eligible;

  _iyut1oys.DiscoverPlace? place;

  int? ordinal;

  int total;

  double? ratingPercentile;

  String? populationCategoryId;

  List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution;

  _ixfyrpmf.DiscoverQueryContext context;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [DiscoverPlaceContext]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoverPlaceContext copyWith({
    bool? eligible,
    _iyut1oys.DiscoverPlace? place,
    int? ordinal,
    int? total,
    double? ratingPercentile,
    String? populationCategoryId,
    List<_iinjfol4.DiscoveryRatingBucket>? ratingDistribution,
    _ixfyrpmf.DiscoverQueryContext? context,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverPlaceContextImpl extends DiscoverPlaceContext {
  _DiscoverPlaceContextImpl({
    required bool eligible,
    _iyut1oys.DiscoverPlace? place,
    int? ordinal,
    required int total,
    double? ratingPercentile,
    String? populationCategoryId,
    required List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution,
    required _ixfyrpmf.DiscoverQueryContext context,
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
  @_is.useResult
  @override
  DiscoverPlaceContext copyWith({
    bool? eligible,
    Object? place = _Undefined,
    Object? ordinal = _Undefined,
    int? total,
    Object? ratingPercentile = _Undefined,
    Object? populationCategoryId = _Undefined,
    List<_iinjfol4.DiscoveryRatingBucket>? ratingDistribution,
    _ixfyrpmf.DiscoverQueryContext? context,
    DateTime? fetchedAt,
  }) {
    return DiscoverPlaceContext(
      eligible: eligible ?? this.eligible,
      place: place is _iyut1oys.DiscoverPlace? ? place : this.place?.copyWith(),
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
