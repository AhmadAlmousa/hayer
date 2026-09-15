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
import 'place_detail_refresh_state.dart' as _i2;

abstract class AdminCatalogDetailRefresh
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminCatalogDetailRefresh._({
    required this.state,
    this.lastAttemptAt,
    this.lastCheckedAt,
    this.lastSuccessAt,
    this.retryAfter,
    this.lastFailureCode,
    required this.attemptCount,
  });

  factory AdminCatalogDetailRefresh({
    required _i2.PlaceDetailRefreshState state,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    required int attemptCount,
  }) = _AdminCatalogDetailRefreshImpl;

  factory AdminCatalogDetailRefresh.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminCatalogDetailRefresh(
      state: _i2.PlaceDetailRefreshState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastCheckedAt: jsonSerialization['lastCheckedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCheckedAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      attemptCount: jsonSerialization['attemptCount'] as int,
    );
  }

  _i2.PlaceDetailRefreshState state;

  DateTime? lastAttemptAt;

  DateTime? lastCheckedAt;

  DateTime? lastSuccessAt;

  DateTime? retryAfter;

  String? lastFailureCode;

  int attemptCount;

  /// Returns a shallow copy of this [AdminCatalogDetailRefresh]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminCatalogDetailRefresh copyWith({
    _i2.PlaceDetailRefreshState? state,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    int? attemptCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogDetailRefresh',
      'state': state.toJson(),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastCheckedAt != null) 'lastCheckedAt': lastCheckedAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      'attemptCount': attemptCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogDetailRefresh',
      'state': state.toJson(),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastCheckedAt != null) 'lastCheckedAt': lastCheckedAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      'attemptCount': attemptCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminCatalogDetailRefreshImpl extends AdminCatalogDetailRefresh {
  _AdminCatalogDetailRefreshImpl({
    required _i2.PlaceDetailRefreshState state,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    required int attemptCount,
  }) : super._(
         state: state,
         lastAttemptAt: lastAttemptAt,
         lastCheckedAt: lastCheckedAt,
         lastSuccessAt: lastSuccessAt,
         retryAfter: retryAfter,
         lastFailureCode: lastFailureCode,
         attemptCount: attemptCount,
       );

  /// Returns a shallow copy of this [AdminCatalogDetailRefresh]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminCatalogDetailRefresh copyWith({
    _i2.PlaceDetailRefreshState? state,
    Object? lastAttemptAt = _Undefined,
    Object? lastCheckedAt = _Undefined,
    Object? lastSuccessAt = _Undefined,
    Object? retryAfter = _Undefined,
    Object? lastFailureCode = _Undefined,
    int? attemptCount,
  }) {
    return AdminCatalogDetailRefresh(
      state: state ?? this.state,
      lastAttemptAt: lastAttemptAt is DateTime?
          ? lastAttemptAt
          : this.lastAttemptAt,
      lastCheckedAt: lastCheckedAt is DateTime?
          ? lastCheckedAt
          : this.lastCheckedAt,
      lastSuccessAt: lastSuccessAt is DateTime?
          ? lastSuccessAt
          : this.lastSuccessAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      lastFailureCode: lastFailureCode is String?
          ? lastFailureCode
          : this.lastFailureCode,
      attemptCount: attemptCount ?? this.attemptCount,
    );
  }
}
