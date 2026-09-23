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

abstract class SwipeRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  SwipeRow._({
    this.id,
    required this.sessionId,
    required this.userId,
    required this.placeId,
    required this.liked,
    required this.swipeIndex,
    required this.clientSwipedAt,
    required this.serverReceivedAt,
    required this.idempotencyKey,
  });

  factory SwipeRow({
    _is.UuidValue? id,
    required String sessionId,
    required String userId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    required DateTime clientSwipedAt,
    required DateTime serverReceivedAt,
    required String idempotencyKey,
  }) = _SwipeRowImpl;

  factory SwipeRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwipeRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      userId: jsonSerialization['userId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      liked: _is.BoolJsonExtension.fromJson(jsonSerialization['liked']),
      swipeIndex: jsonSerialization['swipeIndex'] as int,
      clientSwipedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['clientSwipedAt'],
      ),
      serverReceivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverReceivedAt'],
      ),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
    );
  }

  static final t = SwipeRowTable();

  static const db = SwipeRowRepository._();

  @override
  _is.UuidValue? id;

  String sessionId;

  String userId;

  String placeId;

  bool liked;

  int swipeIndex;

  DateTime clientSwipedAt;

  DateTime serverReceivedAt;

  String idempotencyKey;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SwipeRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SwipeRow copyWith({
    _is.UuidValue? id,
    String? sessionId,
    String? userId,
    String? placeId,
    bool? liked,
    int? swipeIndex,
    DateTime? clientSwipedAt,
    DateTime? serverReceivedAt,
    String? idempotencyKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwipeRow',
      if (id != null) 'id': id?.toJson(),
      'sessionId': sessionId,
      'userId': userId,
      'placeId': placeId,
      'liked': liked,
      'swipeIndex': swipeIndex,
      'clientSwipedAt': clientSwipedAt.toJson(),
      'serverReceivedAt': serverReceivedAt.toJson(),
      'idempotencyKey': idempotencyKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SwipeRowInclude include() {
    return SwipeRowInclude._();
  }

  static SwipeRowIncludeList includeList({
    _is.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    SwipeRowInclude? include,
  }) {
    return SwipeRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwipeRowImpl extends SwipeRow {
  _SwipeRowImpl({
    _is.UuidValue? id,
    required String sessionId,
    required String userId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    required DateTime clientSwipedAt,
    required DateTime serverReceivedAt,
    required String idempotencyKey,
  }) : super._(
         id: id,
         sessionId: sessionId,
         userId: userId,
         placeId: placeId,
         liked: liked,
         swipeIndex: swipeIndex,
         clientSwipedAt: clientSwipedAt,
         serverReceivedAt: serverReceivedAt,
         idempotencyKey: idempotencyKey,
       );

  /// Returns a shallow copy of this [SwipeRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SwipeRow copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? userId,
    String? placeId,
    bool? liked,
    int? swipeIndex,
    DateTime? clientSwipedAt,
    DateTime? serverReceivedAt,
    String? idempotencyKey,
  }) {
    return SwipeRow(
      id: id is _is.UuidValue? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      placeId: placeId ?? this.placeId,
      liked: liked ?? this.liked,
      swipeIndex: swipeIndex ?? this.swipeIndex,
      clientSwipedAt: clientSwipedAt ?? this.clientSwipedAt,
      serverReceivedAt: serverReceivedAt ?? this.serverReceivedAt,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    );
  }
}

class SwipeRowUpdateTable extends _is.UpdateTable<SwipeRowTable> {
  SwipeRowUpdateTable(super.table);

  _is.ColumnValue<String, String> sessionId(String value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> placeId(String value) => _is.ColumnValue(
    table.placeId,
    value,
  );

  _is.ColumnValue<bool, bool> liked(bool value) => _is.ColumnValue(
    table.liked,
    value,
  );

  _is.ColumnValue<int, int> swipeIndex(int value) => _is.ColumnValue(
    table.swipeIndex,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> clientSwipedAt(DateTime value) =>
      _is.ColumnValue(
        table.clientSwipedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> serverReceivedAt(DateTime value) =>
      _is.ColumnValue(
        table.serverReceivedAt,
        value,
      );

  _is.ColumnValue<String, String> idempotencyKey(String value) =>
      _is.ColumnValue(
        table.idempotencyKey,
        value,
      );
}

class SwipeRowTable extends _is.Table<_is.UuidValue?> {
  SwipeRowTable({super.tableRelation}) : super(tableName: 'hayer_swipe') {
    updateTable = SwipeRowUpdateTable(this);
    sessionId = _is.ColumnString(
      'sessionId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    placeId = _is.ColumnString(
      'placeId',
      this,
    );
    liked = _is.ColumnBool(
      'liked',
      this,
    );
    swipeIndex = _is.ColumnInt(
      'swipeIndex',
      this,
    );
    clientSwipedAt = _is.ColumnDateTime(
      'clientSwipedAt',
      this,
    );
    serverReceivedAt = _is.ColumnDateTime(
      'serverReceivedAt',
      this,
    );
    idempotencyKey = _is.ColumnString(
      'idempotencyKey',
      this,
    );
  }

  late final SwipeRowUpdateTable updateTable;

  late final _is.ColumnString sessionId;

  late final _is.ColumnString userId;

  late final _is.ColumnString placeId;

  late final _is.ColumnBool liked;

  late final _is.ColumnInt swipeIndex;

  late final _is.ColumnDateTime clientSwipedAt;

  late final _is.ColumnDateTime serverReceivedAt;

  late final _is.ColumnString idempotencyKey;

  @override
  List<_is.Column> get columns => [
    id,
    sessionId,
    userId,
    placeId,
    liked,
    swipeIndex,
    clientSwipedAt,
    serverReceivedAt,
    idempotencyKey,
  ];
}

class SwipeRowInclude extends _is.IncludeObject {
  SwipeRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => SwipeRow.t;
}

class SwipeRowIncludeList extends _is.IncludeList {
  SwipeRowIncludeList._({
    _is.WhereExpressionBuilder<SwipeRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwipeRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => SwipeRow.t;
}

class SwipeRowRepository {
  const SwipeRowRepository._();

  /// Returns a list of [SwipeRow]s matching the given query parameters.
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
  Future<List<SwipeRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SwipeRow>(
      where: where?.call(SwipeRow.t),
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SwipeRow] matching the given query parameters.
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
  Future<SwipeRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwipeRowTable>? where,
    int? offset,
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SwipeRow>(
      where: where?.call(SwipeRow.t),
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SwipeRow] by its [id] or null if no such row exists.
  Future<SwipeRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SwipeRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SwipeRow]s in the list and returns the inserted rows.
  ///
  /// The returned [SwipeRow]s will have their `id` fields set.
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
  Future<List<SwipeRow>> insert(
    _is.DatabaseSession session,
    List<SwipeRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SwipeRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SwipeRow] and returns the inserted row.
  ///
  /// The returned [SwipeRow] will have its `id` field set.
  Future<SwipeRow> insertRow(
    _is.DatabaseSession session,
    SwipeRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SwipeRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SwipeRow]s in the list and returns the resulting rows.
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
  /// The returned [SwipeRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwipeRow>> upsert(
    _is.DatabaseSession session,
    List<SwipeRow> rows, {
    required _is.ColumnSelections<SwipeRowTable> conflictColumns,
    _is.ColumnSelections<SwipeRowTable>? updateColumns,
    _is.WhereExpressionBuilder<SwipeRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SwipeRow>(
      rows,
      conflictColumns: conflictColumns(SwipeRow.t),
      updateColumns: updateColumns?.call(SwipeRow.t),
      updateWhere: updateWhere?.call(SwipeRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SwipeRow] and returns the resulting row.
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
  /// The returned [SwipeRow] will have its `id` field set.
  Future<SwipeRow?> upsertRow(
    _is.DatabaseSession session,
    SwipeRow row, {
    required _is.ColumnSelections<SwipeRowTable> conflictColumns,
    _is.ColumnSelections<SwipeRowTable>? updateColumns,
    _is.WhereExpressionBuilder<SwipeRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SwipeRow>(
      row,
      conflictColumns: conflictColumns(SwipeRow.t),
      updateColumns: updateColumns?.call(SwipeRow.t),
      updateWhere: updateWhere?.call(SwipeRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [SwipeRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwipeRow>> update(
    _is.DatabaseSession session,
    List<SwipeRow> rows, {
    _is.ColumnSelections<SwipeRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SwipeRow>(
      rows,
      columns: columns?.call(SwipeRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SwipeRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SwipeRow> updateRow(
    _is.DatabaseSession session,
    SwipeRow row, {
    _is.ColumnSelections<SwipeRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SwipeRow>(
      row,
      columns: columns?.call(SwipeRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SwipeRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SwipeRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SwipeRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SwipeRow>(
      id,
      columnValues: columnValues(SwipeRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SwipeRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwipeRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SwipeRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SwipeRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SwipeRow>(
      columnValues: columnValues(SwipeRow.t.updateTable),
      where: where(SwipeRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SwipeRow]s in the list and returns the deleted rows.
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
  Future<List<SwipeRow>> delete(
    _is.DatabaseSession session,
    List<SwipeRow> rows, {
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SwipeRow>(
      rows,
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SwipeRow].
  Future<SwipeRow> deleteRow(
    _is.DatabaseSession session,
    SwipeRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SwipeRow>(
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
  Future<List<SwipeRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwipeRowTable> where,
    _is.OrderByBuilder<SwipeRowTable>? orderBy,
    _is.OrderByListBuilder<SwipeRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SwipeRow>(
      where: where(SwipeRow.t),
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SwipeRow>(
      where: where?.call(SwipeRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwipeRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwipeRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwipeRow>(
      where: where(SwipeRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
