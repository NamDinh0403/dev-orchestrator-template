---
name: diff-review
description: Structured review of the change diff before completion, wrapping the built-in code-review capability. Use on Standard and Deep tasks after implementation and before claiming done.
---

# Skill — Diff Review

Final structured review of the change set. Wraps the built-in **`code-review`** capability rather
than re-implementing review prose.

## Trigger
After implementation on Standard/Deep, before the completion gate. **Non-trigger:** trivial Fast
changes (a diff glance suffices).

## Procedure
1. Produce the diff (staged/unstaged/branch).
2. Invoke the built-in **`code-review`** capability on the diff.
3. Additionally verify: change traces to a requirement/plan step; no unrelated edits; guards at
   external/persistence/integration boundaries; tests updated where behavior changed; backward
   compatibility preserved unless explicitly changed; no secrets or debug output left in.
4. For security/authorization-flagged changes, also require the **`security-review`** subagent.

## Output
Review notes (findings + resolutions) appended to the task record. Unresolved high-confidence
issues block completion.

## Memory
- Reads: the diff, plan, task record.
- Writes: review notes in the task record.
