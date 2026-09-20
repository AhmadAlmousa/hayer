import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart' as flutter_material;
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';

/// The height the open-hours grid itself gets, excluding its day header.
///
/// The vertical scale is derived from this and the span of hours actually on
/// show, so the graph is always this tall and never scrolls. Before, a fixed
/// scale over all 24 hours made it 470dp and mostly empty night.
const _gridHeight = 190.0;

/// The day-name strip above the grid.
const _weekTitleHeight = 34.0;

/// Bounds on the derived vertical scale, in dp per minute. The floor keeps a
/// short period from collapsing to a hairline on a 24-hour place; the ceiling
/// stops a place open two hours a day from drawing one enormous bar.
const _minMinuteHeight = .1;
const _maxMinuteHeight = .5;

/// The narrowest window worth drawing, in hours. Below this the grid reads as
/// a single block with no sense of where the day sits around it.
const _minWindowHours = 8;

/// A calendar week view that highlights the hours during which a place is open.
class WeeklyHoursCalendar extends StatefulWidget {
  const WeeklyHoursCalendar({
    super.key,
    required this.hours,
    required this.countryCode,
    this.now,
  });

  final List<OpeningPeriod> hours;
  final String? countryCode;

  /// Overrides the clock for deterministic tests.
  final DateTime? now;

  @override
  State<WeeklyHoursCalendar> createState() => _WeeklyHoursCalendarState();
}

