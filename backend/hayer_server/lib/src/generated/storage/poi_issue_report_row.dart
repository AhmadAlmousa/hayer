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
import '../place_snapshot.dart' as _i2;
import '../poi_issue_type.dart' as _i3;
import '../poi_issue_status.dart' as _i4;
import 'package:hayer_server/src/generated/protocol.dart' as _i5;

abstract class PoiIssueReportRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PoiIssueReportRow._({
    this.id,
    required this.reportId,
    required this.reporterHash,
    this.activeDedupeKey,
    required this.sessionId,
    required this.placeId,
    required this.placeName,
    required this.reportedSnapshot,
    required this.issueType,
    this.details,
    required this.status,
    this.ownerName,
    this.resolution,
    this.sourceEvidence,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  factory PoiIssueReportRow({
    _i1.UuidValue? id,
    required String reportId,
    required String reporterHash,
    String? activeDedupeKey,
    required String sessionId,
    required String placeId,
    required String placeName,
    required _i2.PlaceSnapshot reportedSnapshot,
    required _i3.PoiIssueType issueType,
    String? details,
    required _i4.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
  }) = _PoiIssueReportRowImpl;

  factory PoiIssueReportRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiIssueReportRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      reportId: jsonSerialization['reportId'] as String,
      reporterHash: jsonSerialization['reporterHash'] as String,
      activeDedupeKey: jsonSerialization['activeDedupeKey'] as String?,
      sessionId: jsonSerialization['sessionId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      placeName: jsonSerialization['placeName'] as String,
      reportedSnapshot: _i5.Protocol().deserialize<_i2.PlaceSnapshot>(
        jsonSerialization['reportedSnapshot'],
      ),
      issueType: _i3.PoiIssueType.fromJson(
        (jsonSerialization['issueType'] as String),
      ),
      details: jsonSerialization['details'] as String?,
      status: _i4.PoiIssueStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      ownerName: jsonSerialization['ownerName'] as String?,
      resolution: jsonSerialization['resolution'] as String?,
      sourceEvidence: jsonSerialization['sourceEvidence'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = PoiIssueReportRowTable();

  static const db = PoiIssueReportRowRepository._();

  @override
  _i1.UuidValue? id;

  String reportId;

  String reporterHash;

  String? activeDedupeKey;

  String sessionId;

  String placeId;

  String placeName;

  _i2.PlaceSnapshot reportedSnapshot;

  _i3.PoiIssueType issueType;

  String? details;

  _i4.PoiIssueStatus status;

  String? ownerName;

  String? resolution;

  String? sourceEvidence;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? resolvedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiIssueReportRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PoiIssueReportRow copyWith({
    _i1.UuidValue? id,
    String? reportId,
    String? reporterHash,
    String? activeDedupeKey,
    String? sessionId,
    String? placeId,
    String? placeName,
    _i2.PlaceSnapshot? reportedSnapshot,
    _i3.PoiIssueType? issueType,
    String? details,
    _i4.PoiIssueStatus? status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiIssueReportRow',
      if (id != null) 'id': id?.toJson(),
      'reportId': reportId,
      'reporterHash': reporterHash,
      if (activeDedupeKey != null) 'activeDedupeKey': activeDedupeKey,
      'sessionId': sessionId,
      'placeId': placeId,
      'placeName': placeName,
      'reportedSnapshot': reportedSnapshot.toJson(),
      'issueType': issueType.toJson(),
      if (details != null) 'details': details,
      'status': status.toJson(),
      if (ownerName != null) 'ownerName': ownerName,
      if (resolution != null) 'resolution': resolution,
      if (sourceEvidence != null) 'sourceEvidence': sourceEvidence,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiIssueReportRowInclude include() {
    return PoiIssueReportRowInclude._();
  }

  static PoiIssueReportRowIncludeList includeList({
    _i1.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    PoiIssueReportRowInclude? include,
  }) {
    return PoiIssueReportRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiIssueReportRowImpl extends PoiIssueReportRow {
  _PoiIssueReportRowImpl({
    _i1.UuidValue? id,
    required String reportId,
    required String reporterHash,
    String? activeDedupeKey,
    required String sessionId,
    required String placeId,
    required String placeName,
    required _i2.PlaceSnapshot reportedSnapshot,
    required _i3.PoiIssueType issueType,
    String? details,
    required _i4.PoiIssueStatus status,
    String? ownerName,
    String? resolution,
    String? sourceEvidence,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         reportId: reportId,
         reporterHash: reporterHash,
         activeDedupeKey: activeDedupeKey,
         sessionId: sessionId,
         placeId: placeId,
         placeName: placeName,
         reportedSnapshot: reportedSnapshot,
         issueType: issueType,
         details: details,
         status: status,
         ownerName: ownerName,
         resolution: resolution,
         sourceEvidence: sourceEvidence,
         createdAt: createdAt,
         updatedAt: updatedAt,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [PoiIssueReportRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PoiIssueReportRow copyWith({
    Object? id = _Undefined,
    String? reportId,
    String? reporterHash,
    Object? activeDedupeKey = _Undefined,
    String? sessionId,
    String? placeId,
    String? placeName,
    _i2.PlaceSnapshot? reportedSnapshot,
    _i3.PoiIssueType? issueType,
    Object? details = _Undefined,
    _i4.PoiIssueStatus? status,
    Object? ownerName = _Undefined,
    Object? resolution = _Undefined,
    Object? sourceEvidence = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return PoiIssueReportRow(
      id: id is _i1.UuidValue? ? id : this.id,
      reportId: reportId ?? this.reportId,
      reporterHash: reporterHash ?? this.reporterHash,
      activeDedupeKey: activeDedupeKey is String?
          ? activeDedupeKey
          : this.activeDedupeKey,
      sessionId: sessionId ?? this.sessionId,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      reportedSnapshot: reportedSnapshot ?? this.reportedSnapshot.copyWith(),
      issueType: issueType ?? this.issueType,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      ownerName: ownerName is String? ? ownerName : this.ownerName,
      resolution: resolution is String? ? resolution : this.resolution,
      sourceEvidence: sourceEvidence is String?
          ? sourceEvidence
          : this.sourceEvidence,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class PoiIssueReportRowUpdateTable
    extends _i1.UpdateTable<PoiIssueReportRowTable> {
  PoiIssueReportRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> reportId(String value) => _i1.ColumnValue(
    table.reportId,
    value,
  );

  _i1.ColumnValue<String, String> reporterHash(String value) => _i1.ColumnValue(
    table.reporterHash,
    value,
  );

  _i1.ColumnValue<String, String> activeDedupeKey(String? value) =>
      _i1.ColumnValue(
        table.activeDedupeKey,
        value,
      );

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> placeId(String value) => _i1.ColumnValue(
    table.placeId,
    value,
  );

  _i1.ColumnValue<String, String> placeName(String value) => _i1.ColumnValue(
    table.placeName,
    value,
  );

  _i1.ColumnValue<_i2.PlaceSnapshot, _i2.PlaceSnapshot> reportedSnapshot(
    _i2.PlaceSnapshot value,
  ) => _i1.ColumnValue(
    table.reportedSnapshot,
    value,
  );

  _i1.ColumnValue<_i3.PoiIssueType, _i3.PoiIssueType> issueType(
    _i3.PoiIssueType value,
  ) => _i1.ColumnValue(
    table.issueType,
    value,
  );

  _i1.ColumnValue<String, String> details(String? value) => _i1.ColumnValue(
    table.details,
    value,
  );

  _i1.ColumnValue<_i4.PoiIssueStatus, _i4.PoiIssueStatus> status(
    _i4.PoiIssueStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> ownerName(String? value) => _i1.ColumnValue(
    table.ownerName,
    value,
  );

  _i1.ColumnValue<String, String> resolution(String? value) => _i1.ColumnValue(
    table.resolution,
    value,
  );

  _i1.ColumnValue<String, String> sourceEvidence(String? value) =>
      _i1.ColumnValue(
        table.sourceEvidence,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class PoiIssueReportRowTable extends _i1.Table<_i1.UuidValue?> {
  PoiIssueReportRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_issue_report') {
    updateTable = PoiIssueReportRowUpdateTable(this);
    reportId = _i1.ColumnString(
      'reportId',
      this,
    );
    reporterHash = _i1.ColumnString(
      'reporterHash',
      this,
    );
    activeDedupeKey = _i1.ColumnString(
      'activeDedupeKey',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    placeId = _i1.ColumnString(
      'placeId',
      this,
    );
    placeName = _i1.ColumnString(
      'placeName',
      this,
    );
    reportedSnapshot = _i1.ColumnSerializable<_i2.PlaceSnapshot>(
      'reportedSnapshot',
      this,
    );
    issueType = _i1.ColumnEnum(
      'issueType',
      this,
      _i1.EnumSerialization.byName,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    ownerName = _i1.ColumnString(
      'ownerName',
      this,
    );
    resolution = _i1.ColumnString(
      'resolution',
      this,
    );
    sourceEvidence = _i1.ColumnString(
      'sourceEvidence',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    resolvedAt = _i1.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final PoiIssueReportRowUpdateTable updateTable;

  late final _i1.ColumnString reportId;

  late final _i1.ColumnString reporterHash;

  late final _i1.ColumnString activeDedupeKey;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString placeId;

  late final _i1.ColumnString placeName;

  late final _i1.ColumnSerializable<_i2.PlaceSnapshot> reportedSnapshot;

  late final _i1.ColumnEnum<_i3.PoiIssueType> issueType;

  late final _i1.ColumnString details;

  late final _i1.ColumnEnum<_i4.PoiIssueStatus> status;

  late final _i1.ColumnString ownerName;

  late final _i1.ColumnString resolution;

  late final _i1.ColumnString sourceEvidence;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime resolvedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    reportId,
    reporterHash,
    activeDedupeKey,
    sessionId,
    placeId,
    placeName,
    reportedSnapshot,
    issueType,
    details,
    status,
    ownerName,
    resolution,
    sourceEvidence,
    createdAt,
    updatedAt,
    resolvedAt,
  ];
}

class PoiIssueReportRowInclude extends _i1.IncludeObject {
  PoiIssueReportRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiIssueReportRow.t;
}

class PoiIssueReportRowIncludeList extends _i1.IncludeList {
  PoiIssueReportRowIncludeList._({
    _i1.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiIssueReportRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiIssueReportRow.t;
}

class PoiIssueReportRowRepository {
  const PoiIssueReportRowRepository._();

  /// Returns a list of [PoiIssueReportRow]s matching the given query parameters.
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
  Future<List<PoiIssueReportRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiIssueReportRow] matching the given query parameters.
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
  Future<PoiIssueReportRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiIssueReportRow] by its [id] or null if no such row exists.
  Future<PoiIssueReportRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiIssueReportRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiIssueReportRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiIssueReportRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PoiIssueReportRow>> insert(
    _i1.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PoiIssueReportRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PoiIssueReportRow] and returns the inserted row.
  ///
  /// The returned [PoiIssueReportRow] will have its `id` field set.
  Future<PoiIssueReportRow> insertRow(
    _i1.DatabaseSession session,
    PoiIssueReportRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiIssueReportRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PoiIssueReportRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PoiIssueReportRow>> update(
    _i1.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _i1.ColumnSelections<PoiIssueReportRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PoiIssueReportRow>(
      rows,
      columns: columns?.call(PoiIssueReportRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiIssueReportRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiIssueReportRow> updateRow(
    _i1.DatabaseSession session,
    PoiIssueReportRow row, {
    _i1.ColumnSelections<PoiIssueReportRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiIssueReportRow>(
      row,
      columns: columns?.call(PoiIssueReportRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiIssueReportRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiIssueReportRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PoiIssueReportRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiIssueReportRow>(
      id,
      columnValues: columnValues(PoiIssueReportRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiIssueReportRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PoiIssueReportRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PoiIssueReportRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _i1.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PoiIssueReportRow>(
      columnValues: columnValues(PoiIssueReportRow.t.updateTable),
      where: where(PoiIssueReportRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PoiIssueReportRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PoiIssueReportRow>> delete(
    _i1.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PoiIssueReportRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PoiIssueReportRow].
  Future<PoiIssueReportRow> deleteRow(
    _i1.DatabaseSession session,
    PoiIssueReportRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiIssueReportRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PoiIssueReportRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PoiIssueReportRow>(
      where: where(PoiIssueReportRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiIssueReportRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiIssueReportRow>(
      where: where(PoiIssueReportRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
