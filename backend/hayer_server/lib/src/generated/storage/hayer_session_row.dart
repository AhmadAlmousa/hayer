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
import '../session_mode.dart' as _i2;
import '../consensus_rule.dart' as _i3;
import '../matching_timing.dart' as _i4;
import '../session_status.dart' as _i5;
import '../place_intent_query.dart' as _i6;
import 'package:hayer_server/src/generated/protocol.dart' as _i7;

abstract class HayerSessionRow
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  HayerSessionRow._({
    this.id,
    required this.sessionId,
    required this.code,
    required this.hostUserId,
    required this.mode,
    required this.categoryId,
    required this.subcategoryIds,
    this.priceLevel,
    required this.anchorLatitude,
    required this.anchorLongitude,
    this.anchorAddress,
    this.cityKey,
    this.cityName,
    this.visitAt,
    required this.countryCode,
    required this.radiusMeters,
    required this.deckSizeRequested,
    required this.deckSizeActual,
    required this.consensusRule,
    required this.matchingTiming,
    required this.status,
    this.matchedPlaceId,
    this.decisionAt,
    required this.revision,
    this.freshnessWarning,
    this.intent,
    int? intentBatchCount,
    required this.createdAt,
    required this.expiresAt,
  }) : intentBatchCount = intentBatchCount ?? 1;

  factory HayerSessionRow({
    _i1.UuidValue? id,
    required String sessionId,
    required String code,
    required String hostUserId,
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    String? cityKey,
    String? cityName,
    DateTime? visitAt,
    required String countryCode,
    required int radiusMeters,
    required int deckSizeRequested,
    required int deckSizeActual,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    required _i5.SessionStatus status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    required int revision,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _HayerSessionRowImpl;

  factory HayerSessionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return HayerSessionRow(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      code: jsonSerialization['code'] as String,
      hostUserId: jsonSerialization['hostUserId'] as String,
      mode: _i2.SessionMode.fromJson((jsonSerialization['mode'] as String)),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i7.Protocol().deserialize<List<String>>(
        jsonSerialization['subcategoryIds'],
      ),
      priceLevel: jsonSerialization['priceLevel'] as int?,
      anchorLatitude: (jsonSerialization['anchorLatitude'] as num).toDouble(),
      anchorLongitude: (jsonSerialization['anchorLongitude'] as num).toDouble(),
      anchorAddress: jsonSerialization['anchorAddress'] as String?,
      cityKey: jsonSerialization['cityKey'] as String?,
      cityName: jsonSerialization['cityName'] as String?,
      visitAt: jsonSerialization['visitAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['visitAt']),
      countryCode: jsonSerialization['countryCode'] as String,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSizeRequested: jsonSerialization['deckSizeRequested'] as int,
      deckSizeActual: jsonSerialization['deckSizeActual'] as int,
      consensusRule: _i3.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _i4.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      status: _i5.SessionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      matchedPlaceId: jsonSerialization['matchedPlaceId'] as String?,
      decisionAt: jsonSerialization['decisionAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['decisionAt']),
      revision: jsonSerialization['revision'] as int,
      freshnessWarning: jsonSerialization['freshnessWarning'] as String?,
      intent: jsonSerialization['intent'] == null
          ? null
          : _i7.Protocol().deserialize<_i6.PlaceIntentQuery>(
              jsonSerialization['intent'],
            ),
      intentBatchCount: jsonSerialization['intentBatchCount'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = HayerSessionRowTable();

  static const db = HayerSessionRowRepository._();

  @override
  _i1.UuidValue? id;

  String sessionId;

  String code;

  String hostUserId;

  _i2.SessionMode mode;

  String categoryId;

  List<String> subcategoryIds;

  int? priceLevel;

  double anchorLatitude;

  double anchorLongitude;

  String? anchorAddress;

  String? cityKey;

  String? cityName;

  DateTime? visitAt;

  String countryCode;

  int radiusMeters;

  int deckSizeRequested;

  int deckSizeActual;

  _i3.ConsensusRule consensusRule;

  _i4.MatchingTiming matchingTiming;

  _i5.SessionStatus status;

  String? matchedPlaceId;

  DateTime? decisionAt;

  int revision;

  String? freshnessWarning;

  _i6.PlaceIntentQuery? intent;

  int? intentBatchCount;

  DateTime createdAt;

  DateTime expiresAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [HayerSessionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HayerSessionRow copyWith({
    _i1.UuidValue? id,
    String? sessionId,
    String? code,
    String? hostUserId,
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    int? priceLevel,
    double? anchorLatitude,
    double? anchorLongitude,
    String? anchorAddress,
    String? cityKey,
    String? cityName,
    DateTime? visitAt,
    String? countryCode,
    int? radiusMeters,
    int? deckSizeRequested,
    int? deckSizeActual,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    _i5.SessionStatus? status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    int? revision,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
    DateTime? createdAt,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HayerSessionRow',
      if (id != null) 'id': id?.toJson(),
      'sessionId': sessionId,
      'code': code,
      'hostUserId': hostUserId,
      'mode': mode.toJson(),
      'categoryId': categoryId,
      'subcategoryIds': subcategoryIds.toJson(),
      if (priceLevel != null) 'priceLevel': priceLevel,
      'anchorLatitude': anchorLatitude,
      'anchorLongitude': anchorLongitude,
      if (anchorAddress != null) 'anchorAddress': anchorAddress,
      if (cityKey != null) 'cityKey': cityKey,
      if (cityName != null) 'cityName': cityName,
      if (visitAt != null) 'visitAt': visitAt?.toJson(),
      'countryCode': countryCode,
      'radiusMeters': radiusMeters,
      'deckSizeRequested': deckSizeRequested,
      'deckSizeActual': deckSizeActual,
      'consensusRule': consensusRule.toJson(),
      'matchingTiming': matchingTiming.toJson(),
      'status': status.toJson(),
      if (matchedPlaceId != null) 'matchedPlaceId': matchedPlaceId,
      if (decisionAt != null) 'decisionAt': decisionAt?.toJson(),
      'revision': revision,
      if (freshnessWarning != null) 'freshnessWarning': freshnessWarning,
      if (intent != null) 'intent': intent?.toJson(),
      if (intentBatchCount != null) 'intentBatchCount': intentBatchCount,
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static HayerSessionRowInclude include() {
    return HayerSessionRowInclude._();
  }

  static HayerSessionRowIncludeList includeList({
    _i1.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HayerSessionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    HayerSessionRowInclude? include,
  }) {
    return HayerSessionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(HayerSessionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HayerSessionRowImpl extends HayerSessionRow {
  _HayerSessionRowImpl({
    _i1.UuidValue? id,
    required String sessionId,
    required String code,
    required String hostUserId,
    required _i2.SessionMode mode,
    required String categoryId,
    required List<String> subcategoryIds,
    int? priceLevel,
    required double anchorLatitude,
    required double anchorLongitude,
    String? anchorAddress,
    String? cityKey,
    String? cityName,
    DateTime? visitAt,
    required String countryCode,
    required int radiusMeters,
    required int deckSizeRequested,
    required int deckSizeActual,
    required _i3.ConsensusRule consensusRule,
    required _i4.MatchingTiming matchingTiming,
    required _i5.SessionStatus status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    required int revision,
    String? freshnessWarning,
    _i6.PlaceIntentQuery? intent,
    int? intentBatchCount,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         code: code,
         hostUserId: hostUserId,
         mode: mode,
         categoryId: categoryId,
         subcategoryIds: subcategoryIds,
         priceLevel: priceLevel,
         anchorLatitude: anchorLatitude,
         anchorLongitude: anchorLongitude,
         anchorAddress: anchorAddress,
         cityKey: cityKey,
         cityName: cityName,
         visitAt: visitAt,
         countryCode: countryCode,
         radiusMeters: radiusMeters,
         deckSizeRequested: deckSizeRequested,
         deckSizeActual: deckSizeActual,
         consensusRule: consensusRule,
         matchingTiming: matchingTiming,
         status: status,
         matchedPlaceId: matchedPlaceId,
         decisionAt: decisionAt,
         revision: revision,
         freshnessWarning: freshnessWarning,
         intent: intent,
         intentBatchCount: intentBatchCount,
         createdAt: createdAt,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [HayerSessionRow]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HayerSessionRow copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? code,
    String? hostUserId,
    _i2.SessionMode? mode,
    String? categoryId,
    List<String>? subcategoryIds,
    Object? priceLevel = _Undefined,
    double? anchorLatitude,
    double? anchorLongitude,
    Object? anchorAddress = _Undefined,
    Object? cityKey = _Undefined,
    Object? cityName = _Undefined,
    Object? visitAt = _Undefined,
    String? countryCode,
    int? radiusMeters,
    int? deckSizeRequested,
    int? deckSizeActual,
    _i3.ConsensusRule? consensusRule,
    _i4.MatchingTiming? matchingTiming,
    _i5.SessionStatus? status,
    Object? matchedPlaceId = _Undefined,
    Object? decisionAt = _Undefined,
    int? revision,
    Object? freshnessWarning = _Undefined,
    Object? intent = _Undefined,
    Object? intentBatchCount = _Undefined,
    DateTime? createdAt,
    DateTime? expiresAt,
  }) {
    return HayerSessionRow(
      id: id is _i1.UuidValue? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      code: code ?? this.code,
      hostUserId: hostUserId ?? this.hostUserId,
      mode: mode ?? this.mode,
      categoryId: categoryId ?? this.categoryId,
      subcategoryIds:
          subcategoryIds ?? this.subcategoryIds.map((e0) => e0).toList(),
      priceLevel: priceLevel is int? ? priceLevel : this.priceLevel,
      anchorLatitude: anchorLatitude ?? this.anchorLatitude,
      anchorLongitude: anchorLongitude ?? this.anchorLongitude,
      anchorAddress: anchorAddress is String?
          ? anchorAddress
          : this.anchorAddress,
      cityKey: cityKey is String? ? cityKey : this.cityKey,
      cityName: cityName is String? ? cityName : this.cityName,
      visitAt: visitAt is DateTime? ? visitAt : this.visitAt,
      countryCode: countryCode ?? this.countryCode,
      radiusMeters: radiusMeters ?? this.radiusMeters,
      deckSizeRequested: deckSizeRequested ?? this.deckSizeRequested,
      deckSizeActual: deckSizeActual ?? this.deckSizeActual,
      consensusRule: consensusRule ?? this.consensusRule,
      matchingTiming: matchingTiming ?? this.matchingTiming,
      status: status ?? this.status,
      matchedPlaceId: matchedPlaceId is String?
          ? matchedPlaceId
          : this.matchedPlaceId,
      decisionAt: decisionAt is DateTime? ? decisionAt : this.decisionAt,
      revision: revision ?? this.revision,
      freshnessWarning: freshnessWarning is String?
          ? freshnessWarning
          : this.freshnessWarning,
      intent: intent is _i6.PlaceIntentQuery?
          ? intent
          : this.intent?.copyWith(),
      intentBatchCount: intentBatchCount is int?
          ? intentBatchCount
          : this.intentBatchCount,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}

class HayerSessionRowUpdateTable extends _i1.UpdateTable<HayerSessionRowTable> {
  HayerSessionRowUpdateTable(super.table);

  _i1.ColumnValue<String, String> sessionId(String value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<String, String> hostUserId(String value) => _i1.ColumnValue(
    table.hostUserId,
    value,
  );

  _i1.ColumnValue<_i2.SessionMode, _i2.SessionMode> mode(
    _i2.SessionMode value,
  ) => _i1.ColumnValue(
    table.mode,
    value,
  );

  _i1.ColumnValue<String, String> categoryId(String value) => _i1.ColumnValue(
    table.categoryId,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> subcategoryIds(
    List<String> value,
  ) => _i1.ColumnValue(
    table.subcategoryIds,
    value,
  );

  _i1.ColumnValue<int, int> priceLevel(int? value) => _i1.ColumnValue(
    table.priceLevel,
    value,
  );

  _i1.ColumnValue<double, double> anchorLatitude(double value) =>
      _i1.ColumnValue(
        table.anchorLatitude,
        value,
      );

  _i1.ColumnValue<double, double> anchorLongitude(double value) =>
      _i1.ColumnValue(
        table.anchorLongitude,
        value,
      );

  _i1.ColumnValue<String, String> anchorAddress(String? value) =>
      _i1.ColumnValue(
        table.anchorAddress,
        value,
      );

  _i1.ColumnValue<String, String> cityKey(String? value) => _i1.ColumnValue(
    table.cityKey,
    value,
  );

  _i1.ColumnValue<String, String> cityName(String? value) => _i1.ColumnValue(
    table.cityName,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> visitAt(DateTime? value) =>
      _i1.ColumnValue(
        table.visitAt,
        value,
      );

  _i1.ColumnValue<String, String> countryCode(String value) => _i1.ColumnValue(
    table.countryCode,
    value,
  );

  _i1.ColumnValue<int, int> radiusMeters(int value) => _i1.ColumnValue(
    table.radiusMeters,
    value,
  );

  _i1.ColumnValue<int, int> deckSizeRequested(int value) => _i1.ColumnValue(
    table.deckSizeRequested,
    value,
  );

  _i1.ColumnValue<int, int> deckSizeActual(int value) => _i1.ColumnValue(
    table.deckSizeActual,
    value,
  );

  _i1.ColumnValue<_i3.ConsensusRule, _i3.ConsensusRule> consensusRule(
    _i3.ConsensusRule value,
  ) => _i1.ColumnValue(
    table.consensusRule,
    value,
  );

  _i1.ColumnValue<_i4.MatchingTiming, _i4.MatchingTiming> matchingTiming(
    _i4.MatchingTiming value,
  ) => _i1.ColumnValue(
    table.matchingTiming,
    value,
  );

  _i1.ColumnValue<_i5.SessionStatus, _i5.SessionStatus> status(
    _i5.SessionStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> matchedPlaceId(String? value) =>
      _i1.ColumnValue(
        table.matchedPlaceId,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> decisionAt(DateTime? value) =>
      _i1.ColumnValue(
        table.decisionAt,
        value,
      );

  _i1.ColumnValue<int, int> revision(int value) => _i1.ColumnValue(
    table.revision,
    value,
  );

  _i1.ColumnValue<String, String> freshnessWarning(String? value) =>
      _i1.ColumnValue(
        table.freshnessWarning,
        value,
      );

  _i1.ColumnValue<_i6.PlaceIntentQuery, _i6.PlaceIntentQuery> intent(
    _i6.PlaceIntentQuery? value,
  ) => _i1.ColumnValue(
    table.intent,
    value,
  );

  _i1.ColumnValue<int, int> intentBatchCount(int? value) => _i1.ColumnValue(
    table.intentBatchCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(
        table.expiresAt,
        value,
      );
}

class HayerSessionRowTable extends _i1.Table<_i1.UuidValue?> {
  HayerSessionRowTable({super.tableRelation})
    : super(tableName: 'hayer_session') {
    updateTable = HayerSessionRowUpdateTable(this);
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    hostUserId = _i1.ColumnString(
      'hostUserId',
      this,
    );
    mode = _i1.ColumnEnum(
      'mode',
      this,
      _i1.EnumSerialization.byName,
    );
    categoryId = _i1.ColumnString(
      'categoryId',
      this,
    );
    subcategoryIds = _i1.ColumnSerializable<List<String>>(
      'subcategoryIds',
      this,
    );
    priceLevel = _i1.ColumnInt(
      'priceLevel',
      this,
    );
    anchorLatitude = _i1.ColumnDouble(
      'anchorLatitude',
      this,
    );
    anchorLongitude = _i1.ColumnDouble(
      'anchorLongitude',
      this,
    );
    anchorAddress = _i1.ColumnString(
      'anchorAddress',
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
    visitAt = _i1.ColumnDateTime(
      'visitAt',
      this,
    );
    countryCode = _i1.ColumnString(
      'countryCode',
      this,
    );
    radiusMeters = _i1.ColumnInt(
      'radiusMeters',
      this,
    );
    deckSizeRequested = _i1.ColumnInt(
      'deckSizeRequested',
      this,
    );
    deckSizeActual = _i1.ColumnInt(
      'deckSizeActual',
      this,
    );
    consensusRule = _i1.ColumnEnum(
      'consensusRule',
      this,
      _i1.EnumSerialization.byName,
    );
    matchingTiming = _i1.ColumnEnum(
      'matchingTiming',
      this,
      _i1.EnumSerialization.byName,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    matchedPlaceId = _i1.ColumnString(
      'matchedPlaceId',
      this,
    );
    decisionAt = _i1.ColumnDateTime(
      'decisionAt',
      this,
    );
    revision = _i1.ColumnInt(
      'revision',
      this,
    );
    freshnessWarning = _i1.ColumnString(
      'freshnessWarning',
      this,
    );
    intent = _i1.ColumnSerializable<_i6.PlaceIntentQuery>(
      'intent',
      this,
    );
    intentBatchCount = _i1.ColumnInt(
      'intentBatchCount',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    expiresAt = _i1.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final HayerSessionRowUpdateTable updateTable;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString hostUserId;

  late final _i1.ColumnEnum<_i2.SessionMode> mode;

  late final _i1.ColumnString categoryId;

  late final _i1.ColumnSerializable<List<String>> subcategoryIds;

  late final _i1.ColumnInt priceLevel;

  late final _i1.ColumnDouble anchorLatitude;

  late final _i1.ColumnDouble anchorLongitude;

  late final _i1.ColumnString anchorAddress;

  late final _i1.ColumnString cityKey;

  late final _i1.ColumnString cityName;

  late final _i1.ColumnDateTime visitAt;

  late final _i1.ColumnString countryCode;

  late final _i1.ColumnInt radiusMeters;

  late final _i1.ColumnInt deckSizeRequested;

  late final _i1.ColumnInt deckSizeActual;

  late final _i1.ColumnEnum<_i3.ConsensusRule> consensusRule;

  late final _i1.ColumnEnum<_i4.MatchingTiming> matchingTiming;

  late final _i1.ColumnEnum<_i5.SessionStatus> status;

  late final _i1.ColumnString matchedPlaceId;

  late final _i1.ColumnDateTime decisionAt;

  late final _i1.ColumnInt revision;

  late final _i1.ColumnString freshnessWarning;

  late final _i1.ColumnSerializable<_i6.PlaceIntentQuery> intent;

  late final _i1.ColumnInt intentBatchCount;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime expiresAt;

  @override
  List<_i1.Column> get columns => [
    id,
    sessionId,
    code,
    hostUserId,
    mode,
    categoryId,
    subcategoryIds,
    priceLevel,
    anchorLatitude,
    anchorLongitude,
    anchorAddress,
    cityKey,
    cityName,
    visitAt,
    countryCode,
    radiusMeters,
    deckSizeRequested,
    deckSizeActual,
    consensusRule,
    matchingTiming,
    status,
    matchedPlaceId,
    decisionAt,
    revision,
    freshnessWarning,
    intent,
    intentBatchCount,
    createdAt,
    expiresAt,
  ];
}

class HayerSessionRowInclude extends _i1.IncludeObject {
  HayerSessionRowInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => HayerSessionRow.t;
}

class HayerSessionRowIncludeList extends _i1.IncludeList {
  HayerSessionRowIncludeList._({
    _i1.WhereExpressionBuilder<HayerSessionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HayerSessionRow.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => HayerSessionRow.t;
}

class HayerSessionRowRepository {
  const HayerSessionRowRepository._();

  /// Returns a list of [HayerSessionRow]s matching the given query parameters.
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
  Future<List<HayerSessionRow>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HayerSessionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [HayerSessionRow] matching the given query parameters.
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
  Future<HayerSessionRow?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? offset,
    _i1.OrderByBuilder<HayerSessionRowTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [HayerSessionRow] by its [id] or null if no such row exists.
  Future<HayerSessionRow?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<HayerSessionRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [HayerSessionRow]s in the list and returns the inserted rows.
  ///
  /// The returned [HayerSessionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<HayerSessionRow>> insert(
    _i1.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<HayerSessionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [HayerSessionRow] and returns the inserted row.
  ///
  /// The returned [HayerSessionRow] will have its `id` field set.
  Future<HayerSessionRow> insertRow(
    _i1.DatabaseSession session,
    HayerSessionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<HayerSessionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [HayerSessionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<HayerSessionRow>> update(
    _i1.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _i1.ColumnSelections<HayerSessionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<HayerSessionRow>(
      rows,
      columns: columns?.call(HayerSessionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HayerSessionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HayerSessionRow> updateRow(
    _i1.DatabaseSession session,
    HayerSessionRow row, {
    _i1.ColumnSelections<HayerSessionRowTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<HayerSessionRow>(
      row,
      columns: columns?.call(HayerSessionRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [HayerSessionRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<HayerSessionRow?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<HayerSessionRowUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<HayerSessionRow>(
      id,
      columnValues: columnValues(HayerSessionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [HayerSessionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<HayerSessionRow>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<HayerSessionRowUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<HayerSessionRowTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _i1.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<HayerSessionRow>(
      columnValues: columnValues(HayerSessionRow.t.updateTable),
      where: where(HayerSessionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [HayerSessionRow]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<HayerSessionRow>> delete(
    _i1.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<HayerSessionRow>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [HayerSessionRow].
  Future<HayerSessionRow> deleteRow(
    _i1.DatabaseSession session,
    HayerSessionRow row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HayerSessionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<HayerSessionRow>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<HayerSessionRowTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<HayerSessionRow>(
      where: where(HayerSessionRow.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [HayerSessionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<HayerSessionRowTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<HayerSessionRow>(
      where: where(HayerSessionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
