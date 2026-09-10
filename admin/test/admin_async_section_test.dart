import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/analytics/analytics_pages.dart';

void main() {
  testWidgets('a reload keeps the previous figures on screen', (tester) async {
    // Behavior under test: changing a filter used to swap the whole body for a
    // spinner, so an operator lost the numbers they were comparing against.
    final first = Completer<String>();
    final second = Completer<String>();
    final host = _Host(future: first.future);
    await tester.pumpWidget(host);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    first.complete('42 sessions');
    await tester.pumpAndSettle();
    expect(find.text('42 sessions'), findsOneWidget);

    await tester.pumpWidget(_Host(future: second.future));
    await tester.pump();

    // Still readable, and visibly refreshing rather than blank.
    expect(find.text('42 sessions'), findsOneWidget);
    expect(find.byKey(const Key('admin-section-refreshing')), findsOneWidget);

    second.complete('51 sessions');
    await tester.pumpAndSettle();
    expect(find.text('51 sessions'), findsOneWidget);
    expect(find.byKey(const Key('admin-section-refreshing')), findsNothing);
  });

  testWidgets('a failed reload keeps the last good data and says so', (
    tester,
  ) async {
    // Replacing good figures with a bare error panel loses the only data the
    // operator had. The last successful load stays, marked stale.
    final first = Completer<String>();
    final second = Completer<String>();
    await tester.pumpWidget(_Host(future: first.future));
    first.complete('42 sessions');
    await tester.pumpAndSettle();

    await tester.pumpWidget(_Host(future: second.future));
    second.completeError(StateError('gateway down'));
    await tester.pumpAndSettle();

    expect(find.text('42 sessions'), findsOneWidget);
    expect(find.byKey(const Key('admin-stale-banner')), findsOneWidget);
  });

  testWidgets('a first load that fails shows the error panel', (tester) async {
    // With nothing to preserve, the error is the whole story.
    final first = Completer<String>();
    await tester.pumpWidget(_Host(future: first.future));
    first.completeError(StateError('gateway down'));
    await tester.pumpAndSettle();

    expect(find.byType(AdminErrorPanel), findsOneWidget);
    expect(find.byKey(const Key('admin-stale-banner')), findsNothing);
  });

  testWidgets('a late response for an abandoned filter is ignored', (
    tester,
  ) async {
    // The operator moved on; the older request must not overwrite the newer.
    final first = Completer<String>();
    final second = Completer<String>();
    await tester.pumpWidget(_Host(future: first.future));
    first.complete('42 sessions');
    await tester.pumpAndSettle();

    await tester.pumpWidget(_Host(future: second.future));
    second.complete('51 sessions');
    await tester.pumpAndSettle();

    // The abandoned first future resolving again must not win.
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('51 sessions'), findsOneWidget);
    expect(find.text('42 sessions'), findsNothing);
  });
}

class _Host extends StatelessWidget {
  const _Host({required this.future});

  final Future<String> future;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: AdminAsyncSection<String>(
        future: future,
        builder: (context, value) => Text(value),
      ),
    ),
  );
}
