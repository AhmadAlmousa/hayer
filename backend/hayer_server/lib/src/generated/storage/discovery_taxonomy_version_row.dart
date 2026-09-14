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

abstract class DiscoveryTaxonomyVersionRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscoveryTaxonomyVersionRow._({
    this.id,
    required this.version,
    required this.revision,
    required this.status,
    required this.documentJson,
    required this.validationPassed,
    required this.validationErrors,
    required this.createdBy,
    required this.createdAt,
    this.validatedAt,
    this.publishedAt,
  });

  factory DiscoveryTaxonomyVersionRow({
    int? id,
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required String documentJson,
    required bool validationPassed,
    required List<String> validationErrors,
    required String createdBy,
    required DateTime createdAt,
    DateTime? validatedAt,
    DateTime? publishedAt,
  }) = _DiscoveryTaxonomyVersionRowImpl;

  factory DiscoveryTaxonomyVersionRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DiscoveryTaxonomyVersionRow(
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

  static final t = DiscoveryTaxonomyVersionRowTable();

  static const db = DiscoveryTaxonomyVersionRowRepository._();

  @override
  int? id;

  String version;

  int revision;

  _i2.TaxonomyStatus status;

  String documentJson;

  bool validationPassed;

  List<String> validationErrors;

  String createdBy;

  DateTime createdAt;

  DateTime? validatedAt;

  DateTime? publishedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryTaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryTaxonomyVersionRow copyWith({
    int? id,
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    String? documentJson,
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
      '__className__': 'DiscoveryTaxonomyVersionRow',
      if (id != null) 'id': id,
      'version': version,
      'revision': revision,
      'status': status.toJson(),
      'documentJson': documentJson,
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

  static DiscoveryTaxonomyVersionRowInclude include() {
    return DiscoveryTaxonomyVersionRowInclude._();
  }

  static DiscoveryTaxonomyVersionRowIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    DiscoveryTaxonomyVersionRowInclude? include,
  }) {
    return DiscoveryTaxonomyVersionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryTaxonomyVersionRowImpl extends DiscoveryTaxonomyVersionRow {
  _DiscoveryTaxonomyVersionRowImpl({
    int? id,
    required String version,
    required int revision,
    required _i2.TaxonomyStatus status,
    required String documentJson,
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
         documentJson: documentJson,
         validationPassed: validationPassed,
         validationErrors: validationErrors,
         createdBy: createdBy,
         createdAt: createdAt,
         validatedAt: validatedAt,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [DiscoveryTaxonomyVersionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryTaxonomyVersionRow copyWith({
    Object? id = _Undefined,
    String? version,
    int? revision,
    _i2.TaxonomyStatus? status,
    String? documentJson,
    bool? validationPassed,
    List<String>? validationErrors,
    String? createdBy,
    DateTime? createdAt,
    Object? validatedAt = _Undefined,
    Object? publishedAt = _Undefined,
  }) {
    return DiscoveryTaxonomyVersionRow(
      id: id is int? ? id : this.id,
      version: version ?? this.version,
      revision: revision ?? this.revision,
      status: status ?? this.status,
      documentJson: documentJson ?? this.documentJson,
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

class DiscoveryTaxonomyVersionRowUpdateTable
    extends _i1.UpdateTable<DiscoveryTaxonomyVersionRowTable> {
  DiscoveryTaxonomyVersionRowUpdateTable(super.table);

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

class DiscoveryTaxonomyVersionRowTable extends _i1.Table<int?> {
  DiscoveryTaxonomyVersionRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_taxonomy') {
    updateTable = DiscoveryTaxonomyVersionRowUpdateTable(this);
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

  late final DiscoveryTaxonomyVersionRowUpdateTable updateTable;

  late final _i1.ColumnString version;

  late final _i1.ColumnInt revision;

  late final _i1.ColumnEnum<_i2.TaxonomyStatus> status;

  late final _i1.ColumnString documentJson;

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
    documentJson,
    validationPassed,
    validationErrors,
    createdBy,
    createdAt,
    validatedAt,
    publishedAt,
  ];
}

class DiscoveryTaxonomyVersionRowInclude extends _i1.IncludeObject {
  DiscoveryTaxonomyVersionRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryTaxonomyVersionRow.t;
}

class DiscoveryTaxonomyVersionRowIncludeList extends _i1.IncludeList {
  DiscoveryTaxonomyVersionRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryTaxonomyVersionRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryTaxonomyVersionRow.t;
}

class DiscoveryTaxonomyVersionRowRepository {
  const DiscoveryTaxonomyVersionRowRepository._();

  /// Returns a list of [DiscoveryTaxonomyVersionRow]s matching the given query parameters.
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
  Future<List<DiscoveryTaxonomyVersionRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryTaxonomyVersionRow] matching the given query parameters.
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
  Future<DiscoveryTaxonomyVersionRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryTaxonomyVersionRow] by its [id] or null if no such row exists.
  Future<DiscoveryTaxonomyVersionRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryTaxonomyVersionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryTaxonomyVersionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryTaxonomyVersionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscoveryTaxonomyVersionRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryTaxonomyVersionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryTaxonomyVersionRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryTaxonomyVersionRow] will have its `id` field set.
  Future<DiscoveryTaxonomyVersionRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryTaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTaxonomyVersionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryTaxonomyVersionRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _i1.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryTaxonomyVersionRow>(
      rows,
      columns: columns?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTaxonomyVersionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryTaxonomyVersionRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _i1.ColumnSelections<DiscoveryTaxonomyVersionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryTaxonomyVersionRow>(
      row,
      columns: columns?.call(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryTaxonomyVersionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryTaxonomyVersionRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryTaxonomyVersionRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryTaxonomyVersionRow>(
      id,
      columnValues: columnValues(DiscoveryTaxonomyVersionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryTaxonomyVersionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryTaxonomyVersionRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryTaxonomyVersionRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryTaxonomyVersionRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryTaxonomyVersionRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryTaxonomyVersionRow>(
      columnValues: columnValues(DiscoveryTaxonomyVersionRow.t.updateTable),
      where: where(DiscoveryTaxonomyVersionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryTaxonomyVersionRow.t),
      orderByList: orderByList?.call(DiscoveryTaxonomyVersionRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryTaxonomyVersionRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryTaxonomyVersionRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryTaxonomyVersionRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryTaxonomyVersionRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryTaxonomyVersionRow].
  Future<DiscoveryTaxonomyVersionRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryTaxonomyVersionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryTaxonomyVersionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryTaxonomyVersionRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryTaxonomyVersionRow>(
      where: where(DiscoveryTaxonomyVersionRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryTaxonomyVersionRow>(
      where: where?.call(DiscoveryTaxonomyVersionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryTaxonomyVersionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryTaxonomyVersionRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryTaxonomyVersionRow>(
      where: where(DiscoveryTaxonomyVersionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
