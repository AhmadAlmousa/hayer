# Fix: The setup keyboard can return after closing a picker

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/unfocus-before-modal
- **Needs new dependency**: none

## Why

Location or display-name input may remain focused when the visit-time picker opens. Unfocusing through the global focus manager before either platform modal prevents the keyboard from reopening when the picker closes.

## Where

```dart
// app/lib/features/setup/setup_screen.dart:649 — current
Future<void> _pickVisitTime() async {
  final now = DateTime.now();
```

```dart
// app/lib/features/setup/setup_screen.dart:660 — current
final confirmed = await showCupertinoModalPopup<bool>(
```

```dart
// app/lib/features/setup/setup_screen.dart:703 — current
final date = await showDatePicker(
```

## The fix

Make the first statement in `_pickVisitTime` the article's exact focus action:

```dart
FocusManager.instance.primaryFocus?.unfocus();
```

One placement before the platform branch covers Cupertino date/time and Material date/time pickers. Do not use `FocusScope.of(context)`.

## Steps

1. Add the global focus-manager call at the start of `_pickVisitTime`.
2. Add a widget test that focuses a setup field, invokes the picker, closes it, and verifies focus does not return.
3. Exercise both platform branches through the existing platform override/testing mechanism.

## Check it

`dart analyze` exits clean. `grep -c "FocusManager.instance.primaryFocus?.unfocus" app/lib/features/setup/setup_screen.dart` → 1.

## Don't touch

- Do not unfocus when moving between ordinary text fields.
- Do not replace the adaptive picker selection in this plan.
- No new dependencies.

## STOP if

- `_pickVisitTime` no longer owns both modal branches.
- The test cannot dismiss the modal cleanly.
- A check fails twice.

## When you're done

Tell the developer that closing the visit-time picker no longer brings an old keyboard focus back. Demonstrate it after typing into a setup field.
