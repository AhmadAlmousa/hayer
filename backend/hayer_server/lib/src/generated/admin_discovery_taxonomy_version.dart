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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import 'discovery_taxonomy_node.dart' as _i3sj4yil;
import 'taxonomy_status.dart' as _ix2svfdk;

abstract class AdminDiscoveryTaxonomyVersion
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminDiscoveryTaxonomyVersion._({
    required this.version,
    required this.revision,
    required this.status,
    required this.roots,
    required this.validationPassed,
    required this.validationErrors,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory AdminDiscoveryTaxonomyVersion({
    required String version,
    required int revision,
    required _ix2svfdk.TaxonomyStatus status,
    required List<_i3sj4yil.DiscoveryTaxonomyNode> roots,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _AdminDiscoveryTaxonomyVersionImpl;

  factory AdminDiscoveryTaxonomyVersion.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminDiscoveryTaxonomyVersion(
      version: jsonSerialization['version'] as String,
      revision: jsonSerialization['revision'] as int,
      status: _ix2svfdk.TaxonomyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      roots: _i66y2smk.Protocol()
          .deserialize<List<_i3sj4yil.DiscoveryTaxonomyNode>>(
            jsonSerialization['roots'],
          ),
      validationPassed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
    );
  }

  String version;

  int revision;

  _ix2svfdk.TaxonomyStatus status;

  List<_i3sj4yil.DiscoveryTaxonomyNode> roots;

  bool validationPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  /// Returns a shallow copy of this [AdminDiscoveryTaxonomyVersion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminDiscoveryTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _ix2svfdk.TaxonomyStatus? status,
    List<_i3sj4yil.DiscoveryTaxonomyNode>? roots,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminDiscoveryTaxonomyVersion',
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'roots': roots.toJson(valueToJson: (v) => v.toJson()),
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminDiscoveryTaxonomyVersion',
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'roots': roots.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminDiscoveryTaxonomyVersionImpl extends AdminDiscoveryTaxonomyVersion {
  _AdminDiscoveryTaxonomyVersionImpl({
    required String version,
    required int revision,
    required _ix2svfdk.TaxonomyStatus status,
    required List<_i3sj4yil.DiscoveryTaxonomyNode> roots,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) : super._(
         version: version,
         revision: revision,
         status: status,
         roots: roots,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [AdminDiscoveryTaxonomyVersion]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminDiscoveryTaxonomyVersion copyWith({
    String? version,
    int? revision,
    _ix2svfdk.TaxonomyStatus? status,
    List<_i3sj4yil.DiscoveryTaxonomyNode>? roots,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return AdminDiscoveryTaxonomyVersion(
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      roots: roots ?? this.roots.map((e0) => e0.copyWith()).toList(),
      validationPassed: validationPassed ?? this.validationPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
    );
  }
}
