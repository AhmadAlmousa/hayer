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
import 'package:serverpod/serverpod.dart' as _is;

abstract class CoverageRecord
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CoverageRecord._({
    required this.coverageKey,
    required this.queryKey,
    required this.language,
    required this.countryCode,
    required this.anchorLatitude,
    required this.anchorLongitude,
    required this.radiusMeters,
    required this.calibrationVersion,
    required this.resultCount,
    required this.refreshedAt,
    required this.expiresAt,
    this.lastFailureCode,
    this.invalidatedAt,
  });

  factory CoverageRecord({
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required int radiusMeters,
    required String calibrationVersion,
    required int resultCount,
    required DateTime refreshedAt,
    required DateTime expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  }) = _CoverageRecordImpl;

  factory CoverageRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return CoverageRecord(
      coverageKey: jsonSerialization['coverageKey'] as String,
      queryKey: jsonSerialization['queryKey'] as String,
      language: jsonSerialization['language'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      resultCount: jsonSerialization['resultCount'] as int,
      refreshedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['refreshedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      invalidatedAt: jsonSerialization['invalidatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['invalidatedAt'],
            ),
    );
  }

  String coverageKey;

  String queryKey;

  String language;

  String countryCode;

  double anchorLatitude;

  double anchorLongitude;

  int radiusMeters;

  String calibrationVersion;

  int resultCount;

  DateTime refreshedAt;

  DateTime expiresAt;

  String? lastFailureCode;

  DateTime? invalidatedAt;

  /// Returns a shallow copy of this [CoverageRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CoverageRecord copyWith({
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    int? radiusMeters,
    String? calibrationVersion,
    int? resultCount,
    DateTime? refreshedAt,
    DateTime? expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CoverageRecord',
      'coverageKey': coverageKey,
      'queryKey': queryKey,
      'language': language,
      'countryCode': countryCode,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      'radiusMeters': radiusMeters,
      'calibrationVersion': calibrationVersion,
      'resultCount': resultCount,
      'refreshedAt': refreshedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      if (invalidatedAt != null) 'invalidatedAt': invalidatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CoverageRecord',
      'coverageKey': coverageKey,
      'queryKey': queryKey,
      'language': language,
      'countryCode': countryCode,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      'radiusMeters': radiusMeters,
      'calibrationVersion': calibrationVersion,
      'resultCount': resultCount,
      'refreshedAt': refreshedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      if (invalidatedAt != null) 'invalidatedAt': invalidatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CoverageRecordImpl extends CoverageRecord {
  _CoverageRecordImpl({
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required int radiusMeters,
    required String calibrationVersion,
    required int resultCount,
    required DateTime refreshedAt,
    required DateTime expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  }) : super._(
         coverageKey: coverageKey,
         queryKey: queryKey,
         language: language,
         countryCode: countryCode,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         radiusMeters: radiusMeters,
         calibrationVersion: calibrationVersion,
         resultCount: resultCount,
         refreshedAt: refreshedAt,
         expiresAt: expiresAt,
         lastFailureCode: lastFailureCode,
         invalidatedAt: invalidatedAt,
       );

  /// Returns a shallow copy of this [CoverageRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CoverageRecord copyWith({
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    int? radiusMeters,
    String? calibrationVersion,
    int? resultCount,
    DateTime? refreshedAt,
    DateTime? expiresAt,
    Object? lastFailureCode = _Undefined,
    Object? invalidatedAt = _Undefined,
  }) {
    return CoverageRecord(
      coverageKey: coverageKey ?? this.coverageKey,
      queryKey: queryKey ?? this.queryKey,
      language: language ?? this.language,
      countryCode: countryCode ?? this.countryCode,
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      resultCount: resultCount ?? this.resultCount,
      refreshedAt: refreshedAt ?? this.refreshedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      lastFailureCode: lastFailureCode is String?
          ? lastFailureCode
          : this.lastFailureCode,
      invalidatedAt: invalidatedAt is DateTime?
          ? invalidatedAt
          : this.invalidatedAt,
    );
  }
}
