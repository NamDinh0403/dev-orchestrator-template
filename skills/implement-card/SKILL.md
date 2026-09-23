---
name: implement-card
description: Plan (tiered to path), implement, and verify a change. Runs a direct IMPLEMENT → VERIFY flow with no persisted gate on Fast/Standard (the default); on Deep — or a Fast/Standard task that escalates or is explicitly asked to be gated — implements only after a valid APPROVED_FOR_IMPLEMENTATION approval, revalidating approval freshness and scope, then verifies and writes a persistent implementation.md. Includes tiered implementation planning, targeted build/test/lint validation, and diff review (folding in the former implementation-planning, targeted-validation, and diff-review skills). Refuses and redirects to /investigate-issue when a Deep/gated task has no valid approval. Invoked by the /implement-card command, or directly by the orchestrator on Fast/Standard, via the Development Orchestrator.
---

# Skill — Implement Card (plan → IMPLEMENT → VERIFY)

Implement a change, then verify and (on the gated path only) persist the result. Every planned
change must trace to an explicit requirement, acceptance criterion, confirmed defect, or necessary
technical dependency — no unrelated cleanup, no ceremonial phases that don't match a real
dependency.

Result template (gated path only): `~/.copilot/shared-brain/templates/implementation-template.md`.
Report size discipline (hard cap): `memory-evidence-policy.md` §10.

## Which mode applies

- **Direct mode (Fast/Standard, the default):** no persisted gate. Implement from the normalized
  requirement (from intake), plan proportionally, implement, verify. No `approval.md` to check, no
  `implementation.md` to write by default (see Durable capture in the orchestrator).
- **Gated mode (Deep, or a Fast/Standard task that escalated or was explicitly asked to be
  investigated first):** implementation is gated — no source is edited without a valid approval.
  Policy: `~/.copilot/shared-brain/workflows/investigation-approval-gate.md`.

## Gated-mode inputs and preconditions

### Approved-investigation path (preferred)

Input is `.../investigations/active/<issue-id-or-slug>/investigation.md` (or the issue id/slug).

### Raw-card path with no prior investigation, on a task that should be gated

Input is a card/issue with no approved investigation, but the task is Deep or was explicitly asked
to be gated. **Do not implement.** Explain that the gate requires a persisted, approved
investigation, and redirect: `/investigate-issue <card>`. No approval can exist yet, so
implementation is refused.

### Implementation preconditions (before editing any source, gated mode only)

1. Locate `approval.md` in the same investigation directory.
2. Confirm its decision is `APPROVED_FOR_IMPLEMENTATION`.
3. Confirm the approval references the current investigation version.
4. Confirm the approval references the expected investigated revision.
5. Compare current source with the approved source revision.
6. Check whether investigated files or relevant behavior changed materially.
7. Revalidate the root cause against current source.
8. Restate approved scope and exclusions.
9. Declare **IMPLEMENT** mode.

### Stop conditions (refuse to implement, gated mode only)

Stop when: `approval.md` is missing; decision is not `APPROVED_FOR_IMPLEMENTATION`; approval
references another investigation version; the report is blocked, inconclusive, rejected, or pending
review; material source changes make the approval stale; implementation would exceed approved scope;
new security/data/migration/integration/contract risk appears; or acceptance criteria are ambiguous
or changed. On any stop, preserve state, explain the exact blocker, and recommend the corrective
command (`/investigate-issue` or `/review-investigation`). Never expand beyond approved scope.

**Mid-task risk discovery on the direct path is the same signal, differently handled:** if,
while implementing Fast/Standard, a hard-exclusion or Deep trigger appears, stop editing
immediately, do not treat the in-progress change as approved, and switch to gated mode (write
`investigation.md` for what's been found, then require `/review-investigation`).

## Planning (tiered to path — do before editing application code on Standard/Deep)

Depth adapts to the execution path; skip straight to Implementation on a genuinely trivial Fast
change where the plan is obvious from the requirement itself.

- **Fast plan** — internal checklist only, not persisted unless the task is interrupted: target;
  change; targeted validation.
- **Standard plan** — concise checklist, per step: affected file/component; reason
  (requirement/evidence); intended change; validation; relevant risk.
- **Deep plan** — executable: requirement IDs; evidence; affected components; dependencies; atomic
  implementation phases; completion criteria; validation per phase; rollout; rollback;
  compatibility; migration considerations; unresolved external dependencies; implementation handoff
  information. Produce it via **Plan mode** so it persists under `~/.copilot/plans/`.

**Impact analysis (Standard/Deep):** evaluate backend, frontend, database, configuration,
authentication, authorization, integrations, deployment, migration, compatibility, tests,
documentation. Classify each as **confirmed / possible / no detected impact**; every confirmed
impact must cite evidence.

Do not stop after planning unless plan-only mode was requested, implementation is blocked, a
destructive change needs confirmation, or an irreversible/ambiguous product/security/compatibility
decision must be resolved first.

## Implementation

Implement only the planned/approved change, honoring approval conditions and explicit exclusions
where the gated path applies.

## VERIFY mode

Declare **VERIFY**. Detect the repository's real build/test/lint commands from its manifests before
running anything — never guess.

**Minimum by path:**
- **Fast:** narrowest targeted test, or a targeted build/compile, plus a diff glance.
- **Standard:** targeted tests + build + lint/type checking + diff review (see below).
- **Deep / gated:** per-phase validation + relevant integration tests + diff review +
  `security-review` when flagged + an explicit manual-verification list.

**Preferred order:** targeted tests (narrowest that cover the change) → targeted build →
compilation → type checking → lint → relevant integration tests → broader validation when risk
justifies it → diff review (final).

Route verbose build/test/lint runs to the **`task`** subagent (returns a success summary or full
failure output) to keep context clean. Record: exact command, result, concise output summary,
failures, whether a failure is **pre-existing** (with evidence), and validation gaps with reasons.
Never claim validation succeeded unless the command executed successfully; never silently skip or
ignore a failed validation — it blocks any completion claim. Keep tests deterministic; note flaky
tests as flaky rather than pre-existing.

**Diff review** (Standard/Deep; a Fast change gets a diff glance instead): produce the diff
(staged/unstaged/branch); invoke the built-in **`code-review`** capability on it; additionally
verify the change traces to a requirement/plan step, has no unrelated edits, guards
external/persistence/integration boundaries, updates tests where behavior changed, preserves
backward compatibility unless explicitly changed, and leaves no secrets/debug output. For
security/authorization-flagged changes, also require the **`security-review`** subagent. Unresolved
high-confidence issues block completion.

## Persist result

**Gated mode only:** write `.../investigations/active/<issue-id-or-slug>/implementation.md` from
the template: precondition check, approved scope implemented, requirement-to-change mapping,
changes (files/symbols), verification evidence, manual verification, scope/risk notes, and outcome.
**Hard size cap:** if this report is approaching ~15KB, stop narrating — summarize remaining detail
as a bullet list and reference the diff itself rather than describing every change in prose
(`memory-evidence-policy.md` §10). When `Implementation status: COMPLETE`, move the whole
investigation folder (all three files) from `investigations/active/` to `investigations/completed/`
— `BLOCKED`/`PARTIAL` stay under `active/`. Then perform path-sized durable capture per the
orchestrator's Durable-capture rules.

**Direct mode (Fast/Standard default):** no `implementation.md` is written. Report the change in
the chat response per the orchestrator's Final response format; persist a task record only if the
task is interrupted or a genuinely reusable finding/decision surfaced (see Durable capture).
