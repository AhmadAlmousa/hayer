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

abstract class AnalyticsBreakdown
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnalyticsBreakdown._({
    required this.key,
    required this.label,
    required this.value,
    required this.percentage,
    required this.sampleCount,
  });

  factory AnalyticsBreakdown({
    required String key,
    required String label,
    required double value,
    required double percentage,
    required int sampleCount,
  }) = _AnalyticsBreakdownImpl;

  factory AnalyticsBreakdown.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsBreakdown(
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
      percentage: (jsonSerialization['percentage'] as num).toDouble(),
      sampleCount: jsonSerialization['sampleCount'] as int,
    );
  }

  String key;

  String label;

  double value;

  double percentage;

  int sampleCount;

  /// Returns a shallow copy of this [AnalyticsBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnalyticsBreakdown copyWith({
    String? key,
    String? label,
    double? value,
    double? percentage,
    int? sampleCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsBreakdown',
      'key': key,
      'label': label,
      'value': value,
      'percentage': percentage,
      'sampleCount': sampleCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsBreakdown',
      'key': key,
      'label': label,
      'value': value,
      'percentage': percentage,
      'sampleCount': sampleCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnalyticsBreakdownImpl extends AnalyticsBreakdown {
  _AnalyticsBreakdownImpl({
    required String key,
    required String label,
    required double value,
    required double percentage,
    required int sampleCount,
  }) : super._(
         key: key,
         label: label,
         value: value,
         percentage: percentage,
         sampleCount: sampleCount,
       );

  /// Returns a shallow copy of this [AnalyticsBreakdown]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnalyticsBreakdown copyWith({
    String? key,
    String? label,
    double? value,
    double? percentage,
    int? sampleCount,
  }) {
    return AnalyticsBreakdown(
      key: key ?? this.key,
      label: label ?? this.label,
      value: value ?? this.value,
      percentage: percentage ?? this.percentage,
      sampleCount: sampleCount ?? this.sampleCount,
    );
  }
}
