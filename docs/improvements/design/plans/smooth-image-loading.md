# Fix: Place photos pop into view or fail without a consistent placeholder

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/smooth-image-loading
- **Needs new dependency**: `image_fade` for placeholder-to-image cross-fades

## Why

Place photos are loaded in three presentation contexts with inconsistent loading and error treatment. A shared cached fade widget preserves caching, fades calmly from a plain surface, and shows a subtle broken-image icon on failure.

## Where

```dart
// app/lib/features/swipe/place_card.dart:26 — current
CachedNetworkImage(
  imageUrl: place.photoUrls.first,
  fit: BoxFit.cover,
  placeholder: (_, _) =>
      Container(color: colors.surfaceContainerHighest),
  errorWidget: (_, _, _) => _fallback(colors),
)
```

```dart
// app/lib/features/results/results_screen.dart:438 — current
CachedNetworkImage(
  imageUrl: place.photoUrls.first,
  fit: BoxFit.cover,
)
```

```dart
// app/lib/features/results/results_screen.dart:925 — current
CachedNetworkImage(
  imageUrl: widget.place.photoUrls[index],
  fit: BoxFit.cover,
  errorWidget: (_, _, _) => const ColoredBox(
```

## The fix

Create `app/lib/core/widgets/smooth_network_image.dart` using the article pattern:

```dart
ImageFade(
  image: CachedNetworkImageProvider(url),
  fit: fit,
  duration: const Duration(milliseconds: 240),
  placeholder: ColoredBox(color: colors.surfaceContainerHighest),
  errorBuilder: (_, _) => ColoredBox(
    color: colors.surfaceContainerHighest,
    child: Icon(
      Icons.broken_image_outlined,
      size: 22,
      color: colors.onSurfaceVariant.withValues(alpha: .55),
    ),
  ),
)
```

Expose `url` and `fit`, and replace all three quoted loaders. Preserve each existing bounding box, aspect ratio, and no-photo fallback.

## Steps

1. Add `image_fade` to `app/pubspec.yaml`.
2. Add the shared `SmoothNetworkImage` widget backed by `CachedNetworkImageProvider`.
3. Replace all three `CachedNetworkImage` widgets in the swipe card and results page.
4. Add widget tests for placeholder, successful fade, and subtle error state.

## Check it

`dart analyze` exits clean. `grep -c "CachedNetworkImage(" app/lib/features/results/results_screen.dart` → 0. `grep -c "SmoothNetworkImage(" app/lib/features/results/results_screen.dart` → 2.

## Don't touch

- Keep image dimensions and crop modes unchanged.
- Keep `cached_network_image`; it supplies the cached provider.
- Do not show spinners or exception text inside image slots.

## STOP if

- The three loader excerpts no longer match.
- Replacing a loader changes its pre-load dimensions.
- A check fails twice.

## When you're done

Tell the developer that all place photos now fade in from a stable placeholder and fail quietly. Demonstrate a swipe card and the results gallery on a throttled connection.
