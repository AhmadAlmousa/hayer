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
import '../discovery_harvest_query_outcome.dart' as _iajcbtjd;
import '../discovery_harvest_requester.dart' as _i85zgm36;
import '../discovery_harvest_state.dart' as _iervij0b;
import '../discovery_harvest_trigger.dart' as _ib06b67f;

abstract class DiscoveryHarvestRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _i85zgm36.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _ib06b67f.DiscoveryHarvestTrigger trigger,
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
    required _iervij0b.DiscoveryHarvestState state,
    required List<_iajcbtjd.DiscoveryHarvestQueryOutcome> queryOutcomes,
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
      requester: _i85zgm36.DiscoveryHarvestRequester.fromJson(
        (jsonSerialization['requester'] as String),
      ),
      requestedBy: jsonSerialization['requestedBy'] as String,
      trigger: _ib06b67f.DiscoveryHarvestTrigger.fromJson(
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
      state: _iervij0b.DiscoveryHarvestState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      queryOutcomes: _i66y2smk.Protocol()
          .deserialize<List<_iajcbtjd.DiscoveryHarvestQueryOutcome>>(
            jsonSerialization['queryOutcomes'],
          ),
      attemptedQueries: jsonSerialization['attemptedQueries'] as int,
      completedQueries: jsonSerialization['completedQueries'] as int,
      totalQueries: jsonSerialization['totalQueries'] as int,
      observedPlaces: jsonSerialization['observedPlaces'] as int,
      upstreamRequests: jsonSerialization['upstreamRequests'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
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

  _i85zgm36.DiscoveryHarvestRequester requester;

  String requestedBy;

  _ib06b67f.DiscoveryHarvestTrigger trigger;

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

  _iervij0b.DiscoveryHarvestState state;

  List<_iajcbtjd.DiscoveryHarvestQueryOutcome> queryOutcomes;

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
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DiscoveryHarvestRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DiscoveryHarvestRow copyWith({
    int? id,
    String? jobId,
    String? harvestKey,
    _i85zgm36.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _ib06b67f.DiscoveryHarvestTrigger? trigger,
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
    _iervij0b.DiscoveryHarvestState? state,
    List<_iajcbtjd.DiscoveryHarvestQueryOutcome>? queryOutcomes,
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
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    DiscoveryHarvestRowInclude? include,
  }) {
    return DiscoveryHarvestRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DiscoveryHarvestRowImpl extends DiscoveryHarvestRow {
  _DiscoveryHarvestRowImpl({
    int? id,
    required String jobId,
    required String harvestKey,
    required _i85zgm36.DiscoveryHarvestRequester requester,
    required String requestedBy,
    required _ib06b67f.DiscoveryHarvestTrigger trigger,
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
    required _iervij0b.DiscoveryHarvestState state,
    required List<_iajcbtjd.DiscoveryHarvestQueryOutcome> queryOutcomes,
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
  @_is.useResult
  @override
  DiscoveryHarvestRow copyWith({
    Object? id = _Undefined,
    String? jobId,
    String? harvestKey,
    _i85zgm36.DiscoveryHarvestRequester? requester,
    String? requestedBy,
    _ib06b67f.DiscoveryHarvestTrigger? trigger,
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
    _iervij0b.DiscoveryHarvestState? state,
    List<_iajcbtjd.DiscoveryHarvestQueryOutcome>? queryOutcomes,
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
    extends _is.UpdateTable<DiscoveryHarvestRowTable> {
  DiscoveryHarvestRowUpdateTable(super.table);

  _is.ColumnValue<String, String> jobId(String value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<String, String> harvestKey(String value) => _is.ColumnValue(
    table.harvestKey,
    value,
  );

  _is.ColumnValue<
    _i85zgm36.DiscoveryHarvestRequester,
    _i85zgm36.DiscoveryHarvestRequester
  >
  requester(_i85zgm36.DiscoveryHarvestRequester value) => _is.ColumnValue(
    table.requester,
    value,
  );

  _is.ColumnValue<String, String> requestedBy(String value) => _is.ColumnValue(
    table.requestedBy,
    value,
  );

  _is.ColumnValue<
    _ib06b67f.DiscoveryHarvestTrigger,
    _ib06b67f.DiscoveryHarvestTrigger
  >
  trigger(_ib06b67f.DiscoveryHarvestTrigger value) => _is.ColumnValue(
    table.trigger,
    value,
  );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<String, String> cellId(String value) => _is.ColumnValue(
    table.cellId,
    value,
  );

  _is.ColumnValue<int, int> radiusMeters(int value) => _is.ColumnValue(
    table.radiusMeters,
    value,
  );

  _is.ColumnValue<double, double> centerLatitude(double value) =>
      _is.ColumnValue(
        table.centerLatitude,
        value,
      );

  _is.ColumnValue<double, double> centerLongitude(double value) =>
      _is.ColumnValue(
        table.centerLongitude,
        value,
      );

  _is.ColumnValue<double, double> south(double value) => _is.ColumnValue(
    table.south,
    value,
  );

  _is.ColumnValue<double, double> west(double value) => _is.ColumnValue(
    table.west,
    value,
  );

  _is.ColumnValue<double, double> north(double value) => _is.ColumnValue(
    table.north,
    value,
  );

  _is.ColumnValue<double, double> east(double value) => _is.ColumnValue(
    table.east,
    value,
  );

  _is.ColumnValue<String, String> manifestVersion(String value) =>
      _is.ColumnValue(
        table.manifestVersion,
        value,
      );

  _is.ColumnValue<int, int> manifestRevision(int value) => _is.ColumnValue(
    table.manifestRevision,
    value,
  );

  _is.ColumnValue<String, String> calibrationVersion(String value) =>
      _is.ColumnValue(
        table.calibrationVersion,
        value,
      );

  _is.ColumnValue<
    _iervij0b.DiscoveryHarvestState,
    _iervij0b.DiscoveryHarvestState
  >
  state(_iervij0b.DiscoveryHarvestState value) => _is.ColumnValue(
    table.state,
    value,
  );

  _is.ColumnValue<
    List<_iajcbtjd.DiscoveryHarvestQueryOutcome>,
    List<_iajcbtjd.DiscoveryHarvestQueryOutcome>
  >
  queryOutcomes(List<_iajcbtjd.DiscoveryHarvestQueryOutcome> value) =>
      _is.ColumnValue(
        table.queryOutcomes,
        value,
      );

  _is.ColumnValue<int, int> attemptedQueries(int value) => _is.ColumnValue(
    table.attemptedQueries,
    value,
  );

  _is.ColumnValue<int, int> completedQueries(int value) => _is.ColumnValue(
    table.completedQueries,
    value,
  );

  _is.ColumnValue<int, int> totalQueries(int value) => _is.ColumnValue(
    table.totalQueries,
    value,
  );

  _is.ColumnValue<int, int> observedPlaces(int value) => _is.ColumnValue(
    table.observedPlaces,
    value,
  );

  _is.ColumnValue<int, int> upstreamRequests(int value) => _is.ColumnValue(
    table.upstreamRequests,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<String, String> failureCode(String? value) => _is.ColumnValue(
    table.failureCode,
    value,
  );
}

class DiscoveryHarvestRowTable extends _is.Table<int?> {
  DiscoveryHarvestRowTable({super.tableRelation})
    : super(tableName: 'hayer_discovery_harvest') {
    updateTable = DiscoveryHarvestRowUpdateTable(this);
    jobId = _is.ColumnString(
      'jobId',
      this,
    );
    harvestKey = _is.ColumnString(
      'harvestKey',
      this,
    );
    requester = _is.ColumnEnum(
      'requester',
      this,
      _is.EnumSerialization.byName,
    );
    requestedBy = _is.ColumnString(
      'requestedBy',
      this,
    );
    trigger = _is.ColumnEnum(
      'trigger',
      this,
      _is.EnumSerialization.byName,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    cellId = _is.ColumnString(
      'cellId',
      this,
    );
    radiusMeters = _is.ColumnInt(
      'radiusMeters',
      this,
    );
    centerLatitude = _is.ColumnDouble(
      'centerLatitude',
      this,
    );
    centerLongitude = _is.ColumnDouble(
      'centerLongitude',
      this,
    );
    south = _is.ColumnDouble(
      'south',
      this,
    );
    west = _is.ColumnDouble(
      'west',
      this,
    );
    north = _is.ColumnDouble(
      'north',
      this,
    );
    east = _is.ColumnDouble(
      'east',
      this,
    );
    manifestVersion = _is.ColumnString(
      'manifestVersion',
      this,
    );
    manifestRevision = _is.ColumnInt(
      'manifestRevision',
      this,
    );
    calibrationVersion = _is.ColumnString(
      'calibrationVersion',
      this,
    );
    state = _is.ColumnEnum(
      'state',
      this,
      _is.EnumSerialization.byName,
    );
    queryOutcomes =
        _is.ColumnSerializable<List<_iajcbtjd.DiscoveryHarvestQueryOutcome>>(
          'queryOutcomes',
          this,
        );
    attemptedQueries = _is.ColumnInt(
      'attemptedQueries',
      this,
    );
    completedQueries = _is.ColumnInt(
      'completedQueries',
      this,
    );
    totalQueries = _is.ColumnInt(
      'totalQueries',
      this,
    );
    observedPlaces = _is.ColumnInt(
      'observedPlaces',
      this,
    );
    upstreamRequests = _is.ColumnInt(
      'upstreamRequests',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    failureCode = _is.ColumnString(
      'failureCode',
      this,
    );
  }

  late final DiscoveryHarvestRowUpdateTable updateTable;

  late final _is.ColumnString jobId;

  late final _is.ColumnString harvestKey;

  late final _is.ColumnEnum<_i85zgm36.DiscoveryHarvestRequester> requester;

  late final _is.ColumnString requestedBy;

  late final _is.ColumnEnum<_ib06b67f.DiscoveryHarvestTrigger> trigger;

  late final _is.ColumnString countryCode;

  late final _is.ColumnString cellId;

  late final _is.ColumnInt radiusMeters;

  late final _is.ColumnDouble centerLatitude;

  late final _is.ColumnDouble centerLongitude;

  late final _is.ColumnDouble south;

  late final _is.ColumnDouble west;

  late final _is.ColumnDouble north;

  late final _is.ColumnDouble east;

  late final _is.ColumnString manifestVersion;

  late final _is.ColumnInt manifestRevision;

  late final _is.ColumnString calibrationVersion;

  late final _is.ColumnEnum<_iervij0b.DiscoveryHarvestState> state;

  late final _is.ColumnSerializable<
    List<_iajcbtjd.DiscoveryHarvestQueryOutcome>
  >
  queryOutcomes;

  late final _is.ColumnInt attemptedQueries;

  late final _is.ColumnInt completedQueries;

  late final _is.ColumnInt totalQueries;

  late final _is.ColumnInt observedPlaces;

  late final _is.ColumnInt upstreamRequests;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnString failureCode;

  @override
  List<_is.Column> get columns => [
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

class DiscoveryHarvestRowInclude extends _is.IncludeObject {
  DiscoveryHarvestRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DiscoveryHarvestRow.t;
}

class DiscoveryHarvestRowIncludeList extends _is.IncludeList {
  DiscoveryHarvestRowIncludeList._({
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DiscoveryHarvestRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DiscoveryHarvestRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DiscoveryHarvestRow] by its [id] or null if no such row exists.
  Future<DiscoveryHarvestRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestRow>> insert(
    _is.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DiscoveryHarvestRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DiscoveryHarvestRow] and returns the inserted row.
  ///
  /// The returned [DiscoveryHarvestRow] will have its `id` field set.
  Future<DiscoveryHarvestRow> insertRow(
    _is.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DiscoveryHarvestRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DiscoveryHarvestRow]s in the list and returns the resulting rows.
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
  /// The returned [DiscoveryHarvestRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestRow>> upsert(
    _is.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    required _is.ColumnSelections<DiscoveryHarvestRowTable> conflictColumns,
    _is.ColumnSelections<DiscoveryHarvestRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DiscoveryHarvestRow>(
      rows,
      conflictColumns: conflictColumns(DiscoveryHarvestRow.t),
      updateColumns: updateColumns?.call(DiscoveryHarvestRow.t),
      updateWhere: updateWhere?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DiscoveryHarvestRow] and returns the resulting row.
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
  /// The returned [DiscoveryHarvestRow] will have its `id` field set.
  Future<DiscoveryHarvestRow?> upsertRow(
    _is.DatabaseSession session,
    DiscoveryHarvestRow row, {
    required _is.ColumnSelections<DiscoveryHarvestRowTable> conflictColumns,
    _is.ColumnSelections<DiscoveryHarvestRowTable>? updateColumns,
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DiscoveryHarvestRow>(
      row,
      conflictColumns: conflictColumns(DiscoveryHarvestRow.t),
      updateColumns: updateColumns?.call(DiscoveryHarvestRow.t),
      updateWhere: updateWhere?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestRow>> update(
    _is.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _is.ColumnSelections<DiscoveryHarvestRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DiscoveryHarvestRow>(
      rows,
      columns: columns?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DiscoveryHarvestRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DiscoveryHarvestRow> updateRow(
    _is.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _is.ColumnSelections<DiscoveryHarvestRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DiscoveryHarvestRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DiscoveryHarvestRow>(
      id,
      columnValues: columnValues(DiscoveryHarvestRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DiscoveryHarvestRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DiscoveryHarvestRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DiscoveryHarvestRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DiscoveryHarvestRow>(
      columnValues: columnValues(DiscoveryHarvestRow.t.updateTable),
      where: where(DiscoveryHarvestRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DiscoveryHarvestRow]s in the list and returns the deleted rows.
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
  Future<List<DiscoveryHarvestRow>> delete(
    _is.DatabaseSession session,
    List<DiscoveryHarvestRow> rows, {
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DiscoveryHarvestRow>(
      rows,
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DiscoveryHarvestRow].
  Future<DiscoveryHarvestRow> deleteRow(
    _is.DatabaseSession session,
    DiscoveryHarvestRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DiscoveryHarvestRow>(
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
  Future<List<DiscoveryHarvestRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    _is.OrderByBuilder<DiscoveryHarvestRowTable>? orderBy,
    _is.OrderByListBuilder<DiscoveryHarvestRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DiscoveryHarvestRow>(
      where: where(DiscoveryHarvestRow.t),
      orderBy: orderBy?.call(DiscoveryHarvestRow.t),
      orderByList: orderByList?.call(DiscoveryHarvestRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DiscoveryHarvestRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DiscoveryHarvestRow>(
      where: where?.call(DiscoveryHarvestRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DiscoveryHarvestRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DiscoveryHarvestRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DiscoveryHarvestRow>(
      where: where(DiscoveryHarvestRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
