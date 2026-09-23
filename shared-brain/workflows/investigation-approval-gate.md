# Workflow Policy — Investigation Approval Gate

Reusable, cross-project policy for the Development Orchestrator
(`~/.copilot/agents/development-orchestrator.agent.md`). This file holds **methodology and rules
only** — no project-specific evidence. Per-issue investigation reports, approvals, and
implementation results live in **Project Memory**, never here.

## Purpose

Enforce a **risk-scoped** gate between investigation and implementation. This gate is mandatory on
the **Deep** execution path (and on any Fast/Standard task that escalates to Deep, or that a
developer explicitly asks to be gated). It does **not** apply to default Fast or Standard tasks —
those implement directly (`INTAKE → IMPLEMENT → VERIFY → COMPLETE`, no persisted investigation/
approval artifact) because their bounded scope and low blast-radius make a persisted, human-reviewed
gate pure overhead rather than governance. Whenever the gate **is** in use, investigation must
**never** automatically transition into implementation — a developer's `APPROVED_FOR_IMPLEMENTATION`
decision is always required first.

Required flow **when the gate applies** (Deep, or an explicitly/escalation-gated task):

```
issue / card
  → INVESTIGATE          (persistent investigation report)
  → REVIEW_APPROVAL      (persistent approval decision)
  → IMPLEMENT
  → VERIFY
  → COMPLETE             (persistent implementation result)
```

Default flow for Fast/Standard (no gate):

```
issue / card
  → IMPLEMENT            (direct, from the normalized requirement)
  → VERIFY
  → COMPLETE              (concise summary; persisted record only if reusable/interrupted)
```

## Operating modes

The orchestrator must **declare the active mode** before doing mode-specific work. On Fast/Standard,
only INTAKE/IMPLEMENT/VERIFY/COMPLETE apply.

| Mode | Entry | Produces | May advance to |
| ---- | ----- | -------- | -------------- |
| INTAKE | task received | normalized requirement set + project identity | IMPLEMENT (Fast/Standard) or INVESTIGATE (Deep/gated) |
| INVESTIGATE | `/investigate-issue`; Deep or explicit request only | `investigation.md` (read-only evidence) | REVIEW_APPROVAL (developer-driven) |
| REVIEW_APPROVAL | `/review-investigation` | `approval.md` | IMPLEMENT (only if APPROVED_FOR_IMPLEMENTATION) |
| IMPLEMENT | direct (Fast/Standard) or `implement-card` with valid approval (Deep/gated) | source changes | VERIFY |
| VERIFY | after implementation | executed validation evidence | COMPLETE |
| COMPLETE | validation passed | `implementation.md` + durable capture (gated), or a concise summary (Fast/Standard default) | — |

INVESTIGATE may **not** advance to IMPLEMENT. Only a developer, via REVIEW_APPROVAL producing
`APPROVED_FOR_IMPLEMENTATION`, opens the gate.

## Persistent artifact location

Preserve the established Project Memory root. Store the gate artifacts under:

```
~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/{active,completed}/<issue-id-or-slug>/
├── investigation.md
├── approval.md
└── implementation.md
```

An issue's folder lives under `investigations/active/` while its gate status is not yet terminal,
and moves to `investigations/completed/` (same folder, moved as a whole — never split apart) once
it reaches a terminal status: `implementation.md` exists with `Implementation status: COMPLETE`,
or the gate reached `REJECTED` or `NOT_REPRODUCIBLE`. `NEEDS_REINVESTIGATION` and
`PENDING_DEVELOPER_REVIEW` are **not** terminal — the folder stays under `active/`. This keeps
`task-resume` and `investigate-issue` (which now includes the former progressive code-investigation
procedure) from having to open every investigation folder to learn which ones are still open.

Never store project-specific investigations, approvals, or implementation results in the Shared
Brain.

## Status vocabularies

**Investigation gate** (`investigation.md`, exactly one):

