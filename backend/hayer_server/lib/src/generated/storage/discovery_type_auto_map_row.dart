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

/// What the Discover type auto-mapper has assigned, so an operator can see
/// which aliases the mapper chose rather than a person, and move the ones it
/// got wrong. One row per observed type; a later run overwrites its own row.
abstract class DiscoveryTypeAutoMapRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DiscoveryTypeAutoMapRow._({
    this.id,
    required this.typeKey,
    required this.primaryType,
    required this.nodeId,
    required this.rule,
    required this.mappedAt,
  });

  factory DiscoveryTypeAutoMapRow({
    int? id,
    required String typeKey,
    required String primaryType,
    required String nodeId,
    required String rule,
    required DateTime mappedAt,
  }) = _DiscoveryTypeAutoMapRowImpl;

  factory DiscoveryTypeAutoMapRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTypeAutoMapRow(
      id: jsonSerialization['id'] as int?,
      typeKey: jsonSerialization['typeKey'] as String,
      primaryType: jsonSerialization['primaryType'] as String,
      nodeId: jsonSerialization['nodeId'] as String,
      rule: jsonSerialization['rule'] as String,
      mappedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['mappedAt'],
      ),
    );
  }

  static final t = DiscoveryTypeAutoMapRowTable();

  static const db = DiscoveryTypeAutoMapRowRepository._();

  @override
  int? id;

  String typeKey;

  String primaryType;

  String nodeId;

  String rule;

  DateTime mappedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTypeAutoMapRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryTypeAutoMapRow copyWith({
    int? id,
    String? typeKey,
    String? primaryType,
    String? nodeId,
    String? rule,
    DateTime? mappedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTypeAutoMapRow',
      if (id != null) 'id': id,
      'typeKey': typeKey,
      'primaryType': primaryType,
      'nodeId': nodeId,
      'rule': rule,
      'mappedAt': mappedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryTypeAutoMapRowInclude include() {
    return DiscoveryTypeAutoMapRowInclude._();
  }

  static DiscoveryTypeAutoMapRowIncludeList includeList({
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    DiscoveryTypeAutoMapRowInclude? include,
  }) {
    return DiscoveryTypeAutoMapRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTypeAutoMapRowImpl extends DiscoveryTypeAutoMapRow {
  _DiscoveryTypeAutoMapRowImpl({
    int? id,
    required String typeKey,
    required String primaryType,
    required String nodeId,
    required String rule,
    required DateTime mappedAt,
  }) : super._(
         id: id,
         typeKey: typeKey,
         primaryType: primaryType,
         nodeId: nodeId,
         rule: rule,
         mappedAt: mappedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTypeAutoMapRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryTypeAutoMapRow copyWith({
    Object? id = _Undefined,
    String? typeKey,
    String? primaryType,
    String? nodeId,
    String? rule,
    DateTime? mappedAt,
  }) {
    return DiscoveryTypeAutoMapRow(
      id: id is int? ? id : this.id,
      typeKey: typeKey ?? this.typeKey,
      primaryType: primaryType ?? this.primaryType,
      nodeId: nodeId ?? this.nodeId,
      rule: rule ?? this.rule,
      mappedAt: mappedAt ?? this.mappedAt,
    );
  }
}

class DiscoveryTypeAutoMapRowUpdateTable
    extends _is.UpdateTable<DiscoveryTypeAutoMapRowTable> {
  DiscoveryTypeAutoMapRowUpdateTable(super.table);

  _is.ColumnValue<String, String> typeKey(String value) => _is.ColumnValue(
    table.typeKey,
    value,
  );

  _is.ColumnValue<String, String> primaryType(String value) => _is.ColumnValue(
    table.primaryType,
    value,
  );

  _is.ColumnValue<String, String> nodeId(String value) => _is.ColumnValue(
    table.nodeId,
    value,
  );

  _is.ColumnValue<String, String> rule(String value) => _is.ColumnValue(
    table.rule,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> mappedAt(DateTime value) =>
      _is.ColumnValue(
        table.mappedAt,
        value,
      );
}

class DiscoveryTypeAutoMapRowTable extends _is.Table<int?> {
  DiscoveryTypeAutoMapRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_type_automap') {
    updateTable = DiscoveryTypeAutoMapRowUpdateTable(this);
    typeKey = _is.ColumnString(
      'typeKey',
      this,
    );
    primaryType = _is.ColumnString(
      'primaryType',
      this,
    );
    nodeId = _is.ColumnString(
      'nodeId',
      this,
    );
    rule = _is.ColumnString(
      'rule',
      this,
    );
    mappedAt = _is.ColumnDateTime(
      'mappedAt',
      this,
    );
  }

  late final DiscoveryTypeAutoMapRowUpdateTable updateTable;

  late final _is.ColumnString typeKey;

  late final _is.ColumnString primaryType;

  late final _is.ColumnString nodeId;

  late final _is.ColumnString rule;

  late final _is.ColumnDateTime mappedAt;

  @override
  List<_is.Column> get columns => [
    id,
    typeKey,
    primaryType,
    nodeId,
    rule,
    mappedAt,
  ];
}

class DiscoveryTypeAutoMapRowInclude extends _is.IncludeObject {
  DiscoveryTypeAutoMapRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiscoveryTypeAutoMapRow.t;
}

class DiscoveryTypeAutoMapRowIncludeList extends _is.IncludeList {
  DiscoveryTypeAutoMapRowIncludeList._({
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTypeAutoMapRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiscoveryTypeAutoMapRow.t;
}

class DiscoveryTypeAutoMapRowRepository {
  const DiscoveryTypeAutoMapRowRepository._();

  /// Returns a list of [DiscoveryTypeAutoMapRow]s matching the given query parameters.
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
  Future<List<DiscoveryTypeAutoMapRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTypeAutoMapRow] matching the given query parameters.
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
  Future<DiscoveryTypeAutoMapRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTypeAutoMapRow] by its [id] or null if no such row exists.
  Future<DiscoveryTypeAutoMapRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTypeAutoMapRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTypeAutoMapRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTypeAutoMapRow]s will have their `id` fields set.
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
  Future<List<DiscoveryTypeAutoMapRow>> insert(
    _is.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiscoveryTypeAutoMapRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiscoveryTypeAutoMapRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTypeAutoMapRow] will have its `id` field set.
  Future<DiscoveryTypeAutoMapRow> insertRow(
    _is.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTypeAutoMapRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiscoveryTypeAutoMapRow]s in the list and returns the resulting rows.
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
  /// The returned [DiscoveryTypeAutoMapRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeAutoMapRow>> upsert(
    _is.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    required _is.ColumnSelections<DiscoveryTypeAutoMapRowTable> conflictColumns,
    _is.ColumnSelections<DiscoveryTypeAutoMapRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiscoveryTypeAutoMapRow>(
      rows,
      conflictColumns: conflictColumns(DiscoveryTypeAutoMapRow.t),
      updateColumns: updateColumns?.call(DiscoveryTypeAutoMapRow.t),
      updateWhere: updateWhere?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiscoveryTypeAutoMapRow] and returns the resulting row.
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
  /// The returned [DiscoveryTypeAutoMapRow] will have its `id` field set.
  Future<DiscoveryTypeAutoMapRow?> upsertRow(
    _is.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    required _is.ColumnSelections<DiscoveryTypeAutoMapRowTable> conflictColumns,
    _is.ColumnSelections<DiscoveryTypeAutoMapRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiscoveryTypeAutoMapRow>(
      row,
      conflictColumns: conflictColumns(DiscoveryTypeAutoMapRow.t),
      updateColumns: updateColumns?.call(DiscoveryTypeAutoMapRow.t),
      updateWhere: updateWhere?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeAutoMapRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeAutoMapRow>> update(
    _is.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _is.ColumnSelections<DiscoveryTypeAutoMapRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiscoveryTypeAutoMapRow>(
      rows,
      columns: columns?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiscoveryTypeAutoMapRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTypeAutoMapRow> updateRow(
    _is.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _is.ColumnSelections<DiscoveryTypeAutoMapRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTypeAutoMapRow>(
      row,
      columns: columns?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeAutoMapRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTypeAutoMapRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiscoveryTypeAutoMapRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTypeAutoMapRow>(
      id,
      columnValues: columnValues(DiscoveryTypeAutoMapRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeAutoMapRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryTypeAutoMapRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiscoveryTypeAutoMapRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiscoveryTypeAutoMapRow>(
      columnValues: columnValues(DiscoveryTypeAutoMapRow.t.updateTable),
      where: where(DiscoveryTypeAutoMapRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiscoveryTypeAutoMapRow]s in the list and returns the deleted rows.
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
  Future<List<DiscoveryTypeAutoMapRow>> delete(
    _is.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiscoveryTypeAutoMapRow>(
      rows,
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiscoveryTypeAutoMapRow].
  Future<DiscoveryTypeAutoMapRow> deleteRow(
    _is.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTypeAutoMapRow>(
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
  Future<List<DiscoveryTypeAutoMapRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    _is.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiscoveryTypeAutoMapRow>(
      where: where(DiscoveryTypeAutoMapRow.t),
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTypeAutoMapRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTypeAutoMapRow>(
      where: where(DiscoveryTypeAutoMapRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
