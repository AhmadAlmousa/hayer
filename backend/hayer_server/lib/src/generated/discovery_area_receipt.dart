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
import 'discovery_coverage.dart' as _i2;
import 'discovery_harvest_status.dart' as _i3;
import 'package:hayer_server/src/generated/protocol.dart' as _i4;

abstract class DiscoveryAreaReceipt
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DiscoveryAreaReceipt._({
    required this.coverage,
    this.job,
    this.retryAfter,
    required this.fetchedAt,
  });

  factory DiscoveryAreaReceipt({
    required _i2.DiscoveryCoverage coverage,
    _i3.DiscoveryHarvestStatus? job,
    DateTime? retryAfter,
    required DateTime fetchedAt,
  }) = _DiscoveryAreaReceiptImpl;

  factory DiscoveryAreaReceipt.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryAreaReceipt(
      coverage: _i4.Protocol().deserialize<_i2.DiscoveryCoverage>(
        jsonSerialization['coverage'],
      ),
      job: jsonSerialization['job'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.DiscoveryHarvestStatus>(
              jsonSerialization['job'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      fetchedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  _i2.DiscoveryCoverage coverage;

  _i3.DiscoveryHarvestStatus? job;

  DateTime? retryAfter;

  DateTime fetchedAt;

  /// Returns a shallow copy of this [DiscoveryAreaReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryAreaReceipt copyWith({
    _i2.DiscoveryCoverage? coverage,
    _i3.DiscoveryHarvestStatus? job,
    DateTime? retryAfter,
    DateTime? fetchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryAreaReceipt',
      'coverage': coverage.toJson(),
      if (job != null) 'job': job?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryAreaReceipt',
      'coverage': coverage.toJsonForProtocol(),
      if (job != null) 'job': job?.toJsonForProtocol(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryAreaReceiptImpl extends DiscoveryAreaReceipt {
  _DiscoveryAreaReceiptImpl({
    required _i2.DiscoveryCoverage coverage,
    _i3.DiscoveryHarvestStatus? job,
    DateTime? retryAfter,
    required DateTime fetchedAt,
  }) : super._(
         coverage: coverage,
         job: job,
         retryAfter: retryAfter,
         fetchedAt: fetchedAt,
       );

  /// Returns a shallow copy of this [DiscoveryAreaReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryAreaReceipt copyWith({
    _i2.DiscoveryCoverage? coverage,
    Object? job = _Undefined,
    Object? retryAfter = _Undefined,
    DateTime? fetchedAt,
  }) {
    return DiscoveryAreaReceipt(
      coverage: coverage ?? this.coverage.copyWith(),
      job: job is _i3.DiscoveryHarvestStatus? ? job : this.job?.copyWith(),
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}
