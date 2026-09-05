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

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'taxonomy_status.dart' as _i2;
import 'admin_taxonomy_item.dart' as _i3;
import 'admin_map_location.dart' as _i4;
import 'package:hayer_client/src/protocol/protocol.dart' as _i5;

abstract class AdminTaxonomyVersion implements _i1.SerializableModel {
  AdminTaxonomyVersion._({
    required this.version,
    required this.revision,
    required this.status,
    required this.items,
    required this.validationPassed,
    required this.validationErrors,
    this.validationLocation,
    this.validationRadiusMeters,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory AdminTaxonomyVersion({
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required List<_i3.AdminTaxonomyItem> items,
    required bool validationPassed,
    required List<String> validationErrors,
    _i4.AdminMapLocation? validationLocation,
    int? validationRadiusMeters,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _AdminTaxonomyVersionImpl;

  factory AdminTaxonomyVersion.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminTaxonomyVersion(
      version: jsonSerialization['version'] as String,
      revision: jsonSerialization['revision'] as int,
      status: _i2.TaxonomyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      items: _i5.Protocol().deserialize<List<_i3.AdminTaxonomyItem>>(
        jsonSerialization['items'],
      ),
      validationPassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _i5.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      validationLocation: jsonSerialization['validationLocation'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AdminMapLocation>(
              jsonSerialization['validationLocation'],
            ),
      validationRadiusMeters:
          jsonSerialization['validationRadiusMeters'] as int?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
    );
  }

  String version;

  int revision;

  _i2.TaxonomyStatus status;

  List<_i3.AdminTaxonomyItem> items;

  bool validationPassed;

  List<String> validationErrors;

  _i4.AdminMapLocation? validationLocation;

  int? validationRadiusMeters;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  /// Returns a shallow copy of this [AdminTaxonomyVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    List<_i3.AdminTaxonomyItem>? items,
    bool? validationPassed,
    List<String>? validationErrors,
    _i4.AdminMapLocation? validationLocation,
    int? validationRadiusMeters,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminTaxonomyVersion',
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      if (validationLocation != null)
        'validationLocation': validationLocation?.toJson(),
      if (validationRadiusMeters != null)
        'validationRadiusMeters': validationRadiusMeters,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminTaxonomyVersionImpl extends AdminTaxonomyVersion {
  _AdminTaxonomyVersionImpl({
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required List<_i3.AdminTaxonomyItem> items,
    required bool validationPassed,
    required List<String> validationErrors,
    _i4.AdminMapLocation? validationLocation,
    int? validationRadiusMeters,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) : super._(
         version: version,
         revision: revision,
         status: status,
         items: items,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         validationLocation: validationLocation,
         validationRadiusMeters: validationRadiusMeters,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [AdminTaxonomyVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    List<_i3.AdminTaxonomyItem>? items,
    bool? validationPassed,
    List<String>? validationErrors,
    Object? validationLocation = _Undefined,
    Object? validationRadiusMeters = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return AdminTaxonomyVersion(
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      validationPassed: validationPassed ?? this.validationPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      validationLocation: validationLocation is _i4.AdminMapLocation?
          ? validationLocation
          : this.validationLocation?.copyWith(),
      validationRadiusMeters: validationRadiusMeters is int?
          ? validationRadiusMeters
          : this.validationRadiusMeters,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
    );
  }
}
