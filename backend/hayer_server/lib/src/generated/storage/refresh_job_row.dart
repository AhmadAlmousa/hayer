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
import '../job_status.dart' as _i2;

abstract class RefreshJobRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
    required String jobId,
    required String coverageKey,
    required _i2.JobStatus status,
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
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      jobId: jsonSerialization['jobId'] as String,
      coverageKey: jsonSerialization['coverageKey'] as String,
      status: _i2.JobStatus.fromJson((jsonSerialization['status'] as String)),
      requestedBy: jsonSerialization['requestedBy'] as String,
      reason: jsonSerialization['reason'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      errorCode: jsonSerialization['errorCode'] as String?,
      planJson: jsonSerialization['planJson'] as String?,
      heartbeatAt: jsonSerialization['heartbeatAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['heartbeatAt'],
            ),
    );
  }

  static final t = RefreshJobRowTable();

  static const db = RefreshJobRowRepository._();

  @override
  _i1.UuidValue? id;

  String jobId;

  String coverageKey;

  _i2.JobStatus status;

  String requestedBy;

  String reason;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  String? errorCode;

  String? planJson;

  DateTime? heartbeatAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [RefreshJobRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RefreshJobRow copyWith({
    _i1.UuidValue? id,
    String? jobId,
    String? coverageKey,
    _i2.JobStatus? status,
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
    _i1.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RefreshJobRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    RefreshJobRowInclude? include,
  }) {
    return RefreshJobRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RefreshJobRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RefreshJobRowImpl extends RefreshJobRow {
  _RefreshJobRowImpl({
    _i1.UuidValue? id,
    required String jobId,
    required String coverageKey,
    required _i2.JobStatus status,
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
  @_i1.useResult
  @override
  RefreshJobRow copyWith({
    Object? id = _Undefined,
    String? jobId,
    String? coverageKey,
    _i2.JobStatus? status,
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class RefreshJobRowUpdateTable extends _i1.UpdateTable<RefreshJobRowTable> {
  RefreshJobRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> jobId(String value) => _i1.ColumnValue(
    table.jobId,
    value,
  );

  _i1.ColumnValue<String, String> coverageKey(String value) => _i1.ColumnValue(
    table.coverageKey,
    value,
  );

  _i1.ColumnValue<_i2.JobStatus, _i2.JobStatus> status(_i2.JobStatus value) =>
      _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<String, String> requestedBy(String value) => _i1.ColumnValue(
    table.requestedBy,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<String, String> errorCode(String? value) => _i1.ColumnValue(
    table.errorCode,
    value,
  );

  _i1.ColumnValue<String, String> planJson(String? value) => _i1.ColumnValue(
    table.planJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> heartbeatAt(DateTime? value) =>
      _i1.ColumnValue(
        table.heartbeatAt,
        value,
      );
}

class RefreshJobRowTable extends _i1.Table<_i1.UuidValue?> {
  RefreshJobRowTable({super.tableRelation})
    : super(tableName: 'hayer_refresh_job') {
    updateTable = RefreshJobRowUpdateTable(this);
    jobId = _i1.ColumnString(
      'jobId',
      this,
    );
    coverageKey = _i1.ColumnString(
      'coverageKey',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    requestedBy = _i1.ColumnString(
      'requestedBy',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    errorCode = _i1.ColumnString(
      'errorCode',
      this,
    );
    planJson = _i1.ColumnString(
      'planJson',
      this,
    );
    heartbeatAt = _i1.ColumnDateTime(
      'heartbeatAt',
      this,
    );
  }

  late final RefreshJobRowUpdateTable updateTable;

  late final _i1.ColumnString jobId;

  late final _i1.ColumnString coverageKey;

  late final _i1.ColumnEnum<_i2.JobStatus> status;

  late final _i1.ColumnString requestedBy;

  late final _i1.ColumnString reason;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnString errorCode;

  late final _i1.ColumnString planJson;

  late final _i1.ColumnDateTime heartbeatAt;

  @override
  List<_i1.Column> get columns => [
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

class RefreshJobRowInclude extends _i1.IncludeObject {
  RefreshJobRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => RefreshJobRow.t;
}

class RefreshJobRowIncludeList extends _i1.IncludeList {
  RefreshJobRowIncludeList._({
    _i1.WhereExpressionBuilder<RefreshJobRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RefreshJobRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => RefreshJobRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RefreshJobRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<RefreshJobRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RefreshJobRow] by its [id] or null if no such row exists.
  Future<RefreshJobRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<RefreshJobRow>> insert(
    _i1.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<RefreshJobRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [RefreshJobRow] and returns the inserted row.
  ///
  /// The returned [RefreshJobRow] will have its `id` field set.
  Future<RefreshJobRow> insertRow(
    _i1.DatabaseSession session,
    RefreshJobRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RefreshJobRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RefreshJobRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RefreshJobRow>> update(
    _i1.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _i1.ColumnSelections<RefreshJobRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RefreshJobRow>(
      rows,
      columns: columns?.call(RefreshJobRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RefreshJobRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RefreshJobRow> updateRow(
    _i1.DatabaseSession session,
    RefreshJobRow row, {
    _i1.ColumnSelections<RefreshJobRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<RefreshJobRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<RefreshJobRow>(
      id,
      columnValues: columnValues(RefreshJobRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RefreshJobRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<RefreshJobRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RefreshJobRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RefreshJobRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RefreshJobRowTable>? orderBy,
    _i1.OrderByListBuilder<RefreshJobRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<RefreshJobRow>(
      columnValues: columnValues(RefreshJobRow.t.updateTable),
      where: where(RefreshJobRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RefreshJobRow.t),
      orderByList: orderByList?.call(RefreshJobRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [RefreshJobRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RefreshJobRow>> delete(
    _i1.DatabaseSession session,
    List<RefreshJobRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RefreshJobRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RefreshJobRow].
  Future<RefreshJobRow> deleteRow(
    _i1.DatabaseSession session,
    RefreshJobRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RefreshJobRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RefreshJobRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RefreshJobRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RefreshJobRow>(
      where: where(RefreshJobRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RefreshJobRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RefreshJobRow>(
      where: where?.call(RefreshJobRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RefreshJobRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RefreshJobRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RefreshJobRow>(
      where: where(RefreshJobRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
