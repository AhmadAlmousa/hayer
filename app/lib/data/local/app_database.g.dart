// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PendingSwipesTable extends PendingSwipes
    with TableInfo<$PendingSwipesTable, PendingSwipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSwipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<String> placeId = GeneratedColumn<String>(
    'place_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likedMeta = const VerificationMeta('liked');
  @override
  late final GeneratedColumn<bool> liked = GeneratedColumn<bool>(
    'liked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("liked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _swipeIndexMeta = const VerificationMeta(
    'swipeIndex',
  );
  @override
  late final GeneratedColumn<int> swipeIndex = GeneratedColumn<int>(
    'swipe_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientSwipedAtMeta = const VerificationMeta(
    'clientSwipedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientSwipedAt =
      GeneratedColumn<DateTime>(
        'client_swiped_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _terminalErrorCodeMeta = const VerificationMeta(
    'terminalErrorCode',
  );
  @override
  late final GeneratedColumn<String> terminalErrorCode =
      GeneratedColumn<String>(
        'terminal_error_code',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    idempotencyKey,
    sessionId,
    placeId,
    liked,
    swipeIndex,
    clientSwipedAt,
    terminalErrorCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_swipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingSwipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('liked')) {
      context.handle(
        _likedMeta,
        liked.isAcceptableOrUnknown(data['liked']!, _likedMeta),
      );
    } else if (isInserting) {
      context.missing(_likedMeta);
    }
    if (data.containsKey('swipe_index')) {
      context.handle(
        _swipeIndexMeta,
        swipeIndex.isAcceptableOrUnknown(data['swipe_index']!, _swipeIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_swipeIndexMeta);
    }
    if (data.containsKey('client_swiped_at')) {
      context.handle(
        _clientSwipedAtMeta,
        clientSwipedAt.isAcceptableOrUnknown(
          data['client_swiped_at']!,
          _clientSwipedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientSwipedAtMeta);
    }
    if (data.containsKey('terminal_error_code')) {
      context.handle(
        _terminalErrorCodeMeta,
        terminalErrorCode.isAcceptableOrUnknown(
          data['terminal_error_code']!,
          _terminalErrorCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idempotencyKey};
  @override
  PendingSwipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSwipe(
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_id'],
      )!,
      liked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}liked'],
      )!,
      swipeIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}swipe_index'],
      )!,
      clientSwipedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_swiped_at'],
      )!,
      terminalErrorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terminal_error_code'],
      ),
    );
  }

  @override
  $PendingSwipesTable createAlias(String alias) {
    return $PendingSwipesTable(attachedDatabase, alias);
  }
}

