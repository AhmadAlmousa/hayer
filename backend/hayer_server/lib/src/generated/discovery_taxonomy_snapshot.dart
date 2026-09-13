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
import 'discovery_taxonomy_node.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class DiscoveryTaxonomySnapshot
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryTaxonomySnapshot._({
    required this.revision,
    required this.roots,
    required this.fetchedAt,
  });

  factory DiscoveryTaxonomySnapshot({
    required int revision,
    required List<_i2.DiscoveryTaxonomyNode> roots,
    required DateTime fetchedAt,
  }) = _DiscoveryTaxonomySnapshotImpl;

  factory DiscoveryTaxonomySnapshot.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTaxonomySnapshot(
      revision: jsonSerialization['revision'] as int,
      roots: _i3.Protocol().deserialize<List<_i2.DiscoveryTaxonomyNode>>(
        jsonSerialization['roots'],
      ),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  int revision;

  List<_i2.DiscoveryTaxonomyNode> roots;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [DiscoveryTaxonomySnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryTaxonomySnapshot copyWith({
    int? revision,
    List<_i2.DiscoveryTaxonomyNode>? roots,
    DateTime? fetchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTaxonomySnapshot',
      'revision': revision,
      'roots': roots.toJson(valueToJson: (v) => v.toJson()),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryTaxonomySnapshot',
      'revision': revision,
      'roots': roots.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoveryTaxonomySnapshotImpl extends DiscoveryTaxonomySnapshot {
  _DiscoveryTaxonomySnapshotImpl({
    required int revision,
    required List<_i2.DiscoveryTaxonomyNode> roots,
    required DateTime fetchedAt,
  }) : super._(
         revision: revision,
         roots: roots,
         fetchedAt: fetchedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTaxonomySnapshot]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryTaxonomySnapshot copyWith({
    int? revision,
    List<_i2.DiscoveryTaxonomyNode>? roots,
    DateTime? fetchedAt,
  }) {
    return DiscoveryTaxonomySnapshot(
      revision: revision ?? this.revision,
      roots: roots ?? this.roots.map((e0) => e0.copyWith()).toList(),
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
