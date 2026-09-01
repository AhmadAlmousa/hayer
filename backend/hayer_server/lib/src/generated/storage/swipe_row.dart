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

abstract class SwipeRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
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
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      userId: jsonSerialization['userId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      liked: _i1.BoolJsonExtension.fromJson(jsonSerialization['liked']),
      swipeIndex: jsonSerialization['swipeIndex'] as int,
      clientSwipedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['clientSwipedAt'],
      ),
      serverReceivedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['serverReceivedAt'],
      ),
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
    );
  }

  static final t = SwipeRowTable();

  static const db = SwipeRowRepository._();

  @override
  _i1.UuidValue? id;

  String sessionId;

  String userId;

  String placeId;

  bool liked;

  int swipeIndex;

  DateTime clientSwipedAt;

  DateTime serverReceivedAt;

  String idempotencyKey;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SwipeRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SwipeRow copyWith({
    _i1.UuidValue? id,
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
    _i1.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwipeRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwipeRowTable>? orderByList,
    SwipeRowInclude? include,
  }) {
    return SwipeRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwipeRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SwipeRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwipeRowImpl extends SwipeRow {
  _SwipeRowImpl({
    _i1.UuidValue? id,
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
  @_i1.useResult
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class SwipeRowUpdateTable extends _i1.UpdateTable<SwipeRowTable> {
  SwipeRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> placeId(String value) => _i1.ColumnValue(
    table.placeId,
    value,
  );

  _i1.ColumnValue<bool, bool> liked(bool value) => _i1.ColumnValue(
    table.liked,
    value,
  );

  _i1.ColumnValue<int, int> swipeIndex(int value) => _i1.ColumnValue(
    table.swipeIndex,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> clientSwipedAt(DateTime value) =>
      _i1.ColumnValue(
        table.clientSwipedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> serverReceivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.serverReceivedAt,
        value,
      );

  _i1.ColumnValue<String, String> idempotencyKey(String value) =>
      _i1.ColumnValue(
        table.idempotencyKey,
        value,
      );
}

class SwipeRowTable extends _i1.Table<_i1.UuidValue?> {
  SwipeRowTable({super.tableRelation}) : super(tableName: 'hayer_swipe') {
    updateTable = SwipeRowUpdateTable(this);
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    placeId = _i1.ColumnString(
      'placeId',
      this,
    );
    liked = _i1.ColumnBool(
      'liked',
      this,
    );
    swipeIndex = _i1.ColumnInt(
      'swipeIndex',
      this,
    );
    clientSwipedAt = _i1.ColumnDateTime(
      'clientSwipedAt',
      this,
    );
    serverReceivedAt = _i1.ColumnDateTime(
      'serverReceivedAt',
      this,
    );
    idempotencyKey = _i1.ColumnString(
      'idempotencyKey',
      this,
    );
  }

  late final SwipeRowUpdateTable updateTable;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString placeId;

  late final _i1.ColumnBool liked;

  late final _i1.ColumnInt swipeIndex;

  late final _i1.ColumnDateTime clientSwipedAt;

  late final _i1.ColumnDateTime serverReceivedAt;

  late final _i1.ColumnString idempotencyKey;

  @override
  List<_i1.Column> get columns => [
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

class SwipeRowInclude extends _i1.IncludeObject {
  SwipeRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SwipeRow.t;
}

class SwipeRowIncludeList extends _i1.IncludeList {
  SwipeRowIncludeList._({
    _i1.WhereExpressionBuilder<SwipeRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwipeRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SwipeRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwipeRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwipeRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SwipeRow>(
      where: where?.call(SwipeRow.t),
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwipeRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<SwipeRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SwipeRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SwipeRow>(
      where: where?.call(SwipeRow.t),
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SwipeRow] by its [id] or null if no such row exists.
  Future<SwipeRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<SwipeRow>> insert(
    _i1.DatabaseSession session,
    List<SwipeRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SwipeRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SwipeRow] and returns the inserted row.
  ///
  /// The returned [SwipeRow] will have its `id` field set.
  Future<SwipeRow> insertRow(
    _i1.DatabaseSession session,
    SwipeRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SwipeRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SwipeRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SwipeRow>> update(
    _i1.DatabaseSession session,
    List<SwipeRow> rows, {
    _i1.ColumnSelections<SwipeRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SwipeRow>(
      rows,
      columns: columns?.call(SwipeRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SwipeRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SwipeRow> updateRow(
    _i1.DatabaseSession session,
    SwipeRow row, {
    _i1.ColumnSelections<SwipeRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SwipeRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SwipeRow>(
      id,
      columnValues: columnValues(SwipeRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SwipeRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SwipeRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SwipeRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SwipeRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SwipeRowTable>? orderBy,
    _i1.OrderByListBuilder<SwipeRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SwipeRow>(
      columnValues: columnValues(SwipeRow.t.updateTable),
      where: where(SwipeRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwipeRow.t),
      orderByList: orderByList?.call(SwipeRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SwipeRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SwipeRow>> delete(
    _i1.DatabaseSession session,
    List<SwipeRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SwipeRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SwipeRow].
  Future<SwipeRow> deleteRow(
    _i1.DatabaseSession session,
    SwipeRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SwipeRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SwipeRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SwipeRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SwipeRow>(
      where: where(SwipeRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SwipeRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SwipeRow>(
      where: where?.call(SwipeRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwipeRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SwipeRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwipeRow>(
      where: where(SwipeRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
