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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'admin_catalog_place.dart' as _i2;
import 'admin_catalog_type_count.dart' as _i3;
import 'package:hayer_client/src/protocol/protocol.dart' as _i4;

abstract class AdminCatalogPage implements _i1.SerializableModel {
  AdminCatalogPage._({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
    required this.types,
    required this.freshAfter,
    required this.generatedAt,
  });

  factory AdminCatalogPage({
    required List<_i2.AdminCatalogPlace> items,
    required int total,
    required int page,
    required int pageSize,
    required List<_i3.AdminCatalogTypeCount> types,
    required DateTime freshAfter,
    required DateTime generatedAt,
  }) = _AdminCatalogPageImpl;

  factory AdminCatalogPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogPage(
      items: _i4.Protocol().deserialize<List<_i2.AdminCatalogPlace>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
      types: _i4.Protocol().deserialize<List<_i3.AdminCatalogTypeCount>>(
        jsonSerialization['types'],
      ),
      freshAfter: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['freshAfter'],
      ),
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  List<_i2.AdminCatalogPlace> items;

  int total;

  int page;

  int pageSize;

  List<_i3.AdminCatalogTypeCount> types;

  DateTime freshAfter;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminCatalogPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminCatalogPage copyWith({
    List<_i2.AdminCatalogPlace>? items,
    int? total,
    int? page,
    int? pageSize,
    List<_i3.AdminCatalogTypeCount>? types,
    DateTime? freshAfter,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
      'types': types.toJson(valueToJson: (v) => v.toJson()),
      'freshAfter': freshAfter.toJson(),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminCatalogPageImpl extends AdminCatalogPage {
  _AdminCatalogPageImpl({
    required List<_i2.AdminCatalogPlace> items,
    required int total,
    required int page,
    required int pageSize,
    required List<_i3.AdminCatalogTypeCount> types,
    required DateTime freshAfter,
    required DateTime generatedAt,
  }) : super._(
         items: items,
         total: total,
         page: page,
         pageSize: pageSize,
         types: types,
         freshAfter: freshAfter,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminCatalogPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminCatalogPage copyWith({
    List<_i2.AdminCatalogPlace>? items,
    int? total,
    int? page,
    int? pageSize,
    List<_i3.AdminCatalogTypeCount>? types,
    DateTime? freshAfter,
    DateTime? generatedAt,
  }) {
    return AdminCatalogPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      types: types ?? this.types.map((e0) => e0.copyWith()).toList(),
      freshAfter: freshAfter ?? this.freshAfter,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
