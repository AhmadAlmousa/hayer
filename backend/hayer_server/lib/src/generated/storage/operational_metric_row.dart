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

abstract class OperationalMetricRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  OperationalMetricRow._({
    this.id,
    required this.bucketStartedAt,
    required this.metricName,
    required this.dimensions,
    required this.metricValue,
    required this.sampleCount,
  });

  factory OperationalMetricRow({
    _is.UuidValue? id,
    required DateTime bucketStartedAt,
    required String metricName,
    required Map<String, String> dimensions,
    required double metricValue,
    required int sampleCount,
  }) = _OperationalMetricRowImpl;

  factory OperationalMetricRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OperationalMetricRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      bucketStartedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['bucketStartedAt'],
      ),
      metricName: jsonSerialization['metricName'] as String,
      dimensions: _i66y2smk.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['dimensions'],
      ),
      metricValue: (jsonSerialization['metricValue'] as num).toDouble(),
      sampleCount: jsonSerialization['sampleCount'] as int,
    );
  }

  static final t = OperationalMetricRowTable();

  static const db = OperationalMetricRowRepository._();

  @override
  _is.UuidValue? id;

  DateTime bucketStartedAt;

  String metricName;

  Map<String, String> dimensions;

  double metricValue;

  int sampleCount;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [OperationalMetricRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OperationalMetricRow copyWith({
    _is.UuidValue? id,
    DateTime? bucketStartedAt,
    String? metricName,
    Map<String, String>? dimensions,
    double? metricValue,
    int? sampleCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OperationalMetricRow',
      if (id != null) 'id': id?.toJson(),
      'bucketStartedAt': bucketStartedAt.toJson(),
      'metricName': metricName,
      'dimensions': dimensions.toJson(),
      'metricValue': metricValue,
      'sampleCount': sampleCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static OperationalMetricRowInclude include() {
    return OperationalMetricRowInclude._();
  }

  static OperationalMetricRowIncludeList includeList({
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    OperationalMetricRowInclude? include,
  }) {
    return OperationalMetricRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OperationalMetricRowImpl extends OperationalMetricRow {
  _OperationalMetricRowImpl({
    _is.UuidValue? id,
    required DateTime bucketStartedAt,
    required String metricName,
    required Map<String, String> dimensions,
    required double metricValue,
    required int sampleCount,
  }) : super._(
         id: id,
         bucketStartedAt: bucketStartedAt,
         metricName: metricName,
         dimensions: dimensions,
         metricValue: metricValue,
         sampleCount: sampleCount,
       );

  /// Returns a shallow copy of this [OperationalMetricRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OperationalMetricRow copyWith({
    Object? id = _Undefined,
    DateTime? bucketStartedAt,
    String? metricName,
    Map<String, String>? dimensions,
    double? metricValue,
    int? sampleCount,
  }) {
    return OperationalMetricRow(
      id: id is _is.UuidValue? ? id : this.id,
      bucketStartedAt: bucketStartedAt ?? this.bucketStartedAt,
      metricName: metricName ?? this.metricName,
      dimensions:
          dimensions ??
          this.dimensions.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      metricValue: metricValue ?? this.metricValue,
      sampleCount: sampleCount ?? this.sampleCount,
    );
  }
}

class OperationalMetricRowUpdateTable
    extends _is.UpdateTable<OperationalMetricRowTable> {
  OperationalMetricRowUpdateTable(super.table);

  _is.ColumnValue<DateTime, DateTime> bucketStartedAt(DateTime value) =>
      _is.ColumnValue(
        table.bucketStartedAt,
        value,
      );

  _is.ColumnValue<String, String> metricName(String value) => _is.ColumnValue(
    table.metricName,
    value,
  );

  _is.ColumnValue<Map<String, String>, Map<String, String>> dimensions(
    Map<String, String> value,
  ) => _is.ColumnValue(
    table.dimensions,
    value,
  );

  _is.ColumnValue<double, double> metricValue(double value) => _is.ColumnValue(
    table.metricValue,
    value,
  );

  _is.ColumnValue<int, int> sampleCount(int value) => _is.ColumnValue(
    table.sampleCount,
    value,
  );
}

class OperationalMetricRowTable extends _is.Table<_is.UuidValue?> {
  OperationalMetricRowTable({super.tableRelation})
    : super(tableName: 'hayer_operational_metric') {
    updateTable = OperationalMetricRowUpdateTable(this);
    bucketStartedAt = _is.ColumnDateTime(
      'bucketStartedAt',
      this,
    );
    metricName = _is.ColumnString(
      'metricName',
      this,
    );
    dimensions = _is.ColumnSerializable<Map<String, String>>(
      'dimensions',
      this,
    );
    metricValue = _is.ColumnDouble(
      'metricValue',
      this,
    );
    sampleCount = _is.ColumnInt(
      'sampleCount',
      this,
    );
  }

  late final OperationalMetricRowUpdateTable updateTable;

  late final _is.ColumnDateTime bucketStartedAt;

  late final _is.ColumnString metricName;

  late final _is.ColumnSerializable<Map<String, String>> dimensions;

  late final _is.ColumnDouble metricValue;

  late final _is.ColumnInt sampleCount;

  @override
  List<_is.Column> get columns => [
    id,
    bucketStartedAt,
    metricName,
    dimensions,
    metricValue,
    sampleCount,
  ];
}

class OperationalMetricRowInclude extends _is.IncludeObject {
  OperationalMetricRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => OperationalMetricRow.t;
}

class OperationalMetricRowIncludeList extends _is.IncludeList {
  OperationalMetricRowIncludeList._({
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OperationalMetricRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => OperationalMetricRow.t;
}

class OperationalMetricRowRepository {
  const OperationalMetricRowRepository._();

  /// Returns a list of [OperationalMetricRow]s matching the given query parameters.
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
  Future<List<OperationalMetricRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OperationalMetricRow>(
      where: where?.call(OperationalMetricRow.t),
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OperationalMetricRow] matching the given query parameters.
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
  Future<OperationalMetricRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? where,
    int? offset,
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OperationalMetricRow>(
      where: where?.call(OperationalMetricRow.t),
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OperationalMetricRow] by its [id] or null if no such row exists.
  Future<OperationalMetricRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OperationalMetricRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OperationalMetricRow]s in the list and returns the inserted rows.
  ///
  /// The returned [OperationalMetricRow]s will have their `id` fields set.
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
  Future<List<OperationalMetricRow>> insert(
    _is.DatabaseSession session,
    List<OperationalMetricRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<OperationalMetricRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [OperationalMetricRow] and returns the inserted row.
  ///
  /// The returned [OperationalMetricRow] will have its `id` field set.
  Future<OperationalMetricRow> insertRow(
    _is.DatabaseSession session,
    OperationalMetricRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<OperationalMetricRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [OperationalMetricRow]s in the list and returns the resulting rows.
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
  /// The returned [OperationalMetricRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OperationalMetricRow>> upsert(
    _is.DatabaseSession session,
    List<OperationalMetricRow> rows, {
    required _is.ColumnSelections<OperationalMetricRowTable> conflictColumns,
    _is.ColumnSelections<OperationalMetricRowTable>? updateColumns,
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<OperationalMetricRow>(
      rows,
      conflictColumns: conflictColumns(OperationalMetricRow.t),
      updateColumns: updateColumns?.call(OperationalMetricRow.t),
      updateWhere: updateWhere?.call(OperationalMetricRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [OperationalMetricRow] and returns the resulting row.
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
  /// The returned [OperationalMetricRow] will have its `id` field set.
  Future<OperationalMetricRow?> upsertRow(
    _is.DatabaseSession session,
    OperationalMetricRow row, {
    required _is.ColumnSelections<OperationalMetricRowTable> conflictColumns,
    _is.ColumnSelections<OperationalMetricRowTable>? updateColumns,
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<OperationalMetricRow>(
      row,
      conflictColumns: conflictColumns(OperationalMetricRow.t),
      updateColumns: updateColumns?.call(OperationalMetricRow.t),
      updateWhere: updateWhere?.call(OperationalMetricRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [OperationalMetricRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OperationalMetricRow>> update(
    _is.DatabaseSession session,
    List<OperationalMetricRow> rows, {
    _is.ColumnSelections<OperationalMetricRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<OperationalMetricRow>(
      rows,
      columns: columns?.call(OperationalMetricRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [OperationalMetricRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OperationalMetricRow> updateRow(
    _is.DatabaseSession session,
    OperationalMetricRow row, {
    _is.ColumnSelections<OperationalMetricRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<OperationalMetricRow>(
      row,
      columns: columns?.call(OperationalMetricRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OperationalMetricRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OperationalMetricRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<OperationalMetricRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<OperationalMetricRow>(
      id,
      columnValues: columnValues(OperationalMetricRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OperationalMetricRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<OperationalMetricRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OperationalMetricRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<OperationalMetricRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<OperationalMetricRow>(
      columnValues: columnValues(OperationalMetricRow.t.updateTable),
      where: where(OperationalMetricRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [OperationalMetricRow]s in the list and returns the deleted rows.
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
  Future<List<OperationalMetricRow>> delete(
    _is.DatabaseSession session,
    List<OperationalMetricRow> rows, {
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<OperationalMetricRow>(
      rows,
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [OperationalMetricRow].
  Future<OperationalMetricRow> deleteRow(
    _is.DatabaseSession session,
    OperationalMetricRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OperationalMetricRow>(
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
  Future<List<OperationalMetricRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OperationalMetricRowTable> where,
    _is.OrderByBuilder<OperationalMetricRowTable>? orderBy,
    _is.OrderByListBuilder<OperationalMetricRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<OperationalMetricRow>(
      where: where(OperationalMetricRow.t),
      orderBy: orderBy?.call(OperationalMetricRow.t),
      orderByList: orderByList?.call(OperationalMetricRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OperationalMetricRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<OperationalMetricRow>(
      where: where?.call(OperationalMetricRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OperationalMetricRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OperationalMetricRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OperationalMetricRow>(
      where: where(OperationalMetricRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
