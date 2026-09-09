import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_admin/features/analytics/analytics_pages.dart';
import 'package:hayer_client/hayer_client.dart';

void main() {
  testWidgets('a KPI tile fits its cell at the system text scale', (
    tester,
  ) async {
    // Behavior under test: the analytics grids size their cells, and a tile
    // that cannot fit overflows rather than scrolling. Adding a denominator
    // line to the tile made the default case tighter, so this pins it.
    await _pumpTile(tester, textScale: 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('a KPI tile still fits at 200% text', (tester) async {
    // The consumer app was taken through the F24-F27 large-text pass; the
    // dashboard never was. An operator raising system text must not be shown
    // a black-and-yellow overflow stripe instead of a number.
    await _pumpTile(tester, textScale: 2);
    expect(tester.takeException(), isNull);
  });

  for (final scale in [1.0, 1.3, 1.6, 2.0]) {
    testWidgets('a long label and a denominator fit at ${scale}x text', (
      tester,
    ) async {
      // The worst case the overview can produce: a rate tile, which carries the
      // extra denominator line, under a label long enough to need every pixel.
      await _pumpTile(
        tester,
        textScale: scale,
        kpi: _kpi(
          key: 'completion_rate',
          label: 'Decision completion across every configured region',
          unit: 'percent',
          value: 62.5,
          previousValue: 55,
        ),
      );
      expect(tester.takeException(), isNull);
    });
  }
}

AnalyticsKpi _kpi({
  required String key,
  required String label,
  required String unit,
  required double value,
  required double previousValue,
}) => AnalyticsKpi(
  key: key,
  label: label,
  value: value,
  previousValue: previousValue,
  unit: unit,
);

Future<void> _pumpTile(
  WidgetTester tester, {
  required double textScale,
  AnalyticsKpi? kpi,
}) async {
  final value =
      kpi ??
      _kpi(
        key: 'completion_rate',
        label: 'Decision completion',
        unit: 'percent',
        value: 62.5,
        previousValue: 55,
      );
  final siblings = [
    value,
    _kpi(
      key: 'sessions',
      label: 'Sessions',
      unit: 'count',
      value: 1284,
      previousValue: 1100,
    ),
  ];
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
        child: Scaffold(
          // The cell the analytics KPI grid actually produces, sized the same
          // way the grid sizes it.
          body: Builder(
            builder: (context) => Center(
              child: SizedBox(
                width: 230,
                height: gridCellHeight(context, 145),
                child: KpiTile(
                  value: value,
                  comparison: 'vs previous 30 days',
                  siblings: siblings,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
