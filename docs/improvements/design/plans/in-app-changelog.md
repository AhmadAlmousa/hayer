# Fix: Updates open without showing what changed

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/in-app-changelog
- **Needs new dependency**: `pub_semver` for ordered version comparisons and `shared_preferences` for the last-seen version

## Why

People currently receive a new build with no explanation of its fixes or features. A localized, once-per-version changelog makes improvements visible without interrupting first install.

## Where

```dart
// app/lib/main.dart:30 — current
runApp(
  ProviderScope(
    overrides: [clientProvider.overrideWithValue(client)],
    child: HayerApp(updateRequired: updateRequired),
  ),
);
```

```dart
// app/lib/app/app.dart:35 — current
return MaterialApp.router(
  title: 'Hayer',
```

```yaml
# app/pubspec.yaml:34 — current
package_info_plus: ^9.0.1
```

## The fix

Add `pub_semver` and `shared_preferences`. Create `app/lib/core/changelog.dart` with `enum AppLanguage { en, ar }`, a `Map<String, Map<AppLanguage, List<String>>>` containing every shipped version, and the article's `unseenChanges` implementation using `Version.parse`. Add a `ChangelogController` that reads `PackageInfo.version`, skips first install, persists `hayer.last-seen-version`, and exposes all entries between the saved and current versions.

Convert `HayerApp` to `StatefulWidget`. Initialize the controller after locale resolution, then present a localized `AlertDialog` containing the unseen changes. Mark the current version seen when the dialog is first shown. Use Arabic entries when `Localizations.localeOf(context).languageCode == 'ar'`, English otherwise.

## Steps

1. Add `pub_semver` and `shared_preferences` to `app/pubspec.yaml`.
2. Create `app/lib/core/changelog.dart` with the versioned bilingual map, `unseenChanges`, controller initialization, and dismissal persistence described above.
3. Convert `HayerApp` in `app/lib/app/app.dart` to stateful ownership of that controller and show the changelog once after the first frame.
4. Add localized dialog title and close-label keys to both ARB files and regenerate localization output.
5. Add unit tests for first install, same version, skipped versions, Arabic selection, malformed saved versions, and dismissal persistence.

## Check it

`dart analyze` exits clean. `grep -c "last-seen-version" app/lib/core/changelog.dart` → 1. `grep -c "pub_semver" app/pubspec.yaml` → 1. Tests prove first install is silent and a jump over multiple versions returns every intervening item.

## Don't touch

- Do not couple this to the mandatory-update screen; that screen blocks obsolete builds for a different reason.
- Do not show a changelog on first install.
- No refactors beyond changelog lifecycle and presentation.

## STOP if

- The quoted startup or app root no longer matches.
- Current release notes cannot be supplied in both English and Arabic.
- A check fails twice.

## When you're done

Tell the developer that returning users now see every update they skipped, once, in their language. Open an upgraded build to demonstrate the dialog.
