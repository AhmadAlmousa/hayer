import 'package:material_ui/material_ui.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/theme.dart';
import 'package:hayer_app/features/swipe/place_deck_swiper.dart';
import 'package:hayer_app/core/widgets/place_details_sheet.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  for (final locale in ['en', 'ar']) {
    testWidgets('details return to the same card without voting ($locale)', (
      tester,
    ) async {
      final controller = CardSwiperController();
      addTearDown(controller.dispose);
      final decisions = <(int, bool)>[];
      final haptics = <bool>[];
      final detailsOpened = <int>[];
      final detailsClosed = <int>[];
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: HayerTheme.light(),
            locale: Locale(locale),
            localizationsDelegates: hayerLocalizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: PlaceDeckSwiper(
                sessionId: 'session-1',
                places: [
                  _place('first').copyWith(formattedAddress: 'Full address'),
                  _place('second'),
                ],
                initialIndex: 0,
                controller: controller,
                disabled: false,
                routeOrigin: RouteOriginMode.sessionAnchor,
                routeEstimatesEnabled: false,
                onHaptic: (liked) async => haptics.add(liked),
                onDetailsOpened: detailsOpened.add,
                onDetailsClosed: detailsClosed.add,
                onDecision: (index, liked) {
                  decisions.add((index, liked));
                  return true;
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final details = find.descendant(
        of: find.byKey(const ValueKey('place-card-first')),
        matching: find.text(locale == 'en' ? 'Details' : 'التفاصيل'),
      );
      await tester.tap(details);
      await tester.pumpAndSettle();
      expect(find.byType(PlaceDetailsSheet), findsOneWidget);
      expect(find.text('Full address'), findsOneWidget);
      expect(decisions, isEmpty);
      expect(haptics, isEmpty);
      expect(detailsOpened, [0]);
      expect(detailsClosed, isEmpty);
      Navigator.of(tester.element(find.byType(PlaceDetailsSheet))).pop();
      await tester.pumpAndSettle();
      expect(find.byType(PlaceDetailsSheet), findsNothing);
      expect(detailsClosed, [0]);
      await tester.drag(
        find.byKey(const ValueKey('place-card-first')),
        const Offset(350, 0),
      );
      await tester.pumpAndSettle();
      expect(decisions, [(0, true)]);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('maps right and left gestures to like and pass decisions', (
    tester,
  ) async {
    final controller = CardSwiperController();
    addTearDown(controller.dispose);
    final decisions = <(int, bool)>[];
    final haptics = <bool>[];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: HayerTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 700,
              child: PlaceDeckSwiper(
                sessionId: 'session-1',
                places: [_place('first'), _place('second')],
                initialIndex: 0,
                controller: controller,
                disabled: false,
                routeOrigin: RouteOriginMode.sessionAnchor,
                routeEstimatesEnabled: false,
                onHaptic: (liked) async => haptics.add(liked),
                onDecision: (index, liked) {
                  decisions.add((index, liked));
                  return true;
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.drag(
      find.byKey(const ValueKey('place-card-first')),
      const Offset(300, 0),
    );
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const ValueKey('place-card-second')),
      const Offset(-300, 0),
    );
    await tester.pumpAndSettle();

    expect(decisions, [(0, true), (1, false)]);
    expect(haptics, [true, false]);
  });

  testWidgets('fires haptic while the finger is still dragging', (
    tester,
  ) async {
    // Behavior under test: crossing the intent threshold gives feedback before
    // the pointer is lifted and before the swipe decision is submitted.
    // Arrange
    final controller = CardSwiperController();
    addTearDown(controller.dispose);
    final haptics = <bool>[];
    final decisions = <(int, bool)>[];
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: PlaceDeckSwiper(
              sessionId: 'session-1',
              places: [_place('first')],
              initialIndex: 0,
              controller: controller,
              disabled: false,
              routeOrigin: RouteOriginMode.sessionAnchor,
              routeEstimatesEnabled: false,
              onHaptic: (liked) async => haptics.add(liked),
              onDecision: (index, liked) {
                decisions.add((index, liked));
                return true;
              },
            ),
          ),
        ),
      ),
    );

    // Act
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const ValueKey('place-card-first'))),
    );
    await gesture.moveBy(const Offset(30, 0));
    await tester.pump();
    await gesture.moveBy(const Offset(50, 0));
    await tester.pump();

    // Assert
    expect(haptics, [true]);
    expect(decisions, isEmpty);
    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('can return to the previous card for a revised decision', (
    tester,
  ) async {
    final controller = CardSwiperController();
    addTearDown(controller.dispose);
    final decisions = <(int, bool)>[];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: HayerTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 700,
              child: PlaceDeckSwiper(
                sessionId: 'session-1',
                places: [_place('first'), _place('second')],
                initialIndex: 0,
                controller: controller,
                disabled: false,
                routeOrigin: RouteOriginMode.sessionAnchor,
                routeEstimatesEnabled: false,
                onHaptic: (_) async {},
                onDecision: (index, liked) {
                  decisions.add((index, liked));
                  return true;
                },
              ),
            ),
          ),
        ),
      ),
    );

    controller.swipe(CardSwiperDirection.right);
    await tester.pumpAndSettle();
    controller.moveTo(0);
    await tester.pumpAndSettle();
    controller.swipe(CardSwiperDirection.left);
    await tester.pumpAndSettle();

    expect(decisions, [(0, true), (0, false)]);
  });
}

PlaceSnapshot _place(String id) => PlaceSnapshot(
  placeId: id,
  name: id,
  categoryIds: const ['restaurant'],
  hours: const [],
  distanceMeters: 100,
  latitude: 24.7136,
  longitude: 46.6753,
  photoUrls: const [],
  attributions: const ['Google Maps'],
  sourceCheckedAt: DateTime.utc(2026, 9),
  isStale: false,
);
