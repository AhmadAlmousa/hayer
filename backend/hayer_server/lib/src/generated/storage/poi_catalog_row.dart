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

abstract class PoiCatalogRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
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
    required this.location,
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
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    String? featureId,
    required String normalizedName,
    required String name,
    required String countryCode,
    required double latitude,
    required double longitude,
    required _is.GeographyPoint location,
    required List<String> categoryIds,
    required _iv1jjw8m.PlaceSnapshot snapshot,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      provider: jsonSerialization['provider'] as String,
      providerPlaceId: jsonSerialization['providerPlaceId'] as String,
      featureId: jsonSerialization['featureId'] as String?,
      normalizedName: jsonSerialization['normalizedName'] as String,
      name: jsonSerialization['name'] as String,
      countryCode: jsonSerialization['countryCode'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      location: _is.GeographyPointJsonExtension.fromJson(
        jsonSerialization['location'],
      ),
      categoryIds: _i66y2smk.Protocol().deserialize<List<String>>(
        jsonSerialization['categoryIds'],
      ),
      snapshot: _i66y2smk.Protocol().deserialize<_iv1jjw8m.PlaceSnapshot>(
        jsonSerialization['snapshot'],
      ),
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      sourceCheckedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['sourceCheckedAt'],
      ),
      firstSeenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['firstSeenAt'],
      ),
      lastSeenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
      quarantinedAt: jsonSerialization['quarantinedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['quarantinedAt'],
            ),
      quarantineReason: jsonSerialization['quarantineReason'] as String?,
    );
  }

  static final t = PoiCatalogRowTable();

  static const db = PoiCatalogRowRepository._();

  @override
  _is.UuidValue? id;

  String provider;

  String providerPlaceId;

  String? featureId;

  String normalizedName;

  String name;

  String countryCode;

  double latitude;

  double longitude;

  _is.GeographyPoint location;

  List<String> categoryIds;

  _iv1jjw8m.PlaceSnapshot snapshot;

  String calibrationVersion;

  DateTime sourceCheckedAt;

  DateTime firstSeenAt;

  DateTime lastSeenAt;

  DateTime? quarantinedAt;

  String? quarantineReason;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PoiCatalogRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PoiCatalogRow copyWith({
    _is.UuidValue? id,
    String? provider,
    String? providerPlaceId,
    String? featureId,
    String? normalizedName,
    String? name,
    String? countryCode,
    double? latitude,
    double? longitude,
    _is.GeographyPoint? location,
    List<String>? categoryIds,
    _iv1jjw8m.PlaceSnapshot? snapshot,
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
      'location': location.toJson(),
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
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    PoiCatalogRowInclude? include,
  }) {
    return PoiCatalogRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PoiCatalogRowImpl extends PoiCatalogRow {
  _PoiCatalogRowImpl({
    _is.UuidValue? id,
    required String provider,
    required String providerPlaceId,
    String? featureId,
    required String normalizedName,
    required String name,
    required String countryCode,
    required double latitude,
    required double longitude,
    required _is.GeographyPoint location,
    required List<String> categoryIds,
    required _iv1jjw8m.PlaceSnapshot snapshot,
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
         location: location,
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
  @_is.useResult
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
    _is.GeographyPoint? location,
    List<String>? categoryIds,
    _iv1jjw8m.PlaceSnapshot? snapshot,
    String? calibrationVersion,
    DateTime? sourceCheckedAt,
    DateTime? firstSeenAt,
    DateTime? lastSeenAt,
    Object? quarantinedAt = _Undefined,
    Object? quarantineReason = _Undefined,
  }) {
    return PoiCatalogRow(
      id: id is _is.UuidValue? ? id : this.id,
      provider: provider ?? this.provider,
      providerPlaceId: providerPlaceId ?? this.providerPlaceId,
      featureId: featureId is String? ? featureId : this.featureId,
      normalizedName: normalizedName ?? this.normalizedName,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      location: location ?? this.location,
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

class PoiCatalogRowUpdateTable extends _is.UpdateTable<PoiCatalogRowTable> {
  PoiCatalogRowUpdateTable(super.table);

  _is.ColumnValue<String, String> provider(String value) => _is.ColumnValue(
    table.provider,
    value,
  );

  _is.ColumnValue<String, String> providerPlaceId(String value) =>
      _is.ColumnValue(
        table.providerPlaceId,
        value,
      );

  _is.ColumnValue<String, String> featureId(String? value) => _is.ColumnValue(
    table.featureId,
    value,
  );

  _is.ColumnValue<String, String> normalizedName(String value) =>
      _is.ColumnValue(
        table.normalizedName,
        value,
      );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<_is.GeographyPoint, _is.GeographyPoint> location(
    _is.GeographyPoint value,
  ) => _is.ColumnValue(
    table.location,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> categoryIds(List<String> value) =>
      _is.ColumnValue(
        table.categoryIds,
        value,
      );

  _is.ColumnValue<_iv1jjw8m.PlaceSnapshot, _iv1jjw8m.PlaceSnapshot> snapshot(
    _iv1jjw8m.PlaceSnapshot value,
  ) => _is.ColumnValue(
    table.snapshot,
    value,
  );

  _is.ColumnValue<String, String> calibrationVersion(String value) =>
      _is.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> sourceCheckedAt(DateTime value) =>
      _is.ColumnValue(
        table.sourceCheckedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> firstSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.firstSeenAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastSeenAt(DateTime value) =>
      _is.ColumnValue(
        table.lastSeenAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> quarantinedAt(DateTime? value) =>
      _is.ColumnValue(
        table.quarantinedAt,
        value,
      );

  _is.ColumnValue<String, String> quarantineReason(String? value) =>
      _is.ColumnValue(
        table.quarantineReason,
        value,
      );
}

class PoiCatalogRowTable extends _is.Table<_is.UuidValue?> {
  PoiCatalogRowTable({super.tableRelation})
    : super(tableName: 'hayer_poi_catalog') {
    updateTable = PoiCatalogRowUpdateTable(this);
    provider = _is.ColumnString(
      'provider',
      this,
    );
    providerPlaceId = _is.ColumnString(
      'providerPlaceId',
      this,
    );
    featureId = _is.ColumnString(
      'featureId',
      this,
    );
    normalizedName = _is.ColumnString(
      'normalizedName',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    location = _is.ColumnGeographyPoint(
      'location',
      this,
    );
    categoryIds = _is.ColumnSerializable<List<String>>(
      'categoryIds',
      this,
    );
    snapshot = _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot>(
      'snapshot',
      this,
    );
    calibrationVersion = _is.ColumnString(
      'calibrationVersion',
      this,
    );
    sourceCheckedAt = _is.ColumnDateTime(
      'sourceCheckedAt',
      this,
    );
    firstSeenAt = _is.ColumnDateTime(
      'firstSeenAt',
      this,
    );
    lastSeenAt = _is.ColumnDateTime(
      'lastSeenAt',
      this,
    );
    quarantinedAt = _is.ColumnDateTime(
      'quarantinedAt',
      this,
    );
    quarantineReason = _is.ColumnString(
      'quarantineReason',
      this,
    );
  }

  late final PoiCatalogRowUpdateTable updateTable;

  late final _is.ColumnString provider;

  late final _is.ColumnString providerPlaceId;

  late final _is.ColumnString featureId;

  late final _is.ColumnString normalizedName;

  late final _is.ColumnString name;

  late final _is.ColumnString countryCode;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnGeographyPoint location;

  late final _is.ColumnSerializable<List<String>> categoryIds;

  late final _is.ColumnSerializable<_iv1jjw8m.PlaceSnapshot> snapshot;

  late final _is.ColumnString calibrationVersion;

  late final _is.ColumnDateTime sourceCheckedAt;

  late final _is.ColumnDateTime firstSeenAt;

  late final _is.ColumnDateTime lastSeenAt;

  late final _is.ColumnDateTime quarantinedAt;

  late final _is.ColumnString quarantineReason;

  @override
  List<_is.Column> get columns => [
    id,
    provider,
    providerPlaceId,
    featureId,
    normalizedName,
    name,
    countryCode,
    latitude,
    longitude,
    location,
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

class PoiCatalogRowInclude extends _is.IncludeObject {
  PoiCatalogRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCatalogRow.t;
}

class PoiCatalogRowIncludeList extends _is.IncludeList {
  PoiCatalogRowIncludeList._({
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PoiCatalogRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => PoiCatalogRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PoiCatalogRow] by its [id] or null if no such row exists.
  Future<PoiCatalogRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCatalogRow>> insert(
    _is.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PoiCatalogRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PoiCatalogRow] and returns the inserted row.
  ///
  /// The returned [PoiCatalogRow] will have its `id` field set.
  Future<PoiCatalogRow> insertRow(
    _is.DatabaseSession session,
    PoiCatalogRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PoiCatalogRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PoiCatalogRow]s in the list and returns the resulting rows.
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
  /// The returned [PoiCatalogRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCatalogRow>> upsert(
    _is.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    required _is.ColumnSelections<PoiCatalogRowTable> conflictColumns,
    _is.ColumnSelections<PoiCatalogRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PoiCatalogRow>(
      rows,
      conflictColumns: conflictColumns(PoiCatalogRow.t),
      updateColumns: updateColumns?.call(PoiCatalogRow.t),
      updateWhere: updateWhere?.call(PoiCatalogRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PoiCatalogRow] and returns the resulting row.
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
  /// The returned [PoiCatalogRow] will have its `id` field set.
  Future<PoiCatalogRow?> upsertRow(
    _is.DatabaseSession session,
    PoiCatalogRow row, {
    required _is.ColumnSelections<PoiCatalogRowTable> conflictColumns,
    _is.ColumnSelections<PoiCatalogRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PoiCatalogRow>(
      row,
      conflictColumns: conflictColumns(PoiCatalogRow.t),
      updateColumns: updateColumns?.call(PoiCatalogRow.t),
      updateWhere: updateWhere?.call(PoiCatalogRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCatalogRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCatalogRow>> update(
    _is.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _is.ColumnSelections<PoiCatalogRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PoiCatalogRow>(
      rows,
      columns: columns?.call(PoiCatalogRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PoiCatalogRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PoiCatalogRow> updateRow(
    _is.DatabaseSession session,
    PoiCatalogRow row, {
    _is.ColumnSelections<PoiCatalogRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<PoiCatalogRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PoiCatalogRow>(
      id,
      columnValues: columnValues(PoiCatalogRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PoiCatalogRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PoiCatalogRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PoiCatalogRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PoiCatalogRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PoiCatalogRow>(
      columnValues: columnValues(PoiCatalogRow.t.updateTable),
      where: where(PoiCatalogRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PoiCatalogRow]s in the list and returns the deleted rows.
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
  Future<List<PoiCatalogRow>> delete(
    _is.DatabaseSession session,
    List<PoiCatalogRow> rows, {
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PoiCatalogRow>(
      rows,
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PoiCatalogRow].
  Future<PoiCatalogRow> deleteRow(
    _is.DatabaseSession session,
    PoiCatalogRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PoiCatalogRow>(
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
  Future<List<PoiCatalogRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCatalogRowTable> where,
    _is.OrderByBuilder<PoiCatalogRowTable>? orderBy,
    _is.OrderByListBuilder<PoiCatalogRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PoiCatalogRow>(
      where: where(PoiCatalogRow.t),
      orderBy: orderBy?.call(PoiCatalogRow.t),
      orderByList: orderByList?.call(PoiCatalogRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PoiCatalogRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PoiCatalogRow>(
      where: where?.call(PoiCatalogRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PoiCatalogRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PoiCatalogRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PoiCatalogRow>(
      where: where(PoiCatalogRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
