import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_app/features/results/destination_choice_controls.dart';
import 'package:hayer_app/features/results/results_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('changing my choice moves the vote with the latest revision', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture);
    final a = find.byKey(const ValueKey('destination-choice-a'));
    final b = find.byKey(const ValueKey('destination-choice-b'));
    await tester.ensureVisible(a);
    await tester.tap(find.descendant(of: a, matching: find.text('My choice')));
    await tester.pump();
    fixture.repository.accept('a');
    await tester.pumpAndSettle();
    fixture.repository.pending = Completer<SessionBundle>();
    await tester.ensureVisible(b);
    await tester.tap(find.descendant(of: b, matching: find.text('My choice')));
    await tester.pump();
    expect(fixture.repository.calls, [('a', 0), ('b', 1)]);
    fixture.repository.accept('b');
    await tester.pumpAndSettle();
    expect(tester.widget<DestinationChoiceControls>(b).count, 1);
    expect(tester.widget<DestinationChoiceControls>(b).selected, isTrue);
    await tester.ensureVisible(a);
    expect(tester.widget<DestinationChoiceControls>(a).count, 0);
    expect(tester.widget<DestinationChoiceControls>(a).selected, isFalse);
    await _dispose(tester, fixture);
  });

  testWidgets('a lost success response reconciles the persisted choice', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture);
    final control = find.byKey(const ValueKey('destination-choice-a'));
    await tester.ensureVisible(control);
    await tester.tap(
      find.descendant(of: control, matching: find.text('My choice')),
    );
    await tester.pump();
    fixture.repository.accept('a', lostResponse: true);
    await tester.pumpAndSettle();
    expect(tester.widget<DestinationChoiceControls>(control).count, 1);
    expect(tester.widget<DestinationChoiceControls>(control).selected, isTrue);
    expect(fixture.repository.calls, [('a', 0)]);
    await _dispose(tester, fixture);
  });

  testWidgets(
    'one tap saves a choice, with no confirmation or invented count',
    (tester) async {
      final fixture = _Fixture();
      await _pump(tester, fixture);
      final control = find.byType(DestinationChoiceControls).first;
      await tester.ensureVisible(control);
      await tester.tap(
        find.descendant(of: control, matching: find.text('My choice')),
      );
      await tester.pump();
      expect(fixture.repository.calls, [('a', 0)]);
      expect(tester.widget<DestinationChoiceControls>(control).count, 0);
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Saving…'), findsOneWidget);
      fixture.repository.accept('a');
      await tester.pumpAndSettle();
      expect(tester.widget<DestinationChoiceControls>(control).count, 1);
      expect(
        tester.widget<DestinationChoiceControls>(control).selected,
        isTrue,
      );
      expect(
        tester.widget<DestinationChoiceControls>(control).onChoose,
        isNull,
      );
      await _dispose(tester, fixture);
    },
  );

  testWidgets(
    'a failed request stays retryable and does not fabricate a vote',
    (tester) async {
      final fixture = _Fixture();
      await _pump(tester, fixture);
      final control = find.byType(DestinationChoiceControls).first;
      await tester.ensureVisible(control);
      await tester.tap(
        find.descendant(of: control, matching: find.text('My choice')),
      );
      await tester.pump();
      fixture.repository.pending.completeError(StateError('offline'));
      await tester.pumpAndSettle();
      expect(tester.widget<DestinationChoiceControls>(control).count, 0);
      expect(
        tester.widget<DestinationChoiceControls>(control).selected,
        isFalse,
      );
      expect(
        tester.widget<DestinationChoiceControls>(control).onChoose,
        isNotNull,
      );
      fixture.repository.pending = Completer<SessionBundle>();
      await tester.tap(
        find.descendant(of: control, matching: find.text('My choice')),
      );
      await tester.pump();
      expect(fixture.repository.calls, [('a', 0), ('a', 0)]);
      fixture.repository.accept('a');
      await tester.pumpAndSettle();
      expect(
        tester.widget<DestinationChoiceControls>(control).selected,
        isTrue,
      );
      await _dispose(tester, fixture);
    },
  );

  testWidgets(
    'realtime counts and winners refresh without changing my ballot',
    (tester) async {
      final fixture = _Fixture();
      await _pump(tester, fixture);
      fixture.repository.bundle = _bundle().copyWith(
        session: _bundle().session.copyWith(revision: 2),
        destinationChoices: _choices().copyWith(
          counts: {'a': 0, 'b': 1},
          winnerPlaceId: 'b',
          chosenCount: 1,
        ),
      );
      fixture.endpoint.events.add(
        SessionEvent(
          sessionId: 'room',
          type: SessionEventType.resultsChanged,
          revision: 2,
          occurredAt: DateTime(2026),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Leading choice: Place b'), findsOneWidget);
      expect(fixture.repository.calls, isEmpty);
      expect(fixture.repository.bundle.destinationChoices!.myPlaceId, isNull);
      await _dispose(tester, fixture);
    },
  );

  testWidgets(
    'older server results do not offer an unsupported choice action',
    (tester) async {
      final fixture = _Fixture();
      fixture.repository.bundle = _bundle().copyWith(destinationChoices: null);
      await _pump(tester, fixture);
      expect(find.byType(DestinationChoiceControls), findsNothing);
      await _dispose(tester, fixture);
    },
  );

  for (final locale in ['en', 'ar']) {
    testWidgets('choice controls wrap at 200% text size ($locale)', (
      tester,
    ) async {
      final fixture = _Fixture();
      await _pump(
        tester,
        fixture,
        locale: locale,
        scale: 2,
        size: const Size(320, 640),
      );
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('destination-choice-a')),
        250,
        scrollable: find.byType(Scrollable).first,
        maxScrolls: 20,
      );
      expect(tester.takeException(), isNull);
      await _dispose(tester, fixture);
    });
  }
}

