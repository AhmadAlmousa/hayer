# Fix: A broken widget becomes an empty grey box in release

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/friendly-error-view
- **Needs new dependency**: none

## Why

No custom `ErrorWidget.builder` is installed, so a release build gives users a blank grey region when a widget fails. A responsive branded fallback keeps technical details hidden in release and copyable by long press for diagnostics.

## Where

```dart
// app/lib/main.dart:11 — current
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
```

## The fix

Create `app/lib/core/widgets/friendly_error_view.dart` using the article's complete structure: a stateful `FriendlyErrorView(details:)`, 2600 ms copied-state timer, medium haptic on long press, clipboard text containing exception plus stack, self-provided `Directionality` and transparent `Material`, and a `LayoutBuilder` that selects full layout only at bounded width ≥300 and height ≥320.

The full view uses `CustomScrollView` and `SliverFillRemaining(hasScrollBody: false)`, dynamic media padding plus 32 pixels, a primary-container background, a 104-pixel 12-point rounded `StarBorder` badge, localized title/body, and debug-only exception/stack text. The compact view uses a 48-pixel badge and debug-only two-line exception. Both views use `HitTestBehavior.opaque`; release mode never paints technical text.

Install it immediately after binding initialization:

```dart
ErrorWidget.builder = (details) => FriendlyErrorView(details: details);
```

## Steps

1. Add the complete responsive error view described above, preserving all article dimensions and debug/release branches.
2. Add localized “Something went wrong”, restart advice, and copied semantics messages to English and Arabic ARB files.
3. Install `ErrorWidget.builder` before network/bootstrap work in `main.dart`.
4. Add tests for compact/full constraints, release-safe content, debug details, long-press clipboard, copied badge, and timer cleanup.

## Check it

`dart analyze` exits clean. `grep -c "ErrorWidget.builder" app/lib/main.dart` → 1. Tests prove no exception text is visible when `kDebugMode` is false-equivalent logic.

## Don't touch

- Do not send errors over the network.
- Do not expose stack traces or exceptions in release UI.
- Do not depend on an ancestor `Material`, `Directionality`, or bounded constraint.

## STOP if

- The fallback itself throws without an inherited theme.
- Release-mode visibility cannot be tested or reasoned about safely.
- A check fails twice.

## When you're done

Tell the developer that widget failures now show a friendly Hayer-branded fallback and retain hidden copy diagnostics. Open the test harness at both compact and full-screen sizes.
