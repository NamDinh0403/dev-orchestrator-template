# Decision Record Template

> This is an **engineering decision record, not a hidden chain-of-thought log.** Capture the
> reviewable rationale a future engineer needs — not internal deliberation.

---

- **ID:** DEC-YYYYMMDD-### (project-specific) or SB-DEC-### (shared principle)
- **Title:** <short decision title>
- **Status:** proposed | accepted | invalidated | superseded | rejected
- **Date:** YYYY-MM-DD
- **Source task:** <TASK-ID>
- **Scope (optional):** <repositories / components this decision applies to>

## Context
<Situation and forces requiring a decision.>

## Evidence
<Concrete source/test/config references.>

## Options considered
1. <Option A>
2. <Option B>

## Selected option
<Chosen option.>

## Rejected options
- <Option> — <why rejected>

## Engineering rationale
<Why the selected option is appropriate, grounded in evidence.>

## Trade-offs
<What is gained and given up.>

## Consequences
<Effects on the system, follow-up work, constraints.>

## Validation
<How validated (commands, results) or why it could not be.>

## Confidence
high | medium | low

## Invalidation conditions
<What future change or evidence would make this decision no longer valid.>

## Supersedes
<Decision ID this one replaces, or n/a.>

## Superseded-by
<Decision ID that replaces this, or n/a. Never delete history.>
