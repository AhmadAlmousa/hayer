# Fix: The home logo can appear a frame late

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/precache-icons
- **Needs new dependency**: none

## Why

The first screen requests its branded raster image only when it builds, which can make the logo pop in late. Precaching that single asset before revealing the home content removes the decode delay.

## Where

```dart
// app/lib/features/home/home_screen.dart:71 — current
child: Image.asset(
  'assets/branding/hayer_icon.png',
  width: 112,
  height: 112,
),
```

## The fix

Add a one-shot future in `_HomeScreenState`, initialized from `didChangeDependencies` because `precacheImage` needs context:

```dart
bool _assetsRequested = false;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_assetsRequested) return;
  _assetsRequested = true;
  unawaited(
    precacheImage(
      const AssetImage('assets/branding/hayer_icon.png'),
      context,
    ),
  );
}
```

The asset remains displayed by the existing fixed-size `Image.asset`; no package is required because there are no SVG assets.

## Steps

1. Import `dart:async` in the home screen.
2. Add the guarded `didChangeDependencies` precache shown above.
3. Add a widget test that pumps the home screen twice and verifies one `AssetImage` precache request.

## Check it

`dart analyze` exits clean. `grep -c "precacheImage" app/lib/features/home/home_screen.dart` → 1.

## Don't touch

- Do not precache network photos.
- Do not add `flutter_svg`; the app has no SVG assets.
- Keep the logo dimensions unchanged.

## STOP if

- The home logo path changes.
- Asset precaching delays the first interactive frame.
- A check fails twice.

## When you're done

Tell the developer that the branded home icon is warmed into the image cache before first paint. Cold-start the app to demonstrate the stable logo.
