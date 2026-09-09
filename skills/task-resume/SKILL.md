---
name: task-resume
description: Resume an interrupted task from the correct phase — resolve project identity, load only the current project's active task, reconcile it against the current branch/HEAD/working tree, invalidate stale evidence, and continue without repeating valid work. Use when the developer resumes a task or an active task record exists.
---

# Skill — Task Resume

Continue an interrupted task safely from the correct phase.

## Trigger
A resume request, or an active task record exists for the current project. **Non-trigger:** a new
task (use `task-intake`). **Never** resume a similarly named task from another project.

## Procedure
1. Resolve the current project identity (project key, registry, sanitized remote, local root).
2. Load only the current project's active task file for the given task ID. If absent, check
   `completed/` and `abandoned/`; do not fabricate a record.
3. Check the current branch, Git HEAD, working-tree status, and diff.
4. Compare repository state with the saved task state; classify each plan step as **completed,
   pending, stale, or invalidated**.
5. Preserve previous decisions; mark invalidated ones (do not delete). Re-validate evidence for
   files that changed since it was recorded — changed source invalidates old investigation
   evidence. Revalidation triggers and freshness statuses:
   `~/.copilot/shared-brain/workflows/memory-evidence-policy.md` §7.
6. Continue from the correct phase without repeating valid completed work; re-run validation
   affected by source changes; keep the task active until completion requirements are met.

## Output
An updated, reconciled active task record and a continuation from the correct phase.

## Memory
- Reads: project `tasks/active/<TASK-ID>.md`, Git state.
- Writes: reconciled task record (state, invalidated evidence/decisions marked).
