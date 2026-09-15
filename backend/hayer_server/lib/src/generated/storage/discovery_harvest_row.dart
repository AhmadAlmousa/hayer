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
import '../discovery_harvest_requester.dart' as _i2;
import '../discovery_harvest_trigger.dart' as _i3;
import '../discovery_harvest_state.dart' as _i4;
import '../discovery_harvest_query_outcome.dart' as _i5;
import 'package:hayer_server/src/generated/protocol.dart' as _i6;

abstract class DiscoveryHarvestRow
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DiscoveryHarvestRow._({
    this.id,
    required this.jobId,
    required this.harvestKey,
    required this.requester,
    required this.requestedBy,
    required this.trigger,
    required this.countryCode,
    required this.cellId,
    required this.radiusMeters,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.south,
    required this.west,
    required this.north,
    required this.east,
    required this.manifestVersion,
    required this.manifestRevision,
    required this.calibrationVersion,
    required this.state,
    required this.queryOutcomes,
    required this.attemptedQueries,
    required this.completedQueries,
    required this.totalQueries,
    required this.observedPlaces,
    required this.upstreamRequests,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.failureCode,
  });

  factory DiscoveryHarvestRow({
    int? id,
    required String jobId,
    required String harvestKey,
    required _i2.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _i3.DiscoveryHarvestTrigger trigger,
    required String countryCode,
    required String cellId,
    required int radiusMeters,
    required double centerLatitude,
    required double centerLongitude,
    required double south,
    required double west,
    required double north,
    required double east,
    required String manifestVersion,
    required int manifestRevision,
    required String calibrationVersion,
    required _i4.DiscoveryHarvestState state,
    required List<_i5.DiscoveryHarvestQueryOutcome> queryOutcomes,
    required int attemptedQueries,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required int upstreamRequests,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? failureCode,
  }) = _DiscoveryHarvestRowImpl;

  factory DiscoveryHarvestRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscoveryHarvestRow(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as String,
      harvestKey: jsonSerialization['harvestKey'] as String,
      requester: _i2.DiscoveryHarvestRequester.fromJson(
        (jsonSerialization['requester'] as String),
      ),
      requestedBy: jsonSerialization['requestedBy'] as String,
      trigger: _i3.DiscoveryHarvestTrigger.fromJson(
        (jsonSerialization['trigger'] as String),
      ),
      countryCode: jsonSerialization['countryCode'] as String,
      cellId: jsonSerialization['cellId'] as String,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      centerLatitude: (jsonSerialization['centerLatitude'] as num).toDouble(),
      centerLongitude: (jsonSerialization['centerLongitude'] as num).toDouble(),
      south: (jsonSerialization['south'] as num).toDouble(),
      west: (jsonSerialization['west'] as num).toDouble(),
      north: (jsonSerialization['north'] as num).toDouble(),
      east: (jsonSerialization['east'] as num).toDouble(),
      manifestVersion: jsonSerialization['manifestVersion'] as String,
      manifestRevision: jsonSerialization['manifestRevision'] as int,
      calibrationVersion: jsonSerialization['calibrationVersion'] as String,
      state: _i4.DiscoveryHarvestState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      queryOutcomes: _i6.Protocol()
          .deserialize<List<_i5.DiscoveryHarvestQueryOutcome>>(
            jsonSerialization['queryOutcomes'],
          ),
      attemptedQueries: jsonSerialization['attemptedQueries'] as int,
      completedQueries: jsonSerialization['completedQueries'] as int,
      totalQueries: jsonSerialization['totalQueries'] as int,
      observedPlaces: jsonSerialization['observedPlaces'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      failureCode: jsonSerialization['failureCode'] as String?,
    );
  }

  static final t = DiscoveryHarvestRowTable();

  static const db = DiscoveryHarvestRowRepository._();

  @override
  int? id;

  String jobId;

  String harvestKey;

  _i2.DiscoveryHarvestRequester requester;

  String requestedBy;

  _i3.DiscoveryHarvestTrigger trigger;

  String countryCode;

  String cellId;

  int radiusMeters;

  double centerLatitude;

  double centerLongitude;

  double south;

  double west;

  double north;

  double east;

  String manifestVersion;

  int manifestRevision;

  String calibrationVersion;

  _i4.DiscoveryHarvestState state;

  List<_i5.DiscoveryHarvestQueryOutcome> queryOutcomes;

  int attemptedQueries;

  int completedQueries;

  int totalQueries;

  int observedPlaces;

  int upstreamRequests;

  DateTime createdAt;

  DateTime? startedAt;

  DateTime? completedAt;

  String? failureCode;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryHarvestRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscoveryHarvestRow copyWith({
    int? id,
    String? jobId,
    String? harvestKey,
    _i2.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _i3.DiscoveryHarvestTrigger? trigger,
    String? countryCode,
    String? cellId,
    int? radiusMeters,
    double? centerLatitude,
    double? centerLongitude,
    double? south,
    double? west,
    double? north,
    double? east,
    String? manifestVersion,
    int? manifestRevision,
    String? calibrationVersion,
    _i4.DiscoveryHarvestState? state,
    List<_i5.DiscoveryHarvestQueryOutcome>? queryOutcomes,
    int? attemptedQueries,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    int? upstreamRequests,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? failureCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscoveryHarvestRow',
      if (id != null) 'id': id,
      'jobId': jobId,
      'harvestKey': harvestKey,
      'requester': requester.toJson(),
      'requestedBy': requestedBy,
      'trigger': trigger.toJson(),
      'countryCode': countryCode,
      'cellId': cellId,
      'radiusMeters': radiusMeters,
      'centerLatitude': centerLatitude,
      'centerLongitude': centerLongitude,
      'south': south,
      'west': west,
      'north': north,
      'east': east,
      'manifestVersion': manifestVersion,
      'manifestRevision': manifestRevision,
      'calibrationVersion': calibrationVersion,
      'state': state.toJson(),
      'queryOutcomes': queryOutcomes.toJson(valueToJson: (v) => v.toJson()),
      'attemptedQueries': attemptedQueries,
      'completedQueries': completedQueries,
      'totalQueries': totalQueries,
      'observedPlaces': observedPlaces,
      'upstreamRequests': upstreamRequests,
      'createdAt': createdAt.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (failureCode != null) 'failureCode': failureCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DiscoveryHarvestRowInclude include() {
    return DiscoveryHarvestRowInclude._();
  }

  static DiscoveryHarvestRowIncludeList includeList({
    _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    DiscoveryHarvestRowInclude? include,
  }) {
    return DiscoveryHarvestRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestRowImpl extends DiscoveryHarvestRow {
  _DiscoveryHarvestRowImpl({
    int? id,
    required String jobId,
    required String harvestKey,
    required _i2.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _i3.DiscoveryHarvestTrigger trigger,
    required String countryCode,
    required String cellId,
    required int radiusMeters,
    required double centerLatitude,
    required double centerLongitude,
    required double south,
    required double west,
    required double north,
    required double east,
    required String manifestVersion,
    required int manifestRevision,
    required String calibrationVersion,
    required _i4.DiscoveryHarvestState state,
    required List<_i5.DiscoveryHarvestQueryOutcome> queryOutcomes,
    required int attemptedQueries,
    required int completedQueries,
    required int totalQueries,
    required int observedPlaces,
    required int upstreamRequests,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? failureCode,
  }) : super._(
         id: id,
         jobId: jobId,
         harvestKey: harvestKey,
         requester: requester,
         requestedBy: requestedBy,
         trigger: trigger,
         countryCode: countryCode,
         cellId: cellId,
         radiusMeters: radiusMeters,
         centerLatitude: centerLatitude,
         centerLongitude: centerLongitude,
         south: south,
         west: west,
         north: north,
         east: east,
         manifestVersion: manifestVersion,
         manifestRevision: manifestRevision,
         calibrationVersion: calibrationVersion,
         state: state,
         queryOutcomes: queryOutcomes,
         attemptedQueries: attemptedQueries,
         completedQueries: completedQueries,
         totalQueries: totalQueries,
         observedPlaces: observedPlaces,
         upstreamRequests: upstreamRequests,
         createdAt: createdAt,
         startedAt: startedAt,
         completedAt: completedAt,
         failureCode: failureCode,
       );

  /// Returns a shallow copy of this [DiscoveryHarvestRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscoveryHarvestRow copyWith({
    Object? id = _Undefined,
    String? jobId,
    String? harvestKey,
    _i2.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _i3.DiscoveryHarvestTrigger? trigger,
    String? countryCode,
    String? cellId,
    int? radiusMeters,
    double? centerLatitude,
    double? centerLongitude,
    double? south,
    double? west,
    double? north,
    double? east,
    String? manifestVersion,
    int? manifestRevision,
    String? calibrationVersion,
    _i4.DiscoveryHarvestState? state,
    List<_i5.DiscoveryHarvestQueryOutcome>? queryOutcomes,
    int? attemptedQueries,
    int? completedQueries,
    int? totalQueries,
    int? observedPlaces,
    int? upstreamRequests,
    DateTime? createdAt,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? failureCode = _Undefined,
  }) {
    return DiscoveryHarvestRow(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      harvestKey: harvestKey ?? this.harvestKey,
      requester: requester ?? this.requester,
      requestedBy: requestedBy ?? this.requestedBy,
      trigger: trigger ?? this.trigger,
      countryCode: countryCode ?? this.countryCode,
      cellId: cellId ?? this.cellId,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      south: south ?? this.south,
      west: west ?? this.west,
      north: north ?? this.north,
      east: east ?? this.east,
      manifestVersion: manifestVersion ?? this.manifestVersion,
      manifestRevision: manifestRevision ?? this.manifestRevision,
      calibrationVersion: calibrationVersion ?? this.calibrationVersion,
      state: state ?? this.state,
      queryOutcomes:
          queryOutcomes ??
          this.queryOutcomes.map((e0) => e0.copyWith()).toList(),
      attemptedQueries: attemptedQueries ?? this.attemptedQueries,
      completedQueries: completedQueries ?? this.completedQueries,
      totalQueries: totalQueries ?? this.totalQueries,
      observedPlaces: observedPlaces ?? this.observedPlaces,
      upstreamRequests: upstreamRequests ?? this.upstreamRequests,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      failureCode: failureCode is String? ? failureCode : this.failureCode,
    );
  }
}

class DiscoveryHarvestRowUpdateTable
    extends _i1.UpdateTable<DiscoveryHarvestRowTable> {
  DiscoveryHarvestRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> jobId(String value) => _i1.ColumnValue(
    table.jobId,
    value,
  );

  _i1.ColumnValue<String, String> harvestKey(String value) => _i1.ColumnValue(
    table.harvestKey,
    value,
  );

  _i1.ColumnValue<_i2.DiscoveryHarvestRequester, _i2.DiscoveryHarvestRequester>
  requester(_i2.DiscoveryHarvestRequester value) => _i1.ColumnValue(
    table.requester,
    value,
  );

  _i1.ColumnValue<String, String> requestedBy(String value) => _i1.ColumnValue(
    table.requestedBy,
    value,
  );

  _i1.ColumnValue<_i3.DiscoveryHarvestTrigger, _i3.DiscoveryHarvestTrigger>
  trigger(_i3.DiscoveryHarvestTrigger value) => _i1.ColumnValue(
    table.trigger,
    value,
  );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<String, String> cellId(String value) => _i1.ColumnValue(
    table.cellId,
    value,
  );

  _i1.ColumnValue<int, int> radiusMeters(int value) => _i1.ColumnValue(
    table.radiusMeters,
    value,
  );

  _i1.ColumnValue<double, double> centerLatitude(double value) =>
      _i1.ColumnValue(
        table.centerLatitude,
        value,
      );

  _i1.ColumnValue<double, double> centerLongitude(double value) =>
      _i1.ColumnValue(
        table.centerLongitude,
        value,
      );

  _i1.ColumnValue<double, double> south(double value) => _i1.ColumnValue(
    table.south,
    value,
  );

  _i1.ColumnValue<double, double> west(double value) => _i1.ColumnValue(
    table.west,
    value,
  );

  _i1.ColumnValue<double, double> north(double value) => _i1.ColumnValue(
    table.north,
    value,
  );

  _i1.ColumnValue<double, double> east(double value) => _i1.ColumnValue(
    table.east,
    value,
  );

  _i1.ColumnValue<String, String> manifestVersion(String value) =>
      _i1.ColumnValue(
        table.manifestVersion,
        value,
      );

  _i1.ColumnValue<int, int> manifestRevision(int value) => _i1.ColumnValue(
    table.manifestRevision,
    value,
  );

  _i1.ColumnValue<String, String> calibrationVersion(String value) =>
      _i1.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _i1.ColumnValue<_i4.DiscoveryHarvestState, _i4.DiscoveryHarvestState> state(
    _i4.DiscoveryHarvestState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<
    List<_i5.DiscoveryHarvestQueryOutcome>,
    List<_i5.DiscoveryHarvestQueryOutcome>
  >
  queryOutcomes(List<_i5.DiscoveryHarvestQueryOutcome> value) =>
      _i1.ColumnValue(
        table.queryOutcomes,
        value,
      );

  _i1.ColumnValue<int, int> attemptedQueries(int value) => _i1.ColumnValue(
    table.attemptedQueries,
    value,
  );

  _i1.ColumnValue<int, int> completedQueries(int value) => _i1.ColumnValue(
    table.completedQueries,
    value,
  );

  _i1.ColumnValue<int, int> totalQueries(int value) => _i1.ColumnValue(
    table.totalQueries,
    value,
  );

  _i1.ColumnValue<int, int> observedPlaces(int value) => _i1.ColumnValue(
    table.observedPlaces,
    value,
  );

  _i1.ColumnValue<int, int> upstreamRequests(int value) => _i1.ColumnValue(
    table.upstreamRequests,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );

  _i1.ColumnValue<String, String> failureCode(String? value) => _i1.ColumnValue(
    table.failureCode,
    value,
  );
}

class DiscoveryHarvestRowTable extends _i1.Table<int?> {
  DiscoveryHarvestRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_harvest') {
    updateTable = DiscoveryHarvestRowUpdateTable(this);
    jobId = _i1.ColumnString(
      'jobId',
      this,
    );
    harvestKey = _i1.ColumnString(
      'harvestKey',
      this,
    );
    requester = _i1.ColumnEnum(
      'requester',
      this,
      _i1.EnumSerialization.byName,
    );
    requestedBy = _i1.ColumnString(
      'requestedBy',
      this,
    );
    trigger = _i1.ColumnEnum(
      'trigger',
      this,
      _i1.EnumSerialization.byName,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    cellId = _i1.ColumnString(
      'cellId',
      this,
    );
    radiusMeters = _i1.ColumnInt(
      'radiusMeters',
      this,
    );
    centerLatitude = _i1.ColumnDouble(
      'centerLatitude',
      this,
    );
    centerLongitude = _i1.ColumnDouble(
      'centerLongitude',
      this,
    );
    south = _i1.ColumnDouble(
      'south',
      this,
    );
    west = _i1.ColumnDouble(
      'west',
      this,
    );
    north = _i1.ColumnDouble(
      'north',
      this,
    );
    east = _i1.ColumnDouble(
      'east',
      this,
    );
    manifestVersion = _i1.ColumnString(
      'manifestVersion',
      this,
    );
    manifestRevision = _i1.ColumnInt(
      'manifestRevision',
      this,
    );
    calibrationVersion = _i1.ColumnString(
      'calibrationVersion',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    queryOutcomes =
        _i1.ColumnSerializable<List<_i5.DiscoveryHarvestQueryOutcome>>(
          'queryOutcomes',
          this,
        );
    attemptedQueries = _i1.ColumnInt(
      'attemptedQueries',
      this,
    );
    completedQueries = _i1.ColumnInt(
      'completedQueries',
      this,
    );
    totalQueries = _i1.ColumnInt(
      'totalQueries',
      this,
    );
    observedPlaces = _i1.ColumnInt(
      'observedPlaces',
      this,
    );
    upstreamRequests = _i1.ColumnInt(
      'upstreamRequests',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
    failureCode = _i1.ColumnString(
      'failureCode',
      this,
    );
  }

  late final DiscoveryHarvestRowUpdateTable updateTable;

  late final _i1.ColumnString jobId;

  late final _i1.ColumnString harvestKey;

  late final _i1.ColumnEnum<_i2.DiscoveryHarvestRequester> requester;

  late final _i1.ColumnString requestedBy;

  late final _i1.ColumnEnum<_i3.DiscoveryHarvestTrigger> trigger;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnString cellId;

  late final _i1.ColumnInt radiusMeters;

  late final _i1.ColumnDouble centerLatitude;

  late final _i1.ColumnDouble centerLongitude;

  late final _i1.ColumnDouble south;

  late final _i1.ColumnDouble west;

  late final _i1.ColumnDouble north;

  late final _i1.ColumnDouble east;

  late final _i1.ColumnString manifestVersion;

  late final _i1.ColumnInt manifestRevision;

  late final _i1.ColumnString calibrationVersion;

  late final _i1.ColumnEnum<_i4.DiscoveryHarvestState> state;

  late final _i1.ColumnSerializable<List<_i5.DiscoveryHarvestQueryOutcome>>
  queryOutcomes;

  late final _i1.ColumnInt attemptedQueries;

  late final _i1.ColumnInt completedQueries;

  late final _i1.ColumnInt totalQueries;

  late final _i1.ColumnInt observedPlaces;

  late final _i1.ColumnInt upstreamRequests;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  late final _i1.ColumnString failureCode;

  @override
  List<_i1.Column> get columns => [
    id,
    jobId,
    harvestKey,
    requester,
    requestedBy,
    trigger,
    countryCode,
    cellId,
    radiusMeters,
    centerLatitude,
    centerLongitude,
    south,
    west,
    north,
    east,
    manifestVersion,
    manifestRevision,
    calibrationVersion,
    state,
    queryOutcomes,
    attemptedQueries,
    completedQueries,
    totalQueries,
    observedPlaces,
    upstreamRequests,
    createdAt,
    startedAt,
    completedAt,
    failureCode,
  ];
}

class DiscoveryHarvestRowInclude extends _i1.IncludeObject {
  DiscoveryHarvestRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DiscoveryHarvestRow.t;
}

class DiscoveryHarvestRowIncludeList extends _i1.IncludeList {
  DiscoveryHarvestRowIncludeList._({
    _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryHarvestRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DiscoveryHarvestRow.t;
}

class DiscoveryHarvestRowRepository {
  const DiscoveryHarvestRowRepository._();

  /// Returns a list of [DiscoveryHarvestRow]s matching the given query parameters.
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
  Future<List<DiscoveryHarvestRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DiscoveryHarvestRow] matching the given query parameters.
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
  Future<DiscoveryHarvestRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryHarvestRow] by its [id] or null if no such row exists.
  Future<DiscoveryHarvestRow?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DiscoveryHarvestRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DiscoveryHarvestRow]s in the list and returns the inserted rows.
  ///
  /// The returned [DiscoveryHarvestRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DiscoveryHarvestRow>> insert(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DiscoveryHarvestRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DiscoveryHarvestRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryHarvestRow] will have its `id` field set.
  Future<DiscoveryHarvestRow> insertRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryHarvestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DiscoveryHarvestRow>> update(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _i1.ColumnSelections<DiscoveryHarvestRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DiscoveryHarvestRow>(
      rows,
      columns: columns?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryHarvestRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryHarvestRow> updateRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _i1.ColumnSelections<DiscoveryHarvestRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DiscoveryHarvestRow>(
      row,
      columns: columns?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DiscoveryHarvestRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DiscoveryHarvestRow?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DiscoveryHarvestRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryHarvestRow>(
      id,
      columnValues: columnValues(DiscoveryHarvestRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DiscoveryHarvestRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DiscoveryHarvestRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _i1.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DiscoveryHarvestRow>(
      columnValues: columnValues(DiscoveryHarvestRow.t.updateTable),
      where: where(DiscoveryHarvestRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DiscoveryHarvestRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DiscoveryHarvestRow>> delete(
    _i1.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DiscoveryHarvestRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DiscoveryHarvestRow].
  Future<DiscoveryHarvestRow> deleteRow(
    _i1.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryHarvestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DiscoveryHarvestRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DiscoveryHarvestRow>(
      where: where(DiscoveryHarvestRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryHarvestRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryHarvestRow>(
      where: where(DiscoveryHarvestRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
