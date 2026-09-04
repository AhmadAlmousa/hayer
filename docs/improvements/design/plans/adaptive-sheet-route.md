# Fix: Place details use a mechanical full-height bottom sheet

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/adaptive-sheet-route
- **Needs new dependency**: `stupid_simple_sheet` for modern rounded adaptive sheet routes

## Why

Result details open through a scroll-controlled Material bottom sheet reaching 94 percent height. A dedicated adaptive sheet route gives iOS the modern rounded glass presentation and Android a smooth pull-down sheet.

## Where

```dart
// app/lib/features/results/results_screen.dart:413 — current
onTap: () => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _PlaceDetailsSheet(
```

```dart
// app/lib/features/results/results_screen.dart:550 — current
Widget build(BuildContext context) => SafeArea(
  child: DraggableScrollableSheet(
    expand: false,
    initialChildSize: .72,
    minChildSize: .45,
    maxChildSize: .94,
```

## The fix

Add the article's extension:

```dart
extension AdaptiveSheetRoute on Widget {
  Route<T> asAdaptiveSheetRoute<T>() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return StupidSimpleGlassSheetRoute<T>(
        child: this,
        blurBehindBarrier: false,
      );
    }
    return StupidSimpleSheetRoute<T>(child: this);
  }
}
```

Open `_PlaceDetailsSheet` with `Navigator.of(context).push(...)`, add an explicit close button at the directional start of its header, and let the route own dragging rather than nesting a `DraggableScrollableSheet`. Retain the internal controlled `ListView`, dynamic bottom padding, and all place content.

## Steps

1. Add `stupid_simple_sheet` and the shared widget extension.
2. Replace the `showModalBottomSheet` call with the adaptive route push.
3. Refactor details content out of `DraggableScrollableSheet` into the route's scrollable child.
4. Add a close button and preserve accessibility names, safe insets, and scrollbar ownership.
5. Add route tests for iOS and Android plus a pull-down/close navigation test.

## Check it

`dart analyze` exits clean. `grep -c "showModalBottomSheet" app/lib/features/results/results_screen.dart` → 0. `grep -c "asAdaptiveSheetRoute" app/lib/features/results/results_screen.dart` → 1.

## Don't touch

- Keep result-card navigation and place metadata unchanged.
- Do not apply this route to the small Cupertino visit-time picker.
- Do not retain two nested drag controllers.

## STOP if

- The package does not support the project's Flutter version.
- The route cannot pass its scroll controller to long content.
- A check fails twice.

## When you're done

Tell the developer that place details now use a modern rounded, pull-down adaptive sheet with an explicit close control. Open a result on both iOS and Android to demonstrate it.
