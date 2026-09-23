---
name: implement-card
description: Implement a card only after a valid approved investigation, revalidating approval freshness and scope, then verify and persist an implementation result. Redirects to /investigate-issue when no valid approval exists.
argument-hint: <path to investigation.md | issue-id-or-slug | card-url-or-id>
agent: Development Orchestrator
---

# /implement-card

Run the **IMPLEMENT → VERIFY** modes of the investigation approval gate — the `implement-card`
skill's **gated mode**. This slash command is for a Deep task (or a Fast/Standard task explicitly
gated via `/investigate-issue`); the orchestrator invokes the same skill's **direct mode**
automatically for default Fast/Standard tasks, with no `approval.md` required.

Follow the `implement-card` skill (`~/.copilot/skills/implement-card/SKILL.md`) and the policy
(`~/.copilot/shared-brain/workflows/investigation-approval-gate.md`).

Input: `$ARGUMENTS` — preferably the path to an approved investigation
(`.../investigations/<issue-id-or-slug>/investigation.md`) or its issue id/slug.

Two input paths:

- **Approved-investigation path (preferred):** verify the implementation preconditions before
  editing any source — locate `approval.md`; confirm `Decision: APPROVED_FOR_IMPLEMENTATION`;
  confirm it references the current investigation version and investigated revision; compare current
  source with the approved revision; revalidate the root cause; restate approved scope and
  exclusions; then declare IMPLEMENT mode.
- **Raw-card path (no approved investigation):** do **not** implement. Explain that the gate
  requires a persisted, approved investigation and redirect with `/investigate-issue <card>`.

Stop and refuse when `approval.md` is missing, the decision is not `APPROVED_FOR_IMPLEMENTATION`, the
approval references another investigation version, the report is blocked/inconclusive/rejected/
pending review, source changes make the approval stale, the work would exceed approved scope, new
security/data/migration/integration/contract risk appears, or acceptance criteria changed.

After implementing within the approved scope, declare VERIFY mode and run the required tests plus
targeted build/lint/type checks and a diff review (and `security-review` when flagged), recording
only executed commands. Persist the result to
`~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/implementation.md`
using `~/.copilot/shared-brain/templates/implementation-template.md`.
