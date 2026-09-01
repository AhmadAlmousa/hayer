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

abstract class IdempotencyRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  IdempotencyRow._({
    this.id,
    required this.scope,
    required this.userId,
    required this.idempotencyKey,
    required this.requestHash,
    required this.responseId,
    required this.createdAt,
    required this.expiresAt,
  });

  factory IdempotencyRow({
    _i1.UuidValue? id,
    required String scope,
    required String userId,
    required String idempotencyKey,
    required String requestHash,
    required String responseId,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _IdempotencyRowImpl;

  factory IdempotencyRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return IdempotencyRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      scope: jsonSerialization['scope'] as String,
      userId: jsonSerialization['userId'] as String,
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      requestHash: jsonSerialization['requestHash'] as String,
      responseId: jsonSerialization['responseId'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = IdempotencyRowTable();

  static const db = IdempotencyRowRepository._();

  @override
  _i1.UuidValue? id;

  String scope;

  String userId;

  String idempotencyKey;

  String requestHash;

  String responseId;

  DateTime createdAt;

  DateTime expiresAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [IdempotencyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IdempotencyRow copyWith({
    _i1.UuidValue? id,
    String? scope,
    String? userId,
    String? idempotencyKey,
    String? requestHash,
    String? responseId,
    DateTime? createdAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IdempotencyRow',
      if (id != null) 'id': id?.toJson(),
      'scope': scope,
      'userId': userId,
      'idempotencyKey': idempotencyKey,
      'requestHash': requestHash,
      'responseId': responseId,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static IdempotencyRowInclude include() {
    return IdempotencyRowInclude._();
  }

  static IdempotencyRowIncludeList includeList({
    _i1.WhereExpressionBuilder<IdempotencyRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IdempotencyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IdempotencyRowTable>? orderByList,
    IdempotencyRowInclude? include,
  }) {
    return IdempotencyRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IdempotencyRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IdempotencyRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IdempotencyRowImpl extends IdempotencyRow {
  _IdempotencyRowImpl({
    _i1.UuidValue? id,
    required String scope,
    required String userId,
    required String idempotencyKey,
    required String requestHash,
    required String responseId,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         scope: scope,
         userId: userId,
         idempotencyKey: idempotencyKey,
         requestHash: requestHash,
         responseId: responseId,
         createdAt: createdAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [IdempotencyRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IdempotencyRow copyWith({
    Object? id = _Undefined,
    String? scope,
    String? userId,
    String? idempotencyKey,
    String? requestHash,
    String? responseId,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return IdempotencyRow(
      id: id is _i1.UuidValue? ? id : this.id,
      scope: scope ?? this.scope,
      userId: userId ?? this.userId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      requestHash: requestHash ?? this.requestHash,
      responseId: responseId ?? this.responseId,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class IdempotencyRowUpdateTable extends _i1.UpdateTable<IdempotencyRowTable> {
  IdempotencyRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> scope(String value) => _i1.ColumnValue(
    table.scope,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> idempotencyKey(String value) =>
      _i1.ColumnValue(
        table.idempotencyKey,
        value,
      );

  _i1.ColumnValue<String, String> requestHash(String value) => _i1.ColumnValue(
    table.requestHash,
    value,
  );

  _i1.ColumnValue<String, String> responseId(String value) => _i1.ColumnValue(
    table.responseId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class IdempotencyRowTable extends _i1.Table<_i1.UuidValue?> {
  IdempotencyRowTable({super.tableRelation})
    : super(tableName: 'hayer_idempotency') {
    updateTable = IdempotencyRowUpdateTable(this);
    scope = _i1.ColumnString(
      'scope',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    idempotencyKey = _i1.ColumnString(
      'idempotencyKey',
      this,
    );
    requestHash = _i1.ColumnString(
      'requestHash',
      this,
    );
    responseId = _i1.ColumnString(
      'responseId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final IdempotencyRowUpdateTable updateTable;

  late final _i1.ColumnString scope;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString idempotencyKey;

  late final _i1.ColumnString requestHash;

  late final _i1.ColumnString responseId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime expiresAt;

  @override
  List<_i1.Column> get columns => [
    id,
    scope,
    userId,
    idempotencyKey,
    requestHash,
    responseId,
    createdAt,
    expiresAt,
  ];
}

class IdempotencyRowInclude extends _i1.IncludeObject {
  IdempotencyRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => IdempotencyRow.t;
}

class IdempotencyRowIncludeList extends _i1.IncludeList {
  IdempotencyRowIncludeList._({
    _i1.WhereExpressionBuilder<IdempotencyRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IdempotencyRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => IdempotencyRow.t;
}

class IdempotencyRowRepository {
  const IdempotencyRowRepository._();

  /// Returns a list of [IdempotencyRow]s matching the given query parameters.
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
  Future<List<IdempotencyRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IdempotencyRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IdempotencyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IdempotencyRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IdempotencyRow>(
      where: where?.call(IdempotencyRow.t),
      orderBy: orderBy?.call(IdempotencyRow.t),
      orderByList: orderByList?.call(IdempotencyRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IdempotencyRow] matching the given query parameters.
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
  Future<IdempotencyRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IdempotencyRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<IdempotencyRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IdempotencyRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IdempotencyRow>(
      where: where?.call(IdempotencyRow.t),
      orderBy: orderBy?.call(IdempotencyRow.t),
      orderByList: orderByList?.call(IdempotencyRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IdempotencyRow] by its [id] or null if no such row exists.
  Future<IdempotencyRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IdempotencyRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IdempotencyRow]s in the list and returns the inserted rows.
  ///
  /// The returned [IdempotencyRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<IdempotencyRow>> insert(
    _i1.DatabaseSession session,
    List<IdempotencyRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<IdempotencyRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [IdempotencyRow] and returns the inserted row.
  ///
  /// The returned [IdempotencyRow] will have its `id` field set.
  Future<IdempotencyRow> insertRow(
    _i1.DatabaseSession session,
    IdempotencyRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IdempotencyRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [IdempotencyRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<IdempotencyRow>> update(
    _i1.DatabaseSession session,
    List<IdempotencyRow> rows, {
    _i1.ColumnSelections<IdempotencyRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IdempotencyRow>(
      rows,
      columns: columns?.call(IdempotencyRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IdempotencyRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IdempotencyRow> updateRow(
    _i1.DatabaseSession session,
    IdempotencyRow row, {
    _i1.ColumnSelections<IdempotencyRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IdempotencyRow>(
      row,
      columns: columns?.call(IdempotencyRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IdempotencyRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IdempotencyRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<IdempotencyRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<IdempotencyRow>(
      id,
      columnValues: columnValues(IdempotencyRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IdempotencyRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<IdempotencyRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<IdempotencyRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<IdempotencyRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IdempotencyRowTable>? orderBy,
    _i1.OrderByListBuilder<IdempotencyRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<IdempotencyRow>(
      columnValues: columnValues(IdempotencyRow.t.updateTable),
      where: where(IdempotencyRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IdempotencyRow.t),
      orderByList: orderByList?.call(IdempotencyRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [IdempotencyRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<IdempotencyRow>> delete(
    _i1.DatabaseSession session,
    List<IdempotencyRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IdempotencyRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [IdempotencyRow].
  Future<IdempotencyRow> deleteRow(
    _i1.DatabaseSession session,
    IdempotencyRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IdempotencyRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<IdempotencyRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IdempotencyRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IdempotencyRow>(
      where: where(IdempotencyRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<IdempotencyRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IdempotencyRow>(
      where: where?.call(IdempotencyRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IdempotencyRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<IdempotencyRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IdempotencyRow>(
      where: where(IdempotencyRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
