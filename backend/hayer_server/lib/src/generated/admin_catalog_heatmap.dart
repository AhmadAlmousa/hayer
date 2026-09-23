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
import 'admin_catalog_heat_cell.dart' as _i1cajeij;

abstract class AdminCatalogHeatmap
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminCatalogHeatmap._({
    required this.cells,
    required this.total,
    required this.maximumCount,
    required this.generatedAt,
  });

  factory AdminCatalogHeatmap({
    required List<_i1cajeij.AdminCatalogHeatCell> cells,
    required int total,
    required int maximumCount,
    required DateTime generatedAt,
  }) = _AdminCatalogHeatmapImpl;

  factory AdminCatalogHeatmap.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminCatalogHeatmap(
      cells: _i66y2smk.Protocol()
          .deserialize<List<_i1cajeij.AdminCatalogHeatCell>>(
            jsonSerialization['cells'],
          ),
      total: jsonSerialization['total'] as int,
      maximumCount: jsonSerialization['maximumCount'] as int,
      generatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  List<_i1cajeij.AdminCatalogHeatCell> cells;

  int total;

  int maximumCount;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminCatalogHeatmap]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminCatalogHeatmap copyWith({
    List<_i1cajeij.AdminCatalogHeatCell>? cells,
    int? total,
    int? maximumCount,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogHeatmap',
      'cells': cells.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'maximumCount': maximumCount,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogHeatmap',
      'cells': cells.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'maximumCount': maximumCount,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminCatalogHeatmapImpl extends AdminCatalogHeatmap {
  _AdminCatalogHeatmapImpl({
    required List<_i1cajeij.AdminCatalogHeatCell> cells,
    required int total,
    required int maximumCount,
    required DateTime generatedAt,
  }) : super._(
         cells: cells,
         total: total,
         maximumCount: maximumCount,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminCatalogHeatmap]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminCatalogHeatmap copyWith({
    List<_i1cajeij.AdminCatalogHeatCell>? cells,
    int? total,
    int? maximumCount,
    DateTime? generatedAt,
  }) {
    return AdminCatalogHeatmap(
      cells: cells ?? this.cells.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      maximumCount: maximumCount ?? this.maximumCount,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
