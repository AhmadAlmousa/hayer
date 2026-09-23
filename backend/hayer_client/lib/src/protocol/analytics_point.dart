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

abstract class AnalyticsPoint
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnalyticsPoint._({
    required this.bucketStartedAt,
    required this.seriesKey,
    required this.seriesLabel,
    required this.value,
  });

  factory AnalyticsPoint({
    required DateTime bucketStartedAt,
    required String seriesKey,
    required String seriesLabel,
    required double value,
  }) = _AnalyticsPointImpl;

  factory AnalyticsPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsPoint(
      bucketStartedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['bucketStartedAt'],
      ),
      seriesKey: jsonSerialization['seriesKey'] as String,
      seriesLabel: jsonSerialization['seriesLabel'] as String,
      value: (jsonSerialization['value'] as num).toDouble(),
    );
  }

  DateTime bucketStartedAt;

  String seriesKey;

  String seriesLabel;

  double value;

  /// Returns a shallow copy of this [AnalyticsPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnalyticsPoint copyWith({
    DateTime? bucketStartedAt,
    String? seriesKey,
    String? seriesLabel,
    double? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsPoint',
      'bucketStartedAt': bucketStartedAt.toJson(),
      'seriesKey': seriesKey,
      'seriesLabel': seriesLabel,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsPoint',
      'bucketStartedAt': bucketStartedAt.toJson(),
      'seriesKey': seriesKey,
      'seriesLabel': seriesLabel,
      'value': value,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnalyticsPointImpl extends AnalyticsPoint {
  _AnalyticsPointImpl({
    required DateTime bucketStartedAt,
    required String seriesKey,
    required String seriesLabel,
    required double value,
  }) : super._(
         bucketStartedAt: bucketStartedAt,
         seriesKey: seriesKey,
         seriesLabel: seriesLabel,
         value: value,
       );

  /// Returns a shallow copy of this [AnalyticsPoint]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnalyticsPoint copyWith({
    DateTime? bucketStartedAt,
    String? seriesKey,
    String? seriesLabel,
    double? value,
  }) {
    return AnalyticsPoint(
      bucketStartedAt: bucketStartedAt ?? this.bucketStartedAt,
      seriesKey: seriesKey ?? this.seriesKey,
      seriesLabel: seriesLabel ?? this.seriesLabel,
      value: value ?? this.value,
    );
  }
}
