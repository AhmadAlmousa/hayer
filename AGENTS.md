## Repository navigation

Use the repository tool that matches the task:

* Use Graft for architecture, subsystems, symbol relationships, callers,
  dependencies, and likely change impact.
* Use tgrep for exact or regex searches and exhaustive occurrences of strings,
  constants, configuration keys, errors, routes, or flags.
* Skip repository discovery for simple edits when the exact target is already
  known.

For non-trivial code changes:

1. Use Graft to identify the relevant subsystem and source spans.
2. Use tgrep when concrete or exhaustive occurrences are needed.
3. Read the exact source that will be modified. Inspect additional files only
   when the task requires them.
4. Use `graft callers <symbol>` before changing a shared symbol or when the
   blast radius is unclear.
5. Run the smallest relevant validation for the changed behavior. Expand the
   checks when risk, failures, or the task requires it.

Prefer:

```
tgrep "<pattern>" .
```

over repository-wide `rg` when the tgrep index or server is available. Use a
raw search for files that are not indexed.

See `graft/INDEX.md` for Graft command details. Graft identifies relevant
source; it does not replace reading code before editing it.

<!-- graft:start -->
## Graft — repo context graph

This repo is indexed in `graft/`: small linked markdown nodes that explain each
system and carry exact file:line spans, kept in sync with the code through git.

For ANY task here — understanding how something works, finding where code lives,
or scoping a change — get context from the graph before grepping or opening
source files. Re-ask freely (it's cheap) and reuse literal identifiers you
already have (symbol, error string, file name) as the query. New to this repo?
Run `graft map` first — a token-budgeted orientation (dir clusters, hubs,
hotspots), no LLM, no key.

- Run `graft ask "<your question>" --source` → ranked nodes with the relevant
  code spans inlined (each hit's ≤8-line crux by default; `--full` for whole
  definitions when the crux isn't enough). Match the tool to the task shape:
  for understanding or editing, the top node IS the answer — cite its
  `covers:` file:line spans and edit straight from `--source`. For
  exhaustive tasks ("every occurrence / every caller of this pattern"), ranked
  results are top-N, not complete — run `graft grep "<literal>"` instead
  (exhaustive over indexed files, grouped by enclosing symbol), falling back
  to raw `grep -rn` only for unindexed files.
- `graft skeleton <file>` → every definition's signature + span, ~10× cheaper
  than reading the file; use it to skim an API surface.
- `graft callers <symbol>` gives precomputed, exact edges — who calls this.
  Add `--direction out` for what it calls, or `--depth N` to walk
  transitively for the full blast radius. For structural questions, skip
  ranking and use this directly.
- Or browse: `graft/INDEX.md` lists every node; follow the links.
- Monorepos and folders of multiple repos rank fairly across sub-projects —
  hits carry `[scope/]` labels naming which one they're from. Narrow with
  `graft ask "<task>" --in <scope>/` once you know where you're working.

If a returned span is truncated ("+N more lines"), open the file at that exact
range before finalizing. Only open source files when a node genuinely lacks a
needed detail, and then at the exact file:line the node points to — never
re-read whole files.

After big code changes, refresh the graph with `graft build` (deterministic,
no API key, $0).
<!-- graft:end -->
