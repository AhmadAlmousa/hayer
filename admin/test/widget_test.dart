import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/admin_app.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('opens dashboard directly after nginx authentication', (
    tester,
  ) async {
    await tester.pumpWidget(AdminApp(client: Client('http://localhost:8080/')));

    expect(find.text('Hayer Cache Operations'), findsOneWidget);
    expect(find.text('Operational overview'), findsOneWidget);
    expect(find.text('Operator name'), findsNothing);
    expect(find.text('Gateway secret'), findsNothing);
    expect(find.text('Sign in'), findsNothing);
  });
}
