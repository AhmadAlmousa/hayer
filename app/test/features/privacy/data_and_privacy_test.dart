import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/device_data_repository.dart';
import 'package:hayer_app/data/discovery_area_store.dart';
import 'package:hayer_app/data/display_name_store.dart';
import 'package:hayer_app/data/pending_discovery_link_store.dart';
import 'package:hayer_app/data/pending_swipe_store.dart';
import 'package:hayer_app/data/saved_place_store.dart';
import 'package:hayer_app/data/session_repository.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_app/features/privacy/data_and_privacy_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  test('erasing clears every device store and the anonymous sign-in', () async {
    final fixture = _Fixture()..seed();

    await fixture.repository.eraseDeviceData();

    expect(fixture.savedPlaces.places, isEmpty);
    expect(fixture.displayNames.value, isNull);
    expect(fixture.outbox.records, isEmpty);
    expect(fixture.storage.values, isEmpty);
    expect(fixture.signOutCount, 1);
  });

  test('a device with nothing stored erases without error', () async {
    final fixture = _Fixture();

    await fixture.repository.eraseDeviceData();

    expect(fixture.signOutCount, 1);
  });

  test('undelivered swipes are counted before anything is destroyed', () async {
    final fixture = _Fixture()..seed();

    expect(await fixture.repository.pendingSwipeCount(), 1);
    // Counting must never be the reason an erase cannot be offered.
    expect(
      await _Fixture(failingOutbox: true).repository.pendingSwipeCount(),
      0,
    );
  });

  testWidgets('the screen accounts for each place data goes', (tester) async {
    final fixture = _Fixture();
    await _pump(tester, fixture);

    final strings = await AppLocalizations.delegate.load(const Locale('en'));
    for (final section in [
      strings.dataIdentityTitle,
      strings.dataLocationTitle,
      strings.dataGroupTitle,
      strings.dataDeviceTitle,
      strings.dataMeasurementTitle,
      strings.dataEraseTitle,
    ]) {
      expect(find.text(section), findsOneWidget);
    }
    // The providers a place's details and address come from are named, since
    // that is what leaves Hayer.
    expect(find.textContaining('OpenStreetMap'), findsOneWidget);
    expect(find.textContaining('Google Maps'), findsOneWidget);
    // Explore sends the map area searched, not the device position, and
    // keeps the last area and a kept link here, which an erase removes.
    expect(
      find.textContaining('Hayer receives the map area you search'),
      findsOneWidget,
    );
    expect(
      find.textContaining('the last area you searched in Explore'),
      findsOneWidget,
    );
    expect(
      find.textContaining('the last Explore area and any kept Explore link'),
      findsOneWidget,
    );
  });

  testWidgets('erasing asks first, and keeping data changes nothing', (
    tester,
  ) async {
    final fixture = _Fixture()..seed();
    await _pump(tester, fixture);

    await tester.tap(find.byKey(const ValueKey('erase-device-data')));
    await tester.pumpAndSettle();
    // A queued swipe is the one thing an erase destroys that the server has
    // never seen, so the question says so.
    expect(find.byKey(const ValueKey('erase-pending-warning')), findsOneWidget);

    await tester.tap(find.text('Keep data'));
    await tester.pumpAndSettle();

    expect(fixture.savedPlaces.places, isNotEmpty);
    expect(fixture.outbox.records, isNotEmpty);
    expect(fixture.signOutCount, 0);
  });

  testWidgets('confirming erases the device and says so', (tester) async {
    final fixture = _Fixture()..seed();
    await _pump(tester, fixture);

    await tester.tap(find.byKey(const ValueKey('erase-device-data')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('erase-device-data-confirm')));
    await tester.pumpAndSettle();

    expect(fixture.savedPlaces.places, isEmpty);
    expect(fixture.displayNames.value, isNull);
    expect(fixture.outbox.records, isEmpty);
    expect(fixture.signOutCount, 1);
    expect(find.text('Data on this device was erased.'), findsOneWidget);
  });

  for (final locale in ['en', 'ar']) {
    testWidgets('the account reads on a small screen at 200% text in $locale', (
      tester,
    ) async {
      final fixture = _Fixture();
      await _pump(
        tester,
        fixture,
        locale: locale,
        size: const Size(320, 640),
        scale: 2,
      );

      // Every section is reachable by scrolling rather than clipped, in both
      // directions of text.
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('erase-device-data')),
        400,
        maxScrolls: 60,
      );
      expect(tester.takeException(), isNull);
      expect(
        Directionality.of(
          tester.element(find.byKey(const ValueKey('erase-device-data'))),
        ),
        locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      );
    });
  }

  testWidgets('a failed erase says so instead of claiming success', (
    tester,
  ) async {
    final fixture = _Fixture(failingSignOut: true)..seed();
    await _pump(tester, fixture);

    await tester.tap(find.byKey(const ValueKey('erase-device-data')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('erase-device-data-confirm')));
    await tester.pumpAndSettle();

    expect(
      find.text('Could not erase everything. Please try again.'),
      findsOneWidget,
    );
  });
}

