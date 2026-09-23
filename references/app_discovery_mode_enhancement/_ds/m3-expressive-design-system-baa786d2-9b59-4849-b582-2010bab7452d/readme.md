# M3 Expressive Design System

A design system extracted from **"Material 3 Design Kit (Community).fig"** — a 87,522-node Figma community file covering the Material 3 Expressive component library, its variable-based token system, and a set of example product screens.

## Sources

| Source | What was taken from it |
| --- | --- |
| `Material 3 Design Kit (Community).fig` (attached; mounted read-only) | Everything. 5 Figma Variable collections (309 variables, 40 modes), 137 Material Symbols glyphs, component geometry read from the reconstructed JSX, and the `Examples/*` product frames that the UI kits recreate. |
| Figma pages read | Getting-started, Table-of-contents, Avatars, Icons, Examples, Shape, Styles, Utilities, App-bars, Badges, Buttons, Cards, Carousel, Checkboxes, Chips, Date-time-pickers, Dialogs, Dividers, Lists, Loading-progress, Menu, Navigation, Radio-button, Search, Sheets, Sliders, Snackbar, Switch, Tabs, Text-fields, Toolbars, Tooltips |

No Figma URL, GitHub repo or codebase was provided — the .fig file is the sole source of truth. Every number in `tokens/` and `components/` is transcribed from it, not from the published Material 3 spec.

**There is no logo in the source.** The file contains `.Building Blocks/Colourful logo`, `.Building Blocks/Favicon` and `.Building Blocks/Monogram` as generic placeholder symbols, not a brand mark. `thumbnail.html` therefore sets the name in type (Roboto on primary), and anywhere a wordmark is needed, set it in the brand font — do not draw a mark.

---

## Index

| Path | What it holds |
| --- | --- |
| `styles.css` | The only file consumers link. `@import`s everything below. |
| `tokens/fig-tokens.css` | Generated from Figma Variables: 309 tokens across 40 modes (Light/Dark, high & medium contrast, 13 hue themes light+dark, Monochrome, Wireframe, Baseline). |
| `tokens/fonts.css` | Font-family tokens + the Google Fonts import. |
| `tokens/typography.css` | The 15-step M3 type scale as `--m3-*` shorthands and `.m3-*` classes. |
| `tokens/shape.css` | The 10-step corner scale. |
| `tokens/elevation.css` | 6 elevation levels, state-layer opacities, easing curves, durations. |
| `tokens/base.css` | Body reset and link colours. |
| `components/buttons/` | Button, IconButton, ToggleButton, Fab, ExtendedFab, FabMenu, SplitButton, ButtonGroup, SegmentedButton |
| `components/selection/` | Checkbox, RadioButton, Switch, Slider, Chip |
| `components/containment/` | Card, Dialog, Sheet, Snackbar, Tooltip, Badge, Divider, Carousel |
| `components/navigation/` | TopAppBar, BottomAppBar, NavigationBar, NavigationRail, NavigationDrawer, Tabs, Toolbar, SearchBar, Menu, TableOfContents |
| `components/content/` | ListItem, TextField, Avatar, ProgressIndicator, LoadingIndicator, DatePicker, TimePicker |
| `components/utilities/` | StatusBar, GestureBar, FocusIndicator, Monogram, TonalPalette, Keyboard |
| `components/building-blocks/` | AppBarContent, ButtonGroupElement, CalendarCell, ClockFace, MenuButton, MenuListItem, NavItem, ListItemElement, Thumbnail, SliderValueLabel |
| `assets/icons/` | Icon + `icon-data.js` (137 glyphs) |
| `assets/images/` | 6 3D avatar renders, the avatar placeholder SVG, and the kit's own media placeholder |
| `guidelines/` | 22 foundation specimen cards (Colors, Type, Shape, Spacing) |
| `ui_kits/mobile/` | Click-through phone kit: home, library, messages, detail |
| `ui_kits/web/` | Click-through expanded-window kit: home, library, reviews, settings, detail |
| `templates/mobile-app/` | Starting template — phone frame with app bar, sections, list, navigation bar |
| `templates/web-app/` | Starting template — expanded window with navigation rail, card grid, list |
| `SKILL.md` | Agent Skills front matter for use in Claude Code |

### Components (full list)

