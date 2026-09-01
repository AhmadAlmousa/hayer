import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../places/catalog_place_service.dart';
import '../places/place_services.dart';
import '../places/place_source.dart';
import '../places/taxonomy.dart';
import '../sessions/consensus.dart';
import '../sessions/session_mapper.dart';
import '../security/rate_limiter.dart';

class HayerSessionEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _uuid = Uuid();
  static const _codeAlphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  Future<SessionBundle> create(
    Session session, {
    required CreateSessionRequest request,
    required String idempotencyKey,
  }) async {
    final userId = _userId(session);
    await RateLimiter.check(
      session,
      operation: 'session-create',
      subject: userId,
      limit: 10,
      window: const Duration(hours: 1),
    );
    _validateCreate(request, idempotencyKey);
    final requestHash = sha256
        .convert(utf8.encode(jsonEncode(request.toJsonForProtocol())))
        .toString();
    final existingKey = await IdempotencyRow.db.findFirstRow(
      session,
      where: (table) =>
          table.scope.equals('create-session') &
          table.userId.equals(userId) &
          table.idempotencyKey.equals(idempotencyKey),
    );
    if (existingKey != null) {
      if (existingKey.requestHash != requestHash) {
        throw ApiException(
          code: 'conflict',
          message: 'This retry key was already used for a different request.',
        );
      }
      return _loadById(session, existingKey.responseId, userId: userId);
    }

    final countryCode = _countryFor(
      request.anchorLatitude,
      request.anchorLongitude,
    );
    if (countryCode == null) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Hayer currently supports locations in GCC countries only.',
      );
    }
    late final List<PlaceSnapshot> deck;
    try {
      final services = await PlaceServices.forSession(session);
      deck =
          await CatalogPlaceService(
            source: services.source,
            calibrationVersion: services.calibration.version,
          ).buildDeck(
            session,
            categoryId: request.categoryId,
            subcategoryIds: request.subcategoryIds,
            latitude: request.anchorLatitude,
            longitude: request.anchorLongitude,
            radiusMeters: request.radiusMeters,
            deckSize: request.deckSize,
            maximumPriceLevel: request.priceLevel,
            countryCode: countryCode,
          );
    } on PlaceSourceException catch (error) {
      throw ApiException(
        code: error.code,
        message: error.message,
      );
    }
    if (deck.isEmpty) {
      throw ApiException(
        code: 'no_places',
        message:
            'No eligible places were found. Try a larger radius or broader category.',
      );
    }
    final now = DateTime.now().toUtc();
    final sessionId = _uuid.v7();
    final participantId = _uuid.v7();
    final code = await _unusedCode(session);
    final displayName = _displayName(request.displayName, fallback: 'Host');

    await session.db.transaction((transaction) async {
      await HayerSessionRow.db.insertRow(
        session,
        HayerSessionRow(
          sessionId: sessionId,
          code: code,
          hostUserId: userId,
          mode: request.mode,
          categoryId: request.categoryId,
          subcategoryIds: request.subcategoryIds,
          priceLevel: request.priceLevel,
          anchorLatitude: request.anchorLatitude,
          anchorLongitude: request.anchorLongitude,
          anchorAddress: request.anchorAddress?.trim(),
          countryCode: countryCode,
          radiusMeters: request.radiusMeters,
          deckSizeRequested: request.deckSize,
          deckSizeActual: deck.length,
          consensusRule: request.consensusRule,
          matchingTiming: request.matchingTiming,
          status: SessionStatus.active,
          revision: 1,
          freshnessWarning: deck.any((place) => place.isStale)
              ? 'Some place details may be out of date.'
              : null,
          createdAt: now,
          expiresAt: now.add(const Duration(hours: 24)),
        ),
        transaction: transaction,
      );
      await ParticipantRow.db.insertRow(
        session,
        ParticipantRow(
          participantId: participantId,
          sessionId: sessionId,
          userId: userId,
          displayName: displayName,
          normalizedName: _normalizeName(displayName),
          isHost: true,
          currentIndex: 0,
          hasCompleted: false,
          lastSeenAt: now,
        ),
        transaction: transaction,
      );
      await SessionPlaceRow.db.insert(
        session,
        [
          for (var index = 0; index < deck.length; index++)
            SessionPlaceRow(
              sessionId: sessionId,
              placeId: deck[index].placeId,
              deckOrder: index,
              snapshot: deck[index],
            ),
        ],
        transaction: transaction,
      );
      await IdempotencyRow.db.insertRow(
        session,
        IdempotencyRow(
          scope: 'create-session',
          userId: userId,
          idempotencyKey: idempotencyKey,
          requestHash: requestHash,
          responseId: sessionId,
          createdAt: now,
          expiresAt: now.add(const Duration(hours: 24)),
        ),
        transaction: transaction,
      );
    });
    return _loadById(session, sessionId, userId: userId);
  }

  Future<SessionBundle> join(
    Session session, {
    required String code,
    required String displayName,
  }) async {
    final userId = _userId(session);
    await RateLimiter.check(
      session,
      operation: 'session-join',
      subject: userId,
      limit: 30,
      window: const Duration(minutes: 1),
    );
    final normalizedCode = code.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9]'),
      '',
    );
    if (normalizedCode.length != 6) {
      throw ApiException(
        code: 'bad_request',
        message: 'Enter a valid six-character code.',
      );
    }
    final name = _displayName(displayName);
    final now = DateTime.now().toUtc();
    final row = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.code.equals(normalizedCode),
    );
    if (row == null) {
      throw ApiException(
        code: 'invalid_code',
        message: 'That session could not be found.',
      );
    }
    _ensureActive(row, now);
    if (row.mode == SessionMode.solo) {
      throw ApiException(
        code: 'forbidden',
        message: 'Solo sessions cannot be joined.',
      );
    }
    final existing = await ParticipantRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(row.sessionId) & table.userId.equals(userId),
    );
    var joined = false;
    var revision = row.revision;
    if (existing == null) {
      await session.db.transaction((transaction) async {
        final lockedSession = await HayerSessionRow.db.findFirstRow(
          session,
          where: (table) => table.sessionId.equals(row.sessionId),
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (lockedSession == null) {
          throw ApiException(
            code: 'invalid_code',
            message: 'That session could not be found.',
          );
        }
        _ensureActive(lockedSession, DateTime.now().toUtc());
        final membership = await ParticipantRow.db.findFirstRow(
          session,
          where: (table) =>
              table.sessionId.equals(lockedSession.sessionId) &
              table.userId.equals(userId),
          transaction: transaction,
        );
        if (membership != null) return;
        final duplicateName = await ParticipantRow.db.findFirstRow(
          session,
          where: (table) =>
              table.sessionId.equals(lockedSession.sessionId) &
              table.normalizedName.equals(_normalizeName(name)),
          transaction: transaction,
        );
        if (duplicateName != null) {
          throw ApiException(
            code: 'name_taken',
            message: 'That display name is already in use.',
          );
        }
        final participantCount = await ParticipantRow.db.count(
          session,
          where: (table) => table.sessionId.equals(lockedSession.sessionId),
          transaction: transaction,
        );
        if (participantCount >= 12) {
          throw ApiException(
            code: 'session_full',
            message: 'This session already has 12 participants.',
          );
        }
        await ParticipantRow.db.insertRow(
          session,
          ParticipantRow(
            participantId: _uuid.v7(),
            sessionId: lockedSession.sessionId,
            userId: userId,
            displayName: name,
            normalizedName: _normalizeName(name),
            isHost: false,
            currentIndex: 0,
            hasCompleted: false,
            lastSeenAt: now,
          ),
          transaction: transaction,
        );
        lockedSession.revision++;
        revision = lockedSession.revision;
        joined = true;
        await HayerSessionRow.db.updateRow(
          session,
          lockedSession,
          transaction: transaction,
        );
      });
    }
    if (joined) {
      await _notify(
        session,
        row.sessionId,
        SessionEventType.participantsChanged,
        revision,
      );
    }
    return _loadById(session, row.sessionId, userId: userId);
  }

  Future<SessionBundle> load(
    Session session, {
    required String sessionId,
  }) => _loadById(session, sessionId, userId: _userId(session));

  Future<SessionBundle> swipe(
    Session session, {
    required SwipeCommand command,
  }) async {
    final userId = _userId(session);
    await RateLimiter.check(
      session,
      operation: 'session-swipe',
      subject: userId,
      limit: 180,
      window: const Duration(minutes: 1),
    );
    final now = DateTime.now().toUtc();
    var event = SessionEventType.progressChanged;
    var revision = 0;
    await session.db.transaction((transaction) async {
      final row = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(command.sessionId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (row == null) {
        throw ApiException(code: 'not_found', message: 'Session not found.');
      }
      _ensureActive(row, now);
      final participant = await ParticipantRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(row.sessionId) & table.userId.equals(userId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (participant == null) {
        throw ApiException(
          code: 'forbidden',
          message: 'Join the session before swiping.',
        );
      }
      final place = await SessionPlaceRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(row.sessionId) &
            table.placeId.equals(command.placeId),
        transaction: transaction,
      );
      if (place == null || place.deckOrder != command.swipeIndex) {
        throw ApiException(
          code: 'bad_request',
          message: 'That card is not part of this deck position.',
        );
      }
      final already = await SwipeRow.db.findFirstRow(
        session,
        where: (table) =>
            table.sessionId.equals(row.sessionId) &
            table.userId.equals(userId) &
            table.placeId.equals(command.placeId),
        transaction: transaction,
      );
      if (already != null) {
        if (already.liked != command.liked ||
            already.swipeIndex != command.swipeIndex) {
          throw ApiException(
            code: 'conflict',
            message: 'This card was already swiped differently.',
          );
        }
        return;
      }
      if (command.swipeIndex != participant.currentIndex) {
        throw ApiException(
          code: 'conflict',
          message: 'Your deck progress changed. Reload and try again.',
        );
      }
      await SwipeRow.db.insertRow(
        session,
        SwipeRow(
          sessionId: row.sessionId,
          userId: userId,
          placeId: command.placeId,
          liked: command.liked,
          swipeIndex: command.swipeIndex,
          clientSwipedAt: command.clientSwipedAt.toUtc(),
          serverReceivedAt: now,
          idempotencyKey: command.idempotencyKey,
        ),
        transaction: transaction,
      );
      participant.currentIndex++;
      participant.hasCompleted = participant.currentIndex >= row.deckSizeActual;
      participant.lastSeenAt = now;
      await ParticipantRow.db.updateRow(
        session,
        participant,
        transaction: transaction,
      );

      if (row.matchingTiming == MatchingTiming.instant && command.liked) {
        final placeSwipes = await SwipeRow.db.find(
          session,
          where: (table) =>
              table.sessionId.equals(row.sessionId) &
              table.placeId.equals(command.placeId),
          transaction: transaction,
        );
        final tally = VoteTally(
          likes: placeSwipes.where((swipe) => swipe.liked).length,
          voters: placeSwipes.length,
        );
        final eligible = row.mode == SessionMode.solo || tally.voters >= 2;
        if (eligible && Consensus.isMatch(row.consensusRule, tally)) {
          row.status = SessionStatus.completed;
          row.matchedPlaceId = command.placeId;
          event = SessionEventType.matched;
        }
      }
      if (row.status == SessionStatus.active &&
          row.matchingTiming == MatchingTiming.afterDeck) {
        final participants = await ParticipantRow.db.find(
          session,
          where: (table) => table.sessionId.equals(row.sessionId),
          transaction: transaction,
        );
        if (participants.isNotEmpty &&
            participants.every((item) => item.hasCompleted)) {
          row.status = SessionStatus.completed;
          event = SessionEventType.resultsChanged;
        }
      }
      row.revision++;
      revision = row.revision;
      await HayerSessionRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      );
    });
    await _notify(session, command.sessionId, event, revision);
    return _loadById(session, command.sessionId, userId: userId);
  }

  Future<List<SessionResult>> results(
    Session session, {
    required String sessionId,
  }) async {
    final userId = _userId(session);
    final bundle = await _loadById(session, sessionId, userId: userId);
    final row = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    final swipes = await SwipeRow.db.find(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    final values = bundle.deck.map((place) {
      final votes = swipes
          .where((swipe) => swipe.placeId == place.placeId)
          .toList();
      final likes = votes.where((swipe) => swipe.liked).length;
      return SessionResult(
        place: place,
        likeCount: likes,
        voterCount: votes.length,
        match: Consensus.isMatch(
          row!.consensusRule,
          VoteTally(likes: likes, voters: votes.length),
        ),
        rank: 0,
      );
    }).toList();
    values.sort((a, b) {
      var result = b.match.toString().compareTo(a.match.toString());
      if (result != 0) return result;
      final ratioA = a.voterCount == 0 ? 0 : a.likeCount / a.voterCount;
      final ratioB = b.voterCount == 0 ? 0 : b.likeCount / b.voterCount;
      result = ratioB.compareTo(ratioA);
      if (result != 0) return result;
      result = b.likeCount.compareTo(a.likeCount);
      if (result != 0) return result;
      result = (b.place.reviewCount ?? -1).compareTo(a.place.reviewCount ?? -1);
      if (result != 0) return result;
      return (b.place.rating ?? -1).compareTo(a.place.rating ?? -1);
    });
    return [
      for (var index = 0; index < values.length; index++)
        values[index].copyWith(rank: index + 1),
    ];
  }

  Stream<SessionEvent> watch(
    Session session, {
    required String sessionId,
  }) async* {
    await _requireMembership(session, sessionId, _userId(session));
    yield* session.messages.createStream<SessionEvent>(_channel(sessionId));
  }

  Future<SessionBundle> _loadById(
    Session session,
    String sessionId, {
    required String userId,
  }) async {
    final row = await HayerSessionRow.db.findFirstRow(
      session,
      where: (table) => table.sessionId.equals(sessionId),
    );
    if (row == null) {
      throw ApiException(code: 'not_found', message: 'Session not found.');
    }
    final participant = await _requireMembership(session, sessionId, userId);
    final now = DateTime.now().toUtc();
    if (row.expiresAt.isBefore(now) && row.status != SessionStatus.expired) {
      row.status = SessionStatus.expired;
      row.revision++;
      await HayerSessionRow.db.updateRow(session, row);
    }
    participant.lastSeenAt = now;
    await ParticipantRow.db.updateRow(session, participant);
    final placeRows = await SessionPlaceRow.db.find(
      session,
      where: (table) => table.sessionId.equals(sessionId),
      orderBy: (table) => table.deckOrder,
    );
    final participants = await ParticipantRow.db.find(
      session,
      where: (table) => table.sessionId.equals(sessionId),
      orderBy: (table) => table.isHost,
      orderDescending: true,
    );
    return SessionBundle(
      session: SessionMapper.session(row),
      deck: placeRows.map((place) => place.snapshot).toList(growable: false),
      participants: participants
          .map(SessionMapper.participant)
          .toList(growable: false),
    );
  }

  Future<ParticipantRow> _requireMembership(
    Session session,
    String sessionId,
    String userId,
  ) async {
    final row = await ParticipantRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.userId.equals(userId),
    );
    if (row == null) {
      throw ApiException(
        code: 'forbidden',
        message: 'You are not a member of this session.',
      );
    }
    return row;
  }

  Future<String> _unusedCode(Session session) async {
    final random = Random.secure();
    for (var attempt = 0; attempt < 8; attempt++) {
      final value = List.generate(
        6,
        (_) => _codeAlphabet[random.nextInt(_codeAlphabet.length)],
      ).join();
      final existing = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.code.equals(value),
      );
      if (existing == null) return value;
    }
    throw ApiException(
      code: 'server_error',
      message: 'Could not allocate a session code.',
    );
  }

  void _validateCreate(CreateSessionRequest request, String idempotencyKey) {
    try {
      PlaceTaxonomy.resolve(request.categoryId, request.subcategoryIds);
    } on ArgumentError {
      throw ApiException(
        code: 'bad_request',
        message: 'The selected category is invalid.',
      );
    }
    if (!request.anchorLatitude.isFinite ||
        !request.anchorLongitude.isFinite ||
        request.anchorLatitude < -90 ||
        request.anchorLatitude > 90 ||
        request.anchorLongitude < -180 ||
        request.anchorLongitude > 180) {
      throw ApiException(
        code: 'bad_request',
        message: 'The search location is invalid.',
      );
    }
    if (!const {500, 1000, 3000, 5000, 10000}.contains(
      request.radiusMeters,
    )) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Choose a supported search radius.',
      );
    }
    if (!const {10, 20, 30, 40, 50}.contains(request.deckSize)) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Choose a supported deck size.',
      );
    }
    if (request.priceLevel != null &&
        (request.priceLevel! < 1 || request.priceLevel! > 4)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Price level is invalid.',
      );
    }
    if (idempotencyKey.length < 8 || idempotencyKey.length > 128) {
      throw ApiException(code: 'bad_request', message: 'Retry key is invalid.');
    }
  }

  void _ensureActive(HayerSessionRow row, DateTime now) {
    if (row.expiresAt.isBefore(now) || row.status == SessionStatus.expired) {
      throw ApiException(
        code: 'session_expired',
        message: 'This session has expired.',
      );
    }
    if (row.status != SessionStatus.active) {
      throw ApiException(
        code: 'conflict',
        message: 'This session is already complete.',
      );
    }
  }

  String _userId(Session session) {
    final value = session.authenticated?.userIdentifier;
    if (value == null) {
      throw ApiException(code: 'unauthorized', message: 'Sign in is required.');
    }
    return value;
  }

  String _displayName(String? value, {String? fallback}) {
    final name =
        value?.trim().replaceAll(RegExp(r'\s+'), ' ') ?? fallback ?? '';
    if (name.length < 2 || name.length > 30) {
      throw ApiException(
        code: 'bad_request',
        message: 'Display name must be 2–30 characters.',
      );
    }
    return name;
  }

  String _normalizeName(String value) => value.toLowerCase().trim();

  String? _countryFor(double latitude, double longitude) {
    if (latitude >= 28.3 &&
        latitude <= 30.2 &&
        longitude >= 46.2 &&
        longitude <= 48.8) {
      return 'KW';
    }
    if (latitude >= 24.3 &&
        latitude <= 26.3 &&
        longitude >= 50.6 &&
        longitude <= 52.0) {
      return 'QA';
    }
    if (latitude >= 25.5 &&
        latitude <= 26.4 &&
        longitude >= 50.3 &&
        longitude <= 51.0) {
      return 'BH';
    }
    if (latitude >= 22.5 &&
        latitude <= 26.5 &&
        longitude >= 50.5 &&
        longitude <= 56.5) {
      return 'AE';
    }
    if (latitude >= 16.5 &&
        latitude <= 26.5 &&
        longitude >= 51.5 &&
        longitude <= 60.0) {
      return 'OM';
    }
    if (latitude >= 16.0 &&
        latitude <= 32.3 &&
        longitude >= 34.4 &&
        longitude <= 55.7) {
      return 'SA';
    }
    return null;
  }

  Future<void> _notify(
    Session session,
    String sessionId,
    SessionEventType type,
    int revision,
  ) async {
    await session.messages.postMessage(
      _channel(sessionId),
      SessionEvent(
        sessionId: sessionId,
        type: type,
        revision: revision,
        occurredAt: DateTime.now().toUtc(),
      ),
      global: false,
    );
  }

  String _channel(String sessionId) => 'hayer.session.$sessionId';
}
