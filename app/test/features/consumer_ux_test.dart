import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hayer_app/app/startup_app.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/display_formatters.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/core/widgets/route_estimate_text.dart';
import 'package:hayer_app/core/widgets/search_area_map.dart';
import 'package:hayer_app/core/widgets/session_recovery.dart';
import 'package:hayer_app/data/location_repository.dart';
import 'package:hayer_app/data/location_warmup.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_app/features/join/join_screen.dart';
import 'package:hayer_app/features/lobby/lobby_screen.dart';
import 'package:hayer_app/features/results/results_screen.dart';
import 'package:hayer_app/features/setup/setup_screen.dart';
import 'package:hayer_app/features/swipe/swipe_screen.dart';
import 'package:hayer_app/features/swipe/place_card.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:material_ui/material_ui.dart';

import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

void main() {
  setUp(() {
    FlutterSecureStorage.setMockInitialValues({});
    final original = MapLibrePlatform.createInstance;
    MapLibrePlatform.createInstance = _MapPlatform.new;
    addTearDown(() => MapLibrePlatform.createInstance = original);
  });

  testWidgets('startup renders immediately and retries initialization', (
    tester,
  ) async {
    final first = Completer<Widget>();
    final retry = Completer<Widget>();
    var calls = 0;
    await tester.pumpWidget(
      StartupApp(
        initialize: () {
          calls++;
          return calls == 1 ? first.future : retry.future;
        },
      ),
    );
    await tester.pump();
    expect(find.text('Getting Hayer ready…'), findsOneWidget);
    first.completeError(StateError('offline'));
    await tester.pumpAndSettle();
    expect(find.text('Try again'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    await tester.pump();
    expect(find.text('Try again'), findsNothing);
    expect(find.text('Getting Hayer ready…'), findsOneWidget);
    retry.complete(const SizedBox(key: ValueKey('ready')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('ready')), findsOneWidget);
    expect(calls, 2);
  });

  for (final locale in ['en', 'ar']) {
    for (final size in [const Size(320, 640), const Size(640, 320)]) {
      testWidgets('results are lazy and readable at 200% $locale $size', (
        tester,
      ) async {
        final fixture = _Fixture();
        await _pump(
          tester,
          fixture,
          const ResultsScreen(sessionId: 'room'),
          locale: locale,
          size: size,
          scale: 2,
        );
        _expectNoLayoutErrors(tester);
        expect(find.byType(RouteEstimateText).evaluate().length, lessThan(10));
        await tester.scrollUntilVisible(
          find.byKey(const ValueKey('place-49')),
          450,
          scrollable: find.byType(Scrollable).first,
          maxScrolls: 150,
        );
        expect(find.text(_place(49).name), findsOneWidget);
        final title = tester.widget<Text>(find.text(_place(49).name));
        expect(title.maxLines, isNull);
        expect(tester.takeException(), isNull);
        await _dispose(tester, fixture);
      });
    }

    testWidgets(
      'setup and join fit narrow screens at 200% $locale with keyboard',
      (tester) async {
        final fixture = _Fixture();
        await _pump(
          tester,
          fixture,
          const SetupScreen(),
          locale: locale,
          scale: 2,
        );
        expect(tester.takeException(), isNull);
        final strings = await AppLocalizations.delegate.load(Locale(locale));
        final category = find.text(locale == 'ar' ? 'مطاعم' : 'Restaurants');
        await tester.ensureVisible(category);
        await tester.pumpAndSettle();
        await tester.tap(category);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.tap(find.text(strings.continueLabel));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.tap(find.text(strings.continueLabel));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox.shrink());
        await _pump(
          tester,
          fixture,
          const JoinScreen(initialCode: 'ABC234'),
          locale: locale,
          scale: 2,
          keyboard: 220,
        );
        expect(tester.takeException(), isNull);
        await _dispose(tester, fixture);
      },
    );

    testWidgets('swipe content scrolls without truncation at 200% $locale', (
      tester,
    ) async {
      final fixture = _Fixture();
      await _pump(
        tester,
        fixture,
        Scaffold(
          body: SizedBox(
            height: 260,
            child: PlaceCard(
              place: _place(0),
              sessionId: 'room',
              routeOrigin: RouteOriginMode.sessionAnchor,
              routeEstimatesEnabled: false,
            ),
          ),
        ),
        locale: locale,
        scale: 2,
      );
      expect(
        find.byKey(const ValueKey('readable-place-place-0')),
        findsOneWidget,
      );
      expect(tester.widget<Text>(find.text(_place(0).name)).maxLines, isNull);
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await _dispose(tester, fixture);
    });
  }

  for (final screen in [
    const LobbyScreen(sessionId: 'room'),
    const ResultsScreen(sessionId: 'room'),
    const SwipeScreen(sessionId: 'room'),
  ]) {
    testWidgets('${screen.runtimeType} recovers from an initial load failure', (
      tester,
    ) async {
      final fixture = _Fixture()..repository.fail = true;
      await _pump(tester, fixture, screen);
      expect(find.byType(SessionRecovery), findsOneWidget);
      expect(find.text('Back to home'), findsOneWidget);
      fixture.repository.fail = false;
      await tester.tap(find.text('Try again'));
      await tester.pumpAndSettle();
      expect(find.byType(SessionRecovery), findsNothing);
      expect(tester.takeException(), isNull);
      await _dispose(tester, fixture);
    });
  }

  testWidgets('lobby participant and sharing controls fit Arabic large text', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(
      tester,
      fixture,
      const LobbyScreen(sessionId: 'room'),
      locale: 'ar',
      scale: 2,
    );
    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await _dispose(tester, fixture);
  });

  testWidgets(
    'large text place details remain readable after opening a result',
    (tester) async {
      final fixture = _Fixture();
      await _pump(
        tester,
        fixture,
        const ResultsScreen(sessionId: 'room'),
        locale: 'ar',
        scale: 2,
      );
      await tester.scrollUntilVisible(
        find.text(_place(0).name),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tapAt(
        tester.getTopLeft(find.text(_place(0).name)) + const Offset(5, 5),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);
      expect(tester.takeException(), isNull);
      await _dispose(tester, fixture);
    },
  );

  testWidgets('results retain visible picks when a refresh fails', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture, const ResultsScreen(sessionId: 'room'));
    fixture.repository.fail = true;
    fixture.endpoint.events.add(
      SessionEvent(
        sessionId: 'room',
        type: SessionEventType.resultsChanged,
        revision: 2,
        occurredAt: DateTime(2026),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Updates paused. Showing the last saved session information.'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text(_place(0).name),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(_place(0).name), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, 800));
    await tester.pumpAndSettle();
    fixture.repository.fail = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.byType(SessionRecovery), findsNothing);
    await _dispose(tester, fixture);
  });

  testWidgets(
    'GPS remains selected when enrichment fails and search is retryable',
    (tester) async {
      final fixture = _Fixture();
      await _pump(tester, fixture, const SetupScreen());
      await tester.tap(find.text('Restaurants'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      final map = tester.widget<SearchAreaMap>(find.byType(SearchAreaMap));
      expect(map.latitude, 24.7);
      expect(map.longitude, 46.6);
      fixture.locations.address.completeError(StateError('geocoder down'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<SearchAreaMap>(find.byType(SearchAreaMap)).latitude,
        24.7,
      );
      final search = find.byType(TextField).first;
      fixture.locations.failSearch = true;
      await tester.enterText(search, 'Riyadh');
      await tester.pump(const Duration(milliseconds: 351));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'Location search is unavailable. Try again or use your current location.',
        ),
        findsOneWidget,
      );
      expect(tester.widget<TextField>(search).controller!.text, 'Riyadh');
      fixture.locations.failSearch = false;
      await tester.tap(find.text('Try again'));
      await tester.pump(const Duration(milliseconds: 351));
      await tester.pumpAndSettle();
      expect(
        find.text(
          'No locations found. Try a different area or use your current location.',
        ),
        findsOneWidget,
      );
      await _dispose(tester, fixture);
    },
  );

  testWidgets('late address enrichment cannot overwrite typed search', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(tester, fixture, const SetupScreen());
    await tester.tap(find.text('Restaurants'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'جدة');
    fixture.locations.address.complete('Old address');
    await tester.pump(const Duration(milliseconds: 351));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      'جدة',
    );
    expect(tester.takeException(), isNull);
    await _dispose(tester, fixture);
  });

  testWidgets('fractional radius uses localized numbers and units', (
    tester,
  ) async {
    final fixture = _Fixture();
    await _pump(
      tester,
      fixture,
      Builder(builder: (context) => Text(formatDistance(context, 1500))),
      locale: 'ar',
    );
    expect(
      find.text('${NumberFormat('0.#', 'ar').format(1.5)} كم'),
      findsOneWidget,
    );
    await _dispose(tester, fixture);
  });
}

void _expectNoLayoutErrors(WidgetTester tester) {
  final error = tester.takeException();
  if (error != null) debugPrint(error.toString());
  expect(error, isNull);
}

Future<void> _pump(
  WidgetTester tester,
  _Fixture fixture,
  Widget screen, {
  String locale = 'en',
  Size size = const Size(320, 640),
  double scale = 1,
  double keyboard = 0,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(fixture.client),
        sessionRepositoryProvider.overrideWithValue(fixture.repository),
        locationWarmupProvider.overrideWithValue(_Location()),
        locationRepositoryProvider.overrideWithValue(fixture.locations),
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
            viewInsets: EdgeInsets.only(bottom: keyboard),
          ),
          child: child!,
        ),
        home: screen,
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
  final repository = _Repository();
  final endpoint = _Endpoint();
  late final client = _Client(endpoint);
  final locations = _Locations();
}

