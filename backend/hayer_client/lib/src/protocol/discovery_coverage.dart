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
import 'discovery_coverage_footprint.dart' as _ito6p50m;
import 'discovery_harvest_status.dart' as _iaeap9p2;

abstract class DiscoveryCoverage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryCoverage._({
    required this.eligibleCatalogCount,
    required this.footprints,
    required this.pendingJobs,
  });

  factory DiscoveryCoverage({
    required int eligibleCatalogCount,
    required List<_ito6p50m.DiscoveryCoverageFootprint> footprints,
    required List<_iaeap9p2.DiscoveryHarvestStatus> pendingJobs,
  }) = _DiscoveryCoverageImpl;

  factory DiscoveryCoverage.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryCoverage(
      eligibleCatalogCount: jsonSerialization['eligibleCatalogCount'] as int,
      footprints: _iynev3sz.Protocol()
          .deserialize<List<_ito6p50m.DiscoveryCoverageFootprint>>(
            jsonSerialization['footprints'],
          ),
      pendingJobs: _iynev3sz.Protocol()
          .deserialize<List<_iaeap9p2.DiscoveryHarvestStatus>>(
            jsonSerialization['pendingJobs'],
          ),
    );
  }

  int eligibleCatalogCount;

  List<_ito6p50m.DiscoveryCoverageFootprint> footprints;

  List<_iaeap9p2.DiscoveryHarvestStatus> pendingJobs;

  /// Returns a shallow copy of this [DiscoveryCoverage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryCoverage copyWith({
    int? eligibleCatalogCount,
    List<_ito6p50m.DiscoveryCoverageFootprint>? footprints,
    List<_iaeap9p2.DiscoveryHarvestStatus>? pendingJobs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryCoverage',
      'eligibleCatalogCount': eligibleCatalogCount,
      'footprints': footprints.toJson(valueToJson: (v) => v.toJson()),
      'pendingJobs': pendingJobs.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryCoverage',
      'eligibleCatalogCount': eligibleCatalogCount,
      'footprints': footprints.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'pendingJobs': pendingJobs.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoveryCoverageImpl extends DiscoveryCoverage {
  _DiscoveryCoverageImpl({
    required int eligibleCatalogCount,
    required List<_ito6p50m.DiscoveryCoverageFootprint> footprints,
    required List<_iaeap9p2.DiscoveryHarvestStatus> pendingJobs,
  }) : super._(
         eligibleCatalogCount: eligibleCatalogCount,
         footprints: footprints,
         pendingJobs: pendingJobs,
       );

  /// Returns a shallow copy of this [DiscoveryCoverage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryCoverage copyWith({
    int? eligibleCatalogCount,
    List<_ito6p50m.DiscoveryCoverageFootprint>? footprints,
    List<_iaeap9p2.DiscoveryHarvestStatus>? pendingJobs,
  }) {
    return DiscoveryCoverage(
      eligibleCatalogCount: eligibleCatalogCount ?? this.eligibleCatalogCount,
      footprints:
          footprints ?? this.footprints.map((e0) => e0.copyWith()).toList(),
      pendingJobs:
          pendingJobs ?? this.pendingJobs.map((e0) => e0.copyWith()).toList(),
    );
  }
}
