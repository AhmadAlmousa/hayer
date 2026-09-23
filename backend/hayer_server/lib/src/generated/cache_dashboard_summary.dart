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

abstract class CacheDashboardSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CacheDashboardSummary._({
    required this.catalogCount,
    required this.freshCount,
    required this.staleCount,
    required this.quarantinedCount,
    required this.coverageCount,
    required this.pendingJobs,
    required this.cacheHitRate,
    required this.sourceSuccessRate,
    required this.calibrationVersion,
    required this.generatedAt,
  });

  factory CacheDashboardSummary({
    required int catalogCount,
    required int freshCount,
    required int staleCount,
    required int quarantinedCount,
    required int coverageCount,
    required int pendingJobs,
    required double cacheHitRate,
    required double sourceSuccessRate,
    required String calibrationVersion,
    required DateTime generatedAt,
  }) = _CacheDashboardSummaryImpl;

  factory CacheDashboardSummary.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CacheDashboardSummary(
      catalogCount: jsonSerialization['catalogCount'] as int,
      freshCount: jsonSerialization['freshCount'] as int,
      staleCount: jsonSerialization['staleCount'] as int,
      quarantinedCount: jsonSerialization['quarantinedCount'] as int,
      coverageCount: jsonSerialization['coverageCount'] as int,
      pendingJobs: jsonSerialization['pendingJobs'] as int,
      cacheHitRate: (jsonSerialization['cacheHitRate'] as num).toDouble(),
      sourceSuccessRate: (jsonSerialization['sourceSuccessRate'] as num)
          .toDouble(),
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      generatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
    );
  }

  int catalogCount;

  int freshCount;

  int staleCount;

  int quarantinedCount;

  int coverageCount;

  int pendingJobs;

  double cacheHitRate;

  double sourceSuccessRate;

  String calibrationVersion;

  DateTime generatedAt;

  /// Returns a shallow copy of this [CacheDashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CacheDashboardSummary copyWith({
    int? catalogCount,
    int? freshCount,
    int? staleCount,
    int? quarantinedCount,
    int? coverageCount,
    int? pendingJobs,
    double? cacheHitRate,
    double? sourceSuccessRate,
    String? calibrationVersion,
    DateTime? generatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CacheDashboardSummary',
      'catalogCount': catalogCount,
      'freshCount': freshCount,
      'staleCount': staleCount,
      'quarantinedCount': quarantinedCount,
      'coverageCount': coverageCount,
      'pendingJobs': pendingJobs,
      'cacheHitRate': cacheHitRate,
      'sourceSuccessRate': sourceSuccessRate,
      'calibrationVersion': calibrationVersion,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CacheDashboardSummary',
      'catalogCount': catalogCount,
      'freshCount': freshCount,
      'staleCount': staleCount,
      'quarantinedCount': quarantinedCount,
      'coverageCount': coverageCount,
      'pendingJobs': pendingJobs,
      'cacheHitRate': cacheHitRate,
      'sourceSuccessRate': sourceSuccessRate,
      'calibrationVersion': calibrationVersion,
      'generatedAt': generatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CacheDashboardSummaryImpl extends CacheDashboardSummary {
  _CacheDashboardSummaryImpl({
    required int catalogCount,
    required int freshCount,
    required int staleCount,
    required int quarantinedCount,
    required int coverageCount,
    required int pendingJobs,
    required double cacheHitRate,
    required double sourceSuccessRate,
    required String calibrationVersion,
    required DateTime generatedAt,
  }) : super._(
         catalogCount: catalogCount,
         freshCount: freshCount,
         staleCount: staleCount,
         quarantinedCount: quarantinedCount,
         coverageCount: coverageCount,
         pendingJobs: pendingJobs,
         cacheHitRate: cacheHitRate,
         sourceSuccessRate: sourceSuccessRate,
         calibrationVersion: calibrationVersion,
         generatedAt: generatedAt,
       );

  /// Returns a shallow copy of this [CacheDashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CacheDashboardSummary copyWith({
    int? catalogCount,
    int? freshCount,
    int? staleCount,
    int? quarantinedCount,
    int? coverageCount,
    int? pendingJobs,
    double? cacheHitRate,
    double? sourceSuccessRate,
    String? calibrationVersion,
    DateTime? generatedAt,
  }) {
    return CacheDashboardSummary(
      catalogCount: catalogCount ?? this.catalogCount,
      freshCount: freshCount ?? this.freshCount,
      staleCount: staleCount ?? this.staleCount,
      quarantinedCount: quarantinedCount ?? this.quarantinedCount,
      coverageCount: coverageCount ?? this.coverageCount,
      pendingJobs: pendingJobs ?? this.pendingJobs,
      cacheHitRate: cacheHitRate ?? this.cacheHitRate,
      sourceSuccessRate: sourceSuccessRate ?? this.sourceSuccessRate,
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }
}
