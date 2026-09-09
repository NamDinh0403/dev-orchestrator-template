<!--
Template — index/component-index.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/index/component-index.md
Routes a component/integration/configuration/operations lookup to the 1-5 specific knowledge or
pitfall files worth loading — never the whole knowledge/ or pitfalls/ tree. Updated by
`knowledge-capture` whenever a new knowledge/pitfall file is created or superseded.
-->

# Component Index — <PROJECT-KEY>

One row per component/integration/configuration/operations area that has at least one knowledge or
pitfall entry. Do not add a row until a real file exists at the target path.

| Component / area | Knowledge files | Pitfall files | One-line summary | Status |
| ---------------- | ---------------- | -------------- | ----------------- | ------ |
| _none yet_ | | | | |

## Discipline
- One row per scoped area — not per individual fact inside a file that already has a row.
- `Status` mirrors the least-fresh entry among the linked files (`verified` only if all linked
  entries are `verified`; otherwise note the weakest, e.g. `1 stale`).
- Remove a row only when every file it points to has been deleted from disk — otherwise mark
  `superseded`/`stale` and keep the row (never silently drop traceability).
