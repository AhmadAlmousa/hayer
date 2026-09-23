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

abstract class DiscoveryHarvestManifestEntry
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DiscoveryHarvestManifestEntry._({
    required this.id,
    required this.label,
    required this.queryEn,
    required this.fallbackQueryAr,
    required this.sortOrder,
    required this.enabled,
  });

  factory DiscoveryHarvestManifestEntry({
    required String id,
    required String label,
    required String queryEn,
    required String fallbackQueryAr,
    required int sortOrder,
    required bool enabled,
  }) = _DiscoveryHarvestManifestEntryImpl;

  factory DiscoveryHarvestManifestEntry.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryHarvestManifestEntry(
      id: jsonSerialization['id'] as String,
      label: jsonSerialization['label'] as String,
      queryEn: jsonSerialization['queryEn'] as String,
      fallbackQueryAr: jsonSerialization['fallbackQueryAr'] as String,
      sortOrder: jsonSerialization['sortOrder'] as int,
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  String id;

  String label;

  String queryEn;

  String fallbackQueryAr;

  int sortOrder;

  bool enabled;

  /// Returns a shallow copy of this [DiscoveryHarvestManifestEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryHarvestManifestEntry copyWith({
    String? id,
    String? label,
    String? queryEn,
    String? fallbackQueryAr,
    int? sortOrder,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestManifestEntry',
      'id': id,
      'label': label,
      'queryEn': queryEn,
      'fallbackQueryAr': fallbackQueryAr,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DiscoveryHarvestManifestEntry',
      'id': id,
      'label': label,
      'queryEn': queryEn,
      'fallbackQueryAr': fallbackQueryAr,
      'sortOrder': sortOrder,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DiscoveryHarvestManifestEntryImpl extends DiscoveryHarvestManifestEntry {
  _DiscoveryHarvestManifestEntryImpl({
    required String id,
    required String label,
    required String queryEn,
    required String fallbackQueryAr,
    required int sortOrder,
    required bool enabled,
  }) : super._(
         id: id,
         label: label,
         queryEn: queryEn,
         fallbackQueryAr: fallbackQueryAr,
         sortOrder: sortOrder,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestManifestEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryHarvestManifestEntry copyWith({
    String? id,
    String? label,
    String? queryEn,
    String? fallbackQueryAr,
    int? sortOrder,
    bool? enabled,
  }) {
    return DiscoveryHarvestManifestEntry(
      id: id ?? this.id,
      label: label ?? this.label,
      queryEn: queryEn ?? this.queryEn,
      fallbackQueryAr: fallbackQueryAr ?? this.fallbackQueryAr,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
    );
  }
}
