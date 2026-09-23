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

abstract class DiscoveryPriceCount
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryPriceCount._({
    this.priceLevel,
    required this.count,
  });

  factory DiscoveryPriceCount({
    int? priceLevel,
    required int count,
  }) = _DiscoveryPriceCountImpl;

  factory DiscoveryPriceCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryPriceCount(
      priceLevel: jsonSerialization['priceLevel'] as int?,
      count: jsonSerialization['count'] as int,
    );
  }

  int? priceLevel;

  int count;

  /// Returns a shallow copy of this [DiscoveryPriceCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryPriceCount copyWith({
    int? priceLevel,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryPriceCount',
      if (priceLevel != null) 'priceLevel': priceLevel,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryPriceCount',
      if (priceLevel != null) 'priceLevel': priceLevel,
      'count': count,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryPriceCountImpl extends DiscoveryPriceCount {
  _DiscoveryPriceCountImpl({
    int? priceLevel,
    required int count,
  }) : super._(
         priceLevel: priceLevel,
         count: count,
       );

  /// Returns a shallow copy of this [DiscoveryPriceCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryPriceCount copyWith({
    Object? priceLevel = _Undefined,
    int? count,
  }) {
    return DiscoveryPriceCount(
      priceLevel: priceLevel is int? ? priceLevel : this.priceLevel,
      count: count ?? this.count,
    );
  }
}
