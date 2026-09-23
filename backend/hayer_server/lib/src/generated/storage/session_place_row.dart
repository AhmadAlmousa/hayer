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
import '../place_snapshot.dart' as _iv1jjw8m;

abstract class SessionPlaceRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  SessionPlaceRow._({
    this.id,
    required this.sessionId,
    required this.placeId,
    required this.deckOrder,
    required this.snapshot,
  });

  factory SessionPlaceRow({
    _is.UuidValue? id,
    required String sessionId,
    required String placeId,
    required int deckOrder,
    required _iv1jjw8m.PlaceSnapshot snapshot,
  }) = _SessionPlaceRowImpl;

  factory SessionPlaceRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionPlaceRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      deckOrder: jsonSerialization['deckOrder'] as int,
      snapshot: _i66y2smk.Protocol().deserialize<_iv1jjw8m.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
    );
  }

  static final t = SessionPlaceRowTable();

  static const db = SessionPlaceRowRepository._();

  @override
  _is.UuidValue? id;

  String sessionId;

  String placeId;

  int deckOrder;

  _iv1jjw8m.PlaceSnapshot snapshot;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SessionPlaceRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SessionPlaceRow copyWith({
    _is.UuidValue? id,
    String? sessionId,
    String? placeId,
    int? deckOrder,
    _iv1jjw8m.PlaceSnapshot? snapshot,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SessionPlaceRow',
      if (id != null) 'id': id?.toJson(),
      'sessionId': sessionId,
      'placeId': placeId,
      'deckOrder': deckOrder,
      'snapshot': snapshot.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SessionPlaceRowInclude include() {
    return SessionPlaceRowInclude._();
  }

  static SessionPlaceRowIncludeList includeList({
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    SessionPlaceRowInclude? include,
  }) {
    return SessionPlaceRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionPlaceRowImpl extends SessionPlaceRow {
  _SessionPlaceRowImpl({
    _is.UuidValue? id,
    required String sessionId,
    required String placeId,
    required int deckOrder,
    required _iv1jjw8m.PlaceSnapshot snapshot,
  }) : super._(
         id: id,
         sessionId: sessionId,
         placeId: placeId,
         deckOrder: deckOrder,
         snapshot: snapshot,
       );

  /// Returns a shallow copy of this [SessionPlaceRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SessionPlaceRow copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? placeId,
    int? deckOrder,
    _iv1jjw8m.PlaceSnapshot? snapshot,
  }) {
    return SessionPlaceRow(
      id: id is _is.UuidValue? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      placeId: placeId ?? this.placeId,
      deckOrder: deckOrder ?? this.deckOrder,
      snapshot: snapshot ?? this.snapshot.copyWith(),
    );
  }
}

class SessionPlaceRowUpdateTable extends _is.UpdateTable<SessionPlaceRowTable> {
  SessionPlaceRowUpdateTable(super.table);

  _is.ColumnValue<String, String> sessionId(String value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<String, String> placeId(String value) => _is.ColumnValue(
    table.placeId,
    value,
  );

  _is.ColumnValue<int, int> deckOrder(int value) => _is.ColumnValue(
    table.deckOrder,
    value,
  );

  _is.ColumnValue<_iv1jjw8m.PlaceSnapshot, _iv1jjw8m.PlaceSnapshot> snapshot(
    _iv1jjw8m.PlaceSnapshot value,
  ) => _is.ColumnValue(
    table.snapshot,
    value,
  );
}

class SessionPlaceRowTable extends _is.Table<_is.UuidValue?> {
  SessionPlaceRowTable({super.tableRelation})
    : super(tableName: 'hayer_session_place') {
    updateTable = SessionPlaceRowUpdateTable(this);
    sessionId = _is.ColumnString(
      'sessionId',
      this,
    );
    placeId = _is.ColumnString(
      'placeId',
      this,
    );
    deckOrder = _is.ColumnInt(
      'deckOrder',
      this,
    );
    snapshot = _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot>(
      'snapshot',
      this,
    );
  }

  late final SessionPlaceRowUpdateTable updateTable;

  late final _is.ColumnString sessionId;

  late final _is.ColumnString placeId;

  late final _is.ColumnInt deckOrder;

  late final _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot> snapshot;

  @override
  List<_is.Column> get columns => [
    id,
    sessionId,
    placeId,
    deckOrder,
    snapshot,
  ];
}

class SessionPlaceRowInclude extends _is.IncludeObject {
  SessionPlaceRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => SessionPlaceRow.t;
}

class SessionPlaceRowIncludeList extends _is.IncludeList {
  SessionPlaceRowIncludeList._({
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SessionPlaceRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => SessionPlaceRow.t;
}

class SessionPlaceRowRepository {
  const SessionPlaceRowRepository._();

  /// Returns a list of [SessionPlaceRow]s matching the given query parameters.
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
  Future<List<SessionPlaceRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SessionPlaceRow] matching the given query parameters.
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
  Future<SessionPlaceRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? offset,
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SessionPlaceRow] by its [id] or null if no such row exists.
  Future<SessionPlaceRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SessionPlaceRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SessionPlaceRow]s in the list and returns the inserted rows.
  ///
  /// The returned [SessionPlaceRow]s will have their `id` fields set.
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
  Future<List<SessionPlaceRow>> insert(
    _is.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SessionPlaceRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SessionPlaceRow] and returns the inserted row.
  ///
  /// The returned [SessionPlaceRow] will have its `id` field set.
  Future<SessionPlaceRow> insertRow(
    _is.DatabaseSession session,
    SessionPlaceRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SessionPlaceRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SessionPlaceRow]s in the list and returns the resulting rows.
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
  /// The returned [SessionPlaceRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SessionPlaceRow>> upsert(
    _is.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    required _is.ColumnSelections<SessionPlaceRowTable> conflictColumns,
    _is.ColumnSelections<SessionPlaceRowTable>? updateColumns,
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SessionPlaceRow>(
      rows,
      conflictColumns: conflictColumns(SessionPlaceRow.t),
      updateColumns: updateColumns?.call(SessionPlaceRow.t),
      updateWhere: updateWhere?.call(SessionPlaceRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SessionPlaceRow] and returns the resulting row.
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
  /// The returned [SessionPlaceRow] will have its `id` field set.
  Future<SessionPlaceRow?> upsertRow(
    _is.DatabaseSession session,
    SessionPlaceRow row, {
    required _is.ColumnSelections<SessionPlaceRowTable> conflictColumns,
    _is.ColumnSelections<SessionPlaceRowTable>? updateColumns,
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SessionPlaceRow>(
      row,
      conflictColumns: conflictColumns(SessionPlaceRow.t),
      updateColumns: updateColumns?.call(SessionPlaceRow.t),
      updateWhere: updateWhere?.call(SessionPlaceRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [SessionPlaceRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SessionPlaceRow>> update(
    _is.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _is.ColumnSelections<SessionPlaceRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SessionPlaceRow>(
      rows,
      columns: columns?.call(SessionPlaceRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SessionPlaceRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SessionPlaceRow> updateRow(
    _is.DatabaseSession session,
    SessionPlaceRow row, {
    _is.ColumnSelections<SessionPlaceRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SessionPlaceRow>(
      row,
      columns: columns?.call(SessionPlaceRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SessionPlaceRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SessionPlaceRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<SessionPlaceRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SessionPlaceRow>(
      id,
      columnValues: columnValues(SessionPlaceRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SessionPlaceRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SessionPlaceRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SessionPlaceRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SessionPlaceRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SessionPlaceRow>(
      columnValues: columnValues(SessionPlaceRow.t.updateTable),
      where: where(SessionPlaceRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SessionPlaceRow]s in the list and returns the deleted rows.
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
  Future<List<SessionPlaceRow>> delete(
    _is.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SessionPlaceRow>(
      rows,
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SessionPlaceRow].
  Future<SessionPlaceRow> deleteRow(
    _is.DatabaseSession session,
    SessionPlaceRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SessionPlaceRow>(
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
  Future<List<SessionPlaceRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SessionPlaceRowTable> where,
    _is.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _is.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SessionPlaceRow>(
      where: where(SessionPlaceRow.t),
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SessionPlaceRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SessionPlaceRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SessionPlaceRow>(
      where: where(SessionPlaceRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
