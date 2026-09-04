import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/home/resume_session_button.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('resume action includes mode and creation time', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ResumeSessionButton(
            bundle: _bundle(),
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('Resume session'), findsOneWidget);
    expect(find.textContaining('Solo session'), findsOneWidget);
    expect(find.textContaining('Created'), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
  });
}

SessionBundle _bundle() => SessionBundle(
  session: SessionView(
    sessionId: 'session-1',
    code: 'ABC234',
    mode: SessionMode.solo,
    categoryId: 'restaurant',
    subcategoryIds: const [],
    anchorLatitude: 24.7136,
    anchorLongitude: 46.6753,
    countryCode: 'SA',
    radiusMeters: 3000,
    deckSizeRequested: 10,
    deckSizeActual: 10,
    consensusRule: ConsensusRule.majority,
    matchingTiming: MatchingTiming.afterDeck,
    status: SessionStatus.active,
    revision: 1,
    createdAt: DateTime(2026, 9, 2, 12),
    expiresAt: DateTime(2026, 9, 3, 12),
  ),
  deck: const [],
  participants: const [],
);
