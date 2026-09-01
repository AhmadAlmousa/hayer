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
import '../calibration_status.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class CalibrationRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
    required String version,
    required _i2.CalibrationStatus status,
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
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      version: jsonSerialization['version'] as String,
      status: _i2.CalibrationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      document: _i3.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['document'],
      ),
      fixturePassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['fixturePassed'],
      ),
      liveCanaryPassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['liveCanaryPassed'],
      ),
      validationErrors: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      activatedAt: jsonSerialization['activatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['activatedAt'],
            ),
    );
  }

  static final t = CalibrationRowTable();

  static const db = CalibrationRowRepository._();

  @override
  _i1.UuidValue? id;

  String version;

  _i2.CalibrationStatus status;

  Map<String, String> document;

  bool fixturePassed;

  bool liveCanaryPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? activatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CalibrationRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CalibrationRow copyWith({
    _i1.UuidValue? id,
    String? version,
    _i2.CalibrationStatus? status,
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
    _i1.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CalibrationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalibrationRowTable>? orderByList,
    CalibrationRowInclude? include,
  }) {
    return CalibrationRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CalibrationRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CalibrationRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CalibrationRowImpl extends CalibrationRow {
  _CalibrationRowImpl({
    _i1.UuidValue? id,
    required String version,
    required _i2.CalibrationStatus status,
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
  @_i1.useResult
  @override
  CalibrationRow copyWith({
    Object? id = _Undefined,
    String? version,
    _i2.CalibrationStatus? status,
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class CalibrationRowUpdateTable extends _i1.UpdateTable<CalibrationRowTable> {
  CalibrationRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<_i2.CalibrationStatus, _i2.CalibrationStatus> status(
    _i2.CalibrationStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> document(
    Map<String, String> value,
  ) => _i1.ColumnValue(
    table.document,
    value,
  );

  _i1.ColumnValue<bool, bool> fixturePassed(bool value) => _i1.ColumnValue(
    table.fixturePassed,
    value,
  );

  _i1.ColumnValue<bool, bool> liveCanaryPassed(bool value) => _i1.ColumnValue(
    table.liveCanaryPassed,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> validationErrors(
    List<String> value,
  ) => _i1.ColumnValue(
    table.validationErrors,
    value,
  );

  _i1.ColumnValue<String, String> createdBy(String value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.validatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> activatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.activatedAt,
        value,
      );
}

class CalibrationRowTable extends _i1.Table<_i1.UuidValue?> {
  CalibrationRowTable({super.tableRelation})
    : super(tableName: 'hayer_calibration') {
    updateTable = CalibrationRowUpdateTable(this);
    version = _i1.ColumnString(
      'version',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    document = _i1.ColumnSerializable<Map<String, String>>(
      'document',
      this,
    );
    fixturePassed = _i1.ColumnBool(
      'fixturePassed',
      this,
    );
    liveCanaryPassed = _i1.ColumnBool(
      'liveCanaryPassed',
      this,
    );
    validationErrors = _i1.ColumnSerializable<List<String>>(
      'validationErrors',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    validatedAt = _i1.ColumnDateTime(
      'validatedAt',
      this,
    );
    activatedAt = _i1.ColumnDateTime(
      'activatedAt',
      this,
    );
  }

  late final CalibrationRowUpdateTable updateTable;

  late final _i1.ColumnString version;

  late final _i1.ColumnEnum<_i2.CalibrationStatus> status;

  late final _i1.ColumnSerializable<Map<String, String>> document;

  late final _i1.ColumnBool fixturePassed;

  late final _i1.ColumnBool liveCanaryPassed;

  late final _i1.ColumnSerializable<List<String>> validationErrors;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime validatedAt;

  late final _i1.ColumnDateTime activatedAt;

  @override
  List<_i1.Column> get columns => [
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

class CalibrationRowInclude extends _i1.IncludeObject {
  CalibrationRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CalibrationRow.t;
}

class CalibrationRowIncludeList extends _i1.IncludeList {
  CalibrationRowIncludeList._({
    _i1.WhereExpressionBuilder<CalibrationRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CalibrationRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CalibrationRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CalibrationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CalibrationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CalibrationRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CalibrationRow] by its [id] or null if no such row exists.
  Future<CalibrationRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<CalibrationRow>> insert(
    _i1.DatabaseSession session,
    List<CalibrationRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CalibrationRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CalibrationRow] and returns the inserted row.
  ///
  /// The returned [CalibrationRow] will have its `id` field set.
  Future<CalibrationRow> insertRow(
    _i1.DatabaseSession session,
    CalibrationRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CalibrationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CalibrationRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CalibrationRow>> update(
    _i1.DatabaseSession session,
    List<CalibrationRow> rows, {
    _i1.ColumnSelections<CalibrationRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CalibrationRow>(
      rows,
      columns: columns?.call(CalibrationRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CalibrationRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CalibrationRow> updateRow(
    _i1.DatabaseSession session,
    CalibrationRow row, {
    _i1.ColumnSelections<CalibrationRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<CalibrationRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CalibrationRow>(
      id,
      columnValues: columnValues(CalibrationRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CalibrationRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CalibrationRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CalibrationRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CalibrationRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CalibrationRowTable>? orderBy,
    _i1.OrderByListBuilder<CalibrationRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CalibrationRow>(
      columnValues: columnValues(CalibrationRow.t.updateTable),
      where: where(CalibrationRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CalibrationRow.t),
      orderByList: orderByList?.call(CalibrationRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CalibrationRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CalibrationRow>> delete(
    _i1.DatabaseSession session,
    List<CalibrationRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CalibrationRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CalibrationRow].
  Future<CalibrationRow> deleteRow(
    _i1.DatabaseSession session,
    CalibrationRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CalibrationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CalibrationRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CalibrationRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CalibrationRow>(
      where: where(CalibrationRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CalibrationRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CalibrationRow>(
      where: where?.call(CalibrationRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CalibrationRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CalibrationRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CalibrationRow>(
      where: where(CalibrationRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
