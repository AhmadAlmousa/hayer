# Fix: Counts, ratings, and distances ignore the user's number format

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/format-numbers-for-humans
- **Needs new dependency**: none; `intl` is already present

## Why

Participant totals, review totals, ratings, distances, and percentages are assembled with raw interpolation and custom abbreviations. `intl` gives English and Arabic users the separators, digits, compact suffixes, and decimals expected by their locale.

## Where

```dart
// app/lib/features/lobby/lobby_screen.dart:236 — current
trailing: Text(
  participant.hasCompleted
      ? 'Done'
      : '${participant.currentIndex}/${bundle.session.deckSizeActual}',
),
```

```dart
// app/lib/features/results/results_screen.dart:177 — current
Text('${bundle.participants.length} participants'),
Text('${values.length} matches'),
```

```dart
// app/lib/features/results/results_screen.dart:473 — current
if (place.reviewCount != null)
  '${place.reviewCount} reviews',
```

```dart
// app/lib/features/swipe/place_card.dart:123 — current
'★ ${place.rating!.toStringAsFixed(1)}',
```

```dart
// app/lib/features/setup/setup_screen.dart:924 — current
Text('${category.subcategories.length} types'),
```

## The fix

Create `app/lib/core/number_display.dart`:

```dart
extension DisplayNumber on num {
  String humanizedCount(String locale) =>
      NumberFormat.decimalPattern(locale).format(this);

  String humanizedDecimal(String locale, {int digits = 1}) =>
      NumberFormat.decimalPatternDigits(
        locale: locale,
        decimalDigits: digits,
      ).format(this);

  String humanizedCompact(String locale) =>
      NumberFormat.compact(locale: locale).format(this);
}
```

At build sites derive `final locale = Localizations.localeOf(context).toLanguageTag();`. Use count formatting for participant/deck/match/vote/review totals, decimal formatting for ratings and percentages, and compact formatting for review totals on cards. Identifiers such as session codes and ranking positions remain unformatted.

## Steps

1. Add the shared number extension and tests for `en` and `ar`.
2. Replace raw user-facing counts in lobby, results, setup category totals, and the swipe progress header.
3. Replace `toStringAsFixed` and `_compact` in place cards/results with the shared locale-aware helpers.
4. Format the same values in shared-result text, using the active locale.

## Check it

`dart analyze` exits clean. `grep -c "String _compact" app/lib/features/swipe/place_card.dart` → 0. Number helper tests assert grouping and one-decimal ratings in both locales.

## Don't touch

- Session codes, swipe indexes used in API commands, coordinates, and ranks are identifiers rather than amounts.
- Currency symbols are handled by the separate GCC-currency requirement.
- No new dependencies.

## STOP if

- A formatted value is used as input to an API or database operation.
- Arabic formatting makes a protocol identifier locale-dependent.
- A check fails twice.

## When you're done

Tell the developer that all readable amounts now follow the selected locale while IDs remain stable. Compare a result with a large review count in English and Arabic.
