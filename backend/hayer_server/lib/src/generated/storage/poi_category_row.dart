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

abstract class PoiCategoryRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PoiCategoryRow._({
    this.id,
    required this.provider,
    required this.providerPlaceId,
    required this.categoryId,
    required this.evidenceQuery,
    required this.firstSeenAt,
    required this.lastSeenAt,
  });

  factory PoiCategoryRow({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) = _PoiCategoryRowImpl;

  factory PoiCategoryRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiCategoryRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
      categoryId: jsonSerialization['categoryId'] as String,
      evidenceQuery: jsonSerialization['evidenceQuery'] as String,
      firstSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  static final t = PoiCategoryRowTable();

  static const db = PoiCategoryRowRepository._();

  @override
  _i1.UuidValue? id;

  String provider;

  String providerPlaceId;

  String categoryId;

  String evidenceQuery;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCategoryRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PoiCategoryRow copyWith({
    _i1.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiCategoryRow',
      if (id != null) 'id': id?.toJson(),
      'provider': provider,
      'providerPlaceId': providerPlaceId,
      'categoryId': categoryId,
      'evidenceQuery': evidenceQuery,
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiCategoryRowInclude include() {
    return PoiCategoryRowInclude._();
  }

  static PoiCategoryRowIncludeList includeList({
    _i1.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    PoiCategoryRowInclude? include,
  }) {
    return PoiCategoryRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PoiCategoryRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCategoryRowImpl extends PoiCategoryRow {
  _PoiCategoryRowImpl({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required String categoryId,
    required String evidenceQuery,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         provider: provider,
         providerPlaceId: providerPlaceId,
         categoryId: categoryId,
         evidenceQuery: evidenceQuery,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [PoiCategoryRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PoiCategoryRow copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerPlaceId,
    String? categoryId,
    String? evidenceQuery,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
  }) {
    return PoiCategoryRow(
      id: id is _i1.UuidValue? ? id : this.id,
      provider: provider ?? this.provider,
      providerPlaceId: providerPlaceId ?? this.providerPlaceId,
      categoryId: categoryId ?? this.categoryId,
      evidenceQuery: evidenceQuery ?? this.evidenceQuery,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}

class PoiCategoryRowUpdateTable extends _i1.UpdateTable<PoiCategoryRowTable> {
  PoiCategoryRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> providerPlaceId(String value) =>
      _i1.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _i1.ColumnValue<String, String> categoryId(String value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<String, String> evidenceQuery(String value) =>
      _i1.ColumnValue(
        table.evidenceQuery,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> firstSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.firstSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );
}

class PoiCategoryRowTable extends _i1.Table<_i1.UuidValue?> {
  PoiCategoryRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_category') {
    updateTable = PoiCategoryRowUpdateTable(this);
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _i1.ColumnString(
      'providerPlaceId',
      this,
    );
    categoryId = _i1.ColumnString(
      'categoryId',
      this,
    );
    evidenceQuery = _i1.ColumnString(
      'evidenceQuery',
      this,
    );
    firstSeenAt = _i1.ColumnDateTime(
      'firstSeenAt',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
  }

  late final PoiCategoryRowUpdateTable updateTable;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString providerPlaceId;

  late final _i1.ColumnString categoryId;

  late final _i1.ColumnString evidenceQuery;

  late final _i1.ColumnDateTime firstSeenAt;

  late final _i1.ColumnDateTime lastSeenAt;

  @override
  List<_i1.Column> get columns => [
    id,
    provider,
    providerPlaceId,
    categoryId,
    evidenceQuery,
    firstSeenAt,
    lastSeenAt,
  ];
}

class PoiCategoryRowInclude extends _i1.IncludeObject {
  PoiCategoryRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCategoryRow.t;
}

class PoiCategoryRowIncludeList extends _i1.IncludeList {
  PoiCategoryRowIncludeList._({
    _i1.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCategoryRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCategoryRow.t;
}

class PoiCategoryRowRepository {
  const PoiCategoryRowRepository._();

  /// Returns a list of [PoiCategoryRow]s matching the given query parameters.
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
  Future<List<PoiCategoryRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiCategoryRow] matching the given query parameters.
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
  Future<PoiCategoryRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCategoryRow] by its [id] or null if no such row exists.
  Future<PoiCategoryRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiCategoryRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiCategoryRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiCategoryRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PoiCategoryRow>> insert(
    _i1.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PoiCategoryRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PoiCategoryRow] and returns the inserted row.
  ///
  /// The returned [PoiCategoryRow] will have its `id` field set.
  Future<PoiCategoryRow> insertRow(
    _i1.DatabaseSession session,
    PoiCategoryRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCategoryRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PoiCategoryRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PoiCategoryRow>> update(
    _i1.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _i1.ColumnSelections<PoiCategoryRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PoiCategoryRow>(
      rows,
      columns: columns?.call(PoiCategoryRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCategoryRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCategoryRow> updateRow(
    _i1.DatabaseSession session,
    PoiCategoryRow row, {
    _i1.ColumnSelections<PoiCategoryRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiCategoryRow>(
      row,
      columns: columns?.call(PoiCategoryRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCategoryRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiCategoryRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PoiCategoryRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCategoryRow>(
      id,
      columnValues: columnValues(PoiCategoryRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCategoryRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PoiCategoryRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PoiCategoryRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PoiCategoryRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCategoryRowTable>? orderBy,
    _i1.OrderByListBuilder<PoiCategoryRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PoiCategoryRow>(
      columnValues: columnValues(PoiCategoryRow.t.updateTable),
      where: where(PoiCategoryRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCategoryRow.t),
      orderByList: orderByList?.call(PoiCategoryRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PoiCategoryRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PoiCategoryRow>> delete(
    _i1.DatabaseSession session,
    List<PoiCategoryRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PoiCategoryRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PoiCategoryRow].
  Future<PoiCategoryRow> deleteRow(
    _i1.DatabaseSession session,
    PoiCategoryRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCategoryRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PoiCategoryRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCategoryRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PoiCategoryRow>(
      where: where(PoiCategoryRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCategoryRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PoiCategoryRow>(
      where: where?.call(PoiCategoryRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCategoryRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCategoryRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCategoryRow>(
      where: where(PoiCategoryRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
