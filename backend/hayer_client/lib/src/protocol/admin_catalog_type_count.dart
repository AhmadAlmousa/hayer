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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class AdminCatalogTypeCount
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminCatalogTypeCount._({
    required this.primaryType,
    required this.count,
  });

  factory AdminCatalogTypeCount({
    required String primaryType,
    required int count,
  }) = _AdminCatalogTypeCountImpl;

  factory AdminCatalogTypeCount.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminCatalogTypeCount(
      primaryType: jsonSerialization['primaryType'] as String,
      count: jsonSerialization['count'] as int,
    );
  }

  String primaryType;

  int count;

  /// Returns a shallow copy of this [AdminCatalogTypeCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminCatalogTypeCount copyWith({
    String? primaryType,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogTypeCount',
      'primaryType': primaryType,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogTypeCount',
      'primaryType': primaryType,
      'count': count,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminCatalogTypeCountImpl extends AdminCatalogTypeCount {
  _AdminCatalogTypeCountImpl({
    required String primaryType,
    required int count,
  }) : super._(
         primaryType: primaryType,
         count: count,
       );

  /// Returns a shallow copy of this [AdminCatalogTypeCount]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminCatalogTypeCount copyWith({
    String? primaryType,
    int? count,
  }) {
    return AdminCatalogTypeCount(
      primaryType: primaryType ?? this.primaryType,
      count: count ?? this.count,
    );
  }
}
