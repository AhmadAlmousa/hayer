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
import 'package:hayer_client/src/protocol/protocol.dart' as _iynev3sz;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'discover_place.dart' as _iyut1oys;
import 'discover_query_context.dart' as _ixfyrpmf;
import 'discovery_coverage.dart' as _i8yqti93;
import 'discovery_map_payload.dart' as _ijiia6mk;

abstract class DiscoverBrowsePage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required List<_iyut1oys.DiscoverPlace> items,
    required int total,
    required _ixfyrpmf.DiscoverQueryContext context,
    required DateTime fetchedAt,
    String? nextCursor,
    _ijiia6mk.DiscoveryMapPayload? map,
    required _i8yqti93.DiscoveryCoverage coverage,
  }) = _DiscoverBrowsePageImpl;

  factory DiscoverBrowsePage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoverBrowsePage(
      items: _iynev3sz.Protocol().deserialize<List<_iyut1oys.DiscoverPlace>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      context: _iynev3sz.Protocol().deserialize<_ixfyrpmf.DiscoverQueryContext>(
        jsonSerialization['context'],
      ),
      fetchedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      map: jsonSerialization['map'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_ijiia6mk.DiscoveryMapPayload>(
              jsonSerialization['map'],
            ),
      coverage: _iynev3sz.Protocol().deserialize<_i8yqti93.DiscoveryCoverage>(
        jsonSerialization['coverage'],
      ),
    );
  }

  List<_iyut1oys.DiscoverPlace> items;

  int total;

  _ixfyrpmf.DiscoverQueryContext context;

  DateTime fetchedAt;

  String? nextCursor;

  _ijiia6mk.DiscoveryMapPayload? map;

  _i8yqti93.DiscoveryCoverage coverage;

  /// Returns a shallow copy of this [DiscoverBrowsePage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoverBrowsePage copyWith({
    List<_iyut1oys.DiscoverPlace>? items,
    int? total,
    _ixfyrpmf.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    String? nextCursor,
    _ijiia6mk.DiscoveryMapPayload? map,
    _i8yqti93.DiscoveryCoverage? coverage,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoverBrowsePage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'context': context.toJsonForProtocol(),
      'fetchedAt': fetchedAt.toJson(),
      if (nextCursor != null) 'nextCursor': nextCursor,
      if (map != null) 'map': map?.toJsonForProtocol(),
      'coverage': coverage.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoverBrowsePageImpl extends DiscoverBrowsePage {
  _DiscoverBrowsePageImpl({
    required List<_iyut1oys.DiscoverPlace> items,
    required int total,
    required _ixfyrpmf.DiscoverQueryContext context,
    required DateTime fetchedAt,
    String? nextCursor,
    _ijiia6mk.DiscoveryMapPayload? map,
    required _i8yqti93.DiscoveryCoverage coverage,
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
  @_isc.useResult
  @override
  DiscoverBrowsePage copyWith({
    List<_iyut1oys.DiscoverPlace>? items,
    int? total,
    _ixfyrpmf.DiscoverQueryContext? context,
    DateTime? fetchedAt,
    Object? nextCursor = _Undefined,
    Object? map = _Undefined,
    _i8yqti93.DiscoveryCoverage? coverage,
  }) {
    return DiscoverBrowsePage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      context: context ?? this.context.copyWith(),
      fetchedAt: fetchedAt ?? this.fetchedAt,
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      map: map is _ijiia6mk.DiscoveryMapPayload? ? map : this.map?.copyWith(),
      coverage: coverage ?? this.coverage.copyWith(),
    );
  }
}
