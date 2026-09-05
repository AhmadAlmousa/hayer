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

abstract class AdminTaxonomyItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminTaxonomyItem._({
    required this.id,
    required this.kind,
    required this.parentCategoryIds,
    required this.labelEn,
    required this.labelAr,
    required this.emoji,
    required this.searchQueryEn,
    this.searchQueryAr,
    required this.sortOrder,
    required this.enabled,
  });

  factory AdminTaxonomyItem({
    required String id,
    required _i2.TaxonomyKind kind,
    required List<String> parentCategoryIds,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required String searchQueryEn,
    String? searchQueryAr,
    required int sortOrder,
    required bool enabled,
  }) = _AdminTaxonomyItemImpl;

  factory AdminTaxonomyItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminTaxonomyItem(
      id: jsonSerialization['id'] as String,
      kind: _i2.TaxonomyKind.fromJson((jsonSerialization['kind'] as String)),
      parentCategoryIds: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['parentCategoryIds'],
      ),
      labelEn: jsonSerialization['labelEn'] as String,
      labelAr: jsonSerialization['labelAr'] as String,
      emoji: jsonSerialization['emoji'] as String,
      searchQueryEn: jsonSerialization['searchQueryEn'] as String,
      searchQueryAr: jsonSerialization['searchQueryAr'] as String?,
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

  String searchQueryEn;

  String? searchQueryAr;

  int sortOrder;

  bool enabled;

  /// Returns a shallow copy of this [AdminTaxonomyItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminTaxonomyItem copyWith({
    String? id,
    _i2.TaxonomyKind? kind,
    List<String>? parentCategoryIds,
    String? labelEn,
    String? labelAr,
    String? emoji,
    String? searchQueryEn,
    String? searchQueryAr,
    int? sortOrder,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminTaxonomyItem',
      'id': id,
      'kind': kind.toJson(),
      'parentCategoryIds': parentCategoryIds.toJson(),
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'searchQueryEn': searchQueryEn,
      if (searchQueryAr != null) 'searchQueryAr': searchQueryAr,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminTaxonomyItem',
      'id': id,
      'kind': kind.toJson(),
      'parentCategoryIds': parentCategoryIds.toJson(),
      'labelEn': labelEn,
      'labelAr': labelAr,
      'emoji': emoji,
      'searchQueryEn': searchQueryEn,
      if (searchQueryAr != null) 'searchQueryAr': searchQueryAr,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminTaxonomyItemImpl extends AdminTaxonomyItem {
  _AdminTaxonomyItemImpl({
    required String id,
    required _i2.TaxonomyKind kind,
    required List<String> parentCategoryIds,
    required String labelEn,
    required String labelAr,
    required String emoji,
    required String searchQueryEn,
    String? searchQueryAr,
    required int sortOrder,
    required bool enabled,
  }) : super._(
         id: id,
         kind: kind,
         parentCategoryIds: parentCategoryIds,
         labelEn: labelEn,
         labelAr: labelAr,
         emoji: emoji,
         searchQueryEn: searchQueryEn,
         searchQueryAr: searchQueryAr,
         sortOrder: sortOrder,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [AdminTaxonomyItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminTaxonomyItem copyWith({
    String? id,
    _i2.TaxonomyKind? kind,
    List<String>? parentCategoryIds,
    String? labelEn,
    String? labelAr,
    String? emoji,
    String? searchQueryEn,
    Object? searchQueryAr = _Undefined,
    int? sortOrder,
    bool? enabled,
  }) {
    return AdminTaxonomyItem(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      parentCategoryIds:
          parentCategoryIds ?? this.parentCategoryIds.map((e0) => e0).toList(),
      labelEn: labelEn ?? this.labelEn,
      labelAr: labelAr ?? this.labelAr,
      emoji: emoji ?? this.emoji,
      searchQueryEn: searchQueryEn ?? this.searchQueryEn,
      searchQueryAr: searchQueryAr is String?
          ? searchQueryAr
          : this.searchQueryAr,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
    );
  }
}
