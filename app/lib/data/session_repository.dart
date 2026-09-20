import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hayer_client/hayer_client.dart';

import 'authentication.dart';
import 'pending_swipe_store.dart';

typedef SwipeTransport = Future<SessionBundle> Function(SwipeCommand command);
typedef ClientAnalyticsTransport = Future<void> Function(
  ClientAnalyticsEvent event,
);

class ClientAnalyticsMetadata {
  const ClientAnalyticsMetadata({
    required this.appBuild,
    required this.platform,
  });

  final int appBuild;
  final String platform;
}

enum SwipeSubmissionState { accepted, queued, rejected }

class SwipeSubmissionResult {
  const SwipeSubmissionResult._({
    required this.state,
    this.bundle,
    this.errorCode,
  });

  const SwipeSubmissionResult.accepted(SessionBundle value)
    : this._(state: SwipeSubmissionState.accepted, bundle: value);

  const SwipeSubmissionResult.queued()
    : this._(state: SwipeSubmissionState.queued);

  const SwipeSubmissionResult.rejected(String code)
    : this._(state: SwipeSubmissionState.rejected, errorCode: code);

  final SwipeSubmissionState state;
  final SessionBundle? bundle;
  final String? errorCode;
}

/// One refreshed view of an open session.
///
/// [resultTallies] is present only when the refresh came from the lightweight
/// `sessions.progress` read. A full load carries no tallies, so a caller that
/// needs them has to ask for them separately.
class SessionRefresh {
  const SessionRefresh({required this.bundle, this.resultTallies});

  final SessionBundle bundle;
  final List<SessionResultTally>? resultTallies;
}

class QueueFlushResult {
  const QueueFlushResult({
    required this.accepted,
    required this.terminalFailures,
    required this.pending,
    required this.pendingSessionIds,
    required this.terminalFailureSessionIds,
    required this.pendingProgressBySession,
  });

  final int accepted;
  final int terminalFailures;
  final int pending;
  final Set<String> pendingSessionIds;
  final Set<String> terminalFailureSessionIds;
  final Map<String, int> pendingProgressBySession;
}

class SessionRepository {
  SessionRepository({
    required this.client,
    required this.outbox,
    this.secureStorage = const FlutterSecureStorage(),
    this.swipeTransport,
    this.analyticsMetadata = const ClientAnalyticsMetadata(
      appBuild: 0,
      platform: 'unknown',
    ),
    this.analyticsTransport,
  });

  final Client client;
  final PendingSwipeStore outbox;
  final FlutterSecureStorage secureStorage;
  final SwipeTransport? swipeTransport;
  final ClientAnalyticsMetadata analyticsMetadata;
  final ClientAnalyticsTransport? analyticsTransport;
  final _commandMutex = _AsyncMutex();
  final _journeysBySession = <String, String>{};
  final _startedSessionJourneys = <String>{};
  String? _pendingJourneyId;
  bool _progressUnsupported = false;
  static const _uuid = Uuid();
  static const activeSessionKey = 'hayer.active-session-id';

