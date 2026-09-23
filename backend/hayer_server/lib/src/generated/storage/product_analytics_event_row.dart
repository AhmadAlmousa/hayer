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

abstract class ProductAnalyticsEventRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    this.receivedAt,
    this.eventSchemaVersion,
    this.origin,
    this.journeyId,
    this.appBuild,
    this.platform,
    this.language,
    this.outcomeCode,
    this.deckPosition,
    this.visibleMilliseconds,
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
    DateTime? receivedAt,
    int? eventSchemaVersion,
    String? origin,
    String? journeyId,
    int? appBuild,
    String? platform,
    String? language,
    String? outcomeCode,
    int? deckPosition,
    int? visibleMilliseconds,
    DateTime? processedAt,
  }) = _ProductAnalyticsEventRowImpl;

  factory ProductAnalyticsEventRow.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProductAnalyticsEventRow(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String,
      occurredAt: _is.DateTimeJsonExtension.fromJson(
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
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
      eventSchemaVersion: jsonSerialization['eventSchemaVersion'] as int?,
      origin: jsonSerialization['origin'] as String?,
      journeyId: jsonSerialization['journeyId'] as String?,
      appBuild: jsonSerialization['appBuild'] as int?,
      platform: jsonSerialization['platform'] as String?,
      language: jsonSerialization['language'] as String?,
      outcomeCode: jsonSerialization['outcomeCode'] as String?,
      deckPosition: jsonSerialization['deckPosition'] as int?,
      visibleMilliseconds: jsonSerialization['visibleMilliseconds'] as int?,
      processedAt: jsonSerialization['processedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
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

  DateTime? receivedAt;

  int? eventSchemaVersion;

  String? origin;

  String? journeyId;

  int? appBuild;

  String? platform;

  String? language;

  String? outcomeCode;

  int? deckPosition;

  int? visibleMilliseconds;

  DateTime? processedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ProductAnalyticsEventRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    DateTime? receivedAt,
    int? eventSchemaVersion,
    String? origin,
    String? journeyId,
    int? appBuild,
    String? platform,
    String? language,
    String? outcomeCode,
    int? deckPosition,
    int? visibleMilliseconds,
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
      if (receivedAt != null) 'receivedAt': receivedAt?.toJson(),
      if (eventSchemaVersion != null) 'eventSchemaVersion': eventSchemaVersion,
      if (origin != null) 'origin': origin,
      if (journeyId != null) 'journeyId': journeyId,
      if (appBuild != null) 'appBuild': appBuild,
      if (platform != null) 'platform': platform,
      if (language != null) 'language': language,
      if (outcomeCode != null) 'outcomeCode': outcomeCode,
      if (deckPosition != null) 'deckPosition': deckPosition,
      if (visibleMilliseconds != null)
        'visibleMilliseconds': visibleMilliseconds,
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
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    ProductAnalyticsEventRowInclude? include,
  }) {
    return ProductAnalyticsEventRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    DateTime? receivedAt,
    int? eventSchemaVersion,
    String? origin,
    String? journeyId,
    int? appBuild,
    String? platform,
    String? language,
    String? outcomeCode,
    int? deckPosition,
    int? visibleMilliseconds,
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
         receivedAt: receivedAt,
         eventSchemaVersion: eventSchemaVersion,
         origin: origin,
         journeyId: journeyId,
         appBuild: appBuild,
         platform: platform,
         language: language,
         outcomeCode: outcomeCode,
         deckPosition: deckPosition,
         visibleMilliseconds: visibleMilliseconds,
         processedAt: processedAt,
       );

  /// Returns a shallow copy of this [ProductAnalyticsEventRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? receivedAt = _Undefined,
    Object? eventSchemaVersion = _Undefined,
    Object? origin = _Undefined,
    Object? journeyId = _Undefined,
    Object? appBuild = _Undefined,
    Object? platform = _Undefined,
    Object? language = _Undefined,
    Object? outcomeCode = _Undefined,
    Object? deckPosition = _Undefined,
    Object? visibleMilliseconds = _Undefined,
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
      receivedAt: receivedAt is DateTime? ? receivedAt : this.receivedAt,
      eventSchemaVersion: eventSchemaVersion is int?
          ? eventSchemaVersion
          : this.eventSchemaVersion,
      origin: origin is String? ? origin : this.origin,
      journeyId: journeyId is String? ? journeyId : this.journeyId,
      appBuild: appBuild is int? ? appBuild : this.appBuild,
      platform: platform is String? ? platform : this.platform,
      language: language is String? ? language : this.language,
      outcomeCode: outcomeCode is String? ? outcomeCode : this.outcomeCode,
      deckPosition: deckPosition is int? ? deckPosition : this.deckPosition,
      visibleMilliseconds: visibleMilliseconds is int?
          ? visibleMilliseconds
          : this.visibleMilliseconds,
      processedAt: processedAt is DateTime? ? processedAt : this.processedAt,
    );
  }
}

