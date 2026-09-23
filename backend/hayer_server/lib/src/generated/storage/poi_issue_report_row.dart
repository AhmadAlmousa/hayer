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
import 'package:hayer_server/src/generated/protocol.dart' as _i66y2smk;
import 'package:serverpod/serverpod.dart' as _is;
import '../place_snapshot.dart' as _iv1jjw8m;
import '../poi_issue_source.dart' as _ir6pywa3;
import '../poi_issue_status.dart' as _i3wqurc8;
import '../poi_issue_type.dart' as _idhjekpp;

abstract class PoiIssueReportRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
  PoiIssueReportRow._({
    this.id,
    required this.reportId,
    required this.reporterHash,
    this.activeDedupeKey,
    this.sessionId,
    _ir6pywa3.PoiIssueSource? source,
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
  }) : source = source ?? _ir6pywa3.PoiIssueSource.session;

  factory PoiIssueReportRow({
    _is.UuidValue? id,
    required String reportId,
    required String reporterHash,
    String? activeDedupeKey,
    String? sessionId,
    _ir6pywa3.PoiIssueSource? source,
    required String placeId,
    required String placeName,
    required _iv1jjw8m.PlaceSnapshot reportedSnapshot,
    required _idhjekpp.PoiIssueType issueType,
    String? details,
    required _i3wqurc8.PoiIssueStatus status,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      reportId: jsonSerialization['reportId'] as String,
      reporterHash: jsonSerialization['reporterHash'] as String,
      activeDedupeKey: jsonSerialization['activeDedupeKey'] as String?,
      sessionId: jsonSerialization['sessionId'] as String?,
      source: jsonSerialization['source'] == null
          ? null
          : _ir6pywa3.PoiIssueSource.fromJson(
              (jsonSerialization['source'] as String),
            ),
      placeId: jsonSerialization['placeId'] as String,
      placeName: jsonSerialization['placeName'] as String,
      reportedSnapshot: _i66y2smk.Protocol()
          .deserialize<_iv1jjw8m.PlaceSnapshot>(
            jsonSerialization['reportedSnapshot'],
          ),
      issueType: _idhjekpp.PoiIssueType.fromJson(
        (jsonSerialization['issueType'] as String),
      ),
      details: jsonSerialization['details'] as String?,
      status: _i3wqurc8.PoiIssueStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      ownerName: jsonSerialization['ownerName'] as String?,
      resolution: jsonSerialization['resolution'] as String?,
      sourceEvidence: jsonSerialization['sourceEvidence'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = PoiIssueReportRowTable();

  static const db = PoiIssueReportRowRepository._();

  @override
  _is.UuidValue? id;

  String reportId;

  String reporterHash;

  String? activeDedupeKey;

  String? sessionId;

  _ir6pywa3.PoiIssueSource source;

  String placeId;

  String placeName;

  _iv1jjw8m.PlaceSnapshot reportedSnapshot;

  _idhjekpp.PoiIssueType issueType;

  String? details;

  _i3wqurc8.PoiIssueStatus status;

  String? ownerName;

  String? resolution;

  String? sourceEvidence;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? resolvedAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiIssueReportRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiIssueReportRow copyWith({
    _is.UuidValue? id,
    String? reportId,
    String? reporterHash,
    String? activeDedupeKey,
    String? sessionId,
    _ir6pywa3.PoiIssueSource? source,
    String? placeId,
    String? placeName,
    _iv1jjw8m.PlaceSnapshot? reportedSnapshot,
    _idhjekpp.PoiIssueType? issueType,
    String? details,
    _i3wqurc8.PoiIssueStatus? status,
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
      if (sessionId != null) 'sessionId': sessionId,
      'source': source.toJson(),
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
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    PoiIssueReportRowInclude? include,
  }) {
    return PoiIssueReportRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiIssueReportRowImpl extends PoiIssueReportRow {
  _PoiIssueReportRowImpl({
    _is.UuidValue? id,
    required String reportId,
    required String reporterHash,
    String? activeDedupeKey,
    String? sessionId,
    _ir6pywa3.PoiIssueSource? source,
    required String placeId,
    required String placeName,
    required _iv1jjw8m.PlaceSnapshot reportedSnapshot,
    required _idhjekpp.PoiIssueType issueType,
    String? details,
    required _i3wqurc8.PoiIssueStatus status,
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
         source: source,
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
  @_is.useResult
  @override
  PoiIssueReportRow copyWith({
    Object? id = _Undefined,
    String? reportId,
    String? reporterHash,
    Object? activeDedupeKey = _Undefined,
    Object? sessionId = _Undefined,
    _ir6pywa3.PoiIssueSource? source,
    String? placeId,
    String? placeName,
    _iv1jjw8m.PlaceSnapshot? reportedSnapshot,
    _idhjekpp.PoiIssueType? issueType,
    Object? details = _Undefined,
    _i3wqurc8.PoiIssueStatus? status,
    Object? ownerName = _Undefined,
    Object? resolution = _Undefined,
    Object? sourceEvidence = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? resolvedAt = _Undefined,
  }) {
    return PoiIssueReportRow(
      id: id is _is.UuidValue? ? id : this.id,
      reportId: reportId ?? this.reportId,
      reporterHash: reporterHash ?? this.reporterHash,
      activeDedupeKey: activeDedupeKey is String?
          ? activeDedupeKey
          : this.activeDedupeKey,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      source: source ?? this.source,
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
    extends _is.UpdateTable<PoiIssueReportRowTable> {
  PoiIssueReportRowUpdateTable(super.table);

  _is.ColumnValue<String, String> reportId(String value) => _is.ColumnValue(
    table.reportId,
    value,
  );

  _is.ColumnValue<String, String> reporterHash(String value) => _is.ColumnValue(
    table.reporterHash,
    value,
  );

  _is.ColumnValue<String, String> activeDedupeKey(String? value) =>
      _is.ColumnValue(
        table.activeDedupeKey,
        value,
      );

  _is.ColumnValue<String, String> sessionId(String? value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<_ir6pywa3.PoiIssueSource, _ir6pywa3.PoiIssueSource> source(
    _ir6pywa3.PoiIssueSource value,
  ) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<String, String> placeId(String value) => _is.ColumnValue(
    table.placeId,
    value,
  );

  _is.ColumnValue<String, String> placeName(String value) => _is.ColumnValue(
    table.placeName,
    value,
  );

  _is.ColumnValue<_iv1jjw8m.PlaceSnapshot, _iv1jjw8m.PlaceSnapshot>
  reportedSnapshot(_iv1jjw8m.PlaceSnapshot value) => _is.ColumnValue(
    table.reportedSnapshot,
    value,
  );

  _is.ColumnValue<_idhjekpp.PoiIssueType, _idhjekpp.PoiIssueType> issueType(
    _idhjekpp.PoiIssueType value,
  ) => _is.ColumnValue(
    table.issueType,
    value,
  );

  _is.ColumnValue<String, String> details(String? value) => _is.ColumnValue(
    table.details,
    value,
  );

  _is.ColumnValue<_i3wqurc8.PoiIssueStatus, _i3wqurc8.PoiIssueStatus> status(
    _i3wqurc8.PoiIssueStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> ownerName(String? value) => _is.ColumnValue(
    table.ownerName,
    value,
  );

  _is.ColumnValue<String, String> resolution(String? value) => _is.ColumnValue(
    table.resolution,
    value,
  );

  _is.ColumnValue<String, String> sourceEvidence(String? value) =>
      _is.ColumnValue(
        table.sourceEvidence,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class PoiIssueReportRowTable extends _is.Table<_is.UuidValue?> {
  PoiIssueReportRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_issue_report') {
    updateTable = PoiIssueReportRowUpdateTable(this);
    reportId = _is.ColumnString(
      'reportId',
      this,
    );
    reporterHash = _is.ColumnString(
      'reporterHash',
      this,
    );
    activeDedupeKey = _is.ColumnString(
      'activeDedupeKey',
      this,
    );
    sessionId = _is.ColumnString(
      'sessionId',
      this,
    );
    source = _is.ColumnEnum(
      'source',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    placeId = _is.ColumnString(
      'placeId',
      this,
    );
    placeName = _is.ColumnString(
      'placeName',
      this,
    );
    reportedSnapshot = _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot>(
      'reportedSnapshot',
      this,
    );
    issueType = _is.ColumnEnum(
      'issueType',
      this,
      _is.EnumSerialization.byName,
    );
    details = _is.ColumnString(
      'details',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    ownerName = _is.ColumnString(
      'ownerName',
      this,
    );
    resolution = _is.ColumnString(
      'resolution',
      this,
    );
    sourceEvidence = _is.ColumnString(
      'sourceEvidence',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final PoiIssueReportRowUpdateTable updateTable;

  late final _is.ColumnString reportId;

  late final _is.ColumnString reporterHash;

  late final _is.ColumnString activeDedupeKey;

  late final _is.ColumnString sessionId;

  late final _is.ColumnEnum<_ir6pywa3.PoiIssueSource> source;

  late final _is.ColumnString placeId;

  late final _is.ColumnString placeName;

  late final _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot> reportedSnapshot;

  late final _is.ColumnEnum<_idhjekpp.PoiIssueType> issueType;

  late final _is.ColumnString details;

  late final _is.ColumnEnum<_i3wqurc8.PoiIssueStatus> status;

  late final _is.ColumnString ownerName;

  late final _is.ColumnString resolution;

  late final _is.ColumnString sourceEvidence;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime resolvedAt;

  @override
  List<_is.Column> get columns => [
    id,
    reportId,
    reporterHash,
    activeDedupeKey,
    sessionId,
    source,
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

class PoiIssueReportRowInclude extends _is.IncludeObject {
  PoiIssueReportRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiIssueReportRow.t;
}

class PoiIssueReportRowIncludeList extends _is.IncludeList {
  PoiIssueReportRowIncludeList._({
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiIssueReportRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiIssueReportRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiIssueReportRow] by its [id] or null if no such row exists.
  Future<PoiIssueReportRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiIssueReportRow>> insert(
    _is.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoiIssueReportRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoiIssueReportRow] and returns the inserted row.
  ///
  /// The returned [PoiIssueReportRow] will have its `id` field set.
  Future<PoiIssueReportRow> insertRow(
    _is.DatabaseSession session,
    PoiIssueReportRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiIssueReportRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoiIssueReportRow]s in the list and returns the resulting rows.
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
  /// The returned [PoiIssueReportRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiIssueReportRow>> upsert(
    _is.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    required _is.ColumnSelections<PoiIssueReportRowTable> conflictColumns,
    _is.ColumnSelections<PoiIssueReportRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoiIssueReportRow>(
      rows,
      conflictColumns: conflictColumns(PoiIssueReportRow.t),
      updateColumns: updateColumns?.call(PoiIssueReportRow.t),
      updateWhere: updateWhere?.call(PoiIssueReportRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoiIssueReportRow] and returns the resulting row.
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
  /// The returned [PoiIssueReportRow] will have its `id` field set.
  Future<PoiIssueReportRow?> upsertRow(
    _is.DatabaseSession session,
    PoiIssueReportRow row, {
    required _is.ColumnSelections<PoiIssueReportRowTable> conflictColumns,
    _is.ColumnSelections<PoiIssueReportRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoiIssueReportRow>(
      row,
      conflictColumns: conflictColumns(PoiIssueReportRow.t),
      updateColumns: updateColumns?.call(PoiIssueReportRow.t),
      updateWhere: updateWhere?.call(PoiIssueReportRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoiIssueReportRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiIssueReportRow>> update(
    _is.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _is.ColumnSelections<PoiIssueReportRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoiIssueReportRow>(
      rows,
      columns: columns?.call(PoiIssueReportRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoiIssueReportRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiIssueReportRow> updateRow(
    _is.DatabaseSession session,
    PoiIssueReportRow row, {
    _is.ColumnSelections<PoiIssueReportRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PoiIssueReportRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiIssueReportRow>(
      id,
      columnValues: columnValues(PoiIssueReportRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiIssueReportRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiIssueReportRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoiIssueReportRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoiIssueReportRow>(
      columnValues: columnValues(PoiIssueReportRow.t.updateTable),
      where: where(PoiIssueReportRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoiIssueReportRow]s in the list and returns the deleted rows.
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
  Future<List<PoiIssueReportRow>> delete(
    _is.DatabaseSession session,
    List<PoiIssueReportRow> rows, {
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoiIssueReportRow>(
      rows,
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoiIssueReportRow].
  Future<PoiIssueReportRow> deleteRow(
    _is.DatabaseSession session,
    PoiIssueReportRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiIssueReportRow>(
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
  Future<List<PoiIssueReportRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    _is.OrderByBuilder<PoiIssueReportRowTable>? orderBy,
    _is.OrderByListBuilder<PoiIssueReportRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoiIssueReportRow>(
      where: where(PoiIssueReportRow.t),
      orderBy: orderBy?.call(PoiIssueReportRow.t),
      orderByList: orderByList?.call(PoiIssueReportRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiIssueReportRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoiIssueReportRow>(
      where: where?.call(PoiIssueReportRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiIssueReportRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiIssueReportRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiIssueReportRow>(
      where: where(PoiIssueReportRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
