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

abstract class ParticipantRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  ParticipantRow._({
    this.id,
    required this.participantId,
    required this.sessionId,
    required this.userId,
    required this.displayName,
    required this.normalizedName,
    required this.isHost,
    required this.currentIndex,
    required this.hasCompleted,
    required this.lastSeenAt,
    this.destinationPlaceId,
    int? destinationChoiceRevision,
  }) : destinationChoiceRevision = destinationChoiceRevision ?? 0;

  factory ParticipantRow({
    _is.UuidValue? id,
    required String participantId,
    required String sessionId,
    required String userId,
    required String displayName,
    required String normalizedName,
    required bool isHost,
    required int currentIndex,
    required bool hasCompleted,
    required DateTime lastSeenAt,
    String? destinationPlaceId,
    int? destinationChoiceRevision,
  }) = _ParticipantRowImpl;

  factory ParticipantRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ParticipantRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      participantId: jsonSerialization['participantId'] as String,
      sessionId: jsonSerialization['sessionId'] as String,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      normalizedName: jsonSerialization['normalizedName'] as String,
      isHost: _is.BoolJsonExtension.fromJson(jsonSerialization['isHost']),
      currentIndex: jsonSerialization['currentIndex'] as int,
      hasCompleted: _is.BoolJsonExtension.fromJson(
        jsonSerialization['hasCompleted'],
      ),
      lastSeenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
      destinationPlaceId: jsonSerialization['destinationPlaceId'] as String?,
      destinationChoiceRevision:
          jsonSerialization['destinationChoiceRevision'] as int?,
    );
  }

  static final t = ParticipantRowTable();

  static const db = ParticipantRowRepository._();

  @override
  _is.UuidValue? id;

  String participantId;

  String sessionId;

  String userId;

  String displayName;

  String normalizedName;

  bool isHost;

  int currentIndex;

  bool hasCompleted;

  DateTime lastSeenAt;

  String? destinationPlaceId;

  int destinationChoiceRevision;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ParticipantRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ParticipantRow copyWith({
    _is.UuidValue? id,
    String? participantId,
    String? sessionId,
    String? userId,
    String? displayName,
    String? normalizedName,
    bool? isHost,
    int? currentIndex,
    bool? hasCompleted,
    DateTime? lastSeenAt,
    String? destinationPlaceId,
    int? destinationChoiceRevision,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ParticipantRow',
      if (id != null) 'id': id?.toJson(),
      'participantId': participantId,
      'sessionId': sessionId,
      'userId': userId,
      'displayName': displayName,
      'normalizedName': normalizedName,
      'isHost': isHost,
      'currentIndex': currentIndex,
      'hasCompleted': hasCompleted,
      'lastSeenAt': lastSeenAt.toJson(),
      if (destinationPlaceId != null) 'destinationPlaceId': destinationPlaceId,
      'destinationChoiceRevision': destinationChoiceRevision,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ParticipantRowInclude include() {
    return ParticipantRowInclude._();
  }

  static ParticipantRowIncludeList includeList({
    _is.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    ParticipantRowInclude? include,
  }) {
    return ParticipantRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParticipantRowImpl extends ParticipantRow {
  _ParticipantRowImpl({
    _is.UuidValue? id,
    required String participantId,
    required String sessionId,
    required String userId,
    required String displayName,
    required String normalizedName,
    required bool isHost,
    required int currentIndex,
    required bool hasCompleted,
    required DateTime lastSeenAt,
    String? destinationPlaceId,
    int? destinationChoiceRevision,
  }) : super._(
         id: id,
         participantId: participantId,
         sessionId: sessionId,
         userId: userId,
         displayName: displayName,
         normalizedName: normalizedName,
         isHost: isHost,
         currentIndex: currentIndex,
         hasCompleted: hasCompleted,
         lastSeenAt: lastSeenAt,
         destinationPlaceId: destinationPlaceId,
         destinationChoiceRevision: destinationChoiceRevision,
       );

  /// Returns a shallow copy of this [ParticipantRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ParticipantRow copyWith({
    Object? id = _Undefined,
    String? participantId,
    String? sessionId,
    String? userId,
    String? displayName,
    String? normalizedName,
    bool? isHost,
    int? currentIndex,
    bool? hasCompleted,
    DateTime? lastSeenAt,
    Object? destinationPlaceId = _Undefined,
    int? destinationChoiceRevision,
  }) {
    return ParticipantRow(
      id: id is _is.UuidValue? ? id : this.id,
      participantId: participantId ?? this.participantId,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      normalizedName: normalizedName ?? this.normalizedName,
      isHost: isHost ?? this.isHost,
      currentIndex: currentIndex ?? this.currentIndex,
      hasCompleted: hasCompleted ?? this.hasCompleted,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      destinationPlaceId: destinationPlaceId is String?
          ? destinationPlaceId
          : this.destinationPlaceId,
      destinationChoiceRevision:
          destinationChoiceRevision ?? this.destinationChoiceRevision,
    );
  }
}

class ParticipantRowUpdateTable extends _is.UpdateTable<ParticipantRowTable> {
  ParticipantRowUpdateTable(super.table);

  _is.ColumnValue<String, String> participantId(String value) =>
      _is.ColumnValue(
        table.participantId,
        value,
      );

  _is.ColumnValue<String, String> sessionId(String value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> normalizedName(String value) =>
      _is.ColumnValue(
        table.normalizedName,
        value,
      );

  _is.ColumnValue<bool, bool> isHost(bool value) => _is.ColumnValue(
    table.isHost,
    value,
  );

  _is.ColumnValue<int, int> currentIndex(int value) => _is.ColumnValue(
    table.currentIndex,
    value,
  );

  _is.ColumnValue<bool, bool> hasCompleted(bool value) => _is.ColumnValue(
    table.hasCompleted,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _is.ColumnValue<String, String> destinationPlaceId(String? value) =>
      _is.ColumnValue(
        table.destinationPlaceId,
        value,
      );

  _is.ColumnValue<int, int> destinationChoiceRevision(int value) =>
      _is.ColumnValue(
        table.destinationChoiceRevision,
        value,
      );
}

class ParticipantRowTable extends _is.Table<_is.UuidValue?> {
  ParticipantRowTable({super.tableRelation})
    : super(tableName: 'hayer_participant') {
    updateTable = ParticipantRowUpdateTable(this);
    participantId = _is.ColumnString(
      'participantId',
      this,
    );
    sessionId = _is.ColumnString(
      'sessionId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    normalizedName = _is.ColumnString(
      'normalizedName',
      this,
    );
    isHost = _is.ColumnBool(
      'isHost',
      this,
    );
    currentIndex = _is.ColumnInt(
      'currentIndex',
      this,
    );
    hasCompleted = _is.ColumnBool(
      'hasCompleted',
      this,
    );
    lastSeenAt = _is.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    destinationPlaceId = _is.ColumnString(
      'destinationPlaceId',
      this,
    );
    destinationChoiceRevision = _is.ColumnInt(
      'destinationChoiceRevision',
      this,
      hasDefault: true,
    );
  }

  late final ParticipantRowUpdateTable updateTable;

  late final _is.ColumnString participantId;

  late final _is.ColumnString sessionId;

  late final _is.ColumnString userId;

  late final _is.ColumnString displayName;

  late final _is.ColumnString normalizedName;

  late final _is.ColumnBool isHost;

  late final _is.ColumnInt currentIndex;

  late final _is.ColumnBool hasCompleted;

  late final _is.ColumnDateTime lastSeenAt;

  late final _is.ColumnString destinationPlaceId;

  late final _is.ColumnInt destinationChoiceRevision;

  @override
  List<_is.Column> get columns => [
    id,
    participantId,
    sessionId,
    userId,
    displayName,
    normalizedName,
    isHost,
    currentIndex,
    hasCompleted,
    lastSeenAt,
    destinationPlaceId,
    destinationChoiceRevision,
  ];
}

class ParticipantRowInclude extends _is.IncludeObject {
  ParticipantRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => ParticipantRow.t;
}

class ParticipantRowIncludeList extends _is.IncludeList {
  ParticipantRowIncludeList._({
    _is.WhereExpressionBuilder<ParticipantRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ParticipantRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => ParticipantRow.t;
}

class ParticipantRowRepository {
  const ParticipantRowRepository._();

  /// Returns a list of [ParticipantRow]s matching the given query parameters.
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
  Future<List<ParticipantRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ParticipantRow] matching the given query parameters.
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
  Future<ParticipantRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? offset,
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ParticipantRow] by its [id] or null if no such row exists.
  Future<ParticipantRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ParticipantRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ParticipantRow]s in the list and returns the inserted rows.
  ///
  /// The returned [ParticipantRow]s will have their `id` fields set.
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
  Future<List<ParticipantRow>> insert(
    _is.DatabaseSession session,
    List<ParticipantRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ParticipantRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ParticipantRow] and returns the inserted row.
  ///
  /// The returned [ParticipantRow] will have its `id` field set.
  Future<ParticipantRow> insertRow(
    _is.DatabaseSession session,
    ParticipantRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ParticipantRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ParticipantRow]s in the list and returns the resulting rows.
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
  /// The returned [ParticipantRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParticipantRow>> upsert(
    _is.DatabaseSession session,
    List<ParticipantRow> rows, {
    required _is.ColumnSelections<ParticipantRowTable> conflictColumns,
    _is.ColumnSelections<ParticipantRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ParticipantRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ParticipantRow>(
      rows,
      conflictColumns: conflictColumns(ParticipantRow.t),
      updateColumns: updateColumns?.call(ParticipantRow.t),
      updateWhere: updateWhere?.call(ParticipantRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ParticipantRow] and returns the resulting row.
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
  /// The returned [ParticipantRow] will have its `id` field set.
  Future<ParticipantRow?> upsertRow(
    _is.DatabaseSession session,
    ParticipantRow row, {
    required _is.ColumnSelections<ParticipantRowTable> conflictColumns,
    _is.ColumnSelections<ParticipantRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ParticipantRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ParticipantRow>(
      row,
      conflictColumns: conflictColumns(ParticipantRow.t),
      updateColumns: updateColumns?.call(ParticipantRow.t),
      updateWhere: updateWhere?.call(ParticipantRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [ParticipantRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParticipantRow>> update(
    _is.DatabaseSession session,
    List<ParticipantRow> rows, {
    _is.ColumnSelections<ParticipantRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ParticipantRow>(
      rows,
      columns: columns?.call(ParticipantRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ParticipantRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ParticipantRow> updateRow(
    _is.DatabaseSession session,
    ParticipantRow row, {
    _is.ColumnSelections<ParticipantRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ParticipantRow>(
      row,
      columns: columns?.call(ParticipantRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ParticipantRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ParticipantRow?> updateById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<ParticipantRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ParticipantRow>(
      id,
      columnValues: columnValues(ParticipantRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ParticipantRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ParticipantRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ParticipantRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ParticipantRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ParticipantRow>(
      columnValues: columnValues(ParticipantRow.t.updateTable),
      where: where(ParticipantRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ParticipantRow]s in the list and returns the deleted rows.
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
  Future<List<ParticipantRow>> delete(
    _is.DatabaseSession session,
    List<ParticipantRow> rows, {
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ParticipantRow>(
      rows,
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ParticipantRow].
  Future<ParticipantRow> deleteRow(
    _is.DatabaseSession session,
    ParticipantRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ParticipantRow>(
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
  Future<List<ParticipantRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParticipantRowTable> where,
    _is.OrderByBuilder<ParticipantRowTable>? orderBy,
    _is.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ParticipantRow>(
      where: where(ParticipantRow.t),
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ParticipantRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ParticipantRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ParticipantRow>(
      where: where(ParticipantRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
