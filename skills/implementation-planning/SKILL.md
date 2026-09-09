---
name: implementation-planning
description: Produce a plan sized to the task's execution path — a short internal checklist for Fast, a concise implementation checklist for Standard, and an executable phased plan for Deep. Includes impact analysis. Use before editing application code on Standard and Deep tasks.
---

# Skill — Implementation Planning (tiered)

Planning depth adapts to the execution path. Every planned change must trace to an explicit
requirement, acceptance criterion, confirmed defect, or necessary technical dependency. No
unrelated cleanup. Avoid ceremonial phases (Foundation/Core/Polish) unless they match real
technical dependencies — every phase must exist for a verified reason.

## Impact analysis (Standard/Deep)
Evaluate backend, frontend, database, configuration, authentication, authorization, integrations,
deployment, migration, compatibility, tests, documentation. Classify each as **confirmed /
possible / no detected impact**; every confirmed impact must cite evidence.

## Plan formats

### Fast plan (internal checklist — not persisted unless interrupted)
- target;
- change;
- targeted validation.

### Standard plan (concise checklist)
Per step: affected file/component; reason (requirement/evidence); intended change; validation;
relevant risk.

### Deep plan (executable)
Requirement IDs; evidence; affected components; dependencies; atomic implementation phases;
completion criteria; validation per phase; rollout; rollback; compatibility; migration
considerations; unresolved external dependencies; implementation handoff information.

## Built-in reuse
For Deep plans, produce the plan via **Plan mode** so it persists under `~/.copilot/plans/`.

## Output
The path-appropriate plan written into the task record (Fast: internal only; Standard: task
checklist; Deep: task plan + persisted plan file).

## Discipline
Do not stop after planning unless plan-only mode was requested, implementation is blocked, a
destructive change needs confirmation, or an irreversible/ambiguous product/security/compatibility
decision must be resolved first.
