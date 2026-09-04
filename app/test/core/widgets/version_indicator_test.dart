import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/version_indicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  testWidgets('shows the installed version and build', (tester) async {
    // Behavior under test: QA can read an exact build identifier on Home.
    await tester.pumpWidget(
      MaterialApp(
        home: VersionIndicator(
          load: () async => PackageInfo(
            appName: 'Hayer',
            packageName: 'sa.almou.hayer',
            version: '1.4.0',
            buildNumber: '42',
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Hayer 1.4.0 (42)'), findsOneWidget);
  });
}
