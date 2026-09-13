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
import 'discover_place.dart' as _i2;
import 'discover_query_context.dart' as _i3;
import 'discovery_map_payload.dart' as _i4;
import 'discovery_coverage.dart' as _i5;
import 'package:hayer_client/src/protocol/protocol.dart' as _i6;

abstract class DiscoverBrowsePage implements _i1.SerializableModel {
  DiscoverBrowsePage._({
    required this.items,
    required this.total,
    required this.context,
    required this.fetchedAt,
    this.nextCursor,
    this.map,
    required this.coverage,
  });

  factory DiscoverBrowsePage({
    required List<_i2.DiscoverPlace> items,
    required int total,
    required _i3.DiscoverQueryContext context,
    required DateTime fetchedAt,
    String? nextCursor,
    _i4.DiscoveryMapPayload? map,
    required _i5.DiscoveryCoverage coverage,
  }) = _DiscoverBrowsePageImpl;

  factory DiscoverBrowsePage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverBrowsePage(
      items: _i6.Protocol().deserialize<List<_i2.DiscoverPlace>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      context: _i6.Protocol().deserialize<_i3.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      map: jsonSerialization['map'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.DiscoveryMapPayload>(
              jsonSerialization['map'],
            ),
      coverage: _i6.Protocol().deserialize<_i5.DiscoveryCoverage>(
        jsonSerialization['coverage'],
      ),
    );
  }

  List<_i2.DiscoverPlace> items;

  int total;

  _i3.DiscoverQueryContext context;

  DateTime fetchedAt;

  String? nextCursor;

  _i4.DiscoveryMapPayload? map;

  _i5.DiscoveryCoverage coverage;

  /// Returns a shallow copy of this [DiscoverBrowsePage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoverBrowsePage copyWith({
    List<_i2.DiscoverPlace>? items,
    int? total,
    _i3.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    String? nextCursor,
    _i4.DiscoveryMapPayload? map,
    _i5.DiscoveryCoverage? coverage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoverBrowsePage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'context': context.toJson(),
      'fetchedAt': fetchedAt.toJson(),
      if (nextCursor != null) 'nextCursor': nextCursor,
      if (map != null) 'map': map?.toJson(),
      'coverage': coverage.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverBrowsePageImpl extends DiscoverBrowsePage {
  _DiscoverBrowsePageImpl({
    required List<_i2.DiscoverPlace> items,
    required int total,
    required _i3.DiscoverQueryContext context,
    required DateTime fetchedAt,
    String? nextCursor,
    _i4.DiscoveryMapPayload? map,
    required _i5.DiscoveryCoverage coverage,
  }) : super._(
         items: items,
         total: total,
         context: context,
         fetchedAt: fetchedAt,
         nextCursor: nextCursor,
         map: map,
         coverage: coverage,
       );

  /// Returns a shallow copy of this [DiscoverBrowsePage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoverBrowsePage copyWith({
    List<_i2.DiscoverPlace>? items,
    int? total,
    _i3.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    Object? nextCursor = _Undefined,
    Object? map = _Undefined,
    _i5.DiscoveryCoverage? coverage,
  }) {
    return DiscoverBrowsePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      context: context ?? this.context.copyWith(),
      fetchedAt: fetchedAt ?? this.fetchedAt,
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      map: map is _i4.DiscoveryMapPayload? ? map : this.map?.copyWith(),
      coverage: coverage ?? this.coverage.copyWith(),
    );
  }
}
