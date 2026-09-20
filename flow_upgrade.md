# Hayer unified intent flow

## Goal

Replace the home-level “In a Hurry vs Got Time” choice with one shared intent:

**WHAT → WHERE → WHAT NEXT**

The three outcomes are **Quick Pick**, **Explore**, and **Decide Together**.
They reuse the same canonical category selection and search area; they are UX
actions rather than user-facing technical modes.

## Flow

1. **WHAT** opens directly at `/`. It shows the complete searchable recursive
   taxonomy. Users may choose up to five categories in one curated selection
   group. A selectable parent means “all beneath this parent”; choosing a child
   replaces the parent, and crossing groups requires confirmation.
2. **WHERE** makes current location the one-tap path. “Choose another area”
   reuses the address search and interactive center/radius map. The unobtrusive
   default is 3 km, adjustable from 500 m to 10 km.
3. **WHAT NEXT** summarizes the context and offers:
   - **Quick Pick** — ten places immediately, with no filter configuration.
   - **Explore** — Discover opened with the selected categories and area.
   - **Decide Together** — a ten-place room using majority/after-deck defaults,
     with optional room rules before creation.

Quick Pick and group results share optional result filtering and sorting.
After the first Quick Pick batch, a user may append ten unseen places to the
same solo session; after the second batch Hayer offers Explore instead.

## Architecture

- One app-scoped immutable place-intent controller owns taxonomy revision,
  selection group, category IDs, center/radius/address, filters, text and sort.
- Discover links remain URL-owned and import/export the same intent. A committed
  map viewport becomes the current center/radius; session actions require a
  viewport no wider than the 10 km session limit.
- The recursive Discovery taxonomy becomes canonical. Curated group roots,
  selectability and acquisition queries are taxonomy metadata, independent of
  tree depth. Area-specific counts remain an optional future annotation.
- New intent-based session contracts coexist with the legacy create contract
  until the minimum client build advances. New sessions persist their intent so
  deterministic ten-place extension and cross-action transitions are possible.
- Saved is bookmark management only. The shortlist creation UI is retired, and
  every place surface exposes the same outline/filled heart control.

## Delivery

1. Add canonical taxonomy metadata, intent/session protocols, persistence and
   server-side validation while preserving old clients.
2. Add shared app intent state, count-free taxonomy selection and area adapters.
3. Replace Home/Setup with WHAT, WHERE and WHAT NEXT.
4. Wire Quick Pick, Explore, Decide Together, full-query transitions and the
   one-time solo deck extension.
5. Add shared result Refine, consistent hearts, Saved simplification, routing
   compatibility, tests, release verification and legacy cleanup.

## Acceptance

- English, Arabic, RTL and 200% text complete all three journeys.
- Category grouping, parent/child replacement and server validation agree.
- Current-location denial and alternate-area map editing remain recoverable.
- Discover deep links and cross-action transitions retain their full query.
- Result filters never change votes, eligibility or the recorded winner.
- Solo extension is idempotent, preserves the original deck prefix, excludes
  seen places and cannot run for multiplayer or more than once.
- Previous clients and active legacy sessions continue to work during rollout.
