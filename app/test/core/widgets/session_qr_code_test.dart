import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/session_qr_code.dart';

void main() {
  test('uses the public join URL without the web app mount path', () {
    final uri = sessionJoinUri('a37');

    expect(uri.toString(), 'https://hayer.almou.sa/join/A37');
    expect(uri.pathSegments, ['join', 'A37']);
  });

  testWidgets('renders a session-specific join QR code', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(child: SessionQrCode(code: 'A37')),
      ),
    );

    expect(find.byKey(const ValueKey('session-qr-A37')), findsOneWidget);
    expect(find.bySemanticsLabel('Join session A37'), findsOneWidget);
  });
}
