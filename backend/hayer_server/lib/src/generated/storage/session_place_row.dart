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
import '../place_snapshot.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class SessionPlaceRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  SessionPlaceRow._({
    this.id,
    required this.sessionId,
    required this.placeId,
    required this.deckOrder,
    required this.snapshot,
  });

  factory SessionPlaceRow({
    _i1.UuidValue? id,
    required String sessionId,
    required String placeId,
    required int deckOrder,
    required _i2.PlaceSnapshot snapshot,
  }) = _SessionPlaceRowImpl;

  factory SessionPlaceRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return SessionPlaceRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      deckOrder: jsonSerialization['deckOrder'] as int,
      snapshot: _i3.Protocol().deserialize<_i2.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
    );
  }

  static final t = SessionPlaceRowTable();

  static const db = SessionPlaceRowRepository._();

  @override
  _i1.UuidValue? id;

  String sessionId;

  String placeId;

  int deckOrder;

  _i2.PlaceSnapshot snapshot;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SessionPlaceRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SessionPlaceRow copyWith({
    _i1.UuidValue? id,
    String? sessionId,
    String? placeId,
    int? deckOrder,
    _i2.PlaceSnapshot? snapshot,
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
    _i1.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    SessionPlaceRowInclude? include,
  }) {
    return SessionPlaceRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SessionPlaceRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SessionPlaceRowImpl extends SessionPlaceRow {
  _SessionPlaceRowImpl({
    _i1.UuidValue? id,
    required String sessionId,
    required String placeId,
    required int deckOrder,
    required _i2.PlaceSnapshot snapshot,
  }) : super._(
         id: id,
         sessionId: sessionId,
         placeId: placeId,
         deckOrder: deckOrder,
         snapshot: snapshot,
       );

  /// Returns a shallow copy of this [SessionPlaceRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SessionPlaceRow copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? placeId,
    int? deckOrder,
    _i2.PlaceSnapshot? snapshot,
  }) {
    return SessionPlaceRow(
      id: id is _i1.UuidValue? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      placeId: placeId ?? this.placeId,
      deckOrder: deckOrder ?? this.deckOrder,
      snapshot: snapshot ?? this.snapshot.copyWith(),
    );
  }
}

class SessionPlaceRowUpdateTable extends _i1.UpdateTable<SessionPlaceRowTable> {
  SessionPlaceRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> placeId(String value) => _i1.ColumnValue(
    table.placeId,
    value,
  );

  _i1.ColumnValue<int, int> deckOrder(int value) => _i1.ColumnValue(
    table.deckOrder,
    value,
  );

  _i1.ColumnValue<_i2.PlaceSnapshot, _i2.PlaceSnapshot> snapshot(
    _i2.PlaceSnapshot value,
  ) => _i1.ColumnValue(
    table.snapshot,
    value,
  );
}

class SessionPlaceRowTable extends _i1.Table<_i1.UuidValue?> {
  SessionPlaceRowTable({super.tableRelation})
    : super(tableName: 'hayer_session_place') {
    updateTable = SessionPlaceRowUpdateTable(this);
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    placeId = _i1.ColumnString(
      'placeId',
      this,
    );
    deckOrder = _i1.ColumnInt(
      'deckOrder',
      this,
    );
    snapshot = _i1.ColumnSerializable<_i2.PlaceSnapshot>(
      'snapshot',
      this,
    );
  }

  late final SessionPlaceRowUpdateTable updateTable;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString placeId;

  late final _i1.ColumnInt deckOrder;

  late final _i1.ColumnSerializable<_i2.PlaceSnapshot> snapshot;

  @override
  List<_i1.Column> get columns => [
    id,
    sessionId,
    placeId,
    deckOrder,
    snapshot,
  ];
}

class SessionPlaceRowInclude extends _i1.IncludeObject {
  SessionPlaceRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SessionPlaceRow.t;
}

class SessionPlaceRowIncludeList extends _i1.IncludeList {
  SessionPlaceRowIncludeList._({
    _i1.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SessionPlaceRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SessionPlaceRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SessionPlaceRow] by its [id] or null if no such row exists.
  Future<SessionPlaceRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<SessionPlaceRow>> insert(
    _i1.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SessionPlaceRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SessionPlaceRow] and returns the inserted row.
  ///
  /// The returned [SessionPlaceRow] will have its `id` field set.
  Future<SessionPlaceRow> insertRow(
    _i1.DatabaseSession session,
    SessionPlaceRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SessionPlaceRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SessionPlaceRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SessionPlaceRow>> update(
    _i1.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _i1.ColumnSelections<SessionPlaceRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SessionPlaceRow>(
      rows,
      columns: columns?.call(SessionPlaceRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SessionPlaceRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SessionPlaceRow> updateRow(
    _i1.DatabaseSession session,
    SessionPlaceRow row, {
    _i1.ColumnSelections<SessionPlaceRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SessionPlaceRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SessionPlaceRow>(
      id,
      columnValues: columnValues(SessionPlaceRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SessionPlaceRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SessionPlaceRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SessionPlaceRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SessionPlaceRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SessionPlaceRowTable>? orderBy,
    _i1.OrderByListBuilder<SessionPlaceRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SessionPlaceRow>(
      columnValues: columnValues(SessionPlaceRow.t.updateTable),
      where: where(SessionPlaceRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SessionPlaceRow.t),
      orderByList: orderByList?.call(SessionPlaceRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SessionPlaceRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SessionPlaceRow>> delete(
    _i1.DatabaseSession session,
    List<SessionPlaceRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SessionPlaceRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SessionPlaceRow].
  Future<SessionPlaceRow> deleteRow(
    _i1.DatabaseSession session,
    SessionPlaceRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SessionPlaceRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SessionPlaceRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SessionPlaceRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SessionPlaceRow>(
      where: where(SessionPlaceRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SessionPlaceRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SessionPlaceRow>(
      where: where?.call(SessionPlaceRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SessionPlaceRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SessionPlaceRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SessionPlaceRow>(
      where: where(SessionPlaceRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
