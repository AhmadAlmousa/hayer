# Project Flutter and Dart guidance

## Scope

These rules apply to the Flutter applications under `app/` and `admin/`.
Backend Dart under `backend/` follows its existing Serverpod conventions.

## Working in the project

* Infer the target application and platform from the requested path and the
  surrounding implementation. Ask only when unresolved ambiguity would
  materially change behavior, scope, or platform support.
* Preserve the architecture, dependencies, and conventions of the subsystem
  being changed. Do not introduce a new package or pattern merely because it
  is generally popular in Flutter projects.
* Both Flutter applications use `go_router`; extend their existing routers
  rather than introducing another routing system.
* Keep UI, state, and data access separated where that improves the touched
  feature. Do not restructure unrelated code to satisfy a generic architecture
  template or line-count target.

## Dependencies and generated code

* Add a dependency only when the requested change needs it and the existing
  stack does not already provide the capability. Explain the project-specific
  reason for the dependency.
* Preserve the serialization approach used by the touched subsystem. Simple
  handwritten local models may use `fromJson` and `toJson`; generated Serverpod
  protocol and database files must remain generated.
* Run the relevant generator only after changing its source inputs. Do not edit
  generated files directly.

## Code conventions

* Follow the repository analyzer and formatter configuration.
* Format only changed Dart files or the affected package.
* Follow the logging abstraction already used by the touched subsystem. Do not
  add `logging` or replace it with `dart:developer` as an unrelated cleanup.
* Prefer clear, maintainable Dart. Use pattern matching, records, immutable
  values, and widget extraction when they make the specific code simpler.
* Document a public contract when it is externally consumed or its behavior is
  non-obvious. Do not backfill unrelated API documentation during a focused
  change.

## UI changes

* Preserve the existing design system, localization, accessibility behavior,
  and responsive conventions.
* Check the sizes and input methods affected by the requested UI change. A
  full multi-platform or accessibility audit is not required for every edit.
* Avoid network calls or expensive computation from widget `build` methods.

## Verification

* Run the smallest relevant test or analyzer target for the changed behavior;
  expand validation when failures, risk, or the request justify it.
* Follow the assertion style of the surrounding test file.
* Treat `dart fix` as a separate code change: preview it first and apply only
  reviewed fixes within the requested scope.
