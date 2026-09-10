import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/core/providers.dart';
import 'package:hayer_app/data/saved_place_store.dart';
import 'package:hayer_app/data/saved_places_repository.dart';
import 'package:hayer_app/domain/saved_place.dart';
import 'package:hayer_app/domain/shortlist_draft.dart';
import 'package:hayer_app/features/saved/save_place_button.dart';
import 'package:hayer_app/features/saved/saved_places_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('saving a place is local-first and can be undone', (
    tester,
  ) async {
    final store = _MemorySavedPlaceStore();
    final repository = SavedPlacesRepository(store: store);
    await _pump(
      tester,
      repository: repository,
      home: SavePlaceButton(place: _place('a')),
    );

    await tester.tap(find.text('Save place'));
    await tester.pumpAndSettle();
    expect(store.places.single.place.placeId, 'a');
    expect(find.text('Remove from saved places'), findsOneWidget);

    await tester.tap(find.text('Remove from saved places'));
    await tester.pumpAndSettle();
    expect(store.places, isEmpty);
    expect(find.text('Save place'), findsOneWidget);
  });

  testWidgets('saved screen explains privacy and starts selected shortlist', (
    tester,
  ) async {
    final store = _MemorySavedPlaceStore()..places = [_saved('a'), _saved('b')];
    final repository = SavedPlacesRepository(store: store);
    late ShortlistDraft openedDraft;
    final router = GoRouter(
      initialLocation: '/saved',
      routes: [
        GoRoute(
          path: '/saved',
          builder: (_, _) => const SavedPlacesScreen(),
          routes: [
            GoRoute(
              path: 'start',
              builder: (_, state) {
                openedDraft = state.extra! as ShortlistDraft;
                return const Scaffold(body: Text('Shortlist setup opened'));
              },
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await _pump(tester, repository: repository, router: router);

    expect(find.text('Private on this device'), findsOneWidget);
    expect(find.textContaining('not synced or exportable'), findsOneWidget);
    await tester.tap(find.byType(Checkbox).at(0));
    await tester.pump();
    await tester.tap(find.byType(Checkbox).at(1));
    await tester.pump();
    expect(find.text('2 selected'), findsOneWidget);
    await tester.tap(find.text('Start shortlist (2)'));
    await tester.pumpAndSettle();

    expect(find.text('Shortlist setup opened'), findsOneWidget);
    expect(openedDraft.places.map((saved) => saved.place.placeId), {'a', 'b'});
  });

  testWidgets('collection and private note are editable on device', (
    tester,
  ) async {
    final store = _MemorySavedPlaceStore()..places = [_saved('a')];
    final repository = SavedPlacesRepository(store: store);
    await _pump(
      tester,
      repository: repository,
      home: const SavedPlacesScreen(),
    );

    await tester.tap(find.byTooltip('Edit saved place'));
    await tester.pumpAndSettle();
    final dialog = find.byType(AlertDialog);
    await tester.tap(
      find.descendant(of: dialog, matching: find.text('Favorites')),
    );
    await tester.enterText(find.byType(TextField), 'Window seat');
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();

    expect(store.places.single.collection, SavedPlaceCollection.favorites);
    expect(store.places.single.note, 'Window seat');
  });

  testWidgets('a saved thumbnail decodes at thumbnail size', (tester) async {
    // Photos arrive 1600 pixels wide, which is about 6.8 MB of bitmap for a
    // 48-pixel square that the image cache would then hold per saved row.
    final store = _MemorySavedPlaceStore()
      ..places = [
        _saved('a').copyWith(
          place: _place(
            'a',
          ).copyWith(photoUrls: ['https://example.invalid/photo.jpg']),
        ),
      ];
    await _pump(
      tester,
      repository: SavedPlacesRepository(store: store),
      home: const SavedPlacesScreen(),
    );

    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(image.memCacheWidth, isNotNull);
    // 1600 is the width the extractor requests every photo at, in
    // backend/hayer_server/lib/src/places/search_parser.dart.
    expect(image.memCacheWidth, lessThan(1600));
    expect(image.memCacheHeight, isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  required SavedPlacesRepository repository,
  Widget? home,
  GoRouter? router,
}) async {
  final app = router == null
      ? MaterialApp(
          theme: HayerTheme.light(),
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: home),
        )
      : MaterialApp.router(
          theme: HayerTheme.light(),
          localizationsDelegates: hayerLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        savedPlacesRepositoryProvider.overrideWithValue(repository),
      ],
      child: app,
    ),
  );
  await tester.pumpAndSettle();
}

SavedPlace _saved(String id) => SavedPlace(
  place: _place(id),
  collection: SavedPlaceCollection.wantToTry,
  savedAt: DateTime.utc(2026, 9, 8),
  updatedAt: DateTime.utc(2026, 9, 8),
);

PlaceSnapshot _place(String id) => PlaceSnapshot(
  placeId: id,
  name: 'Place $id',
  categoryIds: const ['cafe'],
  hours: const [],
  distanceMeters: 100,
  latitude: 24.7136 + (id == 'a' ? 0 : .001),
  longitude: 46.6753,
  photoUrls: const [],
  attributions: const [],
  sourceCheckedAt: DateTime.utc(2026, 9, 8),
  isStale: false,
);

final class _MemorySavedPlaceStore implements SavedPlaceStore {
  List<SavedPlace> places = [];

  @override
  Future<List<SavedPlace>> read() async => [...places];

  @override
  Future<void> write(List<SavedPlace> places) async {
    this.places = [...places];
  }

  @override
  Future<void> close() async {}
}
