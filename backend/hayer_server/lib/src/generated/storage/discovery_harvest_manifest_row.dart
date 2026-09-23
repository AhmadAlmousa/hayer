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
import '../discovery_harvest_manifest_entry.dart' as _i66wwmdw;
import '../discovery_manifest_status.dart' as _iyv2tzop;

abstract class DiscoveryHarvestManifestRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DiscoveryHarvestManifestRow._({
    this.id,
    required this.version,
    required this.revision,
    required this.status,
    required this.entries,
    required this.validationPassed,
    required this.validationErrors,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory DiscoveryHarvestManifestRow({
    int? id,
    required String version,
    required int revision,
    required _iyv2tzop.DiscoveryManifestStatus status,
    required List<_i66wwmdw.DiscoveryHarvestManifestEntry> entries,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _DiscoveryHarvestManifestRowImpl;

  factory DiscoveryHarvestManifestRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryHarvestManifestRow(
      id: jsonSerialization['id'] as int?,
      version: jsonSerialization['version'] as String,
      revision: jsonSerialization['revision'] as int,
      status: _iyv2tzop.DiscoveryManifestStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      entries: _i66y2smk.Protocol()
          .deserialize<List<_i66wwmdw.DiscoveryHarvestManifestEntry>>(
            jsonSerialization['entries'],
          ),
      validationPassed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
    );
  }

  static final t = DiscoveryHarvestManifestRowTable();

  static const db = DiscoveryHarvestManifestRowRepository._();

  @override
  int? id;

  String version;

  int revision;

  _iyv2tzop.DiscoveryManifestStatus status;

  List<_i66wwmdw.DiscoveryHarvestManifestEntry> entries;

  bool validationPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryHarvestManifestRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryHarvestManifestRow copyWith({
    int? id,
    String? version,
    int? revision,
    _iyv2tzop.DiscoveryManifestStatus? status,
    List<_i66wwmdw.DiscoveryHarvestManifestEntry>? entries,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestManifestRow',
      if (id != null) 'id': id,
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryHarvestManifestRowInclude include() {
    return DiscoveryHarvestManifestRowInclude._();
  }

  static DiscoveryHarvestManifestRowIncludeList includeList({
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    DiscoveryHarvestManifestRowInclude? include,
  }) {
    return DiscoveryHarvestManifestRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestManifestRowImpl extends DiscoveryHarvestManifestRow {
  _DiscoveryHarvestManifestRowImpl({
    int? id,
    required String version,
    required int revision,
    required _iyv2tzop.DiscoveryManifestStatus status,
    required List<_i66wwmdw.DiscoveryHarvestManifestEntry> entries,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) : super._(
         id: id,
         version: version,
         revision: revision,
         status: status,
         entries: entries,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestManifestRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DiscoveryHarvestManifestRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _iyv2tzop.DiscoveryManifestStatus? status,
    List<_i66wwmdw.DiscoveryHarvestManifestEntry>? entries,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return DiscoveryHarvestManifestRow(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList(),
      validationPassed: validationPassed ?? this.validationPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
    );
  }
}

class DiscoveryHarvestManifestRowUpdateTable
    extends _is.UpdateTable<DiscoveryHarvestManifestRowTable> {
  DiscoveryHarvestManifestRowUpdateTable(super.table);

  _is.ColumnValue<String, String> version(String value) => _is.ColumnValue(
    table.version,
    value,
  );

  _is.ColumnValue<int, int> revision(int value) => _is.ColumnValue(
    table.revision,
    value,
  );

  _is.ColumnValue<
    _iyv2tzop.DiscoveryManifestStatus,
    _iyv2tzop.DiscoveryManifestStatus
  >
  status(_iyv2tzop.DiscoveryManifestStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<
    List<_i66wwmdw.DiscoveryHarvestManifestEntry>,
    List<_i66wwmdw.DiscoveryHarvestManifestEntry>
  >
  entries(List<_i66wwmdw.DiscoveryHarvestManifestEntry> value) =>
      _is.ColumnValue(
        table.entries,
        value,
      );

  _is.ColumnValue<bool, bool> validationPassed(bool value) => _is.ColumnValue(
    table.validationPassed,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> validationErrors(
    List<String> value,
  ) => _is.ColumnValue(
    table.validationErrors,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _is.ColumnValue(
        table.validatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _is.ColumnValue(
        table.publishedAt,
        value,
      );
}

class DiscoveryHarvestManifestRowTable extends _is.Table<int?> {
  DiscoveryHarvestManifestRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_harvest_manifest') {
    updateTable = DiscoveryHarvestManifestRowUpdateTable(this);
    version = _is.ColumnString(
      'version',
      this,
    );
    revision = _is.ColumnInt(
      'revision',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    entries =
        _is.ColumnSerializable<List<_i66wwmdw.DiscoveryHarvestManifestEntry>>(
          'entries',
          this,
        );
    validationPassed = _is.ColumnBool(
      'validationPassed',
      this,
    );
    validationErrors = _is.ColumnSerializable<List<String>>(
      'validationErrors',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    validatedAt = _is.ColumnDateTime(
      'validatedAt',
      this,
    );
    publishedAt = _is.ColumnDateTime(
      'publishedAt',
      this,
    );
  }

  late final DiscoveryHarvestManifestRowUpdateTable updateTable;

  late final _is.ColumnString version;

  late final _is.ColumnInt revision;

  late final _is.ColumnEnum<_iyv2tzop.DiscoveryManifestStatus> status;

  late final _is.ColumnSerializable<
    List<_i66wwmdw.DiscoveryHarvestManifestEntry>
  >
  entries;

  late final _is.ColumnBool validationPassed;

  late final _is.ColumnSerializable<List<String>> validationErrors;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime validatedAt;

  late final _is.ColumnDateTime publishedAt;

  @override
  List<_is.Column> get columns => [
    id,
    version,
    revision,
    status,
    entries,
    validationPassed,
    validationErrors,
    createdBy,
    createdAt,
    validatedAt,
    publishedAt,
  ];
}

class DiscoveryHarvestManifestRowInclude extends _is.IncludeObject {
  DiscoveryHarvestManifestRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiscoveryHarvestManifestRow.t;
}

class DiscoveryHarvestManifestRowIncludeList extends _is.IncludeList {
  DiscoveryHarvestManifestRowIncludeList._({
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryHarvestManifestRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiscoveryHarvestManifestRow.t;
}

class DiscoveryHarvestManifestRowRepository {
  const DiscoveryHarvestManifestRowRepository._();

  /// Returns a list of [DiscoveryHarvestManifestRow]s matching the given query parameters.
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
  Future<List<DiscoveryHarvestManifestRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryHarvestManifestRow] matching the given query parameters.
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
  Future<DiscoveryHarvestManifestRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryHarvestManifestRow] by its [id] or null if no such row exists.
  Future<DiscoveryHarvestManifestRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryHarvestManifestRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryHarvestManifestRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryHarvestManifestRow]s will have their `id` fields set.
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
  Future<List<DiscoveryHarvestManifestRow>> insert(
    _is.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiscoveryHarvestManifestRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiscoveryHarvestManifestRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryHarvestManifestRow] will have its `id` field set.
  Future<DiscoveryHarvestManifestRow> insertRow(
    _is.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryHarvestManifestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiscoveryHarvestManifestRow]s in the list and returns the resulting rows.
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
  /// The returned [DiscoveryHarvestManifestRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestManifestRow>> upsert(
    _is.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    required _is.ColumnSelections<DiscoveryHarvestManifestRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryHarvestManifestRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiscoveryHarvestManifestRow>(
      rows,
      conflictColumns: conflictColumns(DiscoveryHarvestManifestRow.t),
      updateColumns: updateColumns?.call(DiscoveryHarvestManifestRow.t),
      updateWhere: updateWhere?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiscoveryHarvestManifestRow] and returns the resulting row.
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
  /// The returned [DiscoveryHarvestManifestRow] will have its `id` field set.
  Future<DiscoveryHarvestManifestRow?> upsertRow(
    _is.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    required _is.ColumnSelections<DiscoveryHarvestManifestRowTable>
    conflictColumns,
    _is.ColumnSelections<DiscoveryHarvestManifestRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiscoveryHarvestManifestRow>(
      row,
      conflictColumns: conflictColumns(DiscoveryHarvestManifestRow.t),
      updateColumns: updateColumns?.call(DiscoveryHarvestManifestRow.t),
      updateWhere: updateWhere?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestManifestRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestManifestRow>> update(
    _is.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _is.ColumnSelections<DiscoveryHarvestManifestRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiscoveryHarvestManifestRow>(
      rows,
      columns: columns?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiscoveryHarvestManifestRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryHarvestManifestRow> updateRow(
    _is.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _is.ColumnSelections<DiscoveryHarvestManifestRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryHarvestManifestRow>(
      row,
      columns: columns?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryHarvestManifestRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryHarvestManifestRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiscoveryHarvestManifestRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryHarvestManifestRow>(
      id,
      columnValues: columnValues(DiscoveryHarvestManifestRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestManifestRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestManifestRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiscoveryHarvestManifestRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiscoveryHarvestManifestRow>(
      columnValues: columnValues(DiscoveryHarvestManifestRow.t.updateTable),
      where: where(DiscoveryHarvestManifestRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiscoveryHarvestManifestRow]s in the list and returns the deleted rows.
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
  Future<List<DiscoveryHarvestManifestRow>> delete(
    _is.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiscoveryHarvestManifestRow>(
      rows,
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiscoveryHarvestManifestRow].
  Future<DiscoveryHarvestManifestRow> deleteRow(
    _is.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryHarvestManifestRow>(
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
  Future<List<DiscoveryHarvestManifestRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    _is.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiscoveryHarvestManifestRow>(
      where: where(DiscoveryHarvestManifestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryHarvestManifestRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryHarvestManifestRow>(
      where: where(DiscoveryHarvestManifestRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