class ProductAnalyticsEventRowUpdateTable
    extends _is.UpdateTable<ProductAnalyticsEventRowTable> {
  ProductAnalyticsEventRowUpdateTable(super.table);

  _is.ColumnValue<String, String> eventId(String value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _is.ColumnValue(
        table.occurredAt,
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

  _is.ColumnValue<double, double> value(double value) => _is.ColumnValue(
    table.value,
    value,
  );

  _is.ColumnValue<int, int> sampleCount(int value) => _is.ColumnValue(
    table.sampleCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> receivedAt(DateTime? value) =>
      _is.ColumnValue(
        table.receivedAt,
        value,
      );

  _is.ColumnValue<int, int> eventSchemaVersion(int? value) => _is.ColumnValue(
    table.eventSchemaVersion,
    value,
  );

  _is.ColumnValue<String, String> origin(String? value) => _is.ColumnValue(
    table.origin,
    value,
  );

  _is.ColumnValue<String, String> journeyId(String? value) => _is.ColumnValue(
    table.journeyId,
    value,
  );

  _is.ColumnValue<int, int> appBuild(int? value) => _is.ColumnValue(
    table.appBuild,
    value,
  );

  _is.ColumnValue<String, String> platform(String? value) => _is.ColumnValue(
    table.platform,
    value,
  );

  _is.ColumnValue<String, String> language(String? value) => _is.ColumnValue(
    table.language,
    value,
  );

  _is.ColumnValue<String, String> outcomeCode(String? value) => _is.ColumnValue(
    table.outcomeCode,
    value,
  );

  _is.ColumnValue<int, int> deckPosition(int? value) => _is.ColumnValue(
    table.deckPosition,
    value,
  );

  _is.ColumnValue<int, int> visibleMilliseconds(int? value) => _is.ColumnValue(
    table.visibleMilliseconds,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> processedAt(DateTime? value) =>
      _is.ColumnValue(
        table.processedAt,
        value,
      );
}

class ProductAnalyticsEventRowTable extends _is.Table<int?> {
  ProductAnalyticsEventRowTable({super.tableRelation})
    : super(tableName: 'hayer_product_analytics_event') {
    updateTable = ProductAnalyticsEventRowUpdateTable(this);
    eventId = _is.ColumnString(
      'eventId',
      this,
    );
    occurredAt = _is.ColumnDateTime(
      'occurredAt',
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
    value = _is.ColumnDouble(
      'value',
      this,
    );
    sampleCount = _is.ColumnInt(
      'sampleCount',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
    eventSchemaVersion = _is.ColumnInt(
      'eventSchemaVersion',
      this,
    );
    origin = _is.ColumnString(
      'origin',
      this,
    );
    journeyId = _is.ColumnString(
      'journeyId',
      this,
    );
    appBuild = _is.ColumnInt(
      'appBuild',
      this,
    );
    platform = _is.ColumnString(
      'platform',
      this,
    );
    language = _is.ColumnString(
      'language',
      this,
    );
    outcomeCode = _is.ColumnString(
      'outcomeCode',
      this,
    );
    deckPosition = _is.ColumnInt(
      'deckPosition',
      this,
    );
    visibleMilliseconds = _is.ColumnInt(
      'visibleMilliseconds',
      this,
    );
    processedAt = _is.ColumnDateTime(
      'processedAt',
      this,
    );
  }

  late final ProductAnalyticsEventRowUpdateTable updateTable;

  late final _is.ColumnString eventId;

  late final _is.ColumnDateTime occurredAt;

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

  late final _is.ColumnDouble value;

  late final _is.ColumnInt sampleCount;

  late final _is.ColumnDateTime receivedAt;

  late final _is.ColumnInt eventSchemaVersion;

  late final _is.ColumnString origin;

  late final _is.ColumnString journeyId;

  late final _is.ColumnInt appBuild;

  late final _is.ColumnString platform;

  late final _is.ColumnString language;

  late final _is.ColumnString outcomeCode;

  late final _is.ColumnInt deckPosition;

  late final _is.ColumnInt visibleMilliseconds;

  late final _is.ColumnDateTime processedAt;

  @override
  List<_is.Column> get columns => [
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
    receivedAt,
    eventSchemaVersion,
    origin,
    journeyId,
    appBuild,
    platform,
    language,
    outcomeCode,
    deckPosition,
    visibleMilliseconds,
    processedAt,
  ];
}

class ProductAnalyticsEventRowInclude extends _is.IncludeObject {
  ProductAnalyticsEventRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ProductAnalyticsEventRow.t;
}

class ProductAnalyticsEventRowIncludeList extends _is.IncludeList {
  ProductAnalyticsEventRowIncludeList._({
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ProductAnalyticsEventRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ProductAnalyticsEventRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ProductAnalyticsEventRow] by its [id] or null if no such row exists.
  Future<ProductAnalyticsEventRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsEventRow>> insert(
    _is.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ProductAnalyticsEventRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ProductAnalyticsEventRow] and returns the inserted row.
  ///
  /// The returned [ProductAnalyticsEventRow] will have its `id` field set.
  Future<ProductAnalyticsEventRow> insertRow(
    _is.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ProductAnalyticsEventRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ProductAnalyticsEventRow]s in the list and returns the resulting rows.
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
  /// The returned [ProductAnalyticsEventRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsEventRow>> upsert(
    _is.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    required _is.ColumnSelections<ProductAnalyticsEventRowTable>
    conflictColumns,
    _is.ColumnSelections<ProductAnalyticsEventRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ProductAnalyticsEventRow>(
      rows,
      conflictColumns: conflictColumns(ProductAnalyticsEventRow.t),
      updateColumns: updateColumns?.call(ProductAnalyticsEventRow.t),
      updateWhere: updateWhere?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ProductAnalyticsEventRow] and returns the resulting row.
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
  /// The returned [ProductAnalyticsEventRow] will have its `id` field set.
  Future<ProductAnalyticsEventRow?> upsertRow(
    _is.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    required _is.ColumnSelections<ProductAnalyticsEventRowTable>
    conflictColumns,
    _is.ColumnSelections<ProductAnalyticsEventRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ProductAnalyticsEventRow>(
      row,
      conflictColumns: conflictColumns(ProductAnalyticsEventRow.t),
      updateColumns: updateColumns?.call(ProductAnalyticsEventRow.t),
      updateWhere: updateWhere?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsEventRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsEventRow>> update(
    _is.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _is.ColumnSelections<ProductAnalyticsEventRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ProductAnalyticsEventRow>(
      rows,
      columns: columns?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ProductAnalyticsEventRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ProductAnalyticsEventRow> updateRow(
    _is.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _is.ColumnSelections<ProductAnalyticsEventRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProductAnalyticsEventRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ProductAnalyticsEventRow>(
      id,
      columnValues: columnValues(ProductAnalyticsEventRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ProductAnalyticsEventRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ProductAnalyticsEventRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProductAnalyticsEventRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ProductAnalyticsEventRow>(
      columnValues: columnValues(ProductAnalyticsEventRow.t.updateTable),
      where: where(ProductAnalyticsEventRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ProductAnalyticsEventRow]s in the list and returns the deleted rows.
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
  Future<List<ProductAnalyticsEventRow>> delete(
    _is.DatabaseSession session,
    List<ProductAnalyticsEventRow> rows, {
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ProductAnalyticsEventRow>(
      rows,
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ProductAnalyticsEventRow].
  Future<ProductAnalyticsEventRow> deleteRow(
    _is.DatabaseSession session,
    ProductAnalyticsEventRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ProductAnalyticsEventRow>(
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
  Future<List<ProductAnalyticsEventRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    _is.OrderByBuilder<ProductAnalyticsEventRowTable>? orderBy,
    _is.OrderByListBuilder<ProductAnalyticsEventRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ProductAnalyticsEventRow>(
      where: where(ProductAnalyticsEventRow.t),
      orderBy: orderBy?.call(ProductAnalyticsEventRow.t),
      orderByList: orderByList?.call(ProductAnalyticsEventRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ProductAnalyticsEventRow>(
      where: where?.call(ProductAnalyticsEventRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ProductAnalyticsEventRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProductAnalyticsEventRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ProductAnalyticsEventRow>(
      where: where(ProductAnalyticsEventRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
