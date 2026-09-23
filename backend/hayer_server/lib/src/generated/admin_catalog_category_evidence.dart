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

abstract class AdminCatalogCategoryEvidence
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminCatalogCategoryEvidence._({
    required this.categoryId,
    required this.evidenceQuery,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });

  factory AdminCatalogCategoryEvidence({
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) = _AdminCatalogCategoryEvidenceImpl;

  factory AdminCatalogCategoryEvidence.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminCatalogCategoryEvidence(
      categoryId: jsonSerialization['categoryId'] as String,
      evidenceQuery: jsonSerialization['evidenceQuery'] as String,
      firstSeenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  String categoryId;

  String evidenceQuery;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  /// Returns a shallow copy of this [AdminCatalogCategoryEvidence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminCatalogCategoryEvidence copyWith({
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminCatalogCategoryEvidence',
      'categoryId': categoryId,
      'evidenceQuery': evidenceQuery,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminCatalogCategoryEvidence',
      'categoryId': categoryId,
      'evidenceQuery': evidenceQuery,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminCatalogCategoryEvidenceImpl extends AdminCatalogCategoryEvidence {
  _AdminCatalogCategoryEvidenceImpl({
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) : super._(
         categoryId: categoryId,
         evidenceQuery: evidenceQuery,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [AdminCatalogCategoryEvidence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminCatalogCategoryEvidence copyWith({
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  }) {
    return AdminCatalogCategoryEvidence(
      categoryId: categoryId ?? this.categoryId,
      evidenceQuery: evidenceQuery ?? this.evidenceQuery,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
