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

abstract class PoiCoverageRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PoiCoverageRow._({
    this.id,
    required this.coverageKey,
    required this.queryKey,
    required this.language,
    required this.countryCode,
    required this.anchorLatitude,
    required this.anchorLongitude,
    required this.radiusMeters,
    required this.calibrationVersion,
    required this.resultCount,
    required this.refreshedAt,
    required this.expiresAt,
    this.lastFailureCode,
    this.invalidatedAt,
  });

  factory PoiCoverageRow({
    _i1.UuidValue? id,
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required int radiusMeters,
    required String calibrationVersion,
    required int resultCount,
    required DateTime refreshedAt,
    required DateTime expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  }) = _PoiCoverageRowImpl;

  factory PoiCoverageRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiCoverageRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      coverageKey: jsonSerialization['coverageKey'] as String,
      queryKey: jsonSerialization['queryKey'] as String,
      language: jsonSerialization['language'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      resultCount: jsonSerialization['resultCount'] as int,
      refreshedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['refreshedAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      invalidatedAt: jsonSerialization['invalidatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['invalidatedAt'],
            ),
    );
  }

  static final t = PoiCoverageRowTable();

  static const db = PoiCoverageRowRepository._();

  @override
  _i1.UuidValue? id;

  String coverageKey;

  String queryKey;

  String language;

  String countryCode;

  double anchorLatitude;

  double anchorLongitude;

  int radiusMeters;

  String calibrationVersion;

  int resultCount;

  DateTime refreshedAt;

  DateTime expiresAt;

  String? lastFailureCode;

  DateTime? invalidatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCoverageRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PoiCoverageRow copyWith({
    _i1.UuidValue? id,
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    int? radiusMeters,
    String? calibrationVersion,
    int? resultCount,
    DateTime? refreshedAt,
    DateTime? expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiCoverageRow',
      if (id != null) 'id': id?.toJson(),
      'coverageKey': coverageKey,
      'queryKey': queryKey,
      'language': language,
      'countryCode': countryCode,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      'radiusMeters': radiusMeters,
      'calibrationVersion': calibrationVersion,
      'resultCount': resultCount,
      'refreshedAt': refreshedAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      if (invalidatedAt != null) 'invalidatedAt': invalidatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiCoverageRowInclude include() {
    return PoiCoverageRowInclude._();
  }

  static PoiCoverageRowIncludeList includeList({
    _i1.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    PoiCoverageRowInclude? include,
  }) {
    return PoiCoverageRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PoiCoverageRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCoverageRowImpl extends PoiCoverageRow {
  _PoiCoverageRowImpl({
    _i1.UuidValue? id,
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required int radiusMeters,
    required String calibrationVersion,
    required int resultCount,
    required DateTime refreshedAt,
    required DateTime expiresAt,
    String? lastFailureCode,
    DateTime? invalidatedAt,
  }) : super._(
         id: id,
         coverageKey: coverageKey,
         queryKey: queryKey,
         language: language,
         countryCode: countryCode,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         radiusMeters: radiusMeters,
         calibrationVersion: calibrationVersion,
         resultCount: resultCount,
         refreshedAt: refreshedAt,
         expiresAt: expiresAt,
         lastFailureCode: lastFailureCode,
         invalidatedAt: invalidatedAt,
       );

  /// Returns a shallow copy of this [PoiCoverageRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PoiCoverageRow copyWith({
    Object? id = _Undefined,
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    int? radiusMeters,
    String? calibrationVersion,
    int? resultCount,
    DateTime? refreshedAt,
    DateTime? expiresAt,
    Object? lastFailureCode = _Undefined,
    Object? invalidatedAt = _Undefined,
  }) {
    return PoiCoverageRow(
      id: id is _i1.UuidValue? ? id : this.id,
      coverageKey: coverageKey ?? this.coverageKey,
      queryKey: queryKey ?? this.queryKey,
      language: language ?? this.language,
      countryCode: countryCode ?? this.countryCode,
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      resultCount: resultCount ?? this.resultCount,
      refreshedAt: refreshedAt ?? this.refreshedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      lastFailureCode: lastFailureCode is String?
          ? lastFailureCode
          : this.lastFailureCode,
      invalidatedAt: invalidatedAt is DateTime?
          ? invalidatedAt
          : this.invalidatedAt,
    );
  }
}

class PoiCoverageRowUpdateTable extends _i1.UpdateTable<PoiCoverageRowTable> {
  PoiCoverageRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> coverageKey(String value) => _i1.ColumnValue(
    table.coverageKey,
    value,
  );

  _i1.ColumnValue<String, String> queryKey(String value) => _i1.ColumnValue(
    table.queryKey,
    value,
  );

  _i1.ColumnValue<String, String> language(String value) => _i1.ColumnValue(
    table.language,
    value,
  );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<double, double> anchorLatitude(double value) =>
      _i1.ColumnValue(
        table.anchorLatitude,
        value,
      );

  _i1.ColumnValue<double, double> anchorLongitude(double value) =>
      _i1.ColumnValue(
        table.anchorLongitude,
        value,
      );

  _i1.ColumnValue<int, int> radiusMeters(int value) => _i1.ColumnValue(
    table.radiusMeters,
    value,
  );

  _i1.ColumnValue<String, String> calibrationVersion(String value) =>
      _i1.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _i1.ColumnValue<int, int> resultCount(int value) => _i1.ColumnValue(
    table.resultCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> refreshedAt(DateTime value) =>
      _i1.ColumnValue(
        table.refreshedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );

  _i1.ColumnValue<String, String> lastFailureCode(String? value) =>
      _i1.ColumnValue(
        table.lastFailureCode,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> invalidatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.invalidatedAt,
        value,
      );
}

class PoiCoverageRowTable extends _i1.Table<_i1.UuidValue?> {
  PoiCoverageRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_coverage') {
    updateTable = PoiCoverageRowUpdateTable(this);
    coverageKey = _i1.ColumnString(
      'coverageKey',
      this,
    );
    queryKey = _i1.ColumnString(
      'queryKey',
      this,
    );
    language = _i1.ColumnString(
      'language',
      this,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    anchorLatitude = _i1.ColumnDouble(
      'anchorLatitude',
      this,
    );
    anchorLongitude = _i1.ColumnDouble(
      'anchorLongitude',
      this,
    );
    radiusMeters = _i1.ColumnInt(
      'radiusMeters',
      this,
    );
    calibrationVersion = _i1.ColumnString(
      'calibrationVersion',
      this,
    );
    resultCount = _i1.ColumnInt(
      'resultCount',
      this,
    );
    refreshedAt = _i1.ColumnDateTime(
      'refreshedAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
    lastFailureCode = _i1.ColumnString(
      'lastFailureCode',
      this,
    );
    invalidatedAt = _i1.ColumnDateTime(
      'invalidatedAt',
      this,
    );
  }

  late final PoiCoverageRowUpdateTable updateTable;

  late final _i1.ColumnString coverageKey;

  late final _i1.ColumnString queryKey;

  late final _i1.ColumnString language;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnDouble anchorLatitude;

  late final _i1.ColumnDouble anchorLongitude;

  late final _i1.ColumnInt radiusMeters;

  late final _i1.ColumnString calibrationVersion;

  late final _i1.ColumnInt resultCount;

  late final _i1.ColumnDateTime refreshedAt;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnString lastFailureCode;

  late final _i1.ColumnDateTime invalidatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    coverageKey,
    queryKey,
    language,
    countryCode,
    anchorLatitude,
    anchorLongitude,
    radiusMeters,
    calibrationVersion,
    resultCount,
    refreshedAt,
    expiresAt,
    lastFailureCode,
    invalidatedAt,
  ];
}

class PoiCoverageRowInclude extends _i1.IncludeObject {
  PoiCoverageRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCoverageRow.t;
}

class PoiCoverageRowIncludeList extends _i1.IncludeList {
  PoiCoverageRowIncludeList._({
    _i1.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCoverageRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCoverageRow.t;
}

class PoiCoverageRowRepository {
  const PoiCoverageRowRepository._();

  /// Returns a list of [PoiCoverageRow]s matching the given query parameters.
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
  Future<List<PoiCoverageRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiCoverageRow] matching the given query parameters.
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
  Future<PoiCoverageRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCoverageRow] by its [id] or null if no such row exists.
  Future<PoiCoverageRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiCoverageRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiCoverageRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiCoverageRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PoiCoverageRow>> insert(
    _i1.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PoiCoverageRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PoiCoverageRow] and returns the inserted row.
  ///
  /// The returned [PoiCoverageRow] will have its `id` field set.
  Future<PoiCoverageRow> insertRow(
    _i1.DatabaseSession session,
    PoiCoverageRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCoverageRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PoiCoverageRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PoiCoverageRow>> update(
    _i1.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _i1.ColumnSelections<PoiCoverageRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PoiCoverageRow>(
      rows,
      columns: columns?.call(PoiCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCoverageRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCoverageRow> updateRow(
    _i1.DatabaseSession session,
    PoiCoverageRow row, {
    _i1.ColumnSelections<PoiCoverageRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiCoverageRow>(
      row,
      columns: columns?.call(PoiCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCoverageRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiCoverageRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PoiCoverageRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCoverageRow>(
      id,
      columnValues: columnValues(PoiCoverageRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCoverageRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PoiCoverageRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PoiCoverageRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PoiCoverageRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _i1.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PoiCoverageRow>(
      columnValues: columnValues(PoiCoverageRow.t.updateTable),
      where: where(PoiCoverageRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PoiCoverageRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PoiCoverageRow>> delete(
    _i1.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PoiCoverageRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PoiCoverageRow].
  Future<PoiCoverageRow> deleteRow(
    _i1.DatabaseSession session,
    PoiCoverageRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCoverageRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PoiCoverageRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCoverageRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PoiCoverageRow>(
      where: where(PoiCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCoverageRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCoverageRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCoverageRow>(
      where: where(PoiCoverageRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
