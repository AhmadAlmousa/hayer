# Fix: Setup timeline labels and circle gaps miss taps

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/gesture-detector-hit-area
- **Needs new dependency**: none

## Why

Both custom timeline tap targets defer hit testing to painted children, so padding and gaps can ignore a tap. Opaque hit behavior makes the entire allocated tile respond without changing its appearance.

## Where

```dart
// app/lib/features/setup/setup_timeline.dart:55 — current
child: GestureDetector(
  onTap: isAvailable ? () => onSelect(index) : null,
```

```dart
// app/lib/features/setup/setup_timeline.dart:93 — current
contentsBuilder: (context, index) => GestureDetector(
  onTap: index <= step ? () => onSelect(index) : null,
```

## The fix

Add the article's line to both detectors:

```dart
behavior: HitTestBehavior.opaque,
```

Keep disabled future steps non-interactive through their null callbacks; opaque behavior only expands the hit box of enabled tiles.

## Steps

1. Add opaque behavior to the indicator detector.
2. Add opaque behavior to the label detector.
3. Extend timeline tests to tap padding outside the icon/text paint bounds and assert the step callback.

## Check it

`dart analyze` exits clean. `grep -c "behavior: HitTestBehavior.opaque" app/lib/features/setup/setup_timeline.dart` → 2.

## Don't touch

- Do not replace the timeline with buttons or add ripples.
- Keep availability rules and semantics unchanged.
- No new dependencies.

## STOP if

- Either detector no longer owns a full timeline tile.
- Expanded targets overlap and invoke two indices from one tap.
- A check fails twice.

## When you're done

Tell the developer that the full timeline circle and label regions now accept taps. Tap the whitespace around a completed step to demonstrate it.
