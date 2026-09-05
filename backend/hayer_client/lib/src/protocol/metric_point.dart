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

abstract class MetricPoint implements _i1.SerializableModel {
  MetricPoint._({
    required this.bucketStartedAt,
    required this.metricName,
    required this.metricValue,
    required this.sampleCount,
  });

  factory MetricPoint({
    required DateTime bucketStartedAt,
    required String metricName,
    required double metricValue,
    required int sampleCount,
  }) = _MetricPointImpl;

  factory MetricPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return MetricPoint(
      bucketStartedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['bucketStartedAt'],
      ),
      metricName: jsonSerialization['metricName'] as String,
      metricValue: (jsonSerialization['metricValue'] as num).toDouble(),
      sampleCount: jsonSerialization['sampleCount'] as int,
    );
  }

  DateTime bucketStartedAt;

  String metricName;

  double metricValue;

  int sampleCount;

  /// Returns a shallow copy of this [MetricPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MetricPoint copyWith({
    DateTime? bucketStartedAt,
    String? metricName,
    double? metricValue,
    int? sampleCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MetricPoint',
      'bucketStartedAt': bucketStartedAt.toJson(),
      'metricName': metricName,
      'metricValue': metricValue,
      'sampleCount': sampleCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MetricPointImpl extends MetricPoint {
  _MetricPointImpl({
    required DateTime bucketStartedAt,
    required String metricName,
    required double metricValue,
    required int sampleCount,
  }) : super._(
         bucketStartedAt: bucketStartedAt,
         metricName: metricName,
         metricValue: metricValue,
         sampleCount: sampleCount,
       );

  /// Returns a shallow copy of this [MetricPoint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MetricPoint copyWith({
    DateTime? bucketStartedAt,
    String? metricName,
    double? metricValue,
    int? sampleCount,
  }) {
    return MetricPoint(
      bucketStartedAt: bucketStartedAt ?? this.bucketStartedAt,
      metricName: metricName ?? this.metricName,
      metricValue: metricValue ?? this.metricValue,
      sampleCount: sampleCount ?? this.sampleCount,
    );
  }
}
