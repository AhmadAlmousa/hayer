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
import '../place_detail_refresh_state.dart' as _isf7qw52;

abstract class PoiDetailRefreshRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
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
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required _isf7qw52.PlaceDetailRefreshState state,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
      state: _isf7qw52.PlaceDetailRefreshState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      leaseToken: jsonSerialization['leaseToken'] as String?,
      leaseExpiresAt: jsonSerialization['leaseExpiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['leaseExpiresAt'],
            ),
      lastAttemptAt: jsonSerialization['lastAttemptAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastAttemptAt'],
            ),
      lastCheckedAt: jsonSerialization['lastCheckedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCheckedAt'],
            ),
      lastSuccessAt: jsonSerialization['lastSuccessAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSuccessAt'],
            ),
      retryAfter: jsonSerialization['retryAfter'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['retryAfter']),
      lastFailureCode: jsonSerialization['lastFailureCode'] as String?,
      attemptCount: jsonSerialization['attemptCount'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PoiDetailRefreshRowTable();

  static const db = PoiDetailRefreshRowRepository._();

  @override
  _is.UuidValue? id;

  String provider;

  String providerPlaceId;

  _isf7qw52.PlaceDetailRefreshState state;

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
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiDetailRefreshRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiDetailRefreshRow copyWith({
    _is.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    _isf7qw52.PlaceDetailRefreshState? state,
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
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    PoiDetailRefreshRowInclude? include,
  }) {
    return PoiDetailRefreshRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiDetailRefreshRowImpl extends PoiDetailRefreshRow {
  _PoiDetailRefreshRowImpl({
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    required _isf7qw52.PlaceDetailRefreshState state,
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
  @_is.useResult
  @override
  PoiDetailRefreshRow copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerPlaceId,
    _isf7qw52.PlaceDetailRefreshState? state,
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
      id: id is _is.UuidValue? ? id : this.id,
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
    extends _is.UpdateTable<PoiDetailRefreshRowTable> {
  PoiDetailRefreshRowUpdateTable(super.table);

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> providerPlaceId(String value) =>
      _is.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _is.ColumnValue<
    _isf7qw52.PlaceDetailRefreshState,
    _isf7qw52.PlaceDetailRefreshState
  >
  state(_isf7qw52.PlaceDetailRefreshState value) => _is.ColumnValue(
    table.state,
    value,
  );

  _is.ColumnValue<String, String> leaseToken(String? value) => _is.ColumnValue(
    table.leaseToken,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> leaseExpiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.leaseExpiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastAttemptAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastAttemptAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastCheckedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastCheckedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSuccessAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastSuccessAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> retryAfter(DateTime? value) =>
      _is.ColumnValue(
        table.retryAfter,
        value,
      );

  _is.ColumnValue<String, String> lastFailureCode(String? value) =>
      _is.ColumnValue(
        table.lastFailureCode,
        value,
      );

  _is.ColumnValue<int, int> attemptCount(int value) => _is.ColumnValue(
    table.attemptCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PoiDetailRefreshRowTable extends _is.Table<_is.UuidValue?> {
  PoiDetailRefreshRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_detail_refresh') {
    updateTable = PoiDetailRefreshRowUpdateTable(this);
    provider = _is.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _is.ColumnString(
      'providerPlaceId',
      this,
    );
    state = _is.ColumnEnum(
      'state',
      this,
      _is.EnumSerialization.byName,
    );
    leaseToken = _is.ColumnString(
      'leaseToken',
      this,
    );
    leaseExpiresAt = _is.ColumnDateTime(
      'leaseExpiresAt',
      this,
    );
    lastAttemptAt = _is.ColumnDateTime(
      'lastAttemptAt',
      this,
    );
    lastCheckedAt = _is.ColumnDateTime(
      'lastCheckedAt',
      this,
    );
    lastSuccessAt = _is.ColumnDateTime(
      'lastSuccessAt',
      this,
    );
    retryAfter = _is.ColumnDateTime(
      'retryAfter',
      this,
    );
    lastFailureCode = _is.ColumnString(
      'lastFailureCode',
      this,
    );
    attemptCount = _is.ColumnInt(
      'attemptCount',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final PoiDetailRefreshRowUpdateTable updateTable;

  late final _is.ColumnString provider;

  late final _is.ColumnString providerPlaceId;

  late final _is.ColumnEnum<_isf7qw52.PlaceDetailRefreshState> state;

  late final _is.ColumnString leaseToken;

  late final _is.ColumnDateTime leaseExpiresAt;

  late final _is.ColumnDateTime lastAttemptAt;

  late final _is.ColumnDateTime lastCheckedAt;

  late final _is.ColumnDateTime lastSuccessAt;

  late final _is.ColumnDateTime retryAfter;

  late final _is.ColumnString lastFailureCode;

  late final _is.ColumnInt attemptCount;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
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

class PoiDetailRefreshRowInclude extends _is.IncludeObject {
  PoiDetailRefreshRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiDetailRefreshRow.t;
}

class PoiDetailRefreshRowIncludeList extends _is.IncludeList {
  PoiDetailRefreshRowIncludeList._({
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiDetailRefreshRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiDetailRefreshRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiDetailRefreshRow] by its [id] or null if no such row exists.
  Future<PoiDetailRefreshRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiDetailRefreshRow>> insert(
    _is.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoiDetailRefreshRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoiDetailRefreshRow] and returns the inserted row.
  ///
  /// The returned [PoiDetailRefreshRow] will have its `id` field set.
  Future<PoiDetailRefreshRow> insertRow(
    _is.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiDetailRefreshRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoiDetailRefreshRow]s in the list and returns the resulting rows.
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
  /// The returned [PoiDetailRefreshRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiDetailRefreshRow>> upsert(
    _is.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    required _is.ColumnSelections<PoiDetailRefreshRowTable> conflictColumns,
    _is.ColumnSelections<PoiDetailRefreshRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoiDetailRefreshRow>(
      rows,
      conflictColumns: conflictColumns(PoiDetailRefreshRow.t),
      updateColumns: updateColumns?.call(PoiDetailRefreshRow.t),
      updateWhere: updateWhere?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoiDetailRefreshRow] and returns the resulting row.
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
  /// The returned [PoiDetailRefreshRow] will have its `id` field set.
  Future<PoiDetailRefreshRow?> upsertRow(
    _is.DatabaseSession session,
    PoiDetailRefreshRow row, {
    required _is.ColumnSelections<PoiDetailRefreshRowTable> conflictColumns,
    _is.ColumnSelections<PoiDetailRefreshRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoiDetailRefreshRow>(
      row,
      conflictColumns: conflictColumns(PoiDetailRefreshRow.t),
      updateColumns: updateColumns?.call(PoiDetailRefreshRow.t),
      updateWhere: updateWhere?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoiDetailRefreshRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiDetailRefreshRow>> update(
    _is.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _is.ColumnSelections<PoiDetailRefreshRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoiDetailRefreshRow>(
      rows,
      columns: columns?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoiDetailRefreshRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiDetailRefreshRow> updateRow(
    _is.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _is.ColumnSelections<PoiDetailRefreshRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PoiDetailRefreshRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiDetailRefreshRow>(
      id,
      columnValues: columnValues(PoiDetailRefreshRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiDetailRefreshRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiDetailRefreshRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoiDetailRefreshRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoiDetailRefreshRow>(
      columnValues: columnValues(PoiDetailRefreshRow.t.updateTable),
      where: where(PoiDetailRefreshRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoiDetailRefreshRow]s in the list and returns the deleted rows.
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
  Future<List<PoiDetailRefreshRow>> delete(
    _is.DatabaseSession session,
    List<PoiDetailRefreshRow> rows, {
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoiDetailRefreshRow>(
      rows,
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoiDetailRefreshRow].
  Future<PoiDetailRefreshRow> deleteRow(
    _is.DatabaseSession session,
    PoiDetailRefreshRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiDetailRefreshRow>(
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
  Future<List<PoiDetailRefreshRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    _is.OrderByBuilder<PoiDetailRefreshRowTable>? orderBy,
    _is.OrderByListBuilder<PoiDetailRefreshRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoiDetailRefreshRow>(
      where: where(PoiDetailRefreshRow.t),
      orderBy: orderBy?.call(PoiDetailRefreshRow.t),
      orderByList: orderByList?.call(PoiDetailRefreshRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiDetailRefreshRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoiDetailRefreshRow>(
      where: where?.call(PoiDetailRefreshRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiDetailRefreshRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiDetailRefreshRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiDetailRefreshRow>(
      where: where(PoiDetailRefreshRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
