---
name: requirement-grilling
description: Resolve only material unknowns before implementation using an evidence-first decision tree. Use on Deep path or when behavior, scope, data integrity, authorization, compatibility, integration contracts, or an irreversible choice is genuinely ambiguous. Do not use for clear or simple tasks.
---

# Skill — Requirement Grilling

Optional, evidence-first resolution of material unknowns. Not a mandatory phase and not an
interview. Invoked only when unresolved decisions affect observable behavior, scope, data
integrity, authorization, compatibility, integration contracts, or an irreversible choice.

## Non-triggers
Clear requirements; simple/localized tasks; anything source inspection can answer. Do not turn a
simple task into an interview.

## Procedure
1. **Investigate first.** Answer everything you can from source code, tests, configuration, and
   documentation before asking anything.
2. **Build a decision tree** of the remaining unknowns and their dependencies.
3. **Ask one material question at a time.** For each, provide an evidence-based recommended answer
   and explain the consequence of each important option.
4. **Record** resolved, deferred, and out-of-scope branches.
5. **Stop** as soon as the design is implementable — do not seek exhaustive certainty.

## Output
A concise **requirement decision record** feeding `implementation-planning`: resolved decisions
(with rationale + evidence), deferred items, and explicit out-of-scope branches.

## Memory
- Reads: current source, tests, config, project knowledge.
- Writes: requirement decision record in the task file (and a `DEC-*` via `decision-capture` if
  the choice is a durable engineering decision).

## Failure behavior
If a material question cannot be answered by investigation and the developer is unavailable,
record it as an open question/blocker; do not guess on irreversible or high-risk choices.
