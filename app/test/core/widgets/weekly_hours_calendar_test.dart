import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/widgets/weekly_hours_calendar.dart';
import 'package:hayer_app/l10n/generated/app_localizations.dart';
import 'package:hayer_app/l10n/localization_delegates.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  test('splits overnight hours into the following day and merges overlaps', () {
    final hours = [
      OpeningPeriod(
        day: DateTime.monday,
        openMinutes: 21 * 60 + 30,
        closeMinutes: 75,
        overnight: true,
      ),
      OpeningPeriod(
        day: DateTime.tuesday,
        openMinutes: 60,
        closeMinutes: 180,
        overnight: false,
      ),
    ];

    final monday = openingSegmentsForDay(hours, DateTime.monday);
    final tuesday = openingSegmentsForDay(hours, DateTime.tuesday);

    expect(monday.single.start, 21 * 60 + 30);
    expect(monday.single.end, 1440);
    expect(tuesday.single.start, 0);
    expect(tuesday.single.end, 180);
  });

  testWidgets('uses the locale week start and draws current time across days', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: hayerLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: WeeklyHoursCalendar(
            countryCode: 'SA',
            now: DateTime.utc(2026, 9, 5, 12),
            hours: [
              OpeningPeriod(
                day: DateTime.saturday,
                openMinutes: 9 * 60,
                closeMinutes: 17 * 60,
                overnight: false,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pump();

    final weekView = tester.widget<WeekView<OpeningHoursSegment>>(
      find.byWidgetPredicate(
        (widget) => widget is WeekView<OpeningHoursSegment>,
      ),
    );
    expect(weekView.startDay, WeekDays.saturday);
    expect(weekView.showLiveTimeLineInAllDays, isTrue);
    expect(weekView.liveTimeIndicatorSettings?.onlyShowToday, isFalse);
    expect(
      weekView.liveTimeIndicatorSettings?.currentTimeProvider?.call().hour,
      15,
    );
    expect(find.byKey(const ValueKey('open-hours-period')), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
