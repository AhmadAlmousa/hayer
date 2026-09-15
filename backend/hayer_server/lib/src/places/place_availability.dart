import '../generated/protocol.dart';

abstract final class PlaceAvailability {
  static const _utcOffsetHours = <String, int>{
    'SA': 3,
    'BH': 3,
    'KW': 3,
    'QA': 3,
    'AE': 4,
    'OM': 4,
  };

  /// Whole-hour UTC offset used for place-local time. Supported GCC countries
  /// observe no daylight saving; anything else falls back to Saudi time.
  static int utcOffsetHours(String countryCode) =>
      _utcOffsetHours[countryCode] ?? 3;

  /// Unknown hours remain eligible; only known-closed places are excluded.
  static bool isOpenAt(
    PlaceSnapshot place, {
    required DateTime visitAt,
    required String countryCode,
  }) => isOpenDuring(
    place.hours,
    visitAt: visitAt,
    countryCode: countryCode,
  );

  static bool isOpenDuring(
    List<OpeningPeriod> hours, {
    required DateTime visitAt,
    required String countryCode,
  }) {
    if (hours.isEmpty) return true;
    final local = visitAt.toUtc().add(
      Duration(hours: utcOffsetHours(countryCode)),
    );
    final weekday = local.weekday;
    final minute = local.hour * 60 + local.minute;

    for (final period in hours) {
      final overnight =
          period.overnight ||
          (period.closeMinutes <= period.openMinutes &&
              period.closeMinutes != 1440);
      if (!overnight &&
          period.day == weekday &&
          minute >= period.openMinutes &&
          minute < period.closeMinutes) {
        return true;
      }
      if (overnight) {
        if (period.day == weekday && minute >= period.openMinutes) return true;
        final followingDay = period.day == DateTime.sunday
            ? DateTime.monday
            : period.day + 1;
        if (followingDay == weekday && minute < period.closeMinutes) {
          return true;
        }
      }
    }
    return false;
  }
}
