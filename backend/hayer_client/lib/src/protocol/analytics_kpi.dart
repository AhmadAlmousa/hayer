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

abstract class AnalyticsKpi implements _i1.SerializableModel {
  AnalyticsKpi._({
    required this.key,
    required this.label,
    required this.value,
    required this.previousValue,
    required this.unit,
  });

  factory AnalyticsKpi({
    required String key,
    required String label,
    required double value,
    required double previousValue,
    required String unit,
  }) = _AnalyticsKpiImpl;

  factory AnalyticsKpi.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsKpi(
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      previousValue: (jsonSerialization['previousValue'] as num).toDouble(),
      unit: jsonSerialization['unit'] as String,
    );
  }

  String key;

  String label;

  double value;

  double previousValue;

  String unit;

  /// Returns a shallow copy of this [AnalyticsKpi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalyticsKpi copyWith({
    String? key,
    String? label,
    double? value,
    double? previousValue,
    String? unit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsKpi',
      'key': key,
      'label': label,
      'value': value,
      'previousValue': previousValue,
      'unit': unit,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AnalyticsKpiImpl extends AnalyticsKpi {
  _AnalyticsKpiImpl({
    required String key,
    required String label,
    required double value,
    required double previousValue,
    required String unit,
  }) : super._(
         key: key,
         label: label,
         value: value,
         previousValue: previousValue,
         unit: unit,
       );

  /// Returns a shallow copy of this [AnalyticsKpi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalyticsKpi copyWith({
    String? key,
    String? label,
    double? value,
    double? previousValue,
    String? unit,
  }) {
    return AnalyticsKpi(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      previousValue: previousValue ?? this.previousValue,
      unit: unit ?? this.unit,
    );
  }
}