- `PENDING_DEVELOPER_REVIEW` — evidence complete (even with a confirmed root cause); awaits review.
- `BLOCKED_MISSING_INFORMATION` — cannot proceed without external input.
- `INCONCLUSIVE` — evidence insufficient to reach a conclusion.
- `NOT_REPRODUCIBLE` — reported behavior could not be reproduced.

A confirmed root cause still yields `PENDING_DEVELOPER_REVIEW`, never an implicit approval.
When a review requests changes, the gate becomes `NEEDS_REINVESTIGATION`; when rejected, `REJECTED`.

**Approval decision** (`approval.md`, exactly one):

- `APPROVED_FOR_IMPLEMENTATION` — implementation may proceed within the approved scope.
- `CHANGES_REQUESTED` — investigation must be revised (gate → `NEEDS_REINVESTIGATION`).
- `REJECTED` — no implementation may proceed.
- `NEEDS_REINVESTIGATION` — source changed materially and invalidated the investigation.

## Review rules (REVIEW_APPROVAL)

Before APPROVE: read the report; confirm status is `PENDING_DEVELOPER_REVIEW`; confirm no
unresolved blocking questions; capture the current source revision and compare with the
investigated revision; detect material changes to investigated/proposed files; confirm the proposed
scope is explicit and verification requirements are defined. If material source changes invalidate
the investigation, do **not** approve — set `NEEDS_REINVESTIGATION` and explain.

The review command must **not** modify application source code.

## Reviewer identity

Never invent a reviewer. Resolve in priority order:

1. Reviewer explicitly supplied by the user.
2. Available authenticated source metadata.
3. `Developer`, if no reliable identity is available.

## Reapproval triggers

An existing approval becomes stale and requires reinvestigation/reapproval when any occurs:

- Material source changes affecting investigated behavior.
- Root cause contradicted by new evidence.
- Expansion to another module.
- Security impact discovered.
- Data migration required.
- Public API or integration contract change discovered.
- Change to acceptance criteria.
- Change to the proposed solution beyond approved constraints.
- Architecture impact discovered that was not part of the approved scope.
- Backward-compatibility impact discovered.
- Change to the verification/validation strategy from what was approved.

## Implementation preconditions (IMPLEMENT, gated path only — Deep or an explicitly gated Standard task)

Before editing source: locate `approval.md` in the issue's investigation directory; confirm its
decision is `APPROVED_FOR_IMPLEMENTATION`; confirm it references the current investigation version
and the investigated source revision; compare current source with the approved revision; check
whether investigated files/behavior changed materially; revalidate the root cause against current
source; restate approved scope and exclusions; declare IMPLEMENT mode.

Stop and refuse to implement when: `approval.md` is missing; decision is not
`APPROVED_FOR_IMPLEMENTATION`; approval references another investigation version; the report is
blocked, inconclusive, rejected, or pending review; material source changes make the approval
stale; implementation would exceed approved scope; new security/data/migration/integration/contract
risk appears; or acceptance criteria are ambiguous or changed. When no valid approval exists,
redirect to `/investigate-issue` rather than implementing.

## Shared Brain vs Project Memory boundary

- **Shared Brain (this doc and peers):** workflow policies, reusable investigation methodology,
  approval rules, risk policies, cross-project lessons. No client-specific content.
- **Project Memory:** project-specific evidence, investigation reports, approval decisions,
  implementation results, project-specific lessons.

## Verification date

Established: 2026-09-03. Amended (this redesign pass): changed the gate from mandatory-on-every-path
to risk-scoped — applies only to Deep tasks (and any Fast/Standard task that escalates or is
explicitly requested to be gated); default Fast/Standard tasks implement directly with no persisted
investigation/approval artifact. Rationale: operational evidence from real use of this framework
showed the universal gate producing tens of kilobytes of generated documentation and a mandatory
human round-trip for changes as small as a single-field visibility toggle — cost with no
corresponding governance value at that risk level. Invalidation: revisit if the operating-mode set,
artifact layout, gate statuses, or risk-path definitions change.
