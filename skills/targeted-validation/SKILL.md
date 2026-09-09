---
name: targeted-validation
description: Detect the repository's real build/test/lint commands and run the narrowest checks that cover the change, in the correct order, classifying pre-existing and flaky failures. Use on every path, scaled to risk; route verbose command runs to the built-in task subagent.
---

# Skill — Targeted Validation

Detect the real repository commands from its manifests before running anything. Scale to the
execution path.

## Minimum by path
- **Fast:** narrowest targeted test, or a targeted build/compile, plus a diff glance.
- **Standard:** targeted tests + build + lint/type checking + diff review.
- **Deep:** per-phase validation + relevant integration tests + diff review + `security-review`
  when flagged + an explicit manual-verification list.

## Preferred order
1. Targeted tests (narrowest that cover the change).
2. Targeted build.
3. Compilation.
4. Type checking.
5. Lint.
6. Relevant integration tests.
7. Broader validation when risk justifies it.
8. Final diff review (via `diff-review`).

## Built-in reuse
Route verbose build/test/lint runs to the **`task`** subagent (returns success summary or full
failure output) to keep orchestrator context clean.

## Record (in the task file)
Exact command, execution time when useful, result, concise output summary, failures, whether a
failure is **pre-existing** (with evidence), and validation gaps with reasons.

## Discipline
- Never claim validation succeeded unless the command executed successfully.
- Never silently skip or ignore failed validation — failed validation blocks any completion claim.
- Record pre-existing failures as pre-existing; do not attribute them to the current change.
- Keep tests deterministic; avoid time/order/network-dependent flakiness; note flaky tests.
- When an environment is unavailable, record it and provide a manual-verification list instead of
  claiming success.