Future<void> _pump(
  WidgetTester tester,
  _Fixture fixture, {
  String locale = 'en',
  double scale = 1,
  Size size = const Size(420, 1000),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(_Client(fixture.endpoint)),
        sessionRepositoryProvider.overrideWithValue(fixture.repository),
      ],
      child: MaterialApp(
        theme: HayerTheme.light(),
        locale: Locale(locale),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(scale),
            disableAnimations: true,
          ),
          child: child!,
        ),
        home: const ResultsScreen(sessionId: 'room'),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _dispose(WidgetTester tester, _Fixture fixture) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
  await fixture.endpoint.events.close();
}

class _Fixture {
  final endpoint = _Endpoint();
  final repository = _Repository();
}

class _Client extends Fake implements Client {
  _Client(this.hayerSession);
  @override
  final EndpointHayerSession hayerSession;
}

class _Endpoint extends Fake implements EndpointHayerSession {
  final events = StreamController<SessionEvent>.broadcast();
  @override
  Stream<SessionEvent> watch({required String sessionId}) => events.stream;
  @override
  Future<List<SessionResult>> results({required String sessionId}) async => [
    for (final id in ['a', 'b'])
      SessionResult(
        place: _place(id),
        likeCount: 2,
        voterCount: 2,
        match: true,
        rank: 1,
      ),
  ];
}

class _Repository extends Fake implements SessionRepository {
  SessionBundle bundle = _bundle();
  Completer<SessionBundle> pending = Completer<SessionBundle>();
  final calls = <(String, int)>[];
  @override
  Future<SessionBundle> load(String sessionId) async => bundle;
  @override
  Future<SessionBundle> chooseDestination({
    required String sessionId,
    required String placeId,
    required int expectedRevision,
    String language = 'en',
  }) {
    calls.add((placeId, expectedRevision));
    return pending.future;
  }

  @override
  Future<void> recordResultsViewed({
    required String sessionId,
    required String language,
  }) async {}

  @override
  Future<void> recordPlaceDetailsOpened({
    required String sessionId,
    required String placeId,
    required int deckPosition,
    required String language,
  }) async {}

  void accept(String id, {bool lostResponse = false}) {
    bundle = bundle.copyWith(
      session: bundle.session.copyWith(revision: bundle.session.revision + 1),
      destinationChoices: _choices().copyWith(
        myPlaceId: id,
        myRevision: bundle.destinationChoices!.myRevision + 1,
        counts: {'a': id == 'a' ? 1 : 0, 'b': id == 'b' ? 1 : 0},
        chosenCount: 1,
        winnerPlaceId: id,
      ),
    );
    if (lostResponse) {
      pending.completeError(StateError('response lost'));
    } else {
      pending.complete(bundle);
    }
  }
}

DestinationChoiceState _choices() => DestinationChoiceState(
  eligiblePlaceIds: ['a', 'b'],
  counts: {'a': 0, 'b': 0},
  myRevision: 0,
  tiedPlaceIds: [],
  chosenCount: 0,
  participantCount: 2,
  canChoose: true,
  isComplete: false,
  hostBrokeTie: false,
);

PlaceSnapshot _place(String id) => PlaceSnapshot(
  placeId: id,
  name: 'Place $id',
  categoryIds: [],
  hours: [],
  distanceMeters: 1000,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: [],
  attributions: [],
  sourceCheckedAt: DateTime(2026),
  isStale: false,
  rating: id == 'a' ? 5 : 4,
);

SessionBundle _bundle() {
  final host = ParticipantView(
    participantId: 'host',
    displayName: 'Host',
    isHost: true,
    currentIndex: 10,
    hasCompleted: true,
    lastSeenAt: DateTime(2026),
  );
  return SessionBundle(
    session: SessionView(
      sessionId: 'room',
      code: 'ABC234',
      mode: SessionMode.multiplayer,
      categoryId: 'restaurant',
      subcategoryIds: [],
      anchorLatitude: 24.7,
      anchorLongitude: 46.6,
      countryCode: 'SA',
      radiusMeters: 1500,
      deckSizeRequested: 10,
      deckSizeActual: 10,
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.afterDeck,
      status: SessionStatus.active,
      revision: 1,
      createdAt: DateTime(2026),
      expiresAt: DateTime(2027),
    ),
    deck: [_place('a'), _place('b')],
    participants: [
      host,
      host.copyWith(
        participantId: 'guest',
        displayName: 'Guest',
        isHost: false,
      ),
    ],
    selfParticipant: host,
    destinationChoices: _choices(),
  );
}
