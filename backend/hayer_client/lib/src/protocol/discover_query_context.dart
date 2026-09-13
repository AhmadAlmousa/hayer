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

abstract class DiscoverQueryContext implements _i1.SerializableModel {
  DiscoverQueryContext._({
    required this.fingerprint,
    required this.policyRevision,
    required this.taxonomyRevision,
    required this.evaluatedAt,
  });

  factory DiscoverQueryContext({
    required String fingerprint,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime evaluatedAt,
  }) = _DiscoverQueryContextImpl;

  factory DiscoverQueryContext.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoverQueryContext(
      fingerprint: jsonSerialization['fingerprint'] as String,
      policyRevision: jsonSerialization['policyRevision'] as int,
      taxonomyRevision: jsonSerialization['taxonomyRevision'] as int,
      evaluatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['evaluatedAt'],
      ),
    );
  }

  String fingerprint;

  int policyRevision;

  int taxonomyRevision;

  DateTime evaluatedAt;

  /// Returns a shallow copy of this [DiscoverQueryContext]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverQueryContext copyWith({
    String? fingerprint,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? evaluatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverQueryContext',
      'fingerprint': fingerprint,
      'policyRevision': policyRevision,
      'taxonomyRevision': taxonomyRevision,
      'evaluatedAt': evaluatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DiscoverQueryContextImpl extends DiscoverQueryContext {
  _DiscoverQueryContextImpl({
    required String fingerprint,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime evaluatedAt,
  }) : super._(
         fingerprint: fingerprint,
         policyRevision: policyRevision,
         taxonomyRevision: taxonomyRevision,
         evaluatedAt: evaluatedAt,
       );

  /// Returns a shallow copy of this [DiscoverQueryContext]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverQueryContext copyWith({
    String? fingerprint,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? evaluatedAt,
  }) {
    return DiscoverQueryContext(
      fingerprint: fingerprint ?? this.fingerprint,
      policyRevision: policyRevision ?? this.policyRevision,
      taxonomyRevision: taxonomyRevision ?? this.taxonomyRevision,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
    );
  }
}
