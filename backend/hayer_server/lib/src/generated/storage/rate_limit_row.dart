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

import 'package:serverpod/serverpod.dart' as _i1;

abstract class RateLimitRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  RateLimitRow._({
    this.id,
    required this.counterKey,
    required this.attemptCount,
    required this.windowStartedAt,
    required this.expiresAt,
  });

  factory RateLimitRow({
    _i1.UuidValue? id,
    required String counterKey,
    required int attemptCount,
    required DateTime windowStartedAt,
    required DateTime expiresAt,
  }) = _RateLimitRowImpl;

  factory RateLimitRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return RateLimitRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      counterKey: jsonSerialization['counterKey'] as String,
      attemptCount: jsonSerialization['attemptCount'] as int,
      windowStartedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStartedAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = RateLimitRowTable();

  static const db = RateLimitRowRepository._();

  @override
  _i1.UuidValue? id;

  String counterKey;

  int attemptCount;

  DateTime windowStartedAt;

  DateTime expiresAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [RateLimitRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RateLimitRow copyWith({
    _i1.UuidValue? id,
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
    _i1.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RateLimitRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateLimitRowTable>? orderByList,
    RateLimitRowInclude? include,
  }) {
    return RateLimitRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RateLimitRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RateLimitRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RateLimitRowImpl extends RateLimitRow {
  _RateLimitRowImpl({
    _i1.UuidValue? id,
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
  @_i1.useResult
  @override
  RateLimitRow copyWith({
    Object? id = _Undefined,
    String? counterKey,
    int? attemptCount,
    DateTime? windowStartedAt,
    DateTime? expiresAt,
  }) {
    return RateLimitRow(
      id: id is _i1.UuidValue? ? id : this.id,
      counterKey: counterKey ?? this.counterKey,
      attemptCount: attemptCount ?? this.attemptCount,
      windowStartedAt: windowStartedAt ?? this.windowStartedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class RateLimitRowUpdateTable extends _i1.UpdateTable<RateLimitRowTable> {
  RateLimitRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> counterKey(String value) => _i1.ColumnValue(
    table.counterKey,
    value,
  );

  _i1.ColumnValue<int, int> attemptCount(int value) => _i1.ColumnValue(
    table.attemptCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> windowStartedAt(DateTime value) =>
      _i1.ColumnValue(
        table.windowStartedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class RateLimitRowTable extends _i1.Table<_i1.UuidValue?> {
  RateLimitRowTable({super.tableRelation})
    : super(tableName: 'hayer_rate_limit') {
    updateTable = RateLimitRowUpdateTable(this);
    counterKey = _i1.ColumnString(
      'counterKey',
      this,
    );
    attemptCount = _i1.ColumnInt(
      'attemptCount',
      this,
    );
    windowStartedAt = _i1.ColumnDateTime(
      'windowStartedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final RateLimitRowUpdateTable updateTable;

  late final _i1.ColumnString counterKey;

  late final _i1.ColumnInt attemptCount;

  late final _i1.ColumnDateTime windowStartedAt;

  late final _i1.ColumnDateTime expiresAt;

  @override
  List<_i1.Column> get columns => [
    id,
    counterKey,
    attemptCount,
    windowStartedAt,
    expiresAt,
  ];
}

class RateLimitRowInclude extends _i1.IncludeObject {
  RateLimitRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => RateLimitRow.t;
}

class RateLimitRowIncludeList extends _i1.IncludeList {
  RateLimitRowIncludeList._({
    _i1.WhereExpressionBuilder<RateLimitRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RateLimitRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => RateLimitRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RateLimitRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<RateLimitRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RateLimitRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RateLimitRow] by its [id] or null if no such row exists.
  Future<RateLimitRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<RateLimitRow>> insert(
    _i1.DatabaseSession session,
    List<RateLimitRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RateLimitRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RateLimitRow] and returns the inserted row.
  ///
  /// The returned [RateLimitRow] will have its `id` field set.
  Future<RateLimitRow> insertRow(
    _i1.DatabaseSession session,
    RateLimitRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RateLimitRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RateLimitRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RateLimitRow>> update(
    _i1.DatabaseSession session,
    List<RateLimitRow> rows, {
    _i1.ColumnSelections<RateLimitRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RateLimitRow>(
      rows,
      columns: columns?.call(RateLimitRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RateLimitRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RateLimitRow> updateRow(
    _i1.DatabaseSession session,
    RateLimitRow row, {
    _i1.ColumnSelections<RateLimitRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<RateLimitRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RateLimitRow>(
      id,
      columnValues: columnValues(RateLimitRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RateLimitRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RateLimitRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RateLimitRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RateLimitRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RateLimitRowTable>? orderBy,
    _i1.OrderByListBuilder<RateLimitRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RateLimitRow>(
      columnValues: columnValues(RateLimitRow.t.updateTable),
      where: where(RateLimitRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RateLimitRow.t),
      orderByList: orderByList?.call(RateLimitRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RateLimitRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RateLimitRow>> delete(
    _i1.DatabaseSession session,
    List<RateLimitRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RateLimitRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RateLimitRow].
  Future<RateLimitRow> deleteRow(
    _i1.DatabaseSession session,
    RateLimitRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RateLimitRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RateLimitRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RateLimitRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RateLimitRow>(
      where: where(RateLimitRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RateLimitRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RateLimitRow>(
      where: where?.call(RateLimitRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RateLimitRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RateLimitRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RateLimitRow>(
      where: where(RateLimitRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
