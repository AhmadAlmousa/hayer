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
import '../calibration_status.dart' as _i5qm94s5;

abstract class CalibrationRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  CalibrationRow._({
    this.id,
    required this.version,
    required this.status,
    required this.document,
    required this.fixturePassed,
    required this.liveCanaryPassed,
    required this.validationErrors,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.activatedAt,
  });

  factory CalibrationRow({
    _is.UuidValue? id,
    required String version,
    required _i5qm94s5.CalibrationStatus status,
    required Map<String, String> document,
    required bool fixturePassed,
    required bool liveCanaryPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? activatedAt,
  }) = _CalibrationRowImpl;

  factory CalibrationRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CalibrationRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      version: jsonSerialization['version'] as String,
      status: _i5qm94s5.CalibrationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      document: _i66y2smk.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['document'],
      ),
      fixturePassed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['fixturePassed'],
      ),
      liveCanaryPassed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['liveCanaryPassed'],
      ),
      validationErrors: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      activatedAt: jsonSerialization['activatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['activatedAt'],
            ),
    );
  }

  static final t = CalibrationRowTable();

  static const db = CalibrationRowRepository._();

  @override
  _is.UuidValue? id;

  String version;

  _i5qm94s5.CalibrationStatus status;

  Map<String, String> document;

  bool fixturePassed;

  bool liveCanaryPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? activatedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CalibrationRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CalibrationRow copyWith({
    _is.UuidValue? id,
    String? version,
    _i5qm94s5.CalibrationStatus? status,
    Map<String, String>? document,
    bool? fixturePassed,
    bool? liveCanaryPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? activatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CalibrationRow',
      if (id != null) 'id': id?.toJson(),
      'version': version,
      'status': status.toJson(),
      'document': document.toJson(),
      'fixturePassed': fixturePassed,
      'liveCanaryPassed': liveCanaryPassed,
      'validationErrors': validationErrors.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
      if (activatedAt != null) 'activatedAt': activatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CalibrationRowInclude include() {
    return CalibrationRowInclude._();
  }

  static CalibrationRowIncludeList includeList({
    _is.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    CalibrationRowInclude? include,
  }) {
    return CalibrationRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CalibrationRowImpl extends CalibrationRow {
  _CalibrationRowImpl({
    _is.UuidValue? id,
    required String version,
    required _i5qm94s5.CalibrationStatus status,
    required Map<String, String> document,
    required bool fixturePassed,
    required bool liveCanaryPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? activatedAt,
  }) : super._(
         id: id,
         version: version,
         status: status,
         document: document,
         fixturePassed: fixturePassed,
         liveCanaryPassed: liveCanaryPassed,
         validationErrors: validationErrors,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         activatedAt: activatedAt,
       );

  /// Returns a shallow copy of this [CalibrationRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CalibrationRow copyWith({
    Object? id = _Undefined,
    String? version,
    _i5qm94s5.CalibrationStatus? status,
    Map<String, String>? document,
    bool? fixturePassed,
    bool? liveCanaryPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? activatedAt = _Undefined,
  }) {
    return CalibrationRow(
      id: id is _is.UuidValue? ? id : this.id,
      version: version ?? this.version,
      status: status ?? this.status,
      document:
          document ??
          this.document.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      fixturePassed: fixturePassed ?? this.fixturePassed,
      liveCanaryPassed: liveCanaryPassed ?? this.liveCanaryPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
      activatedAt: activatedAt is DateTime? ? activatedAt : this.activatedAt,
    );
  }
}

class CalibrationRowUpdateTable extends _is.UpdateTable<CalibrationRowTable> {
  CalibrationRowUpdateTable(super.table);

  _is.ColumnValue<String, String> version(String value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<_i5qm94s5.CalibrationStatus, _i5qm94s5.CalibrationStatus>
  status(_i5qm94s5.CalibrationStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> document(
    Map<String, String> value,
  ) => _is.ColumnValue(
    table.document,
    value,
  );

  _is.ColumnValue<bool, bool> fixturePassed(bool value) => _is.ColumnValue(
    table.fixturePassed,
    value,
  );

  _is.ColumnValue<bool, bool> liveCanaryPassed(bool value) => _is.ColumnValue(
    table.liveCanaryPassed,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> validationErrors(
    List<String> value,
  ) => _is.ColumnValue(
    table.validationErrors,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.validatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> activatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.activatedAt,
        value,
      );
}

class CalibrationRowTable extends _is.Table<_is.UuidValue?> {
  CalibrationRowTable({super.tableRelation})
    : super(tableName: 'hayer_calibration') {
    updateTable = CalibrationRowUpdateTable(this);
    version = _is.ColumnString(
      'version',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    document = _is.ColumnSerializable<Map<String, String>>(
      'document',
      this,
    );
    fixturePassed = _is.ColumnBool(
      'fixturePassed',
      this,
    );
    liveCanaryPassed = _is.ColumnBool(
      'liveCanaryPassed',
      this,
    );
    validationErrors = _is.ColumnSerializable<List<String>>(
      'validationErrors',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    validatedAt = _is.ColumnDateTime(
      'validatedAt',
      this,
    );
    activatedAt = _is.ColumnDateTime(
      'activatedAt',
      this,
    );
  }

  late final CalibrationRowUpdateTable updateTable;

  late final _is.ColumnString version;

  late final _is.ColumnEnum<_i5qm94s5.CalibrationStatus> status;

  late final _is.ColumnSerializable<Map<String, String>> document;

  late final _is.ColumnBool fixturePassed;

  late final _is.ColumnBool liveCanaryPassed;

  late final _is.ColumnSerializable<List<String>> validationErrors;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime validatedAt;

  late final _is.ColumnDateTime activatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    version,
    status,
    document,
    fixturePassed,
    liveCanaryPassed,
    validationErrors,
    createdBy,
    createdAt,
    validatedAt,
    activatedAt,
  ];
}

class CalibrationRowInclude extends _is.IncludeObject {
  CalibrationRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => CalibrationRow.t;
}

class CalibrationRowIncludeList extends _is.IncludeList {
  CalibrationRowIncludeList._({
    _is.WhereExpressionBuilder<CalibrationRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CalibrationRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => CalibrationRow.t;
}

class CalibrationRowRepository {
  const CalibrationRowRepository._();

  /// Returns a list of [CalibrationRow]s matching the given query parameters.
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
  Future<List<CalibrationRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CalibrationRow] matching the given query parameters.
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
  Future<CalibrationRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? offset,
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CalibrationRow] by its [id] or null if no such row exists.
  Future<CalibrationRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CalibrationRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CalibrationRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CalibrationRow]s will have their `id` fields set.
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
  Future<List<CalibrationRow>> insert(
    _is.DatabaseSession session,
    List<CalibrationRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CalibrationRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CalibrationRow] and returns the inserted row.
  ///
  /// The returned [CalibrationRow] will have its `id` field set.
  Future<CalibrationRow> insertRow(
    _is.DatabaseSession session,
    CalibrationRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CalibrationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CalibrationRow]s in the list and returns the resulting rows.
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
  /// The returned [CalibrationRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CalibrationRow>> upsert(
    _is.DatabaseSession session,
    List<CalibrationRow> rows, {
    required _is.ColumnSelections<CalibrationRowTable> conflictColumns,
    _is.ColumnSelections<CalibrationRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CalibrationRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CalibrationRow>(
      rows,
      conflictColumns: conflictColumns(CalibrationRow.t),
      updateColumns: updateColumns?.call(CalibrationRow.t),
      updateWhere: updateWhere?.call(CalibrationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CalibrationRow] and returns the resulting row.
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
  /// The returned [CalibrationRow] will have its `id` field set.
  Future<CalibrationRow?> upsertRow(
    _is.DatabaseSession session,
    CalibrationRow row, {
    required _is.ColumnSelections<CalibrationRowTable> conflictColumns,
    _is.ColumnSelections<CalibrationRowTable>? updateColumns,
    _is.WhereExpressionBuilder<CalibrationRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CalibrationRow>(
      row,
      conflictColumns: conflictColumns(CalibrationRow.t),
      updateColumns: updateColumns?.call(CalibrationRow.t),
      updateWhere: updateWhere?.call(CalibrationRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [CalibrationRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CalibrationRow>> update(
    _is.DatabaseSession session,
    List<CalibrationRow> rows, {
    _is.ColumnSelections<CalibrationRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CalibrationRow>(
      rows,
      columns: columns?.call(CalibrationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CalibrationRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CalibrationRow> updateRow(
    _is.DatabaseSession session,
    CalibrationRow row, {
    _is.ColumnSelections<CalibrationRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CalibrationRow>(
      row,
      columns: columns?.call(CalibrationRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CalibrationRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CalibrationRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<CalibrationRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CalibrationRow>(
      id,
      columnValues: columnValues(CalibrationRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CalibrationRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CalibrationRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CalibrationRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CalibrationRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CalibrationRow>(
      columnValues: columnValues(CalibrationRow.t.updateTable),
      where: where(CalibrationRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CalibrationRow]s in the list and returns the deleted rows.
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
  Future<List<CalibrationRow>> delete(
    _is.DatabaseSession session,
    List<CalibrationRow> rows, {
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CalibrationRow>(
      rows,
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CalibrationRow].
  Future<CalibrationRow> deleteRow(
    _is.DatabaseSession session,
    CalibrationRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CalibrationRow>(
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
  Future<List<CalibrationRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CalibrationRowTable> where,
    _is.OrderByBuilder<CalibrationRowTable>? orderBy,
    _is.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CalibrationRow>(
      where: where(CalibrationRow.t),
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CalibrationRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CalibrationRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CalibrationRow>(
      where: where(CalibrationRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
