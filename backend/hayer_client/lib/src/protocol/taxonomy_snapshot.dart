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
import 'taxonomy_item.dart' as _ikn8u775;

abstract class TaxonomySnapshot
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TaxonomySnapshot._({
    required this.version,
    required this.items,
  });

  factory TaxonomySnapshot({
    required String version,
    required List<_ikn8u775.TaxonomyItem> items,
  }) = _TaxonomySnapshotImpl;

  factory TaxonomySnapshot.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaxonomySnapshot(
      version: jsonSerialization['version'] as String,
      items: _iynev3sz.Protocol().deserialize<List<_ikn8u775.TaxonomyItem>>(
        jsonSerialization['items'],
      ),
    );
  }

  String version;

  List<_ikn8u775.TaxonomyItem> items;

  /// Returns a shallow copy of this [TaxonomySnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TaxonomySnapshot copyWith({
    String? version,
    List<_ikn8u775.TaxonomyItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomySnapshot',
      'version': version,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaxonomySnapshot',
      'version': version,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _TaxonomySnapshotImpl extends TaxonomySnapshot {
  _TaxonomySnapshotImpl({
    required String version,
    required List<_ikn8u775.TaxonomyItem> items,
  }) : super._(
         version: version,
         items: items,
       );

  /// Returns a shallow copy of this [TaxonomySnapshot]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TaxonomySnapshot copyWith({
    String? version,
    List<_ikn8u775.TaxonomyItem>? items,
  }) {
    return TaxonomySnapshot(
      version: version ?? this.version,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
