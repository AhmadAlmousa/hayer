# Fix: Extreme system text scaling can break compact layouts

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/text-scale-factor
- **Needs new dependency**: none

## Why

The app currently accepts unbounded device text scaling even in dense chips, timeline labels, result cards, and swipe overlays. A tested app-wide cap preserves some accessibility scaling while preventing known compact layouts from overflowing.

## Where

```dart
// app/lib/app/app.dart:45 — current
builder: builder,
routerConfig: appRouter,
```

```dart
// app/lib/app/app.dart:52 — current
TransitionBuilder? _adaptiveBuilder(TargetPlatform platform) {
```

## The fix

Replace the optional Apple-only builder with a builder that always clamps text and conditionally wraps Cupertino theming:

```dart
return (context, child) {
  final media = MediaQuery.of(context);
  Widget result = MediaQuery(
    data: media.copyWith(
      textScaler: media.textScaler.clamp(maxScaleFactor: 1.1),
    ),
    child: child ?? const SizedBox.shrink(),
  );
  if (isApple) {
    result = CupertinoTheme(data: ..., child: result);
  }
  return result;
};
```

Apply the same builder to mandatory-update and routed app roots.

## Steps

1. Refactor `_adaptiveBuilder` to always return the combined builder above.
2. Preserve the current Cupertino colors and brightness exactly.
3. Add widget tests with device scale 1.0, 1.1, and 2.0, asserting effective scale 1.0, 1.1, and 1.1.
4. Pump home, setup timeline, join, swipe, lobby, and results at the cap and assert no overflow exceptions.

## Check it

`dart analyze` exits clean. `grep -c "maxScaleFactor: 1.1" app/lib/app/app.dart` → 1. All capped-scale screen tests pass.

## Don't touch

- Do not force all users to 1.0.
- Do not alter platform theme behavior.
- No new dependencies.

## STOP if

- Any core screen still overflows at 1.1; fix that layout before lowering the cap.
- The builder loses its child during startup.
- A check fails twice.

## When you're done

Tell the developer that large system text remains supported up to a tested safe scale across all screens. Demonstrate the setup and results screens with the device scale above the cap.
