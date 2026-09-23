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
import 'discover_query_context.dart' as _ixfyrpmf;
import 'discovery_minimum_rating_count.dart' as _iafesi5t;
import 'discovery_price_count.dart' as _ijqf6en4;
import 'discovery_rating_bucket.dart' as _iinjfol4;
import 'discovery_review_band_count.dart' as _ijvcgm3f;
import 'discovery_type_count.dart' as _iaqq99sz;

abstract class DiscoverFacets
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    required _ixfyrpmf.DiscoverQueryContext context,
    required DateTime fetchedAt,
    required List<_iaqq99sz.DiscoveryTypeCount> typeCounts,
    required List<_ijvcgm3f.DiscoveryReviewBandCount> reviewBandCounts,
    required List<_ijqf6en4.DiscoveryPriceCount> priceCounts,
    required List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution,
    required List<_iafesi5t.DiscoveryMinimumRatingCount> minimumRatingCounts,
    required int unknownRatingCount,
  }) = _DiscoverFacetsImpl;

  factory DiscoverFacets.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverFacets(
      total: jsonSerialization['total'] as int,
      context: _i66y2smk.Protocol().deserialize<_ixfyrpmf.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      typeCounts: _i66y2smk.Protocol()
          .deserialize<List<_iaqq99sz.DiscoveryTypeCount>>(
            jsonSerialization['typeCounts'],
          ),
      reviewBandCounts: _i66y2smk.Protocol()
          .deserialize<List<_ijvcgm3f.DiscoveryReviewBandCount>>(
            jsonSerialization['reviewBandCounts'],
          ),
      priceCounts: _i66y2smk.Protocol()
          .deserialize<List<_ijqf6en4.DiscoveryPriceCount>>(
            jsonSerialization['priceCounts'],
          ),
      ratingDistribution: _i66y2smk.Protocol()
          .deserialize<List<_iinjfol4.DiscoveryRatingBucket>>(
            jsonSerialization['ratingDistribution'],
          ),
      minimumRatingCounts: _i66y2smk.Protocol()
          .deserialize<List<_iafesi5t.DiscoveryMinimumRatingCount>>(
            jsonSerialization['minimumRatingCounts'],
          ),
      unknownRatingCount: jsonSerialization['unknownRatingCount'] as int,
    );
  }

  int total;

  _ixfyrpmf.DiscoverQueryContext context;

  DateTime fetchedAt;

  List<_iaqq99sz.DiscoveryTypeCount> typeCounts;

  List<_ijvcgm3f.DiscoveryReviewBandCount> reviewBandCounts;

  List<_ijqf6en4.DiscoveryPriceCount> priceCounts;

  List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution;

  List<_iafesi5t.DiscoveryMinimumRatingCount> minimumRatingCounts;

  int unknownRatingCount;

  /// Returns a shallow copy of this [DiscoverFacets]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoverFacets copyWith({
    int? total,
    _ixfyrpmf.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    List<_iaqq99sz.DiscoveryTypeCount>? typeCounts,
    List<_ijvcgm3f.DiscoveryReviewBandCount>? reviewBandCounts,
    List<_ijqf6en4.DiscoveryPriceCount>? priceCounts,
    List<_iinjfol4.DiscoveryRatingBucket>? ratingDistribution,
    List<_iafesi5t.DiscoveryMinimumRatingCount>? minimumRatingCounts,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverFacets',
      'total': total,
      'context': context.toJsonForProtocol(),
      'fetchedAt': fetchedAt.toJson(),
      'typeCounts': typeCounts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'reviewBandCounts': reviewBandCounts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'priceCounts': priceCounts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'ratingDistribution': ratingDistribution.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'minimumRatingCounts': minimumRatingCounts.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'unknownRatingCount': unknownRatingCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DiscoverFacetsImpl extends DiscoverFacets {
  _DiscoverFacetsImpl({
    required int total,
    required _ixfyrpmf.DiscoverQueryContext context,
    required DateTime fetchedAt,
    required List<_iaqq99sz.DiscoveryTypeCount> typeCounts,
    required List<_ijvcgm3f.DiscoveryReviewBandCount> reviewBandCounts,
    required List<_ijqf6en4.DiscoveryPriceCount> priceCounts,
    required List<_iinjfol4.DiscoveryRatingBucket> ratingDistribution,
    required List<_iafesi5t.DiscoveryMinimumRatingCount> minimumRatingCounts,
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
  @_is.useResult
  @override
  DiscoverFacets copyWith({
    int? total,
    _ixfyrpmf.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    List<_iaqq99sz.DiscoveryTypeCount>? typeCounts,
    List<_ijvcgm3f.DiscoveryReviewBandCount>? reviewBandCounts,
    List<_ijqf6en4.DiscoveryPriceCount>? priceCounts,
    List<_iinjfol4.DiscoveryRatingBucket>? ratingDistribution,
    List<_iafesi5t.DiscoveryMinimumRatingCount>? minimumRatingCounts,
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
