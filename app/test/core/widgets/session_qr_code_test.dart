import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/session_qr_code.dart';

void main() {
  test('uses the deployed web app join route', () {
    final uri = sessionJoinUri('z70');

    expect(uri.toString(), 'https://hayer.almou.sa/app/join/Z70');
    expect(uri.pathSegments, ['app', 'join', 'Z70']);
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
