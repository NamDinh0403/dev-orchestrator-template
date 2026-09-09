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
├── memory-index.md         # tasks, decisions, knowledge overview
├── investigations/<issue-id-or-slug>/
│   ├── investigation.md    # INVESTIGATE-mode report + gate status
│   ├── approval.md         # REVIEW_APPROVAL-mode developer decision
│   └── implementation.md   # IMPLEMENT/VERIFY-mode result
├── tasks/{active,completed,abandoned}/<TASK-ID>.md
├── decisions/DEC-YYYYMMDD-###.md
├── knowledge/{architecture,patterns,known-pitfalls,troubleshooting}.md
└── improvement-backlog.md  # project-scoped workflow-performance observations (evidence-linked)
```

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
against current source; record accepted/rejected with reasons.

## Resume behavior

Resolve the current project first; load only its active task; compare saved state with the
current branch, Git HEAD, working tree, and diff; preserve prior decisions (mark invalidated
ones); continue from the correct phase without repeating valid completed work. Never resume a
similarly named task from another project.

## Knowledge promotion

Project knowledge uses `ARC/PAT/PIT/TRB`. Promote to the Shared Brain (`SB-*`) only
non-client-specific, evidence-backed, reusable findings with sanitized content, explicit scope,
and invalidation conditions. See the `knowledge-capture` skill.

## Sensitive-data restrictions

Never store tokens, credentials, cookies, connection strings, or remote URLs containing
credentials. Sanitize remotes, logs, and command output. Private card content stays only where
necessary in the project task record — never in the Shared Brain.

## Stale-memory handling

Current source and executed validation override stored memory. On conflict, record it in the
task and correct the memory. Mark obsolete knowledge/decisions as **superseded** with a link;
never delete history.
