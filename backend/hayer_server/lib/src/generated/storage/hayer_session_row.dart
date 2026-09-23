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
import '../consensus_rule.dart' as _itza565q;
import '../matching_timing.dart' as _il2ujp2y;
import '../place_intent_query.dart' as _iag0ql9d;
import '../session_mode.dart' as _il8ct4tj;
import '../session_status.dart' as _imums090;

abstract class HayerSessionRow
    implements _is.TableRow<_is.UuidValue?>, _is.ProtocolSerialization {
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
    _is.UuidValue? id,
    required String sessionId,
    required String code,
    required String hostUserId,
    required _il8ct4tj.SessionMode mode,
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
    required _itza565q.ConsensusRule consensusRule,
    required _il2ujp2y.MatchingTiming matchingTiming,
    required _imums090.SessionStatus status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    required int revision,
    String? freshnessWarning,
    _iag0ql9d.PlaceIntentQuery? intent,
    int? intentBatchCount,
    required DateTime createdAt,
    required DateTime expiresAt,
  }) = _HayerSessionRowImpl;

  factory HayerSessionRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return HayerSessionRow(
      id: jsonSerialization['id'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      sessionId: jsonSerialization['sessionId'] as String,
      code: jsonSerialization['code'] as String,
      hostUserId: jsonSerialization['hostUserId'] as String,
      mode: _il8ct4tj.SessionMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      categoryId: jsonSerialization['categoryId'] as String,
      subcategoryIds: _i66y2smk.Protocol().deserialize<List<String>>(
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['visitAt']),
      countryCode: jsonSerialization['countryCode'] as String,
      radiusMeters: jsonSerialization['radiusMeters'] as int,
      deckSizeRequested: jsonSerialization['deckSizeRequested'] as int,
      deckSizeActual: jsonSerialization['deckSizeActual'] as int,
      consensusRule: _itza565q.ConsensusRule.fromJson(
        (jsonSerialization['consensusRule'] as String),
      ),
      matchingTiming: _il2ujp2y.MatchingTiming.fromJson(
        (jsonSerialization['matchingTiming'] as String),
      ),
      status: _imums090.SessionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      matchedPlaceId: jsonSerialization['matchedPlaceId'] as String?,
      decisionAt: jsonSerialization['decisionAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decisionAt']),
      revision: jsonSerialization['revision'] as int,
      freshnessWarning: jsonSerialization['freshnessWarning'] as String?,
      intent: jsonSerialization['intent'] == null
          ? null
          : _i66y2smk.Protocol().deserialize<_iag0ql9d.PlaceIntentQuery>(
              jsonSerialization['intent'],
            ),
      intentBatchCount: jsonSerialization['intentBatchCount'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  static final t = HayerSessionRowTable();

  static const db = HayerSessionRowRepository._();

  @override
  _is.UuidValue? id;

  String sessionId;

  String code;

  String hostUserId;

  _il8ct4tj.SessionMode mode;

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

  _itza565q.ConsensusRule consensusRule;

  _il2ujp2y.MatchingTiming matchingTiming;

  _imums090.SessionStatus status;

  String? matchedPlaceId;

  DateTime? decisionAt;

  int revision;

  String? freshnessWarning;

  _iag0ql9d.PlaceIntentQuery? intent;

  int? intentBatchCount;

  DateTime createdAt;

  DateTime expiresAt;

  @override
  _is.Table<_is.UuidValue?> get table => t;

  /// Returns a shallow copy of this [HayerSessionRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HayerSessionRow copyWith({
    _is.UuidValue? id,
    String? sessionId,
    String? code,
    String? hostUserId,
    _il8ct4tj.SessionMode? mode,
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
    _itza565q.ConsensusRule? consensusRule,
    _il2ujp2y.MatchingTiming? matchingTiming,
    _imums090.SessionStatus? status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    int? revision,
    String? freshnessWarning,
    _iag0ql9d.PlaceIntentQuery? intent,
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
    _is.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    HayerSessionRowInclude? include,
  }) {
    return HayerSessionRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _HayerSessionRowImpl extends HayerSessionRow {
  _HayerSessionRowImpl({
    _is.UuidValue? id,
    required String sessionId,
    required String code,
    required String hostUserId,
    required _il8ct4tj.SessionMode mode,
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
    required _itza565q.ConsensusRule consensusRule,
    required _il2ujp2y.MatchingTiming matchingTiming,
    required _imums090.SessionStatus status,
    String? matchedPlaceId,
    DateTime? decisionAt,
    required int revision,
    String? freshnessWarning,
    _iag0ql9d.PlaceIntentQuery? intent,
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
  @_is.useResult
  @override
  HayerSessionRow copyWith({
    Object? id = _Undefined,
    String? sessionId,
    String? code,
    String? hostUserId,
    _il8ct4tj.SessionMode? mode,
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
    _itza565q.ConsensusRule? consensusRule,
    _il2ujp2y.MatchingTiming? matchingTiming,
    _imums090.SessionStatus? status,
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
      id: id is _is.UuidValue? ? id : this.id,
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
      intent: intent is _iag0ql9d.PlaceIntentQuery?
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

class HayerSessionRowUpdateTable extends _is.UpdateTable<HayerSessionRowTable> {
  HayerSessionRowUpdateTable(super.table);

  _is.ColumnValue<String, String> sessionId(String value) => _is.ColumnValue(
    table.sessionId,
    value,
  );

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<String, String> hostUserId(String value) => _is.ColumnValue(
    table.hostUserId,
    value,
  );

  _is.ColumnValue<_il8ct4tj.SessionMode, _il8ct4tj.SessionMode> mode(
    _il8ct4tj.SessionMode value,
  ) => _is.ColumnValue(
    table.mode,
    value,
  );

  _is.ColumnValue<String, String> categoryId(String value) => _is.ColumnValue(
    table.categoryId,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> subcategoryIds(
    List<String> value,
  ) => _is.ColumnValue(
    table.subcategoryIds,
    value,
  );

  _is.ColumnValue<int, int> priceLevel(int? value) => _is.ColumnValue(
    table.priceLevel,
    value,
  );

  _is.ColumnValue<double, double> anchorLatitude(double value) =>
      _is.ColumnValue(
        table.anchorLatitude,
        value,
      );

  _is.ColumnValue<double, double> anchorLongitude(double value) =>
      _is.ColumnValue(
        table.anchorLongitude,
        value,
      );

  _is.ColumnValue<String, String> anchorAddress(String? value) =>
      _is.ColumnValue(
        table.anchorAddress,
        value,
      );

  _is.ColumnValue<String, String> cityKey(String? value) => _is.ColumnValue(
    table.cityKey,
    value,
  );

  _is.ColumnValue<String, String> cityName(String? value) => _is.ColumnValue(
    table.cityName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> visitAt(DateTime? value) =>
      _is.ColumnValue(
        table.visitAt,
        value,
      );

  _is.ColumnValue<String, String> countryCode(String value) => _is.ColumnValue(
    table.countryCode,
    value,
  );

  _is.ColumnValue<int, int> radiusMeters(int value) => _is.ColumnValue(
    table.radiusMeters,
    value,
  );

  _is.ColumnValue<int, int> deckSizeRequested(int value) => _is.ColumnValue(
    table.deckSizeRequested,
    value,
  );

  _is.ColumnValue<int, int> deckSizeActual(int value) => _is.ColumnValue(
    table.deckSizeActual,
    value,
  );

  _is.ColumnValue<_itza565q.ConsensusRule, _itza565q.ConsensusRule>
  consensusRule(_itza565q.ConsensusRule value) => _is.ColumnValue(
    table.consensusRule,
    value,
  );

  _is.ColumnValue<_il2ujp2y.MatchingTiming, _il2ujp2y.MatchingTiming>
  matchingTiming(_il2ujp2y.MatchingTiming value) => _is.ColumnValue(
    table.matchingTiming,
    value,
  );

  _is.ColumnValue<_imums090.SessionStatus, _imums090.SessionStatus> status(
    _imums090.SessionStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> matchedPlaceId(String? value) =>
      _is.ColumnValue(
        table.matchedPlaceId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decisionAt(DateTime? value) =>
      _is.ColumnValue(
        table.decisionAt,
        value,
      );

  _is.ColumnValue<int, int> revision(int value) => _is.ColumnValue(
    table.revision,
    value,
  );

  _is.ColumnValue<String, String> freshnessWarning(String? value) =>
      _is.ColumnValue(
        table.freshnessWarning,
        value,
      );

  _is.ColumnValue<_iag0ql9d.PlaceIntentQuery, _iag0ql9d.PlaceIntentQuery>
  intent(_iag0ql9d.PlaceIntentQuery? value) => _is.ColumnValue(
    table.intent,
    value,
  );

  _is.ColumnValue<int, int> intentBatchCount(int? value) => _is.ColumnValue(
    table.intentBatchCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );
}

class HayerSessionRowTable extends _is.Table<_is.UuidValue?> {
  HayerSessionRowTable({super.tableRelation})
    : super(tableName: 'hayer_session') {
    updateTable = HayerSessionRowUpdateTable(this);
    sessionId = _is.ColumnString(
      'sessionId',
      this,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    hostUserId = _is.ColumnString(
      'hostUserId',
      this,
    );
    mode = _is.ColumnEnum(
      'mode',
      this,
      _is.EnumSerialization.byName,
    );
    categoryId = _is.ColumnString(
      'categoryId',
      this,
    );
    subcategoryIds = _is.ColumnSerializable<List<String>>(
      'subcategoryIds',
      this,
    );
    priceLevel = _is.ColumnInt(
      'priceLevel',
      this,
    );
    anchorLatitude = _is.ColumnDouble(
      'anchorLatitude',
      this,
    );
    anchorLongitude = _is.ColumnDouble(
      'anchorLongitude',
      this,
    );
    anchorAddress = _is.ColumnString(
      'anchorAddress',
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
    visitAt = _is.ColumnDateTime(
      'visitAt',
      this,
    );
    countryCode = _is.ColumnString(
      'countryCode',
      this,
    );
    radiusMeters = _is.ColumnInt(
      'radiusMeters',
      this,
    );
    deckSizeRequested = _is.ColumnInt(
      'deckSizeRequested',
      this,
    );
    deckSizeActual = _is.ColumnInt(
      'deckSizeActual',
      this,
    );
    consensusRule = _is.ColumnEnum(
      'consensusRule',
      this,
      _is.EnumSerialization.byName,
    );
    matchingTiming = _is.ColumnEnum(
      'matchingTiming',
      this,
      _is.EnumSerialization.byName,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    matchedPlaceId = _is.ColumnString(
      'matchedPlaceId',
      this,
    );
    decisionAt = _is.ColumnDateTime(
      'decisionAt',
      this,
    );
    revision = _is.ColumnInt(
      'revision',
      this,
    );
    freshnessWarning = _is.ColumnString(
      'freshnessWarning',
      this,
    );
    intent = _is.ColumnSerializable<_iag0ql9d.PlaceIntentQuery>(
      'intent',
      this,
    );
    intentBatchCount = _is.ColumnInt(
      'intentBatchCount',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
  }

  late final HayerSessionRowUpdateTable updateTable;

  late final _is.ColumnString sessionId;

  late final _is.ColumnString code;

  late final _is.ColumnString hostUserId;

  late final _is.ColumnEnum<_il8ct4tj.SessionMode> mode;

  late final _is.ColumnString categoryId;

  late final _is.ColumnSerializable<List<String>> subcategoryIds;

  late final _is.ColumnInt priceLevel;

  late final _is.ColumnDouble anchorLatitude;

  late final _is.ColumnDouble anchorLongitude;

  late final _is.ColumnString anchorAddress;

  late final _is.ColumnString cityKey;

  late final _is.ColumnString cityName;

  late final _is.ColumnDateTime visitAt;

  late final _is.ColumnString countryCode;

  late final _is.ColumnInt radiusMeters;

  late final _is.ColumnInt deckSizeRequested;

  late final _is.ColumnInt deckSizeActual;

  late final _is.ColumnEnum<_itza565q.ConsensusRule> consensusRule;

  late final _is.ColumnEnum<_il2ujp2y.MatchingTiming> matchingTiming;

  late final _is.ColumnEnum<_imums090.SessionStatus> status;

  late final _is.ColumnString matchedPlaceId;

  late final _is.ColumnDateTime decisionAt;

  late final _is.ColumnInt revision;

  late final _is.ColumnString freshnessWarning;

  late final _is.ColumnSerializable<_iag0ql9d.PlaceIntentQuery> intent;

  late final _is.ColumnInt intentBatchCount;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime expiresAt;

  @override
  List<_is.Column> get columns => [
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

class HayerSessionRowInclude extends _is.IncludeObject {
  HayerSessionRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<_is.UuidValue?> get table => HayerSessionRow.t;
}

class HayerSessionRowIncludeList extends _is.IncludeList {
  HayerSessionRowIncludeList._({
    _is.WhereExpressionBuilder<HayerSessionRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(HayerSessionRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<_is.UuidValue?> get table => HayerSessionRow.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? offset,
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [HayerSessionRow] by its [id] or null if no such row exists.
  Future<HayerSessionRow?> findById(
    _is.DatabaseSession session,
    _is.UuidValue id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
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
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HayerSessionRow>> insert(
    _is.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<HayerSessionRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [HayerSessionRow] and returns the inserted row.
  ///
  /// The returned [HayerSessionRow] will have its `id` field set.
  Future<HayerSessionRow> insertRow(
    _is.DatabaseSession session,
    HayerSessionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<HayerSessionRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [HayerSessionRow]s in the list and returns the resulting rows.
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
  /// The returned [HayerSessionRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HayerSessionRow>> upsert(
    _is.DatabaseSession session,
    List<HayerSessionRow> rows, {
    required _is.ColumnSelections<HayerSessionRowTable> conflictColumns,
    _is.ColumnSelections<HayerSessionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<HayerSessionRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<HayerSessionRow>(
      rows,
      conflictColumns: conflictColumns(HayerSessionRow.t),
      updateColumns: updateColumns?.call(HayerSessionRow.t),
      updateWhere: updateWhere?.call(HayerSessionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [HayerSessionRow] and returns the resulting row.
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
  /// The returned [HayerSessionRow] will have its `id` field set.
  Future<HayerSessionRow?> upsertRow(
    _is.DatabaseSession session,
    HayerSessionRow row, {
    required _is.ColumnSelections<HayerSessionRowTable> conflictColumns,
    _is.ColumnSelections<HayerSessionRowTable>? updateColumns,
    _is.WhereExpressionBuilder<HayerSessionRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<HayerSessionRow>(
      row,
      conflictColumns: conflictColumns(HayerSessionRow.t),
      updateColumns: updateColumns?.call(HayerSessionRow.t),
      updateWhere: updateWhere?.call(HayerSessionRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [HayerSessionRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HayerSessionRow>> update(
    _is.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _is.ColumnSelections<HayerSessionRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<HayerSessionRow>(
      rows,
      columns: columns?.call(HayerSessionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [HayerSessionRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<HayerSessionRow> updateRow(
    _is.DatabaseSession session,
    HayerSessionRow row, {
    _is.ColumnSelections<HayerSessionRowTable>? columns,
    _is.Transaction? transaction,
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
    _is.DatabaseSession session,
    _is.UuidValue id, {
    required _is.ColumnValueListBuilder<HayerSessionRowUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<HayerSessionRow>(
      id,
      columnValues: columnValues(HayerSessionRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [HayerSessionRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<HayerSessionRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<HayerSessionRowUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<HayerSessionRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<HayerSessionRow>(
      columnValues: columnValues(HayerSessionRow.t.updateTable),
      where: where(HayerSessionRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [HayerSessionRow]s in the list and returns the deleted rows.
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
  Future<List<HayerSessionRow>> delete(
    _is.DatabaseSession session,
    List<HayerSessionRow> rows, {
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<HayerSessionRow>(
      rows,
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [HayerSessionRow].
  Future<HayerSessionRow> deleteRow(
    _is.DatabaseSession session,
    HayerSessionRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<HayerSessionRow>(
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
  Future<List<HayerSessionRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HayerSessionRowTable> where,
    _is.OrderByBuilder<HayerSessionRowTable>? orderBy,
    _is.OrderByListBuilder<HayerSessionRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<HayerSessionRow>(
      where: where(HayerSessionRow.t),
      orderBy: orderBy?.call(HayerSessionRow.t),
      orderByList: orderByList?.call(HayerSessionRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<HayerSessionRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<HayerSessionRow>(
      where: where?.call(HayerSessionRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [HayerSessionRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<HayerSessionRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<HayerSessionRow>(
      where: where(HayerSessionRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
