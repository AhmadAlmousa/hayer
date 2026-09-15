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

abstract class DiscoveryCoverageRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscoveryCoverageRow._({
    this.id,
    required this.countryCode,
    required this.cellId,
    required this.radiusMeters,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.south,
    required this.west,
    required this.north,
    required this.east,
    required this.manifestRevision,
    required this.queryCompletedAt,
    this.lastAttemptAt,
    this.lastSuccessAt,
    this.lastJobId,
    this.lastFailureCode,
    required this.updatedAt,
  });

  factory DiscoveryCoverageRow({
    int? id,
    required String countryCode,
    required String cellId,
    required int radiusMeters,
    required double centerLatitude,
    required double centerLongitude,
    required double south,
    required double west,
    required double north,
    required double east,
    required int manifestRevision,
    required Map<String, DateTime> queryCompletedAt,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    String? lastJobId,
    String? lastFailureCode,
    required DateTime updatedAt,
  }) = _DiscoveryCoverageRowImpl;

  factory DiscoveryCoverageRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryCoverageRow(
      id: jsonSerialization['id'] as int?,
      countryCode: jsonSerialization['countryCode'] as String,
      cellId: jsonSerialization['cellId'] as String,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      centerLatitude: (jsonSerialization['centerLatitude'] as num).toDouble(),
      centerLongitude: (jsonSerialization['centerLongitude'] as num).toDouble(),
      south: (jsonSerialization['south'] as num).toDouble(),
      west: (jsonSerialization['west'] as num).toDouble(),
      north: (jsonSerialization['north'] as num).toDouble(),
      east: (jsonSerialization['east'] as num).toDouble(),
      manifestRevision: jsonSerialization['manifestRevision'] as int,
      queryCompletedAt: _i2.Protocol().deserialize<Map<String, DateTime>>(
        jsonSerialization['queryCompletedAt'],
      ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      lastJobId: jsonSerialization['lastJobId'] as String?,
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = DiscoveryCoverageRowTable();

  static const db = DiscoveryCoverageRowRepository._();

  @override
  int? id;

  String countryCode;

  String cellId;

  int radiusMeters;

  double centerLatitude;

  double centerLongitude;

  double south;

  double west;

  double north;

  double east;

  int manifestRevision;

  Map<String, DateTime> queryCompletedAt;

  DateTime? lastAttemptAt;

  DateTime? lastSuccessAt;

  String? lastJobId;

  String? lastFailureCode;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryCoverageRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryCoverageRow copyWith({
    int? id,
    String? countryCode,
    String? cellId,
    int? radiusMeters,
    double? centerLatitude,
    double? centerLongitude,
    double? south,
    double? west,
    double? north,
    double? east,
    int? manifestRevision,
    Map<String, DateTime>? queryCompletedAt,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    String? lastJobId,
    String? lastFailureCode,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryCoverageRow',
      if (id != null) 'id': id,
      'countryCode': countryCode,
      'cellId': cellId,
      'radiusMeters': radiusMeters,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'south': south,
      'west': west,
      'north': north,
      'east': east,
      'manifestRevision': manifestRevision,
      'queryCompletedAt': queryCompletedAt.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (lastJobId != null) 'lastJobId': lastJobId,
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryCoverageRowInclude include() {
    return DiscoveryCoverageRowInclude._();
  }

  static DiscoveryCoverageRowIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryCoverageRowTable>? orderByList,
    DiscoveryCoverageRowInclude? include,
  }) {
    return DiscoveryCoverageRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryCoverageRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryCoverageRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryCoverageRowImpl extends DiscoveryCoverageRow {
  _DiscoveryCoverageRowImpl({
    int? id,
    required String countryCode,
    required String cellId,
    required int radiusMeters,
    required double centerLatitude,
    required double centerLongitude,
    required double south,
    required double west,
    required double north,
    required double east,
    required int manifestRevision,
    required Map<String, DateTime> queryCompletedAt,
    DateTime? lastAttemptAt,
    DateTime? lastSuccessAt,
    String? lastJobId,
    String? lastFailureCode,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         countryCode: countryCode,
         cellId: cellId,
         radiusMeters: radiusMeters,
         centerLatitude: centerLatitude,
         centerLongitude: centerLongitude,
         south: south,
         west: west,
         north: north,
         east: east,
         manifestRevision: manifestRevision,
         queryCompletedAt: queryCompletedAt,
         lastAttemptAt: lastAttemptAt,
         lastSuccessAt: lastSuccessAt,
         lastJobId: lastJobId,
         lastFailureCode: lastFailureCode,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DiscoveryCoverageRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryCoverageRow copyWith({
    Object? id = _Undefined,
    String? countryCode,
    String? cellId,
    int? radiusMeters,
    double? centerLatitude,
    double? centerLongitude,
    double? south,
    double? west,
    double? north,
    double? east,
    int? manifestRevision,
    Map<String, DateTime>? queryCompletedAt,
    Object? lastAttemptAt = _Undefined,
    Object? lastSuccessAt = _Undefined,
    Object? lastJobId = _Undefined,
    Object? lastFailureCode = _Undefined,
    DateTime? updatedAt,
  }) {
    return DiscoveryCoverageRow(
      id: id is int? ? id : this.id,
      countryCode: countryCode ?? this.countryCode,
      cellId: cellId ?? this.cellId,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      south: south ?? this.south,
      west: west ?? this.west,
      north: north ?? this.north,
      east: east ?? this.east,
      manifestRevision: manifestRevision ?? this.manifestRevision,
      queryCompletedAt:
          queryCompletedAt ??
          this.queryCompletedAt.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      lastAttemptAt: lastAttemptAt is DateTime?
          ? lastAttemptAt
          : this.lastAttemptAt,
      lastSuccessAt: lastSuccessAt is DateTime?
          ? lastSuccessAt
          : this.lastSuccessAt,
      lastJobId: lastJobId is String? ? lastJobId : this.lastJobId,
      lastFailureCode: lastFailureCode is String?
          ? lastFailureCode
          : this.lastFailureCode,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DiscoveryCoverageRowUpdateTable
    extends _i1.UpdateTable<DiscoveryCoverageRowTable> {
  DiscoveryCoverageRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<String, String> cellId(String value) => _i1.ColumnValue(
    table.cellId,
    value,
  );

  _i1.ColumnValue<int, int> radiusMeters(int value) => _i1.ColumnValue(
    table.radiusMeters,
    value,
  );

  _i1.ColumnValue<double, double> centerLatitude(double value) =>
      _i1.ColumnValue(
        table.centerLatitude,
        value,
      );

  _i1.ColumnValue<double, double> centerLongitude(double value) =>
      _i1.ColumnValue(
        table.centerLongitude,
        value,
      );

  _i1.ColumnValue<double, double> south(double value) => _i1.ColumnValue(
    table.south,
    value,
  );

  _i1.ColumnValue<double, double> west(double value) => _i1.ColumnValue(
    table.west,
    value,
  );

  _i1.ColumnValue<double, double> north(double value) => _i1.ColumnValue(
    table.north,
    value,
  );

  _i1.ColumnValue<double, double> east(double value) => _i1.ColumnValue(
    table.east,
    value,
  );

  _i1.ColumnValue<int, int> manifestRevision(int value) => _i1.ColumnValue(
    table.manifestRevision,
    value,
  );

  _i1.ColumnValue<Map<String, DateTime>, Map<String, DateTime>>
  queryCompletedAt(Map<String, DateTime> value) => _i1.ColumnValue(
    table.queryCompletedAt,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastAttemptAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastAttemptAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSuccessAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSuccessAt,
        value,
      );

  _i1.ColumnValue<String, String> lastJobId(String? value) => _i1.ColumnValue(
    table.lastJobId,
    value,
  );

  _i1.ColumnValue<String, String> lastFailureCode(String? value) =>
      _i1.ColumnValue(
        table.lastFailureCode,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class DiscoveryCoverageRowTable extends _i1.Table<int?> {
  DiscoveryCoverageRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_coverage') {
    updateTable = DiscoveryCoverageRowUpdateTable(this);
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    cellId = _i1.ColumnString(
      'cellId',
      this,
    );
    radiusMeters = _i1.ColumnInt(
      'radiusMeters',
      this,
    );
    centerLatitude = _i1.ColumnDouble(
      'centerLatitude',
      this,
    );
    centerLongitude = _i1.ColumnDouble(
      'centerLongitude',
      this,
    );
    south = _i1.ColumnDouble(
      'south',
      this,
    );
    west = _i1.ColumnDouble(
      'west',
      this,
    );
    north = _i1.ColumnDouble(
      'north',
      this,
    );
    east = _i1.ColumnDouble(
      'east',
      this,
    );
    manifestRevision = _i1.ColumnInt(
      'manifestRevision',
      this,
    );
    queryCompletedAt = _i1.ColumnSerializable<Map<String, DateTime>>(
      'queryCompletedAt',
      this,
    );
    lastAttemptAt = _i1.ColumnDateTime(
      'lastAttemptAt',
      this,
    );
    lastSuccessAt = _i1.ColumnDateTime(
      'lastSuccessAt',
      this,
    );
    lastJobId = _i1.ColumnString(
      'lastJobId',
      this,
    );
    lastFailureCode = _i1.ColumnString(
      'lastFailureCode',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final DiscoveryCoverageRowUpdateTable updateTable;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnString cellId;

  late final _i1.ColumnInt radiusMeters;

  late final _i1.ColumnDouble centerLatitude;

  late final _i1.ColumnDouble centerLongitude;

  late final _i1.ColumnDouble south;

  late final _i1.ColumnDouble west;

  late final _i1.ColumnDouble north;

  late final _i1.ColumnDouble east;

  late final _i1.ColumnInt manifestRevision;

  late final _i1.ColumnSerializable<Map<String, DateTime>> queryCompletedAt;

  late final _i1.ColumnDateTime lastAttemptAt;

  late final _i1.ColumnDateTime lastSuccessAt;

  late final _i1.ColumnString lastJobId;

  late final _i1.ColumnString lastFailureCode;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    countryCode,
    cellId,
    radiusMeters,
    centerLatitude,
    centerLongitude,
    south,
    west,
    north,
    east,
    manifestRevision,
    queryCompletedAt,
    lastAttemptAt,
    lastSuccessAt,
    lastJobId,
    lastFailureCode,
    updatedAt,
  ];
}

class DiscoveryCoverageRowInclude extends _i1.IncludeObject {
  DiscoveryCoverageRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryCoverageRow.t;
}

class DiscoveryCoverageRowIncludeList extends _i1.IncludeList {
  DiscoveryCoverageRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryCoverageRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryCoverageRow.t;
}

class DiscoveryCoverageRowRepository {
  const DiscoveryCoverageRowRepository._();

  /// Returns a list of [DiscoveryCoverageRow]s matching the given query parameters.
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
  Future<List<DiscoveryCoverageRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryCoverageRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryCoverageRow>(
      where: where?.call(DiscoveryCoverageRow.t),
      orderBy: orderBy?.call(DiscoveryCoverageRow.t),
      orderByList: orderByList?.call(DiscoveryCoverageRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryCoverageRow] matching the given query parameters.
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
  Future<DiscoveryCoverageRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryCoverageRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryCoverageRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryCoverageRow>(
      where: where?.call(DiscoveryCoverageRow.t),
      orderBy: orderBy?.call(DiscoveryCoverageRow.t),
      orderByList: orderByList?.call(DiscoveryCoverageRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryCoverageRow] by its [id] or null if no such row exists.
  Future<DiscoveryCoverageRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryCoverageRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryCoverageRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryCoverageRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscoveryCoverageRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryCoverageRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryCoverageRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryCoverageRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryCoverageRow] will have its `id` field set.
  Future<DiscoveryCoverageRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryCoverageRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryCoverageRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryCoverageRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryCoverageRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryCoverageRow> rows, {
    _i1.ColumnSelections<DiscoveryCoverageRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryCoverageRow>(
      rows,
      columns: columns?.call(DiscoveryCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryCoverageRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryCoverageRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryCoverageRow row, {
    _i1.ColumnSelections<DiscoveryCoverageRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryCoverageRow>(
      row,
      columns: columns?.call(DiscoveryCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryCoverageRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryCoverageRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryCoverageRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryCoverageRow>(
      id,
      columnValues: columnValues(DiscoveryCoverageRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryCoverageRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryCoverageRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryCoverageRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryCoverageRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryCoverageRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryCoverageRow>(
      columnValues: columnValues(DiscoveryCoverageRow.t.updateTable),
      where: where(DiscoveryCoverageRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryCoverageRow.t),
      orderByList: orderByList?.call(DiscoveryCoverageRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryCoverageRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryCoverageRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryCoverageRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryCoverageRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryCoverageRow].
  Future<DiscoveryCoverageRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryCoverageRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryCoverageRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryCoverageRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryCoverageRow>(
      where: where(DiscoveryCoverageRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryCoverageRow>(
      where: where?.call(DiscoveryCoverageRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryCoverageRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryCoverageRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryCoverageRow>(
      where: where(DiscoveryCoverageRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