  Future<SessionBundle> create(
    CreateSessionRequest request, {
    String language = 'en',
  }) async {
    final idempotencyKey = _uuid.v7();
    final context = _newSessionContext(language);
    final requestWithAnalytics = request.copyWith(analyticsContext: context);
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.create(
          request: requestWithAnalytics,
          idempotencyKey: idempotencyKey,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    _rememberJourney(bundle.session.sessionId, context.journeyId);
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> createFromIntent(
    CreateIntentSessionRequest request, {
    String language = 'en',
  }) async {
    final idempotencyKey = _uuid.v7();
    final context = _newSessionContext(language);
    final requestWithAnalytics = request.copyWith(analyticsContext: context);
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.createFromIntent(
          request: requestWithAnalytics,
          idempotencyKey: idempotencyKey,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    _rememberJourney(bundle.session.sessionId, context.journeyId);
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> extendSolo({
    required String sessionId,
    required int expectedRevision,
  }) async {
    final idempotencyKey = _uuid.v7();
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.extendSolo(
          sessionId: sessionId,
          expectedRevision: expectedRevision,
          idempotencyKey: idempotencyKey,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> join(
    String code,
    String displayName, {
    String language = 'en',
  }) async {
    final context = _newSessionContext(language);
    final bundle = await retryOnceAfterTransientFailure(
      action: () => withAnonymousAuthentication(
        client,
        () => client.hayerSession.join(
          code: code,
          displayName: displayName,
          analyticsContext: context,
        ),
      ),
      isTransient: _isTransientClientFailure,
    );
    _rememberJourney(bundle.session.sessionId, context.journeyId);
    await remember(bundle.session.sessionId);
    return bundle;
  }

  Future<SessionBundle> load(String sessionId) async {
    return withAnonymousAuthentication(
      client,
      () => client.hayerSession.load(sessionId: sessionId),
    );
  }

  /// Refreshes the half of an open session that can still change.
  ///
  /// A room's deck is immutable once it is created, so a refresh only needs the
  /// session, its participants and the current tallies. [previous] supplies the
  /// deck that `sessions.progress` deliberately omits, which turns one refresh
  /// of a full twelve-person room from roughly 75-150 KB into 1-2 KB. Presence
  /// is preserved: the server writes `lastSeenAt` on this read too.
  ///
  /// Without a [previous] bundle there is no deck to keep, so this falls back
  /// to the full [load].
  ///
  /// A server older than the progress contract — the rollback target while
  /// build 5 is still accepted — cannot answer the call at all. The first time
  /// that happens and the full load succeeds in its place, this repository
  /// stops attempting the lightweight read for the rest of the process. An
  /// [ApiException] is the server's real answer about this session, not a
  /// missing endpoint, so it is reported rather than retried as a full load.
  Future<SessionRefresh> refresh(
    String sessionId, {
    SessionBundle? previous,
  }) async {
    if (previous == null || _progressUnsupported) {
      return SessionRefresh(bundle: await load(sessionId));
    }
    try {
      final progress = await readProgress(sessionId);
      return SessionRefresh(
        bundle: mergeSessionProgress(previous, progress),
        resultTallies: progress.resultTallies,
      );
    } on ApiException {
      rethrow;
    } catch (_) {
      final bundle = await load(sessionId);
      _progressUnsupported = true;
      return SessionRefresh(bundle: bundle);
    }
  }

  /// The lightweight read behind [refresh], kept separate from it so a test
  /// can stand in for the server without a live client.
  Future<SessionProgress> readProgress(String sessionId) =>
      withAnonymousAuthentication(
        client,
        () => client.hayerSession.progress(sessionId: sessionId),
      );

  Future<String?> activeSessionId() =>
      secureStorage.read(key: activeSessionKey);

  Future<SessionBundle> chooseDestination({
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    String language = 'en',
  }) => withAnonymousAuthentication(
    client,
    () => client.hayerSession.chooseDestination(
      sessionId: sessionId,
      placeId: placeId,
      expectedRevision: expectedRevision,
      analyticsContext: _contextForSession(sessionId, language),
    ),
  );

  Future<void> beginJourney({
    required String entryPoint,
    required String language,
  }) async {
    final journeyId = _uuid.v7();
    _pendingJourneyId = journeyId;
    await _recordBestEffort(
      ClientAnalyticsEvent(
        eventId: _uuid.v7(),
        eventName: 'journey_started',
        occurredAt: DateTime.now().toUtc(),
        context: _context(journeyId, language),
        outcomeCode: entryPoint,
      ),
    );
  }

  Future<void> recordCardImpression({
    required String sessionId,
    required String placeId,
    required int deckPosition,
    required int visibleMilliseconds,
    required String language,
  }) => _recordSessionEvent(
    sessionId: sessionId,
    eventName: 'card_impression',
    language: language,
    placeId: placeId,
    deckPosition: deckPosition,
    visibleMilliseconds: visibleMilliseconds,
  );

  Future<void> recordPlaceDetailsOpened({
    required String sessionId,
    required String placeId,
    required int deckPosition,
    required String language,
  }) => _recordSessionEvent(
    sessionId: sessionId,
    eventName: 'place_details_opened',
    language: language,
    placeId: placeId,
    deckPosition: deckPosition,
  );

  Future<void> recordResultsViewed({
    required String sessionId,
    required String language,
  }) => _recordSessionEvent(
    sessionId: sessionId,
    eventName: 'results_viewed',
    language: language,
  );

  Future<void> remember(String sessionId) async {
    try {
      await secureStorage.write(key: activeSessionKey, value: sessionId);
    } catch (_) {
      // Local resume persistence is optional; the server action succeeded.
    }
  }

  Future<void> forgetActiveSession() =>
      secureStorage.delete(key: activeSessionKey);

  Future<void> abandonSolo(String sessionId) async {
    await withAnonymousAuthentication(
      client,
      () => client.hayerSession.abandon(sessionId: sessionId),
    );
    await outbox.removeSession(sessionId);
    final active = await activeSessionId();
    if (active == sessionId) await forgetActiveSession();
  }

  Future<SwipeSubmissionResult> swipe({
    required String sessionId,
    required String placeId,
    required bool liked,
    required int swipeIndex,
    String language = 'en',
  }) => _commandMutex.protect(() async {
    final key = _uuid.v7();
    final swipedAt = DateTime.now().toUtc();
    final command = SwipeCommand(
      sessionId: sessionId,
      placeId: placeId,
      liked: liked,
      swipeIndex: swipeIndex,
      clientSwipedAt: swipedAt,
      idempotencyKey: key,
      analyticsContext: _contextForSession(sessionId, language),
    );
    final pending = PendingSwipeRecord(
      idempotencyKey: key,
      sessionId: sessionId,
      placeId: placeId,
      liked: liked,
      swipeIndex: swipeIndex,
      clientSwipedAt: swipedAt,
    );
    await outbox.removeTerminalDecision(sessionId, swipeIndex);
    await outbox.enqueue(pending);
    try {
      final bundle = await _sendSwipe(command);
      await outbox.remove(key);
      return SwipeSubmissionResult.accepted(bundle);
    } catch (error) {
      final terminalCode = _terminalSwipeErrorCode(error);
      if (terminalCode != null) {
        await outbox.markTerminal(key, terminalCode);
        unawaited(
          _recordSessionEvent(
            sessionId: sessionId,
            eventName: 'sync_terminal_failure',
            language: language,
            outcomeCode: terminalCode,
          ),
        );
        return SwipeSubmissionResult.rejected(terminalCode);
      }
      unawaited(
        _recordSessionEvent(
          sessionId: sessionId,
          eventName: 'outbox_queued',
          language: language,
        ),
      );
      return const SwipeSubmissionResult.queued();
    }
  });

  Future<QueueFlushResult> flushQueue({String language = 'en'}) =>
      _commandMutex.protect(() async {
        var accepted = 0;
        var terminalFailures = 0;
        final blockedSessions = <String>{};
        final recoveredSessions = <String>{};
        final newlyTerminalSessions = <String, String>{};
        for (final pending in await outbox.queued()) {
          if (pending.isTerminal) {
            terminalFailures++;
            continue;
          }
          if (blockedSessions.contains(pending.sessionId)) continue;
          try {
            await _sendSwipe(
              SwipeCommand(
                sessionId: pending.sessionId,
                placeId: pending.placeId,
                liked: pending.liked,
                swipeIndex: pending.swipeIndex,
                clientSwipedAt: pending.clientSwipedAt,
                idempotencyKey: pending.idempotencyKey,
              ),
            );
            await outbox.remove(pending.idempotencyKey);
            accepted++;
            recoveredSessions.add(pending.sessionId);
          } catch (error) {
            final terminalCode = _terminalSwipeErrorCode(error);
            if (terminalCode == null) {
              blockedSessions.add(pending.sessionId);
              continue;
            }
            await outbox.markTerminal(pending.idempotencyKey, terminalCode);
            terminalFailures++;
            newlyTerminalSessions[pending.sessionId] = terminalCode;
          }
        }
        final remaining = await outbox.queued();
        final pendingProgressBySession = <String, int>{};
        for (final record in remaining.where((record) => !record.isTerminal)) {
          final progress = record.swipeIndex + 1;
          final previous = pendingProgressBySession[record.sessionId] ?? 0;
          if (progress > previous) {
            pendingProgressBySession[record.sessionId] = progress;
          }
        }
        for (final sessionId in recoveredSessions) {
          unawaited(
            _recordSessionEvent(
              sessionId: sessionId,
              eventName: 'sync_recovered',
              language: language,
            ),
          );
        }
        for (final entry in newlyTerminalSessions.entries) {
          unawaited(
            _recordSessionEvent(
              sessionId: entry.key,
              eventName: 'sync_terminal_failure',
              language: language,
              outcomeCode: entry.value,
            ),
          );
        }
        return QueueFlushResult(
          accepted: accepted,
          terminalFailures: terminalFailures,
          pending: remaining.where((record) => !record.isTerminal).length,
          pendingSessionIds: {
            for (final record in remaining)
              if (!record.isTerminal) record.sessionId,
          },
          terminalFailureSessionIds: {
            for (final record in remaining)
              if (record.isTerminal) record.sessionId,
          },
          pendingProgressBySession: pendingProgressBySession,
        );
      });

  Future<SessionBundle> _sendSwipe(SwipeCommand command) {
    final transport = swipeTransport;
    if (transport != null) return transport(command);
    return withAnonymousAuthentication(
      client,
      () => client.hayerSession.swipe(command: command),
    );
  }

  ClientAnalyticsContext _newSessionContext(String language) {
    final journeyId = _pendingJourneyId ?? _uuid.v7();
    return _context(journeyId, language);
  }

  ClientAnalyticsContext _contextForSession(
    String sessionId,
    String language,
  ) {
    final journeyId = _journeysBySession.putIfAbsent(sessionId, _uuid.v7);
    if (_startedSessionJourneys.add(sessionId)) {
      unawaited(
        _recordBestEffort(
          ClientAnalyticsEvent(
            eventId: _uuid.v7(),
            eventName: 'journey_started',
            occurredAt: DateTime.now().toUtc(),
            context: _context(journeyId, language),
            sessionId: sessionId,
            outcomeCode: 'resume',
          ),
        ),
      );
    }
    return _context(journeyId, language);
  }

  ClientAnalyticsContext _context(String journeyId, String language) =>
      ClientAnalyticsContext(
        journeyId: journeyId,
        schemaVersion: 1,
        appBuild: analyticsMetadata.appBuild,
        platform: analyticsMetadata.platform,
        language: language,
      );

  void _rememberJourney(String sessionId, String journeyId) {
    _journeysBySession[sessionId] = journeyId;
    _startedSessionJourneys.add(sessionId);
    if (_pendingJourneyId == journeyId) _pendingJourneyId = null;
  }

  Future<void> _recordSessionEvent({
    required String sessionId,
    required String eventName,
    required String language,
    String? placeId,
    int? deckPosition,
    int? visibleMilliseconds,
    String? outcomeCode,
  }) => _recordBestEffort(
    ClientAnalyticsEvent(
      eventId: _uuid.v7(),
      eventName: eventName,
      occurredAt: DateTime.now().toUtc(),
      context: _contextForSession(sessionId, language),
      sessionId: sessionId,
      placeId: placeId,
      deckPosition: deckPosition,
      visibleMilliseconds: visibleMilliseconds,
      outcomeCode: outcomeCode,
    ),
  );

  Future<void> _recordBestEffort(ClientAnalyticsEvent event) async {
    try {
      final transport = analyticsTransport;
      if (transport != null) {
        await transport(event);
        return;
      }
      await withAnonymousAuthentication(
        client,
        () => client.hayerSession.recordClientAnalytics(event: event),
      ).timeout(const Duration(seconds: 8));
    } catch (_) {
      // Product telemetry never blocks or changes a user action.
    }
  }
}

/// Applies a lightweight progress read onto the bundle that carries the deck.
///
/// The deck and the route-estimate policy are the two fields `sessions.progress`
/// does not return. The deck cannot change for the life of a room. The policy
/// can be edited by an operator, so a change made while a room is open reaches
/// this client on its next full load rather than on its next refresh.
SessionBundle mergeSessionProgress(
  SessionBundle previous,
  SessionProgress progress,
) => SessionBundle(
  session: progress.session,
  deck: previous.deck,
  participants: progress.participants,
  selfParticipant: progress.selfParticipant,
  routeEstimatePolicy: previous.routeEstimatePolicy,
  destinationChoices: progress.destinationChoices,
);

bool _isTransientClientFailure(Object error) =>
    error is ServerpodClientException &&
    (error.statusCode < 0 ||
        error.statusCode == 408 ||
        error.statusCode >= 500);

String? _terminalSwipeErrorCode(Object error) {
  if (error is ApiException) {
    return switch (error.code) {
      'rate_limited' || 'server_error' => null,
      _ => error.code,
    };
  }
  if (error is ServerpodClientException &&
      error.statusCode >= 400 &&
      error.statusCode < 500 &&
      error.statusCode != 408 &&
      error.statusCode != 429) {
    return 'http_${error.statusCode}';
  }
  return null;
}

final class _AsyncMutex {
  Future<void> _tail = Future<void>.value();

  Future<T> protect<T>(Future<T> Function() action) {
    final previous = _tail;
    final complete = Completer<void>();
    _tail = complete.future;
    return (() async {
      await previous;
      try {
        return await action();
      } finally {
        complete.complete();
      }
    })();
  }
}
