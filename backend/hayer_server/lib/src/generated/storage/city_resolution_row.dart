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

abstract class CityResolutionRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CityResolutionRow._({
    this.id,
    required this.cellKey,
    required this.countryCode,
    required this.cityKey,
    required this.cityName,
    this.regionName,
    required this.resolvedAt,
    required this.expiresAt,
  });

  factory CityResolutionRow({
    int? id,
    required String cellKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    String? regionName,
    required DateTime resolvedAt,
    required DateTime expiresAt,
  }) = _CityResolutionRowImpl;

  factory CityResolutionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityResolutionRow(
      id: jsonSerialization['id'] as int?,
      cellKey: jsonSerialization['cellKey'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      cityKey: jsonSerialization['cityKey'] as String,
      cityName: jsonSerialization['cityName'] as String,
      regionName: jsonSerialization['regionName'] as String?,
      resolvedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['resolvedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = CityResolutionRowTable();

  static const db = CityResolutionRowRepository._();

  @override
  int? id;

  String cellKey;

  String countryCode;

  String cityKey;

  String cityName;

  String? regionName;

  DateTime resolvedAt;

  DateTime expiresAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CityResolutionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CityResolutionRow copyWith({
    int? id,
    String? cellKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    String? regionName,
    DateTime? resolvedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityResolutionRow',
      if (id != null) 'id': id,
      'cellKey': cellKey,
      'countryCode': countryCode,
      'cityKey': cityKey,
      'cityName': cityName,
      if (regionName != null) 'regionName': regionName,
      'resolvedAt': resolvedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CityResolutionRowInclude include() {
    return CityResolutionRowInclude._();
  }

  static CityResolutionRowIncludeList includeList({
    _is.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    CityResolutionRowInclude? include,
  }) {
    return CityResolutionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityResolutionRowImpl extends CityResolutionRow {
  _CityResolutionRowImpl({
    int? id,
    required String cellKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    String? regionName,
    required DateTime resolvedAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         cellKey: cellKey,
         countryCode: countryCode,
         cityKey: cityKey,
         cityName: cityName,
         regionName: regionName,
         resolvedAt: resolvedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [CityResolutionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CityResolutionRow copyWith({
    Object? id = _Undefined,
    String? cellKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    Object? regionName = _Undefined,
    DateTime? resolvedAt,
    DateTime? expiresAt,
  }) {
    return CityResolutionRow(
      id: id is int? ? id : this.id,
      cellKey: cellKey ?? this.cellKey,
      countryCode: countryCode ?? this.countryCode,
      cityKey: cityKey ?? this.cityKey,
      cityName: cityName ?? this.cityName,
      regionName: regionName is String? ? regionName : this.regionName,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class CityResolutionRowUpdateTable
    extends _is.UpdateTable<CityResolutionRowTable> {
  CityResolutionRowUpdateTable(super.table);

  _is.ColumnValue<String, String> cellKey(String value) => _is.ColumnValue(
    table.cellKey,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<String, String> cityKey(String value) => _is.ColumnValue(
    table.cityKey,
    value,
  );

  _is.ColumnValue<String, String> cityName(String value) => _is.ColumnValue(
    table.cityName,
    value,
  );

  _is.ColumnValue<String, String> regionName(String? value) => _is.ColumnValue(
    table.regionName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class CityResolutionRowTable extends _is.Table<int?> {
  CityResolutionRowTable({super.tableRelation})
    : super(tableName: 'hayer_city_resolution') {
    updateTable = CityResolutionRowUpdateTable(this);
    cellKey = _is.ColumnString(
      'cellKey',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    cityKey = _is.ColumnString(
      'cityKey',
      this,
    );
    cityName = _is.ColumnString(
      'cityName',
      this,
    );
    regionName = _is.ColumnString(
      'regionName',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final CityResolutionRowUpdateTable updateTable;

  late final _is.ColumnString cellKey;

  late final _is.ColumnString countryCode;

  late final _is.ColumnString cityKey;

  late final _is.ColumnString cityName;

  late final _is.ColumnString regionName;

  late final _is.ColumnDateTime resolvedAt;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
    id,
    cellKey,
    countryCode,
    cityKey,
    cityName,
    regionName,
    resolvedAt,
    expiresAt,
  ];
}

class CityResolutionRowInclude extends _is.IncludeObject {
  CityResolutionRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CityResolutionRow.t;
}

class CityResolutionRowIncludeList extends _is.IncludeList {
  CityResolutionRowIncludeList._({
    _is.WhereExpressionBuilder<CityResolutionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CityResolutionRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CityResolutionRow.t;
}

class CityResolutionRowRepository {
  const CityResolutionRowRepository._();

  /// Returns a list of [CityResolutionRow]s matching the given query parameters.
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
  Future<List<CityResolutionRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CityResolutionRow] matching the given query parameters.
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
  Future<CityResolutionRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? offset,
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CityResolutionRow] by its [id] or null if no such row exists.
  Future<CityResolutionRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CityResolutionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CityResolutionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CityResolutionRow]s will have their `id` fields set.
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
  Future<List<CityResolutionRow>> insert(
    _is.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CityResolutionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CityResolutionRow] and returns the inserted row.
  ///
  /// The returned [CityResolutionRow] will have its `id` field set.
  Future<CityResolutionRow> insertRow(
    _is.DatabaseSession session,
    CityResolutionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CityResolutionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CityResolutionRow]s in the list and returns the resulting rows.
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
  /// The returned [CityResolutionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityResolutionRow>> upsert(
    _is.DatabaseSession session,
    List<CityResolutionRow> rows, {
    required _is.ColumnSelections<CityResolutionRowTable> conflictColumns,
    _is.ColumnSelections<CityResolutionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CityResolutionRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CityResolutionRow>(
      rows,
      conflictColumns: conflictColumns(CityResolutionRow.t),
      updateColumns: updateColumns?.call(CityResolutionRow.t),
      updateWhere: updateWhere?.call(CityResolutionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CityResolutionRow] and returns the resulting row.
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
  /// The returned [CityResolutionRow] will have its `id` field set.
  Future<CityResolutionRow?> upsertRow(
    _is.DatabaseSession session,
    CityResolutionRow row, {
    required _is.ColumnSelections<CityResolutionRowTable> conflictColumns,
    _is.ColumnSelections<CityResolutionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CityResolutionRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CityResolutionRow>(
      row,
      conflictColumns: conflictColumns(CityResolutionRow.t),
      updateColumns: updateColumns?.call(CityResolutionRow.t),
      updateWhere: updateWhere?.call(CityResolutionRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [CityResolutionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityResolutionRow>> update(
    _is.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _is.ColumnSelections<CityResolutionRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CityResolutionRow>(
      rows,
      columns: columns?.call(CityResolutionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CityResolutionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CityResolutionRow> updateRow(
    _is.DatabaseSession session,
    CityResolutionRow row, {
    _is.ColumnSelections<CityResolutionRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CityResolutionRow>(
      row,
      columns: columns?.call(CityResolutionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CityResolutionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CityResolutionRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CityResolutionRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CityResolutionRow>(
      id,
      columnValues: columnValues(CityResolutionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CityResolutionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CityResolutionRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CityResolutionRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CityResolutionRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CityResolutionRow>(
      columnValues: columnValues(CityResolutionRow.t.updateTable),
      where: where(CityResolutionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CityResolutionRow]s in the list and returns the deleted rows.
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
  Future<List<CityResolutionRow>> delete(
    _is.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CityResolutionRow>(
      rows,
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CityResolutionRow].
  Future<CityResolutionRow> deleteRow(
    _is.DatabaseSession session,
    CityResolutionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CityResolutionRow>(
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
  Future<List<CityResolutionRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityResolutionRowTable> where,
    _is.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _is.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CityResolutionRow>(
      where: where(CityResolutionRow.t),
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CityResolutionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CityResolutionRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CityResolutionRow>(
      where: where(CityResolutionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
