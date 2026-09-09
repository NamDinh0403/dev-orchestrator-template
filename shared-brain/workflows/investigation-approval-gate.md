# Workflow Policy — Investigation Approval Gate

Reusable, cross-project policy for the Development Orchestrator
(`~/.copilot/agents/development-orchestrator.agent.md`). This file holds **methodology and rules
only** — no project-specific evidence. Per-issue investigation reports, approvals, and
implementation results live in **Project Memory**, never here.

## Purpose

Enforce a mandatory, persistent gate between investigation and implementation. Investigation must
**never** automatically transition into implementation. This applies on **every** execution path
(Fast, Standard, Deep). Fast still sizes effort and may inline light investigation, but it never
skips the gate.

Required flow:

```
issue / card
  → INVESTIGATE          (persistent investigation report)
  → REVIEW_APPROVAL      (persistent approval decision)
  → IMPLEMENT
  → VERIFY
  → COMPLETE             (persistent implementation result)
```

## Operating modes

The orchestrator must **declare the active mode** before doing mode-specific work.

| Mode | Entry | Produces | May advance to |
| ---- | ----- | -------- | -------------- |
| INTAKE | task received | normalized requirement set + project identity | INVESTIGATE |
| INVESTIGATE | `/investigate-issue` | `investigation.md` (read-only evidence) | REVIEW_APPROVAL (developer-driven) |
| REVIEW_APPROVAL | `/review-investigation` | `approval.md` | IMPLEMENT (only if APPROVED_FOR_IMPLEMENTATION) |
| IMPLEMENT | `/implement-card` with valid approval | source changes | VERIFY |
| VERIFY | after implementation | executed validation evidence | COMPLETE |
| COMPLETE | validation passed | `implementation.md` + durable capture | — |

INVESTIGATE may **not** advance to IMPLEMENT. Only a developer, via REVIEW_APPROVAL producing
`APPROVED_FOR_IMPLEMENTATION`, opens the gate.

## Persistent artifact location

Preserve the established Project Memory root. Store the gate artifacts under:

```
~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/
├── investigation.md
├── approval.md
└── implementation.md
```

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

## Implementation preconditions (IMPLEMENT)

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

Established: 2026-09-03. Invalidation: revisit if the operating-mode set, artifact layout, or gate
statuses change.
