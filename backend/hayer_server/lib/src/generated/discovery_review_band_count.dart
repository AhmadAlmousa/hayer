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
import 'discover_review_band.dart' as _ibwysijp;

abstract class DiscoveryReviewBandCount
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryReviewBandCount._({
    required this.band,
    required this.count,
  });

  factory DiscoveryReviewBandCount({
    required _ibwysijp.DiscoverReviewBand band,
    required int count,
  }) = _DiscoveryReviewBandCountImpl;

  factory DiscoveryReviewBandCount.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryReviewBandCount(
      band: _ibwysijp.DiscoverReviewBand.fromJson(
        (jsonSerialization['band'] as String),
      ),
      count: jsonSerialization['count'] as int,
    );
  }

  _ibwysijp.DiscoverReviewBand band;

  int count;

  /// Returns a shallow copy of this [DiscoveryReviewBandCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryReviewBandCount copyWith({
    _ibwysijp.DiscoverReviewBand? band,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryReviewBandCount',
      'band': band.toJson(),
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryReviewBandCount',
      'band': band.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DiscoveryReviewBandCountImpl extends DiscoveryReviewBandCount {
  _DiscoveryReviewBandCountImpl({
    required _ibwysijp.DiscoverReviewBand band,
    required int count,
  }) : super._(
         band: band,
         count: count,
       );

  /// Returns a shallow copy of this [DiscoveryReviewBandCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryReviewBandCount copyWith({
    _ibwysijp.DiscoverReviewBand? band,
    int? count,
  }) {
    return DiscoveryReviewBandCount(
      band: band ?? this.band,
      count: count ?? this.count,
    );
  }
}
