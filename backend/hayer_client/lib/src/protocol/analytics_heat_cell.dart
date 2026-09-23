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

abstract class AnalyticsHeatCell
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AnalyticsHeatCell._({
    required this.weekday,
    required this.hour,
    required this.value,
  });

  factory AnalyticsHeatCell({
    required int weekday,
    required int hour,
    required double value,
  }) = _AnalyticsHeatCellImpl;

  factory AnalyticsHeatCell.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsHeatCell(
      weekday: jsonSerialization['weekday'] as int,
      hour: jsonSerialization['hour'] as int,
      value: (jsonSerialization['value'] as num).toDouble(),
    );
  }

  int weekday;

  int hour;

  double value;

  /// Returns a shallow copy of this [AnalyticsHeatCell]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AnalyticsHeatCell copyWith({
    int? weekday,
    int? hour,
    double? value,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsHeatCell',
      'weekday': weekday,
      'hour': hour,
      'value': value,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsHeatCell',
      'weekday': weekday,
      'hour': hour,
      'value': value,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AnalyticsHeatCellImpl extends AnalyticsHeatCell {
  _AnalyticsHeatCellImpl({
    required int weekday,
    required int hour,
    required double value,
  }) : super._(
         weekday: weekday,
         hour: hour,
         value: value,
       );

  /// Returns a shallow copy of this [AnalyticsHeatCell]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AnalyticsHeatCell copyWith({
    int? weekday,
    int? hour,
    double? value,
  }) {
    return AnalyticsHeatCell(
      weekday: weekday ?? this.weekday,
      hour: hour ?? this.hour,
      value: value ?? this.value,
    );
  }
}
