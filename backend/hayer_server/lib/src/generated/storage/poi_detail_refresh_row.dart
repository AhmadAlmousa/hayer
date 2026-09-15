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
import '../place_detail_refresh_state.dart' as _i2;

abstract class PoiDetailRefreshRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PoiDetailRefreshRow._({
    this.id,
    required this.provider,
    required this.providerPlaceId,
    required this.state,
    this.leaseToken,
    this.leaseExpiresAt,
    this.lastAttemptAt,
    this.lastCheckedAt,
    this.lastSuccessAt,
    this.retryAfter,
    this.lastFailureCode,
    required this.attemptCount,
    required this.updatedAt,
  });

  factory PoiDetailRefreshRow({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required _i2.PlaceDetailRefreshState state,
    String? leaseToken,
    DateTime? leaseExpiresAt,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    required int attemptCount,
    required DateTime updatedAt,
  }) = _PoiDetailRefreshRowImpl;

  factory PoiDetailRefreshRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiDetailRefreshRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
      state: _i2.PlaceDetailRefreshState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      leaseToken: jsonSerialization['leaseToken'] as String?,
      leaseExpiresAt: jsonSerialization['leaseExpiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['leaseExpiresAt'],
            ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastCheckedAt: jsonSerialization['lastCheckedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCheckedAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      attemptCount: jsonSerialization['attemptCount'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PoiDetailRefreshRowTable();

  static const db = PoiDetailRefreshRowRepository._();

  @override
  _i1.UuidValue? id;

  String provider;

  String providerPlaceId;

  _i2.PlaceDetailRefreshState state;

  String? leaseToken;

  DateTime? leaseExpiresAt;

  DateTime? lastAttemptAt;

  DateTime? lastCheckedAt;

  DateTime? lastSuccessAt;

  DateTime? retryAfter;

  String? lastFailureCode;

  int attemptCount;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiDetailRefreshRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PoiDetailRefreshRow copyWith({
    _i1.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    _i2.PlaceDetailRefreshState? state,
    String? leaseToken,
    DateTime? leaseExpiresAt,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    int? attemptCount,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiDetailRefreshRow',
      if (id != null) 'id': id?.toJson(),
      'provider': provider,
      'providerPlaceId': providerPlaceId,
      'state': state.toJson(),
      if (leaseToken != null) 'leaseToken': leaseToken,
      if (leaseExpiresAt != null) 'leaseExpiresAt': leaseExpiresAt?.toJson(),
      if (lastAttemptAt != null) 'lastAttemptAt': lastAttemptAt?.toJson(),
      if (lastCheckedAt != null) 'lastCheckedAt': lastCheckedAt?.toJson(),
      if (lastSuccessAt != null) 'lastSuccessAt': lastSuccessAt?.toJson(),
      if (retryAfter != null) 'retryAfter': retryAfter?.toJson(),
      if (lastFailureCode != null) 'lastFailureCode': lastFailureCode,
      'attemptCount': attemptCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiDetailRefreshRowInclude include() {
    return PoiDetailRefreshRowInclude._();
  }

  static PoiDetailRefreshRowIncludeList includeList({
    _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    PoiDetailRefreshRowInclude? include,
  }) {
    return PoiDetailRefreshRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiDetailRefreshRowImpl extends PoiDetailRefreshRow {
  _PoiDetailRefreshRowImpl({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required _i2.PlaceDetailRefreshState state,
    String? leaseToken,
    DateTime? leaseExpiresAt,
    DateTime? lastAttemptAt,
    DateTime? lastCheckedAt,
    DateTime? lastSuccessAt,
    DateTime? retryAfter,
    String? lastFailureCode,
    required int attemptCount,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         provider: provider,
         providerPlaceId: providerPlaceId,
         state: state,
         leaseToken: leaseToken,
         leaseExpiresAt: leaseExpiresAt,
         lastAttemptAt: lastAttemptAt,
         lastCheckedAt: lastCheckedAt,
         lastSuccessAt: lastSuccessAt,
         retryAfter: retryAfter,
         lastFailureCode: lastFailureCode,
         attemptCount: attemptCount,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PoiDetailRefreshRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PoiDetailRefreshRow copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerPlaceId,
    _i2.PlaceDetailRefreshState? state,
    Object? leaseToken = _Undefined,
    Object? leaseExpiresAt = _Undefined,
    Object? lastAttemptAt = _Undefined,
    Object? lastCheckedAt = _Undefined,
    Object? lastSuccessAt = _Undefined,
    Object? retryAfter = _Undefined,
    Object? lastFailureCode = _Undefined,
    int? attemptCount,
    DateTime? updatedAt,
  }) {
    return PoiDetailRefreshRow(
      id: id is _i1.UuidValue? ? id : this.id,
      provider: provider ?? this.provider,
      providerPlaceId: providerPlaceId ?? this.providerPlaceId,
      state: state ?? this.state,
      leaseToken: leaseToken is String? ? leaseToken : this.leaseToken,
      leaseExpiresAt: leaseExpiresAt is DateTime?
          ? leaseExpiresAt
          : this.leaseExpiresAt,
      lastAttemptAt: lastAttemptAt is DateTime?
          ? lastAttemptAt
          : this.lastAttemptAt,
      lastCheckedAt: lastCheckedAt is DateTime?
          ? lastCheckedAt
          : this.lastCheckedAt,
      lastSuccessAt: lastSuccessAt is DateTime?
          ? lastSuccessAt
          : this.lastSuccessAt,
      retryAfter: retryAfter is DateTime? ? retryAfter : this.retryAfter,
      lastFailureCode: lastFailureCode is String?
          ? lastFailureCode
          : this.lastFailureCode,
      attemptCount: attemptCount ?? this.attemptCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PoiDetailRefreshRowUpdateTable
    extends _i1.UpdateTable<PoiDetailRefreshRowTable> {
  PoiDetailRefreshRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> providerPlaceId(String value) =>
      _i1.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _i1.ColumnValue<_i2.PlaceDetailRefreshState, _i2.PlaceDetailRefreshState>
  state(_i2.PlaceDetailRefreshState value) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<String, String> leaseToken(String? value) => _i1.ColumnValue(
    table.leaseToken,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> leaseExpiresAt(DateTime? value) =>
      _i1.ColumnValue(
        table.leaseExpiresAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastAttemptAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastAttemptAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastCheckedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastCheckedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSuccessAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastSuccessAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> retryAfter(DateTime? value) =>
      _i1.ColumnValue(
        table.retryAfter,
        value,
      );

  _i1.ColumnValue<String, String> lastFailureCode(String? value) =>
      _i1.ColumnValue(
        table.lastFailureCode,
        value,
      );

  _i1.ColumnValue<int, int> attemptCount(int value) => _i1.ColumnValue(
    table.attemptCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PoiDetailRefreshRowTable extends _i1.Table<_i1.UuidValue?> {
  PoiDetailRefreshRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_detail_refresh') {
    updateTable = PoiDetailRefreshRowUpdateTable(this);
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _i1.ColumnString(
      'providerPlaceId',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    leaseToken = _i1.ColumnString(
      'leaseToken',
      this,
    );
    leaseExpiresAt = _i1.ColumnDateTime(
      'leaseExpiresAt',
      this,
    );
    lastAttemptAt = _i1.ColumnDateTime(
      'lastAttemptAt',
      this,
    );
    lastCheckedAt = _i1.ColumnDateTime(
      'lastCheckedAt',
      this,
    );
    lastSuccessAt = _i1.ColumnDateTime(
      'lastSuccessAt',
      this,
    );
    retryAfter = _i1.ColumnDateTime(
      'retryAfter',
      this,
    );
    lastFailureCode = _i1.ColumnString(
      'lastFailureCode',
      this,
    );
    attemptCount = _i1.ColumnInt(
      'attemptCount',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final PoiDetailRefreshRowUpdateTable updateTable;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString providerPlaceId;

  late final _i1.ColumnEnum<_i2.PlaceDetailRefreshState> state;

  late final _i1.ColumnString leaseToken;

  late final _i1.ColumnDateTime leaseExpiresAt;

  late final _i1.ColumnDateTime lastAttemptAt;

  late final _i1.ColumnDateTime lastCheckedAt;

  late final _i1.ColumnDateTime lastSuccessAt;

  late final _i1.ColumnDateTime retryAfter;

  late final _i1.ColumnString lastFailureCode;

  late final _i1.ColumnInt attemptCount;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    provider,
    providerPlaceId,
    state,
    leaseToken,
    leaseExpiresAt,
    lastAttemptAt,
    lastCheckedAt,
    lastSuccessAt,
    retryAfter,
    lastFailureCode,
    attemptCount,
    updatedAt,
  ];
}

class PoiDetailRefreshRowInclude extends _i1.IncludeObject {
  PoiDetailRefreshRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiDetailRefreshRow.t;
}

class PoiDetailRefreshRowIncludeList extends _i1.IncludeList {
  PoiDetailRefreshRowIncludeList._({
    _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiDetailRefreshRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiDetailRefreshRow.t;
}

class PoiDetailRefreshRowRepository {
  const PoiDetailRefreshRowRepository._();

  /// Returns a list of [PoiDetailRefreshRow]s matching the given query parameters.
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
  Future<List<PoiDetailRefreshRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiDetailRefreshRow] matching the given query parameters.
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
  Future<PoiDetailRefreshRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiDetailRefreshRow] by its [id] or null if no such row exists.
  Future<PoiDetailRefreshRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiDetailRefreshRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiDetailRefreshRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiDetailRefreshRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PoiDetailRefreshRow>> insert(
    _i1.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PoiDetailRefreshRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PoiDetailRefreshRow] and returns the inserted row.
  ///
  /// The returned [PoiDetailRefreshRow] will have its `id` field set.
  Future<PoiDetailRefreshRow> insertRow(
    _i1.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiDetailRefreshRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PoiDetailRefreshRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PoiDetailRefreshRow>> update(
    _i1.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _i1.ColumnSelections<PoiDetailRefreshRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PoiDetailRefreshRow>(
      rows,
      columns: columns?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiDetailRefreshRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiDetailRefreshRow> updateRow(
    _i1.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _i1.ColumnSelections<PoiDetailRefreshRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiDetailRefreshRow>(
      row,
      columns: columns?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiDetailRefreshRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiDetailRefreshRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PoiDetailRefreshRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiDetailRefreshRow>(
      id,
      columnValues: columnValues(PoiDetailRefreshRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiDetailRefreshRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PoiDetailRefreshRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PoiDetailRefreshRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _i1.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PoiDetailRefreshRow>(
      columnValues: columnValues(PoiDetailRefreshRow.t.updateTable),
      where: where(PoiDetailRefreshRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PoiDetailRefreshRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PoiDetailRefreshRow>> delete(
    _i1.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PoiDetailRefreshRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PoiDetailRefreshRow].
  Future<PoiDetailRefreshRow> deleteRow(
    _i1.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiDetailRefreshRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PoiDetailRefreshRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PoiDetailRefreshRow>(
      where: where(PoiDetailRefreshRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiDetailRefreshRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiDetailRefreshRow>(
      where: where(PoiDetailRefreshRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
