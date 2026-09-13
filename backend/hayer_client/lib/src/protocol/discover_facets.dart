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
import 'discover_query_context.dart' as _i2;
import 'discovery_type_count.dart' as _i3;
import 'discovery_review_band_count.dart' as _i4;
import 'discovery_price_count.dart' as _i5;
import 'discovery_rating_bucket.dart' as _i6;
import 'discovery_minimum_rating_count.dart' as _i7;
import 'package:hayer_client/src/protocol/protocol.dart' as _i8;

abstract class DiscoverFacets implements _i1.SerializableModel {
  DiscoverFacets._({
    required this.total,
    required this.context,
    required this.fetchedAt,
    required this.typeCounts,
    required this.reviewBandCounts,
    required this.priceCounts,
    required this.ratingDistribution,
    required this.minimumRatingCounts,
    required this.unknownRatingCount,
  });

  factory DiscoverFacets({
    required int total,
    required _i2.DiscoverQueryContext context,
    required DateTime fetchedAt,
    required List<_i3.DiscoveryTypeCount> typeCounts,
    required List<_i4.DiscoveryReviewBandCount> reviewBandCounts,
    required List<_i5.DiscoveryPriceCount> priceCounts,
    required List<_i6.DiscoveryRatingBucket> ratingDistribution,
    required List<_i7.DiscoveryMinimumRatingCount> minimumRatingCounts,
    required int unknownRatingCount,
  }) = _DiscoverFacetsImpl;

  factory DiscoverFacets.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverFacets(
      total: jsonSerialization['total'] as int,
      context: _i8.Protocol().deserialize<_i2.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      typeCounts: _i8.Protocol().deserialize<List<_i3.DiscoveryTypeCount>>(
        jsonSerialization['typeCounts'],
      ),
      reviewBandCounts: _i8.Protocol()
          .deserialize<List<_i4.DiscoveryReviewBandCount>>(
            jsonSerialization['reviewBandCounts'],
          ),
      priceCounts: _i8.Protocol().deserialize<List<_i5.DiscoveryPriceCount>>(
        jsonSerialization['priceCounts'],
      ),
      ratingDistribution: _i8.Protocol()
          .deserialize<List<_i6.DiscoveryRatingBucket>>(
            jsonSerialization['ratingDistribution'],
          ),
      minimumRatingCounts: _i8.Protocol()
          .deserialize<List<_i7.DiscoveryMinimumRatingCount>>(
            jsonSerialization['minimumRatingCounts'],
          ),
      unknownRatingCount: jsonSerialization['unknownRatingCount'] as int,
    );
  }

  int total;

  _i2.DiscoverQueryContext context;

  DateTime fetchedAt;

  List<_i3.DiscoveryTypeCount> typeCounts;

  List<_i4.DiscoveryReviewBandCount> reviewBandCounts;

  List<_i5.DiscoveryPriceCount> priceCounts;

  List<_i6.DiscoveryRatingBucket> ratingDistribution;

  List<_i7.DiscoveryMinimumRatingCount> minimumRatingCounts;

  int unknownRatingCount;

  /// Returns a shallow copy of this [DiscoverFacets]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverFacets copyWith({
    int? total,
    _i2.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    List<_i3.DiscoveryTypeCount>? typeCounts,
    List<_i4.DiscoveryReviewBandCount>? reviewBandCounts,
    List<_i5.DiscoveryPriceCount>? priceCounts,
    List<_i6.DiscoveryRatingBucket>? ratingDistribution,
    List<_i7.DiscoveryMinimumRatingCount>? minimumRatingCounts,
    int? unknownRatingCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverFacets',
      'total': total,
      'context': context.toJson(),
      'fetchedAt': fetchedAt.toJson(),
      'typeCounts': typeCounts.toJson(valueToJson: (v) => v.toJson()),
      'reviewBandCounts': reviewBandCounts.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'priceCounts': priceCounts.toJson(valueToJson: (v) => v.toJson()),
      'ratingDistribution': ratingDistribution.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'minimumRatingCounts': minimumRatingCounts.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'unknownRatingCount': unknownRatingCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoverFacetsImpl extends DiscoverFacets {
  _DiscoverFacetsImpl({
    required int total,
    required _i2.DiscoverQueryContext context,
    required DateTime fetchedAt,
    required List<_i3.DiscoveryTypeCount> typeCounts,
    required List<_i4.DiscoveryReviewBandCount> reviewBandCounts,
    required List<_i5.DiscoveryPriceCount> priceCounts,
    required List<_i6.DiscoveryRatingBucket> ratingDistribution,
    required List<_i7.DiscoveryMinimumRatingCount> minimumRatingCounts,
    required int unknownRatingCount,
  }) : super._(
         total: total,
         context: context,
         fetchedAt: fetchedAt,
         typeCounts: typeCounts,
         reviewBandCounts: reviewBandCounts,
         priceCounts: priceCounts,
         ratingDistribution: ratingDistribution,
         minimumRatingCounts: minimumRatingCounts,
         unknownRatingCount: unknownRatingCount,
       );

  /// Returns a shallow copy of this [DiscoverFacets]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverFacets copyWith({
    int? total,
    _i2.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    List<_i3.DiscoveryTypeCount>? typeCounts,
    List<_i4.DiscoveryReviewBandCount>? reviewBandCounts,
    List<_i5.DiscoveryPriceCount>? priceCounts,
    List<_i6.DiscoveryRatingBucket>? ratingDistribution,
    List<_i7.DiscoveryMinimumRatingCount>? minimumRatingCounts,
    int? unknownRatingCount,
  }) {
    return DiscoverFacets(
      total: total ?? this.total,
      context: context ?? this.context.copyWith(),
      fetchedAt: fetchedAt ?? this.fetchedAt,
      typeCounts:
          typeCounts ?? this.typeCounts.map((e0) => e0.copyWith()).toList(),
      reviewBandCounts:
          reviewBandCounts ??
          this.reviewBandCounts.map((e0) => e0.copyWith()).toList(),
      priceCounts:
          priceCounts ?? this.priceCounts.map((e0) => e0.copyWith()).toList(),
      ratingDistribution:
          ratingDistribution ??
          this.ratingDistribution.map((e0) => e0.copyWith()).toList(),
      minimumRatingCounts:
          minimumRatingCounts ??
          this.minimumRatingCounts.map((e0) => e0.copyWith()).toList(),
      unknownRatingCount: unknownRatingCount ?? this.unknownRatingCount,
    );
  }
}
