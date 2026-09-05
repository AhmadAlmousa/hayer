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
import 'taxonomy_kind.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class TaxonomyItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TaxonomyItem._({
    required this.id,
    required this.kind,
    required this.parentCategoryIds,
    required this.labelEn,
    required this.labelAr,
    required this.emoji,
    required this.sortOrder,
    required this.enabled,
  });

  factory TaxonomyItem({
    required String id,
    required _i2.TaxonomyKind kind,
    required List<String> parentCategoryIds,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required int sortOrder,
    required bool enabled,
  }) = _TaxonomyItemImpl;

  factory TaxonomyItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaxonomyItem(
      id: jsonSerialization['id'] as String,
      kind: _i2.TaxonomyKind.fromJson((jsonSerialization['kind'] as String)),
      parentCategoryIds: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['parentCategoryIds'],
      ),
      labelEn: jsonSerialization['labelEn'] as String,
      labelAr: jsonSerialization['labelAr'] as String,
      emoji: jsonSerialization['emoji'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int,
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  String id;

  _i2.TaxonomyKind kind;

  List<String> parentCategoryIds;

  String labelEn;

  String labelAr;

  String emoji;

  int sortOrder;

  bool enabled;

  /// Returns a shallow copy of this [TaxonomyItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaxonomyItem copyWith({
    String? id,
    _i2.TaxonomyKind? kind,
    List<String>? parentCategoryIds,
    String? labelEn,
    String? labelAr,
    String? emoji,
    int? sortOrder,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomyItem',
      'id': id,
      'kind': kind.toJson(),
      'parentCategoryIds': parentCategoryIds.toJson(),
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaxonomyItem',
      'id': id,
      'kind': kind.toJson(),
      'parentCategoryIds': parentCategoryIds.toJson(),
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TaxonomyItemImpl extends TaxonomyItem {
  _TaxonomyItemImpl({
    required String id,
    required _i2.TaxonomyKind kind,
    required List<String> parentCategoryIds,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required int sortOrder,
    required bool enabled,
  }) : super._(
         id: id,
         kind: kind,
         parentCategoryIds: parentCategoryIds,
         labelEn: labelEn,
         labelAr: labelAr,
         emoji: emoji,
         sortOrder: sortOrder,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [TaxonomyItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaxonomyItem copyWith({
    String? id,
    _i2.TaxonomyKind? kind,
    List<String>? parentCategoryIds,
    String? labelEn,
    String? labelAr,
    String? emoji,
    int? sortOrder,
    bool? enabled,
  }) {
    return TaxonomyItem(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      parentCategoryIds:
          parentCategoryIds ?? this.parentCategoryIds.map((e0) => e0).toList(),
      labelEn: labelEn ?? this.labelEn,
      labelAr: labelAr ?? this.labelAr,
      emoji: emoji ?? this.emoji,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
    );
  }
}
