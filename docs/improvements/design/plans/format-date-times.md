# Fix: A backend timestamp is shown as raw DateTime text

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/format-date-times
- **Needs new dependency**: none; `intl` is already present

## Why

The app formats saved-session and visit dates locally but prints a place check timestamp through `DateTime.toString()`. Centralizing all display formats keeps every date human-readable and localized.

## Where

```dart
// app/lib/features/results/results_screen.dart:673 — current
Text(
  '${place.attributions.join(' • ')}\nChecked ${place.sourceCheckedAt.toLocal()}'
```

```dart
// app/lib/features/setup/setup_screen.dart:361 — current
DateFormat.yMMMEd(
  Localizations.localeOf(context).toLanguageTag(),
).add_jm().format(_visitAt!),
```

```dart
// app/lib/features/home/resume_session_button.dart:23 — current
final created = DateFormat.MMMd(locale).add_jm().format(
  bundle.session.createdAt.toLocal(),
);
```

## The fix

Create `app/lib/core/date_time_display.dart` following the article, with nullable extensions `formattedDateTime(locale)`, `formattedWeekdayDateTime(locale)`, and `formattedShortDateTime(locale)` returning a localized placeholder for null. Call `await initializeDateFormatting()` during startup before `runApp`.

Use `formattedDateTime` for the checked timestamp, `formattedWeekdayDateTime` for planned visits, and `formattedShortDateTime` for compact resume-card metadata. Put “Checked” and placeholders in ARB strings; do not concatenate an English label around a localized date.

## Steps

1. Add the shared nullable date extension and locale-specific unit tests.
2. Initialize locale date data in `main.dart`.
3. Replace all three quoted date formatting paths with the helper.
4. Add localized ARB messages for the checked-at line and missing date.

## Check it

`dart analyze` exits clean. `grep -c "sourceCheckedAt.toLocal()}" app/lib/features/results/results_screen.dart` → 0. Date tests assert English and Arabic month output.

## Don't touch

- Keep UTC conversion at API boundaries unchanged.
- Do not localize backend/request date formats.
- No new dependencies.

## STOP if

- Any affected timestamp is not UTC-backed as assumed.
- A date is used for parsing after display formatting.
- A check fails twice.

## When you're done

Tell the developer that every displayed date is now a human, locale-aware date rather than raw Dart output. Open place details and inspect the checked-at line.
