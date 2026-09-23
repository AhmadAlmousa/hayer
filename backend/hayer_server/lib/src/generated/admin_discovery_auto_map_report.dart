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
import 'admin_discovery_auto_mapped_type.dart' as _izsiyar5;

/// What the Discover type auto-mapper has done, for the unmapped-types page
/// and the tree editor.
abstract class AdminDiscoveryAutoMapReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    required List<_izsiyar5.AdminDiscoveryAutoMappedType> recent,
  }) = _AdminDiscoveryAutoMapReportImpl;

  factory AdminDiscoveryAutoMapReport.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryAutoMapReport(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      mappedTypeCount: jsonSerialization['mappedTypeCount'] as int,
      lastMappedAt: jsonSerialization['lastMappedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMappedAt'],
            ),
      recent: _i66y2smk.Protocol()
          .deserialize<List<_izsiyar5.AdminDiscoveryAutoMappedType>>(
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
  List<_izsiyar5.AdminDiscoveryAutoMappedType> recent;

  /// Returns a shallow copy of this [AdminDiscoveryAutoMapReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminDiscoveryAutoMapReport copyWith({
    bool? enabled,
    int? mappedTypeCount,
    DateTime? lastMappedAt,
    List<_izsiyar5.AdminDiscoveryAutoMappedType>? recent,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryAutoMapReport',
      'enabled': enabled,
      'mappedTypeCount': mappedTypeCount,
      if (lastMappedAt != null) 'lastMappedAt': lastMappedAt?.toJson(),
      'recent': recent.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminDiscoveryAutoMapReportImpl extends AdminDiscoveryAutoMapReport {
  _AdminDiscoveryAutoMapReportImpl({
    required bool enabled,
    required int mappedTypeCount,
    DateTime? lastMappedAt,
    required List<_izsiyar5.AdminDiscoveryAutoMappedType> recent,
  }) : super._(
         enabled: enabled,
         mappedTypeCount: mappedTypeCount,
         lastMappedAt: lastMappedAt,
         recent: recent,
       );

  /// Returns a shallow copy of this [AdminDiscoveryAutoMapReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminDiscoveryAutoMapReport copyWith({
    bool? enabled,
    int? mappedTypeCount,
    Object? lastMappedAt = _Undefined,
    List<_izsiyar5.AdminDiscoveryAutoMappedType>? recent,
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