class _MapPlatform extends Fake implements MapLibrePlatform {
  @override
  Widget buildView(
    Map<String, dynamic> creationParams,
    OnPlatformViewCreatedCallback onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  ) => const SizedBox.expand();
  @override
  void dispose() {}
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
    for (var index = 0; index < 50; index++)
      SessionResult(
        place: _place(index),
        likeCount: 2,
        voterCount: 2,
        match: true,
        rank: index + 1,
      ),
  ];
}

class _Repository extends Fake implements SessionRepository {
  bool fail = false;
  @override
  Future<SessionBundle> load(String sessionId) async {
    if (fail) throw StateError('offline');
    return _bundle();
  }

  @override
  Future<QueueFlushResult> flushQueue() async => const QueueFlushResult(
    accepted: 0,
    pending: 0,
    terminalFailures: 0,
    pendingSessionIds: {},
    terminalFailureSessionIds: {},
    pendingProgressBySession: {},
  );
}

class _Locations extends Fake implements LocationRepository {
  final address = Completer<String>();
  bool failSearch = false;
  @override
  Future<String> reverseGeocode({
    required double latitude,
    required double longitude,
    required String languageCode,
  }) => address.future;
  @override
  Future<List<LocationSuggestion>> suggest({
    required String query,
    double? latitude,
    double? longitude,
  }) async {
    if (failSearch) throw StateError('search unavailable');
    return [];
  }
}

