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
import 'taxonomy_canary_sample.dart' as _itt2qz3g;

abstract class TaxonomyValidation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TaxonomyValidation._({
    required this.passed,
    required this.errors,
    required this.samples,
    required this.validatedAt,
  });

  factory TaxonomyValidation({
    required bool passed,
    required List<String> errors,
    required List<_itt2qz3g.TaxonomyCanarySample> samples,
    required DateTime validatedAt,
  }) = _TaxonomyValidationImpl;

  factory TaxonomyValidation.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaxonomyValidation(
      passed: _is.BoolJsonExtension.fromJson(jsonSerialization['passed']),
      errors: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['errors'],
      ),
      samples: _i66y2smk.Protocol()
          .deserialize<List<_itt2qz3g.TaxonomyCanarySample>>(
            jsonSerialization['samples'],
          ),
      validatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['validatedAt'],
      ),
    );
  }

  bool passed;

  List<String> errors;

  List<_itt2qz3g.TaxonomyCanarySample> samples;

  DateTime validatedAt;

  /// Returns a shallow copy of this [TaxonomyValidation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TaxonomyValidation copyWith({
    bool? passed,
    List<String>? errors,
    List<_itt2qz3g.TaxonomyCanarySample>? samples,
    DateTime? validatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomyValidation',
      'passed': passed,
      'errors': errors.toJson(),
      'samples': samples.toJson(valueToJson: (v) => v.toJson()),
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TaxonomyValidation',
      'passed': passed,
      'errors': errors.toJson(),
      'samples': samples.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'validatedAt': validatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TaxonomyValidationImpl extends TaxonomyValidation {
  _TaxonomyValidationImpl({
    required bool passed,
    required List<String> errors,
    required List<_itt2qz3g.TaxonomyCanarySample> samples,
    required DateTime validatedAt,
  }) : super._(
         passed: passed,
         errors: errors,
         samples: samples,
         validatedAt: validatedAt,
       );

  /// Returns a shallow copy of this [TaxonomyValidation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TaxonomyValidation copyWith({
    bool? passed,
    List<String>? errors,
    List<_itt2qz3g.TaxonomyCanarySample>? samples,
    DateTime? validatedAt,
  }) {
    return TaxonomyValidation(
      passed: passed ?? this.passed,
      errors: errors ?? this.errors.map((e0) => e0).toList(),
      samples: samples ?? this.samples.map((e0) => e0.copyWith()).toList(),
      validatedAt: validatedAt ?? this.validatedAt,
    );
  }
}
