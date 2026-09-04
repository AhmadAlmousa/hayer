# Fix: Users cannot find the installed app version

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/show-app-version
- **Needs new dependency**: none; `package_info_plus` is already present

## Why

The app reads its build number only for the bootstrap compatibility check and never displays it. A quiet version/build label on the main page gives users and QA an exact identifier when reporting problems.

## Where

```dart
// app/lib/main.dart:20 — current
final package = await PackageInfo.fromPlatform();
final build = int.tryParse(package.buildNumber) ?? 1;
```

```dart
// app/lib/features/home/home_screen.dart:93 — current
FilledButton.icon(
  onPressed: () => context.push('/setup'),
```

## The fix

Add `app/lib/core/widgets/version_indicator.dart` based on the article. Load `PackageInfo.fromPlatform()` in `initState`, then render:

```dart
Text(
  '${info.appName} ${info.version} (${info.buildNumber})',
  style: Theme.of(context).textTheme.labelSmall?.copyWith(
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontFeatures: const [FontFeature.tabularFigures()],
  ),
)
```

Insert it below the main action buttons with 16 pixels of top spacing. Hayer does not use Shorebird, so no patch reader is needed.

## Steps

1. Create the stateful version indicator and handle package-info failures by rendering `SizedBox.shrink()`.
2. Add it at the bottom of the home content.
3. Add a widget test using an injected loader so version and build output are deterministic.

## Check it

`dart analyze` exits clean. `grep -c "VersionIndicator" app/lib/features/home/home_screen.dart` → 1. The widget test displays both version and build number.

## Don't touch

- Keep the bootstrap compatibility request in `main.dart`.
- Do not add Shorebird packages.
- The label must remain visually secondary.

## STOP if

- A settings/account page is introduced before execution; place the label there instead and report the scope change.
- `PackageInfo` cannot be injected for testing.
- A check fails twice.

## When you're done

Tell the developer that the exact installed version and build are now visible on the main page. Open the page and point out the quiet footer label.
