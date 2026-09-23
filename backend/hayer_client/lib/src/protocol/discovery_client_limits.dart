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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class DiscoveryClientLimits
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DiscoveryClientLimits._({
    required this.defaultPageSize,
    required this.maximumPageSize,
    required this.maximumCategoryIds,
    required this.maximumTextCodePoints,
    required this.maximumMapPoints,
    required this.otherCategoryId,
  });

  factory DiscoveryClientLimits({
    required int defaultPageSize,
    required int maximumPageSize,
    required int maximumCategoryIds,
    required int maximumTextCodePoints,
    required int maximumMapPoints,
    required String otherCategoryId,
  }) = _DiscoveryClientLimitsImpl;

  factory DiscoveryClientLimits.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryClientLimits(
      defaultPageSize: jsonSerialization['defaultPageSize'] as int,
      maximumPageSize: jsonSerialization['maximumPageSize'] as int,
      maximumCategoryIds: jsonSerialization['maximumCategoryIds'] as int,
      maximumTextCodePoints: jsonSerialization['maximumTextCodePoints'] as int,
      maximumMapPoints: jsonSerialization['maximumMapPoints'] as int,
      otherCategoryId: jsonSerialization['otherCategoryId'] as String,
    );
  }

  int defaultPageSize;

  int maximumPageSize;

  int maximumCategoryIds;

  int maximumTextCodePoints;

  int maximumMapPoints;

  String otherCategoryId;

  /// Returns a shallow copy of this [DiscoveryClientLimits]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DiscoveryClientLimits copyWith({
    int? defaultPageSize,
    int? maximumPageSize,
    int? maximumCategoryIds,
    int? maximumTextCodePoints,
    int? maximumMapPoints,
    String? otherCategoryId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryClientLimits',
      'defaultPageSize': defaultPageSize,
      'maximumPageSize': maximumPageSize,
      'maximumCategoryIds': maximumCategoryIds,
      'maximumTextCodePoints': maximumTextCodePoints,
      'maximumMapPoints': maximumMapPoints,
      'otherCategoryId': otherCategoryId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryClientLimits',
      'defaultPageSize': defaultPageSize,
      'maximumPageSize': maximumPageSize,
      'maximumCategoryIds': maximumCategoryIds,
      'maximumTextCodePoints': maximumTextCodePoints,
      'maximumMapPoints': maximumMapPoints,
      'otherCategoryId': otherCategoryId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DiscoveryClientLimitsImpl extends DiscoveryClientLimits {
  _DiscoveryClientLimitsImpl({
    required int defaultPageSize,
    required int maximumPageSize,
    required int maximumCategoryIds,
    required int maximumTextCodePoints,
    required int maximumMapPoints,
    required String otherCategoryId,
  }) : super._(
         defaultPageSize: defaultPageSize,
         maximumPageSize: maximumPageSize,
         maximumCategoryIds: maximumCategoryIds,
         maximumTextCodePoints: maximumTextCodePoints,
         maximumMapPoints: maximumMapPoints,
         otherCategoryId: otherCategoryId,
       );

  /// Returns a shallow copy of this [DiscoveryClientLimits]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DiscoveryClientLimits copyWith({
    int? defaultPageSize,
    int? maximumPageSize,
    int? maximumCategoryIds,
    int? maximumTextCodePoints,
    int? maximumMapPoints,
    String? otherCategoryId,
  }) {
    return DiscoveryClientLimits(
      defaultPageSize: defaultPageSize ?? this.defaultPageSize,
      maximumPageSize: maximumPageSize ?? this.maximumPageSize,
      maximumCategoryIds: maximumCategoryIds ?? this.maximumCategoryIds,
      maximumTextCodePoints:
          maximumTextCodePoints ?? this.maximumTextCodePoints,
      maximumMapPoints: maximumMapPoints ?? this.maximumMapPoints,
      otherCategoryId: otherCategoryId ?? this.otherCategoryId,
    );
  }
}
