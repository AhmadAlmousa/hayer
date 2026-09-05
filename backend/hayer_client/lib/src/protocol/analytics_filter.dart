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
import 'analytics_granularity.dart' as _i2;
import 'session_mode.dart' as _i3;

abstract class AnalyticsFilter implements _i1.SerializableModel {
  AnalyticsFilter._({
    required this.from,
    required this.to,
    required this.granularity,
    this.mode,
    this.cityKey,
    this.categoryId,
  });

  factory AnalyticsFilter({
    required DateTime from,
    required DateTime to,
    required _i2.AnalyticsGranularity granularity,
    _i3.SessionMode? mode,
    String? cityKey,
    String? categoryId,
  }) = _AnalyticsFilterImpl;

  factory AnalyticsFilter.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsFilter(
      from: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      granularity: _i2.AnalyticsGranularity.fromJson(
        (jsonSerialization['granularity'] as String),
      ),
      mode: jsonSerialization['mode'] == null
          ? null
          : _i3.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      cityKey: jsonSerialization['cityKey'] as String?,
      categoryId: jsonSerialization['categoryId'] as String?,
    );
  }

  DateTime from;

  DateTime to;

  _i2.AnalyticsGranularity granularity;

  _i3.SessionMode? mode;

  String? cityKey;

  String? categoryId;

  /// Returns a shallow copy of this [AnalyticsFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AnalyticsFilter copyWith({
    DateTime? from,
    DateTime? to,
    _i2.AnalyticsGranularity? granularity,
    _i3.SessionMode? mode,
    String? cityKey,
    String? categoryId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsFilter',
      'from': from.toJson(),
      'to': to.toJson(),
      'granularity': granularity.toJson(),
      if (mode != null) 'mode': mode?.toJson(),
      if (cityKey != null) 'cityKey': cityKey,
      if (categoryId != null) 'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnalyticsFilterImpl extends AnalyticsFilter {
  _AnalyticsFilterImpl({
    required DateTime from,
    required DateTime to,
    required _i2.AnalyticsGranularity granularity,
    _i3.SessionMode? mode,
    String? cityKey,
    String? categoryId,
  }) : super._(
         from: from,
         to: to,
         granularity: granularity,
         mode: mode,
         cityKey: cityKey,
         categoryId: categoryId,
       );

  /// Returns a shallow copy of this [AnalyticsFilter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AnalyticsFilter copyWith({
    DateTime? from,
    DateTime? to,
    _i2.AnalyticsGranularity? granularity,
    Object? mode = _Undefined,
    Object? cityKey = _Undefined,
    Object? categoryId = _Undefined,
  }) {
    return AnalyticsFilter(
      from: from ?? this.from,
      to: to ?? this.to,
      granularity: granularity ?? this.granularity,
      mode: mode is _i3.SessionMode? ? mode : this.mode,
      cityKey: cityKey is String? ? cityKey : this.cityKey,
      categoryId: categoryId is String? ? categoryId : this.categoryId,
    );
  }
}
