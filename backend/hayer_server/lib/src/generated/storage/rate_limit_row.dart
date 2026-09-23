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

abstract class RateLimitRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  RateLimitRow._({
    this.id,
    required this.counterKey,
    required this.attemptCount,
    required this.windowStartedAt,
    required this.expiresAt,
  });

  factory RateLimitRow({
    _is.UuidValue? id,
    required String counterKey,
    required int attemptCount,
    required DateTime windowStartedAt,
    required DateTime expiresAt,
  }) = _RateLimitRowImpl;

  factory RateLimitRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return RateLimitRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      counterKey: jsonSerialization['counterKey'] as String,
      attemptCount: jsonSerialization['attemptCount'] as int,
      windowStartedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStartedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = RateLimitRowTable();

  static const db = RateLimitRowRepository._();

  @override
  _is.UuidValue? id;

  String counterKey;

  int attemptCount;

  DateTime windowStartedAt;

  DateTime expiresAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [RateLimitRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RateLimitRow copyWith({
    _is.UuidValue? id,
    String? counterKey,
    int? attemptCount,
    DateTime? windowStartedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RateLimitRow',
      if (id != null) 'id': id?.toJson(),
      'counterKey': counterKey,
      'attemptCount': attemptCount,
      'windowStartedAt': windowStartedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static RateLimitRowInclude include() {
    return RateLimitRowInclude._();
  }

  static RateLimitRowIncludeList includeList({
    _is.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    RateLimitRowInclude? include,
  }) {
    return RateLimitRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RateLimitRowImpl extends RateLimitRow {
  _RateLimitRowImpl({
    _is.UuidValue? id,
    required String counterKey,
    required int attemptCount,
    required DateTime windowStartedAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         counterKey: counterKey,
         attemptCount: attemptCount,
         windowStartedAt: windowStartedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [RateLimitRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RateLimitRow copyWith({
    Object? id = _Undefined,
    String? counterKey,
    int? attemptCount,
    DateTime? windowStartedAt,
    DateTime? expiresAt,
  }) {
    return RateLimitRow(
      id: id is _is.UuidValue? ? id : this.id,
      counterKey: counterKey ?? this.counterKey,
      attemptCount: attemptCount ?? this.attemptCount,
      windowStartedAt: windowStartedAt ?? this.windowStartedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class RateLimitRowUpdateTable extends _is.UpdateTable<RateLimitRowTable> {
  RateLimitRowUpdateTable(super.table);

  _is.ColumnValue<String, String> counterKey(String value) => _is.ColumnValue(
    table.counterKey,
    value,
  );

  _is.ColumnValue<int, int> attemptCount(int value) => _is.ColumnValue(
    table.attemptCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> windowStartedAt(DateTime value) =>
      _is.ColumnValue(
        table.windowStartedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class RateLimitRowTable extends _is.Table<_is.UuidValue?> {
  RateLimitRowTable({super.tableRelation})
    : super(tableName: 'hayer_rate_limit') {
    updateTable = RateLimitRowUpdateTable(this);
    counterKey = _is.ColumnString(
      'counterKey',
      this,
    );
    attemptCount = _is.ColumnInt(
      'attemptCount',
      this,
    );
    windowStartedAt = _is.ColumnDateTime(
      'windowStartedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final RateLimitRowUpdateTable updateTable;

  late final _is.ColumnString counterKey;

  late final _is.ColumnInt attemptCount;

  late final _is.ColumnDateTime windowStartedAt;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    counterKey,
    attemptCount,
    windowStartedAt,
    expiresAt,
  ];
}

class RateLimitRowInclude extends _is.IncludeObject {
  RateLimitRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => RateLimitRow.t;
}

class RateLimitRowIncludeList extends _is.IncludeList {
  RateLimitRowIncludeList._({
    _is.WhereExpressionBuilder<RateLimitRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RateLimitRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => RateLimitRow.t;
}

class RateLimitRowRepository {
  const RateLimitRowRepository._();

  /// Returns a list of [RateLimitRow]s matching the given query parameters.
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
  Future<List<RateLimitRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RateLimitRow] matching the given query parameters.
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
  Future<RateLimitRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? offset,
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RateLimitRow] by its [id] or null if no such row exists.
  Future<RateLimitRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RateLimitRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RateLimitRow]s in the list and returns the inserted rows.
  ///
  /// The returned [RateLimitRow]s will have their `id` fields set.
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
  Future<List<RateLimitRow>> insert(
    _is.DatabaseSession session,
    List<RateLimitRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RateLimitRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RateLimitRow] and returns the inserted row.
  ///
  /// The returned [RateLimitRow] will have its `id` field set.
  Future<RateLimitRow> insertRow(
    _is.DatabaseSession session,
    RateLimitRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RateLimitRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RateLimitRow]s in the list and returns the resulting rows.
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
  /// The returned [RateLimitRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RateLimitRow>> upsert(
    _is.DatabaseSession session,
    List<RateLimitRow> rows, {
    required _is.ColumnSelections<RateLimitRowTable> conflictColumns,
    _is.ColumnSelections<RateLimitRowTable>? updateColumns,
    _is.WhereExpressionBuilder<RateLimitRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RateLimitRow>(
      rows,
      conflictColumns: conflictColumns(RateLimitRow.t),
      updateColumns: updateColumns?.call(RateLimitRow.t),
      updateWhere: updateWhere?.call(RateLimitRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RateLimitRow] and returns the resulting row.
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
  /// The returned [RateLimitRow] will have its `id` field set.
  Future<RateLimitRow?> upsertRow(
    _is.DatabaseSession session,
    RateLimitRow row, {
    required _is.ColumnSelections<RateLimitRowTable> conflictColumns,
    _is.ColumnSelections<RateLimitRowTable>? updateColumns,
    _is.WhereExpressionBuilder<RateLimitRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RateLimitRow>(
      row,
      conflictColumns: conflictColumns(RateLimitRow.t),
      updateColumns: updateColumns?.call(RateLimitRow.t),
      updateWhere: updateWhere?.call(RateLimitRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [RateLimitRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RateLimitRow>> update(
    _is.DatabaseSession session,
    List<RateLimitRow> rows, {
    _is.ColumnSelections<RateLimitRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RateLimitRow>(
      rows,
      columns: columns?.call(RateLimitRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RateLimitRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RateLimitRow> updateRow(
    _is.DatabaseSession session,
    RateLimitRow row, {
    _is.ColumnSelections<RateLimitRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RateLimitRow>(
      row,
      columns: columns?.call(RateLimitRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RateLimitRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RateLimitRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<RateLimitRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RateLimitRow>(
      id,
      columnValues: columnValues(RateLimitRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RateLimitRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RateLimitRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RateLimitRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RateLimitRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RateLimitRow>(
      columnValues: columnValues(RateLimitRow.t.updateTable),
      where: where(RateLimitRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RateLimitRow]s in the list and returns the deleted rows.
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
  Future<List<RateLimitRow>> delete(
    _is.DatabaseSession session,
    List<RateLimitRow> rows, {
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RateLimitRow>(
      rows,
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RateLimitRow].
  Future<RateLimitRow> deleteRow(
    _is.DatabaseSession session,
    RateLimitRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RateLimitRow>(
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
  Future<List<RateLimitRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RateLimitRowTable> where,
    _is.OrderByBuilder<RateLimitRowTable>? orderBy,
    _is.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RateLimitRow>(
      where: where(RateLimitRow.t),
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RateLimitRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RateLimitRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RateLimitRow>(
      where: where(RateLimitRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
