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
import 'admin_map_location.dart' as _irkf0vy6;
import 'admin_taxonomy_item.dart' as _ic97i39b;
import 'taxonomy_status.dart' as _ix2svfdk;

abstract class AdminTaxonomyVersion
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _ix2svfdk.TaxonomyStatus status,
    required List<_ic97i39b.AdminTaxonomyItem> items,
    required bool validationPassed,
    required List<String> validationErrors,
    _irkf0vy6.AdminMapLocation? validationLocation,
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
      status: _ix2svfdk.TaxonomyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      items: _iynev3sz.Protocol()
          .deserialize<List<_ic97i39b.AdminTaxonomyItem>>(
            jsonSerialization['items'],
          ),
      validationPassed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _iynev3sz.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      validationLocation: jsonSerialization['validationLocation'] == null
          ? null
          : _iynev3sz.Protocol().deserialize<_irkf0vy6.AdminMapLocation>(
              jsonSerialization['validationLocation'],
            ),
      validationRadiusMeters:
          jsonSerialization['validationRadiusMeters'] as int?,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
    );
  }

  String version;

  int revision;

  _ix2svfdk.TaxonomyStatus status;

  List<_ic97i39b.AdminTaxonomyItem> items;

  bool validationPassed;

  List<String> validationErrors;

  _irkf0vy6.AdminMapLocation? validationLocation;

  int? validationRadiusMeters;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  /// Returns a shallow copy of this [AdminTaxonomyVersion]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _ix2svfdk.TaxonomyStatus? status,
    List<_ic97i39b.AdminTaxonomyItem>? items,
    bool? validationPassed,
    List<String>? validationErrors,
    _irkf0vy6.AdminMapLocation? validationLocation,
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminTaxonomyVersion',
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      if (validationLocation != null)
        'validationLocation': validationLocation?.toJsonForProtocol(),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminTaxonomyVersionImpl extends AdminTaxonomyVersion {
  _AdminTaxonomyVersionImpl({
    required String version,
    required int revision,
    required _ix2svfdk.TaxonomyStatus status,
    required List<_ic97i39b.AdminTaxonomyItem> items,
    required bool validationPassed,
    required List<String> validationErrors,
    _irkf0vy6.AdminMapLocation? validationLocation,
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
  @_isc.useResult
  @override
  AdminTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _ix2svfdk.TaxonomyStatus? status,
    List<_ic97i39b.AdminTaxonomyItem>? items,
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
      validationLocation: validationLocation is _irkf0vy6.AdminMapLocation?
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
