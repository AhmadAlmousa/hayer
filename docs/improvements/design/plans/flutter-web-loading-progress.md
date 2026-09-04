# Fix: Flutter web shows a blank page while booting

> Follow the steps in order. Run every check. If anything in "STOP if"
> happens, stop and report instead of improvising.

- **Link**: https://flutterpro.design/details/md/flutter-web-loading-progress
- **Needs new dependency**: none

## Why

The current web body contains only scripts, so users see an empty surface while the Flutter bundle and engine load. A tiny branded progress view tied to real loader milestones confirms that Hayer is starting.

## Where

```html
<!-- app/web/index.html:76 — current -->
<body>
  <script>
```

```html
<!-- app/web/index.html:111 — current -->
<script src="flutter_bootstrap.js" async></script>
```

## The fix

Add visible boot markup before the existing gesture-protection script:

```html
<main id="boot" aria-label="Loading Hayer">
  <img src="icons/Icon-192.png" width="72" height="72" alt="">
  <div class="progress-container" role="progressbar" aria-valuemin="0" aria-valuemax="100">
    <div class="progress-bar"></div>
  </div>
</main>
```

Move styles to `app/web/style.css`, preserve light/dark colors, and add the article's custom `app/web/flutter_bootstrap.js` with `{{flutter_js}}`, `{{flutter_build_config}}`, and 20/50/80 percent milestone updates before `runApp()`.

## Steps

1. Add the boot markup and a stylesheet link to `index.html`; keep the existing wheel/touch protections.
2. Add `style.css` with centered logo, a 120×8 rounded track, teal progress, dark-mode surface, and reduced-motion handling.
3. Add the custom bootstrap script and replace the async script include with the generated bootstrap entry as required by Flutter's template.
4. Add a web smoke check that builds and confirms the placeholders are substituted.

## Check it

`dart analyze` exits clean. `grep -c "progress-container" app/web/index.html` → 1. `grep -c "onEntrypointLoaded" app/web/flutter_bootstrap.js` → 1. A release web build succeeds.

## Don't touch

- Keep the existing edge-swipe and wheel event protections.
- Do not load remote images, fonts, or animation during boot.
- No new dependencies.

## STOP if

- The Flutter build no longer recognizes custom bootstrap placeholders.
- The boot element remains visible after Flutter mounts.
- A check fails twice.

## When you're done

Tell the developer that web startup now shows the Hayer icon and milestone-based progress. Demonstrate it with cache disabled and network throttling.
