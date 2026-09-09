---
name: implement-card
description: IMPLEMENT and VERIFY procedure for the investigation approval gate. Implements a card only after a valid APPROVED_FOR_IMPLEMENTATION approval, revalidating approval freshness and scope, then verifies and writes a persistent implementation.md. Refuses and redirects to /investigate-issue when no valid approval exists. Invoked by the /implement-card command via the Development Orchestrator.
---

# Skill — Implement Card (IMPLEMENT → VERIFY mode)

Implement an approved change within its approved scope, then verify and persist the result.
Implementation is **gated**: no source is edited without a valid approval. Policy:
`~/.copilot/shared-brain/workflows/investigation-approval-gate.md`.
Result template: `~/.copilot/shared-brain/templates/implementation-template.md`.

## Inputs — two paths

### Approved-investigation path (preferred)

Input is `.../investigations/<issue-id-or-slug>/investigation.md` (or the issue id/slug).

### Raw-card path (no prior investigation)

Input is a card/issue with no approved investigation. **Do not implement.** Explain that the gate
requires a persisted, approved investigation, and redirect: `/investigate-issue <card>`. No approval
can exist yet, so implementation is refused.

## Implementation preconditions (before editing any source)

1. Locate `approval.md` in the same investigation directory.
2. Confirm its decision is `APPROVED_FOR_IMPLEMENTATION`.
3. Confirm the approval references the current investigation version.
4. Confirm the approval references the expected investigated revision.
5. Compare current source with the approved source revision.
6. Check whether investigated files or relevant behavior changed materially.
7. Revalidate the root cause against current source.
8. Restate approved scope and exclusions.
9. Declare **IMPLEMENT** mode.

## Stop conditions (refuse to implement)

Stop when: `approval.md` is missing; decision is not `APPROVED_FOR_IMPLEMENTATION`; approval
references another investigation version; the report is blocked, inconclusive, rejected, or pending
review; material source changes make the approval stale; implementation would exceed approved scope;
new security/data/migration/integration/contract risk appears; or acceptance criteria are ambiguous
or changed. On any stop, preserve state, explain the exact blocker, and recommend the corrective
command (`/investigate-issue` or `/review-investigation`). Never expand beyond approved scope.

## Implementation

Implement only the approved change, honoring approval conditions and explicit exclusions. Route the
build/plan work through existing skills (`implementation-planning`, `targeted-validation`) and
built-ins as usual.

## VERIFY mode

Declare **VERIFY**. Run the approval's required tests plus targeted build/lint/type checks; run
`diff-review`; run `security-review` when a security/authorization flag applies. Record only
executed commands and their results. Do not claim success without executed validation.

## Persist result

Write `.../investigations/<issue-id-or-slug>/implementation.md` from the template: precondition
check, approved scope implemented, changes (files/symbols), verification evidence, manual
verification, scope/risk notes, and outcome. Then perform path-sized durable capture per the
orchestrator's Durable-capture rules.
