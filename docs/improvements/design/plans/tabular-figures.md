# Fix: Changing counters and codes shift as digits change

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/tabular-figures
- **Needs new dependency**: none

## Why

Swipe progress, participant progress, vote ratios, session codes, and slider values change or align with nearby numbers. Tabular figures keep those digits still and make codes easier to scan.

## Where

```dart
// app/lib/features/swipe/swipe_screen.dart:100 — current
child: Text(
  '${(_index + 1).clamp(1, bundle.deck.length)} / '
  '${bundle.deck.length}',
```

```dart
// app/lib/features/lobby/lobby_screen.dart:122 — current
Text(
  bundle.session.code,
  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
```

```dart
// app/lib/features/results/results_screen.dart:513 — current
child: Text(
  '${(ratio * 100).round()}% · ${result.likeCount}/${result.voterCount} liked it',
```

```dart
// app/lib/features/setup/setup_screen.dart:844 — current
child: Text(
  label,
  key: ValueKey(label),
```

## The fix

Import `dart:ui` and add `fontFeatures: const [FontFeature.tabularFigures()]` only to numeric styles that change, align, or represent a code. Apply it to the join code field, lobby session code and participant progress, results summary/vote ratios/rating chips, swipe progress, and fine-tuning slider value. Do not set it globally or on numbers embedded in ordinary prose.

## Steps

1. Add the font feature to code-entry and code-display styles.
2. Add it to swipe, lobby, and results changing counters.
3. Add it to the animated slider label and numeric result metadata.
4. Add widget/theme tests that inspect representative text styles.

## Check it

`dart analyze` exits clean. `grep -c "tabularFigures" app/lib/features/swipe/swipe_screen.dart` → 1. Representative widget tests pass.

## Don't touch

- Do not add tabular figures to body text globally.
- Do not change font family, weight, size, or number formatting in this plan.
- No new dependencies.

## STOP if

- Nunito's bundled variable font lacks tabular-figure support.
- A targeted numeric string no longer exists at the quoted location.
- A check fails twice.

## When you're done

Tell the developer that changing progress and vote numbers stay visually anchored and session codes are easier to read. Watch the swipe counter advance to demonstrate it.
