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

abstract class DiscoveryRatingBucket implements _i1.SerializableModel {
  DiscoveryRatingBucket._({
    required this.minimumInclusive,
    required this.maximumExclusive,
    required this.count,
  });

  factory DiscoveryRatingBucket({
    required double minimumInclusive,
    required double maximumExclusive,
    required int count,
  }) = _DiscoveryRatingBucketImpl;

  factory DiscoveryRatingBucket.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryRatingBucket(
      minimumInclusive: (jsonSerialization['minimumInclusive'] as num)
          .toDouble(),
      maximumExclusive: (jsonSerialization['maximumExclusive'] as num)
          .toDouble(),
      count: jsonSerialization['count'] as int,
    );
  }

  double minimumInclusive;

  double maximumExclusive;

  int count;

  /// Returns a shallow copy of this [DiscoveryRatingBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryRatingBucket copyWith({
    double? minimumInclusive,
    double? maximumExclusive,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryRatingBucket',
      'minimumInclusive': minimumInclusive,
      'maximumExclusive': maximumExclusive,
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryRatingBucketImpl extends DiscoveryRatingBucket {
  _DiscoveryRatingBucketImpl({
    required double minimumInclusive,
    required double maximumExclusive,
    required int count,
  }) : super._(
         minimumInclusive: minimumInclusive,
         maximumExclusive: maximumExclusive,
         count: count,
       );

  /// Returns a shallow copy of this [DiscoveryRatingBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryRatingBucket copyWith({
    double? minimumInclusive,
    double? maximumExclusive,
    int? count,
  }) {
    return DiscoveryRatingBucket(
      minimumInclusive: minimumInclusive ?? this.minimumInclusive,
      maximumExclusive: maximumExclusive ?? this.maximumExclusive,
      count: count ?? this.count,
    );
  }
}
