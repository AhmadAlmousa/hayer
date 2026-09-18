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

/// What the Discover type auto-mapper has assigned, so an operator can see
/// which aliases the mapper chose rather than a person, and move the ones it
/// got wrong. One row per observed type; a later run overwrites its own row.
abstract class DiscoveryTypeAutoMapRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscoveryTypeAutoMapRow._({
    this.id,
    required this.typeKey,
    required this.primaryType,
    required this.nodeId,
    required this.rule,
    required this.mappedAt,
  });

  factory DiscoveryTypeAutoMapRow({
    int? id,
    required String typeKey,
    required String primaryType,
    required String nodeId,
    required String rule,
    required DateTime mappedAt,
  }) = _DiscoveryTypeAutoMapRowImpl;

  factory DiscoveryTypeAutoMapRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTypeAutoMapRow(
      id: jsonSerialization['id'] as int?,
      typeKey: jsonSerialization['typeKey'] as String,
      primaryType: jsonSerialization['primaryType'] as String,
      nodeId: jsonSerialization['nodeId'] as String,
      rule: jsonSerialization['rule'] as String,
      mappedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['mappedAt'],
      ),
    );
  }

  static final t = DiscoveryTypeAutoMapRowTable();

  static const db = DiscoveryTypeAutoMapRowRepository._();

  @override
  int? id;

  String typeKey;

  String primaryType;

  String nodeId;

  String rule;

  DateTime mappedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTypeAutoMapRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryTypeAutoMapRow copyWith({
    int? id,
    String? typeKey,
    String? primaryType,
    String? nodeId,
    String? rule,
    DateTime? mappedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryTypeAutoMapRow',
      if (id != null) 'id': id,
      'typeKey': typeKey,
      'primaryType': primaryType,
      'nodeId': nodeId,
      'rule': rule,
      'mappedAt': mappedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryTypeAutoMapRowInclude include() {
    return DiscoveryTypeAutoMapRowInclude._();
  }

  static DiscoveryTypeAutoMapRowIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    DiscoveryTypeAutoMapRowInclude? include,
  }) {
    return DiscoveryTypeAutoMapRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTypeAutoMapRowImpl extends DiscoveryTypeAutoMapRow {
  _DiscoveryTypeAutoMapRowImpl({
    int? id,
    required String typeKey,
    required String primaryType,
    required String nodeId,
    required String rule,
    required DateTime mappedAt,
  }) : super._(
         id: id,
         typeKey: typeKey,
         primaryType: primaryType,
         nodeId: nodeId,
         rule: rule,
         mappedAt: mappedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTypeAutoMapRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryTypeAutoMapRow copyWith({
    Object? id = _Undefined,
    String? typeKey,
    String? primaryType,
    String? nodeId,
    String? rule,
    DateTime? mappedAt,
  }) {
    return DiscoveryTypeAutoMapRow(
      id: id is int? ? id : this.id,
      typeKey: typeKey ?? this.typeKey,
      primaryType: primaryType ?? this.primaryType,
      nodeId: nodeId ?? this.nodeId,
      rule: rule ?? this.rule,
      mappedAt: mappedAt ?? this.mappedAt,
    );
  }
}

class DiscoveryTypeAutoMapRowUpdateTable
    extends _i1.UpdateTable<DiscoveryTypeAutoMapRowTable> {
  DiscoveryTypeAutoMapRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> typeKey(String value) => _i1.ColumnValue(
    table.typeKey,
    value,
  );

  _i1.ColumnValue<String, String> primaryType(String value) => _i1.ColumnValue(
    table.primaryType,
    value,
  );

  _i1.ColumnValue<String, String> nodeId(String value) => _i1.ColumnValue(
    table.nodeId,
    value,
  );

  _i1.ColumnValue<String, String> rule(String value) => _i1.ColumnValue(
    table.rule,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> mappedAt(DateTime value) =>
      _i1.ColumnValue(
        table.mappedAt,
        value,
      );
}

class DiscoveryTypeAutoMapRowTable extends _i1.Table<int?> {
  DiscoveryTypeAutoMapRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_type_automap') {
    updateTable = DiscoveryTypeAutoMapRowUpdateTable(this);
    typeKey = _i1.ColumnString(
      'typeKey',
      this,
    );
    primaryType = _i1.ColumnString(
      'primaryType',
      this,
    );
    nodeId = _i1.ColumnString(
      'nodeId',
      this,
    );
    rule = _i1.ColumnString(
      'rule',
      this,
    );
    mappedAt = _i1.ColumnDateTime(
      'mappedAt',
      this,
    );
  }

  late final DiscoveryTypeAutoMapRowUpdateTable updateTable;

  late final _i1.ColumnString typeKey;

  late final _i1.ColumnString primaryType;

  late final _i1.ColumnString nodeId;

  late final _i1.ColumnString rule;

  late final _i1.ColumnDateTime mappedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    typeKey,
    primaryType,
    nodeId,
    rule,
    mappedAt,
  ];
}

class DiscoveryTypeAutoMapRowInclude extends _i1.IncludeObject {
  DiscoveryTypeAutoMapRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryTypeAutoMapRow.t;
}

class DiscoveryTypeAutoMapRowIncludeList extends _i1.IncludeList {
  DiscoveryTypeAutoMapRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTypeAutoMapRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryTypeAutoMapRow.t;
}

class DiscoveryTypeAutoMapRowRepository {
  const DiscoveryTypeAutoMapRowRepository._();

  /// Returns a list of [DiscoveryTypeAutoMapRow]s matching the given query parameters.
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
  Future<List<DiscoveryTypeAutoMapRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTypeAutoMapRow] matching the given query parameters.
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
  Future<DiscoveryTypeAutoMapRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTypeAutoMapRow] by its [id] or null if no such row exists.
  Future<DiscoveryTypeAutoMapRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTypeAutoMapRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTypeAutoMapRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTypeAutoMapRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscoveryTypeAutoMapRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryTypeAutoMapRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryTypeAutoMapRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTypeAutoMapRow] will have its `id` field set.
  Future<DiscoveryTypeAutoMapRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTypeAutoMapRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeAutoMapRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryTypeAutoMapRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _i1.ColumnSelections<DiscoveryTypeAutoMapRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryTypeAutoMapRow>(
      rows,
      columns: columns?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeAutoMapRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTypeAutoMapRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _i1.ColumnSelections<DiscoveryTypeAutoMapRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTypeAutoMapRow>(
      row,
      columns: columns?.call(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTypeAutoMapRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTypeAutoMapRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryTypeAutoMapRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTypeAutoMapRow>(
      id,
      columnValues: columnValues(DiscoveryTypeAutoMapRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTypeAutoMapRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryTypeAutoMapRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryTypeAutoMapRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTypeAutoMapRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryTypeAutoMapRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryTypeAutoMapRow>(
      columnValues: columnValues(DiscoveryTypeAutoMapRow.t.updateTable),
      where: where(DiscoveryTypeAutoMapRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTypeAutoMapRow.t),
      orderByList: orderByList?.call(DiscoveryTypeAutoMapRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryTypeAutoMapRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryTypeAutoMapRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryTypeAutoMapRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryTypeAutoMapRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryTypeAutoMapRow].
  Future<DiscoveryTypeAutoMapRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryTypeAutoMapRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTypeAutoMapRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryTypeAutoMapRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryTypeAutoMapRow>(
      where: where(DiscoveryTypeAutoMapRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTypeAutoMapRow>(
      where: where?.call(DiscoveryTypeAutoMapRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTypeAutoMapRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTypeAutoMapRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTypeAutoMapRow>(
      where: where(DiscoveryTypeAutoMapRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
