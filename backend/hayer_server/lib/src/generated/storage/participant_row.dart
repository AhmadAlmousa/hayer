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

abstract class ParticipantRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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
    _i1.UuidValue? id,
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
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      participantId: jsonSerialization['participantId'] as String,
      sessionId: jsonSerialization['sessionId'] as String,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      normalizedName: jsonSerialization['normalizedName'] as String,
      isHost: _i1.BoolJsonExtension.fromJson(jsonSerialization['isHost']),
      currentIndex: jsonSerialization['currentIndex'] as int,
      hasCompleted: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasCompleted'],
      ),
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
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
  _i1.UuidValue? id;

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
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ParticipantRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ParticipantRow copyWith({
    _i1.UuidValue? id,
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
    _i1.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ParticipantRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ParticipantRowTable>? orderByList,
    ParticipantRowInclude? include,
  }) {
    return ParticipantRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParticipantRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ParticipantRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ParticipantRowImpl extends ParticipantRow {
  _ParticipantRowImpl({
    _i1.UuidValue? id,
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
  @_i1.useResult
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
      id: id is _i1.UuidValue? ? id : this.id,
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

class ParticipantRowUpdateTable extends _i1.UpdateTable<ParticipantRowTable> {
  ParticipantRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> participantId(String value) =>
      _i1.ColumnValue(
        table.participantId,
        value,
      );

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<String, String> normalizedName(String value) =>
      _i1.ColumnValue(
        table.normalizedName,
        value,
      );

  _i1.ColumnValue<bool, bool> isHost(bool value) => _i1.ColumnValue(
    table.isHost,
    value,
  );

  _i1.ColumnValue<int, int> currentIndex(int value) => _i1.ColumnValue(
    table.currentIndex,
    value,
  );

  _i1.ColumnValue<bool, bool> hasCompleted(bool value) => _i1.ColumnValue(
    table.hasCompleted,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<String, String> destinationPlaceId(String? value) =>
      _i1.ColumnValue(
        table.destinationPlaceId,
        value,
      );

  _i1.ColumnValue<int, int> destinationChoiceRevision(int value) =>
      _i1.ColumnValue(
        table.destinationChoiceRevision,
        value,
      );
}

class ParticipantRowTable extends _i1.Table<_i1.UuidValue?> {
  ParticipantRowTable({super.tableRelation})
    : super(tableName: 'hayer_participant') {
    updateTable = ParticipantRowUpdateTable(this);
    participantId = _i1.ColumnString(
      'participantId',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    normalizedName = _i1.ColumnString(
      'normalizedName',
      this,
    );
    isHost = _i1.ColumnBool(
      'isHost',
      this,
    );
    currentIndex = _i1.ColumnInt(
      'currentIndex',
      this,
    );
    hasCompleted = _i1.ColumnBool(
      'hasCompleted',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    destinationPlaceId = _i1.ColumnString(
      'destinationPlaceId',
      this,
    );
    destinationChoiceRevision = _i1.ColumnInt(
      'destinationChoiceRevision',
      this,
      hasDefault: true,
    );
  }

  late final ParticipantRowUpdateTable updateTable;

  late final _i1.ColumnString participantId;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnString normalizedName;

  late final _i1.ColumnBool isHost;

  late final _i1.ColumnInt currentIndex;

  late final _i1.ColumnBool hasCompleted;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnString destinationPlaceId;

  late final _i1.ColumnInt destinationChoiceRevision;

  @override
  List<_i1.Column> get columns => [
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

class ParticipantRowInclude extends _i1.IncludeObject {
  ParticipantRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ParticipantRow.t;
}

class ParticipantRowIncludeList extends _i1.IncludeList {
  ParticipantRowIncludeList._({
    _i1.WhereExpressionBuilder<ParticipantRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ParticipantRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ParticipantRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ParticipantRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<ParticipantRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ParticipantRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ParticipantRow] by its [id] or null if no such row exists.
  Future<ParticipantRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<ParticipantRow>> insert(
    _i1.DatabaseSession session,
    List<ParticipantRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ParticipantRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ParticipantRow] and returns the inserted row.
  ///
  /// The returned [ParticipantRow] will have its `id` field set.
  Future<ParticipantRow> insertRow(
    _i1.DatabaseSession session,
    ParticipantRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ParticipantRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ParticipantRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ParticipantRow>> update(
    _i1.DatabaseSession session,
    List<ParticipantRow> rows, {
    _i1.ColumnSelections<ParticipantRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ParticipantRow>(
      rows,
      columns: columns?.call(ParticipantRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ParticipantRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ParticipantRow> updateRow(
    _i1.DatabaseSession session,
    ParticipantRow row, {
    _i1.ColumnSelections<ParticipantRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ParticipantRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ParticipantRow>(
      id,
      columnValues: columnValues(ParticipantRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ParticipantRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ParticipantRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ParticipantRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ParticipantRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ParticipantRowTable>? orderBy,
    _i1.OrderByListBuilder<ParticipantRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ParticipantRow>(
      columnValues: columnValues(ParticipantRow.t.updateTable),
      where: where(ParticipantRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ParticipantRow.t),
      orderByList: orderByList?.call(ParticipantRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ParticipantRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ParticipantRow>> delete(
    _i1.DatabaseSession session,
    List<ParticipantRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ParticipantRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ParticipantRow].
  Future<ParticipantRow> deleteRow(
    _i1.DatabaseSession session,
    ParticipantRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ParticipantRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ParticipantRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ParticipantRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ParticipantRow>(
      where: where(ParticipantRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ParticipantRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ParticipantRow>(
      where: where?.call(ParticipantRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ParticipantRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ParticipantRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ParticipantRow>(
      where: where(ParticipantRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
