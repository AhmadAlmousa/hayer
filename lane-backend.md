# Back-end lane log

Working notes for the back-end lane: `backend/`, deployment, server contracts,
generated clients, and repository release tooling. Codex works this lane from
the primary worktree on `main`; Claude owns front-end behavior in
`.claude/worktrees/claude-lane`.

`PROJECT.md` remains authoritative for shared decisions, milestone state, and
acceptance gates. Detailed back-end checkpoints and front-end handoffs live
here so the two lanes do not repeatedly edit the same evidence paragraphs.

Last updated: 2026-09-09

## Current state

- M7-A's F02/F03/F04 implementation and a real-PostGIS read-versus-swipe
  regression are present. Docker and physical-device acceptance remain open.
- F01's signup and method-aware join protections are implemented. Real gateway
  proof and the Cloudflare connector trust decision remain open.
- Claude completed the F17 client convergence half in `6277dcd`. The next
  back-end handoff is a lightweight mutable session-progress contract that
  avoids transferring the immutable deck on every real-time refresh.

## Checkpoints

### F01 method-aware join budget — implemented (2026-09-09)

`hayerSession.join` retains its 30-request/minute authenticated-user budget and
now also applies a 120-request/minute budget to the client address vouched for
by the gateway. Requests without that header fall back to the direct peer, so
direct-origin access cannot spend a legitimate forwarded client's budget.

The per-client ceiling allows more than twice the entire 50-person beta to join
within one minute behind a carrier NAT while bounding attacks that rotate among
previously-created anonymous identities. The endpoint itself owns this check
because every Serverpod session RPC shares `/api/hayerSession` at the gateway.

The real-PostGIS regression uses distinct authenticated identities sharing the
test peer and proves the 121st join attempt is rejected by the client budget.
Live proof of forwarded addresses, forged headers, and direct-origin behavior
still requires the production-like gateway/container environment.

Verification: pinned full preflight passes generation/formatting, all fatal-
info analyses, 101 server tests, 123 app tests, nine admin tests, shell checks,
and diff checks. The new integration case compiles but cannot run because this
host has no Docker command. The required signed `0.2.1+7` APK and alias are
104,876,403 bytes at SHA-256
`0ac17018b52c8685eaa783836bb2c79da44ff1fe9ba1af5e35cf6c0a7da7de0f`;
both manifests and APK Signature Scheme v2 verify. The backend-only change
correctly leaves the APK bytes unchanged from the prior P06 build.

## Open handoffs to the front-end lane

### F17 lightweight progress contract

Planned next: retain the existing full `load` response for bootstrap and old
clients, add a deck-free mutable progress response for refresh, and hand the
generated client contract to Claude. The contract will include room revision,
participant/self progress, and destination-choice state without exposing user
IDs or changing immutable session decks.
