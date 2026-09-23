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

abstract class DiscoveryHarvestManifestValidation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryHarvestManifestValidation._({
    required this.passed,
    required this.errors,
    required this.revision,
    required this.validatedAt,
  });

  factory DiscoveryHarvestManifestValidation({
    required bool passed,
    required List<String> errors,
    required int revision,
    required DateTime validatedAt,
  }) = _DiscoveryHarvestManifestValidationImpl;

  factory DiscoveryHarvestManifestValidation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryHarvestManifestValidation(
      passed: _isc.BoolJsonExtension.fromJson(jsonSerialization['passed']),
      errors: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
      revision: jsonSerialization['revision'] as int,
      validatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['validatedAt'],
      ),
    );
  }

  bool passed;

  List<String> errors;

  int revision;

  DateTime validatedAt;

  /// Returns a shallow copy of this [DiscoveryHarvestManifestValidation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryHarvestManifestValidation copyWith({
    bool? passed,
    List<String>? errors,
    int? revision,
    DateTime? validatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestManifestValidation',
      'passed': passed,
      'errors': errors.toJson(),
      'revision': revision,
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryHarvestManifestValidation',
      'passed': passed,
      'errors': errors.toJson(),
      'revision': revision,
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoveryHarvestManifestValidationImpl
    extends DiscoveryHarvestManifestValidation {
  _DiscoveryHarvestManifestValidationImpl({
    required bool passed,
    required List<String> errors,
    required int revision,
    required DateTime validatedAt,
  }) : super._(
         passed: passed,
         errors: errors,
         revision: revision,
         validatedAt: validatedAt,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestManifestValidation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryHarvestManifestValidation copyWith({
    bool? passed,
    List<String>? errors,
    int? revision,
    DateTime? validatedAt,
  }) {
    return DiscoveryHarvestManifestValidation(
      passed: passed ?? this.passed,
      errors: errors ?? this.errors.map((e0) => e0).toList(),
      revision: revision ?? this.revision,
      validatedAt: validatedAt ?? this.validatedAt,
    );
  }
}
