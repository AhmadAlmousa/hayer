# Fix: The keyboard stays open while forms scroll

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/dismiss-keyboard-on-scroll
- **Needs new dependency**: none

## Why

The join form and setup steps can scroll while an input remains focused, leaving the keyboard over the next controls. Dismissing on drag matches the user's intent to move on and read what follows.

## Where

```dart
// app/lib/features/join/join_screen.dart:55 — current
child: ListView(
  padding: const EdgeInsets.all(24),
```

```dart
// app/lib/features/setup/setup_screen.dart:779 — current
Widget _stepScrollView(Widget child) => SingleChildScrollView(
  padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
```

## The fix

Set the article's behavior on both scrollable constructors:

```dart
keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
```

Because `_stepScrollView` owns all three setup pages, one change covers location search and display-name entry without affecting the swipe deck or photo gallery.

## Steps

1. Add `keyboardDismissBehavior` to the join `ListView`.
2. Add it to the setup `SingleChildScrollView` helper.
3. Add widget tests that focus a field, drag its scrollable, and assert that the primary focus is cleared.

## Check it

`dart analyze` exits clean. `grep -c "keyboardDismissBehavior" app/lib/features/join/join_screen.dart` → 1. `grep -c "keyboardDismissBehavior" app/lib/features/setup/setup_screen.dart` → 1.

## Don't touch

- Do not apply this behavior to the card swiper or photo `PageView`.
- Keep field autofocus behavior unchanged.
- No new dependencies.

## STOP if

- Either form becomes non-scrollable.
- A drag can submit or clear field content.
- A check fails twice.

## When you're done

Tell the developer that dragging either form now gets the keyboard out of the way. Demonstrate it on the join screen with the name field focused.
