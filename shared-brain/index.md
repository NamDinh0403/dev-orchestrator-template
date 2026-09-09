# Shared Brain Index

Concise lookup for the Development Orchestrator. Load only matching entries, not entire files.
Search by technology, framework, error, entity, integration, task type, module, configuration
key, build tool, or testing tool.

## Patterns (`engineering/patterns.md`)

| ID | Title | Scope / keywords | Confidence |
| -- | ----- | ---------------- | ---------- |
| SB-PAT-000 | _Example_ — prefer a config/DI seam over forking a shared library | illustrative example, replace once you have a real entry | n/a |

## Pitfalls (`engineering/known-pitfalls.md`)

| ID | Title | Scope / keywords | Confidence |
| -- | ----- | ---------------- | ---------- |
| _none_ | | | |

## Troubleshooting (`engineering/troubleshooting.md`)

| ID | Title | Symptom / keywords | Confidence |
| -- | ----- | ------------------ | ---------- |
| _none_ | | | |

## Decision principles (`engineering/decision-principles.md`)

| ID | Title | Scope / keywords |
| -- | ----- | ---------------- |
| SB-DEC-000 | _Example_ — prefer extension/DI override over editing shared libraries | illustrative example, replace once you have a real entry |

## Procedures — focused skills (`~/.copilot/skills/`)

The orchestrator routes each phase to a focused skill:

| Concern | Skill |
| ------- | ----- |
| intake → completion | `task-intake` |
| resume an interrupted task | `task-resume` |
| INVESTIGATE mode — read-only report (`/investigate-issue`) | `investigate-issue` |
| progressive investigation | `code-investigation` |
| REVIEW_APPROVAL mode — approval decision (`/review-investigation`) | `review-investigation` |
| IMPLEMENT/VERIFY mode — gated implementation (`/implement-card`) | `implement-card` |
| impact analysis + tiered plan | `implementation-planning` |
| validation ordering | `targeted-validation` |
| diff review | `diff-review` |
| classification and promotion | `knowledge-capture` |
| decision records | `decision-capture` |
| first-time project setup | `project-bootstrap` |
| resolving material unknowns | `requirement-grilling` |

## Workflow policies (`workflows/`)

| File | Purpose |
| ---- | ------- |
| `investigation-approval-gate.md` | Mandatory investigation→review→implementation gate: operating modes, gate statuses, approval rules, reapproval triggers, reviewer identity, artifact layout |

## Improvement backlog (`improvement-backlog/`)

| File | Purpose |
| ---- | ------- |
| `backlog.md` | Orchestrator/system-level workflow-performance observations, improvement proposals (approval-gated), metric definitions — cross-project patterns only |

Each **project** also keeps its own `project-memory/projects/<KEY>/improvement-backlog.md`
(`templates/improvement-backlog-template.md`) for project-specific workflow observations. Promote a
finding here only when it recurs across more than one project.

## Templates (`templates/`)

`task-min-template.md` (Fast/Standard records), `task-full-template.md` (Deep records),
`decision-template.md`, `knowledge-template.md`, `project-profile-template.md`,
`investigation-template.md`, `approval-template.md`, `implementation-template.md`,
`improvement-backlog-template.md`.