class _WeeklyHoursCalendarState extends State<WeeklyHoursCalendar> {
  final EventController<OpeningHoursSegment> _controller = EventController();
  WeekDays? _startDay;
  DateTime? _weekStart;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rebuildEvents();
  }

  @override
  void didUpdateWidget(WeeklyHoursCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _rebuildEvents();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final localNow = gccLocalDateTime(
      widget.now ?? DateTime.now(),
      widget.countryCode,
    );
    final start = _weekStart ?? _startOfWeek(localNow, _startDay!);
    final calendarTheme = flutter_material.ThemeData(
      useMaterial3: true,
      brightness: theme.brightness,
      colorScheme: flutter_material.ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: theme.brightness,
      ),
      extensions: [
        WeekViewThemeData(
          weekDayTileColor: colors.surfaceContainerHigh,
          weekDayTextColor: colors.onSurface,
          hourLineColor: colors.outlineVariant,
          halfHourLineColor: colors.outlineVariant.withValues(alpha: .45),
          quarterHourLineColor: colors.outlineVariant.withValues(alpha: .25),
          liveIndicatorColor: colors.error,
          pageBackgroundColor: colors.surfaceContainerLowest,
          headerIconColor: colors.onSurface,
          headerTextColor: colors.onSurface,
          headerBackgroundColor: colors.surfaceContainerLow,
          timelineTextColor: colors.onSurfaceVariant,
          borderColor: colors.outlineVariant,
          verticalLinesColor: colors.outlineVariant.withValues(alpha: .65),
        ),
      ],
    );

    final window = openingHoursWindow(widget.hours, localNow);
    final windowMinutes = (window.endHour - window.startHour) * 60;
    final minuteHeight = (_gridHeight / windowMinutes).clamp(
      _minMinuteHeight,
      _maxMinuteHeight,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: _weekTitleHeight + windowMinutes * minuteHeight,
        child: flutter_material.Theme(
          data: calendarTheme,
          child: flutter_material.Material(
            color: colors.surfaceContainerLowest,
            child: WeekView<OpeningHoursSegment>(
              key: ValueKey('weekly-hours-${_startDay!.name}'),
              controller: _controller,
              initialDay: localNow,
              minDay: start,
              maxDay: start.add(const Duration(days: 6)),
              startDay: _startDay!,
              startHour: window.startHour,
              endHour: window.endHour,
              heightPerMinute: minuteHeight,
              timeLineWidth: 44,
              weekTitleHeight: _weekTitleHeight,
              backgroundColor: colors.surfaceContainerLowest,
              weekTitleBackgroundColor: colors.surfaceContainerLow,
              pageViewPhysics: const NeverScrollableScrollPhysics(),
              showLiveTimeLineInAllDays: true,
              liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
                color: colors.error,
                height: 2,
                showBullet: true,
                showTime: false,
                onlyShowToday: false,
                currentTimeProvider: () => gccLocalDateTime(
                  widget.now ?? DateTime.now(),
                  widget.countryCode,
                ),
              ),
              hourIndicatorSettings: HourIndicatorSettings(
                color: colors.outlineVariant,
                height: 1,
              ),
              safeAreaOption: const SafeAreaOption(
                left: false,
                top: false,
                right: false,
                bottom: false,
              ),
              weekPageHeaderBuilder: (_, _) => const SizedBox.shrink(),
              weekNumberBuilder: (_) => const SizedBox.shrink(),
              weekDayBuilder: (date) => _DayHeader(date: date, locale: locale),
              timeLineBuilder: (date) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 7),
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Text(
                    DateFormat.j(locale).format(date),
                    maxLines: 1,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              eventTileBuilder: (_, events, _, _, _) => _OpenPeriodTile(
                segment: events.first.event!,
                locale: locale,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _rebuildEvents() {
    final localNow = gccLocalDateTime(
      widget.now ?? DateTime.now(),
      widget.countryCode,
    );
    final startDay = weekDayFromMaterialIndex(
      MaterialLocalizations.of(context).firstDayOfWeekIndex,
    );
    final start = _startOfWeek(localNow, startDay);
    _startDay = startDay;
    _weekStart = start;
    final events = <CalendarEventData<OpeningHoursSegment>>[];
    for (var offset = 0; offset < 7; offset++) {
      final date = start.add(Duration(days: offset));
      for (final segment in openingSegmentsForDay(widget.hours, date.weekday)) {
        final endMinutes = segment.end.clamp(1, 1439);
        events.add(
          CalendarEventData<OpeningHoursSegment>(
            title: '',
            date: date,
            event: segment,
            startTime: DateTime(
              date.year,
              date.month,
              date.day,
              segment.start ~/ 60,
              segment.start % 60,
            ),
            endTime: DateTime(
              date.year,
              date.month,
              date.day,
              endMinutes ~/ 60,
              endMinutes % 60,
            ),
          ),
        );
      }
    }
    _controller
      ..clear()
      ..addAll(events);
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.date, required this.locale});

  final DateTime date;
  final String locale;

  @override
  Widget build(BuildContext context) => Padding(
    key: ValueKey('hours-day-${date.weekday}'),
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              DateFormat.E(locale).format(date),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        Text(
          DateFormat.d(locale).format(date),
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    ),
  );
}

class _OpenPeriodTile extends StatelessWidget {
  const _OpenPeriodTile({required this.segment, required this.locale});

  final OpeningHoursSegment segment;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final strings = AppLocalizations.of(context)!;
    return Semantics(
      label:
          '${strings.weeklyHours}: ${_formatTime(segment.start, locale)}–${_formatTime(segment.end, locale)}',
      child: Container(
        key: const ValueKey('open-hours-period'),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: .72),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}

/// The band of hours the week view draws, as whole hours in `[0, 24]`.
typedef OpeningHoursWindow = ({int startHour, int endHour});

/// Narrows the week view to the hours [hours] actually covers.
///
/// Most places are shut for a third of the day or more, and drawing all 24
/// hours spent that space on empty night. The window is the union of every
/// day's open periods, padded an hour each side so the edges of a period are
/// visible, widened to include [localNow] so the live-time line always has
/// somewhere to land, and never narrower than [_minWindowHours].
OpeningHoursWindow openingHoursWindow(
  List<OpeningPeriod> hours,
  DateTime localNow,
) {
  int? earliest;
  int? latest;
  for (var day = DateTime.monday; day <= DateTime.sunday; day++) {
    for (final segment in openingSegmentsForDay(hours, day)) {
      if (earliest == null || segment.start < earliest) {
        earliest = segment.start;
      }
      if (latest == null || segment.end > latest) latest = segment.end;
    }
  }

  // With no periods at all the caller draws an empty grid; a daytime band
  // reads better there than midnight to midnight.
  var start = earliest == null ? 8 : (earliest ~/ 60) - 1;
  var end = latest == null ? 22 : ((latest + 59) ~/ 60) + 1;

  start = start < localNow.hour ? start : localNow.hour;
  end = end > localNow.hour + 1 ? end : localNow.hour + 1;
  start = start.clamp(0, 24);
  end = end.clamp(0, 24);

  // Grow towards whichever end has room, so a place open only in the evening
  // keeps its evening in view rather than being recentred on noon.
  while (end - start < _minWindowHours) {
    if (end < 24) {
      end++;
    } else if (start > 0) {
      start--;
    } else {
      break;
    }
  }
  return (startHour: start, endHour: end);
}

@immutable
class OpeningHoursSegment {
  const OpeningHoursSegment(this.start, this.end);

  final int start;
  final int end;
}

/// Splits overnight periods across their two days and merges overlaps.
List<OpeningHoursSegment> openingSegmentsForDay(
  List<OpeningPeriod> hours,
  int day,
) {
  final segments = <OpeningHoursSegment>[];
  for (final period in hours) {
    final open = period.openMinutes.clamp(0, 1440);
    final close = period.closeMinutes.clamp(0, 1440);
    final overnight = period.overnight || (close <= open && close != 1440);
    if (period.day == day) {
      final end = overnight ? 1440 : close;
      if (end > open) segments.add(OpeningHoursSegment(open, end));
    }
    final followingDay = period.day == DateTime.sunday
        ? DateTime.monday
        : period.day + 1;
    if (overnight && followingDay == day && close > 0) {
      segments.add(OpeningHoursSegment(0, close));
    }
  }
  segments.sort((a, b) => a.start.compareTo(b.start));
  final merged = <OpeningHoursSegment>[];
  for (final segment in segments) {
    if (merged.isEmpty || segment.start > merged.last.end) {
      merged.add(segment);
    } else if (segment.end > merged.last.end) {
      merged[merged.length - 1] = OpeningHoursSegment(
        merged.last.start,
        segment.end,
      );
    }
  }
  return merged;
}

WeekDays weekDayFromMaterialIndex(int index) => switch (index % 7) {
  0 => WeekDays.sunday,
  1 => WeekDays.monday,
  2 => WeekDays.tuesday,
  3 => WeekDays.wednesday,
  4 => WeekDays.thursday,
  5 => WeekDays.friday,
  _ => WeekDays.saturday,
};

DateTime gccLocalDateTime(DateTime instant, String? countryCode) {
  final offset = switch (countryCode) {
    'AE' || 'OM' => 4,
    _ => 3,
  };
  final shifted = instant.toUtc().add(Duration(hours: offset));
  return DateTime(
    shifted.year,
    shifted.month,
    shifted.day,
    shifted.hour,
    shifted.minute,
    shifted.second,
    shifted.millisecond,
    shifted.microsecond,
  );
}

DateTime _startOfWeek(DateTime date, WeekDays startDay) {
  final startWeekday = startDay.index + 1;
  final difference = (date.weekday - startWeekday) % 7;
  return DateTime(date.year, date.month, date.day - difference);
}

String _formatTime(int minutes, String locale) {
  final normalized = minutes == 1440 ? 0 : minutes;
  return DateFormat.jm(locale).format(
    DateTime(2024, 1, 1, normalized ~/ 60, normalized % 60),
  );
}
