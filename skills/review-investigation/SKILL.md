---
name: review-investigation
description: REVIEW_APPROVAL-mode procedure for the investigation approval gate. Records a developer's APPROVE / REQUEST_CHANGES / REJECT decision on an investigation.md, validating staleness against current source, and writes a persistent approval.md. Never modifies application source code. Invoked by the /review-investigation command via the Development Orchestrator.
---

# Skill — Review Investigation (REVIEW_APPROVAL mode)

Record a developer's decision on a persistent investigation and gate implementation. **Never**
modifies application source code. Policy:
`~/.copilot/shared-brain/workflows/investigation-approval-gate.md`.
Approval template: `~/.copilot/shared-brain/templates/approval-template.md`.

## Mode

Declare **REVIEW_APPROVAL** before doing mode-specific work.

## Inputs

- Path to `investigation.md` (required).
- Developer decision: `APPROVE | REQUEST_CHANGES | REJECT` (required).
- Optional review comments, scope restrictions, approval conditions.

## Reviewer identity

Never invent one. Resolve: (1) reviewer explicitly supplied by the user; (2) available
authenticated source metadata; (3) `Developer`.

## APPROVE procedure

1. Read the investigation report.
2. Confirm status is `PENDING_DEVELOPER_REVIEW`.
3. Confirm there are no unresolved blocking questions.
4. Capture the current source revision.
5. Compare it with the investigated source revision.
6. Detect material changes to investigated or proposed files.
7. Validate the proposed implementation scope is explicit.
8. Validate verification requirements are defined.

If material source changes invalidate the investigation, **do not approve** — set the decision to
`NEEDS_REINVESTIGATION`, explain why, and recommend `/investigate-issue <path>`.

Otherwise create or replace `approval.md` (approve section of the template) with: metadata
(including investigated + approved source revisions and approval version), approved scope
(including an explicit restatement of the approved root cause — not just a version reference),
approval conditions, reapproval triggers, and `Decision: APPROVED_FOR_IMPLEMENTATION`.

## REQUEST_CHANGES procedure

Create or update `approval.md` with `Decision: CHANGES_REQUESTED`, review comments, required
investigation updates, review timestamp, and reviewer. Update the investigation gate to
`NEEDS_REINVESTIGATION`. Do **not** rewrite investigation findings as if already re-investigated.
Recommend `/investigate-issue <investigation-report-path>`.

## REJECT procedure

Create or update `approval.md` with `Decision: REJECTED`, rejection reason, review timestamp, and
reviewer. Update the investigation gate to `REJECTED`. No implementation may proceed. `REJECTED` is
a terminal gate status — move the whole investigation folder from `investigations/active/` to
`investigations/completed/` (never split `investigation.md`/`approval.md` apart).

## Artifact location

`~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/active/<issue-id-or-slug>/approval.md`
(same directory as the investigation, while the gate is non-terminal — `APPROVE` and
`REQUEST_CHANGES` both leave the folder under `active/`, since neither
`APPROVED_FOR_IMPLEMENTATION` nor `NEEDS_REINVESTIGATION` is a terminal status). Only `REJECT`
moves the folder to `investigations/completed/` at this stage.

## Rules

- Never modify application source code, configuration, or tests.
- The reviewer decision is authoritative input; do not approve on the developer's behalf.
- Current source overrides the report on conflict — a stale investigation cannot be approved.
