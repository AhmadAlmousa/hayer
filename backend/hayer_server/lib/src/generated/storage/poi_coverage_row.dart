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
import 'package:serverpod/serverpod.dart' as _is;

abstract class PoiCoverageRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  PoiCoverageRow._({
    this.id,
    required this.coverageKey,
    required this.queryKey,
    required this.language,
    required this.countryCode,
    required this.anchorLatitude,
    required this.anchorLongitude,
    required this.location,
    required this.radiusMeters,
    required this.calibrationVersion,
    required this.resultCount,
    required this.refreshedAt,
    required this.expiresAt,
    this.lastFailureCode,
    this.invalidatedAt,
  });

  factory PoiCoverageRow({
    _is.UuidValue? id,
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required _is.GeographyPoint location,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      coverageKey: jsonSerialization['coverageKey'] as String,
      queryKey: jsonSerialization['queryKey'] as String,
      language: jsonSerialization['language'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      location: _is.GeographyPointJsonExtension.fromJson(
        jsonSerialization['location'],
      ),
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      resultCount: jsonSerialization['resultCount'] as int,
      refreshedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['refreshedAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      invalidatedAt: jsonSerialization['invalidatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['invalidatedAt'],
            ),
    );
  }

  static final t = PoiCoverageRowTable();

  static const db = PoiCoverageRowRepository._();

  @override
  _is.UuidValue? id;

  String coverageKey;

  String queryKey;

  String language;

  String countryCode;

  double anchorLatitude;

  double anchorLongitude;

  _is.GeographyPoint location;

  int radiusMeters;

  String calibrationVersion;

  int resultCount;

  DateTime refreshedAt;

  DateTime expiresAt;

  String? lastFailureCode;

  DateTime? invalidatedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCoverageRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiCoverageRow copyWith({
    _is.UuidValue? id,
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    _is.GeographyPoint? location,
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
      'location': location.toJson(),
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
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    PoiCoverageRowInclude? include,
  }) {
    return PoiCoverageRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCoverageRowImpl extends PoiCoverageRow {
  _PoiCoverageRowImpl({
    _is.UuidValue? id,
    required String coverageKey,
    required String queryKey,
    required String language,
    required String countryCode,
    required double anchorLatitude,
    required double anchorLongitude,
    required _is.GeographyPoint location,
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
         location: location,
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
  @_is.useResult
  @override
  PoiCoverageRow copyWith({
    Object? id = _Undefined,
    String? coverageKey,
    String? queryKey,
    String? language,
    String? countryCode,
    double? anchorLatitude,
    double? anchorLongitude,
    _is.GeographyPoint? location,
    int? radiusMeters,
    String? calibrationVersion,
    int? resultCount,
    DateTime? refreshedAt,
    DateTime? expiresAt,
    Object? lastFailureCode = _Undefined,
    Object? invalidatedAt = _Undefined,
  }) {
    return PoiCoverageRow(
      id: id is _is.UuidValue? ? id : this.id,
      coverageKey: coverageKey ?? this.coverageKey,
      queryKey: queryKey ?? this.queryKey,
      language: language ?? this.language,
      countryCode: countryCode ?? this.countryCode,
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      location: location ?? this.location,
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

class PoiCoverageRowUpdateTable extends _is.UpdateTable<PoiCoverageRowTable> {
  PoiCoverageRowUpdateTable(super.table);

  _is.ColumnValue<String, String> coverageKey(String value) => _is.ColumnValue(
    table.coverageKey,
    value,
  );

  _is.ColumnValue<String, String> queryKey(String value) => _is.ColumnValue(
    table.queryKey,
    value,
  );

  _is.ColumnValue<String, String> language(String value) => _is.ColumnValue(
    table.language,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<double, double> anchorLatitude(double value) =>
      _is.ColumnValue(
        table.anchorLatitude,
        value,
      );

  _is.ColumnValue<double, double> anchorLongitude(double value) =>
      _is.ColumnValue(
        table.anchorLongitude,
        value,
      );

  _is.ColumnValue<_is.GeographyPoint, _is.GeographyPoint> location(
    _is.GeographyPoint value,
  ) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<int, int> radiusMeters(int value) => _is.ColumnValue(
    table.radiusMeters,
    value,
  );

  _is.ColumnValue<String, String> calibrationVersion(String value) =>
      _is.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _is.ColumnValue<int, int> resultCount(int value) => _is.ColumnValue(
    table.resultCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> refreshedAt(DateTime value) =>
      _is.ColumnValue(
        table.refreshedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<String, String> lastFailureCode(String? value) =>
      _is.ColumnValue(
        table.lastFailureCode,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> invalidatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.invalidatedAt,
        value,
      );
}

class PoiCoverageRowTable extends _is.Table<_is.UuidValue?> {
  PoiCoverageRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_coverage') {
    updateTable = PoiCoverageRowUpdateTable(this);
    coverageKey = _is.ColumnString(
      'coverageKey',
      this,
    );
    queryKey = _is.ColumnString(
      'queryKey',
      this,
    );
    language = _is.ColumnString(
      'language',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    anchorLatitude = _is.ColumnDouble(
      'anchorLatitude',
      this,
    );
    anchorLongitude = _is.ColumnDouble(
      'anchorLongitude',
      this,
    );
    location = _is.ColumnGeographyPoint(
      'location',
      this,
    );
    radiusMeters = _is.ColumnInt(
      'radiusMeters',
      this,
    );
    calibrationVersion = _is.ColumnString(
      'calibrationVersion',
      this,
    );
    resultCount = _is.ColumnInt(
      'resultCount',
      this,
    );
    refreshedAt = _is.ColumnDateTime(
      'refreshedAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    lastFailureCode = _is.ColumnString(
      'lastFailureCode',
      this,
    );
    invalidatedAt = _is.ColumnDateTime(
      'invalidatedAt',
      this,
    );
  }

  late final PoiCoverageRowUpdateTable updateTable;

  late final _is.ColumnString coverageKey;

  late final _is.ColumnString queryKey;

  late final _is.ColumnString language;

  late final _is.ColumnString countryCode;

  late final _is.ColumnDouble anchorLatitude;

  late final _is.ColumnDouble anchorLongitude;

  late final _is.ColumnGeographyPoint location;

  late final _is.ColumnInt radiusMeters;

  late final _is.ColumnString calibrationVersion;

  late final _is.ColumnInt resultCount;

  late final _is.ColumnDateTime refreshedAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnString lastFailureCode;

  late final _is.ColumnDateTime invalidatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    coverageKey,
    queryKey,
    language,
    countryCode,
    anchorLatitude,
    anchorLongitude,
    location,
    radiusMeters,
    calibrationVersion,
    resultCount,
    refreshedAt,
    expiresAt,
    lastFailureCode,
    invalidatedAt,
  ];
}

class PoiCoverageRowInclude extends _is.IncludeObject {
  PoiCoverageRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCoverageRow.t;
}

class PoiCoverageRowIncludeList extends _is.IncludeList {
  PoiCoverageRowIncludeList._({
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCoverageRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCoverageRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCoverageRow] by its [id] or null if no such row exists.
  Future<PoiCoverageRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCoverageRow>> insert(
    _is.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoiCoverageRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoiCoverageRow] and returns the inserted row.
  ///
  /// The returned [PoiCoverageRow] will have its `id` field set.
  Future<PoiCoverageRow> insertRow(
    _is.DatabaseSession session,
    PoiCoverageRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCoverageRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoiCoverageRow]s in the list and returns the resulting rows.
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
  /// The returned [PoiCoverageRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCoverageRow>> upsert(
    _is.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    required _is.ColumnSelections<PoiCoverageRowTable> conflictColumns,
    _is.ColumnSelections<PoiCoverageRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoiCoverageRow>(
      rows,
      conflictColumns: conflictColumns(PoiCoverageRow.t),
      updateColumns: updateColumns?.call(PoiCoverageRow.t),
      updateWhere: updateWhere?.call(PoiCoverageRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoiCoverageRow] and returns the resulting row.
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
  /// The returned [PoiCoverageRow] will have its `id` field set.
  Future<PoiCoverageRow?> upsertRow(
    _is.DatabaseSession session,
    PoiCoverageRow row, {
    required _is.ColumnSelections<PoiCoverageRowTable> conflictColumns,
    _is.ColumnSelections<PoiCoverageRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoiCoverageRow>(
      row,
      conflictColumns: conflictColumns(PoiCoverageRow.t),
      updateColumns: updateColumns?.call(PoiCoverageRow.t),
      updateWhere: updateWhere?.call(PoiCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCoverageRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCoverageRow>> update(
    _is.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _is.ColumnSelections<PoiCoverageRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoiCoverageRow>(
      rows,
      columns: columns?.call(PoiCoverageRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoiCoverageRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCoverageRow> updateRow(
    _is.DatabaseSession session,
    PoiCoverageRow row, {
    _is.ColumnSelections<PoiCoverageRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PoiCoverageRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCoverageRow>(
      id,
      columnValues: columnValues(PoiCoverageRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCoverageRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCoverageRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoiCoverageRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PoiCoverageRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoiCoverageRow>(
      columnValues: columnValues(PoiCoverageRow.t.updateTable),
      where: where(PoiCoverageRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoiCoverageRow]s in the list and returns the deleted rows.
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
  Future<List<PoiCoverageRow>> delete(
    _is.DatabaseSession session,
    List<PoiCoverageRow> rows, {
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoiCoverageRow>(
      rows,
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoiCoverageRow].
  Future<PoiCoverageRow> deleteRow(
    _is.DatabaseSession session,
    PoiCoverageRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCoverageRow>(
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
  Future<List<PoiCoverageRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCoverageRowTable> where,
    _is.OrderByBuilder<PoiCoverageRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCoverageRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoiCoverageRow>(
      where: where(PoiCoverageRow.t),
      orderBy: orderBy?.call(PoiCoverageRow.t),
      orderByList: orderByList?.call(PoiCoverageRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCoverageRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoiCoverageRow>(
      where: where?.call(PoiCoverageRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCoverageRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCoverageRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCoverageRow>(
      where: where(PoiCoverageRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
