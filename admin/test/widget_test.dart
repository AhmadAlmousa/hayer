import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/admin_app.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('shows protected operations login', (tester) async {
    await tester.pumpWidget(AdminApp(client: Client('http://localhost:8080/')));

    expect(find.text('Hayer Cache Operations'), findsOneWidget);
    expect(find.text('Operator name'), findsOneWidget);
    expect(find.text('Gateway secret'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });
}
