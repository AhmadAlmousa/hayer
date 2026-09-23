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
import '../job_status.dart' as _ik61uby8;

abstract class RefreshJobRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  RefreshJobRow._({
    this.id,
    required this.jobId,
    required this.coverageKey,
    required this.status,
    required this.requestedBy,
    required this.reason,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.errorCode,
    this.planJson,
    this.heartbeatAt,
  });

  factory RefreshJobRow({
    _is.UuidValue? id,
    required String jobId,
    required String coverageKey,
    required _ik61uby8.JobStatus status,
    required String requestedBy,
    required String reason,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
    String? planJson,
    DateTime? heartbeatAt,
  }) = _RefreshJobRowImpl;

  factory RefreshJobRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return RefreshJobRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      jobId: jsonSerialization['jobId'] as String,
      coverageKey: jsonSerialization['coverageKey'] as String,
      status: _ik61uby8.JobStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      requestedBy: jsonSerialization['requestedBy'] as String,
      reason: jsonSerialization['reason'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      errorCode: jsonSerialization['errorCode'] as String?,
      planJson: jsonSerialization['planJson'] as String?,
      heartbeatAt: jsonSerialization['heartbeatAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['heartbeatAt'],
            ),
    );
  }

  static final t = RefreshJobRowTable();

  static const db = RefreshJobRowRepository._();

  @override
  _is.UuidValue? id;

  String jobId;

  String coverageKey;

  _ik61uby8.JobStatus status;

  String requestedBy;

  String reason;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  String? errorCode;

  String? planJson;

  DateTime? heartbeatAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [RefreshJobRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RefreshJobRow copyWith({
    _is.UuidValue? id,
    String? jobId,
    String? coverageKey,
    _ik61uby8.JobStatus? status,
    String? requestedBy,
    String? reason,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
    String? planJson,
    DateTime? heartbeatAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RefreshJobRow',
      if (id != null) 'id': id?.toJson(),
      'jobId': jobId,
      'coverageKey': coverageKey,
      'status': status.toJson(),
      'requestedBy': requestedBy,
      'reason': reason,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (errorCode != null) 'errorCode': errorCode,
      if (planJson != null) 'planJson': planJson,
      if (heartbeatAt != null) 'heartbeatAt': heartbeatAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static RefreshJobRowInclude include() {
    return RefreshJobRowInclude._();
  }

  static RefreshJobRowIncludeList includeList({
    _is.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    RefreshJobRowInclude? include,
  }) {
    return RefreshJobRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RefreshJobRowImpl extends RefreshJobRow {
  _RefreshJobRowImpl({
    _is.UuidValue? id,
    required String jobId,
    required String coverageKey,
    required _ik61uby8.JobStatus status,
    required String requestedBy,
    required String reason,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? errorCode,
    String? planJson,
    DateTime? heartbeatAt,
  }) : super._(
         id: id,
         jobId: jobId,
         coverageKey: coverageKey,
         status: status,
         requestedBy: requestedBy,
         reason: reason,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
         errorCode: errorCode,
         planJson: planJson,
         heartbeatAt: heartbeatAt,
       );

  /// Returns a shallow copy of this [RefreshJobRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RefreshJobRow copyWith({
    Object? id = _Undefined,
    String? jobId,
    String? coverageKey,
    _ik61uby8.JobStatus? status,
    String? requestedBy,
    String? reason,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? errorCode = _Undefined,
    Object? planJson = _Undefined,
    Object? heartbeatAt = _Undefined,
  }) {
    return RefreshJobRow(
      id: id is _is.UuidValue? ? id : this.id,
      jobId: jobId ?? this.jobId,
      coverageKey: coverageKey ?? this.coverageKey,
      status: status ?? this.status,
      requestedBy: requestedBy ?? this.requestedBy,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      errorCode: errorCode is String? ? errorCode : this.errorCode,
      planJson: planJson is String? ? planJson : this.planJson,
      heartbeatAt: heartbeatAt is DateTime? ? heartbeatAt : this.heartbeatAt,
    );
  }
}

class RefreshJobRowUpdateTable extends _is.UpdateTable<RefreshJobRowTable> {
  RefreshJobRowUpdateTable(super.table);

  _is.ColumnValue<String, String> jobId(String value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<String, String> coverageKey(String value) => _is.ColumnValue(
    table.coverageKey,
    value,
  );

  _is.ColumnValue<_ik61uby8.JobStatus, _ik61uby8.JobStatus> status(
    _ik61uby8.JobStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> requestedBy(String value) => _is.ColumnValue(
    table.requestedBy,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<String, String> errorCode(String? value) => _is.ColumnValue(
    table.errorCode,
    value,
  );

  _is.ColumnValue<String, String> planJson(String? value) => _is.ColumnValue(
    table.planJson,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> heartbeatAt(DateTime? value) =>
      _is.ColumnValue(
        table.heartbeatAt,
        value,
      );
}

class RefreshJobRowTable extends _is.Table<_is.UuidValue?> {
  RefreshJobRowTable({super.tableRelation})
    : super(tableName: 'hayer_refresh_job') {
    updateTable = RefreshJobRowUpdateTable(this);
    jobId = _is.ColumnString(
      'jobId',
      this,
    );
    coverageKey = _is.ColumnString(
      'coverageKey',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    requestedBy = _is.ColumnString(
      'requestedBy',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    errorCode = _is.ColumnString(
      'errorCode',
      this,
    );
    planJson = _is.ColumnString(
      'planJson',
      this,
    );
    heartbeatAt = _is.ColumnDateTime(
      'heartbeatAt',
      this,
    );
  }

  late final RefreshJobRowUpdateTable updateTable;

  late final _is.ColumnString jobId;

  late final _is.ColumnString coverageKey;

  late final _is.ColumnEnum<_ik61uby8.JobStatus> status;

  late final _is.ColumnString requestedBy;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnString errorCode;

  late final _is.ColumnString planJson;

  late final _is.ColumnDateTime heartbeatAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    coverageKey,
    status,
    requestedBy,
    reason,
    createdAt,
    startedAt,
    completedAt,
    errorCode,
    planJson,
    heartbeatAt,
  ];
}

class RefreshJobRowInclude extends _is.IncludeObject {
  RefreshJobRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => RefreshJobRow.t;
}

class RefreshJobRowIncludeList extends _is.IncludeList {
  RefreshJobRowIncludeList._({
    _is.WhereExpressionBuilder<RefreshJobRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RefreshJobRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => RefreshJobRow.t;
}

class RefreshJobRowRepository {
  const RefreshJobRowRepository._();

  /// Returns a list of [RefreshJobRow]s matching the given query parameters.
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
  Future<List<RefreshJobRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RefreshJobRow] matching the given query parameters.
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
  Future<RefreshJobRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? offset,
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RefreshJobRow] by its [id] or null if no such row exists.
  Future<RefreshJobRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RefreshJobRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RefreshJobRow]s in the list and returns the inserted rows.
  ///
  /// The returned [RefreshJobRow]s will have their `id` fields set.
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
  Future<List<RefreshJobRow>> insert(
    _is.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RefreshJobRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RefreshJobRow] and returns the inserted row.
  ///
  /// The returned [RefreshJobRow] will have its `id` field set.
  Future<RefreshJobRow> insertRow(
    _is.DatabaseSession session,
    RefreshJobRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RefreshJobRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RefreshJobRow]s in the list and returns the resulting rows.
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
  /// The returned [RefreshJobRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RefreshJobRow>> upsert(
    _is.DatabaseSession session,
    List<RefreshJobRow> rows, {
    required _is.ColumnSelections<RefreshJobRowTable> conflictColumns,
    _is.ColumnSelections<RefreshJobRowTable>? updateColumns,
    _is.WhereExpressionBuilder<RefreshJobRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RefreshJobRow>(
      rows,
      conflictColumns: conflictColumns(RefreshJobRow.t),
      updateColumns: updateColumns?.call(RefreshJobRow.t),
      updateWhere: updateWhere?.call(RefreshJobRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RefreshJobRow] and returns the resulting row.
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
  /// The returned [RefreshJobRow] will have its `id` field set.
  Future<RefreshJobRow?> upsertRow(
    _is.DatabaseSession session,
    RefreshJobRow row, {
    required _is.ColumnSelections<RefreshJobRowTable> conflictColumns,
    _is.ColumnSelections<RefreshJobRowTable>? updateColumns,
    _is.WhereExpressionBuilder<RefreshJobRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RefreshJobRow>(
      row,
      conflictColumns: conflictColumns(RefreshJobRow.t),
      updateColumns: updateColumns?.call(RefreshJobRow.t),
      updateWhere: updateWhere?.call(RefreshJobRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [RefreshJobRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RefreshJobRow>> update(
    _is.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _is.ColumnSelections<RefreshJobRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RefreshJobRow>(
      rows,
      columns: columns?.call(RefreshJobRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RefreshJobRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RefreshJobRow> updateRow(
    _is.DatabaseSession session,
    RefreshJobRow row, {
    _is.ColumnSelections<RefreshJobRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RefreshJobRow>(
      row,
      columns: columns?.call(RefreshJobRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RefreshJobRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RefreshJobRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<RefreshJobRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RefreshJobRow>(
      id,
      columnValues: columnValues(RefreshJobRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RefreshJobRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RefreshJobRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RefreshJobRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RefreshJobRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RefreshJobRow>(
      columnValues: columnValues(RefreshJobRow.t.updateTable),
      where: where(RefreshJobRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RefreshJobRow]s in the list and returns the deleted rows.
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
  Future<List<RefreshJobRow>> delete(
    _is.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RefreshJobRow>(
      rows,
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RefreshJobRow].
  Future<RefreshJobRow> deleteRow(
    _is.DatabaseSession session,
    RefreshJobRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RefreshJobRow>(
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
  Future<List<RefreshJobRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RefreshJobRowTable> where,
    _is.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _is.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RefreshJobRow>(
      where: where(RefreshJobRow.t),
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RefreshJobRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RefreshJobRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RefreshJobRow>(
      where: where(RefreshJobRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
