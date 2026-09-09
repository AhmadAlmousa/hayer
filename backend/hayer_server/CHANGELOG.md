## Unreleased

- Add an additive participant destination ballot and per-caller choice
  revision.
- Add `chooseDestination` with membership, expiry, matched-candidate, stale
  revision, and same-choice retry handling.
- Return anonymous aggregate destination counts, the caller's own ballot, and
  plurality/host-ballot tie state in an optional session-bundle field.
- Resolve ordered 2–20-place saved shortlists against the authoritative catalog
  and optionally append up to five fresh candidates without accepting local
  snapshots or notes.

## 1.0.0

- Initial version, created by Stagehand
