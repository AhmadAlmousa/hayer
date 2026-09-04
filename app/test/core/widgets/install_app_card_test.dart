import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/install_app_card.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('shows the badge for the selected device family', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: InstallAppCard(platform: StoreBadgePlatform.apple),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('app-store-badge')), findsOneWidget);
    expect(find.byKey(const ValueKey('google-play-badge')), findsNothing);
    expect(find.text('Enjoyed deciding with Hayer?'), findsOneWidget);
  });
}