AppBarContent, Avatar, Badge, BottomAppBar, Button, ButtonGroup, ButtonGroupElement, CalendarCell, Card, Carousel, Checkbox, Chip, ClockFace, DatePicker, Dialog, Divider, ExtendedFab, Fab, FabMenu, FocusIndicator, GestureBar, Icon, IconButton, Keyboard, ListItem, ListItemElement, LoadingIndicator, Menu, MenuButton, MenuListItem, Monogram, NavItem, NavigationBar, NavigationDrawer, NavigationRail, ProgressIndicator, RadioButton, SearchBar, SegmentedButton, Sheet, Slider, SliderValueLabel, SplitButton, StatusBar, Switch, TableOfContents, Tabs, TextField, Thumbnail, TimePicker, ToggleButton, Toolbar, TonalPalette, TopAppBar.

### Intentional additions

- **`Icon`** — the source ships 137 loose glyph symbols with no wrapper component. One wrapper was added so consumers can reference glyphs by name instead of pasting path data.
- **`TonalPalette`** — the source's `.Tonal palettes` symbol is a static documentation frame; it is rebuilt as a parameterised component so specimen pages can generate a ramp for any key colour.

---

## CONTENT FUNDAMENTALS

The source file is a **component library, not a product**, so its copy is deliberately neutral. That neutrality *is* the content voice, and recreations should match it rather than invent marketing language.

**Casing.** Sentence case everywhere — labels, headlines, menu items, dialog titles. The file has no ALL-CAPS and no Title Case. "Show all", not "Show All". "Select date", not "SELECT DATE".

**Label copy is one to three words, verb-first.** Real strings from the file: `Label`, `Show all`, `Select date`, `Select time`, `Section title`, `Supporting text`, `Headline`, `Overline`, `Trailing text`. Buttons name the action ("Open", "Publish", "Invite"), never the mechanism ("Submit form").

**Voice.** Second person when addressing the user, and only when necessary — "Your review", "We'll never share it." No first person, no "we" as a company voice. Supporting text explains consequence, not process: "This can't be undone", "Saves mobile data".

**No emoji.** Zero emoji in the source, and none in this system. Status and meaning come from icons, colour roles and shape — not from pictographs in text.

**Placeholders stay obvious.** The file uses `Section title` / `Supporting text` / `Label` rather than plausible-looking fake content, so a designer never mistakes a placeholder for a decision. The UI kits here follow that: item titles are generic, and only the review/settings screens carry real-sounding sentences (where the shape of a real sentence matters to the layout).

**Numbers.** Tabular where they line up in a column (sizes, durations, percentages). Counts cap with a "+" — `999+`. Timestamps are short: `10:24`, `Aug 16`.

**Tone in one line.** Plain, unhurried, technical without jargon. It sounds like documentation written by someone who respects the reader's time.

---

## VISUAL FOUNDATIONS

### Colour

The whole system runs on **role tokens, never raw hex.** `--schemes-primary`, `--schemes-on-primary`, `--schemes-primary-container`, `--schemes-on-primary-container` — and the same quartet for secondary, tertiary and error. Baseline light values: primary `rgb(103,80,164)`, secondary `rgb(98,91,113)`, tertiary `rgb(125,82,96)`, error `rgb(179,38,30)`, surface `rgb(254,247,255)`, on-surface `rgb(29,27,32)`.

Note the surface is **not white** — it is a violet-tinted off-white (`#FEF7FF`), and every container step above it (`surface-container-lowest` → `highest`: `#FFFFFF`, `#F7F2FA`, `#F3EDF7`, `#ECE6F0`, `#E6E0E9`) is a tonal step, not a grey. **Elevation is expressed as tone first, shadow second.** A "raised" card is `surface-container-low` + elevation 1, not white + a big shadow.

Error is the **only** semantic colour. There is no success green, no warning amber, no info blue in the source — don't add them; use tertiary or a hue theme instead.

**40 theme modes** ship in `tokens/fig-tokens.css`: light and dark, each with high-contrast and medium-contrast variants, plus 13 hue themes (Monochrome, Pink, Rose, Red, Orange, Yellow, Chartreuse, Green, Teal, Cyan, Blue, Indigo, Purple) in light and dark, plus a Wireframe mode that swaps both font roles to Flow Circular. Switch with `<html data-theme="dark">` or `<html data-mode="teal-lt">`.

### Type

Two font roles: **brand** (display/headline/title-large) and **plain** (title/body/label). In this file both resolve to **Roboto** — the kit also references Google Sans and Google Sans Text for annotation UI, which are proprietary and fall back to Roboto here (see Caveats).

Fifteen steps, three sizes each of display / headline / title / body / label. Weight is 400 for display, headline and title-large; **500 for every label and for title-medium/small**. Tracking is the give-away detail: it goes *negative* only on display-large (-0.25px) and *positive* on small text — body-large 0.5, body-small 0.4, label-medium/small 0.5. Never set label text at 400.

Roboto Mono 400 at 9–11px is used for annotation and token values. Flow Circular is greeked wireframe type.

