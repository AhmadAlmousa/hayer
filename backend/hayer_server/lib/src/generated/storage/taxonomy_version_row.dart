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

abstract class TaxonomyVersionRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TaxonomyVersionRow._({
    this.id,
    required this.version,
    required this.revision,
    required this.status,
    required this.documentJson,
    required this.validationPassed,
    required this.validationErrors,
    this.validationLocationJson,
    this.validationRadiusMeters,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory TaxonomyVersionRow({
    int? id,
    required String version,
    required int revision,
    required _i5zgwsjw.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _TaxonomyVersionRowImpl;

  factory TaxonomyVersionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaxonomyVersionRow(
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
      validationLocationJson:
          jsonSerialization['validationLocationJson'] as String?,
      validationRadiusMeters:
          jsonSerialization['validationRadiusMeters'] as int?,
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

  static final t = TaxonomyVersionRowTable();

  static const db = TaxonomyVersionRowRepository._();

  @override
  int? id;

  String version;

  int revision;

  _i5zgwsjw.TaxonomyStatus status;

  String documentJson;

  bool validationPassed;

  List<String> validationErrors;

  String? validationLocationJson;

  int? validationRadiusMeters;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TaxonomyVersionRow copyWith({
    int? id,
    String? version,
    int? revision,
    _i5zgwsjw.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomyVersionRow',
      if (id != null) 'id': id,
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'documentJson': documentJson,
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      if (validationLocationJson != null)
        'validationLocationJson': validationLocationJson,
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
    return {};
  }

  static TaxonomyVersionRowInclude include() {
    return TaxonomyVersionRowInclude._();
  }

  static TaxonomyVersionRowIncludeList includeList({
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    TaxonomyVersionRowInclude? include,
  }) {
    return TaxonomyVersionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaxonomyVersionRowImpl extends TaxonomyVersionRow {
  _TaxonomyVersionRowImpl({
    int? id,
    required String version,
    required int revision,
    required _i5zgwsjw.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
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
         validationLocationJson: validationLocationJson,
         validationRadiusMeters: validationRadiusMeters,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [TaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TaxonomyVersionRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _i5zgwsjw.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    Object? validationLocationJson = _Undefined,
    Object? validationRadiusMeters = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return TaxonomyVersionRow(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      documentJson: documentJson ?? this.documentJson,
      validationPassed: validationPassed ?? this.validationPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      validationLocationJson: validationLocationJson is String?
          ? validationLocationJson
          : this.validationLocationJson,
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

class TaxonomyVersionRowUpdateTable
    extends _is.UpdateTable<TaxonomyVersionRowTable> {
  TaxonomyVersionRowUpdateTable(super.table);

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

  _is.ColumnValue<String, String> validationLocationJson(String? value) =>
      _is.ColumnValue(
        table.validationLocationJson,
        value,
      );

  _is.ColumnValue<int, int> validationRadiusMeters(int? value) =>
      _is.ColumnValue(
        table.validationRadiusMeters,
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

class TaxonomyVersionRowTable extends _is.Table<int?> {
  TaxonomyVersionRowTable({super.tableRelation})
    : super(tableName: 'hayer_taxonomy_version') {
    updateTable = TaxonomyVersionRowUpdateTable(this);
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
    validationLocationJson = _is.ColumnString(
      'validationLocationJson',
      this,
    );
    validationRadiusMeters = _is.ColumnInt(
      'validationRadiusMeters',
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

  late final TaxonomyVersionRowUpdateTable updateTable;

  late final _is.ColumnString version;

  late final _is.ColumnInt revision;

  late final _is.ColumnEnum<_i5zgwsjw.TaxonomyStatus> status;

  late final _is.ColumnString documentJson;

  late final _is.ColumnBool validationPassed;

  late final _is.ColumnSerializable<List<String>> validationErrors;

  late final _is.ColumnString validationLocationJson;

  late final _is.ColumnInt validationRadiusMeters;

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
    validationLocationJson,
    validationRadiusMeters,
    createdBy,
    createdAt,
    validatedAt,
    publishedAt,
  ];
}

class TaxonomyVersionRowInclude extends _is.IncludeObject {
  TaxonomyVersionRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TaxonomyVersionRow.t;
}

class TaxonomyVersionRowIncludeList extends _is.IncludeList {
  TaxonomyVersionRowIncludeList._({
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TaxonomyVersionRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TaxonomyVersionRow.t;
}

class TaxonomyVersionRowRepository {
  const TaxonomyVersionRowRepository._();

  /// Returns a list of [TaxonomyVersionRow]s matching the given query parameters.
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
  Future<List<TaxonomyVersionRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TaxonomyVersionRow] matching the given query parameters.
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
  Future<TaxonomyVersionRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? offset,
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TaxonomyVersionRow] by its [id] or null if no such row exists.
  Future<TaxonomyVersionRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TaxonomyVersionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TaxonomyVersionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [TaxonomyVersionRow]s will have their `id` fields set.
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
  Future<List<TaxonomyVersionRow>> insert(
    _is.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TaxonomyVersionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TaxonomyVersionRow] and returns the inserted row.
  ///
  /// The returned [TaxonomyVersionRow] will have its `id` field set.
  Future<TaxonomyVersionRow> insertRow(
    _is.DatabaseSession session,
    TaxonomyVersionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TaxonomyVersionRow]s in the list and returns the resulting rows.
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
  /// The returned [TaxonomyVersionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TaxonomyVersionRow>> upsert(
    _is.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    required _is.ColumnSelections<TaxonomyVersionRowTable> conflictColumns,
    _is.ColumnSelections<TaxonomyVersionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TaxonomyVersionRow>(
      rows,
      conflictColumns: conflictColumns(TaxonomyVersionRow.t),
      updateColumns: updateColumns?.call(TaxonomyVersionRow.t),
      updateWhere: updateWhere?.call(TaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TaxonomyVersionRow] and returns the resulting row.
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
  /// The returned [TaxonomyVersionRow] will have its `id` field set.
  Future<TaxonomyVersionRow?> upsertRow(
    _is.DatabaseSession session,
    TaxonomyVersionRow row, {
    required _is.ColumnSelections<TaxonomyVersionRowTable> conflictColumns,
    _is.ColumnSelections<TaxonomyVersionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TaxonomyVersionRow>(
      row,
      conflictColumns: conflictColumns(TaxonomyVersionRow.t),
      updateColumns: updateColumns?.call(TaxonomyVersionRow.t),
      updateWhere: updateWhere?.call(TaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [TaxonomyVersionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TaxonomyVersionRow>> update(
    _is.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _is.ColumnSelections<TaxonomyVersionRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TaxonomyVersionRow>(
      rows,
      columns: columns?.call(TaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TaxonomyVersionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TaxonomyVersionRow> updateRow(
    _is.DatabaseSession session,
    TaxonomyVersionRow row, {
    _is.ColumnSelections<TaxonomyVersionRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TaxonomyVersionRow>(
      row,
      columns: columns?.call(TaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaxonomyVersionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TaxonomyVersionRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TaxonomyVersionRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TaxonomyVersionRow>(
      id,
      columnValues: columnValues(TaxonomyVersionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TaxonomyVersionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TaxonomyVersionRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TaxonomyVersionRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TaxonomyVersionRow>(
      columnValues: columnValues(TaxonomyVersionRow.t.updateTable),
      where: where(TaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TaxonomyVersionRow]s in the list and returns the deleted rows.
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
  Future<List<TaxonomyVersionRow>> delete(
    _is.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TaxonomyVersionRow>(
      rows,
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TaxonomyVersionRow].
  Future<TaxonomyVersionRow> deleteRow(
    _is.DatabaseSession session,
    TaxonomyVersionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TaxonomyVersionRow>(
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
  Future<List<TaxonomyVersionRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    _is.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _is.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TaxonomyVersionRow>(
      where: where(TaxonomyVersionRow.t),
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TaxonomyVersionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TaxonomyVersionRow>(
      where: where(TaxonomyVersionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
