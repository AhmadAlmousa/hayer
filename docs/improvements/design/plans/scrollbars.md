# Fix: Mobile scrollable pages give no position cue

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/scrollbars
- **Needs new dependency**: none

## Why

Long setup, lobby, join, results, and place-detail pages have no scrollbar on mobile. An app-wide scroll behavior supplies one without double-wrapping desktop scrollables and automatically excludes page-style widgets.

## Where

```dart
// app/lib/app/app.dart:35 — current
return MaterialApp.router(
  title: 'Hayer',
```

```dart
// app/lib/features/results/results_screen.dart:556 — current
builder: (context, controller) => ListView(
  controller: controller,
```

## The fix

Add the article's behavior:

```dart
class HayerScrollBehavior extends MaterialScrollBehavior {
  const HayerScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => Scrollbar(controller: details.controller, child: child);
}
```

Set `scrollBehavior: const HayerScrollBehavior()` on both `MaterialApp` and `MaterialApp.router`. Flutter's local behavior overrides keep `PageView`, editable text, and other unsuitable scrollables scrollbar-free.

## Steps

1. Add `HayerScrollBehavior` beside the app root.
2. Assign it to mandatory-update and normal app configurations.
3. Add a widget test that builds a vertical list through the app root and finds one scrollbar.
4. Verify the details-sheet controller is inherited by its scrollbar.

## Check it

`dart analyze` exits clean. `grep -c "scrollBehavior: const HayerScrollBehavior" app/lib/app/app.dart` → 2. The widget test finds no duplicate scrollbar.

## Don't touch

- Do not manually wrap every list.
- Do not add scrollbars to the card swiper or photo gallery.
- No new dependencies.

## STOP if

- The app-wide behavior creates duplicate desktop scrollbars.
- The details sheet thumb is disconnected from its controller.
- A check fails twice.

## When you're done

Tell the developer that vertical pages now expose scroll position consistently. Scroll a long lobby or place-details page on Android to demonstrate it.
