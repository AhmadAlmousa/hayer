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
import 'package:hayer_server/src/generated/protocol.dart' as _i2;

abstract class CalibrationValidation
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CalibrationValidation._({
    required this.version,
    required this.fixturePassed,
    required this.liveCanaryPassed,
    required this.errors,
    required this.validatedAt,
  });

  factory CalibrationValidation({
    required String version,
    required bool fixturePassed,
    required bool liveCanaryPassed,
    required List<String> errors,
    required DateTime validatedAt,
  }) = _CalibrationValidationImpl;

  factory CalibrationValidation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CalibrationValidation(
      version: jsonSerialization['version'] as String,
      fixturePassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['fixturePassed'],
      ),
      liveCanaryPassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['liveCanaryPassed'],
      ),
      errors: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
      validatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['validatedAt'],
      ),
    );
  }

  String version;

  bool fixturePassed;

  bool liveCanaryPassed;

  List<String> errors;

  DateTime validatedAt;

  /// Returns a shallow copy of this [CalibrationValidation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CalibrationValidation copyWith({
    String? version,
    bool? fixturePassed,
    bool? liveCanaryPassed,
    List<String>? errors,
    DateTime? validatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CalibrationValidation',
      'version': version,
      'fixturePassed': fixturePassed,
      'liveCanaryPassed': liveCanaryPassed,
      'errors': errors.toJson(),
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CalibrationValidation',
      'version': version,
      'fixturePassed': fixturePassed,
      'liveCanaryPassed': liveCanaryPassed,
      'errors': errors.toJson(),
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CalibrationValidationImpl extends CalibrationValidation {
  _CalibrationValidationImpl({
    required String version,
    required bool fixturePassed,
    required bool liveCanaryPassed,
    required List<String> errors,
    required DateTime validatedAt,
  }) : super._(
         version: version,
         fixturePassed: fixturePassed,
         liveCanaryPassed: liveCanaryPassed,
         errors: errors,
         validatedAt: validatedAt,
       );

  /// Returns a shallow copy of this [CalibrationValidation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CalibrationValidation copyWith({
    String? version,
    bool? fixturePassed,
    bool? liveCanaryPassed,
    List<String>? errors,
    DateTime? validatedAt,
  }) {
    return CalibrationValidation(
      version: version ?? this.version,
      fixturePassed: fixturePassed ?? this.fixturePassed,
      liveCanaryPassed: liveCanaryPassed ?? this.liveCanaryPassed,
      errors: errors ?? this.errors.map((e0) => e0).toList(),
      validatedAt: validatedAt ?? this.validatedAt,
    );
  }
}
