repo: AhmadAlmousa/hayer
branch: main
path: app/lib

## Last sync
date: 2026-09-11T21:20:00Z

### Updated in this project
- Recreated the live flow (Home → Setup Type/Where/Mode → Swipe) pixel-for-pixel from `app/lib` as `Hayer Today.dc.html`.
- Designed the new "Got time" discovery mode: two-hero home, four map+list constructions, live category tree, advanced filters, place detail (`Hayer Got Time.dc.html`).
- Palette, type and component shapes lifted from `app/lib/app/theme.dart` (teal seed #0E9594, Nunito, 18px buttons, 20px cards).
- Map styling follows `core/widgets/search_area_map.dart` (radius fill #0E9594 @20%, outline #087F7E, centre dot #FF6B6B).

## Screen map
| Project screen | Repo files |
| --- | --- |
| Hayer Today · Home | `app/lib/features/home/home_screen.dart`, `core/widgets/content_shell.dart`, `core/widgets/version_indicator.dart`, `app/app.dart`, `app/theme.dart` |
| Hayer Today · Setup Type | `app/lib/features/setup/setup_screen.dart`, `setup_data.dart`, `setup_timeline.dart` |
| Hayer Today · Setup Where | `app/lib/features/setup/setup_screen.dart`, `core/widgets/search_area_map.dart`, `core/display_formatters.dart` |
| Hayer Today · Setup Mode | `app/lib/features/setup/setup_screen.dart`, `multiplayer_decision_options.dart`, `core/widgets/adaptive_actions.dart` |
| Hayer Today · Swipe | `app/lib/features/swipe/swipe_screen.dart`, `place_card.dart`, `features/saved/save_place_button.dart` |
| Got Time · 1a/1b Home heroes | `app/lib/features/home/home_screen.dart`, `app/lib/app/router.dart` |
| Got Time · 1c–1f Explore | `core/widgets/search_area_map.dart`, `features/setup/setup_data.dart` (taxonomy + emoji) |
| Got Time · 1g Category tree | `app/lib/features/setup/setup_data.dart` |
| Got Time · 1h Place detail | `app/lib/core/widgets/place_details_sheet.dart`, `features/swipe/place_card.dart` |

Copy: English strings taken from `app/lib/l10n/generated/app_localizations_en.dart`.
