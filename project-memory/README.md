# Project Memory

Per-repository memory for the Development Orchestrator (`~/.copilot/agents/development-orchestrator.agent.md`).
Each project has an **isolated** namespace under `projects/<PROJECT-KEY>/`.

## Project isolation

Knowledge, tasks, and decisions from one project are **never** automatically applied to another.
The agent loads only the current project's namespace, resolved from the repository identity at
the start of every task. Cross-project reuse happens only via the Shared Brain, after explicit
sanitization and validation.

## Registry behavior

`registry.md` lists every registered project: project key, repository name, normalized local
root, sanitized remote URL (no credentials), default branch, detected stack, registration date,
and last-accessed date. Register only verified repositories; never create fake projects.

## Project-key generation

Priority: (1) sanitized `<remote-owner>--<repository-name>`; (2) `<folder-name>--<short-path-hash>`;
(3) `<folder-name>`. The key must use safe filename characters, be stable across sessions,
distinguish same-named folders, and contain no credentials, full local path, or tokens. If
identity is ambiguous, create a separate namespace rather than merging memory.

## Namespace layout

```
projects/<PROJECT-KEY>/
├── project-profile.md      # verified repo identity, stack, commands, conventions
├── memory-index.md         # tasks, decisions, knowledge overview (shared-brain/templates/memory-index-template.md)
├── investigations/<issue-id-or-slug>/
│   ├── investigation.md    # INVESTIGATE-mode report + gate status
│   ├── approval.md         # REVIEW_APPROVAL-mode developer decision
│   └── implementation.md   # IMPLEMENT/VERIFY-mode result
├── tasks/{active,completed,abandoned}/<TASK-ID>.md
├── decisions/DEC-YYYYMMDD-###.md          # created lazily on the first real decision — not pre-scaffolded empty
├── knowledge/{architecture,patterns,known-pitfalls,constraints,troubleshooting}.md  # created lazily per category on first real entry
└── improvement-backlog.md  # project-scoped workflow-performance observations (evidence-linked)
```

`decisions/` and `knowledge/*.md` are created on demand by `decision-capture` / `knowledge-capture`
the first time this project has a real entry to record — `project-bootstrap` does not pre-create
empty category files, to avoid memory scaffolding that is never populated or read.

## Improvement backlog (project-scoped)

Each project keeps its own `improvement-backlog.md`
(`shared-brain/templates/improvement-backlog-template.md`) recording dated, evidence-linked
observations about how work actually went on **this** project (rework, blocked investigations,
rejected assumptions, missing scaffold, etc.). This is separate from
`shared-brain/improvement-backlog/backlog.md`, which tracks orchestrator/system-level patterns
across all projects. A project-level finding is promoted to the Shared Brain backlog only when it
recurs across more than one project.

## Investigation approval gate

Each card/issue passes a mandatory, persistent gate before implementation:
`investigate → investigation.md (PENDING_DEVELOPER_REVIEW) → developer review →
approval.md (APPROVED_FOR_IMPLEMENTATION) → implement → implementation.md`. Investigation never
auto-transitions into implementation on any path. Investigation artifacts stay in Project Memory,
never the Shared Brain. Policy and methodology:
`~/.copilot/shared-brain/workflows/investigation-approval-gate.md`.

## Task lifecycle

Intake → normalize → memory lookup → investigate → impact analysis → plan → implement →
validate → record decisions → extract knowledge → complete. Tasks move `active` → `completed`
only when completion criteria are met; blocked tasks stay `active`; genuinely dropped tasks move
to `abandoned` with a reason. Full procedure: the `task-intake` and `task-resume` skills.

## Memory lookup

Before broad investigation, search this project's `memory-index.md`, completed tasks, decisions,
and knowledge; then the Shared Brain index and relevant entries. Validate every reused finding
against current source; record accepted/rejected with reasons. Full retrieval budget (default max
5 entries), validation checklist, and evidence-precedence hierarchy:
`~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.

## Layered memory architecture

1. **Session Working Memory** — the current task's in-context state; ephemeral, never durable.
2. **Local Project Memory** (this store) — this repository's isolated findings, tasks, decisions,
   investigation artifacts.
3. **Team Project Knowledge** *(optional)* — reviewed, project-specific knowledge shared across a
   team, only where the repository/org already provides a secure, private, team-shared location.
   Not scaffolded here by default — document it as an available integration if one exists, rather
   than creating an unused folder.
4. **Shared Brain** — sanitized, generalized, cross-project knowledge (`~/.copilot/shared-brain/`).

Full layer responsibilities and the evidence-precedence hierarchy across all four layers:
`~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.

## Resume behavior

Resolve the current project first; load only its active task; compare saved state with the
current branch, Git HEAD, working tree, and diff; preserve prior decisions (mark invalidated
ones); continue from the correct phase without repeating valid completed work. Never resume a
similarly named task from another project.

## Knowledge promotion

Project knowledge uses `ARC/PAT/PIT/CST/TRB`. Promote to the Shared Brain (`SB-*`) only
non-client-specific, evidence-backed, reusable findings with sanitized content, explicit scope,
and invalidation conditions. See the `knowledge-capture` skill.

## Sensitive-data restrictions

Never store tokens, credentials, cookies, connection strings, or remote URLs containing
credentials. Sanitize remotes, logs, and command output. Private card content stays only where
necessary in the project task record — never in the Shared Brain.

## Stale-memory handling

Current source and executed validation override stored memory. On conflict, record it in the
task and correct the memory. Mark obsolete knowledge/decisions as **superseded**, **stale**, or
**invalidated** (with a link where applicable); never delete history. Full status vocabulary and
revalidation triggers: `~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.
