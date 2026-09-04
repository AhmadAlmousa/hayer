# Fix: Text selection does not use Hayer's colors

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/selection-color
- **Needs new dependency**: none

## Why

Editable text currently inherits Flutter's generic selection tint. Matching the cursor, handles, and translucent selection to Hayer teal makes forms feel intentional in both themes.

## Where

```dart
// app/lib/app/theme.dart:22 — current
return ThemeData(
  useMaterial3: true,
  brightness: brightness,
  platform: platform,
  colorScheme: scheme,
```

## The fix

Add this theme component to the shared `ThemeData`:

```dart
textSelectionTheme: TextSelectionThemeData(
  cursorColor: scheme.primary,
  selectionColor: scheme.primary.withValues(alpha: .30),
  selectionHandleColor: scheme.primary,
),
```

## Steps

1. Add the exact `textSelectionTheme` block to the single light/dark theme factory.
2. Extend the theme test to assert cursor, selection, and handle colors for light and dark themes.

## Check it

`dart analyze` exits clean. `grep -c "textSelectionTheme" app/lib/app/theme.dart` → 1. Theme tests pass.

## Don't touch

- Do not override selection colors per text field.
- Keep the existing seed color and color scheme.
- No new dependencies.

## STOP if

- The shared theme factory no longer matches the quote.
- Either theme loses readable text contrast in a selected field.
- A check fails twice.

## When you're done

Tell the developer that text cursor, selection, and handles now use Hayer teal in both themes. Open the join form and select its code text to show it.
