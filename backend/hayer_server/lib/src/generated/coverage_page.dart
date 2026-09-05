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
import 'coverage_record.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class CoveragePage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CoveragePage._({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory CoveragePage({
    required List<_i2.CoverageRecord> items,
    required int total,
    required int page,
    required int pageSize,
  }) = _CoveragePageImpl;

  factory CoveragePage.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoveragePage(
      items: _i3.Protocol().deserialize<List<_i2.CoverageRecord>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
    );
  }

  List<_i2.CoverageRecord> items;

  int total;

  int page;

  int pageSize;

  /// Returns a shallow copy of this [CoveragePage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CoveragePage copyWith({
    List<_i2.CoverageRecord>? items,
    int? total,
    int? page,
    int? pageSize,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoveragePage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoveragePage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CoveragePageImpl extends CoveragePage {
  _CoveragePageImpl({
    required List<_i2.CoverageRecord> items,
    required int total,
    required int page,
    required int pageSize,
  }) : super._(
         items: items,
         total: total,
         page: page,
         pageSize: pageSize,
       );

  /// Returns a shallow copy of this [CoveragePage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CoveragePage copyWith({
    List<_i2.CoverageRecord>? items,
    int? total,
    int? page,
    int? pageSize,
  }) {
    return CoveragePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
