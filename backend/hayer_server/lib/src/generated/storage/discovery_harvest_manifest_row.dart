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
import '../discovery_manifest_status.dart' as _i2;
import '../discovery_harvest_manifest_entry.dart' as _i3;
import 'package:hayer_server/src/generated/protocol.dart' as _i4;

abstract class DiscoveryHarvestManifestRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    required _i2.DiscoveryManifestStatus status,
    required List<_i3.DiscoveryHarvestManifestEntry> entries,
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
      status: _i2.DiscoveryManifestStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      entries: _i4.Protocol()
          .deserialize<List<_i3.DiscoveryHarvestManifestEntry>>(
            jsonSerialization['entries'],
          ),
      validationPassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _i4.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
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

  _i2.DiscoveryManifestStatus status;

  List<_i3.DiscoveryHarvestManifestEntry> entries;

  bool validationPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryHarvestManifestRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryHarvestManifestRow copyWith({
    int? id,
    String? version,
    int? revision,
    _i2.DiscoveryManifestStatus? status,
    List<_i3.DiscoveryHarvestManifestEntry>? entries,
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
    _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    DiscoveryHarvestManifestRowInclude? include,
  }) {
    return DiscoveryHarvestManifestRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestManifestRowImpl extends DiscoveryHarvestManifestRow {
  _DiscoveryHarvestManifestRowImpl({
    int? id,
    required String version,
    required int revision,
    required _i2.DiscoveryManifestStatus status,
    required List<_i3.DiscoveryHarvestManifestEntry> entries,
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
  @_i1.useResult
  @override
  DiscoveryHarvestManifestRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _i2.DiscoveryManifestStatus? status,
    List<_i3.DiscoveryHarvestManifestEntry>? entries,
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
    extends _i1.UpdateTable<DiscoveryHarvestManifestRowTable> {
  DiscoveryHarvestManifestRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<int, int> revision(int value) => _i1.ColumnValue(
    table.revision,
    value,
  );

  _i1.ColumnValue<_i2.DiscoveryManifestStatus, _i2.DiscoveryManifestStatus>
  status(_i2.DiscoveryManifestStatus value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<
    List<_i3.DiscoveryHarvestManifestEntry>,
    List<_i3.DiscoveryHarvestManifestEntry>
  >
  entries(List<_i3.DiscoveryHarvestManifestEntry> value) => _i1.ColumnValue(
    table.entries,
    value,
  );

  _i1.ColumnValue<bool, bool> validationPassed(bool value) => _i1.ColumnValue(
    table.validationPassed,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> validationErrors(
    List<String> value,
  ) => _i1.ColumnValue(
    table.validationErrors,
    value,
  );

  _i1.ColumnValue<String, String> createdBy(String value) => _i1.ColumnValue(
    table.createdBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.validatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );
}

class DiscoveryHarvestManifestRowTable extends _i1.Table<int?> {
  DiscoveryHarvestManifestRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_harvest_manifest') {
    updateTable = DiscoveryHarvestManifestRowUpdateTable(this);
    version = _i1.ColumnString(
      'version',
      this,
    );
    revision = _i1.ColumnInt(
      'revision',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    entries = _i1.ColumnSerializable<List<_i3.DiscoveryHarvestManifestEntry>>(
      'entries',
      this,
    );
    validationPassed = _i1.ColumnBool(
      'validationPassed',
      this,
    );
    validationErrors = _i1.ColumnSerializable<List<String>>(
      'validationErrors',
      this,
    );
    createdBy = _i1.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    validatedAt = _i1.ColumnDateTime(
      'validatedAt',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
  }

  late final DiscoveryHarvestManifestRowUpdateTable updateTable;

  late final _i1.ColumnString version;

  late final _i1.ColumnInt revision;

  late final _i1.ColumnEnum<_i2.DiscoveryManifestStatus> status;

  late final _i1.ColumnSerializable<List<_i3.DiscoveryHarvestManifestEntry>>
  entries;

  late final _i1.ColumnBool validationPassed;

  late final _i1.ColumnSerializable<List<String>> validationErrors;

  late final _i1.ColumnString createdBy;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime validatedAt;

  late final _i1.ColumnDateTime publishedAt;

  @override
  List<_i1.Column> get columns => [
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

class DiscoveryHarvestManifestRowInclude extends _i1.IncludeObject {
  DiscoveryHarvestManifestRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryHarvestManifestRow.t;
}

class DiscoveryHarvestManifestRowIncludeList extends _i1.IncludeList {
  DiscoveryHarvestManifestRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryHarvestManifestRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryHarvestManifestRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryHarvestManifestRow] by its [id] or null if no such row exists.
  Future<DiscoveryHarvestManifestRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<DiscoveryHarvestManifestRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryHarvestManifestRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryHarvestManifestRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryHarvestManifestRow] will have its `id` field set.
  Future<DiscoveryHarvestManifestRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryHarvestManifestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestManifestRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryHarvestManifestRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _i1.ColumnSelections<DiscoveryHarvestManifestRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryHarvestManifestRow>(
      rows,
      columns: columns?.call(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryHarvestManifestRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryHarvestManifestRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _i1.ColumnSelections<DiscoveryHarvestManifestRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryHarvestManifestRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryHarvestManifestRow>(
      id,
      columnValues: columnValues(DiscoveryHarvestManifestRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestManifestRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryHarvestManifestRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryHarvestManifestRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestManifestRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryHarvestManifestRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryHarvestManifestRow>(
      columnValues: columnValues(DiscoveryHarvestManifestRow.t.updateTable),
      where: where(DiscoveryHarvestManifestRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestManifestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestManifestRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryHarvestManifestRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryHarvestManifestRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestManifestRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryHarvestManifestRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryHarvestManifestRow].
  Future<DiscoveryHarvestManifestRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestManifestRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryHarvestManifestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryHarvestManifestRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryHarvestManifestRow>(
      where: where(DiscoveryHarvestManifestRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryHarvestManifestRow>(
      where: where?.call(DiscoveryHarvestManifestRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryHarvestManifestRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryHarvestManifestRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryHarvestManifestRow>(
      where: where(DiscoveryHarvestManifestRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