### Shape

Ten corner tokens: 0, 4, 8, 12, 16, 20, 28, 32, 48, full. Shape is **semantic and it moves** — this is the defining Expressive behaviour:

- Buttons are full-corner at rest and square down to the size's shape token when pressed or selected (12px at xsmall/small, 16px medium, 28px large/xlarge).
- Icon buttons morph the same way; a toggle that turns on squares off.
- Connected button groups keep only their **outer** corners full; inner corners take the shape token.
- Chips are 8px, cards 12px, dialogs and sheets 28px, snackbars and menus 4px.
- Radius transitions run on `--m3-ease-spatial-fast` (`cubic-bezier(.42,1.67,.21,.9)`) — a slight overshoot, so shape change reads as springy, not as a fade.

### Elevation & shadow

Six levels, each a **pair** of shadows: a tight key shadow at `rgba(0,0,0,0.3)` and a wide ambient at `rgba(0,0,0,0.15)`. Level 1 `0 1px 2px / 0 1px 3px 1px`; level 3 (FAB, dialog, menu, expanded search) `0 1px 3px / 0 4px 8px 3px`; level 5 is reserved and rare. There are **no inner shadows** anywhere in the source. Cards prefer tone over shadow; only FABs, dialogs, menus, snackbars and floating toolbars carry real elevation.

### Interaction states

Every interactive surface has a **state layer**: a full-bleed overlay of the *content* colour at a fixed opacity — hover 8%, focus 10%, pressed 10%, dragged 16%. Nothing lightens or darkens its own background colour, and nothing changes opacity as a hover effect. Disabled is two moves at once: container at 10% of on-surface, content at 38% opacity.

Presses do **not** shrink. The press signal is the state layer plus the corner morph. Elevated components lift one level on hover (1→2, 3→4).

### Motion

`--m3-ease-standard` `cubic-bezier(.2,0,0,1)` for most property changes; decelerate for entrances, accelerate for exits; `--m3-ease-spatial-fast` (with overshoot) for anything that changes shape or size. Durations: short 200ms, medium 350ms, long 500ms. Indeterminate progress and the Expressive loading indicator loop continuously; nothing else animates on idle.

### Borders

Hairlines are always **1px `--schemes-outline-variant`** (`#CAC4D0`) for dividers and outlined cards, and **1px `--schemes-outline`** (`#79747E`) for controls that must read as interactive (outlined text fields, segmented buttons). Focused text fields thicken to 2px and take primary. No 2px decorative borders, no coloured left-border accents.

### Layout

Spacing sits on a 4px grid, but the real gaps in use are **2, 4, 8, 12, 16, 24, 48, 64px** — and they scale with component size rather than being uniform: button internal gap runs 4 → 8 → 8 → 12 → 16px across xsmall→xlarge, and horizontal padding 12 → 16 → 24 → 48 → 64px. Page gutters are 16px on compact (mobile) and 24px on expanded (web).

Fixed elements: status bar 52px, gesture bar 24px, top app bar 64/112/152px, navigation bar 80px, bottom app bar 80px, navigation rail 96px collapsed / 220px expanded, navigation drawer 360px, side sheet 320px. Mobile frames are 412px wide with a 28px corner.

### Imagery

The source ships **no photography**. Two kinds of image asset only: a 5KB grey **media placeholder** (`assets/images/media-placeholder.png`, used 247 times across the example frames) and **30 3D avatar renders** — soft-lit, matte, pastel-on-neutral portraits with no hard shadows, warm-neutral in cast (6 are copied into `assets/images/`). There are no gradients as backgrounds, no textures, no patterns, no grain, and no full-bleed hero photography in the file. Media sits in 12px (small) or 28px (hero/carousel) rounded containers.

### Transparency & blur

Transparency appears only in state layers and scrims (`--schemes-scrim` black at 32%). **No frosted glass, no backdrop-filter, no translucent panels** in the source — a floating toolbar is opaque `surface-container` with a shadow, not a blur.

### Cards, in one sentence

12px corner; `surface-container-low` + elevation 1 (elevated), `surface-container-highest` flat (filled), or `surface` + a 1px outline-variant hairline (outlined); content padded 16px; interactive cards add the 8% state layer and lift one elevation level.

---

## ICONOGRAPHY

**System:** Material Symbols, as drawn in the source file. 137 glyphs are extracted to `assets/icons/icon-data.js` as real path data (`{ viewBox, body }`) and rendered by `Icon`. They are **not** redrawn — every path comes from the .fig.

