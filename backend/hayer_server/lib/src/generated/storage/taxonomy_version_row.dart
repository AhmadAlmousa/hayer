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
import '../taxonomy_status.dart' as _i2;
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class TaxonomyVersionRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TaxonomyVersionRow._({
    this.id,
    required this.version,
    required this.revision,
    required this.status,
    required this.documentJson,
    required this.validationPassed,
    required this.validationErrors,
    this.validationLocationJson,
    this.validationRadiusMeters,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory TaxonomyVersionRow({
    int? id,
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _TaxonomyVersionRowImpl;

  factory TaxonomyVersionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaxonomyVersionRow(
      id: jsonSerialization['id'] as int?,
      version: jsonSerialization['version'] as String,
      revision: jsonSerialization['revision'] as int,
      status: _i2.TaxonomyStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      documentJson: jsonSerialization['documentJson'] as String,
      validationPassed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['validationPassed'],
      ),
      validationErrors: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['validationErrors'],
      ),
      validationLocationJson:
          jsonSerialization['validationLocationJson'] as String?,
      validationRadiusMeters:
          jsonSerialization['validationRadiusMeters'] as int?,
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

  static final t = TaxonomyVersionRowTable();

  static const db = TaxonomyVersionRowRepository._();

  @override
  int? id;

  String version;

  int revision;

  _i2.TaxonomyStatus status;

  String documentJson;

  bool validationPassed;

  List<String> validationErrors;

  String? validationLocationJson;

  int? validationRadiusMeters;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaxonomyVersionRow copyWith({
    int? id,
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
    String? createdBy,
    DateTime? createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaxonomyVersionRow',
      if (id != null) 'id': id,
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'documentJson': documentJson,
      'validationPassed': validationPassed,
      'validationErrors': validationErrors.toJson(),
      if (validationLocationJson != null)
        'validationLocationJson': validationLocationJson,
      if (validationRadiusMeters != null)
        'validationRadiusMeters': validationRadiusMeters,
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

  static TaxonomyVersionRowInclude include() {
    return TaxonomyVersionRowInclude._();
  }

  static TaxonomyVersionRowIncludeList includeList({
    _i1.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    TaxonomyVersionRowInclude? include,
  }) {
    return TaxonomyVersionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaxonomyVersionRowImpl extends TaxonomyVersionRow {
  _TaxonomyVersionRowImpl({
    int? id,
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    String? validationLocationJson,
    int? validationRadiusMeters,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) : super._(
         id: id,
         version: version,
         revision: revision,
         status: status,
         documentJson: documentJson,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         validationLocationJson: validationLocationJson,
         validationRadiusMeters: validationRadiusMeters,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [TaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaxonomyVersionRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    Object? validationLocationJson = _Undefined,
    Object? validationRadiusMeters = _Undefined,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return TaxonomyVersionRow(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      documentJson: documentJson ?? this.documentJson,
      validationPassed: validationPassed ?? this.validationPassed,
      validationErrors:
          validationErrors ?? this.validationErrors.map((e0) => e0).toList(),
      validationLocationJson: validationLocationJson is String?
          ? validationLocationJson
          : this.validationLocationJson,
      validationRadiusMeters: validationRadiusMeters is int?
          ? validationRadiusMeters
          : this.validationRadiusMeters,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
    );
  }
}

class TaxonomyVersionRowUpdateTable
    extends _i1.UpdateTable<TaxonomyVersionRowTable> {
  TaxonomyVersionRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<int, int> revision(int value) => _i1.ColumnValue(
    table.revision,
    value,
  );

  _i1.ColumnValue<_i2.TaxonomyStatus, _i2.TaxonomyStatus> status(
    _i2.TaxonomyStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> documentJson(String value) => _i1.ColumnValue(
    table.documentJson,
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

  _i1.ColumnValue<String, String> validationLocationJson(String? value) =>
      _i1.ColumnValue(
        table.validationLocationJson,
        value,
      );

  _i1.ColumnValue<int, int> validationRadiusMeters(int? value) =>
      _i1.ColumnValue(
        table.validationRadiusMeters,
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

class TaxonomyVersionRowTable extends _i1.Table<int?> {
  TaxonomyVersionRowTable({super.tableRelation})
    : super(tableName: 'hayer_taxonomy_version') {
    updateTable = TaxonomyVersionRowUpdateTable(this);
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
    documentJson = _i1.ColumnString(
      'documentJson',
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
    validationLocationJson = _i1.ColumnString(
      'validationLocationJson',
      this,
    );
    validationRadiusMeters = _i1.ColumnInt(
      'validationRadiusMeters',
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

  late final TaxonomyVersionRowUpdateTable updateTable;

  late final _i1.ColumnString version;

  late final _i1.ColumnInt revision;

  late final _i1.ColumnEnum<_i2.TaxonomyStatus> status;

  late final _i1.ColumnString documentJson;

  late final _i1.ColumnBool validationPassed;

  late final _i1.ColumnSerializable<List<String>> validationErrors;

  late final _i1.ColumnString validationLocationJson;

  late final _i1.ColumnInt validationRadiusMeters;

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
    documentJson,
    validationPassed,
    validationErrors,
    validationLocationJson,
    validationRadiusMeters,
    createdBy,
    createdAt,
    validatedAt,
    publishedAt,
  ];
}

class TaxonomyVersionRowInclude extends _i1.IncludeObject {
  TaxonomyVersionRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TaxonomyVersionRow.t;
}

class TaxonomyVersionRowIncludeList extends _i1.IncludeList {
  TaxonomyVersionRowIncludeList._({
    _i1.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TaxonomyVersionRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TaxonomyVersionRow.t;
}

class TaxonomyVersionRowRepository {
  const TaxonomyVersionRowRepository._();

  /// Returns a list of [TaxonomyVersionRow]s matching the given query parameters.
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
  Future<List<TaxonomyVersionRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TaxonomyVersionRow] matching the given query parameters.
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
  Future<TaxonomyVersionRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TaxonomyVersionRow] by its [id] or null if no such row exists.
  Future<TaxonomyVersionRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TaxonomyVersionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TaxonomyVersionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [TaxonomyVersionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TaxonomyVersionRow>> insert(
    _i1.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TaxonomyVersionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TaxonomyVersionRow] and returns the inserted row.
  ///
  /// The returned [TaxonomyVersionRow] will have its `id` field set.
  Future<TaxonomyVersionRow> insertRow(
    _i1.DatabaseSession session,
    TaxonomyVersionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TaxonomyVersionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TaxonomyVersionRow>> update(
    _i1.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _i1.ColumnSelections<TaxonomyVersionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TaxonomyVersionRow>(
      rows,
      columns: columns?.call(TaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaxonomyVersionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TaxonomyVersionRow> updateRow(
    _i1.DatabaseSession session,
    TaxonomyVersionRow row, {
    _i1.ColumnSelections<TaxonomyVersionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TaxonomyVersionRow>(
      row,
      columns: columns?.call(TaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TaxonomyVersionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TaxonomyVersionRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TaxonomyVersionRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TaxonomyVersionRow>(
      id,
      columnValues: columnValues(TaxonomyVersionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TaxonomyVersionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TaxonomyVersionRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TaxonomyVersionRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TaxonomyVersionRowTable>? orderBy,
    _i1.OrderByListBuilder<TaxonomyVersionRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TaxonomyVersionRow>(
      columnValues: columnValues(TaxonomyVersionRow.t.updateTable),
      where: where(TaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TaxonomyVersionRow.t),
      orderByList: orderByList?.call(TaxonomyVersionRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TaxonomyVersionRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TaxonomyVersionRow>> delete(
    _i1.DatabaseSession session,
    List<TaxonomyVersionRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TaxonomyVersionRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TaxonomyVersionRow].
  Future<TaxonomyVersionRow> deleteRow(
    _i1.DatabaseSession session,
    TaxonomyVersionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TaxonomyVersionRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TaxonomyVersionRow>(
      where: where(TaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TaxonomyVersionRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TaxonomyVersionRow>(
      where: where?.call(TaxonomyVersionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TaxonomyVersionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TaxonomyVersionRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TaxonomyVersionRow>(
      where: where(TaxonomyVersionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
