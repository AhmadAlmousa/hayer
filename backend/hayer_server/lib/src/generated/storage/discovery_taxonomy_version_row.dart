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
import '../taxonomy_status.dart' as _i5zgwsjw;

abstract class DiscoveryTaxonomyVersionRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DiscoveryTaxonomyVersionRow._({
    this.id,
    required this.version,
    required this.revision,
    required this.status,
    required this.documentJson,
    required this.validationPassed,
    required this.validationErrors,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory DiscoveryTaxonomyVersionRow({
    int? id,
    required String version,
    required int revision,
    required _i5zgwsjw.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _DiscoveryTaxonomyVersionRowImpl;

  factory DiscoveryTaxonomyVersionRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTaxonomyVersionRow(
      id: jsonSerialization['id'] as int?,
      version: jsonSerialization['version'] as String,
      revision: jsonSerialization['revision'] as int,
      status: _i5zgwsjw.TaxonomyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      documentJson: jsonSerialization['documentJson'] as String,
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

  static final t = DiscoveryTaxonomyVersionRowTable();

  static const db = DiscoveryTaxonomyVersionRowRepository._();

  @override
  int? id;

  String version;

  int revision;

  _i5zgwsjw.TaxonomyStatus status;

  String documentJson;

  bool validationPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryTaxonomyVersionRow copyWith({
    int? id,
    String? version,
    int? revision,
    _i5zgwsjw.TaxonomyStatus? status,
    String? documentJson,
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
      '__className__': 'DiscoveryTaxonomyVersionRow',
      if (id != null) 'id': id,
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'documentJson': documentJson,
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
    return {};
  }

  static DiscoveryTaxonomyVersionRowInclude include() {
    return DiscoveryTaxonomyVersionRowInclude._();
  }

  static DiscoveryTaxonomyVersionRowIncludeList includeList({
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    DiscoveryTaxonomyVersionRowInclude? include,
  }) {
    return DiscoveryTaxonomyVersionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTaxonomyVersionRowImpl extends DiscoveryTaxonomyVersionRow {
  _DiscoveryTaxonomyVersionRowImpl({
    int? id,
    required String version,
    required int revision,
    required _i5zgwsjw.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) : super._(
         id: id,
         version: version,
         revision: revision,
         status: status,
         documentJson: documentJson,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryTaxonomyVersionRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _i5zgwsjw.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return DiscoveryTaxonomyVersionRow(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      documentJson: documentJson ?? this.documentJson,
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

class DiscoveryTaxonomyVersionRowUpdateTable
    extends _is.UpdateTable<DiscoveryTaxonomyVersionRowTable> {
  DiscoveryTaxonomyVersionRowUpdateTable(super.table);

  _is.ColumnValue<String, String> version(String value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<int, int> revision(int value) => _is.ColumnValue(
    table.revision,
    value,
  );

  _is.ColumnValue<_i5zgwsjw.TaxonomyStatus, _i5zgwsjw.TaxonomyStatus> status(
    _i5zgwsjw.TaxonomyStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> documentJson(String value) => _is.ColumnValue(
    table.documentJson,
    value,
  );

  _is.ColumnValue<bool, bool> validationPassed(bool value) => _is.ColumnValue(
    table.validationPassed,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> validationErrors(
    List<String> value,
  ) => _is.ColumnValue(
    table.validationErrors,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.validatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _is.ColumnValue(
        table.publishedAt,
        value,
      );
}

class DiscoveryTaxonomyVersionRowTable extends _is.Table<int?> {
  DiscoveryTaxonomyVersionRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_taxonomy') {
    updateTable = DiscoveryTaxonomyVersionRowUpdateTable(this);
    version = _is.ColumnString(
      'version',
      this,
    );
    revision = _is.ColumnInt(
      'revision',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    documentJson = _is.ColumnString(
      'documentJson',
      this,
    );
    validationPassed = _is.ColumnBool(
      'validationPassed',
      this,
    );
    validationErrors = _is.ColumnSerializable<List<String>>(
      'validationErrors',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    validatedAt = _is.ColumnDateTime(
      'validatedAt',
      this,
    );
    publishedAt = _is.ColumnDateTime(
      'publishedAt',
      this,
    );
  }

  late final DiscoveryTaxonomyVersionRowUpdateTable updateTable;

  late final _is.ColumnString version;

  late final _is.ColumnInt revision;

  late final _is.ColumnEnum<_i5zgwsjw.TaxonomyStatus> status;

  late final _is.ColumnString documentJson;

  late final _is.ColumnBool validationPassed;

  late final _is.ColumnSerializable<List<String>> validationErrors;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime validatedAt;

  late final _is.ColumnDateTime publishedAt;

  @override
  List<_is.Column> get columns => [
    id,
    version,
    revision,
    status,
    documentJson,
    validationPassed,
    validationErrors,
    createdBy,
    createdAt,
    validatedAt,
    publishedAt,
  ];
}

class DiscoveryTaxonomyVersionRowInclude extends _is.IncludeObject {
  DiscoveryTaxonomyVersionRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiscoveryTaxonomyVersionRow.t;
}

class DiscoveryTaxonomyVersionRowIncludeList extends _is.IncludeList {
  DiscoveryTaxonomyVersionRowIncludeList._({
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTaxonomyVersionRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiscoveryTaxonomyVersionRow.t;
}

class DiscoveryTaxonomyVersionRowRepository {
  const DiscoveryTaxonomyVersionRowRepository._();

  /// Returns a list of [DiscoveryTaxonomyVersionRow]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<DiscoveryTaxonomyVersionRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTaxonomyVersionRow] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<DiscoveryTaxonomyVersionRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? offset,
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTaxonomyVersionRow] by its [id] or null if no such row exists.
  Future<DiscoveryTaxonomyVersionRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTaxonomyVersionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTaxonomyVersionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTaxonomyVersionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> insert(
    _is.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiscoveryTaxonomyVersionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiscoveryTaxonomyVersionRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTaxonomyVersionRow] will have its `id` field set.
  Future<DiscoveryTaxonomyVersionRow> insertRow(
    _is.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiscoveryTaxonomyVersionRow]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [DiscoveryTaxonomyVersionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> upsert(
    _is.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    required _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiscoveryTaxonomyVersionRow>(
      rows,
      conflictColumns: conflictColumns(DiscoveryTaxonomyVersionRow.t),
      updateColumns: updateColumns?.call(DiscoveryTaxonomyVersionRow.t),
      updateWhere: updateWhere?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiscoveryTaxonomyVersionRow] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [DiscoveryTaxonomyVersionRow] will have its `id` field set.
  Future<DiscoveryTaxonomyVersionRow?> upsertRow(
    _is.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    required _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiscoveryTaxonomyVersionRow>(
      row,
      conflictColumns: conflictColumns(DiscoveryTaxonomyVersionRow.t),
      updateColumns: updateColumns?.call(DiscoveryTaxonomyVersionRow.t),
      updateWhere: updateWhere?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTaxonomyVersionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> update(
    _is.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiscoveryTaxonomyVersionRow>(
      rows,
      columns: columns?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiscoveryTaxonomyVersionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTaxonomyVersionRow> updateRow(
    _is.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _is.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTaxonomyVersionRow>(
      row,
      columns: columns?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTaxonomyVersionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTaxonomyVersionRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiscoveryTaxonomyVersionRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTaxonomyVersionRow>(
      id,
      columnValues: columnValues(DiscoveryTaxonomyVersionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTaxonomyVersionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiscoveryTaxonomyVersionRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiscoveryTaxonomyVersionRow>(
      columnValues: columnValues(DiscoveryTaxonomyVersionRow.t.updateTable),
      where: where(DiscoveryTaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiscoveryTaxonomyVersionRow]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> delete(
    _is.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiscoveryTaxonomyVersionRow>(
      rows,
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiscoveryTaxonomyVersionRow].
  Future<DiscoveryTaxonomyVersionRow> deleteRow(
    _is.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTaxonomyVersionRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    _is.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiscoveryTaxonomyVersionRow>(
      where: where(DiscoveryTaxonomyVersionRow.t),
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTaxonomyVersionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTaxonomyVersionRow>(
      where: where(DiscoveryTaxonomyVersionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