class PendingSwipe extends DataClass implements Insertable<PendingSwipe> {
  final String idempotencyKey;
  final String sessionId;
  final String placeId;
  final bool liked;
  final int swipeIndex;
  final DateTime clientSwipedAt;
  final String? terminalErrorCode;
  const PendingSwipe({
    required this.idempotencyKey,
    required this.sessionId,
    required this.placeId,
    required this.liked,
    required this.swipeIndex,
    required this.clientSwipedAt,
    this.terminalErrorCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['session_id'] = Variable<String>(sessionId);
    map['place_id'] = Variable<String>(placeId);
    map['liked'] = Variable<bool>(liked);
    map['swipe_index'] = Variable<int>(swipeIndex);
    map['client_swiped_at'] = Variable<DateTime>(clientSwipedAt);
    if (!nullToAbsent || terminalErrorCode != null) {
      map['terminal_error_code'] = Variable<String>(terminalErrorCode);
    }
    return map;
  }

  PendingSwipesCompanion toCompanion(bool nullToAbsent) {
    return PendingSwipesCompanion(
      idempotencyKey: Value(idempotencyKey),
      sessionId: Value(sessionId),
      placeId: Value(placeId),
      liked: Value(liked),
      swipeIndex: Value(swipeIndex),
      clientSwipedAt: Value(clientSwipedAt),
      terminalErrorCode: terminalErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(terminalErrorCode),
    );
  }

  factory PendingSwipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSwipe(
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      placeId: serializer.fromJson<String>(json['placeId']),
      liked: serializer.fromJson<bool>(json['liked']),
      swipeIndex: serializer.fromJson<int>(json['swipeIndex']),
      clientSwipedAt: serializer.fromJson<DateTime>(json['clientSwipedAt']),
      terminalErrorCode: serializer.fromJson<String?>(
        json['terminalErrorCode'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'sessionId': serializer.toJson<String>(sessionId),
      'placeId': serializer.toJson<String>(placeId),
      'liked': serializer.toJson<bool>(liked),
      'swipeIndex': serializer.toJson<int>(swipeIndex),
      'clientSwipedAt': serializer.toJson<DateTime>(clientSwipedAt),
      'terminalErrorCode': serializer.toJson<String?>(terminalErrorCode),
    };
  }

  PendingSwipe copyWith({
    String? idempotencyKey,
    String? sessionId,
    String? placeId,
    bool? liked,
    int? swipeIndex,
    DateTime? clientSwipedAt,
    Value<String?> terminalErrorCode = const Value.absent(),
  }) => PendingSwipe(
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    sessionId: sessionId ?? this.sessionId,
    placeId: placeId ?? this.placeId,
    liked: liked ?? this.liked,
    swipeIndex: swipeIndex ?? this.swipeIndex,
    clientSwipedAt: clientSwipedAt ?? this.clientSwipedAt,
    terminalErrorCode: terminalErrorCode.present
        ? terminalErrorCode.value
        : this.terminalErrorCode,
  );
  PendingSwipe copyWithCompanion(PendingSwipesCompanion data) {
    return PendingSwipe(
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      liked: data.liked.present ? data.liked.value : this.liked,
      swipeIndex: data.swipeIndex.present
          ? data.swipeIndex.value
          : this.swipeIndex,
      clientSwipedAt: data.clientSwipedAt.present
          ? data.clientSwipedAt.value
          : this.clientSwipedAt,
      terminalErrorCode: data.terminalErrorCode.present
          ? data.terminalErrorCode.value
          : this.terminalErrorCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSwipe(')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('sessionId: $sessionId, ')
          ..write('placeId: $placeId, ')
          ..write('liked: $liked, ')
          ..write('swipeIndex: $swipeIndex, ')
          ..write('clientSwipedAt: $clientSwipedAt, ')
          ..write('terminalErrorCode: $terminalErrorCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idempotencyKey,
    sessionId,
    placeId,
    liked,
    swipeIndex,
    clientSwipedAt,
    terminalErrorCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSwipe &&
          other.idempotencyKey == this.idempotencyKey &&
          other.sessionId == this.sessionId &&
          other.placeId == this.placeId &&
          other.liked == this.liked &&
          other.swipeIndex == this.swipeIndex &&
          other.clientSwipedAt == this.clientSwipedAt &&
          other.terminalErrorCode == this.terminalErrorCode);
}

class PendingSwipesCompanion extends UpdateCompanion<PendingSwipe> {
  final Value<String> idempotencyKey;
  final Value<String> sessionId;
  final Value<String> placeId;
  final Value<bool> liked;
  final Value<int> swipeIndex;
  final Value<DateTime> clientSwipedAt;
  final Value<String?> terminalErrorCode;
  final Value<int> rowid;
  const PendingSwipesCompanion({
    this.idempotencyKey = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.placeId = const Value.absent(),
    this.liked = const Value.absent(),
    this.swipeIndex = const Value.absent(),
    this.clientSwipedAt = const Value.absent(),
    this.terminalErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingSwipesCompanion.insert({
    required String idempotencyKey,
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    required DateTime clientSwipedAt,
    this.terminalErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idempotencyKey = Value(idempotencyKey),
       sessionId = Value(sessionId),
       placeId = Value(placeId),
       liked = Value(liked),
       swipeIndex = Value(swipeIndex),
       clientSwipedAt = Value(clientSwipedAt);
  static Insertable<PendingSwipe> custom({
    Expression<String>? idempotencyKey,
    Expression<String>? sessionId,
    Expression<String>? placeId,
    Expression<bool>? liked,
    Expression<int>? swipeIndex,
    Expression<DateTime>? clientSwipedAt,
    Expression<String>? terminalErrorCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (sessionId != null) 'session_id': sessionId,
      if (placeId != null) 'place_id': placeId,
      if (liked != null) 'liked': liked,
      if (swipeIndex != null) 'swipe_index': swipeIndex,
      if (clientSwipedAt != null) 'client_swiped_at': clientSwipedAt,
      if (terminalErrorCode != null) 'terminal_error_code': terminalErrorCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingSwipesCompanion copyWith({
    Value<String>? idempotencyKey,
    Value<String>? sessionId,
    Value<String>? placeId,
    Value<bool>? liked,
    Value<int>? swipeIndex,
    Value<DateTime>? clientSwipedAt,
    Value<String?>? terminalErrorCode,
    Value<int>? rowid,
  }) {
    return PendingSwipesCompanion(
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      sessionId: sessionId ?? this.sessionId,
      placeId: placeId ?? this.placeId,
      liked: liked ?? this.liked,
      swipeIndex: swipeIndex ?? this.swipeIndex,
      clientSwipedAt: clientSwipedAt ?? this.clientSwipedAt,
      terminalErrorCode: terminalErrorCode ?? this.terminalErrorCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<String>(placeId.value);
    }
    if (liked.present) {
      map['liked'] = Variable<bool>(liked.value);
    }
    if (swipeIndex.present) {
      map['swipe_index'] = Variable<int>(swipeIndex.value);
    }
    if (clientSwipedAt.present) {
      map['client_swiped_at'] = Variable<DateTime>(clientSwipedAt.value);
    }
    if (terminalErrorCode.present) {
      map['terminal_error_code'] = Variable<String>(terminalErrorCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSwipesCompanion(')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('sessionId: $sessionId, ')
          ..write('placeId: $placeId, ')
          ..write('liked: $liked, ')
          ..write('swipeIndex: $swipeIndex, ')
          ..write('clientSwipedAt: $clientSwipedAt, ')
          ..write('terminalErrorCode: $terminalErrorCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PendingSwipesTable pendingSwipes = $PendingSwipesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pendingSwipes];
}

typedef $$PendingSwipesTableCreateCompanionBuilder =
    PendingSwipesCompanion Function({
      required String idempotencyKey,
      required String sessionId,
      required String placeId,
      required bool liked,
      required int swipeIndex,
      required DateTime clientSwipedAt,
      Value<String?> terminalErrorCode,
      Value<int> rowid,
    });
typedef $$PendingSwipesTableUpdateCompanionBuilder =
    PendingSwipesCompanion Function({
      Value<String> idempotencyKey,
      Value<String> sessionId,
      Value<String> placeId,
      Value<bool> liked,
      Value<int> swipeIndex,
      Value<DateTime> clientSwipedAt,
      Value<String?> terminalErrorCode,
      Value<int> rowid,
    });

class $$PendingSwipesTableFilterComposer
    extends Composer<_$AppDatabase, $PendingSwipesTable> {
  $$PendingSwipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get liked => $composableBuilder(
    column: $table.liked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get swipeIndex => $composableBuilder(
    column: $table.swipeIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientSwipedAt => $composableBuilder(
    column: $table.clientSwipedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get terminalErrorCode => $composableBuilder(
    column: $table.terminalErrorCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingSwipesTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingSwipesTable> {
  $$PendingSwipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeId => $composableBuilder(
    column: $table.placeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get liked => $composableBuilder(
    column: $table.liked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get swipeIndex => $composableBuilder(
    column: $table.swipeIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientSwipedAt => $composableBuilder(
    column: $table.clientSwipedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get terminalErrorCode => $composableBuilder(
    column: $table.terminalErrorCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingSwipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingSwipesTable> {
  $$PendingSwipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get placeId =>
      $composableBuilder(column: $table.placeId, builder: (column) => column);

  GeneratedColumn<bool> get liked =>
      $composableBuilder(column: $table.liked, builder: (column) => column);

  GeneratedColumn<int> get swipeIndex => $composableBuilder(
    column: $table.swipeIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientSwipedAt => $composableBuilder(
    column: $table.clientSwipedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get terminalErrorCode => $composableBuilder(
    column: $table.terminalErrorCode,
    builder: (column) => column,
  );
}

class $$PendingSwipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingSwipesTable,
          PendingSwipe,
          $$PendingSwipesTableFilterComposer,
          $$PendingSwipesTableOrderingComposer,
          $$PendingSwipesTableAnnotationComposer,
          $$PendingSwipesTableCreateCompanionBuilder,
          $$PendingSwipesTableUpdateCompanionBuilder,
          (
            PendingSwipe,
            BaseReferences<_$AppDatabase, $PendingSwipesTable, PendingSwipe>,
          ),
          PendingSwipe,
          PrefetchHooks Function()
        > {
  $$PendingSwipesTableTableManager(_$AppDatabase db, $PendingSwipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSwipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingSwipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingSwipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> placeId = const Value.absent(),
                Value<bool> liked = const Value.absent(),
                Value<int> swipeIndex = const Value.absent(),
                Value<DateTime> clientSwipedAt = const Value.absent(),
                Value<String?> terminalErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingSwipesCompanion(
                idempotencyKey: idempotencyKey,
                sessionId: sessionId,
                placeId: placeId,
                liked: liked,
                swipeIndex: swipeIndex,
                clientSwipedAt: clientSwipedAt,
                terminalErrorCode: terminalErrorCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idempotencyKey,
                required String sessionId,
                required String placeId,
                required bool liked,
                required int swipeIndex,
                required DateTime clientSwipedAt,
                Value<String?> terminalErrorCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingSwipesCompanion.insert(
                idempotencyKey: idempotencyKey,
                sessionId: sessionId,
                placeId: placeId,
                liked: liked,
                swipeIndex: swipeIndex,
                clientSwipedAt: clientSwipedAt,
                terminalErrorCode: terminalErrorCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingSwipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingSwipesTable,
      PendingSwipe,
      $$PendingSwipesTableFilterComposer,
      $$PendingSwipesTableOrderingComposer,
      $$PendingSwipesTableAnnotationComposer,
      $$PendingSwipesTableCreateCompanionBuilder,
      $$PendingSwipesTableUpdateCompanionBuilder,
      (
        PendingSwipe,
        BaseReferences<_$AppDatabase, $PendingSwipesTable, PendingSwipe>,
      ),
      PendingSwipe,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PendingSwipesTableTableManager get pendingSwipes =>
      $$PendingSwipesTableTableManager(_db, _db.pendingSwipes);
}