Future<void> _pump(
  WidgetTester tester,
  _Fixture fixture, {
  String locale = 'en',
  // The account runs longer than a phone screen; by default the whole of it is
  // pumped so a section is never missed just because it is below the fold.
  Size size = const Size(800, 2200),
  double scale = 1,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        deviceDataRepositoryProvider.overrideWithValue(fixture.repository),
      ],
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        ),
        home: const DataAndPrivacyScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _Fixture {
  _Fixture({this.failingSignOut = false, bool failingOutbox = false})
    : outbox = _MemoryPendingSwipeStore(failing: failingOutbox);

  final bool failingSignOut;
  final savedPlaces = _MemorySavedPlaceStore();
  final displayNames = _MemoryDisplayNameStore();
  final _MemoryPendingSwipeStore outbox;
  final storage = _MemorySecureStorage();
  int signOutCount = 0;

  late final DeviceDataRepository repository = DeviceDataRepository(
    signOut: () async {
      signOutCount++;
      if (failingSignOut) throw StateError('sign-out unavailable');
    },
    savedPlaces: savedPlaces,
    displayNames: displayNames,
    outbox: outbox,
    secureStorage: storage,
  );

  void seed() {
    savedPlaces.places = [
      SavedPlace(
        place: PlaceSnapshot(
          placeId: 'a',
          name: 'Place a',
          categoryIds: const ['cafe'],
          hours: const [],
          distanceMeters: 100,
          latitude: 24.7,
          longitude: 46.7,
          photoUrls: const [],
          attributions: const ['Google'],
          sourceCheckedAt: DateTime.utc(2026, 9, 10),
          isStale: false,
        ),
        collection: SavedPlaceCollection.wantToTry,
        note: 'Private note',
        savedAt: DateTime.utc(2026, 9, 10),
        updatedAt: DateTime.utc(2026, 9, 10),
      ),
    ];
    displayNames.value = 'Ahmad';
    outbox.records.add(
      PendingSwipeRecord(
        idempotencyKey: 'key',
        sessionId: 'session',
        placeId: 'a',
        liked: true,
        swipeIndex: 0,
        clientSwipedAt: DateTime.utc(2026, 9, 10),
      ),
    );
    storage.values[SessionRepository.activeSessionKey] = 'session';
    storage.values[SecurePendingDiscoveryLinkStore.storageKey] =
        '/discover?v=1';
    storage.values[SecureDiscoveryAreaStore.storageKey] = '24.6,46.6,24.8,46.8';
  }
}

class _MemorySavedPlaceStore implements SavedPlaceStore {
  List<SavedPlace> places = [];

  @override
  Future<List<SavedPlace>> read() async => places;

  @override
  Future<void> write(List<SavedPlace> value) async => places = [...value];

  @override
  Future<void> close() async {}
}

class _MemoryDisplayNameStore implements DisplayNameStore {
  String? value;

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String displayName) async => value = displayName;

  @override
  Future<void> clear() async => value = null;
}

class _MemoryPendingSwipeStore implements PendingSwipeStore {
  _MemoryPendingSwipeStore({this.failing = false});

  final bool failing;
  final records = <PendingSwipeRecord>[];

  @override
  Future<void> enqueue(PendingSwipeRecord record) async => records.add(record);

  @override
  Future<List<PendingSwipeRecord>> queued() async {
    if (failing) throw StateError('queue unreadable');
    return records;
  }

  @override
  Future<void> remove(String idempotencyKey) async => records.removeWhere(
    (record) => record.idempotencyKey == idempotencyKey,
  );

  @override
  Future<void> markTerminal(String idempotencyKey, String errorCode) async {}

  @override
  Future<void> removeTerminalDecision(String sessionId, int swipeIndex) async {}

  @override
  Future<void> removeSession(String sessionId) async =>
      records.removeWhere((record) => record.sessionId == sessionId);

  @override
  Future<void> clear() async => records.clear();

  @override
  Future<void> close() async {}
}

class _MemorySecureStorage implements FlutterSecureStorage {
  final values = <String, String>{};

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => values.remove(key);

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('${invocation.memberName} is not used here');
}
