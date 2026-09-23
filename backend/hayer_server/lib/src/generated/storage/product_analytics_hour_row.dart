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

abstract class ProductAnalyticsHourRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ProductAnalyticsHourRow._({
    this.id,
    required this.aggregateKey,
    required this.bucketStartedAt,
    required this.metricName,
    required this.modeKey,
    required this.countryCode,
    required this.cityKey,
    required this.cityName,
    required this.categoryId,
    required this.taxonomyKind,
    required this.taxonomyId,
    required this.placeId,
    required this.placeName,
    required this.total,
    required this.sampleCount,
    required this.updatedAt,
  });

  factory ProductAnalyticsHourRow({
    int? id,
    required String aggregateKey,
    required DateTime bucketStartedAt,
    required String metricName,
    required String modeKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    required String categoryId,
    required String taxonomyKind,
    required String taxonomyId,
    required String placeId,
    required String placeName,
    required double total,
    required int sampleCount,
    required DateTime updatedAt,
  }) = _ProductAnalyticsHourRowImpl;

  factory ProductAnalyticsHourRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProductAnalyticsHourRow(
      id: jsonSerialization['id'] as int?,
      aggregateKey: jsonSerialization['aggregateKey'] as String,
      bucketStartedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['bucketStartedAt'],
      ),
      metricName: jsonSerialization['metricName'] as String,
      modeKey: jsonSerialization['modeKey'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      cityKey: jsonSerialization['cityKey'] as String,
      cityName: jsonSerialization['cityName'] as String,
      categoryId: jsonSerialization['categoryId'] as String,
      taxonomyKind: jsonSerialization['taxonomyKind'] as String,
      taxonomyId: jsonSerialization['taxonomyId'] as String,
      placeId: jsonSerialization['placeId'] as String,
      placeName: jsonSerialization['placeName'] as String,
      total: (jsonSerialization['total'] as num).toDouble(),
      sampleCount: jsonSerialization['sampleCount'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ProductAnalyticsHourRowTable();

  static const db = ProductAnalyticsHourRowRepository._();

  @override
  int? id;

  String aggregateKey;

  DateTime bucketStartedAt;

  String metricName;

  String modeKey;

  String countryCode;

  String cityKey;

  String cityName;

  String categoryId;

  String taxonomyKind;

  String taxonomyId;

  String placeId;

  String placeName;

  double total;

  int sampleCount;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductAnalyticsHourRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProductAnalyticsHourRow copyWith({
    int? id,
    String? aggregateKey,
    DateTime? bucketStartedAt,
    String? metricName,
    String? modeKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    String? categoryId,
    String? taxonomyKind,
    String? taxonomyId,
    String? placeId,
    String? placeName,
    double? total,
    int? sampleCount,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductAnalyticsHourRow',
      if (id != null) 'id': id,
      'aggregateKey': aggregateKey,
      'bucketStartedAt': bucketStartedAt.toJson(),
      'metricName': metricName,
      'modeKey': modeKey,
      'countryCode': countryCode,
      'cityKey': cityKey,
      'cityName': cityName,
      'categoryId': categoryId,
      'taxonomyKind': taxonomyKind,
      'taxonomyId': taxonomyId,
      'placeId': placeId,
      'placeName': placeName,
      'total': total,
      'sampleCount': sampleCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ProductAnalyticsHourRowInclude include() {
    return ProductAnalyticsHourRowInclude._();
  }

  static ProductAnalyticsHourRowIncludeList includeList({
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    ProductAnalyticsHourRowInclude? include,
  }) {
    return ProductAnalyticsHourRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductAnalyticsHourRowImpl extends ProductAnalyticsHourRow {
  _ProductAnalyticsHourRowImpl({
    int? id,
    required String aggregateKey,
    required DateTime bucketStartedAt,
    required String metricName,
    required String modeKey,
    required String countryCode,
    required String cityKey,
    required String cityName,
    required String categoryId,
    required String taxonomyKind,
    required String taxonomyId,
    required String placeId,
    required String placeName,
    required double total,
    required int sampleCount,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         aggregateKey: aggregateKey,
         bucketStartedAt: bucketStartedAt,
         metricName: metricName,
         modeKey: modeKey,
         countryCode: countryCode,
         cityKey: cityKey,
         cityName: cityName,
         categoryId: categoryId,
         taxonomyKind: taxonomyKind,
         taxonomyId: taxonomyId,
         placeId: placeId,
         placeName: placeName,
         total: total,
         sampleCount: sampleCount,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProductAnalyticsHourRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProductAnalyticsHourRow copyWith({
    Object? id = _Undefined,
    String? aggregateKey,
    DateTime? bucketStartedAt,
    String? metricName,
    String? modeKey,
    String? countryCode,
    String? cityKey,
    String? cityName,
    String? categoryId,
    String? taxonomyKind,
    String? taxonomyId,
    String? placeId,
    String? placeName,
    double? total,
    int? sampleCount,
    DateTime? updatedAt,
  }) {
    return ProductAnalyticsHourRow(
      id: id is int? ? id : this.id,
      aggregateKey: aggregateKey ?? this.aggregateKey,
      bucketStartedAt: bucketStartedAt ?? this.bucketStartedAt,
      metricName: metricName ?? this.metricName,
      modeKey: modeKey ?? this.modeKey,
      countryCode: countryCode ?? this.countryCode,
      cityKey: cityKey ?? this.cityKey,
      cityName: cityName ?? this.cityName,
      categoryId: categoryId ?? this.categoryId,
      taxonomyKind: taxonomyKind ?? this.taxonomyKind,
      taxonomyId: taxonomyId ?? this.taxonomyId,
      placeId: placeId ?? this.placeId,
      placeName: placeName ?? this.placeName,
      total: total ?? this.total,
      sampleCount: sampleCount ?? this.sampleCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductAnalyticsHourRowUpdateTable
    extends _is.UpdateTable<ProductAnalyticsHourRowTable> {
  ProductAnalyticsHourRowUpdateTable(super.table);

  _is.ColumnValue<String, String> aggregateKey(String value) => _is.ColumnValue(
    table.aggregateKey,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> bucketStartedAt(DateTime value) =>
      _is.ColumnValue(
        table.bucketStartedAt,
        value,
      );

  _is.ColumnValue<String, String> metricName(String value) => _is.ColumnValue(
    table.metricName,
    value,
  );

  _is.ColumnValue<String, String> modeKey(String value) => _is.ColumnValue(
    table.modeKey,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<String, String> cityKey(String value) => _is.ColumnValue(
    table.cityKey,
    value,
  );

  _is.ColumnValue<String, String> cityName(String value) => _is.ColumnValue(
    table.cityName,
    value,
  );

  _is.ColumnValue<String, String> categoryId(String value) => _is.ColumnValue(
    table.categoryId,
    value,
  );

  _is.ColumnValue<String, String> taxonomyKind(String value) => _is.ColumnValue(
    table.taxonomyKind,
    value,
  );

  _is.ColumnValue<String, String> taxonomyId(String value) => _is.ColumnValue(
    table.taxonomyId,
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

  _is.ColumnValue<double, double> total(double value) => _is.ColumnValue(
    table.total,
    value,
  );

  _is.ColumnValue<int, int> sampleCount(int value) => _is.ColumnValue(
    table.sampleCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ProductAnalyticsHourRowTable extends _is.Table<int?> {
  ProductAnalyticsHourRowTable({super.tableRelation})
    : super(tableName: 'hayer_product_analytics_hour') {
    updateTable = ProductAnalyticsHourRowUpdateTable(this);
    aggregateKey = _is.ColumnString(
      'aggregateKey',
      this,
    );
    bucketStartedAt = _is.ColumnDateTime(
      'bucketStartedAt',
      this,
    );
    metricName = _is.ColumnString(
      'metricName',
      this,
    );
    modeKey = _is.ColumnString(
      'modeKey',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    cityKey = _is.ColumnString(
      'cityKey',
      this,
    );
    cityName = _is.ColumnString(
      'cityName',
      this,
    );
    categoryId = _is.ColumnString(
      'categoryId',
      this,
    );
    taxonomyKind = _is.ColumnString(
      'taxonomyKind',
      this,
    );
    taxonomyId = _is.ColumnString(
      'taxonomyId',
      this,
    );
    placeId = _is.ColumnString(
      'placeId',
      this,
    );
    placeName = _is.ColumnString(
      'placeName',
      this,
    );
    total = _is.ColumnDouble(
      'total',
      this,
    );
    sampleCount = _is.ColumnInt(
      'sampleCount',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ProductAnalyticsHourRowUpdateTable updateTable;

  late final _is.ColumnString aggregateKey;

  late final _is.ColumnDateTime bucketStartedAt;

  late final _is.ColumnString metricName;

  late final _is.ColumnString modeKey;

  late final _is.ColumnString countryCode;

  late final _is.ColumnString cityKey;

  late final _is.ColumnString cityName;

  late final _is.ColumnString categoryId;

  late final _is.ColumnString taxonomyKind;

  late final _is.ColumnString taxonomyId;

  late final _is.ColumnString placeId;

  late final _is.ColumnString placeName;

  late final _is.ColumnDouble total;

  late final _is.ColumnInt sampleCount;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    aggregateKey,
    bucketStartedAt,
    metricName,
    modeKey,
    countryCode,
    cityKey,
    cityName,
    categoryId,
    taxonomyKind,
    taxonomyId,
    placeId,
    placeName,
    total,
    sampleCount,
    updatedAt,
  ];
}

class ProductAnalyticsHourRowInclude extends _is.IncludeObject {
  ProductAnalyticsHourRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProductAnalyticsHourRow.t;
}

class ProductAnalyticsHourRowIncludeList extends _is.IncludeList {
  ProductAnalyticsHourRowIncludeList._({
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductAnalyticsHourRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProductAnalyticsHourRow.t;
}

class ProductAnalyticsHourRowRepository {
  const ProductAnalyticsHourRowRepository._();

  /// Returns a list of [ProductAnalyticsHourRow]s matching the given query parameters.
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
  Future<List<ProductAnalyticsHourRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductAnalyticsHourRow] matching the given query parameters.
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
  Future<ProductAnalyticsHourRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductAnalyticsHourRow] by its [id] or null if no such row exists.
  Future<ProductAnalyticsHourRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductAnalyticsHourRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductAnalyticsHourRow]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductAnalyticsHourRow]s will have their `id` fields set.
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
  Future<List<ProductAnalyticsHourRow>> insert(
    _is.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProductAnalyticsHourRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProductAnalyticsHourRow] and returns the inserted row.
  ///
  /// The returned [ProductAnalyticsHourRow] will have its `id` field set.
  Future<ProductAnalyticsHourRow> insertRow(
    _is.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductAnalyticsHourRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProductAnalyticsHourRow]s in the list and returns the resulting rows.
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
  /// The returned [ProductAnalyticsHourRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsHourRow>> upsert(
    _is.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    required _is.ColumnSelections<ProductAnalyticsHourRowTable> conflictColumns,
    _is.ColumnSelections<ProductAnalyticsHourRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProductAnalyticsHourRow>(
      rows,
      conflictColumns: conflictColumns(ProductAnalyticsHourRow.t),
      updateColumns: updateColumns?.call(ProductAnalyticsHourRow.t),
      updateWhere: updateWhere?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProductAnalyticsHourRow] and returns the resulting row.
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
  /// The returned [ProductAnalyticsHourRow] will have its `id` field set.
  Future<ProductAnalyticsHourRow?> upsertRow(
    _is.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    required _is.ColumnSelections<ProductAnalyticsHourRowTable> conflictColumns,
    _is.ColumnSelections<ProductAnalyticsHourRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProductAnalyticsHourRow>(
      row,
      conflictColumns: conflictColumns(ProductAnalyticsHourRow.t),
      updateColumns: updateColumns?.call(ProductAnalyticsHourRow.t),
      updateWhere: updateWhere?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsHourRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsHourRow>> update(
    _is.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _is.ColumnSelections<ProductAnalyticsHourRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProductAnalyticsHourRow>(
      rows,
      columns: columns?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProductAnalyticsHourRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductAnalyticsHourRow> updateRow(
    _is.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _is.ColumnSelections<ProductAnalyticsHourRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductAnalyticsHourRow>(
      row,
      columns: columns?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductAnalyticsHourRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductAnalyticsHourRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProductAnalyticsHourRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductAnalyticsHourRow>(
      id,
      columnValues: columnValues(ProductAnalyticsHourRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsHourRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsHourRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProductAnalyticsHourRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProductAnalyticsHourRow>(
      columnValues: columnValues(ProductAnalyticsHourRow.t.updateTable),
      where: where(ProductAnalyticsHourRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProductAnalyticsHourRow]s in the list and returns the deleted rows.
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
  Future<List<ProductAnalyticsHourRow>> delete(
    _is.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProductAnalyticsHourRow>(
      rows,
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProductAnalyticsHourRow].
  Future<ProductAnalyticsHourRow> deleteRow(
    _is.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductAnalyticsHourRow>(
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
  Future<List<ProductAnalyticsHourRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    _is.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProductAnalyticsHourRow>(
      where: where(ProductAnalyticsHourRow.t),
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductAnalyticsHourRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductAnalyticsHourRow>(
      where: where(ProductAnalyticsHourRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
