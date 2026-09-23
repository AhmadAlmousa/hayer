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
import 'admin_audit_entry.dart' as _i62lvi00;

abstract class AdminAuditPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminAuditPage._({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory AdminAuditPage({
    required List<_i62lvi00.AdminAuditEntry> items,
    required int total,
    required int page,
    required int pageSize,
  }) = _AdminAuditPageImpl;

  factory AdminAuditPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditPage(
      items: _i66y2smk.Protocol().deserialize<List<_i62lvi00.AdminAuditEntry>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
    );
  }

  List<_i62lvi00.AdminAuditEntry> items;

  int total;

  int page;

  int pageSize;

  /// Returns a shallow copy of this [AdminAuditPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAuditPage copyWith({
    List<_i62lvi00.AdminAuditEntry>? items,
    int? total,
    int? page,
    int? pageSize,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'page': page,
      'pageSize': pageSize,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminAuditPageImpl extends AdminAuditPage {
  _AdminAuditPageImpl({
    required List<_i62lvi00.AdminAuditEntry> items,
    required int total,
    required int page,
    required int pageSize,
  }) : super._(
         items: items,
         total: total,
         page: page,
         pageSize: pageSize,
       );

  /// Returns a shallow copy of this [AdminAuditPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminAuditPage copyWith({
    List<_i62lvi00.AdminAuditEntry>? items,
    int? total,
    int? page,
    int? pageSize,
  }) {
    return AdminAuditPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}
