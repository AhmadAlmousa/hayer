# Fix: Important gestures and outcomes feel silent

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/haptic-feedback
- **Needs new dependency**: `haptic_feedback` for semantic haptic types; remove `vibration` after migration

## Why

Hayer currently vibrates only after a swipe has completed, while drag thresholds, toggles, sliders, submits, and failures have no consistent feedback. A cached-capability helper and restrained semantic patterns make the app responsive without buzzing on every tap.

## Where

```dart
// app/lib/features/swipe/place_deck_swiper.dart:44 — current
onSwipe: (previousIndex, _, direction) {
  final liked = direction == CardSwiperDirection.right;
  final accepted = onDecision(previousIndex, liked);
  if (accepted) unawaited((onHaptic ?? SwipeHaptics.play)(liked));
```

```dart
// app/lib/features/setup/setup_screen.dart:477 — current
SwitchListTile(
  value: _instant,
  onChanged: (value) => setState(() => _instant = value),
)
```

```dart
// app/lib/features/setup/setup_screen.dart:856 — current
Slider(
  value: value,
  max: max,
  divisions: max.round(),
  onChanged: onChanged,
)
```

```dart
// app/lib/features/home/home_screen.dart:142 — current
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(AppLocalizations.of(context)!.resumeFailed)),
);
```

## The fix

Replace `SwipeHaptics` with an app-wide helper based on the article:

```dart
abstract final class AppHaptics {
  static bool? _canVibrate;
  static Future<void> _play(HapticsType type) async {
    _canVibrate ??= await Haptics.canVibrate();
    if (_canVibrate ?? false) await Haptics.vibrate(type);
  }
  static Future<void> success() => _play(HapticsType.success);
  static Future<void> error() => _play(HapticsType.error);
  static Future<void> light() => _play(HapticsType.light);
  static Future<void> medium() => _play(HapticsType.medium);
  static Future<void> selection() => _play(HapticsType.selection);
  static Future<void> rigid() => _play(HapticsType.rigid);
}
```

Convert `PlaceDeckSwiper` to stateful, track the last drag side and whether `horizontalOffset.abs() >= 65`, and trigger one `selection()` as the still-held card crosses the decision threshold in either direction. Reset below 45 pixels to provide hysteresis; do not wait for `onSwipe`. Use selection on ChoiceChip changes, switch changes, and discrete slider divisions; light when opening the details sheet; success after join/create/copy; error before every visible failure snackbar or inline submit error.

## Steps

1. Add `haptic_feedback`, replace the helper implementation, and remove `vibration` after no imports remain.
2. Move swipe feedback from `onSwipe` to threshold crossing during `cardBuilder` drag updates with 65/45 hysteresis.
3. Add selection feedback to setup chips, switch, and slider division changes.
4. Add success/error/light feedback to join/create, copy, details-sheet open, and all snackbar/error paths in home, setup, swipe, session close, and place-link handling.
5. Extend swiper tests to prove one haptic per crossing, no haptic below threshold, reset at center, and feedback before finger lift.

## Check it

`dart analyze` exits clean. `grep -c "vibration:" app/pubspec.yaml` → 0. Swiper tests prove threshold timing and hysteresis.

## Don't touch

- Do not vibrate continuously for every drag frame.
- Keep haptics best-effort and never block navigation or network state.
- Do not haptically announce ordinary passive rebuilds.

## STOP if

- The swiper does not expose live horizontal offsets while a finger remains down.
- Tests cannot inject a fake haptic callback.
- A check fails twice.

## When you're done

Tell the developer that swipe intent is now felt as soon as the held card crosses left or right, with consistent subtle feedback for key controls and outcomes. Demonstrate a threshold crossing without lifting the finger.
