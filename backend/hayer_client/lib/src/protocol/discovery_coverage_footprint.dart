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
import 'discover_viewport.dart' as _i1okvcdc;

abstract class DiscoveryCoverageFootprint
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryCoverageFootprint._({
    required this.cellId,
    required this.bounds,
    required this.manifestRevision,
    required this.completedQueryGroups,
    required this.incompleteQueryGroups,
    this.lastAttemptAt,
    this.lastSuccessAt,
    this.retryAfter,
  });

  factory DiscoveryCoverageFootprint({
    required String cellId,
    required _i1okvcdc.DiscoverViewport bounds,
    required int manifestRevision,
    required List<String> completedQueryGroups,
    required List<String> incompleteQueryGroups,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
  }) = _DiscoveryCoverageFootprintImpl;

  factory DiscoveryCoverageFootprint.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryCoverageFootprint(
      cellId: jsonSerialization['cellId'] as String,
      bounds: _iynev3sz.Protocol().deserialize<_i1okvcdc.DiscoverViewport>(
        jsonSerialization['bounds'],
      ),
      manifestRevision: jsonSerialization['manifestRevision'] as int,
      completedQueryGroups: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['completedQueryGroups'],
      ),
      incompleteQueryGroups: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['incompleteQueryGroups'],
      ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['retryAfter'],
            ),
    );
  }

  String cellId;

  _i1okvcdc.DiscoverViewport bounds;

  int manifestRevision;

  List<String> completedQueryGroups;

  List<String> incompleteQueryGroups;

  DateTime? lastAttemptAt;

  DateTime? lastSuccessAt;

  DateTime? retryAfter;

  /// Returns a shallow copy of this [DiscoveryCoverageFootprint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryCoverageFootprint copyWith({
    String? cellId,
    _i1okvcdc.DiscoverViewport? bounds,
    int? manifestRevision,
    List<String>? completedQueryGroups,
    List<String>? incompleteQueryGroups,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryCoverageFootprint',
      'cellId': cellId,
      'bounds': bounds.toJson(),
      'manifestRevision': manifestRevision,
      'completedQueryGroups': completedQueryGroups.toJson(),
      'incompleteQueryGroups': incompleteQueryGroups.toJson(),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryCoverageFootprint',
      'cellId': cellId,
      'bounds': bounds.toJsonForProtocol(),
      'manifestRevision': manifestRevision,
      'completedQueryGroups': completedQueryGroups.toJson(),
      'incompleteQueryGroups': incompleteQueryGroups.toJson(),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryCoverageFootprintImpl extends DiscoveryCoverageFootprint {
  _DiscoveryCoverageFootprintImpl({
    required String cellId,
    required _i1okvcdc.DiscoverViewport bounds,
    required int manifestRevision,
    required List<String> completedQueryGroups,
    required List<String> incompleteQueryGroups,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
  }) : super._(
         cellId: cellId,
         bounds: bounds,
         manifestRevision: manifestRevision,
         completedQueryGroups: completedQueryGroups,
         incompleteQueryGroups: incompleteQueryGroups,
         lastAttemptAt: lastAttemptAt,
         lastSuccessAt: lastSuccessAt,
         retryAfter: retryAfter,
       );

  /// Returns a shallow copy of this [DiscoveryCoverageFootprint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryCoverageFootprint copyWith({
    String? cellId,
    _i1okvcdc.DiscoverViewport? bounds,
    int? manifestRevision,
    List<String>? completedQueryGroups,
    List<String>? incompleteQueryGroups,
    Object? lastAttemptAt = _Undefined,
    Object? lastSuccessAt = _Undefined,
    Object? retryAfter = _Undefined,
  }) {
    return DiscoveryCoverageFootprint(
      cellId: cellId ?? this.cellId,
      bounds: bounds ?? this.bounds.copyWith(),
      manifestRevision: manifestRevision ?? this.manifestRevision,
      completedQueryGroups:
          completedQueryGroups ??
          this.completedQueryGroups.map((e0) => e0).toList(),
      incompleteQueryGroups:
          incompleteQueryGroups ??
          this.incompleteQueryGroups.map((e0) => e0).toList(),
      lastAttemptAt: lastAttemptAt is DateTime?
          ? lastAttemptAt
          : this.lastAttemptAt,
      lastSuccessAt: lastSuccessAt is DateTime?
          ? lastSuccessAt
          : this.lastSuccessAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
    );
  }
}
