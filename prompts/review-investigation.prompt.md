---
name: review-investigation
description: Record a developer's APPROVE, REQUEST_CHANGES, or REJECT decision on an investigation report and write a persistent approval decision. Never modifies application source code.
argument-hint: <path-to-investigation.md> <APPROVE|REQUEST_CHANGES|REJECT> [comments] [scope-restrictions] [conditions]
agent: development-orchestrator
---

# /review-investigation

Run the **REVIEW_APPROVAL** mode of the investigation approval gate.

Declare REVIEW_APPROVAL mode, then follow the `review-investigation` skill
(`~/.copilot/skills/review-investigation/SKILL.md`) and the policy
(`~/.copilot/shared-brain/workflows/investigation-approval-gate.md`).

Inputs from `$ARGUMENTS`:

- Path to `investigation.md` (required).
- Developer decision: `APPROVE`, `REQUEST_CHANGES`, or `REJECT` (required).
- Optional: review comments, scope restrictions, approval conditions.

Rules:

- Never modify application source code, configuration, or tests.
- Resolve the reviewer identity without inventing one: explicit user value → authenticated source
  metadata → `Developer`.
- **APPROVE**: only when the report is `PENDING_DEVELOPER_REVIEW`, has no unresolved blocking
  questions, and current source has not materially changed since the investigated revision. If it
  has, set `NEEDS_REINVESTIGATION` instead and explain. Otherwise write `approval.md` with
  `Decision: APPROVED_FOR_IMPLEMENTATION`.
- **REQUEST_CHANGES**: write `approval.md` with `Decision: CHANGES_REQUESTED`; set the investigation
  gate to `NEEDS_REINVESTIGATION`; recommend `/investigate-issue <path>`.
- **REJECT**: write `approval.md` with `Decision: REJECTED`; set the investigation gate to
  `REJECTED`.

Write the decision to
`~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/approval.md`
using `~/.copilot/shared-brain/templates/approval-template.md`.
