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

abstract class DiscoveryTypeObservationRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DiscoveryTypeObservationRow._({
    this.id,
    required this.typeKey,
    required this.primaryType,
    required this.observationCount,
    required this.firstObservedAt,
    required this.lastObservedAt,
  });

  factory DiscoveryTypeObservationRow({
    int? id,
    required String typeKey,
    required String primaryType,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
  }) = _DiscoveryTypeObservationRowImpl;

  factory DiscoveryTypeObservationRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTypeObservationRow(
      id: jsonSerialization['id'] as int?,
      typeKey: jsonSerialization['typeKey'] as String,
      primaryType: jsonSerialization['primaryType'] as String,
      observationCount: jsonSerialization['observationCount'] as int,
      firstObservedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstObservedAt'],
      ),
      lastObservedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastObservedAt'],
      ),
    );
  }

  static final t = DiscoveryTypeObservationRowTable();

  static const db = DiscoveryTypeObservationRowRepository._();

  @override
  int? id;

  String typeKey;

  String primaryType;

  int observationCount;

  DateTime firstObservedAt;

  DateTime lastObservedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTypeObservationRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryTypeObservationRow copyWith({
    int? id,
    String? typeKey,
    String? primaryType,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTypeObservationRow',
      if (id != null) 'id': id,
      'typeKey': typeKey,
      'primaryType': primaryType,
      'observationCount': observationCount,
      'firstObservedAt': firstObservedAt.toJson(),
      'lastObservedAt': lastObservedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryTypeObservationRowInclude include() {
    return DiscoveryTypeObservationRowInclude._();
  }

  static DiscoveryTypeObservationRowIncludeList includeList({
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    DiscoveryTypeObservationRowInclude? include,
  }) {
    return DiscoveryTypeObservationRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTypeObservationRowImpl extends DiscoveryTypeObservationRow {
  _DiscoveryTypeObservationRowImpl({
    int? id,
    required String typeKey,
    required String primaryType,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
  }) : super._(
         id: id,
         typeKey: typeKey,
         primaryType: primaryType,
         observationCount: observationCount,
         firstObservedAt: firstObservedAt,
         lastObservedAt: lastObservedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTypeObservationRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryTypeObservationRow copyWith({
    Object? id = _Undefined,
    String? typeKey,
    String? primaryType,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
  }) {
    return DiscoveryTypeObservationRow(
      id: id is int? ? id : this.id,
      typeKey: typeKey ?? this.typeKey,
      primaryType: primaryType ?? this.primaryType,
      observationCount: observationCount ?? this.observationCount,
      firstObservedAt: firstObservedAt ?? this.firstObservedAt,
      lastObservedAt: lastObservedAt ?? this.lastObservedAt,
    );
  }
}

class DiscoveryTypeObservationRowUpdateTable
    extends _is.UpdateTable<DiscoveryTypeObservationRowTable> {
  DiscoveryTypeObservationRowUpdateTable(super.table);

  _is.ColumnValue<String, String> typeKey(String value) => _is.ColumnValue(
    table.typeKey,
    value,
  );

  _is.ColumnValue<String, String> primaryType(String value) => _is.ColumnValue(
    table.primaryType,
    value,
  );

  _is.ColumnValue<int, int> observationCount(int value) => _is.ColumnValue(
    table.observationCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> firstObservedAt(DateTime value) =>
      _is.ColumnValue(
        table.firstObservedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastObservedAt(DateTime value) =>
      _is.ColumnValue(
        table.lastObservedAt,
        value,
      );
}

class DiscoveryTypeObservationRowTable extends _is.Table<int?> {
  DiscoveryTypeObservationRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_type_observation') {
    updateTable = DiscoveryTypeObservationRowUpdateTable(this);
    typeKey = _is.ColumnString(
      'typeKey',
      this,
    );
    primaryType = _is.ColumnString(
      'primaryType',
      this,
    );
    observationCount = _is.ColumnInt(
      'observationCount',
      this,
    );
    firstObservedAt = _is.ColumnDateTime(
      'firstObservedAt',
      this,
    );
    lastObservedAt = _is.ColumnDateTime(
      'lastObservedAt',
      this,
    );
  }

  late final DiscoveryTypeObservationRowUpdateTable updateTable;

  late final _is.ColumnString typeKey;

  late final _is.ColumnString primaryType;

  late final _is.ColumnInt observationCount;

  late final _is.ColumnDateTime firstObservedAt;

  late final _is.ColumnDateTime lastObservedAt;

  @override
  List<_is.Column> get columns => [
    id,
    typeKey,
    primaryType,
    observationCount,
    firstObservedAt,
    lastObservedAt,
  ];
}

class DiscoveryTypeObservationRowInclude extends _is.IncludeObject {
  DiscoveryTypeObservationRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiscoveryTypeObservationRow.t;
}

class DiscoveryTypeObservationRowIncludeList extends _is.IncludeList {
  DiscoveryTypeObservationRowIncludeList._({
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTypeObservationRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiscoveryTypeObservationRow.t;
}

class DiscoveryTypeObservationRowRepository {
  const DiscoveryTypeObservationRowRepository._();

  /// Returns a list of [DiscoveryTypeObservationRow]s matching the given query parameters.
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
  Future<List<DiscoveryTypeObservationRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTypeObservationRow] matching the given query parameters.
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
  Future<DiscoveryTypeObservationRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTypeObservationRow] by its [id] or null if no such row exists.
  Future<DiscoveryTypeObservationRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTypeObservationRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTypeObservationRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTypeObservationRow]s will have their `id` fields set.
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
  Future<List<DiscoveryTypeObservationRow>> insert(
    _is.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiscoveryTypeObservationRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiscoveryTypeObservationRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTypeObservationRow] will have its `id` field set.
  Future<DiscoveryTypeObservationRow> insertRow(
    _is.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTypeObservationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiscoveryTypeObservationRow]s in the list and returns the resulting rows.
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
  /// The returned [DiscoveryTypeObservationRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeObservationRow>> upsert(
    _is.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    required _is.ColumnSelections<DiscoveryTypeObservationRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryTypeObservationRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiscoveryTypeObservationRow>(
      rows,
      conflictColumns: conflictColumns(DiscoveryTypeObservationRow.t),
      updateColumns: updateColumns?.call(DiscoveryTypeObservationRow.t),
      updateWhere: updateWhere?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiscoveryTypeObservationRow] and returns the resulting row.
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
  /// The returned [DiscoveryTypeObservationRow] will have its `id` field set.
  Future<DiscoveryTypeObservationRow?> upsertRow(
    _is.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    required _is.ColumnSelections<DiscoveryTypeObservationRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryTypeObservationRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiscoveryTypeObservationRow>(
      row,
      conflictColumns: conflictColumns(DiscoveryTypeObservationRow.t),
      updateColumns: updateColumns?.call(DiscoveryTypeObservationRow.t),
      updateWhere: updateWhere?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeObservationRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeObservationRow>> update(
    _is.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _is.ColumnSelections<DiscoveryTypeObservationRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiscoveryTypeObservationRow>(
      rows,
      columns: columns?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiscoveryTypeObservationRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTypeObservationRow> updateRow(
    _is.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _is.ColumnSelections<DiscoveryTypeObservationRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTypeObservationRow>(
      row,
      columns: columns?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeObservationRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTypeObservationRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiscoveryTypeObservationRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTypeObservationRow>(
      id,
      columnValues: columnValues(DiscoveryTypeObservationRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeObservationRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeObservationRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiscoveryTypeObservationRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiscoveryTypeObservationRow>(
      columnValues: columnValues(DiscoveryTypeObservationRow.t.updateTable),
      where: where(DiscoveryTypeObservationRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiscoveryTypeObservationRow]s in the list and returns the deleted rows.
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
  Future<List<DiscoveryTypeObservationRow>> delete(
    _is.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiscoveryTypeObservationRow>(
      rows,
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiscoveryTypeObservationRow].
  Future<DiscoveryTypeObservationRow> deleteRow(
    _is.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTypeObservationRow>(
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
  Future<List<DiscoveryTypeObservationRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    _is.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiscoveryTypeObservationRow>(
      where: where(DiscoveryTypeObservationRow.t),
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTypeObservationRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTypeObservationRow>(
      where: where(DiscoveryTypeObservationRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
