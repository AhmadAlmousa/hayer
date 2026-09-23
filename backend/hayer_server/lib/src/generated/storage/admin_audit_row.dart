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

abstract class AdminAuditRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  AdminAuditRow._({
    this.id,
    required this.auditId,
    required this.operatorName,
    required this.ipHash,
    required this.action,
    required this.targetType,
    this.targetId,
    required this.reason,
    this.beforeData,
    this.afterData,
    required this.occurredAt,
  });

  factory AdminAuditRow({
    _is.UuidValue? id,
    required String auditId,
    required String operatorName,
    required String ipHash,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    required DateTime occurredAt,
  }) = _AdminAuditRowImpl;

  factory AdminAuditRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      auditId: jsonSerialization['auditId'] as String,
      operatorName: jsonSerialization['operatorName'] as String,
      ipHash: jsonSerialization['ipHash'] as String,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as String?,
      reason: jsonSerialization['reason'] as String,
      beforeData: jsonSerialization['beforeData'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['beforeData'],
            ),
      afterData: jsonSerialization['afterData'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['afterData'],
            ),
      occurredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  static final t = AdminAuditRowTable();

  static const db = AdminAuditRowRepository._();

  @override
  _is.UuidValue? id;

  String auditId;

  String operatorName;

  String ipHash;

  String action;

  String targetType;

  String? targetId;

  String reason;

  Map<String, String>? beforeData;

  Map<String, String>? afterData;

  DateTime occurredAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AdminAuditRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAuditRow copyWith({
    _is.UuidValue? id,
    String? auditId,
    String? operatorName,
    String? ipHash,
    String? action,
    String? targetType,
    String? targetId,
    String? reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditRow',
      if (id != null) 'id': id?.toJson(),
      'auditId': auditId,
      'operatorName': operatorName,
      'ipHash': ipHash,
      'action': action,
      'targetType': targetType,
      if (targetId != null) 'targetId': targetId,
      'reason': reason,
      if (beforeData != null) 'beforeData': beforeData?.toJson(),
      if (afterData != null) 'afterData': afterData?.toJson(),
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AdminAuditRowInclude include() {
    return AdminAuditRowInclude._();
  }

  static AdminAuditRowIncludeList includeList({
    _is.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    AdminAuditRowInclude? include,
  }) {
    return AdminAuditRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditRowImpl extends AdminAuditRow {
  _AdminAuditRowImpl({
    _is.UuidValue? id,
    required String auditId,
    required String operatorName,
    required String ipHash,
    required String action,
    required String targetType,
    String? targetId,
    required String reason,
    Map<String, String>? beforeData,
    Map<String, String>? afterData,
    required DateTime occurredAt,
  }) : super._(
         id: id,
         auditId: auditId,
         operatorName: operatorName,
         ipHash: ipHash,
         action: action,
         targetType: targetType,
         targetId: targetId,
         reason: reason,
         beforeData: beforeData,
         afterData: afterData,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [AdminAuditRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminAuditRow copyWith({
    Object? id = _Undefined,
    String? auditId,
    String? operatorName,
    String? ipHash,
    String? action,
    String? targetType,
    Object? targetId = _Undefined,
    String? reason,
    Object? beforeData = _Undefined,
    Object? afterData = _Undefined,
    DateTime? occurredAt,
  }) {
    return AdminAuditRow(
      id: id is _is.UuidValue? ? id : this.id,
      auditId: auditId ?? this.auditId,
      operatorName: operatorName ?? this.operatorName,
      ipHash: ipHash ?? this.ipHash,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId is String? ? targetId : this.targetId,
      reason: reason ?? this.reason,
      beforeData: beforeData is Map<String, String>?
          ? beforeData
          : this.beforeData?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      afterData: afterData is Map<String, String>?
          ? afterData
          : this.afterData?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}

class AdminAuditRowUpdateTable extends _is.UpdateTable<AdminAuditRowTable> {
  AdminAuditRowUpdateTable(super.table);

  _is.ColumnValue<String, String> auditId(String value) => _is.ColumnValue(
    table.auditId,
    value,
  );

  _is.ColumnValue<String, String> operatorName(String value) => _is.ColumnValue(
    table.operatorName,
    value,
  );

  _is.ColumnValue<String, String> ipHash(String value) => _is.ColumnValue(
    table.ipHash,
    value,
  );

  _is.ColumnValue<String, String> action(String value) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<String, String> targetType(String value) => _is.ColumnValue(
    table.targetType,
    value,
  );

  _is.ColumnValue<String, String> targetId(String? value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> beforeData(
    Map<String, String>? value,
  ) => _is.ColumnValue(
    table.beforeData,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> afterData(
    Map<String, String>? value,
  ) => _is.ColumnValue(
    table.afterData,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _is.ColumnValue(
        table.occurredAt,
        value,
      );
}

class AdminAuditRowTable extends _is.Table<_is.UuidValue?> {
  AdminAuditRowTable({super.tableRelation})
    : super(tableName: 'hayer_admin_audit') {
    updateTable = AdminAuditRowUpdateTable(this);
    auditId = _is.ColumnString(
      'auditId',
      this,
    );
    operatorName = _is.ColumnString(
      'operatorName',
      this,
    );
    ipHash = _is.ColumnString(
      'ipHash',
      this,
    );
    action = _is.ColumnString(
      'action',
      this,
    );
    targetType = _is.ColumnString(
      'targetType',
      this,
    );
    targetId = _is.ColumnString(
      'targetId',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    beforeData = _is.ColumnSerializable<Map<String, String>>(
      'beforeData',
      this,
    );
    afterData = _is.ColumnSerializable<Map<String, String>>(
      'afterData',
      this,
    );
    occurredAt = _is.ColumnDateTime(
      'occurredAt',
      this,
    );
  }

  late final AdminAuditRowUpdateTable updateTable;

  late final _is.ColumnString auditId;

  late final _is.ColumnString operatorName;

  late final _is.ColumnString ipHash;

  late final _is.ColumnString action;

  late final _is.ColumnString targetType;

  late final _is.ColumnString targetId;

  late final _is.ColumnString reason;

  late final _is.ColumnSerializable<Map<String, String>> beforeData;

  late final _is.ColumnSerializable<Map<String, String>> afterData;

  late final _is.ColumnDateTime occurredAt;

  @override
  List<_is.Column> get columns => [
    id,
    auditId,
    operatorName,
    ipHash,
    action,
    targetType,
    targetId,
    reason,
    beforeData,
    afterData,
    occurredAt,
  ];
}

class AdminAuditRowInclude extends _is.IncludeObject {
  AdminAuditRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => AdminAuditRow.t;
}

class AdminAuditRowIncludeList extends _is.IncludeList {
  AdminAuditRowIncludeList._({
    _is.WhereExpressionBuilder<AdminAuditRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminAuditRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => AdminAuditRow.t;
}

class AdminAuditRowRepository {
  const AdminAuditRowRepository._();

  /// Returns a list of [AdminAuditRow]s matching the given query parameters.
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
  Future<List<AdminAuditRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AdminAuditRow] matching the given query parameters.
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
  Future<AdminAuditRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? offset,
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminAuditRow] by its [id] or null if no such row exists.
  Future<AdminAuditRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AdminAuditRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AdminAuditRow]s in the list and returns the inserted rows.
  ///
  /// The returned [AdminAuditRow]s will have their `id` fields set.
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
  Future<List<AdminAuditRow>> insert(
    _is.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AdminAuditRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AdminAuditRow] and returns the inserted row.
  ///
  /// The returned [AdminAuditRow] will have its `id` field set.
  Future<AdminAuditRow> insertRow(
    _is.DatabaseSession session,
    AdminAuditRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminAuditRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AdminAuditRow]s in the list and returns the resulting rows.
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
  /// The returned [AdminAuditRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditRow>> upsert(
    _is.DatabaseSession session,
    List<AdminAuditRow> rows, {
    required _is.ColumnSelections<AdminAuditRowTable> conflictColumns,
    _is.ColumnSelections<AdminAuditRowTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminAuditRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AdminAuditRow>(
      rows,
      conflictColumns: conflictColumns(AdminAuditRow.t),
      updateColumns: updateColumns?.call(AdminAuditRow.t),
      updateWhere: updateWhere?.call(AdminAuditRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AdminAuditRow] and returns the resulting row.
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
  /// The returned [AdminAuditRow] will have its `id` field set.
  Future<AdminAuditRow?> upsertRow(
    _is.DatabaseSession session,
    AdminAuditRow row, {
    required _is.ColumnSelections<AdminAuditRowTable> conflictColumns,
    _is.ColumnSelections<AdminAuditRowTable>? updateColumns,
    _is.WhereExpressionBuilder<AdminAuditRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AdminAuditRow>(
      row,
      conflictColumns: conflictColumns(AdminAuditRow.t),
      updateColumns: updateColumns?.call(AdminAuditRow.t),
      updateWhere: updateWhere?.call(AdminAuditRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditRow>> update(
    _is.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _is.ColumnSelections<AdminAuditRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AdminAuditRow>(
      rows,
      columns: columns?.call(AdminAuditRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AdminAuditRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminAuditRow> updateRow(
    _is.DatabaseSession session,
    AdminAuditRow row, {
    _is.ColumnSelections<AdminAuditRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AdminAuditRow>(
      row,
      columns: columns?.call(AdminAuditRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminAuditRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AdminAuditRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<AdminAuditRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminAuditRow>(
      id,
      columnValues: columnValues(AdminAuditRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AdminAuditRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AdminAuditRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AdminAuditRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AdminAuditRow>(
      columnValues: columnValues(AdminAuditRow.t.updateTable),
      where: where(AdminAuditRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AdminAuditRow]s in the list and returns the deleted rows.
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
  Future<List<AdminAuditRow>> delete(
    _is.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AdminAuditRow>(
      rows,
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AdminAuditRow].
  Future<AdminAuditRow> deleteRow(
    _is.DatabaseSession session,
    AdminAuditRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminAuditRow>(
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
  Future<List<AdminAuditRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminAuditRowTable> where,
    _is.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _is.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AdminAuditRow>(
      where: where(AdminAuditRow.t),
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminAuditRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AdminAuditRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminAuditRow>(
      where: where(AdminAuditRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
