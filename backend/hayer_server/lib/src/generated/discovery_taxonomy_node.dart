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
import 'discovery_taxonomy_node.dart' as _i3sj4yil;

abstract class DiscoveryTaxonomyNode
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryTaxonomyNode._({
    required this.id,
    required this.labelEn,
    required this.labelAr,
    required this.emoji,
    required this.typeAliases,
    required this.children,
    this.selectable,
    this.selectionGroupRoot,
    this.searchQueryEn,
    this.searchQueryAr,
  });

  factory DiscoveryTaxonomyNode({
    required String id,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required List<String> typeAliases,
    required List<_i3sj4yil.DiscoveryTaxonomyNode> children,
    bool? selectable,
    bool? selectionGroupRoot,
    String? searchQueryEn,
    String? searchQueryAr,
  }) = _DiscoveryTaxonomyNodeImpl;

  factory DiscoveryTaxonomyNode.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTaxonomyNode(
      id: jsonSerialization['id'] as String,
      labelEn: jsonSerialization['labelEn'] as String,
      labelAr: jsonSerialization['labelAr'] as String,
      emoji: jsonSerialization['emoji'] as String,
      typeAliases: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['typeAliases'],
      ),
      children: _i66y2smk.Protocol()
          .deserialize<List<_i3sj4yil.DiscoveryTaxonomyNode>>(
            jsonSerialization['children'],
          ),
      selectable: jsonSerialization['selectable'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['selectable']),
      selectionGroupRoot: jsonSerialization['selectionGroupRoot'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['selectionGroupRoot'],
            ),
      searchQueryEn: jsonSerialization['searchQueryEn'] as String?,
      searchQueryAr: jsonSerialization['searchQueryAr'] as String?,
    );
  }

  String id;

  String labelEn;

  String labelAr;

  String emoji;

  List<String> typeAliases;

  List<_i3sj4yil.DiscoveryTaxonomyNode> children;

  bool? selectable;

  bool? selectionGroupRoot;

  String? searchQueryEn;

  String? searchQueryAr;

  /// Returns a shallow copy of this [DiscoveryTaxonomyNode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryTaxonomyNode copyWith({
    String? id,
    String? labelEn,
    String? labelAr,
    String? emoji,
    List<String>? typeAliases,
    List<_i3sj4yil.DiscoveryTaxonomyNode>? children,
    bool? selectable,
    bool? selectionGroupRoot,
    String? searchQueryEn,
    String? searchQueryAr,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTaxonomyNode',
      'id': id,
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'typeAliases': typeAliases.toJson(),
      'children': children.toJson(valueToJson: (v) => v.toJson()),
      if (selectable != null) 'selectable': selectable,
      if (selectionGroupRoot != null) 'selectionGroupRoot': selectionGroupRoot,
      if (searchQueryEn != null) 'searchQueryEn': searchQueryEn,
      if (searchQueryAr != null) 'searchQueryAr': searchQueryAr,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryTaxonomyNode',
      'id': id,
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'typeAliases': typeAliases.toJson(),
      'children': children.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (selectable != null) 'selectable': selectable,
      if (selectionGroupRoot != null) 'selectionGroupRoot': selectionGroupRoot,
      if (searchQueryEn != null) 'searchQueryEn': searchQueryEn,
      if (searchQueryAr != null) 'searchQueryAr': searchQueryAr,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTaxonomyNodeImpl extends DiscoveryTaxonomyNode {
  _DiscoveryTaxonomyNodeImpl({
    required String id,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required List<String> typeAliases,
    required List<_i3sj4yil.DiscoveryTaxonomyNode> children,
    bool? selectable,
    bool? selectionGroupRoot,
    String? searchQueryEn,
    String? searchQueryAr,
  }) : super._(
         id: id,
         labelEn: labelEn,
         labelAr: labelAr,
         emoji: emoji,
         typeAliases: typeAliases,
         children: children,
         selectable: selectable,
         selectionGroupRoot: selectionGroupRoot,
         searchQueryEn: searchQueryEn,
         searchQueryAr: searchQueryAr,
       );

  /// Returns a shallow copy of this [DiscoveryTaxonomyNode]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryTaxonomyNode copyWith({
    String? id,
    String? labelEn,
    String? labelAr,
    String? emoji,
    List<String>? typeAliases,
    List<_i3sj4yil.DiscoveryTaxonomyNode>? children,
    Object? selectable = _Undefined,
    Object? selectionGroupRoot = _Undefined,
    Object? searchQueryEn = _Undefined,
    Object? searchQueryAr = _Undefined,
  }) {
    return DiscoveryTaxonomyNode(
      id: id ?? this.id,
      labelEn: labelEn ?? this.labelEn,
      labelAr: labelAr ?? this.labelAr,
      emoji: emoji ?? this.emoji,
      typeAliases: typeAliases ?? this.typeAliases.map((e0) => e0).toList(),
      children: children ?? this.children.map((e0) => e0.copyWith()).toList(),
      selectable: selectable is bool? ? selectable : this.selectable,
      selectionGroupRoot: selectionGroupRoot is bool?
          ? selectionGroupRoot
          : this.selectionGroupRoot,
      searchQueryEn: searchQueryEn is String?
          ? searchQueryEn
          : this.searchQueryEn,
      searchQueryAr: searchQueryAr is String?
          ? searchQueryAr
          : this.searchQueryAr,
    );
  }
}
