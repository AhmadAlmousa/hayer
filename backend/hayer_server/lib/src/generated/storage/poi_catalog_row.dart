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
import 'package:hayer_server/src/generated/protocol.dart' as _i3;

abstract class PoiCatalogRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PoiCatalogRow._({
    this.id,
    required this.provider,
    required this.providerPlaceId,
    this.featureId,
    required this.normalizedName,
    required this.name,
    required this.countryCode,
    required this.latitude,
    required this.longitude,
    required this.categoryIds,
    required this.snapshot,
    required this.calibrationVersion,
    required this.sourceCheckedAt,
    required this.firstSeenAt,
    required this.lastSeenAt,
    this.quarantinedAt,
    this.quarantineReason,
  });

  factory PoiCatalogRow({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    String? featureId,
    required String normalizedName,
    required String name,
    required String countryCode,
    required double latitude,
    required double longitude,
    required List<String> categoryIds,
    required _i2.PlaceSnapshot snapshot,
    required String calibrationVersion,
    required DateTime sourceCheckedAt,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
    DateTime? quarantinedAt,
    String? quarantineReason,
  }) = _PoiCatalogRowImpl;

  factory PoiCatalogRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PoiCatalogRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
      featureId: jsonSerialization['featureId'] as String?,
      normalizedName: jsonSerialization['normalizedName'] as String,
      name: jsonSerialization['name'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      categoryIds: _i3.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      snapshot: _i3.Protocol().deserialize<_i2.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      sourceCheckedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['sourceCheckedAt'],
      ),
      firstSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
      quarantinedAt: jsonSerialization['quarantinedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['quarantinedAt'],
            ),
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
    );
  }

  static final t = PoiCatalogRowTable();

  static const db = PoiCatalogRowRepository._();

  @override
  _i1.UuidValue? id;

  String provider;

  String providerPlaceId;

  String? featureId;

  String normalizedName;

  String name;

  String countryCode;

  double latitude;

  double longitude;

  List<String> categoryIds;

  _i2.PlaceSnapshot snapshot;

  String calibrationVersion;

  DateTime sourceCheckedAt;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  DateTime? quarantinedAt;

  String? quarantineReason;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCatalogRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PoiCatalogRow copyWith({
    _i1.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    String? featureId,
    String? normalizedName,
    String? name,
    String? countryCode,
    double? latitude,
    double? longitude,
    List<String>? categoryIds,
    _i2.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    DateTime? sourceCheckedAt,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    DateTime? quarantinedAt,
    String? quarantineReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PoiCatalogRow',
      if (id != null) 'id': id?.toJson(),
      'provider': provider,
      'providerPlaceId': providerPlaceId,
      if (featureId != null) 'featureId': featureId,
      'normalizedName': normalizedName,
      'name': name,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'categoryIds': categoryIds.toJson(),
      'snapshot': snapshot.toJson(),
      'calibrationVersion': calibrationVersion,
      'sourceCheckedAt': sourceCheckedAt.toJson(),
      'firstSeenAt': firstSeenAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
      if (quarantinedAt != null) 'quarantinedAt': quarantinedAt?.toJson(),
      if (quarantineReason != null) 'quarantineReason': quarantineReason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static PoiCatalogRowInclude include() {
    return PoiCatalogRowInclude._();
  }

  static PoiCatalogRowIncludeList includeList({
    _i1.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    PoiCatalogRowInclude? include,
  }) {
    return PoiCatalogRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PoiCatalogRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCatalogRowImpl extends PoiCatalogRow {
  _PoiCatalogRowImpl({
    _i1.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    String? featureId,
    required String normalizedName,
    required String name,
    required String countryCode,
    required double latitude,
    required double longitude,
    required List<String> categoryIds,
    required _i2.PlaceSnapshot snapshot,
    required String calibrationVersion,
    required DateTime sourceCheckedAt,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
    DateTime? quarantinedAt,
    String? quarantineReason,
  }) : super._(
         id: id,
         provider: provider,
         providerPlaceId: providerPlaceId,
         featureId: featureId,
         normalizedName: normalizedName,
         name: name,
         countryCode: countryCode,
         latitude: latitude,
         longitude: longitude,
         categoryIds: categoryIds,
         snapshot: snapshot,
         calibrationVersion: calibrationVersion,
         sourceCheckedAt: sourceCheckedAt,
         firstSeenAt: firstSeenAt,
         lastSeenAt: lastSeenAt,
         quarantinedAt: quarantinedAt,
         quarantineReason: quarantineReason,
       );

  /// Returns a shallow copy of this [PoiCatalogRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PoiCatalogRow copyWith({
    Object? id = _Undefined,
    String? provider,
    String? providerPlaceId,
    Object? featureId = _Undefined,
    String? normalizedName,
    String? name,
    String? countryCode,
    double? latitude,
    double? longitude,
    List<String>? categoryIds,
    _i2.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    DateTime? sourceCheckedAt,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    Object? quarantinedAt = _Undefined,
    Object? quarantineReason = _Undefined,
  }) {
    return PoiCatalogRow(
      id: id is _i1.UuidValue? ? id : this.id,
      provider: provider ?? this.provider,
      providerPlaceId: providerPlaceId ?? this.providerPlaceId,
      featureId: featureId is String? ? featureId : this.featureId,
      normalizedName: normalizedName ?? this.normalizedName,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      categoryIds: categoryIds ?? this.categoryIds.map((e0) => e0).toList(),
      snapshot: snapshot ?? this.snapshot.copyWith(),
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      sourceCheckedAt: sourceCheckedAt ?? this.sourceCheckedAt,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      quarantinedAt: quarantinedAt is DateTime?
          ? quarantinedAt
          : this.quarantinedAt,
      quarantineReason: quarantineReason is String?
          ? quarantineReason
          : this.quarantineReason,
    );
  }
}

class PoiCatalogRowUpdateTable extends _i1.UpdateTable<PoiCatalogRowTable> {
  PoiCatalogRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> provider(String value) => _i1.ColumnValue(
    table.provider,
    value,
  );

  _i1.ColumnValue<String, String> providerPlaceId(String value) =>
      _i1.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _i1.ColumnValue<String, String> featureId(String? value) => _i1.ColumnValue(
    table.featureId,
    value,
  );

  _i1.ColumnValue<String, String> normalizedName(String value) =>
      _i1.ColumnValue(
        table.normalizedName,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<double, double> latitude(double value) => _i1.ColumnValue(
    table.latitude,
    value,
  );

  _i1.ColumnValue<double, double> longitude(double value) => _i1.ColumnValue(
    table.longitude,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> categoryIds(List<String> value) =>
      _i1.ColumnValue(
        table.categoryIds,
        value,
      );

  _i1.ColumnValue<_i2.PlaceSnapshot, _i2.PlaceSnapshot> snapshot(
    _i2.PlaceSnapshot value,
  ) => _i1.ColumnValue(
    table.snapshot,
    value,
  );

  _i1.ColumnValue<String, String> calibrationVersion(String value) =>
      _i1.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> sourceCheckedAt(DateTime value) =>
      _i1.ColumnValue(
        table.sourceCheckedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> firstSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.firstSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _i1.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> quarantinedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.quarantinedAt,
        value,
      );

  _i1.ColumnValue<String, String> quarantineReason(String? value) =>
      _i1.ColumnValue(
        table.quarantineReason,
        value,
      );
}

class PoiCatalogRowTable extends _i1.Table<_i1.UuidValue?> {
  PoiCatalogRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_catalog') {
    updateTable = PoiCatalogRowUpdateTable(this);
    provider = _i1.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _i1.ColumnString(
      'providerPlaceId',
      this,
    );
    featureId = _i1.ColumnString(
      'featureId',
      this,
    );
    normalizedName = _i1.ColumnString(
      'normalizedName',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    categoryIds = _i1.ColumnSerializable<List<String>>(
      'categoryIds',
      this,
    );
    snapshot = _i1.ColumnSerializable<_i2.PlaceSnapshot>(
      'snapshot',
      this,
    );
    calibrationVersion = _i1.ColumnString(
      'calibrationVersion',
      this,
    );
    sourceCheckedAt = _i1.ColumnDateTime(
      'sourceCheckedAt',
      this,
    );
    firstSeenAt = _i1.ColumnDateTime(
      'firstSeenAt',
      this,
    );
    lastSeenAt = _i1.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    quarantinedAt = _i1.ColumnDateTime(
      'quarantinedAt',
      this,
    );
    quarantineReason = _i1.ColumnString(
      'quarantineReason',
      this,
    );
  }

  late final PoiCatalogRowUpdateTable updateTable;

  late final _i1.ColumnString provider;

  late final _i1.ColumnString providerPlaceId;

  late final _i1.ColumnString featureId;

  late final _i1.ColumnString normalizedName;

  late final _i1.ColumnString name;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnDouble latitude;

  late final _i1.ColumnDouble longitude;

  late final _i1.ColumnSerializable<List<String>> categoryIds;

  late final _i1.ColumnSerializable<_i2.PlaceSnapshot> snapshot;

  late final _i1.ColumnString calibrationVersion;

  late final _i1.ColumnDateTime sourceCheckedAt;

  late final _i1.ColumnDateTime firstSeenAt;

  late final _i1.ColumnDateTime lastSeenAt;

  late final _i1.ColumnDateTime quarantinedAt;

  late final _i1.ColumnString quarantineReason;

  @override
  List<_i1.Column> get columns => [
    id,
    provider,
    providerPlaceId,
    featureId,
    normalizedName,
    name,
    countryCode,
    latitude,
    longitude,
    categoryIds,
    snapshot,
    calibrationVersion,
    sourceCheckedAt,
    firstSeenAt,
    lastSeenAt,
    quarantinedAt,
    quarantineReason,
  ];
}

class PoiCatalogRowInclude extends _i1.IncludeObject {
  PoiCatalogRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCatalogRow.t;
}

class PoiCatalogRowIncludeList extends _i1.IncludeList {
  PoiCatalogRowIncludeList._({
    _i1.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCatalogRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PoiCatalogRow.t;
}

class PoiCatalogRowRepository {
  const PoiCatalogRowRepository._();

  /// Returns a list of [PoiCatalogRow]s matching the given query parameters.
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
  Future<List<PoiCatalogRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PoiCatalogRow] matching the given query parameters.
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
  Future<PoiCatalogRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCatalogRow] by its [id] or null if no such row exists.
  Future<PoiCatalogRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PoiCatalogRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PoiCatalogRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PoiCatalogRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PoiCatalogRow>> insert(
    _i1.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PoiCatalogRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PoiCatalogRow] and returns the inserted row.
  ///
  /// The returned [PoiCatalogRow] will have its `id` field set.
  Future<PoiCatalogRow> insertRow(
    _i1.DatabaseSession session,
    PoiCatalogRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCatalogRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PoiCatalogRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PoiCatalogRow>> update(
    _i1.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _i1.ColumnSelections<PoiCatalogRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PoiCatalogRow>(
      rows,
      columns: columns?.call(PoiCatalogRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCatalogRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCatalogRow> updateRow(
    _i1.DatabaseSession session,
    PoiCatalogRow row, {
    _i1.ColumnSelections<PoiCatalogRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PoiCatalogRow>(
      row,
      columns: columns?.call(PoiCatalogRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PoiCatalogRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PoiCatalogRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PoiCatalogRowUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCatalogRow>(
      id,
      columnValues: columnValues(PoiCatalogRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCatalogRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PoiCatalogRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PoiCatalogRowUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PoiCatalogRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _i1.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PoiCatalogRow>(
      columnValues: columnValues(PoiCatalogRow.t.updateTable),
      where: where(PoiCatalogRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PoiCatalogRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PoiCatalogRow>> delete(
    _i1.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PoiCatalogRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PoiCatalogRow].
  Future<PoiCatalogRow> deleteRow(
    _i1.DatabaseSession session,
    PoiCatalogRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCatalogRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PoiCatalogRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCatalogRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PoiCatalogRow>(
      where: where(PoiCatalogRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCatalogRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PoiCatalogRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCatalogRow>(
      where: where(PoiCatalogRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
