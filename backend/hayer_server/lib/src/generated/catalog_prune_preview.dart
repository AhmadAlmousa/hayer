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

abstract class CatalogPrunePreview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CatalogPrunePreview._({
    required this.eligibleCount,
    required this.retentionDays,
    required this.cutoff,
  });

  factory CatalogPrunePreview({
    required int eligibleCount,
    required int retentionDays,
    required DateTime cutoff,
  }) = _CatalogPrunePreviewImpl;

  factory CatalogPrunePreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return CatalogPrunePreview(
      eligibleCount: jsonSerialization['eligibleCount'] as int,
      retentionDays: jsonSerialization['retentionDays'] as int,
      cutoff: _is.DateTimeJsonExtension.fromJson(jsonSerialization['cutoff']),
    );
  }

  int eligibleCount;

  int retentionDays;

  DateTime cutoff;

  /// Returns a shallow copy of this [CatalogPrunePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CatalogPrunePreview copyWith({
    int? eligibleCount,
    int? retentionDays,
    DateTime? cutoff,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CatalogPrunePreview',
      'eligibleCount': eligibleCount,
      'retentionDays': retentionDays,
      'cutoff': cutoff.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CatalogPrunePreview',
      'eligibleCount': eligibleCount,
      'retentionDays': retentionDays,
      'cutoff': cutoff.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CatalogPrunePreviewImpl extends CatalogPrunePreview {
  _CatalogPrunePreviewImpl({
    required int eligibleCount,
    required int retentionDays,
    required DateTime cutoff,
  }) : super._(
         eligibleCount: eligibleCount,
         retentionDays: retentionDays,
         cutoff: cutoff,
       );

  /// Returns a shallow copy of this [CatalogPrunePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CatalogPrunePreview copyWith({
    int? eligibleCount,
    int? retentionDays,
    DateTime? cutoff,
  }) {
    return CatalogPrunePreview(
      eligibleCount: eligibleCount ?? this.eligibleCount,
      retentionDays: retentionDays ?? this.retentionDays,
      cutoff: cutoff ?? this.cutoff,
    );
  }
}
