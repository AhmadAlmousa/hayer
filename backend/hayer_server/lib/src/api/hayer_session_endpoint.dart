import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../analytics/product_analytics.dart';
import '../generated/protocol.dart';
import '../places/catalog_place_service.dart';
import '../places/city_resolution_service.dart';
import '../places/place_services.dart';
import '../places/place_availability.dart';
import '../places/place_source.dart';
import '../places/taxonomy_service.dart';
import '../places/route_estimate_policy_service.dart';
import '../sessions/consensus.dart';
import '../sessions/destination_choices.dart';
import '../sessions/session_code.dart';
import '../sessions/session_mapper.dart';
import '../security/rate_limiter.dart';

class HayerSessionEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _uuid = Uuid();
  static const _clientAnalyticsMetrics = {
    AnalyticsMetric.journeyStarted,
    AnalyticsMetric.cardImpression,
    AnalyticsMetric.placeDetailsOpened,
    AnalyticsMetric.resultsViewed,
    AnalyticsMetric.outboxQueued,
    AnalyticsMetric.syncRecovered,
    AnalyticsMetric.syncTerminalFailure,
  };

  Future<SessionBundle> create(
    Session session, {
    required CreateSessionRequest request,
    required String idempotencyKey,
  }) async {
    final userId = _userId(session);
    _validateAnalyticsContext(request.analyticsContext);
    await RateLimiter.check(
      session,
      operation: 'session-create',
      subject: userId,
      limit: 10,
      window: const Duration(hours: 1),
    );
    await _validateCreate(session, request, idempotencyKey);
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
    final cityFuture = CityResolutionService.resolve(
      session,
      latitude: request.anchorLatitude,
      longitude: request.anchorLongitude,
      countryCode: countryCode,
    );
    final shortlistIds = request.shortlistPlaceIds ?? const <String>[];
    final freshDiscoveryCount = request.freshDiscoveryCount ?? 0;
    final targetDeckSize = shortlistIds.isEmpty
        ? request.deckSize
        : shortlistIds.length + freshDiscoveryCount;
    var shortlist = const <PlaceSnapshot>[];
    late final List<PlaceSnapshot> candidates;
    try {
      final services = await PlaceServices.forSession(session);
      final catalog = CatalogPlaceService(
        source: services.source,
        calibrationVersion: services.calibration.version,
      );
      if (shortlistIds.isNotEmpty) {
        shortlist = await catalog.resolveShortlist(
          session,
          placeIds: shortlistIds,
          latitude: request.anchorLatitude,
          longitude: request.anchorLongitude,
          radiusMeters: request.radiusMeters,
          maximumPriceLevel: request.priceLevel,
          countryCode: countryCode,
        );
        if (shortlist.length != shortlistIds.length) {
          throw ApiException(
            code: 'shortlist_unavailable',
            message: 'Some saved places are no longer eligible for this room.',
          );
        }
      }
      final requestedFresh = shortlistIds.isEmpty
          ? request.deckSize
          : freshDiscoveryCount;
      final baseCandidateCount = shortlistIds.isEmpty
          ? requestedFresh
          : min(50, requestedFresh + shortlistIds.length);
      final candidateCount = request.visitAt == null
          ? baseCandidateCount
          : min(
              50,
              max(baseCandidateCount * 3, baseCandidateCount + 10),
            );
      final fresh = requestedFresh == 0
          ? const <PlaceSnapshot>[]
          : await catalog.buildDeck(
              session,
              categoryId: request.categoryId,
              subcategoryIds: request.subcategoryIds,
              latitude: request.anchorLatitude,
              longitude: request.anchorLongitude,
              radiusMeters: request.radiusMeters,
              deckSize: candidateCount,
              maximumPriceLevel: request.priceLevel,
              countryCode: countryCode,
            );
      final shortlistedIds = shortlistIds.toSet();
      candidates = [
        ...shortlist,
        ...fresh.where((place) => !shortlistedIds.contains(place.placeId)),
      ];
    } on PlaceSourceException catch (error, stackTrace) {
      await cityFuture;
      if (shortlist.isNotEmpty) {
        session.log(
          'Fresh shortlist discovery failed (${error.code}); creating the room '
          'with the saved places only.',
          level: LogLevel.warning,
          exception: error.cause ?? error,
          stackTrace: stackTrace,
        );
        candidates = shortlist;
      } else {
        session.log(
          'Session creation place source failure (${error.code}): '
          '${error.message}',
          level: LogLevel.error,
          exception: error.cause ?? error,
          stackTrace: stackTrace,
        );
        throw ApiException(
          code: error.code,
          message: error.message,
        );
      }
    } catch (_) {
      await cityFuture;
      rethrow;
    }
    final eligibleCandidates = request.visitAt == null
        ? candidates
        : candidates.where(
            (place) => PlaceAvailability.isOpenAt(
              place,
              visitAt: request.visitAt!,
              countryCode: countryCode,
            ),
          );
    final deck = eligibleCandidates
        .take(targetDeckSize)
        .toList(growable: false);
    if (shortlistIds.isNotEmpty &&
        !shortlistIds.every(
          (placeId) => deck.any((place) => place.placeId == placeId),
        )) {
      throw ApiException(
        code: 'shortlist_unavailable',
        message: 'Some saved places are not available at the selected time.',
      );
    }
    final city = await cityFuture;
    if (deck.isEmpty) {
      throw ApiException(
        code: 'no_places',
        message: 'No eligible places were found. Try a larger radius or broader category.',
      );
    }
    final now = DateTime.now().toUtc();
    final sessionId = _uuid.v7();
    final participantId = _uuid.v7();
    final code = await _unusedCode(session);
    final displayName = _displayName(request.displayName, fallback: 'Host');
    final taxonomyItems = await TaxonomyService.activeItems(session);
    final taxonomyById = {for (final item in taxonomyItems) item.id: item};
    final sessionRow = HayerSessionRow(
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
      visitAt: request.visitAt?.toUtc(),
      countryCode: countryCode,
      cityKey: city.cityKey,
      cityName: city.cityName,
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
    );

    final persistedSessionId = await session.db.transaction((
      transaction,
    ) async {
      final idempotencyRows = await IdempotencyRow.db.insert(
        session,
        [
          IdempotencyRow(
            scope: 'create-session',
            userId: userId,
            idempotencyKey: idempotencyKey,
            requestHash: requestHash,
            responseId: sessionId,
            createdAt: now,
            expiresAt: now.add(const Duration(hours: 24)),
          ),
        ],
        transaction: transaction,
        ignoreConflicts: true,
      );
      if (idempotencyRows.isEmpty) {
        final concurrentKey = await IdempotencyRow.db.findFirstRow(
          session,
          where: (table) =>
              table.scope.equals('create-session') &
              table.userId.equals(userId) &
              table.idempotencyKey.equals(idempotencyKey),
          transaction: transaction,
        );
        if (concurrentKey == null) {
          throw StateError(
            'Idempotency row disappeared after a create conflict.',
          );
        }
        if (concurrentKey.requestHash != requestHash) {
          throw ApiException(
            code: 'conflict',
            message: 'This retry key was already used for a different request.',
          );
        }
        return concurrentKey.responseId;
      }

      await HayerSessionRow.db.insertRow(
        session,
        sessionRow,
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
      await ProductAnalyticsRecorder.record(
        session,
        [
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.sessionCreated,
            sessionRow: sessionRow,
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.participantJoined,
            sessionRow: sessionRow,
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.radiusSelected,
            sessionRow: sessionRow,
            taxonomyId: '${request.radiusMeters}',
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.deckSizeSelected,
            sessionRow: sessionRow,
            taxonomyId: '${request.deckSize}',
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.priceSelected,
            sessionRow: sessionRow,
            taxonomyId: request.priceLevel?.toString() ?? 'any',
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.visitScheduled,
            sessionRow: sessionRow,
            taxonomyId: request.visitAt == null ? 'now' : 'scheduled',
            context: request.analyticsContext,
          ),
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: AnalyticsMetric.taxonomySelected,
            sessionRow: sessionRow,
            taxonomyKind: TaxonomyKind.category.name,
            taxonomyId: request.categoryId,
            context: request.analyticsContext,
          ),
          for (final id in request.subcategoryIds)
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.taxonomySelected,
              sessionRow: sessionRow,
              taxonomyKind: taxonomyById[id]?.kind.name ?? '',
              taxonomyId: id,
              context: request.analyticsContext,
            ),
          for (final place in deck)
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.deckIncluded,
              sessionRow: sessionRow,
              placeId: place.placeId,
              placeName: place.name,
              context: request.analyticsContext,
            ),
          if (shortlistIds.isNotEmpty)
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.shortlistUsed,
              sessionRow: sessionRow,
              value: shortlistIds.length.toDouble(),
              sampleCount: shortlistIds.length,
              context: request.analyticsContext,
              outcomeCode: deck.length == shortlistIds.length
                  ? 'saved_only'
                  : 'with_discovery',
            ),
          if (deck.any((place) => place.isStale))
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.staleDeck,
              sessionRow: sessionRow,
              context: request.analyticsContext,
            ),
          if (deck.length < targetDeckSize)
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.underfilledDeck,
              sessionRow: sessionRow,
              context: request.analyticsContext,
            ),
        ],
        transaction: transaction,
      );
      return sessionId;
    });
    return _loadById(session, persistedSessionId, userId: userId);
  }

  Future<SessionBundle> join(
    Session session, {
    required String code,
    required String displayName,
    ClientAnalyticsContext? analyticsContext,
  }) async {
    final userId = _userId(session);
    _validateAnalyticsContext(analyticsContext);
    await RateLimiter.check(
      session,
      operation: 'session-join',
      subject: userId,
      limit: 30,
      window: const Duration(minutes: 1),
    );
    final normalizedCode = SessionCode.normalize(code);
    if (!SessionCode.isValid(normalizedCode)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Enter a valid session code.',
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
        await ProductAnalyticsRecorder.record(
          session,
          [
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.participantJoined,
              sessionRow: lockedSession,
              context: analyticsContext,
            ),
          ],
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

  /// Permanently deletes an active solo session owned by the caller.
  Future<void> abandon(
    Session session, {
    required String sessionId,
  }) async {
    final userId = _userId(session);
    await RateLimiter.check(
      session,
      operation: 'session-abandon',
      subject: userId,
      limit: 20,
      window: const Duration(minutes: 1),
    );
    await session.db.transaction((transaction) async {
      final row = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (row == null) return;
      if (row.mode != SessionMode.solo) {
        throw ApiException(
          code: 'forbidden',
          message: 'Only solo sessions can be ended this way.',
        );
      }
      if (row.hostUserId != userId) {
        throw ApiException(
          code: 'forbidden',
          message: 'Only the session owner can end it.',
        );
      }
      await HayerSessionRow.db.deleteRow(
        session,
        row,
        transaction: transaction,
      );
      await IdempotencyRow.db.deleteWhere(
        session,
        where: (table) =>
            table.scope.equals('create-session') &
            table.userId.equals(userId) &
            table.responseId.equals(sessionId),
        transaction: transaction,
      );
    });
  }

  Future<SessionBundle> swipe(
    Session session, {
    required SwipeCommand command,
  }) async {
    final userId = _userId(session);
    _validateAnalyticsContext(command.analyticsContext);
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
      final analyticsEvents = <AnalyticsEvent>[];
      final wasCompleted = participant.hasCompleted;
      var revisingPreviousSwipe = false;
      if (already != null) {
        if (already.swipeIndex != command.swipeIndex) {
          throw ApiException(
            code: 'conflict',
            message: 'This card was already swiped at another position.',
          );
        }
        if (already.liked == command.liked) return;
        if (participant.currentIndex != command.swipeIndex + 1) {
          throw ApiException(
            code: 'conflict',
            message: 'Only your most recent swipe can be changed.',
          );
        }
        final previousLiked = already.liked;
        already
          ..liked = command.liked
          ..clientSwipedAt = command.clientSwipedAt.toUtc()
          ..serverReceivedAt = now;
        await SwipeRow.db.updateRow(
          session,
          already,
          transaction: transaction,
        );
        participant.lastSeenAt = now;
        await ParticipantRow.db.updateRow(
          session,
          participant,
          transaction: transaction,
        );
        revisingPreviousSwipe = true;
        event = SessionEventType.resultsChanged;
        analyticsEvents
          ..add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: previousLiked
                  ? AnalyticsMetric.swipeLike
                  : AnalyticsMetric.swipeDislike,
              sessionRow: row,
              placeId: place.placeId,
              placeName: place.snapshot.name,
              value: -1,
              sampleCount: -1,
              context: command.analyticsContext,
            ),
          )
          ..add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: command.liked
                  ? AnalyticsMetric.swipeLike
                  : AnalyticsMetric.swipeDislike,
              sessionRow: row,
              placeId: place.placeId,
              placeName: place.snapshot.name,
              context: command.analyticsContext,
            ),
          );
      }
      if (!revisingPreviousSwipe &&
          command.swipeIndex != participant.currentIndex) {
        throw ApiException(
          code: 'conflict',
          message: 'Your deck progress changed. Reload and try again.',
        );
      }
      if (!revisingPreviousSwipe) {
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
        participant.hasCompleted =
            participant.currentIndex >= row.deckSizeActual;
        participant.lastSeenAt = now;
        await ParticipantRow.db.updateRow(
          session,
          participant,
          transaction: transaction,
        );
        analyticsEvents.add(
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: command.liked
                ? AnalyticsMetric.swipeLike
                : AnalyticsMetric.swipeDislike,
            sessionRow: row,
            placeId: place.placeId,
            placeName: place.snapshot.name,
            context: command.analyticsContext,
          ),
        );
        if (!wasCompleted && participant.hasCompleted) {
          analyticsEvents
            ..add(
              ProductAnalyticsRecorder.event(
                eventId: _uuid.v7(),
                occurredAt: now,
                metricName: AnalyticsMetric.participantCompleted,
                sessionRow: row,
                context: command.analyticsContext,
              ),
            )
            ..add(
              ProductAnalyticsRecorder.event(
                eventId: _uuid.v7(),
                occurredAt: now,
                metricName: AnalyticsMetric.swipeDepth,
                sessionRow: row,
                value: participant.currentIndex.toDouble(),
                context: command.analyticsContext,
              ),
            );
        }
      }

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
      // Finishing every deck currently in a multiplayer room must not close
      // its join link. Late participants can still join and update results.
      if (row.status == SessionStatus.active &&
          row.mode == SessionMode.solo &&
          participant.hasCompleted) {
        row.status = SessionStatus.completed;
        event = SessionEventType.resultsChanged;
      }
      var reachedDecision = row.status == SessionStatus.completed;
      int? decisionParticipantCount;
      if (!reachedDecision &&
          row.mode == SessionMode.multiplayer &&
          row.matchingTiming == MatchingTiming.afterDeck &&
          participant.hasCompleted &&
          row.decisionAt == null) {
        final participants = await ParticipantRow.db.find(
          session,
          where: (table) => table.sessionId.equals(row.sessionId),
          transaction: transaction,
        );
        reachedDecision =
            participants.isNotEmpty &&
            participants.every((value) => value.hasCompleted);
        decisionParticipantCount = participants.length;
      }
      if (reachedDecision && row.decisionAt == null) {
        row.decisionAt = now;
        final matchedPlaceIds = <String>{?row.matchedPlaceId};
        if (matchedPlaceIds.isEmpty) {
          final allSwipes = await SwipeRow.db.find(
            session,
            where: (table) => table.sessionId.equals(row.sessionId),
            transaction: transaction,
          );
          final tallies = <String, VoteTally>{};
          for (final swipe in allSwipes) {
            final previous = tallies[swipe.placeId];
            tallies[swipe.placeId] = VoteTally(
              likes: (previous?.likes ?? 0) + (swipe.liked ? 1 : 0),
              voters: (previous?.voters ?? 0) + 1,
            );
          }
          matchedPlaceIds.addAll(
            tallies.entries
                .where(
                  (entry) => Consensus.isMatch(row.consensusRule, entry.value),
                )
                .map((entry) => entry.key),
          );
        }
        final participantCount =
            decisionParticipantCount ??
            await ParticipantRow.db.count(
              session,
              where: (table) => table.sessionId.equals(row.sessionId),
              transaction: transaction,
            );
        analyticsEvents
          ..add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.decisionCompleted,
              sessionRow: row,
              context: command.analyticsContext,
            ),
          )
          ..add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.decisionTimeSeconds,
              sessionRow: row,
              value: now.difference(row.createdAt).inSeconds.toDouble(),
              context: command.analyticsContext,
            ),
          )
          ..add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.groupSize,
              sessionRow: row,
              taxonomyId: '$participantCount',
              context: command.analyticsContext,
            ),
          );
        if (matchedPlaceIds.isEmpty) {
          analyticsEvents.add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.noMatchCompleted,
              sessionRow: row,
              context: command.analyticsContext,
            ),
          );
        } else {
          analyticsEvents.add(
            ProductAnalyticsRecorder.event(
              eventId: _uuid.v7(),
              occurredAt: now,
              metricName: AnalyticsMetric.matchCompleted,
              sessionRow: row,
              context: command.analyticsContext,
            ),
          );
          final matchedPlaces = await SessionPlaceRow.db.find(
            session,
            where: (table) =>
                table.sessionId.equals(row.sessionId) &
                table.placeId.inSet(matchedPlaceIds),
            transaction: transaction,
          );
          analyticsEvents.addAll(
            matchedPlaces.map(
              (matchedPlace) => ProductAnalyticsRecorder.event(
                eventId: _uuid.v7(),
                occurredAt: now,
                metricName: AnalyticsMetric.placeMatched,
                sessionRow: row,
                placeId: matchedPlace.placeId,
                placeName: matchedPlace.snapshot.name,
                context: command.analyticsContext,
              ),
            ),
          );
        }
      }
      row.revision++;
      revision = row.revision;
      await HayerSessionRow.db.updateRow(
        session,
        row,
        transaction: transaction,
      );
      await ProductAnalyticsRecorder.record(
        session,
        analyticsEvents,
        transaction: transaction,
      );
    });
    await _notify(session, command.sessionId, event, revision);
    return _loadById(session, command.sessionId, userId: userId);
  }

  Future<SessionBundle> chooseDestination(
    Session session, {
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    ClientAnalyticsContext? analyticsContext,
  }) async {
    final userId = _userId(session);
    _validateAnalyticsContext(analyticsContext);
    await RateLimiter.check(
      session,
      operation: 'destination-choice',
      subject: userId,
      limit: 60,
      window: const Duration(minutes: 1),
    );
    int? revision;
    await session.db.transaction((transaction) async {
      final room = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (room == null) {
        throw ApiException(code: 'not_found', message: 'Session not found.');
      }
      final self = await _requireMembership(
        session,
        sessionId,
        userId,
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      if (!now.isBefore(room.expiresAt) ||
          room.status == SessionStatus.expired) {
        throw ApiException(
          code: 'session_expired',
          message: 'This session has expired.',
        );
      }
      if (room.mode != SessionMode.multiplayer) {
        throw ApiException(
          code: 'bad_request',
          message: 'Destination voting is for multiplayer sessions.',
        );
      }
      final participants = await ParticipantRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
      );
      final places = await SessionPlaceRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
      );
      final swipes = await SwipeRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
      );
      final state = DestinationChoices.summarize(
        room: room,
        participants: participants,
        swipes: swipes,
        deckPlaceIds: places.map((place) => place.placeId).toList(),
        userId: userId,
        now: now,
      );
      if (!state.canChoose) {
        throw ApiException(
          code: 'choice_not_ready',
          message: 'Wait for the group to finish swiping.',
        );
      }
      if (!state.eligiblePlaceIds.contains(placeId)) {
        throw ApiException(
          code: 'bad_request',
          message: 'Choose a place from the group matches.',
        );
      }
      // A retry of the same choice is a no-op. An older, different choice must
      // never overwrite a newer choice from this participant.
      if (self.destinationPlaceId == placeId) return;
      if (self.destinationChoiceRevision != expectedRevision) {
        throw ApiException(
          code: 'choice_conflict',
          message: 'Your choice changed. Refresh before choosing again.',
        );
      }
      final previousPlaceId = self.destinationPlaceId;
      self
        ..destinationPlaceId = placeId
        ..destinationChoiceRevision += 1;
      await ParticipantRow.db.updateRow(
        session,
        self,
        columns: (table) => [
          table.destinationPlaceId,
          table.destinationChoiceRevision,
        ],
        transaction: transaction,
      );
      room.revision += 1;
      await HayerSessionRow.db.updateRow(
        session,
        room,
        columns: (table) => [table.revision],
        transaction: transaction,
      );
      final selectedPlace = places.singleWhere(
        (place) => place.placeId == placeId,
      );
      await ProductAnalyticsRecorder.record(
        session,
        [
          ProductAnalyticsRecorder.event(
            eventId: _uuid.v7(),
            occurredAt: now,
            metricName: previousPlaceId == null
                ? AnalyticsMetric.choiceConfirmed
                : AnalyticsMetric.choiceChanged,
            sessionRow: room,
            placeId: placeId,
            placeName: selectedPlace.snapshot.name,
            context: analyticsContext,
          ),
        ],
        transaction: transaction,
      );
      revision = room.revision;
    });
    if (revision != null) {
      await _notify(
        session,
        sessionId,
        SessionEventType.resultsChanged,
        revision!,
      );
    }
    return _loadById(session, sessionId, userId: userId);
  }

  /// Records a bounded, allowlisted UI event. These events are best effort;
  /// authoritative votes and destination choices are recorded in their own
  /// database transactions instead.
  Future<void> recordClientAnalytics(
    Session session, {
    required ClientAnalyticsEvent event,
  }) async {
    final userId = _userId(session);
    _validateClientAnalyticsEvent(event);
    await RateLimiter.check(
      session,
      operation: 'client-analytics',
      subject: userId,
      limit: 180,
      window: const Duration(minutes: 1),
    );
    final sessionId = event.sessionId?.trim();
    HayerSessionRow? room;
    ParticipantRow? participant;
    SessionPlaceRow? place;
    if (sessionId != null && sessionId.isNotEmpty) {
      room = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(sessionId),
      );
      if (room == null) {
        throw ApiException(code: 'not_found', message: 'Session not found.');
      }
      participant = await _requireMembership(session, sessionId, userId);
      final placeId = event.placeId?.trim();
      if (placeId != null && placeId.isNotEmpty) {
        place = await SessionPlaceRow.db.findFirstRow(
          session,
          where: (table) =>
              table.sessionId.equals(sessionId) & table.placeId.equals(placeId),
        );
        if (place == null) {
          throw ApiException(
            code: 'bad_request',
            message: 'That place is not in this session.',
          );
        }
      }
    }
    if (event.eventName != AnalyticsMetric.journeyStarted && room == null) {
      throw ApiException(
        code: 'bad_request',
        message: 'This analytics event requires a session.',
      );
    }
    var eventId = event.eventId;
    if (event.eventName == AnalyticsMetric.journeyStarted) {
      eventId = sha256
          .convert(
            utf8.encode(
              '${AnalyticsMetric.journeyStarted}:${event.context.journeyId}:'
              '${event.outcomeCode ?? 'unknown'}:${sessionId ?? 'none'}',
            ),
          )
          .toString();
    } else if (event.eventName == AnalyticsMetric.cardImpression) {
      if (participant == null ||
          place == null ||
          event.deckPosition != place.deckOrder ||
          (event.visibleMilliseconds ?? 0) < 500 ||
          event.visibleMilliseconds! > 60000) {
        throw ApiException(
          code: 'bad_request',
          message: 'The card impression is invalid.',
        );
      }
      eventId = sha256
          .convert(
            utf8.encode(
              '${AnalyticsMetric.cardImpression}:$sessionId:'
              '${participant.participantId}:${place.placeId}',
            ),
          )
          .toString();
    } else if (event.eventName == AnalyticsMetric.placeDetailsOpened &&
        place == null) {
      throw ApiException(
        code: 'bad_request',
        message: 'Place details require a session place.',
      );
    }
    await ProductAnalyticsRecorder.record(session, [
      ProductAnalyticsRecorder.clientEvent(
        eventId: eventId,
        occurredAt: event.occurredAt,
        metricName: event.eventName,
        context: event.context,
        sessionRow: room,
        placeId: place?.placeId ?? '',
        placeName: place?.snapshot.name ?? '',
        outcomeCode: event.outcomeCode,
        deckPosition: event.deckPosition,
        visibleMilliseconds: event.visibleMilliseconds,
      ),
    ]);
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
    // Create the event stream before reading the current revision so an event
    // posted during the read is queued instead of falling into a race window.
    final updates = session.messages.createStream<SessionEvent>(
      _channel(sessionId),
    );
    final bundle = await _loadById(
      session,
      sessionId,
      userId: _userId(session),
    );
    yield SessionEvent(
      sessionId: sessionId,
      type: SessionEventType.resultsChanged,
      revision: bundle.session.revision,
      occurredAt: DateTime.now().toUtc(),
    );
    yield* updates;
  }

  Future<SessionBundle> _loadById(
    Session session,
    String sessionId, {
    required String userId,
  }) async {
    final routeEstimatePolicy = await RouteEstimatePolicyService.load(session);
    // Membership, progress, matches and choice counts share one revision.
    // All mutations lock the room first; no network work occurs under this lock.
    return session.db.transaction((transaction) async {
      final row = await HayerSessionRow.db.findFirstRow(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
      if (row == null) {
        throw ApiException(code: 'not_found', message: 'Session not found.');
      }
      final participant = await _requireMembership(
        session,
        sessionId,
        userId,
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      if (!now.isBefore(row.expiresAt) && row.status != SessionStatus.expired) {
        row
          ..status = SessionStatus.expired
          ..revision += 1;
        await HayerSessionRow.db.updateRow(
          session,
          row,
          columns: (table) => [table.status, table.revision],
          transaction: transaction,
        );
      }
      participant.lastSeenAt = now;
      await ParticipantRow.db.updateRow(
        session,
        participant,
        columns: (table) => [table.lastSeenAt],
        transaction: transaction,
      );
      final placeRows = await SessionPlaceRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        orderBy: (table) => table.deckOrder,
        transaction: transaction,
      );
      final participants = await ParticipantRow.db.find(
        session,
        where: (table) => table.sessionId.equals(sessionId),
        orderBy: (table) => table.isHost,
        orderDescending: true,
        transaction: transaction,
      );
      final participantViews = participants
          .map(SessionMapper.participant)
          .toList(growable: false);
      DestinationChoiceState? choices;
      if (row.mode == SessionMode.multiplayer) {
        final swipes = await SwipeRow.db.find(
          session,
          where: (table) => table.sessionId.equals(sessionId),
          transaction: transaction,
        );
        choices = DestinationChoices.summarize(
          room: row,
          participants: participants,
          swipes: swipes,
          deckPlaceIds: placeRows.map((place) => place.placeId).toList(),
          userId: userId,
          now: now,
        );
      }
      return SessionBundle(
        session: SessionMapper.session(row),
        deck: placeRows.map((place) => place.snapshot).toList(growable: false),
        participants: participantViews,
        selfParticipant: participantViews.singleWhere(
          (value) => value.participantId == participant.participantId,
        ),
        routeEstimatePolicy: routeEstimatePolicy,
        destinationChoices: choices,
      );
    });
  }

  Future<ParticipantRow> _requireMembership(
    Session session,
    String sessionId,
    String userId, {
    Transaction? transaction,
  }) async {
    final row = await ParticipantRow.db.findFirstRow(
      session,
      where: (table) =>
          table.sessionId.equals(sessionId) & table.userId.equals(userId),
      transaction: transaction,
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
    for (var attempt = 0; attempt < 64; attempt++) {
      final value = SessionCode.generate(random);
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

  Future<void> _validateCreate(
    Session session,
    CreateSessionRequest request,
    String idempotencyKey,
  ) async {
    try {
      await TaxonomyService.resolve(
        session,
        request.categoryId,
        request.subcategoryIds,
      );
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
    if (request.radiusMeters < 500 || request.radiusMeters > 10000) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Choose a search radius between 500 m and 10 km.',
      );
    }
    if (!const {10, 20, 30, 40, 50}.contains(request.deckSize)) {
      throw ApiException(
        code: 'invalid_request',
        message: 'Choose a supported deck size.',
      );
    }
    final shortlistIds = request.shortlistPlaceIds ?? const <String>[];
    final freshDiscoveryCount = request.freshDiscoveryCount ?? 0;
    if (shortlistIds.isEmpty) {
      if (request.freshDiscoveryCount != null) {
        throw ApiException(
          code: 'bad_request',
          message: 'Fresh shortlist discovery requires saved places.',
        );
      }
    } else if (shortlistIds.length < 2 ||
        shortlistIds.length > 20 ||
        shortlistIds.toSet().length != shortlistIds.length ||
        shortlistIds.any((id) => id.isEmpty || id.length > 128) ||
        !const {0, 5}.contains(freshDiscoveryCount) ||
        shortlistIds.length + freshDiscoveryCount > request.deckSize) {
      throw ApiException(
        code: 'bad_request',
        message: 'Choose 2–20 distinct saved places for the shortlist.',
      );
    }
    if (request.priceLevel != null &&
        (request.priceLevel! < 1 || request.priceLevel! > 4)) {
      throw ApiException(
        code: 'bad_request',
        message: 'Price level is invalid.',
      );
    }
    final visitAt = request.visitAt?.toUtc();
    final now = DateTime.now().toUtc();
    if (visitAt != null &&
        (visitAt.isBefore(now.subtract(const Duration(minutes: 5))) ||
            visitAt.isAfter(now.add(const Duration(days: 90))))) {
      throw ApiException(
        code: 'bad_request',
        message: 'Visit time must be within the next 90 days.',
      );
    }
    if (idempotencyKey.length < 8 || idempotencyKey.length > 128) {
      throw ApiException(code: 'bad_request', message: 'Retry key is invalid.');
    }
  }

  void _validateClientAnalyticsEvent(ClientAnalyticsEvent event) {
    _validateAnalyticsContext(event.context);
    final now = DateTime.now().toUtc();
    final occurredAt = event.occurredAt.toUtc();
    final validOutcome =
        event.outcomeCode == null ||
        RegExp(r'^[a-z0-9_]{1,64}$').hasMatch(event.outcomeCode!);
    if (!_clientAnalyticsMetrics.contains(event.eventName) ||
        !Uuid.isValidUUID(fromString: event.eventId) ||
        occurredAt.isBefore(now.subtract(const Duration(hours: 24))) ||
        occurredAt.isAfter(now.add(const Duration(minutes: 5))) ||
        (event.sessionId?.length ?? 0) > 64 ||
        (event.placeId?.length ?? 0) > 128 ||
        (event.deckPosition != null &&
            (event.deckPosition! < 0 || event.deckPosition! >= 50)) ||
        !validOutcome) {
      throw ApiException(
        code: 'bad_request',
        message: 'The analytics event is invalid.',
      );
    }
    if (event.eventName == AnalyticsMetric.journeyStarted &&
        !const {'setup', 'join', 'resume'}.contains(event.outcomeCode)) {
      throw ApiException(
        code: 'bad_request',
        message: 'The journey entry point is invalid.',
      );
    }
  }

  void _validateAnalyticsContext(ClientAnalyticsContext? context) {
    if (context == null) return;
    const platforms = {
      'android',
      'ios',
      'web',
      'macos',
      'windows',
      'linux',
      'unknown',
    };
    if (context.schemaVersion != 1 ||
        !Uuid.isValidUUID(fromString: context.journeyId) ||
        context.appBuild < 0 ||
        context.appBuild > 1000000000 ||
        !platforms.contains(context.platform) ||
        !RegExp(r'^[a-z]{2,3}(-[A-Z]{2})?$').hasMatch(context.language)) {
      throw ApiException(
        code: 'bad_request',
        message: 'The analytics context is invalid.',
      );
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
