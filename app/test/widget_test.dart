import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/app.dart';

void main() {
  testWidgets('app honors 200% system text and keeps WHAT reachable', (
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
    final title = find.text('WHAT?').first;
    expect(
      MediaQuery.textScalerOf(tester.element(title)).scale(16),
      greaterThan(16),
    );
    await tester.ensureVisible(
      find.byKey(const ValueKey('intent-category-search')),
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('intent-category-search')).hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('WHAT offers category, join and saved actions', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProviderScope(child: HayerApp()));
    await tester.pumpAndSettle();

    expect(find.text('WHAT?'), findsOneWidget);
    expect(find.text('What are you in the mood for?'), findsOneWidget);
    expect(find.byTooltip('Join'), findsOneWidget);
    expect(find.byTooltip('Saved'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.system,
    );

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Light / Dark'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
}
