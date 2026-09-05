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

abstract class CityResolutionRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CityResolutionRow._({
    this.id,
    required this.cellKey,
    required this.countryCode,
    required this.cityKey,
    required this.cityName,
    this.regionName,
    required this.resolvedAt,
    required this.expiresAt,
  });

  factory CityResolutionRow({
    int? id,
    required String cellKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    String? regionName,
    required DateTime resolvedAt,
    required DateTime expiresAt,
  }) = _CityResolutionRowImpl;

  factory CityResolutionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CityResolutionRow(
      id: jsonSerialization['id'] as int?,
      cellKey: jsonSerialization['cellKey'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      cityKey: jsonSerialization['cityKey'] as String,
      cityName: jsonSerialization['cityName'] as String,
      regionName: jsonSerialization['regionName'] as String?,
      resolvedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['resolvedAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = CityResolutionRowTable();

  static const db = CityResolutionRowRepository._();

  @override
  int? id;

  String cellKey;

  String countryCode;

  String cityKey;

  String cityName;

  String? regionName;

  DateTime resolvedAt;

  DateTime expiresAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CityResolutionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CityResolutionRow copyWith({
    int? id,
    String? cellKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    String? regionName,
    DateTime? resolvedAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CityResolutionRow',
      if (id != null) 'id': id,
      'cellKey': cellKey,
      'countryCode': countryCode,
      'cityKey': cityKey,
      'cityName': cityName,
      if (regionName != null) 'regionName': regionName,
      'resolvedAt': resolvedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CityResolutionRowInclude include() {
    return CityResolutionRowInclude._();
  }

  static CityResolutionRowIncludeList includeList({
    _i1.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityResolutionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    CityResolutionRowInclude? include,
  }) {
    return CityResolutionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CityResolutionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CityResolutionRowImpl extends CityResolutionRow {
  _CityResolutionRowImpl({
    int? id,
    required String cellKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    String? regionName,
    required DateTime resolvedAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         cellKey: cellKey,
         countryCode: countryCode,
         cityKey: cityKey,
         cityName: cityName,
         regionName: regionName,
         resolvedAt: resolvedAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [CityResolutionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CityResolutionRow copyWith({
    Object? id = _Undefined,
    String? cellKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    Object? regionName = _Undefined,
    DateTime? resolvedAt,
    DateTime? expiresAt,
  }) {
    return CityResolutionRow(
      id: id is int? ? id : this.id,
      cellKey: cellKey ?? this.cellKey,
      countryCode: countryCode ?? this.countryCode,
      cityKey: cityKey ?? this.cityKey,
      cityName: cityName ?? this.cityName,
      regionName: regionName is String? ? regionName : this.regionName,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class CityResolutionRowUpdateTable
    extends _i1.UpdateTable<CityResolutionRowTable> {
  CityResolutionRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> cellKey(String value) => _i1.ColumnValue(
    table.cellKey,
    value,
  );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<String, String> cityKey(String value) => _i1.ColumnValue(
    table.cityKey,
    value,
  );

  _i1.ColumnValue<String, String> cityName(String value) => _i1.ColumnValue(
    table.cityName,
    value,
  );

  _i1.ColumnValue<String, String> regionName(String? value) => _i1.ColumnValue(
    table.regionName,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class CityResolutionRowTable extends _i1.Table<int?> {
  CityResolutionRowTable({super.tableRelation})
    : super(tableName: 'hayer_city_resolution') {
    updateTable = CityResolutionRowUpdateTable(this);
    cellKey = _i1.ColumnString(
      'cellKey',
      this,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    cityKey = _i1.ColumnString(
      'cityKey',
      this,
    );
    cityName = _i1.ColumnString(
      'cityName',
      this,
    );
    regionName = _i1.ColumnString(
      'regionName',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final CityResolutionRowUpdateTable updateTable;

  late final _i1.ColumnString cellKey;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnString cityKey;

  late final _i1.ColumnString cityName;

  late final _i1.ColumnString regionName;

  late final _i1.ColumnDateTime resolvedAt;

  late final _i1.ColumnDateTime expiresAt;

  @override
  List<_i1.Column> get columns => [
    id,
    cellKey,
    countryCode,
    cityKey,
    cityName,
    regionName,
    resolvedAt,
    expiresAt,
  ];
}

class CityResolutionRowInclude extends _i1.IncludeObject {
  CityResolutionRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CityResolutionRow.t;
}

class CityResolutionRowIncludeList extends _i1.IncludeList {
  CityResolutionRowIncludeList._({
    _i1.WhereExpressionBuilder<CityResolutionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CityResolutionRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CityResolutionRow.t;
}

class CityResolutionRowRepository {
  const CityResolutionRowRepository._();

  /// Returns a list of [CityResolutionRow]s matching the given query parameters.
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
  Future<List<CityResolutionRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityResolutionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CityResolutionRow] matching the given query parameters.
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
  Future<CityResolutionRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CityResolutionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CityResolutionRow] by its [id] or null if no such row exists.
  Future<CityResolutionRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CityResolutionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CityResolutionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CityResolutionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CityResolutionRow>> insert(
    _i1.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CityResolutionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CityResolutionRow] and returns the inserted row.
  ///
  /// The returned [CityResolutionRow] will have its `id` field set.
  Future<CityResolutionRow> insertRow(
    _i1.DatabaseSession session,
    CityResolutionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CityResolutionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CityResolutionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CityResolutionRow>> update(
    _i1.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _i1.ColumnSelections<CityResolutionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CityResolutionRow>(
      rows,
      columns: columns?.call(CityResolutionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CityResolutionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CityResolutionRow> updateRow(
    _i1.DatabaseSession session,
    CityResolutionRow row, {
    _i1.ColumnSelections<CityResolutionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CityResolutionRow>(
      row,
      columns: columns?.call(CityResolutionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CityResolutionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CityResolutionRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<CityResolutionRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CityResolutionRow>(
      id,
      columnValues: columnValues(CityResolutionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CityResolutionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CityResolutionRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CityResolutionRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CityResolutionRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CityResolutionRowTable>? orderBy,
    _i1.OrderByListBuilder<CityResolutionRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CityResolutionRow>(
      columnValues: columnValues(CityResolutionRow.t.updateTable),
      where: where(CityResolutionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CityResolutionRow.t),
      orderByList: orderByList?.call(CityResolutionRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CityResolutionRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CityResolutionRow>> delete(
    _i1.DatabaseSession session,
    List<CityResolutionRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CityResolutionRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CityResolutionRow].
  Future<CityResolutionRow> deleteRow(
    _i1.DatabaseSession session,
    CityResolutionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CityResolutionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CityResolutionRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CityResolutionRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CityResolutionRow>(
      where: where(CityResolutionRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CityResolutionRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CityResolutionRow>(
      where: where?.call(CityResolutionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CityResolutionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CityResolutionRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CityResolutionRow>(
      where: where(CityResolutionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
