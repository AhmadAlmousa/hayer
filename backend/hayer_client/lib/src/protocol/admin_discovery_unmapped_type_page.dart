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
import 'package:hayer_client/src/protocol/protocol.dart' as _iynev3sz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'admin_discovery_unmapped_type.dart' as _io11b7f4;

abstract class AdminDiscoveryUnmappedTypePage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminDiscoveryUnmappedTypePage._({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory AdminDiscoveryUnmappedTypePage({
    required List<_io11b7f4.AdminDiscoveryUnmappedType> items,
    required int total,
    required int page,
    required int pageSize,
  }) = _AdminDiscoveryUnmappedTypePageImpl;

  factory AdminDiscoveryUnmappedTypePage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryUnmappedTypePage(
      items: _iynev3sz.Protocol()
          .deserialize<List<_io11b7f4.AdminDiscoveryUnmappedType>>(
            jsonSerialization['items'],
          ),
      total: jsonSerialization['total'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
    );
  }

  List<_io11b7f4.AdminDiscoveryUnmappedType> items;

  int total;

  int page;

  int pageSize;

  /// Returns a shallow copy of this [AdminDiscoveryUnmappedTypePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminDiscoveryUnmappedTypePage copyWith({
    List<_io11b7f4.AdminDiscoveryUnmappedType>? items,
    int? total,
    int? page,
    int? pageSize,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryUnmappedTypePage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryUnmappedTypePage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminDiscoveryUnmappedTypePageImpl
    extends AdminDiscoveryUnmappedTypePage {
  _AdminDiscoveryUnmappedTypePageImpl({
    required List<_io11b7f4.AdminDiscoveryUnmappedType> items,
    required int total,
    required int page,
    required int pageSize,
  }) : super._(
         items: items,
         total: total,
         page: page,
         pageSize: pageSize,
       );

  /// Returns a shallow copy of this [AdminDiscoveryUnmappedTypePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminDiscoveryUnmappedTypePage copyWith({
    List<_io11b7f4.AdminDiscoveryUnmappedType>? items,
    int? total,
    int? page,
    int? pageSize,
  }) {
    return AdminDiscoveryUnmappedTypePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
