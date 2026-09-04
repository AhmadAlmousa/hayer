# Fix: Shared web links appear as bare URLs

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/flutter-web-og-image
- **Needs new dependency**: none

## Why

Hayer's web document has a description but no Open Graph or X metadata. Adding a 1200×630 branded card gives shared session and app links a recognizable title, description, and image.

## Where

```html
<!-- app/web/index.html:20 — current -->
<meta name="description" content="Hayer helps you swipe through places and decide together.">
```

## The fix

Add the following to `<head>` and supply the image at the absolute URL:

```html
<meta property="og:title" content="Hayer — Decide where to go together">
<meta property="og:description" content="Swipe through nearby places and find the group favorite.">
<meta property="og:image" content="https://hayer.almou.sa/og-image.png">
<meta property="og:url" content="https://hayer.almou.sa/">
<meta property="og:type" content="website">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Hayer — Decide where to go together">
<meta name="twitter:description" content="Swipe through nearby places and find the group favorite.">
<meta name="twitter:image" content="https://hayer.almou.sa/og-image.png">
```

Create `app/web/og-image.png` at exactly 1200×630 with the Hayer mark, teal background, and readable bilingual-neutral visual treatment.

## Steps

1. Produce and add the 1200×630 optimized PNG.
2. Add the exact Open Graph and X metadata above.
3. Ensure deployment serves `/og-image.png` publicly with an image content type.
4. Add a deployment smoke assertion for status 200 and dimensions.

## Check it

`grep -c "og:image" app/web/index.html` → 1. `grep -c "twitter:image" app/web/index.html` → 1. `file app/web/og-image.png` reports 1200×630 PNG.

## Don't touch

- Do not use a relative image URL.
- Do not expose session-specific data in static metadata.
- No new dependencies.

## STOP if

- The production host for the card differs from `hayer.almou.sa`.
- The image cannot be served at the stated absolute URL.
- A check fails twice.

## When you're done

Tell the developer that Hayer links now render a branded large preview card. Validate the production URL in a social-preview debugger.
