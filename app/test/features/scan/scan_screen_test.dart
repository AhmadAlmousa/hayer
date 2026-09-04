import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_app/features/scan/native_qr_scanner.dart';
import 'package:hayer_app/features/scan/scan_screen.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('opens a valid scanned session link', (tester) async {
    final scanner = _FakeQrScanner(
      result: () async => 'https://hayer.almou.sa/join/a37',
    );
    final router = _router(scanner);
    addTearDown(router.dispose);

    await tester.pumpWidget(_TestApp(router: router));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(scanner.calls, 1);
    expect(find.text('joined:A37'), findsOneWidget);
  });

  testWidgets('reports a QR code that is not a Hayer session link', (
    tester,
  ) async {
    final scanner = _FakeQrScanner(
      result: () async => 'https://example.com/not-a-session',
    );
    final router = _router(scanner);
    addTearDown(router.dispose);

    await tester.pumpWidget(_TestApp(router: router));
    await tester.pumpAndSettle();

    expect(scanner.calls, 1);
    expect(
      find.text('That QR code is not a Hayer session link.'),
      findsOneWidget,
    );
    expect(find.text('Scan QR code'), findsNWidgets(2));
  });

  testWidgets('offers code entry when native scanning is unsupported', (
    tester,
  ) async {
    final scanner = _FakeQrScanner(
      isSupported: false,
      result: () async => null,
    );
    final router = _router(scanner);
    addTearDown(router.dispose);

    await tester.pumpWidget(_TestApp(router: router));
    await tester.pumpAndSettle();

    expect(scanner.calls, 0);
    expect(
      find.text('QR scanning is available in the Android and iOS apps.'),
      findsOneWidget,
    );
    expect(find.text('Enter code instead'), findsOneWidget);
  });
}

GoRouter _router(QrScanner scanner) => GoRouter(
  initialLocation: '/scan',
  routes: [
    GoRoute(
      path: '/scan',
      builder: (context, state) => ScanScreen(scanner: scanner),
    ),
    GoRoute(
      path: '/join',
      builder: (context, state) => const Text('manual join'),
      routes: [
        GoRoute(
          path: ':code',
          builder: (context, state) => Text(
            'joined:${state.pathParameters['code']}',
          ),
        ),
      ],
    ),
  ],
);

class _TestApp extends StatelessWidget {
  const _TestApp({required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}

final class _FakeQrScanner implements QrScanner {
  _FakeQrScanner({this.isSupported = true, required this.result});

  @override
  final bool isSupported;

  final Future<String?> Function() result;
  int calls = 0;

  @override
  Future<String?> scan() {
    calls += 1;
    return result();
  }
}
