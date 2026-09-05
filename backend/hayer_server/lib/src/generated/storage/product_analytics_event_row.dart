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

abstract class ProductAnalyticsEventRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ProductAnalyticsEventRow._({
    this.id,
    required this.eventId,
    required this.occurredAt,
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
    required this.value,
    required this.sampleCount,
    this.processedAt,
  });

  factory ProductAnalyticsEventRow({
    int? id,
    required String eventId,
    required DateTime occurredAt,
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
    required double value,
    required int sampleCount,
    DateTime? processedAt,
  }) = _ProductAnalyticsEventRowImpl;

  factory ProductAnalyticsEventRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProductAnalyticsEventRow(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
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
      value: (jsonSerialization['value'] as num).toDouble(),
      sampleCount: jsonSerialization['sampleCount'] as int,
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processedAt'],
            ),
    );
  }

  static final t = ProductAnalyticsEventRowTable();

  static const db = ProductAnalyticsEventRowRepository._();

  @override
  int? id;

  String eventId;

  DateTime occurredAt;

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

  double value;

  int sampleCount;

  DateTime? processedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductAnalyticsEventRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProductAnalyticsEventRow copyWith({
    int? id,
    String? eventId,
    DateTime? occurredAt,
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
    double? value,
    int? sampleCount,
    DateTime? processedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductAnalyticsEventRow',
      if (id != null) 'id': id,
      'eventId': eventId,
      'occurredAt': occurredAt.toJson(),
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
      'value': value,
      'sampleCount': sampleCount,
      if (processedAt != null) 'processedAt': processedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ProductAnalyticsEventRowInclude include() {
    return ProductAnalyticsEventRowInclude._();
  }

  static ProductAnalyticsEventRowIncludeList includeList({
    _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    ProductAnalyticsEventRowInclude? include,
  }) {
    return ProductAnalyticsEventRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductAnalyticsEventRowImpl extends ProductAnalyticsEventRow {
  _ProductAnalyticsEventRowImpl({
    int? id,
    required String eventId,
    required DateTime occurredAt,
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
    required double value,
    required int sampleCount,
    DateTime? processedAt,
  }) : super._(
         id: id,
         eventId: eventId,
         occurredAt: occurredAt,
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
         value: value,
         sampleCount: sampleCount,
         processedAt: processedAt,
       );

  /// Returns a shallow copy of this [ProductAnalyticsEventRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProductAnalyticsEventRow copyWith({
    Object? id = _Undefined,
    String? eventId,
    DateTime? occurredAt,
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
    double? value,
    int? sampleCount,
    Object? processedAt = _Undefined,
  }) {
    return ProductAnalyticsEventRow(
      id: id is int? ? id : this.id,
      eventId: eventId ?? this.eventId,
      occurredAt: occurredAt ?? this.occurredAt,
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
      value: value ?? this.value,
      sampleCount: sampleCount ?? this.sampleCount,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
    );
  }
}

class ProductAnalyticsEventRowUpdateTable
    extends _i1.UpdateTable<ProductAnalyticsEventRowTable> {
  ProductAnalyticsEventRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> eventId(String value) => _i1.ColumnValue(
    table.eventId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _i1.ColumnValue(
        table.occurredAt,
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

  _i1.ColumnValue<double, double> value(double value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<int, int> sampleCount(int value) => _i1.ColumnValue(
    table.sampleCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> processedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.processedAt,
        value,
      );
}

class ProductAnalyticsEventRowTable extends _i1.Table<int?> {
  ProductAnalyticsEventRowTable({super.tableRelation})
    : super(tableName: 'hayer_product_analytics_event') {
    updateTable = ProductAnalyticsEventRowUpdateTable(this);
    eventId = _i1.ColumnString(
      'eventId',
      this,
    );
    occurredAt = _i1.ColumnDateTime(
      'occurredAt',
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
    value = _i1.ColumnDouble(
      'value',
      this,
    );
    sampleCount = _i1.ColumnInt(
      'sampleCount',
      this,
    );
    processedAt = _i1.ColumnDateTime(
      'processedAt',
      this,
    );
  }

  late final ProductAnalyticsEventRowUpdateTable updateTable;

  late final _i1.ColumnString eventId;

  late final _i1.ColumnDateTime occurredAt;

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

  late final _i1.ColumnDouble value;

  late final _i1.ColumnInt sampleCount;

  late final _i1.ColumnDateTime processedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    eventId,
    occurredAt,
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
    value,
    sampleCount,
    processedAt,
  ];
}

class ProductAnalyticsEventRowInclude extends _i1.IncludeObject {
  ProductAnalyticsEventRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ProductAnalyticsEventRow.t;
}

class ProductAnalyticsEventRowIncludeList extends _i1.IncludeList {
  ProductAnalyticsEventRowIncludeList._({
    _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductAnalyticsEventRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ProductAnalyticsEventRow.t;
}

class ProductAnalyticsEventRowRepository {
  const ProductAnalyticsEventRowRepository._();

  /// Returns a list of [ProductAnalyticsEventRow]s matching the given query parameters.
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
  Future<List<ProductAnalyticsEventRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ProductAnalyticsEventRow] matching the given query parameters.
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
  Future<ProductAnalyticsEventRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductAnalyticsEventRow] by its [id] or null if no such row exists.
  Future<ProductAnalyticsEventRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ProductAnalyticsEventRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ProductAnalyticsEventRow]s in the list and returns the inserted rows.
  ///
  /// The returned [ProductAnalyticsEventRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ProductAnalyticsEventRow>> insert(
    _i1.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ProductAnalyticsEventRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ProductAnalyticsEventRow] and returns the inserted row.
  ///
  /// The returned [ProductAnalyticsEventRow] will have its `id` field set.
  Future<ProductAnalyticsEventRow> insertRow(
    _i1.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductAnalyticsEventRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsEventRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ProductAnalyticsEventRow>> update(
    _i1.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _i1.ColumnSelections<ProductAnalyticsEventRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ProductAnalyticsEventRow>(
      rows,
      columns: columns?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductAnalyticsEventRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductAnalyticsEventRow> updateRow(
    _i1.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _i1.ColumnSelections<ProductAnalyticsEventRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ProductAnalyticsEventRow>(
      row,
      columns: columns?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ProductAnalyticsEventRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ProductAnalyticsEventRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ProductAnalyticsEventRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductAnalyticsEventRow>(
      id,
      columnValues: columnValues(ProductAnalyticsEventRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsEventRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ProductAnalyticsEventRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ProductAnalyticsEventRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _i1.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ProductAnalyticsEventRow>(
      columnValues: columnValues(ProductAnalyticsEventRow.t.updateTable),
      where: where(ProductAnalyticsEventRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ProductAnalyticsEventRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ProductAnalyticsEventRow>> delete(
    _i1.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ProductAnalyticsEventRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ProductAnalyticsEventRow].
  Future<ProductAnalyticsEventRow> deleteRow(
    _i1.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductAnalyticsEventRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ProductAnalyticsEventRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ProductAnalyticsEventRow>(
      where: where(ProductAnalyticsEventRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductAnalyticsEventRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductAnalyticsEventRow>(
      where: where(ProductAnalyticsEventRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
