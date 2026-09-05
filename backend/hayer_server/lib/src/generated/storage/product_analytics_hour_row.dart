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

abstract class ProductAnalyticsHourRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
      bucketStartedAt: _i1.DateTimeJsonExtension.fromJson(
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
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductAnalyticsHourRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    ProductAnalyticsHourRowInclude? include,
  }) {
    return ProductAnalyticsHourRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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
    extends _i1.UpdateTable<ProductAnalyticsHourRowTable> {
  ProductAnalyticsHourRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> aggregateKey(String value) => _i1.ColumnValue(
    table.aggregateKey,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> bucketStartedAt(DateTime value) =>
      _i1.ColumnValue(
        table.bucketStartedAt,
        value,
      );

  _i1.ColumnValue<String, String> metricName(String value) => _i1.ColumnValue(
    table.metricName,
    value,
  );

  _i1.ColumnValue<String, String> modeKey(String value) => _i1.ColumnValue(
    table.modeKey,
    value,
  );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<String, String> cityKey(String value) => _i1.ColumnValue(
    table.cityKey,
    value,
  );

  _i1.ColumnValue<String, String> cityName(String value) => _i1.ColumnValue(
    table.cityName,
    value,
  );

  _i1.ColumnValue<String, String> categoryId(String value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<String, String> taxonomyKind(String value) => _i1.ColumnValue(
    table.taxonomyKind,
    value,
  );

  _i1.ColumnValue<String, String> taxonomyId(String value) => _i1.ColumnValue(
    table.taxonomyId,
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

  _i1.ColumnValue<double, double> total(double value) => _i1.ColumnValue(
    table.total,
    value,
  );

  _i1.ColumnValue<int, int> sampleCount(int value) => _i1.ColumnValue(
    table.sampleCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ProductAnalyticsHourRowTable extends _i1.Table<int?> {
  ProductAnalyticsHourRowTable({super.tableRelation})
    : super(tableName: 'hayer_product_analytics_hour') {
    updateTable = ProductAnalyticsHourRowUpdateTable(this);
    aggregateKey = _i1.ColumnString(
      'aggregateKey',
      this,
    );
    bucketStartedAt = _i1.ColumnDateTime(
      'bucketStartedAt',
      this,
    );
    metricName = _i1.ColumnString(
      'metricName',
      this,
    );
    modeKey = _i1.ColumnString(
      'modeKey',
      this,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    cityKey = _i1.ColumnString(
      'cityKey',
      this,
    );
    cityName = _i1.ColumnString(
      'cityName',
      this,
    );
    categoryId = _i1.ColumnString(
      'categoryId',
      this,
    );
    taxonomyKind = _i1.ColumnString(
      'taxonomyKind',
      this,
    );
    taxonomyId = _i1.ColumnString(
      'taxonomyId',
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
    total = _i1.ColumnDouble(
      'total',
      this,
    );
    sampleCount = _i1.ColumnInt(
      'sampleCount',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ProductAnalyticsHourRowUpdateTable updateTable;

  late final _i1.ColumnString aggregateKey;

  late final _i1.ColumnDateTime bucketStartedAt;

  late final _i1.ColumnString metricName;

  late final _i1.ColumnString modeKey;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnString cityKey;

  late final _i1.ColumnString cityName;

  late final _i1.ColumnString categoryId;

  late final _i1.ColumnString taxonomyKind;

  late final _i1.ColumnString taxonomyId;

  late final _i1.ColumnString placeId;

  late final _i1.ColumnString placeName;

  late final _i1.ColumnDouble total;

  late final _i1.ColumnInt sampleCount;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
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

class ProductAnalyticsHourRowInclude extends _i1.IncludeObject {
  ProductAnalyticsHourRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductAnalyticsHourRow.t;
}

class ProductAnalyticsHourRowIncludeList extends _i1.IncludeList {
  ProductAnalyticsHourRowIncludeList._({
    _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductAnalyticsHourRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductAnalyticsHourRow.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      orderDescending: orderDescending,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductAnalyticsHourRow] by its [id] or null if no such row exists.
  Future<ProductAnalyticsHourRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
  Future<List<ProductAnalyticsHourRow>> insert(
    _i1.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductAnalyticsHourRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductAnalyticsHourRow] and returns the inserted row.
  ///
  /// The returned [ProductAnalyticsHourRow] will have its `id` field set.
  Future<ProductAnalyticsHourRow> insertRow(
    _i1.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductAnalyticsHourRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsHourRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductAnalyticsHourRow>> update(
    _i1.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _i1.ColumnSelections<ProductAnalyticsHourRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductAnalyticsHourRow>(
      rows,
      columns: columns?.call(ProductAnalyticsHourRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductAnalyticsHourRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductAnalyticsHourRow> updateRow(
    _i1.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _i1.ColumnSelections<ProductAnalyticsHourRowTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductAnalyticsHourRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductAnalyticsHourRow>(
      id,
      columnValues: columnValues(ProductAnalyticsHourRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsHourRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductAnalyticsHourRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductAnalyticsHourRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsHourRowTable>? orderBy,
    _i1.OrderByListBuilder<ProductAnalyticsHourRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductAnalyticsHourRow>(
      columnValues: columnValues(ProductAnalyticsHourRow.t.updateTable),
      where: where(ProductAnalyticsHourRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsHourRow.t),
      orderByList: orderByList?.call(ProductAnalyticsHourRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductAnalyticsHourRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductAnalyticsHourRow>> delete(
    _i1.DatabaseSession session,
    List<ProductAnalyticsHourRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductAnalyticsHourRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductAnalyticsHourRow].
  Future<ProductAnalyticsHourRow> deleteRow(
    _i1.DatabaseSession session,
    ProductAnalyticsHourRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductAnalyticsHourRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductAnalyticsHourRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductAnalyticsHourRow>(
      where: where(ProductAnalyticsHourRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductAnalyticsHourRow>(
      where: where?.call(ProductAnalyticsHourRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductAnalyticsHourRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductAnalyticsHourRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductAnalyticsHourRow>(
      where: where(ProductAnalyticsHourRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
