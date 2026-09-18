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
import 'admin_discovery_auto_mapped_type.dart' as _i2;
import 'package:hayer_client/src/protocol/protocol.dart' as _i3;

/// What the Discover type auto-mapper has done, for the unmapped-types page
/// and the tree editor.
abstract class AdminDiscoveryAutoMapReport implements _i1.SerializableModel {
  AdminDiscoveryAutoMapReport._({
    required this.enabled,
    required this.mappedTypeCount,
    this.lastMappedAt,
    required this.recent,
  });

  factory AdminDiscoveryAutoMapReport({
    required bool enabled,
    required int mappedTypeCount,
    DateTime? lastMappedAt,
    required List<_i2.AdminDiscoveryAutoMappedType> recent,
  }) = _AdminDiscoveryAutoMapReportImpl;

  factory AdminDiscoveryAutoMapReport.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryAutoMapReport(
      enabled: _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      mappedTypeCount: jsonSerialization['mappedTypeCount'] as int,
      lastMappedAt: jsonSerialization['lastMappedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMappedAt'],
            ),
      recent: _i3.Protocol()
          .deserialize<List<_i2.AdminDiscoveryAutoMappedType>>(
            jsonSerialization['recent'],
          ),
    );
  }

  /// Whether the harvest is currently allowed to map types by itself.
  bool enabled;

  /// How many observed types the mapper has attached in total.
  int mappedTypeCount;

  /// When it last attached one, null when it never has.
  DateTime? lastMappedAt;

  /// The most recent assignments, newest first.
  List<_i2.AdminDiscoveryAutoMappedType> recent;

  /// Returns a shallow copy of this [AdminDiscoveryAutoMapReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminDiscoveryAutoMapReport copyWith({
    bool? enabled,
    int? mappedTypeCount,
    DateTime? lastMappedAt,
    List<_i2.AdminDiscoveryAutoMappedType>? recent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryAutoMapReport',
      'enabled': enabled,
      'mappedTypeCount': mappedTypeCount,
      if (lastMappedAt != null) 'lastMappedAt': lastMappedAt?.toJson(),
      'recent': recent.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminDiscoveryAutoMapReportImpl extends AdminDiscoveryAutoMapReport {
  _AdminDiscoveryAutoMapReportImpl({
    required bool enabled,
    required int mappedTypeCount,
    DateTime? lastMappedAt,
    required List<_i2.AdminDiscoveryAutoMappedType> recent,
  }) : super._(
         enabled: enabled,
         mappedTypeCount: mappedTypeCount,
         lastMappedAt: lastMappedAt,
         recent: recent,
       );

  /// Returns a shallow copy of this [AdminDiscoveryAutoMapReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminDiscoveryAutoMapReport copyWith({
    bool? enabled,
    int? mappedTypeCount,
    Object? lastMappedAt = _Undefined,
    List<_i2.AdminDiscoveryAutoMappedType>? recent,
  }) {
    return AdminDiscoveryAutoMapReport(
      enabled: enabled ?? this.enabled,
      mappedTypeCount: mappedTypeCount ?? this.mappedTypeCount,
      lastMappedAt: lastMappedAt is DateTime?
          ? lastMappedAt
          : this.lastMappedAt,
      recent: recent ?? this.recent.map((e0) => e0.copyWith()).toList(),
    );
  }
}
