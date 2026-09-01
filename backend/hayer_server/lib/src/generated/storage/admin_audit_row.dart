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
import 'package:hayer_server/src/generated/protocol.dart' as _i2;

abstract class AdminAuditRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
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
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      auditId: jsonSerialization['auditId'] as String,
      operatorName: jsonSerialization['operatorName'] as String,
      ipHash: jsonSerialization['ipHash'] as String,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as String?,
      reason: jsonSerialization['reason'] as String,
      beforeData: jsonSerialization['beforeData'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['beforeData'],
            ),
      afterData: jsonSerialization['afterData'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['afterData'],
            ),
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  static final t = AdminAuditRowTable();

  static const db = AdminAuditRowRepository._();

  @override
  _i1.UuidValue? id;

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
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [AdminAuditRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAuditRow copyWith({
    _i1.UuidValue? id,
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
    _i1.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminAuditRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    AdminAuditRowInclude? include,
  }) {
    return AdminAuditRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AdminAuditRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditRowImpl extends AdminAuditRow {
  _AdminAuditRowImpl({
    _i1.UuidValue? id,
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
  @_i1.useResult
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class AdminAuditRowUpdateTable extends _i1.UpdateTable<AdminAuditRowTable> {
  AdminAuditRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> auditId(String value) => _i1.ColumnValue(
    table.auditId,
    value,
  );

  _i1.ColumnValue<String, String> operatorName(String value) => _i1.ColumnValue(
    table.operatorName,
    value,
  );

  _i1.ColumnValue<String, String> ipHash(String value) => _i1.ColumnValue(
    table.ipHash,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> targetType(String value) => _i1.ColumnValue(
    table.targetType,
    value,
  );

  _i1.ColumnValue<String, String> targetId(String? value) => _i1.ColumnValue(
    table.targetId,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> beforeData(
    Map<String, String>? value,
  ) => _i1.ColumnValue(
    table.beforeData,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> afterData(
    Map<String, String>? value,
  ) => _i1.ColumnValue(
    table.afterData,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _i1.ColumnValue(
        table.occurredAt,
        value,
      );
}

class AdminAuditRowTable extends _i1.Table<_i1.UuidValue?> {
  AdminAuditRowTable({super.tableRelation})
    : super(tableName: 'hayer_admin_audit') {
    updateTable = AdminAuditRowUpdateTable(this);
    auditId = _i1.ColumnString(
      'auditId',
      this,
    );
    operatorName = _i1.ColumnString(
      'operatorName',
      this,
    );
    ipHash = _i1.ColumnString(
      'ipHash',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    targetType = _i1.ColumnString(
      'targetType',
      this,
    );
    targetId = _i1.ColumnString(
      'targetId',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
      this,
    );
    beforeData = _i1.ColumnSerializable<Map<String, String>>(
      'beforeData',
      this,
    );
    afterData = _i1.ColumnSerializable<Map<String, String>>(
      'afterData',
      this,
    );
    occurredAt = _i1.ColumnDateTime(
      'occurredAt',
      this,
    );
  }

  late final AdminAuditRowUpdateTable updateTable;

  late final _i1.ColumnString auditId;

  late final _i1.ColumnString operatorName;

  late final _i1.ColumnString ipHash;

  late final _i1.ColumnString action;

  late final _i1.ColumnString targetType;

  late final _i1.ColumnString targetId;

  late final _i1.ColumnString reason;

  late final _i1.ColumnSerializable<Map<String, String>> beforeData;

  late final _i1.ColumnSerializable<Map<String, String>> afterData;

  late final _i1.ColumnDateTime occurredAt;

  @override
  List<_i1.Column> get columns => [
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

class AdminAuditRowInclude extends _i1.IncludeObject {
  AdminAuditRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AdminAuditRow.t;
}

class AdminAuditRowIncludeList extends _i1.IncludeList {
  AdminAuditRowIncludeList._({
    _i1.WhereExpressionBuilder<AdminAuditRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AdminAuditRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => AdminAuditRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminAuditRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<AdminAuditRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AdminAuditRow] by its [id] or null if no such row exists.
  Future<AdminAuditRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<AdminAuditRow>> insert(
    _i1.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AdminAuditRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AdminAuditRow] and returns the inserted row.
  ///
  /// The returned [AdminAuditRow] will have its `id` field set.
  Future<AdminAuditRow> insertRow(
    _i1.DatabaseSession session,
    AdminAuditRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AdminAuditRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AdminAuditRow>> update(
    _i1.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _i1.ColumnSelections<AdminAuditRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AdminAuditRow>(
      rows,
      columns: columns?.call(AdminAuditRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AdminAuditRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AdminAuditRow> updateRow(
    _i1.DatabaseSession session,
    AdminAuditRow row, {
    _i1.ColumnSelections<AdminAuditRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AdminAuditRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AdminAuditRow>(
      id,
      columnValues: columnValues(AdminAuditRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AdminAuditRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AdminAuditRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AdminAuditRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AdminAuditRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AdminAuditRowTable>? orderBy,
    _i1.OrderByListBuilder<AdminAuditRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AdminAuditRow>(
      columnValues: columnValues(AdminAuditRow.t.updateTable),
      where: where(AdminAuditRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AdminAuditRow.t),
      orderByList: orderByList?.call(AdminAuditRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AdminAuditRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AdminAuditRow>> delete(
    _i1.DatabaseSession session,
    List<AdminAuditRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AdminAuditRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AdminAuditRow].
  Future<AdminAuditRow> deleteRow(
    _i1.DatabaseSession session,
    AdminAuditRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AdminAuditRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AdminAuditRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminAuditRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AdminAuditRow>(
      where: where(AdminAuditRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AdminAuditRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AdminAuditRow>(
      where: where?.call(AdminAuditRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AdminAuditRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AdminAuditRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AdminAuditRow>(
      where: where(AdminAuditRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
