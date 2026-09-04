# Fix: Missing API text can leak as blank or "null"

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/never-show-null
- **Needs new dependency**: none

## Why

Optional place and session strings are guarded only for Dart `null`; empty strings and a backend literal `"null"` still reach the interface. One shared guard makes display and conditional rendering consistent.

## Where

```dart
// app/lib/features/setup/setup_screen.dart:247 — current
subtitle: suggestion.secondaryText == null
    ? null
    : Text(suggestion.secondaryText!),
```

```dart
// app/lib/features/lobby/lobby_screen.dart:166 — current
if (bundle.session.anchorAddress != null) ...[
```

```dart
// app/lib/features/swipe/place_card.dart:121 — current
if (place.primaryType != null) place.primaryType!,
```

```dart
// app/lib/features/results/results_screen.dart:570 — current
if (place.primaryType != null) Text(place.primaryType!),
```

```dart
// app/lib/features/results/results_screen.dart:648 — current
if (place.phoneNumber != null)
```

## The fix

Create `app/lib/core/string_display.dart` from the article:

```dart
extension DisplayString on String? {
  bool get isUsable =>
      this != null && this!.trim().isNotEmpty && this!.trim().toLowerCase() != 'null';

  String orPlaceholder([String placeholder = '-']) =>
      isUsable ? this!.trim() : placeholder;
}
```

Use `isUsable` for every optional API-backed string that gates a widget in setup, lobby, swipe-card, and results details. Use `orPlaceholder()` only where the layout requires a value. Apply the same guard to addresses, primary/status/price text, editorial summary, featured review, website, phone, and attribution entries.

## Steps

1. Add the shared extension and unit tests for null, empty, whitespace, all case variants of `null`, and usable text.
2. Replace the quoted null-only guards and every sibling optional display-string guard in the same four files with `isUsable`.
3. Filter attribution lists through `isUsable` before joining them.
4. Keep true data absence hidden where the widget is optional; do not introduce visible dashes into optional sections.

## Check it

`dart analyze` exits clean. `grep -c "isUsable" app/lib/core/string_display.dart` → 2. Unit tests cover every invalid representation.

## Don't touch

- Do not use the helper for identifiers, URLs passed to parsers, or required model fields.
- Do not change generated protocol nullability.
- No new dependencies.

## STOP if

- Any affected field is confirmed to distinguish whitespace from missing data.
- A required model string becomes optional as part of this work.
- A check fails twice.

## When you're done

Tell the developer that missing backend text is now hidden or replaced consistently and can never render as `null`. Open a place with sparse metadata to demonstrate it.
