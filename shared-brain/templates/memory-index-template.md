<!--
Template — index/memory-index.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/index/memory-index.md
Initialized by `project-bootstrap` for every newly registered project. This is the ONLY file read
by default at task start — it is a thin router, not a store. It must never accumulate task/
decision/knowledge rows itself; those live in the three sibling index files. Full retrieval/
validation rules: `~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.
-->

# Memory Index — <PROJECT-KEY>

Read this file first, and only this file, before deciding what else to load. Do not add
task/decision/knowledge rows here — route to the sub-index that owns them.

- **Project profile:** [../project-profile.md](../project-profile.md)
- **Improvement backlog:** [../improvement-backlog.md](../improvement-backlog.md)

## Sub-indexes

| Need | Go to |
| ---- | ----- |
| Active/completed/abandoned/archived tasks | [task-index.md](./task-index.md) |
| Decisions (active or superseded) | [decision-index.md](./decision-index.md) |
| Knowledge/pitfalls by component, integration, configuration, or operations area | [component-index.md](./component-index.md) |
| Open or completed investigations (gate status) | List directly below (kept here — investigations are few and their gate status is the first thing every task needs) |

## Investigations (gate status)
| Slug | Title | Gate status | Link |
| ---- | ----- | ----------- | ---- |
| _none_ | | | |

## Memory maintenance
- Last reviewed: <YYYY-MM-DD>
- Known stale/invalidated/candidate-never-verified entries pending cleanup: <IDs or "none">
- Category folders created so far (for orientation only — always confirm on disk before trusting this list): <list or "none yet">