class _Location extends Fake implements LocationWarmup {
  @override
  Future<Position?> get ready async => null;
  @override
  Future<Position?> locate({
    bool requestPermission = false,
    bool refresh = false,
  }) async => Position(
    latitude: 24.7,
    longitude: 46.6,
    timestamp: DateTime(2026),
    accuracy: 30,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

PlaceSnapshot _place(int index) => PlaceSnapshot(
  placeId: 'place-$index',
  name: 'Restaurant $index — مطعم ذو اسم طويل في الرياض',
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 1500 + index,
  latitude: 24.7,
  longitude: 46.6,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime(2026),
  isStale: false,
  rating: 5 - index / 100,
  reviewCount: 1200,
  isOpen: true,
);

SessionBundle _bundle() {
  final participant = ParticipantView(
    participantId: 'host',
    displayName: 'Host',
    isHost: true,
    currentIndex: 0,
    hasCompleted: false,
    lastSeenAt: DateTime(2026),
  );
  return SessionBundle(
    session: SessionView(
      sessionId: 'room',
      code: 'ABC234',
      mode: SessionMode.multiplayer,
      categoryId: 'restaurant',
      subcategoryIds: const [],
      anchorLatitude: 24.7,
      anchorLongitude: 46.6,
      countryCode: 'SA',
      radiusMeters: 1500,
      deckSizeRequested: 50,
      deckSizeActual: 50,
      consensusRule: ConsensusRule.majority,
      matchingTiming: MatchingTiming.afterDeck,
      status: SessionStatus.active,
      revision: 1,
      createdAt: DateTime(2026),
      expiresAt: DateTime(2027),
    ),
    deck: [_place(0), _place(1)],
    participants: [participant],
    selfParticipant: participant,
  );
}
