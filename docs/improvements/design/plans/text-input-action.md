# Fix: Keyboard action keys do not advance or perform the field's task

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/text-input-action
- **Needs new dependency**: none

## Why

The first join field has no explicit next action, and setup search/name inputs use generic keyboard behavior. Assigning next, search, and done lets users complete each flow from the keyboard.

## Where

```dart
// app/lib/features/join/join_screen.dart:65 — current
TextField(
  controller: _code,
  autofocus: widget.initialCode == null,
```

```dart
// app/lib/features/join/join_screen.dart:83 — current
TextField(
  controller: _name,
  textInputAction: TextInputAction.done,
  onSubmitted: (_) => _loading ? null : _join(),
```

```dart
// app/lib/features/setup/setup_screen.dart:221 — current
TextField(
  controller: _locationSearch,
  onChanged: _searchLocations,
```

```dart
// app/lib/features/setup/setup_screen.dart:425 — current
TextField(
  controller: _displayName,
  onChanged: (_) => setState(() {}),
```

## The fix

Set `TextInputAction.next` on the session-code field so Flutter moves focus to display name automatically. Keep display name at `done` and its join submission. Set location to `TextInputAction.search` with `onSubmitted: _searchLocations`, and setup display name to `TextInputAction.done` with `onSubmitted` calling `_advance()` only when `_canContinue && !_loading`.

## Steps

1. Add `next` to the join code field.
2. Add `search` and submission to location search.
3. Add `done` and guarded submission to setup display name.
4. Add widget tests that submit each field and assert focus/navigation/search behavior.

## Check it

`dart analyze` exits clean. `grep -c "textInputAction" app/lib/features/join/join_screen.dart` → 2. `grep -c "textInputAction" app/lib/features/setup/setup_screen.dart` → 2.

## Don't touch

- Keep max lengths and input formatters unchanged.
- Do not submit incomplete or loading forms.
- No custom focus nodes are required.

## STOP if

- Setup search submission would make a duplicate network request without debounce cancellation.
- The code field is no longer followed by display name.
- A check fails twice.

## When you're done

Tell the developer that keyboard actions now advance, search, or submit according to each field. Complete the join form without tapping outside the keyboard.
