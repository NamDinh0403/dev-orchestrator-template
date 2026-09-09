---
name: project-bootstrap
description: Create isolated Project Memory for a repository the agent has not seen before — generate a stable project key, build a verified project profile, register it, and initialize the memory namespace. Use only when the current project is not in the registry.
---

# Skill — Project Bootstrap

First-time initialization of an isolated Project Memory namespace. Invoked by the orchestrator or
`task-intake` when the current repository is not registered.

## Trigger
Current project key is absent from `~/.copilot/project-memory/registry.md`.
**Non-trigger:** project already registered (load its namespace instead).

## Procedure
1. Generate the stable project key (see `task-intake`, section C). Ensure it distinguishes
   same-named folders and contains no credentials/paths/tokens.
2. Create the namespace scaffold that is actually used from task start:
   `projects/<KEY>/{project-profile.md, memory-index.md, improvement-backlog.md, tasks/{active,completed,abandoned}/}`.
   Do **not** pre-create `decisions/` or `knowledge/*.md` — those are created lazily by
   `decision-capture` / `knowledge-capture` the first time this project has a real entry to write
   (see `~/.copilot/shared-brain/workflows/memory-evidence-policy.md`). Pre-scaffolding empty
   knowledge/decision files has produced unused, never-populated folders in practice.
3. Build `project-profile.md` from **verified repository evidence only**
   (`shared-brain/templates/project-profile-template.md`): identity, stack, modules, locations,
   build/test/lint commands (verify before use), integration boundaries, conventions, evidence,
   invalidation conditions. Do not infer unsupported architecture.
4. Register the project in `registry.md`: key, repo name, normalized local root, sanitized remote
   (no credentials), default branch, detected stack, registration date, last-accessed date.
5. Initialize `memory-index.md` from `shared-brain/templates/memory-index-template.md` (empty
   tables — no fake entries).
6. Initialize `improvement-backlog.md` from `shared-brain/templates/improvement-backlog-template.md`
   (empty Observations/Proposals tables — no fake entries).

## Output
An isolated, registered Project Memory namespace ready for the task.

## Memory
- Reads: repository manifests, `git remote`.
- Writes: new `projects/<KEY>/**` + a `registry.md` row.

## Failure behavior
If repository identity is ambiguous, create a separate namespace rather than merging with an
existing project.
