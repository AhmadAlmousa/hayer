import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/session_qr_code.dart';

void main() {
  test('uses the deployed web app join route', () {
    final uri = sessionJoinUri('abc124');

    expect(uri.toString(), 'https://hayer.almou.sa/join/ABC-124');
    expect(uri.pathSegments, ['join', 'ABC-124']);
  });

  testWidgets('renders a session-specific join QR code', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(child: SessionQrCode(code: 'ABC124')),
      ),
    );

    expect(find.byKey(const ValueKey('session-qr-ABC124')), findsOneWidget);
    expect(find.bySemanticsLabel('Join session ABC-124'), findsOneWidget);
  });
}
