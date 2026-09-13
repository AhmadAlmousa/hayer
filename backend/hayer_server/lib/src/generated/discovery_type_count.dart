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

abstract class DiscoveryTypeCount
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryTypeCount._({
    this.primaryType,
    required this.taxonomyNodeId,
    required this.count,
  });

  factory DiscoveryTypeCount({
    String? primaryType,
    required String taxonomyNodeId,
    required int count,
  }) = _DiscoveryTypeCountImpl;

  factory DiscoveryTypeCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryTypeCount(
      primaryType: jsonSerialization['primaryType'] as String?,
      taxonomyNodeId: jsonSerialization['taxonomyNodeId'] as String,
      count: jsonSerialization['count'] as int,
    );
  }

  String? primaryType;

  String taxonomyNodeId;

  int count;

  /// Returns a shallow copy of this [DiscoveryTypeCount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryTypeCount copyWith({
    String? primaryType,
    String? taxonomyNodeId,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTypeCount',
      if (primaryType != null) 'primaryType': primaryType,
      'taxonomyNodeId': taxonomyNodeId,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryTypeCount',
      if (primaryType != null) 'primaryType': primaryType,
      'taxonomyNodeId': taxonomyNodeId,
      'count': count,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTypeCountImpl extends DiscoveryTypeCount {
  _DiscoveryTypeCountImpl({
    String? primaryType,
    required String taxonomyNodeId,
    required int count,
  }) : super._(
         primaryType: primaryType,
         taxonomyNodeId: taxonomyNodeId,
         count: count,
       );

  /// Returns a shallow copy of this [DiscoveryTypeCount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryTypeCount copyWith({
    Object? primaryType = _Undefined,
    String? taxonomyNodeId,
    int? count,
  }) {
    return DiscoveryTypeCount(
      primaryType: primaryType is String? ? primaryType : this.primaryType,
      taxonomyNodeId: taxonomyNodeId ?? this.taxonomyNodeId,
      count: count ?? this.count,
    );
  }
}
