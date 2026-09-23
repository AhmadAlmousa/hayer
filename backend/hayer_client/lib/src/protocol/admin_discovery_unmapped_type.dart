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
import 'discovery_type_mapping_issue.dart' as _i0ly2vwv;

abstract class AdminDiscoveryUnmappedType
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminDiscoveryUnmappedType._({
    required this.primaryType,
    required this.issue,
    required this.catalogPlaceCount,
    required this.observationCount,
    required this.firstObservedAt,
    required this.lastObservedAt,
    required this.exampleCatalogIds,
  });

  factory AdminDiscoveryUnmappedType({
    required String primaryType,
    required _i0ly2vwv.DiscoveryTypeMappingIssue issue,
    required int catalogPlaceCount,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
    required List<int> exampleCatalogIds,
  }) = _AdminDiscoveryUnmappedTypeImpl;

  factory AdminDiscoveryUnmappedType.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryUnmappedType(
      primaryType: jsonSerialization['primaryType'] as String,
      issue: _i0ly2vwv.DiscoveryTypeMappingIssue.fromJson(
        (jsonSerialization['issue'] as String),
      ),
      catalogPlaceCount: jsonSerialization['catalogPlaceCount'] as int,
      observationCount: jsonSerialization['observationCount'] as int,
      firstObservedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstObservedAt'],
      ),
      lastObservedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastObservedAt'],
      ),
      exampleCatalogIds: _iynev3sz.Protocol().deserialize<List<int>>(
        jsonSerialization['exampleCatalogIds'],
      ),
    );
  }

  String primaryType;

  _i0ly2vwv.DiscoveryTypeMappingIssue issue;

  int catalogPlaceCount;

  int observationCount;

  DateTime firstObservedAt;

  DateTime lastObservedAt;

  List<int> exampleCatalogIds;

  /// Returns a shallow copy of this [AdminDiscoveryUnmappedType]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminDiscoveryUnmappedType copyWith({
    String? primaryType,
    _i0ly2vwv.DiscoveryTypeMappingIssue? issue,
    int? catalogPlaceCount,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
    List<int>? exampleCatalogIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryUnmappedType',
      'primaryType': primaryType,
      'issue': issue.toJson(),
      'catalogPlaceCount': catalogPlaceCount,
      'observationCount': observationCount,
      'firstObservedAt': firstObservedAt.toJson(),
      'lastObservedAt': lastObservedAt.toJson(),
      'exampleCatalogIds': exampleCatalogIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryUnmappedType',
      'primaryType': primaryType,
      'issue': issue.toJson(),
      'catalogPlaceCount': catalogPlaceCount,
      'observationCount': observationCount,
      'firstObservedAt': firstObservedAt.toJson(),
      'lastObservedAt': lastObservedAt.toJson(),
      'exampleCatalogIds': exampleCatalogIds.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminDiscoveryUnmappedTypeImpl extends AdminDiscoveryUnmappedType {
  _AdminDiscoveryUnmappedTypeImpl({
    required String primaryType,
    required _i0ly2vwv.DiscoveryTypeMappingIssue issue,
    required int catalogPlaceCount,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
    required List<int> exampleCatalogIds,
  }) : super._(
         primaryType: primaryType,
         issue: issue,
         catalogPlaceCount: catalogPlaceCount,
         observationCount: observationCount,
         firstObservedAt: firstObservedAt,
         lastObservedAt: lastObservedAt,
         exampleCatalogIds: exampleCatalogIds,
       );

  /// Returns a shallow copy of this [AdminDiscoveryUnmappedType]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminDiscoveryUnmappedType copyWith({
    String? primaryType,
    _i0ly2vwv.DiscoveryTypeMappingIssue? issue,
    int? catalogPlaceCount,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
    List<int>? exampleCatalogIds,
  }) {
    return AdminDiscoveryUnmappedType(
      primaryType: primaryType ?? this.primaryType,
      issue: issue ?? this.issue,
      catalogPlaceCount: catalogPlaceCount ?? this.catalogPlaceCount,
      observationCount: observationCount ?? this.observationCount,
      firstObservedAt: firstObservedAt ?? this.firstObservedAt,
      lastObservedAt: lastObservedAt ?? this.lastObservedAt,
      exampleCatalogIds:
          exampleCatalogIds ?? this.exampleCatalogIds.map((e0) => e0).toList(),
    );
  }
}
