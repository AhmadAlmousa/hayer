import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/app/app.dart';

void main() {
  testWidgets('home offers create and join actions', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HayerApp()));
    await tester.pumpAndSettle();

    expect(find.text('Hayer'), findsWidgets);
    expect(find.text('New search'), findsOneWidget);
    expect(find.text('Join a session'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.system,
    );
  });
}
