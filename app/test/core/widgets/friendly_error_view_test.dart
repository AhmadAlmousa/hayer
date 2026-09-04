import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/friendly_error_view.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('hides technical details in the release-safe view', (
    tester,
  ) async {
    // Behavior under test: users get recovery guidance, not an exception dump.
    await tester.pumpWidget(
      SizedBox(
        width: 400,
        height: 700,
        child: FriendlyErrorView(
          details: FlutterErrorDetails(exception: StateError('secret detail')),
          showDiagnostics: false,
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.textContaining('secret detail'), findsNothing);
  });

  testWidgets('uses a compact fallback inside a small broken region', (
    tester,
  ) async {
    await tester.pumpWidget(
      Center(
        child: SizedBox(
          width: 120,
          height: 100,
          child: FriendlyErrorView(
            details: FlutterErrorDetails(exception: Exception('broken')),
            showDiagnostics: true,
          ),
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.textContaining('broken'), findsOneWidget);
    expect(find.byType(CustomScrollView), findsNothing);
  });
}
