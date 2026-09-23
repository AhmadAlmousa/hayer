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
import 'discovery_client_limits.dart' as _ii690dam;
import 'discovery_scoring.dart' as _iphkx6cy;

abstract class DiscoveryConfig
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryConfig._({
    required this.contractVersion,
    required this.enabled,
    required this.detailsAvailable,
    required this.policyRevision,
    required this.taxonomyRevision,
    required this.serverTime,
    required this.expiresAt,
    required this.supportedCountries,
    required this.scoring,
    required this.limits,
    required this.amenitiesAvailable,
    required this.reviewTextSearchAvailable,
  });

  factory DiscoveryConfig({
    required int contractVersion,
    required bool enabled,
    required bool detailsAvailable,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime serverTime,
    required DateTime expiresAt,
    required List<String> supportedCountries,
    required _iphkx6cy.DiscoveryScoring scoring,
    required _ii690dam.DiscoveryClientLimits limits,
    required bool amenitiesAvailable,
    required bool reviewTextSearchAvailable,
  }) = _DiscoveryConfigImpl;

  factory DiscoveryConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryConfig(
      contractVersion: jsonSerialization['contractVersion'] as int,
      enabled: _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      detailsAvailable: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['detailsAvailable'],
      ),
      policyRevision: jsonSerialization['policyRevision'] as int,
      taxonomyRevision: jsonSerialization['taxonomyRevision'] as int,
      serverTime: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverTime'],
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      supportedCountries: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['supportedCountries'],
      ),
      scoring: _iynev3sz.Protocol().deserialize<_iphkx6cy.DiscoveryScoring>(
        jsonSerialization['scoring'],
      ),
      limits: _iynev3sz.Protocol().deserialize<_ii690dam.DiscoveryClientLimits>(
        jsonSerialization['limits'],
      ),
      amenitiesAvailable: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['amenitiesAvailable'],
      ),
      reviewTextSearchAvailable: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['reviewTextSearchAvailable'],
      ),
    );
  }

  int contractVersion;

  bool enabled;

  bool detailsAvailable;

  int policyRevision;

  int taxonomyRevision;

  DateTime serverTime;

  DateTime expiresAt;

  List<String> supportedCountries;

  _iphkx6cy.DiscoveryScoring scoring;

  _ii690dam.DiscoveryClientLimits limits;

  bool amenitiesAvailable;

  bool reviewTextSearchAvailable;

  /// Returns a shallow copy of this [DiscoveryConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryConfig copyWith({
    int? contractVersion,
    bool? enabled,
    bool? detailsAvailable,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? serverTime,
    DateTime? expiresAt,
    List<String>? supportedCountries,
    _iphkx6cy.DiscoveryScoring? scoring,
    _ii690dam.DiscoveryClientLimits? limits,
    bool? amenitiesAvailable,
    bool? reviewTextSearchAvailable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryConfig',
      'contractVersion': contractVersion,
      'enabled': enabled,
      'detailsAvailable': detailsAvailable,
      'policyRevision': policyRevision,
      'taxonomyRevision': taxonomyRevision,
      'serverTime': serverTime.toJson(),
      'expiresAt': expiresAt.toJson(),
      'supportedCountries': supportedCountries.toJson(),
      'scoring': scoring.toJson(),
      'limits': limits.toJson(),
      'amenitiesAvailable': amenitiesAvailable,
      'reviewTextSearchAvailable': reviewTextSearchAvailable,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryConfig',
      'contractVersion': contractVersion,
      'enabled': enabled,
      'detailsAvailable': detailsAvailable,
      'policyRevision': policyRevision,
      'taxonomyRevision': taxonomyRevision,
      'serverTime': serverTime.toJson(),
      'expiresAt': expiresAt.toJson(),
      'supportedCountries': supportedCountries.toJson(),
      'scoring': scoring.toJsonForProtocol(),
      'limits': limits.toJsonForProtocol(),
      'amenitiesAvailable': amenitiesAvailable,
      'reviewTextSearchAvailable': reviewTextSearchAvailable,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoveryConfigImpl extends DiscoveryConfig {
  _DiscoveryConfigImpl({
    required int contractVersion,
    required bool enabled,
    required bool detailsAvailable,
    required int policyRevision,
    required int taxonomyRevision,
    required DateTime serverTime,
    required DateTime expiresAt,
    required List<String> supportedCountries,
    required _iphkx6cy.DiscoveryScoring scoring,
    required _ii690dam.DiscoveryClientLimits limits,
    required bool amenitiesAvailable,
    required bool reviewTextSearchAvailable,
  }) : super._(
         contractVersion: contractVersion,
         enabled: enabled,
         detailsAvailable: detailsAvailable,
         policyRevision: policyRevision,
         taxonomyRevision: taxonomyRevision,
         serverTime: serverTime,
         expiresAt: expiresAt,
         supportedCountries: supportedCountries,
         scoring: scoring,
         limits: limits,
         amenitiesAvailable: amenitiesAvailable,
         reviewTextSearchAvailable: reviewTextSearchAvailable,
       );

  /// Returns a shallow copy of this [DiscoveryConfig]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryConfig copyWith({
    int? contractVersion,
    bool? enabled,
    bool? detailsAvailable,
    int? policyRevision,
    int? taxonomyRevision,
    DateTime? serverTime,
    DateTime? expiresAt,
    List<String>? supportedCountries,
    _iphkx6cy.DiscoveryScoring? scoring,
    _ii690dam.DiscoveryClientLimits? limits,
    bool? amenitiesAvailable,
    bool? reviewTextSearchAvailable,
  }) {
    return DiscoveryConfig(
      contractVersion: contractVersion ?? this.contractVersion,
      enabled: enabled ?? this.enabled,
      detailsAvailable: detailsAvailable ?? this.detailsAvailable,
      policyRevision: policyRevision ?? this.policyRevision,
      taxonomyRevision: taxonomyRevision ?? this.taxonomyRevision,
      serverTime: serverTime ?? this.serverTime,
      expiresAt: expiresAt ?? this.expiresAt,
      supportedCountries:
          supportedCountries ??
          this.supportedCountries.map((e0) => e0).toList(),
      scoring: scoring ?? this.scoring.copyWith(),
      limits: limits ?? this.limits.copyWith(),
      amenitiesAvailable: amenitiesAvailable ?? this.amenitiesAvailable,
      reviewTextSearchAvailable:
          reviewTextSearchAvailable ?? this.reviewTextSearchAvailable,
    );
  }
}
