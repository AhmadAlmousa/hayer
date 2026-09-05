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
import 'place_insight.dart' as _i2;
import 'analytics_breakdown.dart' as _i3;
import 'package:hayer_server/src/generated/protocol.dart' as _i4;

abstract class AdminPlaceAnalytics
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminPlaceAnalytics._({
    required this.items,
    required this.topCuisines,
    required this.topTypes,
    required this.generatedAt,
  });

  factory AdminPlaceAnalytics({
    required List<_i2.PlaceInsight> items,
    required List<_i3.AnalyticsBreakdown> topCuisines,
    required List<_i3.AnalyticsBreakdown> topTypes,
    required DateTime generatedAt,
  }) = _AdminPlaceAnalyticsImpl;

  factory AdminPlaceAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminPlaceAnalytics(
      items: _i4.Protocol().deserialize<List<_i2.PlaceInsight>>(
        jsonSerialization['items'],
      ),
      topCuisines: _i4.Protocol().deserialize<List<_i3.AnalyticsBreakdown>>(
        jsonSerialization['topCuisines'],
      ),
      topTypes: _i4.Protocol().deserialize<List<_i3.AnalyticsBreakdown>>(
        jsonSerialization['topTypes'],
      ),
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  List<_i2.PlaceInsight> items;

  List<_i3.AnalyticsBreakdown> topCuisines;

  List<_i3.AnalyticsBreakdown> topTypes;

  DateTime generatedAt;

  /// Returns a shallow copy of this [AdminPlaceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminPlaceAnalytics copyWith({
    List<_i2.PlaceInsight>? items,
    List<_i3.AnalyticsBreakdown>? topCuisines,
    List<_i3.AnalyticsBreakdown>? topTypes,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminPlaceAnalytics',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'topCuisines': topCuisines.toJson(valueToJson: (v) => v.toJson()),
      'topTypes': topTypes.toJson(valueToJson: (v) => v.toJson()),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminPlaceAnalytics',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'topCuisines': topCuisines.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'topTypes': topTypes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminPlaceAnalyticsImpl extends AdminPlaceAnalytics {
  _AdminPlaceAnalyticsImpl({
    required List<_i2.PlaceInsight> items,
    required List<_i3.AnalyticsBreakdown> topCuisines,
    required List<_i3.AnalyticsBreakdown> topTypes,
    required DateTime generatedAt,
  }) : super._(
         items: items,
         topCuisines: topCuisines,
         topTypes: topTypes,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [AdminPlaceAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminPlaceAnalytics copyWith({
    List<_i2.PlaceInsight>? items,
    List<_i3.AnalyticsBreakdown>? topCuisines,
    List<_i3.AnalyticsBreakdown>? topTypes,
    DateTime? generatedAt,
  }) {
    return AdminPlaceAnalytics(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      topCuisines:
          topCuisines ?? this.topCuisines.map((e0) => e0.copyWith()).toList(),
      topTypes: topTypes ?? this.topTypes.map((e0) => e0.copyWith()).toList(),
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
