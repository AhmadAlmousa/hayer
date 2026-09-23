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

abstract class PoiCategoryRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  PoiCategoryRow._({
    this.id,
    required this.provider,
    required this.providerPlaceId,
    required this.categoryId,
    required this.evidenceQuery,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });

  factory PoiCategoryRow({
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) = _PoiCategoryRowImpl;

  factory PoiCategoryRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiCategoryRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
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

  static final t = PoiCategoryRowTable();

  static const db = PoiCategoryRowRepository._();

  @override
  _is.UuidValue? id;

  String provider;

  String providerPlaceId;

  String categoryId;

  String evidenceQuery;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCategoryRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiCategoryRow copyWith({
    _is.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiCategoryRow',
      if (id != null) 'id': id?.toJson(),
      'provider': provider,
      'providerPlaceId': providerPlaceId,
      'categoryId': categoryId,
      'evidenceQuery': evidenceQuery,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiCategoryRowInclude include() {
    return PoiCategoryRowInclude._();
  }

  static PoiCategoryRowIncludeList includeList({
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    PoiCategoryRowInclude? include,
  }) {
    return PoiCategoryRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCategoryRowImpl extends PoiCategoryRow {
  _PoiCategoryRowImpl({
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         provider: provider,
         providerPlaceId: providerPlaceId,
         categoryId: categoryId,
         evidenceQuery: evidenceQuery,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [PoiCategoryRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PoiCategoryRow copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerPlaceId,
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  }) {
    return PoiCategoryRow(
      id: id is _is.UuidValue? ? id : this.id,
      provider: provider ?? this.provider,
      providerPlaceId: providerPlaceId ?? this.providerPlaceId,
      categoryId: categoryId ?? this.categoryId,
      evidenceQuery: evidenceQuery ?? this.evidenceQuery,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

class PoiCategoryRowUpdateTable extends _is.UpdateTable<PoiCategoryRowTable> {
  PoiCategoryRowUpdateTable(super.table);

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> providerPlaceId(String value) =>
      _is.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _is.ColumnValue<String, String> categoryId(String value) => _is.ColumnValue(
    table.categoryId,
    value,
  );

  _is.ColumnValue<String, String> evidenceQuery(String value) =>
      _is.ColumnValue(
        table.evidenceQuery,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> firstSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.firstSeenAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class PoiCategoryRowTable extends _is.Table<_is.UuidValue?> {
  PoiCategoryRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_category') {
    updateTable = PoiCategoryRowUpdateTable(this);
    provider = _is.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _is.ColumnString(
      'providerPlaceId',
      this,
    );
    categoryId = _is.ColumnString(
      'categoryId',
      this,
    );
    evidenceQuery = _is.ColumnString(
      'evidenceQuery',
      this,
    );
    firstSeenAt = _is.ColumnDateTime(
      'firstSeenAt',
      this,
    );
    lastSeenAt = _is.ColumnDateTime(
      'lastSeenAt',
      this,
    );
  }

  late final PoiCategoryRowUpdateTable updateTable;

  late final _is.ColumnString provider;

  late final _is.ColumnString providerPlaceId;

  late final _is.ColumnString categoryId;

  late final _is.ColumnString evidenceQuery;

  late final _is.ColumnDateTime firstSeenAt;

  late final _is.ColumnDateTime lastSeenAt;

  @override
  List<_is.Column> get columns => [
    id,
    provider,
    providerPlaceId,
    categoryId,
    evidenceQuery,
    firstSeenAt,
    lastSeenAt,
  ];
}

class PoiCategoryRowInclude extends _is.IncludeObject {
  PoiCategoryRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCategoryRow.t;
}

class PoiCategoryRowIncludeList extends _is.IncludeList {
  PoiCategoryRowIncludeList._({
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCategoryRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCategoryRow.t;
}

class PoiCategoryRowRepository {
  const PoiCategoryRowRepository._();

  /// Returns a list of [PoiCategoryRow]s matching the given query parameters.
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
  Future<List<PoiCategoryRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiCategoryRow] matching the given query parameters.
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
  Future<PoiCategoryRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCategoryRow] by its [id] or null if no such row exists.
  Future<PoiCategoryRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiCategoryRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiCategoryRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiCategoryRow]s will have their `id` fields set.
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
  Future<List<PoiCategoryRow>> insert(
    _is.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoiCategoryRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoiCategoryRow] and returns the inserted row.
  ///
  /// The returned [PoiCategoryRow] will have its `id` field set.
  Future<PoiCategoryRow> insertRow(
    _is.DatabaseSession session,
    PoiCategoryRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCategoryRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoiCategoryRow]s in the list and returns the resulting rows.
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
  /// The returned [PoiCategoryRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCategoryRow>> upsert(
    _is.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    required _is.ColumnSelections<PoiCategoryRowTable> conflictColumns,
    _is.ColumnSelections<PoiCategoryRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoiCategoryRow>(
      rows,
      conflictColumns: conflictColumns(PoiCategoryRow.t),
      updateColumns: updateColumns?.call(PoiCategoryRow.t),
      updateWhere: updateWhere?.call(PoiCategoryRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoiCategoryRow] and returns the resulting row.
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
  /// The returned [PoiCategoryRow] will have its `id` field set.
  Future<PoiCategoryRow?> upsertRow(
    _is.DatabaseSession session,
    PoiCategoryRow row, {
    required _is.ColumnSelections<PoiCategoryRowTable> conflictColumns,
    _is.ColumnSelections<PoiCategoryRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoiCategoryRow>(
      row,
      conflictColumns: conflictColumns(PoiCategoryRow.t),
      updateColumns: updateColumns?.call(PoiCategoryRow.t),
      updateWhere: updateWhere?.call(PoiCategoryRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCategoryRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCategoryRow>> update(
    _is.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _is.ColumnSelections<PoiCategoryRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoiCategoryRow>(
      rows,
      columns: columns?.call(PoiCategoryRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoiCategoryRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCategoryRow> updateRow(
    _is.DatabaseSession session,
    PoiCategoryRow row, {
    _is.ColumnSelections<PoiCategoryRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiCategoryRow>(
      row,
      columns: columns?.call(PoiCategoryRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCategoryRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiCategoryRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PoiCategoryRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCategoryRow>(
      id,
      columnValues: columnValues(PoiCategoryRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCategoryRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCategoryRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoiCategoryRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PoiCategoryRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoiCategoryRow>(
      columnValues: columnValues(PoiCategoryRow.t.updateTable),
      where: where(PoiCategoryRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoiCategoryRow]s in the list and returns the deleted rows.
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
  Future<List<PoiCategoryRow>> delete(
    _is.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoiCategoryRow>(
      rows,
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoiCategoryRow].
  Future<PoiCategoryRow> deleteRow(
    _is.DatabaseSession session,
    PoiCategoryRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCategoryRow>(
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
  Future<List<PoiCategoryRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCategoryRowTable> where,
    _is.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoiCategoryRow>(
      where: where(PoiCategoryRow.t),
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCategoryRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCategoryRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCategoryRow>(
      where: where(PoiCategoryRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
