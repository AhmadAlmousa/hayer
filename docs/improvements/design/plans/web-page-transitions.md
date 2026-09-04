# Fix: Web and desktop routes animate like mobile pages

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/web-page-transitions
- **Needs new dependency**: none

## Why

The theme defines native mobile builders but leaves web, Windows, and Linux on animated defaults and gives macOS an iOS slide. Desktop navigation should switch immediately while Android and iOS retain their native motion.

## Where

```dart
// app/lib/app/theme.dart:30 — current
pageTransitionsTheme: const PageTransitionsTheme(
  builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
  },
),
```

## The fix

Add the article's `_NoPageTransitionsBuilder` with zero forward/reverse durations and a `buildTransitions` method returning `child`. Build the transition map so Android/iOS use `_NoPageTransitionsBuilder` when `kIsWeb`, Android uses `PredictiveBackPageTransitionsBuilder` natively, iOS uses `CupertinoPageTransitionsBuilder` natively, and macOS/Windows/Linux/Fuchsia always use no transition.

## Steps

1. Add `_NoPageTransitionsBuilder` to the theme file.
2. Replace the constant map with a map that branches on `kIsWeb` for Android and iOS.
3. Cover every `TargetPlatform` explicitly.
4. Extend theme tests for Android native, iOS native, and all desktop builders; isolate the web assertion where `kIsWeb` is testable.

## Check it

`dart analyze` exits clean. `grep -c "_NoPageTransitionsBuilder" app/lib/app/theme.dart` is at least 6. Theme tests pass.

## Don't touch

- Keep predictive-back transitions on native Android.
- Keep Cupertino transitions on native iOS.
- Do not customize individual routes.

## STOP if

- Routing has moved away from Material page routes.
- A platform cannot be covered through `PageTransitionsTheme`.
- A check fails twice.

## When you're done

Tell the developer that routes now switch instantly on web and desktop while mobile motion stays native. Navigate between home and setup on web to demonstrate it.
