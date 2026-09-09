---
name: code-investigation
description: Progressive, index-first code investigation that avoids scanning the whole repository. Use to locate root cause or the implementation gap for Standard and Deep path tasks; fan out independent research threads to the built-in explore subagent.
---

# Skill — Code Investigation

Progressive investigation. **Do not scan the whole repository by default.** Fast tasks inline a
light version; Standard/Deep invoke this skill fully.

## Order
1. Parse the request; extract keywords and symbols.
2. Resolve the current project; load its `memory-index.md`.
3. Search relevant current-project knowledge, then relevant Shared Brain entries (index-first).
4. Inspect repository manifests (package/build/solution files) to confirm stack and commands.
5. Locate direct implementation entry points.
6. Search exact symbols; read only directly relevant files.
7. Trace callers, dependencies, and data flow as needed.
8. Inspect relevant tests and configuration.
9. Expand only when evidence indicates broader impact.

## Built-in reuse
For several **independent** research threads that each need substantial separate context, fan out
to the **`explore`** subagent (one thread per agent). For a single continuous chain, investigate
directly. Do not duplicate an explore agent's work afterward.

## Record (in the task file)
Search strategy, keywords, files/symbols inspected, execution flow, configuration, data flow,
authorization flow, integration boundaries, relevant tests, root cause or technical gap, and
areas confirmed unaffected.

## Rules
- Do not modify production code during investigation.
- Do not repeatedly read unchanged files.
- Prefer concise evidence summaries over large raw output.
- Distinguish evidence from assumptions; never present an assumption as evidence.
- Current source overrides stored memory on conflict — record the conflict. Full retrieval
  budget and validation checklist: `~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.
