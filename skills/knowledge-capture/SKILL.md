---
name: knowledge-capture
description: At task completion, classify each finding and route it to the correct layer — task-only, Project Memory, Shared Brain candidate, decision record, or stale-knowledge correction. Promote to the Shared Brain only when strict criteria are met. Use during durable capture.
---

# Skill — Knowledge Capture

Outcome-driven, not mandatory documentation generation. Classify every finding, then store it in
the correct layer.

## Classification
- **No durable value** → discard.
- **Task-only context** → keep in the task record only.
- **Workflow-performance observation** (rework, rejected assumption, blocked investigation, missing
  scaffold, validation gap) → that project's own `improvement-backlog.md`. Escalate to
  `shared-brain/improvement-backlog/backlog.md` only if the same problem recurs across more than
  one project.
- **Project Memory knowledge** → `project-memory/projects/<KEY>/knowledge/` (ARC/PAT/PIT/CST/TRB).
  Create the specific category file **lazily**, only when there is a real entry to write — do not
  pre-create empty knowledge files.
- **Shared Brain candidate** → `shared-brain/engineering/` (SB-PAT/SB-PIT/SB-CST/SB-TRB/SB-DEC).
- **Decision** → `decision-capture` skill.
- **Stale knowledge correction** → mark the old entry `stale` or `invalidated`; add the correction.

## Hypotheses are never durable knowledge

A hypothesis, an unconfirmed assumption, or an investigation's `Probable`/`Inconclusive` root cause
must **never** be written into `knowledge/` or the Shared Brain, and must never be cited as an
established fact by a later task — it must be re-verified from scratch every time it would be
relied upon. It stays only inside the originating `investigation.md`. See
`shared-brain/workflows/memory-evidence-policy.md` §4.

## Promote to Shared Brain only when ALL hold
1. Not client-specific.
2. Applicable to more than one project, or a general technology rule.
3. Supported by direct source evidence or executable validation.
4. Sensitive information removed (sanitize paths, names, secrets — remove client identifiers).
5. Explicit scope recorded, with `applies_when` / `does_not_apply_when` conditions.
6. Invalidation conditions recorded.
7. Status is `verified` (never promote a `candidate` or a hypothesis — see above).

If verification is insufficient, keep it in Project Memory. Consider a **candidate-review** state
(propose for developer review) before promoting anything sensitive or lower-confidence. Avoid
Shared Brain updates for ordinary implementation details.

## Never promote
Assumptions, raw card content, secrets, customer data, temporary debugging output, one-off task
details, unverified architecture, large source-code blocks, hidden reasoning.

## Retain detailed investigation logs only when
The task is blocked/unresolved, needs handoff, involves a production incident, is high-risk domain
logic, took a wrong path worth preserving, or requires rollback evidence. Otherwise keep the
completed record minimal.

## Discipline
Append/update surgically; search the relevant index first to avoid duplicates; update
`shared-brain/index.md` or the project `memory-index.md`; current source and executed validation
override stored knowledge on conflict. Retrieval budget, validation checklist, and status
vocabulary: `shared-brain/workflows/memory-evidence-policy.md`.
