# Fix: Scrollable content is clipped or crowded at the system bar

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/safe-area-replacement
- **Needs new dependency**: none

## Why

Wrapping a scrolling viewport in `SafeArea` clips items as they travel under the bottom inset. Dynamic content padding lets the final item clear the system bar while the list keeps using the full viewport.

## Where

```dart
// app/lib/features/join/join_screen.dart:53 — current
body: SafeArea(
  child: ContentShell(
    child: ListView(
      padding: const EdgeInsets.all(24),
```

```dart
// app/lib/features/lobby/lobby_screen.dart:96 — current
: SafeArea(
    child: ContentShell(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
```

```dart
// app/lib/features/results/results_screen.dart:151 — current
: SafeArea(
    child: ContentShell(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
```

```dart
// app/lib/features/results/results_screen.dart:550 — current
Widget build(BuildContext context) => SafeArea(
  child: DraggableScrollableSheet(
```

```dart
// app/lib/features/setup/setup_screen.dart:779 — current
Widget _stepScrollView(Widget child) => SingleChildScrollView(
  padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
```

## The fix

Create `BottomPadding.of(context, minimum:)` exactly as in the article, using `MediaQuery.viewPaddingOf(context).bottom`. Remove `SafeArea` from around scrolling bodies and replace fixed bottom padding with `BottomPadding.of(context, minimum: existingMinimum)`. Keep `SafeArea` around fixed bottom action bars and camera overlays.

```dart
padding: EdgeInsets.fromLTRB(
  24,
  24,
  24,
  BottomPadding.of(context, minimum: 24),
),
```

For lobby/results lists whose bottom bars overlap the body, add the action-bar clearance to the dynamic inset: `BottomPadding.of(context, minimum: 16) + 94`.

## Steps

1. Add `app/lib/core/widgets/bottom_padding.dart` with the article's `BottomPadding` widget and `of` helper.
2. Update the join, lobby, results, details-sheet, and setup scrollable paddings listed above.
3. Remove only the `SafeArea` instances that wrap those scrollable viewports; retain fixed-control and scanner `SafeArea` widgets.
4. Add widget tests with bottom view padding `0` and `34`, asserting the final effective list padding.

## Check it

`dart analyze` exits clean. `grep -c "viewPaddingOf" app/lib/core/widgets/bottom_padding.dart` → 1. Widget tests prove the minimum and device inset branches.

## Don't touch

- Scanner overlay `SafeArea` widgets protect fixed controls and remain unchanged.
- Bottom navigation bars remain wrapped in `SafeArea`.
- No fixed replacement for a dynamic device inset.

## STOP if

- Any listed scrollable has moved or no longer matches the quote.
- A bottom action bar's measured clearance cannot be determined.
- A check fails twice.

## When you're done

Tell the developer that lists now scroll naturally under system UI while their last item retains breathing room. Demonstrate the join and results pages on a gesture-navigation device.
