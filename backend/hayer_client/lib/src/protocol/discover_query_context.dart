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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class DiscoverQueryContext
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoverQueryContext._({
    required this.fingerprint,
    required this.countryCode,
    required this.policyRevision,
    required this.taxonomyRevision,
    required this.evaluatedAt,
  });

  factory DiscoverQueryContext({
    required String fingerprint,
    required String countryCode,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime evaluatedAt,
  }) = _DiscoverQueryContextImpl;

  factory DiscoverQueryContext.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoverQueryContext(
      fingerprint: jsonSerialization['fingerprint'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      policyRevision: jsonSerialization['policyRevision'] as int,
      taxonomyRevision: jsonSerialization['taxonomyRevision'] as int,
      evaluatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['evaluatedAt'],
      ),
    );
  }

  String fingerprint;

  String countryCode;

  int policyRevision;

  int taxonomyRevision;

  DateTime evaluatedAt;

  /// Returns a shallow copy of this [DiscoverQueryContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoverQueryContext copyWith({
    String? fingerprint,
    String? countryCode,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? evaluatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverQueryContext',
      'fingerprint': fingerprint,
      'countryCode': countryCode,
      'policyRevision': policyRevision,
      'taxonomyRevision': taxonomyRevision,
      'evaluatedAt': evaluatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverQueryContext',
      'fingerprint': fingerprint,
      'countryCode': countryCode,
      'policyRevision': policyRevision,
      'taxonomyRevision': taxonomyRevision,
      'evaluatedAt': evaluatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoverQueryContextImpl extends DiscoverQueryContext {
  _DiscoverQueryContextImpl({
    required String fingerprint,
    required String countryCode,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime evaluatedAt,
  }) : super._(
         fingerprint: fingerprint,
         countryCode: countryCode,
         policyRevision: policyRevision,
         taxonomyRevision: taxonomyRevision,
         evaluatedAt: evaluatedAt,
       );

  /// Returns a shallow copy of this [DiscoverQueryContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoverQueryContext copyWith({
    String? fingerprint,
    String? countryCode,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? evaluatedAt,
  }) {
    return DiscoverQueryContext(
      fingerprint: fingerprint ?? this.fingerprint,
      countryCode: countryCode ?? this.countryCode,
      policyRevision: policyRevision ?? this.policyRevision,
      taxonomyRevision: taxonomyRevision ?? this.taxonomyRevision,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
    );
  }
}
