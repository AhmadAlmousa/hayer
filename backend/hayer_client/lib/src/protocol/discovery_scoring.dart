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
import 'discovery_best_formula.dart' as _i2;

abstract class DiscoveryScoring implements _i1.SerializableModel {
  DiscoveryScoring._({
    required this.bestFormula,
    required this.gemMinimumRating,
    required this.gemMinimumReviews,
    required this.gemMaximumReviewsExclusive,
    required this.bayesianPriorReviews,
    required this.bayesianMeanRating,
    required this.bestMinimumReviews,
    required this.topRatedMinimumReviews,
    required this.worstRatedMinimumReviews,
    required this.recentlyAddedDays,
  });

  factory DiscoveryScoring({
    required _i2.DiscoveryBestFormula bestFormula,
    required double gemMinimumRating,
    required int gemMinimumReviews,
    required int gemMaximumReviewsExclusive,
    required int bayesianPriorReviews,
    required double bayesianMeanRating,
    required int bestMinimumReviews,
    required int topRatedMinimumReviews,
    required int worstRatedMinimumReviews,
    required int recentlyAddedDays,
  }) = _DiscoveryScoringImpl;

  factory DiscoveryScoring.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryScoring(
      bestFormula: _i2.DiscoveryBestFormula.fromJson(
        (jsonSerialization['bestFormula'] as String),
      ),
      gemMinimumRating: (jsonSerialization['gemMinimumRating'] as num)
          .toDouble(),
      gemMinimumReviews: jsonSerialization['gemMinimumReviews'] as int,
      gemMaximumReviewsExclusive:
          jsonSerialization['gemMaximumReviewsExclusive'] as int,
      bayesianPriorReviews: jsonSerialization['bayesianPriorReviews'] as int,
      bayesianMeanRating: (jsonSerialization['bayesianMeanRating'] as num)
          .toDouble(),
      bestMinimumReviews: jsonSerialization['bestMinimumReviews'] as int,
      topRatedMinimumReviews:
          jsonSerialization['topRatedMinimumReviews'] as int,
      worstRatedMinimumReviews:
          jsonSerialization['worstRatedMinimumReviews'] as int,
      recentlyAddedDays: jsonSerialization['recentlyAddedDays'] as int,
    );
  }

  _i2.DiscoveryBestFormula bestFormula;

  double gemMinimumRating;

  int gemMinimumReviews;

  int gemMaximumReviewsExclusive;

  int bayesianPriorReviews;

  double bayesianMeanRating;

  int bestMinimumReviews;

  int topRatedMinimumReviews;

  int worstRatedMinimumReviews;

  int recentlyAddedDays;

  /// Returns a shallow copy of this [DiscoveryScoring]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryScoring copyWith({
    _i2.DiscoveryBestFormula? bestFormula,
    double? gemMinimumRating,
    int? gemMinimumReviews,
    int? gemMaximumReviewsExclusive,
    int? bayesianPriorReviews,
    double? bayesianMeanRating,
    int? bestMinimumReviews,
    int? topRatedMinimumReviews,
    int? worstRatedMinimumReviews,
    int? recentlyAddedDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryScoring',
      'bestFormula': bestFormula.toJson(),
      'gemMinimumRating': gemMinimumRating,
      'gemMinimumReviews': gemMinimumReviews,
      'gemMaximumReviewsExclusive': gemMaximumReviewsExclusive,
      'bayesianPriorReviews': bayesianPriorReviews,
      'bayesianMeanRating': bayesianMeanRating,
      'bestMinimumReviews': bestMinimumReviews,
      'topRatedMinimumReviews': topRatedMinimumReviews,
      'worstRatedMinimumReviews': worstRatedMinimumReviews,
      'recentlyAddedDays': recentlyAddedDays,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryScoringImpl extends DiscoveryScoring {
  _DiscoveryScoringImpl({
    required _i2.DiscoveryBestFormula bestFormula,
    required double gemMinimumRating,
    required int gemMinimumReviews,
    required int gemMaximumReviewsExclusive,
    required int bayesianPriorReviews,
    required double bayesianMeanRating,
    required int bestMinimumReviews,
    required int topRatedMinimumReviews,
    required int worstRatedMinimumReviews,
    required int recentlyAddedDays,
  }) : super._(
         bestFormula: bestFormula,
         gemMinimumRating: gemMinimumRating,
         gemMinimumReviews: gemMinimumReviews,
         gemMaximumReviewsExclusive: gemMaximumReviewsExclusive,
         bayesianPriorReviews: bayesianPriorReviews,
         bayesianMeanRating: bayesianMeanRating,
         bestMinimumReviews: bestMinimumReviews,
         topRatedMinimumReviews: topRatedMinimumReviews,
         worstRatedMinimumReviews: worstRatedMinimumReviews,
         recentlyAddedDays: recentlyAddedDays,
       );

  /// Returns a shallow copy of this [DiscoveryScoring]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryScoring copyWith({
    _i2.DiscoveryBestFormula? bestFormula,
    double? gemMinimumRating,
    int? gemMinimumReviews,
    int? gemMaximumReviewsExclusive,
    int? bayesianPriorReviews,
    double? bayesianMeanRating,
    int? bestMinimumReviews,
    int? topRatedMinimumReviews,
    int? worstRatedMinimumReviews,
    int? recentlyAddedDays,
  }) {
    return DiscoveryScoring(
      bestFormula: bestFormula ?? this.bestFormula,
      gemMinimumRating: gemMinimumRating ?? this.gemMinimumRating,
      gemMinimumReviews: gemMinimumReviews ?? this.gemMinimumReviews,
      gemMaximumReviewsExclusive:
          gemMaximumReviewsExclusive ?? this.gemMaximumReviewsExclusive,
      bayesianPriorReviews: bayesianPriorReviews ?? this.bayesianPriorReviews,
      bayesianMeanRating: bayesianMeanRating ?? this.bayesianMeanRating,
      bestMinimumReviews: bestMinimumReviews ?? this.bestMinimumReviews,
      topRatedMinimumReviews:
          topRatedMinimumReviews ?? this.topRatedMinimumReviews,
      worstRatedMinimumReviews:
          worstRatedMinimumReviews ?? this.worstRatedMinimumReviews,
      recentlyAddedDays: recentlyAddedDays ?? this.recentlyAddedDays,
    );
  }
}
