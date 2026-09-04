# Fix: Every browser tab is titled only “Hayer”

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/browser-tab-title
- **Needs new dependency**: none

## Why

The app sets one static title, so multiple Hayer pages cannot be distinguished in browser tabs, history, or bookmarks. One route-aware wrapper keeps all page names centralized and updates on every GoRouter navigation.

## Where

```dart
// app/lib/app/app.dart:36 — current
title: 'Hayer',
debugShowCheckedModeBanner: false,
```

```dart
// app/lib/app/router.dart:12 — current
GoRouter createAppRouter({String? initialLocation}) => GoRouter(
```

## The fix

Create a `RouteTitle` wrapper matching the article. It must listen to both `appRouter.routerDelegate` and `appRouter.routeInformationProvider`, read the current path, and wrap the active page in:

```dart
Title(
  title: titleForPath(path),
  color: Theme.of(context).colorScheme.surface,
  child: child,
)
```

Map `/` → `Hayer`, `/setup` → `New search · Hayer`, `/scan` → `Scan code · Hayer`, `/join...` → `Join session · Hayer`, `/lobby...` → `Lobby · Hayer`, `/swipe...` → `Swipe · Hayer`, and `/results...` → `Results · Hayer`. Match on parsed path segments so IDs and codes never appear in the title.

## Steps

1. Add `RouteTitle` and `titleForPath` beside the router or in a dedicated app widget file.
2. Wrap `child` with `RouteTitle` inside the routed app's builder; compose it with any existing Cupertino/text-scale wrappers instead of replacing them.
3. Keep the mandatory-update app titled `Update required · Hayer` through its static title.
4. Add unit tests for every route pattern and a widget test proving a navigation updates `Title`.

## Check it

`dart analyze` exits clean. `grep -c "RouteTitle" app/lib/app/app.dart` → 1. Route-title tests cover all seven page groups and fallback.

## Don't touch

- Do not expose session IDs or join codes in browser titles.
- Do not spread `Title` widgets across screens.
- No new dependencies.

## STOP if

- The app no longer uses the global `appRouter` instance.
- Existing builder wrappers would be lost rather than composed.
- A check fails twice.

## When you're done

Tell the developer that browser tabs now track the current Hayer page without leaking session data. Navigate from home to results to demonstrate the title change.
