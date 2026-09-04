import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/session_qr_code.dart';

void main() {
  test('uses the public join URL without the web app mount path', () {
    final uri = sessionJoinUri('q3w');

    expect(uri.toString(), 'https://hayer.almou.sa/join/Q3W');
    expect(uri.pathSegments, ['join', 'Q3W']);
  });

  testWidgets('renders a session-specific join QR code', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(child: SessionQrCode(code: 'Q3W')),
      ),
    );

    expect(find.byKey(const ValueKey('session-qr-Q3W')), findsOneWidget);
    expect(find.bySemanticsLabel('Join session Q3W'), findsOneWidget);
  });
}
