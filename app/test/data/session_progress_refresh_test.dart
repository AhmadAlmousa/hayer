import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/data/pending_swipe_store.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('a refresh keeps the deck it already has', () async {
    // Behavior under test: the deck is immutable for the life of a room, so a
    // refresh must reuse it rather than pull fifty place snapshots again. This
    // is the whole point of the lightweight read: an event burst in a twelve
    // person room otherwise re-transfers the same deck once per event.
    // Arrange
    final repository = _Repository(
      progress: (_) async => _progress(revision: 4, currentIndex: 3),
    );

    // Act
    final refreshed = await repository.refresh(
      'room',
      previous: _bundle(revision: 1),
    );

    // Assert
    expect(repository.loads, isEmpty);
    expect(refreshed.bundle.deck.map((place) => place.placeId), [
      'place-0',
      'place-1',
    ]);
    expect(refreshed.bundle.session.revision, 4);
    expect(refreshed.bundle.selfParticipant.currentIndex, 3);
    expect(refreshed.resultTallies?.single.likeCount, 2);
  });

  test('the route policy survives a refresh that cannot carry it', () async {
    // Behavior under test: the progress read omits the route-estimate policy,
    // so a refresh must not silently drop a policy the room was opened with.
    // Arrange
    final previous =
        _bundle(
          revision: 1,
        ).copyWith(
          routeEstimatePolicy: RouteEstimatePolicy(
            enabled: true,
            allowParticipantLocation: true,
            defaultOrigin: RouteOriginMode.sessionAnchor,
            cacheMinutes: 30,
          ),
        );
    final repository = _Repository(
      progress: (_) async => _progress(revision: 2, currentIndex: 0),
    );

    // Act
    final refreshed = await repository.refresh('room', previous: previous);

    // Assert
    expect(refreshed.bundle.routeEstimatePolicy?.enabled, isTrue);
  });

  test('without a previous bundle the deck is fetched', () async {
    // Behavior under test: a screen opening cold has no deck to refresh onto,
    // so it must still get the full bundle.
    // Arrange
    final repository = _Repository(
      progress: (_) async => fail('progress must not be attempted'),
    );

    // Act
    final refreshed = await repository.refresh('room');

    // Assert
    expect(repository.loads, ['room']);
    expect(refreshed.resultTallies, isNull);
  });

  test('a server without the progress read is used once, then dropped', () async {
    // Behavior under test: build 6 has to work against a rolled-back server
    // that never heard of sessions.progress. The first attempt falls back to
    // the full load, and the client stops paying for a call it knows will fail.
    // Arrange
    var attempts = 0;
    final repository = _Repository(
      progress: (_) async {
        attempts++;
        throw StateError('unknown method');
      },
    );

    // Act
    final first = await repository.refresh(
      'room',
      previous: _bundle(revision: 1),
    );
    final second = await repository.refresh('room', previous: first.bundle);

    // Assert
    expect(attempts, 1);
    expect(repository.loads, ['room', 'room']);
    expect(second.bundle.deck, isNotEmpty);
  });

  test('a rejection of this session is reported, not retried as a load', () async {
    // Behavior under test: expiry and lost membership are real answers about
    // the room. Treating them as a missing endpoint would both hide the answer
    // and permanently disable the lightweight read.
    // Arrange
    final repository = _Repository(
      progress: (_) async =>
          throw ApiException(code: 'session_expired', message: 'Expired'),
    );

    // Act & Assert
    await expectLater(
      repository.refresh('room', previous: _bundle(revision: 1)),
      throwsA(
        isA<ApiException>().having((e) => e.code, 'code', 'session_expired'),
      ),
    );
    expect(repository.loads, isEmpty);
  });
}

class _Repository extends SessionRepository {
  _Repository({required this.progress})
    : super(
        client: Client('http://localhost:8080/'),
        outbox: const _NoPendingSwipes(),
      );

  final Future<SessionProgress> Function(String sessionId) progress;
  final loads = <String>[];

  @override
  Future<SessionProgress> readProgress(String sessionId) => progress(sessionId);

  @override
  Future<SessionBundle> load(String sessionId) async {
    loads.add(sessionId);
    return _bundle(revision: 9);
  }
}

PlaceSnapshot _place(int index) => PlaceSnapshot(
  placeId: 'place-$index',
  name: 'Place $index',
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 1200 + index,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026),
  isStale: false,
  isOpen: true,
);

ParticipantView _participant(int currentIndex) => ParticipantView(
  participantId: 'host',
  displayName: 'Host',
  isHost: true,
  currentIndex: currentIndex,
  hasCompleted: false,
  lastSeenAt: DateTime.utc(2026),
);

SessionBundle _bundle({required int revision}) => SessionBundle(
  session: _session(revision),
  deck: [_place(0), _place(1)],
  participants: [_participant(0)],
  selfParticipant: _participant(0),
);

SessionProgress _progress({
  required int revision,
  required int currentIndex,
}) => SessionProgress(
  session: _session(revision),
  participants: [_participant(currentIndex)],
  selfParticipant: _participant(currentIndex),
  resultTallies: [
    SessionResultTally(
      placeId: 'place-0',
      likeCount: 2,
      voterCount: 2,
      match: true,
    ),
  ],
);

SessionView _session(int revision) => SessionView(
  sessionId: 'room',
  code: 'ABC234',
  mode: SessionMode.multiplayer,
  categoryId: 'restaurant',
  subcategoryIds: const [],
  anchorLatitude: 24.7,
  anchorLongitude: 46.6,
  countryCode: 'SA',
  radiusMeters: 1500,
  deckSizeRequested: 2,
  deckSizeActual: 2,
  consensusRule: ConsensusRule.majority,
  matchingTiming: MatchingTiming.afterDeck,
  status: SessionStatus.active,
  revision: revision,
  createdAt: DateTime.utc(2026),
  expiresAt: DateTime.utc(2027),
);

final class _NoPendingSwipes implements PendingSwipeStore {
  const _NoPendingSwipes();

  @override
  Future<void> clear() async {}

  @override
  Future<void> close() async {}

  @override
  Future<void> enqueue(PendingSwipeRecord record) async {}

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) async {}

  @override
  Future<List<PendingSwipeRecord>> queued() async => const [];

  @override
  Future<void> remove(String idempotencyKey) async {}

  @override
  Future<void> removeSession(String sessionId) async {}

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) async {}
}
