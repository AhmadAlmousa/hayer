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
import '../route_origin_mode.dart' as _i2;

abstract class CacheSettingsRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  CacheSettingsRow._({
    this.id,
    required this.settingsKey,
    required this.version,
    required this.freshHours,
    required this.staleFallbackDays,
    required this.retentionDays,
    required this.extractorAttempts,
    required this.perCreationConcurrency,
    required this.globalRequestsPerMinute,
    required this.globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    required this.updatedBy,
    required this.updatedAt,
  }) : routeEstimatesEnabled = routeEstimatesEnabled ?? true,
       allowParticipantLocation = allowParticipantLocation ?? true,
       defaultRouteOrigin =
           defaultRouteOrigin ?? _i2.RouteOriginMode.sessionAnchor,
       routeEstimateCacheMinutes = routeEstimateCacheMinutes ?? 10,
       routeRequestsPerMinute = routeRequestsPerMinute ?? 30,
       routeBurst = routeBurst ?? 6;

  factory CacheSettingsRow({
    _i1.UuidValue? id,
    required String settingsKey,
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    required String updatedBy,
    required DateTime updatedAt,
  }) = _CacheSettingsRowImpl;

  factory CacheSettingsRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return CacheSettingsRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      settingsKey: jsonSerialization['settingsKey'] as String,
      version: jsonSerialization['version'] as int,
      freshHours: jsonSerialization['freshHours'] as int,
      staleFallbackDays: jsonSerialization['staleFallbackDays'] as int,
      retentionDays: jsonSerialization['retentionDays'] as int,
      extractorAttempts: jsonSerialization['extractorAttempts'] as int,
      perCreationConcurrency:
          jsonSerialization['perCreationConcurrency'] as int,
      globalRequestsPerMinute:
          jsonSerialization['globalRequestsPerMinute'] as int,
      globalBurst: jsonSerialization['globalBurst'] as int,
      routeEstimatesEnabled: jsonSerialization['routeEstimatesEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['routeEstimatesEnabled'],
            ),
      allowParticipantLocation:
          jsonSerialization['allowParticipantLocation'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['allowParticipantLocation'],
            ),
      defaultRouteOrigin: jsonSerialization['defaultRouteOrigin'] == null
          ? null
          : _i2.RouteOriginMode.fromJson(
              (jsonSerialization['defaultRouteOrigin'] as String),
            ),
      routeEstimateCacheMinutes:
          jsonSerialization['routeEstimateCacheMinutes'] as int?,
      routeRequestsPerMinute:
          jsonSerialization['routeRequestsPerMinute'] as int?,
      routeBurst: jsonSerialization['routeBurst'] as int?,
      updatedBy: jsonSerialization['updatedBy'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = CacheSettingsRowTable();

  static const db = CacheSettingsRowRepository._();

  @override
  _i1.UuidValue? id;

  String settingsKey;

  int version;

  int freshHours;

  int staleFallbackDays;

  int retentionDays;

  int extractorAttempts;

  int perCreationConcurrency;

  int globalRequestsPerMinute;

  int globalBurst;

  bool routeEstimatesEnabled;

  bool allowParticipantLocation;

  _i2.RouteOriginMode defaultRouteOrigin;

  int routeEstimateCacheMinutes;

  int routeRequestsPerMinute;

  int routeBurst;

  String updatedBy;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [CacheSettingsRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CacheSettingsRow copyWith({
    _i1.UuidValue? id,
    String? settingsKey,
    int? version,
    int? freshHours,
    int? staleFallbackDays,
    int? retentionDays,
    int? extractorAttempts,
    int? perCreationConcurrency,
    int? globalRequestsPerMinute,
    int? globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    String? updatedBy,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CacheSettingsRow',
      if (id != null) 'id': id?.toJson(),
      'settingsKey': settingsKey,
      'version': version,
      'freshHours': freshHours,
      'staleFallbackDays': staleFallbackDays,
      'retentionDays': retentionDays,
      'extractorAttempts': extractorAttempts,
      'perCreationConcurrency': perCreationConcurrency,
      'globalRequestsPerMinute': globalRequestsPerMinute,
      'globalBurst': globalBurst,
      'routeEstimatesEnabled': routeEstimatesEnabled,
      'allowParticipantLocation': allowParticipantLocation,
      'defaultRouteOrigin': defaultRouteOrigin.toJson(),
      'routeEstimateCacheMinutes': routeEstimateCacheMinutes,
      'routeRequestsPerMinute': routeRequestsPerMinute,
      'routeBurst': routeBurst,
      'updatedBy': updatedBy,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CacheSettingsRowInclude include() {
    return CacheSettingsRowInclude._();
  }

  static CacheSettingsRowIncludeList includeList({
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    CacheSettingsRowInclude? include,
  }) {
    return CacheSettingsRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CacheSettingsRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CacheSettingsRowImpl extends CacheSettingsRow {
  _CacheSettingsRowImpl({
    _i1.UuidValue? id,
    required String settingsKey,
    required int version,
    required int freshHours,
    required int staleFallbackDays,
    required int retentionDays,
    required int extractorAttempts,
    required int perCreationConcurrency,
    required int globalRequestsPerMinute,
    required int globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    required String updatedBy,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         settingsKey: settingsKey,
         version: version,
         freshHours: freshHours,
         staleFallbackDays: staleFallbackDays,
         retentionDays: retentionDays,
         extractorAttempts: extractorAttempts,
         perCreationConcurrency: perCreationConcurrency,
         globalRequestsPerMinute: globalRequestsPerMinute,
         globalBurst: globalBurst,
         routeEstimatesEnabled: routeEstimatesEnabled,
         allowParticipantLocation: allowParticipantLocation,
         defaultRouteOrigin: defaultRouteOrigin,
         routeEstimateCacheMinutes: routeEstimateCacheMinutes,
         routeRequestsPerMinute: routeRequestsPerMinute,
         routeBurst: routeBurst,
         updatedBy: updatedBy,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CacheSettingsRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CacheSettingsRow copyWith({
    Object? id = _Undefined,
    String? settingsKey,
    int? version,
    int? freshHours,
    int? staleFallbackDays,
    int? retentionDays,
    int? extractorAttempts,
    int? perCreationConcurrency,
    int? globalRequestsPerMinute,
    int? globalBurst,
    bool? routeEstimatesEnabled,
    bool? allowParticipantLocation,
    _i2.RouteOriginMode? defaultRouteOrigin,
    int? routeEstimateCacheMinutes,
    int? routeRequestsPerMinute,
    int? routeBurst,
    String? updatedBy,
    DateTime? updatedAt,
  }) {
    return CacheSettingsRow(
      id: id is _i1.UuidValue? ? id : this.id,
      settingsKey: settingsKey ?? this.settingsKey,
      version: version ?? this.version,
      freshHours: freshHours ?? this.freshHours,
      staleFallbackDays: staleFallbackDays ?? this.staleFallbackDays,
      retentionDays: retentionDays ?? this.retentionDays,
      extractorAttempts: extractorAttempts ?? this.extractorAttempts,
      perCreationConcurrency:
          perCreationConcurrency ?? this.perCreationConcurrency,
      globalRequestsPerMinute:
          globalRequestsPerMinute ?? this.globalRequestsPerMinute,
      globalBurst: globalBurst ?? this.globalBurst,
      routeEstimatesEnabled:
          routeEstimatesEnabled ?? this.routeEstimatesEnabled,
      allowParticipantLocation:
          allowParticipantLocation ?? this.allowParticipantLocation,
      defaultRouteOrigin: defaultRouteOrigin ?? this.defaultRouteOrigin,
      routeEstimateCacheMinutes:
          routeEstimateCacheMinutes ?? this.routeEstimateCacheMinutes,
      routeRequestsPerMinute:
          routeRequestsPerMinute ?? this.routeRequestsPerMinute,
      routeBurst: routeBurst ?? this.routeBurst,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CacheSettingsRowUpdateTable
    extends _i1.UpdateTable<CacheSettingsRowTable> {
  CacheSettingsRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> settingsKey(String value) => _i1.ColumnValue(
    table.settingsKey,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<int, int> freshHours(int value) => _i1.ColumnValue(
    table.freshHours,
    value,
  );

  _i1.ColumnValue<int, int> staleFallbackDays(int value) => _i1.ColumnValue(
    table.staleFallbackDays,
    value,
  );

  _i1.ColumnValue<int, int> retentionDays(int value) => _i1.ColumnValue(
    table.retentionDays,
    value,
  );

  _i1.ColumnValue<int, int> extractorAttempts(int value) => _i1.ColumnValue(
    table.extractorAttempts,
    value,
  );

  _i1.ColumnValue<int, int> perCreationConcurrency(int value) =>
      _i1.ColumnValue(
        table.perCreationConcurrency,
        value,
      );

  _i1.ColumnValue<int, int> globalRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.globalRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> globalBurst(int value) => _i1.ColumnValue(
    table.globalBurst,
    value,
  );

  _i1.ColumnValue<bool, bool> routeEstimatesEnabled(bool value) =>
      _i1.ColumnValue(
        table.routeEstimatesEnabled,
        value,
      );

  _i1.ColumnValue<bool, bool> allowParticipantLocation(bool value) =>
      _i1.ColumnValue(
        table.allowParticipantLocation,
        value,
      );

  _i1.ColumnValue<_i2.RouteOriginMode, _i2.RouteOriginMode> defaultRouteOrigin(
    _i2.RouteOriginMode value,
  ) => _i1.ColumnValue(
    table.defaultRouteOrigin,
    value,
  );

  _i1.ColumnValue<int, int> routeEstimateCacheMinutes(int value) =>
      _i1.ColumnValue(
        table.routeEstimateCacheMinutes,
        value,
      );

  _i1.ColumnValue<int, int> routeRequestsPerMinute(int value) =>
      _i1.ColumnValue(
        table.routeRequestsPerMinute,
        value,
      );

  _i1.ColumnValue<int, int> routeBurst(int value) => _i1.ColumnValue(
    table.routeBurst,
    value,
  );

  _i1.ColumnValue<String, String> updatedBy(String value) => _i1.ColumnValue(
    table.updatedBy,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class CacheSettingsRowTable extends _i1.Table<_i1.UuidValue?> {
  CacheSettingsRowTable({super.tableRelation})
    : super(tableName: 'hayer_cache_settings') {
    updateTable = CacheSettingsRowUpdateTable(this);
    settingsKey = _i1.ColumnString(
      'settingsKey',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    freshHours = _i1.ColumnInt(
      'freshHours',
      this,
    );
    staleFallbackDays = _i1.ColumnInt(
      'staleFallbackDays',
      this,
    );
    retentionDays = _i1.ColumnInt(
      'retentionDays',
      this,
    );
    extractorAttempts = _i1.ColumnInt(
      'extractorAttempts',
      this,
    );
    perCreationConcurrency = _i1.ColumnInt(
      'perCreationConcurrency',
      this,
    );
    globalRequestsPerMinute = _i1.ColumnInt(
      'globalRequestsPerMinute',
      this,
    );
    globalBurst = _i1.ColumnInt(
      'globalBurst',
      this,
    );
    routeEstimatesEnabled = _i1.ColumnBool(
      'routeEstimatesEnabled',
      this,
      hasDefault: true,
    );
    allowParticipantLocation = _i1.ColumnBool(
      'allowParticipantLocation',
      this,
      hasDefault: true,
    );
    defaultRouteOrigin = _i1.ColumnEnum(
      'defaultRouteOrigin',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    routeEstimateCacheMinutes = _i1.ColumnInt(
      'routeEstimateCacheMinutes',
      this,
      hasDefault: true,
    );
    routeRequestsPerMinute = _i1.ColumnInt(
      'routeRequestsPerMinute',
      this,
      hasDefault: true,
    );
    routeBurst = _i1.ColumnInt(
      'routeBurst',
      this,
      hasDefault: true,
    );
    updatedBy = _i1.ColumnString(
      'updatedBy',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final CacheSettingsRowUpdateTable updateTable;

  late final _i1.ColumnString settingsKey;

  late final _i1.ColumnInt version;

  late final _i1.ColumnInt freshHours;

  late final _i1.ColumnInt staleFallbackDays;

  late final _i1.ColumnInt retentionDays;

  late final _i1.ColumnInt extractorAttempts;

  late final _i1.ColumnInt perCreationConcurrency;

  late final _i1.ColumnInt globalRequestsPerMinute;

  late final _i1.ColumnInt globalBurst;

  late final _i1.ColumnBool routeEstimatesEnabled;

  late final _i1.ColumnBool allowParticipantLocation;

  late final _i1.ColumnEnum<_i2.RouteOriginMode> defaultRouteOrigin;

  late final _i1.ColumnInt routeEstimateCacheMinutes;

  late final _i1.ColumnInt routeRequestsPerMinute;

  late final _i1.ColumnInt routeBurst;

  late final _i1.ColumnString updatedBy;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    settingsKey,
    version,
    freshHours,
    staleFallbackDays,
    retentionDays,
    extractorAttempts,
    perCreationConcurrency,
    globalRequestsPerMinute,
    globalBurst,
    routeEstimatesEnabled,
    allowParticipantLocation,
    defaultRouteOrigin,
    routeEstimateCacheMinutes,
    routeRequestsPerMinute,
    routeBurst,
    updatedBy,
    updatedAt,
  ];
}

class CacheSettingsRowInclude extends _i1.IncludeObject {
  CacheSettingsRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CacheSettingsRow.t;
}

class CacheSettingsRowIncludeList extends _i1.IncludeList {
  CacheSettingsRowIncludeList._({
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CacheSettingsRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => CacheSettingsRow.t;
}

class CacheSettingsRowRepository {
  const CacheSettingsRowRepository._();

  /// Returns a list of [CacheSettingsRow]s matching the given query parameters.
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
  Future<List<CacheSettingsRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CacheSettingsRow] matching the given query parameters.
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
  Future<CacheSettingsRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CacheSettingsRow] by its [id] or null if no such row exists.
  Future<CacheSettingsRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CacheSettingsRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CacheSettingsRow]s in the list and returns the inserted rows.
  ///
  /// The returned [CacheSettingsRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CacheSettingsRow>> insert(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CacheSettingsRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CacheSettingsRow] and returns the inserted row.
  ///
  /// The returned [CacheSettingsRow] will have its `id` field set.
  Future<CacheSettingsRow> insertRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CacheSettingsRow>> update(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.ColumnSelections<CacheSettingsRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CacheSettingsRow>(
      rows,
      columns: columns?.call(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CacheSettingsRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CacheSettingsRow> updateRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.ColumnSelections<CacheSettingsRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CacheSettingsRow>(
      row,
      columns: columns?.call(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CacheSettingsRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CacheSettingsRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CacheSettingsRow>(
      id,
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CacheSettingsRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CacheSettingsRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<CacheSettingsRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CacheSettingsRowTable>? orderBy,
    _i1.OrderByListBuilder<CacheSettingsRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CacheSettingsRow>(
      columnValues: columnValues(CacheSettingsRow.t.updateTable),
      where: where(CacheSettingsRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CacheSettingsRow.t),
      orderByList: orderByList?.call(CacheSettingsRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CacheSettingsRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CacheSettingsRow>> delete(
    _i1.DatabaseSession session,
    List<CacheSettingsRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CacheSettingsRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CacheSettingsRow].
  Future<CacheSettingsRow> deleteRow(
    _i1.DatabaseSession session,
    CacheSettingsRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CacheSettingsRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CacheSettingsRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<CacheSettingsRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CacheSettingsRow>(
      where: where?.call(CacheSettingsRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CacheSettingsRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<CacheSettingsRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CacheSettingsRow>(
      where: where(CacheSettingsRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
