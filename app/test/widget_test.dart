import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/app.dart';

void main() {
  testWidgets('app honors 200% system text and keeps home actions reachable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const ProviderScope(child: HayerApp()));
    await tester.pumpAndSettle();
    final title = find.text('Hayer').first;
    expect(MediaQuery.textScalerOf(tester.element(title)).scale(16), 32);
    await tester.ensureVisible(find.text('Join a session'));
    await tester.pumpAndSettle();
    expect(find.text('Join a session').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home offers create and join actions', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: HayerApp()));
    await tester.pumpAndSettle();

    expect(find.text('Hayer'), findsWidgets);
    expect(find.text('New search'), findsOneWidget);
    expect(find.text('Join a session'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.system,
    );

    await tester.tap(find.byKey(const ValueKey('theme-toggle')));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
}