**Style:** outlined, 24px optical grid, single colour via `currentColor`. Filled counterparts exist only where state demands them and are named accordingly: `Star` / `StarFilled`, `Bookmark` / `BookmarkFilled`, `Folder` / `FolderFilled`, `PlayArrow` / `PlayArrowFilled`, `Keyboard` / `KeyboardFilled`, `FastForward` / `FastForwardFilled`. A trailing `2` in a name (`Mail2`, `Edit2`, `Settings2`) is the file's own duplicate/alternate weight of the same glyph.

**Sizes in use:** 18px in chips, 20px in xsmall/small buttons, **24px default**, 32px in large buttons, 36px in the large FAB, 40px in xlarge buttons.

**Colour:** icons take the on-role colour of whatever contains them — `on-surface-variant` for standard icon buttons and list leading icons, `on-primary` inside filled buttons, `primary` for a selected standard toggle.

**No icon font.** `tokens/fonts.css` does import Material Symbols Outlined from Google Fonts as a fallback for glyphs the extraction dropped, but every component here uses the extracted SVG data. **No emoji, and no Unicode characters standing in for icons** — the one exception is the `★` run used as a rating overline in the reviews screen, which is a text ornament, not an icon.

**Not in the extracted set:** `Home`, `List`, `Menu` (the file names its hamburger `MenuOpen`), and `VolumeUp` (present in the file but with no decodable vector geometry). Use `Inbox`, `Folder` and `MenuOpen`.

---

## Caveats

- **Fonts.** Google Sans, Google Sans Text and Google Symbols are proprietary Google faces used for the kit's own annotation UI; they are not redistributable, so `--m3-font-brand` / `--m3-font-plain` resolve to **Roboto** (the value the source's own Font-theme variables carry anyway). Roboto, Roboto Mono, Roboto Flex and Flow Circular load from Google Fonts. **If you have the Google Sans files, upload them and I'll wire the `@font-face` rules.**
- **Coverage — 43 components against 813 counted "families", deliberately.** The compiler counts every Figma component *set* and *standalone symbol* as a family. The source's 548 sets and 525 standalone symbols are overwhelmingly variant explosions and `.Building Blocks/*` sub-parts of a much smaller public API: **80 sets are togglable icon buttons** (5 sizes x 4 styles x selected/unselected x 5 states), **25 are label buttons**, 24 are `hour-line` rotations of one clock tick, 22 are calendar cells, 30 are numbered 3D avatar renders, and ~160 of the standalone symbols are individual icon glyphs. Each of those collapses to one prop-driven component — `IconButton` covers all 80 sets, `Icon` covers 137 glyphs, `DatePicker`/`TimePicker` cover the cell and tick families. Shipping one component per Figma variant would give consumers 800 near-identical exports and no API.

  The slot-level parts that *are* independently reusable ship as real components in `components/building-blocks/`: `AppBarContent`, `ButtonGroupElement`, `CalendarCell`, `ClockFace`, `MenuButton`, `MenuListItem`, `NavItem`, `ListItemElement`, `Thumbnail`, `SliderValueLabel`.

  **Intentionally skipped, and why:**
  - The remaining `.Building Blocks/*` sub-parts (`state-layer`, `Handle`, `Stops`, `Active track`, `Inactive track`, `Track dot`, `Track stop`, `Value indicator`, `Segment`, `Focus indicator` per-component copies, `hour-line`, `Progress indicator/Width 4|8/Segment|Stop|Track`) — internal Figma plumbing that exists so variants can be swapped in the file. In code these are props, pseudo-elements and generated geometry inside `Slider`, `Switch`, `ProgressIndicator` and `ClockFace`, not separate components.
  - Per-variant sets (`Type=Round, Size=Small, State=Enabled`, `Selected=True, State=Hovered`, …) — expressed as `size`/`shape`/`variant`/`selected` props and real CSS state layers.
  - `3D Avatars / 1…30` — image assets, not components; 6 are copied into `assets/images/` and any of them can be passed to `Avatar src`.
  - The 3 sets the file itself marks `?Deprecated?` (Button, FAB, Icon button).
  - Documentation frames on the `Getting-started`, `Table-of-contents`, `Styles`, `Shape` and `Examples` pages (`.Header`, `.Schematic group`, `.Swatch`, `Link to Component(s)`, `Window size class …`, and the `Examples/*` screens) — the `Examples/*` frames are instead recreated as the two UI kits and two templates, which is what they are for.
  - `.Building Blocks/Colourful logo` and `.Building Blocks/Favicon` — placeholder brand marks with no brand behind them; see the logo note above.
- **Avatars.** 6 of the 30 3D avatar renders were copied (each is ~1.3 MB). Ask if you want the rest.
