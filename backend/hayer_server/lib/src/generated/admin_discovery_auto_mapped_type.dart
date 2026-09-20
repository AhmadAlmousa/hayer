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

/// One provider type the Discover auto-mapper attached to a node, so the admin
/// can show which aliases a person chose and which the mapper guessed.
abstract class AdminDiscoveryAutoMappedType
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminDiscoveryAutoMappedType._({
    required this.primaryType,
    required this.typeKey,
    required this.nodeId,
    required this.nodeLabel,
    required this.rule,
    required this.mappedAt,
  });

  factory AdminDiscoveryAutoMappedType({
    required String primaryType,
    required String typeKey,
    required String nodeId,
    required String nodeLabel,
    required String rule,
    required DateTime mappedAt,
  }) = _AdminDiscoveryAutoMappedTypeImpl;

  factory AdminDiscoveryAutoMappedType.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryAutoMappedType(
      primaryType: jsonSerialization['primaryType'] as String,
      typeKey: jsonSerialization['typeKey'] as String,
      nodeId: jsonSerialization['nodeId'] as String,
      nodeLabel: jsonSerialization['nodeLabel'] as String,
      rule: jsonSerialization['rule'] as String,
      mappedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['mappedAt'],
      ),
    );
  }

  String primaryType;

  String typeKey;

  String nodeId;

  String nodeLabel;

  String rule;

  DateTime mappedAt;

  /// Returns a shallow copy of this [AdminDiscoveryAutoMappedType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminDiscoveryAutoMappedType copyWith({
    String? primaryType,
    String? typeKey,
    String? nodeId,
    String? nodeLabel,
    String? rule,
    DateTime? mappedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryAutoMappedType',
      'primaryType': primaryType,
      'typeKey': typeKey,
      'nodeId': nodeId,
      'nodeLabel': nodeLabel,
      'rule': rule,
      'mappedAt': mappedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryAutoMappedType',
      'primaryType': primaryType,
      'typeKey': typeKey,
      'nodeId': nodeId,
      'nodeLabel': nodeLabel,
      'rule': rule,
      'mappedAt': mappedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminDiscoveryAutoMappedTypeImpl extends AdminDiscoveryAutoMappedType {
  _AdminDiscoveryAutoMappedTypeImpl({
    required String primaryType,
    required String typeKey,
    required String nodeId,
    required String nodeLabel,
    required String rule,
    required DateTime mappedAt,
  }) : super._(
         primaryType: primaryType,
         typeKey: typeKey,
         nodeId: nodeId,
         nodeLabel: nodeLabel,
         rule: rule,
         mappedAt: mappedAt,
       );

  /// Returns a shallow copy of this [AdminDiscoveryAutoMappedType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminDiscoveryAutoMappedType copyWith({
    String? primaryType,
    String? typeKey,
    String? nodeId,
    String? nodeLabel,
    String? rule,
    DateTime? mappedAt,
  }) {
    return AdminDiscoveryAutoMappedType(
      primaryType: primaryType ?? this.primaryType,
      typeKey: typeKey ?? this.typeKey,
      nodeId: nodeId ?? this.nodeId,
      nodeLabel: nodeLabel ?? this.nodeLabel,
      rule: rule ?? this.rule,
      mappedAt: mappedAt ?? this.mappedAt,
    );
  }
}
