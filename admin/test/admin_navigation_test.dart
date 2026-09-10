import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/navigation/admin_navigation.dart';

void main() {
  test('destinations are declared once, in one order', () {
    // The router indexes `adminRoutes` with the index the navigation reports,
    // so the two lists have to describe the same destinations in the same
    // order. They used to be separate hardcoded lists.
    expect(adminRoutes.length, adminDestinations.length);
    for (var i = 0; i < adminRoutes.length; i++) {
      expect(adminRoutes[i], adminDestinations[i].route);
    }
    expect(adminRoutes.toSet().length, adminRoutes.length);
    expect(adminRoutes.every((route) => route.startsWith('/')), isTrue);
  });

  test('every destination belongs to exactly one titled group', () {
    final grouped = [
      for (final group in adminNavigationGroups) ...group.destinations,
    ];

    // Group membership was a hardcoded index range over a flat list, so a page
    // added in the middle silently changed the heading of the pages after it.
    expect(grouped.length, adminDestinations.length);
    expect(
      adminNavigationGroups.every((group) => group.destinations.isNotEmpty),
      isTrue,
    );
    expect(
      adminNavigationGroups.map((group) => group.title).toSet().length,
      adminNavigationGroups.length,
    );
  });

  testWidgets('a destination announces its name and whether it is current', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await _pumpNavigation(tester, selectedIndex: 1);

    // Which page an operator is on was carried by colour alone.
    final current = tester.getSemantics(
      find.byKey(const Key('admin-rail-/usage')),
    );
    expect(current.label, 'Usage');
    expect(current.flagsCollection.isButton, isTrue);
    expect(current.flagsCollection.isSelected, Tristate.isTrue);
    expect(
      tester
          .getSemantics(find.byKey(const Key('admin-rail-/overview')))
          .flagsCollection
          .isSelected,
      Tristate.isFalse,
    );
    handle.dispose();
  });

  testWidgets('a heading introduces each run of destinations', (tester) async {
    await _pumpNavigation(tester, selectedIndex: 0);

    for (final group in adminNavigationGroups) {
      expect(find.text(group.title.toUpperCase()), findsOneWidget);
    }
    for (final destination in adminDestinations) {
      expect(find.text(destination.label), findsOneWidget);
    }
  });

  testWidgets('a tap reports the index the router indexes routes with', (
    tester,
  ) async {
    final selected = <int>[];
    await _pumpNavigation(tester, selectedIndex: 0, onSelect: selected.add);

    // Group headings sit between destinations, so a heading must not consume
    // an index the router would then resolve to the wrong page.
    await tester.tap(find.byKey(Key('admin-rail-${adminRoutes.last}')));
    await tester.tap(find.byKey(const Key('admin-rail-/reports')));
    await tester.pump();

    expect(selected, [adminRoutes.length - 1, adminRoutes.indexOf('/reports')]);
  });

  testWidgets('the navigation still fits its column at 200% text', (
    tester,
  ) async {
    await _pumpNavigation(tester, selectedIndex: 0, textScale: 2);

    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpNavigation(
  WidgetTester tester, {
  required int selectedIndex,
  ValueChanged<int>? onSelect,
  double textScale = 1,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(1400, 900);
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: Scaffold(
          body: Row(
            children: [
              AdminSideNavigation(
                selectedIndex: selectedIndex,
                onSelect: onSelect ?? (_) {},
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
