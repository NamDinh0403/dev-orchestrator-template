---
name: decision-capture
description: Record a meaningful engineering decision as a traceable record — inline in the task for Standard, or a standalone DEC-YYYYMMDD-### file for Deep. Use only for real decisions, not routine implementation detail or hidden chain-of-thought.
---

# Skill — Decision Capture

Preserve engineering traceability without storing hidden reasoning. Create a decision record only
for **meaningful** decisions.

## When a decision qualifies
Choice between valid implementations; compatibility behavior; scope interpretation; a shortcut
rejected due to evidence; an architecture or integration choice; an accepted limitation; a
migration or rollback strategy.

**Not** a decision record: routine implementation detail, obvious mechanics, or reasoning logs.

## Where it lives
- **Standard:** inline in the task record ("Decisions" section), one line + rationale.
- **Deep:** standalone `~/.copilot/project-memory/projects/<KEY>/decisions/active/DEC-YYYYMMDD-###.md`
  using `shared-brain/templates/decision-template.md`, referenced from the task and
  `index/decision-index.md`. Create the `decisions/active/` folder the first time this project has
  a real standalone decision to record — do not rely on it being pre-scaffolded empty.

## Contents (per `decision-template.md`)
Context; evidence; options considered; selected option; rejected options; concise rationale;
trade-offs; consequences; validation; confidence; invalidation conditions; source task;
optional scope (repositories/components); supersession status (`proposed | accepted | invalidated
| superseded | rejected`).

## Discipline
Do not overwrite history — mark obsolete decisions as **superseded** (replaced by a new decision)
or **invalidated** (no longer valid, not yet replaced), with a link to the replacement where one
exists. When a decision becomes `superseded` or `rejected`, move its file from `decisions/active/`
to `decisions/superseded/` and update its row in `index/decision-index.md` — never delete the file
or the row. This is an engineering decision record, not a chain-of-thought log.
