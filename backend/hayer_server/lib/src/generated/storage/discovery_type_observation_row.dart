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

abstract class DiscoveryTypeObservationRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscoveryTypeObservationRow._({
    this.id,
    required this.typeKey,
    required this.primaryType,
    required this.observationCount,
    required this.firstObservedAt,
    required this.lastObservedAt,
  });

  factory DiscoveryTypeObservationRow({
    int? id,
    required String typeKey,
    required String primaryType,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
  }) = _DiscoveryTypeObservationRowImpl;

  factory DiscoveryTypeObservationRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTypeObservationRow(
      id: jsonSerialization['id'] as int?,
      typeKey: jsonSerialization['typeKey'] as String,
      primaryType: jsonSerialization['primaryType'] as String,
      observationCount: jsonSerialization['observationCount'] as int,
      firstObservedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstObservedAt'],
      ),
      lastObservedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastObservedAt'],
      ),
    );
  }

  static final t = DiscoveryTypeObservationRowTable();

  static const db = DiscoveryTypeObservationRowRepository._();

  @override
  int? id;

  String typeKey;

  String primaryType;

  int observationCount;

  DateTime firstObservedAt;

  DateTime lastObservedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTypeObservationRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryTypeObservationRow copyWith({
    int? id,
    String? typeKey,
    String? primaryType,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTypeObservationRow',
      if (id != null) 'id': id,
      'typeKey': typeKey,
      'primaryType': primaryType,
      'observationCount': observationCount,
      'firstObservedAt': firstObservedAt.toJson(),
      'lastObservedAt': lastObservedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryTypeObservationRowInclude include() {
    return DiscoveryTypeObservationRowInclude._();
  }

  static DiscoveryTypeObservationRowIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    DiscoveryTypeObservationRowInclude? include,
  }) {
    return DiscoveryTypeObservationRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTypeObservationRowImpl extends DiscoveryTypeObservationRow {
  _DiscoveryTypeObservationRowImpl({
    int? id,
    required String typeKey,
    required String primaryType,
    required int observationCount,
    required DateTime firstObservedAt,
    required DateTime lastObservedAt,
  }) : super._(
         id: id,
         typeKey: typeKey,
         primaryType: primaryType,
         observationCount: observationCount,
         firstObservedAt: firstObservedAt,
         lastObservedAt: lastObservedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTypeObservationRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryTypeObservationRow copyWith({
    Object? id = _Undefined,
    String? typeKey,
    String? primaryType,
    int? observationCount,
    DateTime? firstObservedAt,
    DateTime? lastObservedAt,
  }) {
    return DiscoveryTypeObservationRow(
      id: id is int? ? id : this.id,
      typeKey: typeKey ?? this.typeKey,
      primaryType: primaryType ?? this.primaryType,
      observationCount: observationCount ?? this.observationCount,
      firstObservedAt: firstObservedAt ?? this.firstObservedAt,
      lastObservedAt: lastObservedAt ?? this.lastObservedAt,
    );
  }
}

class DiscoveryTypeObservationRowUpdateTable
    extends _i1.UpdateTable<DiscoveryTypeObservationRowTable> {
  DiscoveryTypeObservationRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> typeKey(String value) => _i1.ColumnValue(
    table.typeKey,
    value,
  );

  _i1.ColumnValue<String, String> primaryType(String value) => _i1.ColumnValue(
    table.primaryType,
    value,
  );

  _i1.ColumnValue<int, int> observationCount(int value) => _i1.ColumnValue(
    table.observationCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> firstObservedAt(DateTime value) =>
      _i1.ColumnValue(
        table.firstObservedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastObservedAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastObservedAt,
        value,
      );
}

class DiscoveryTypeObservationRowTable extends _i1.Table<int?> {
  DiscoveryTypeObservationRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_type_observation') {
    updateTable = DiscoveryTypeObservationRowUpdateTable(this);
    typeKey = _i1.ColumnString(
      'typeKey',
      this,
    );
    primaryType = _i1.ColumnString(
      'primaryType',
      this,
    );
    observationCount = _i1.ColumnInt(
      'observationCount',
      this,
    );
    firstObservedAt = _i1.ColumnDateTime(
      'firstObservedAt',
      this,
    );
    lastObservedAt = _i1.ColumnDateTime(
      'lastObservedAt',
      this,
    );
  }

  late final DiscoveryTypeObservationRowUpdateTable updateTable;

  late final _i1.ColumnString typeKey;

  late final _i1.ColumnString primaryType;

  late final _i1.ColumnInt observationCount;

  late final _i1.ColumnDateTime firstObservedAt;

  late final _i1.ColumnDateTime lastObservedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    typeKey,
    primaryType,
    observationCount,
    firstObservedAt,
    lastObservedAt,
  ];
}

class DiscoveryTypeObservationRowInclude extends _i1.IncludeObject {
  DiscoveryTypeObservationRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryTypeObservationRow.t;
}

class DiscoveryTypeObservationRowIncludeList extends _i1.IncludeList {
  DiscoveryTypeObservationRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTypeObservationRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryTypeObservationRow.t;
}

class DiscoveryTypeObservationRowRepository {
  const DiscoveryTypeObservationRowRepository._();

  /// Returns a list of [DiscoveryTypeObservationRow]s matching the given query parameters.
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
  Future<List<DiscoveryTypeObservationRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTypeObservationRow] matching the given query parameters.
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
  Future<DiscoveryTypeObservationRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTypeObservationRow] by its [id] or null if no such row exists.
  Future<DiscoveryTypeObservationRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTypeObservationRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTypeObservationRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTypeObservationRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscoveryTypeObservationRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryTypeObservationRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryTypeObservationRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTypeObservationRow] will have its `id` field set.
  Future<DiscoveryTypeObservationRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTypeObservationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeObservationRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryTypeObservationRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _i1.ColumnSelections<DiscoveryTypeObservationRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryTypeObservationRow>(
      rows,
      columns: columns?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeObservationRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTypeObservationRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _i1.ColumnSelections<DiscoveryTypeObservationRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTypeObservationRow>(
      row,
      columns: columns?.call(DiscoveryTypeObservationRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeObservationRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTypeObservationRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryTypeObservationRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTypeObservationRow>(
      id,
      columnValues: columnValues(DiscoveryTypeObservationRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeObservationRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryTypeObservationRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryTypeObservationRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeObservationRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryTypeObservationRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryTypeObservationRow>(
      columnValues: columnValues(DiscoveryTypeObservationRow.t.updateTable),
      where: where(DiscoveryTypeObservationRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeObservationRow.t),
      orderByList: orderByList?.call(DiscoveryTypeObservationRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryTypeObservationRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryTypeObservationRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryTypeObservationRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryTypeObservationRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryTypeObservationRow].
  Future<DiscoveryTypeObservationRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryTypeObservationRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTypeObservationRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryTypeObservationRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryTypeObservationRow>(
      where: where(DiscoveryTypeObservationRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTypeObservationRow>(
      where: where?.call(DiscoveryTypeObservationRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTypeObservationRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTypeObservationRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTypeObservationRow>(
      where: where(DiscoveryTypeObservationRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
