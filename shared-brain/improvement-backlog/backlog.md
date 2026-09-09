# Improvement Backlog

Safe, reviewable improvement loop for the Development Orchestrator system. The agent may **append
observations** here; it must **not** rewrite its own core rules automatically. Proposed agent
changes require developer approval before they are applied.

## Layers (keep separate)
- **Operational knowledge** → Shared Brain / Project Memory (not here).
- **Workflow-performance observations** → this file, `## Observations`.
- **Proposed agent improvements** → this file, `## Proposals` (status `proposed`).
- **Approved agent changes** → this file, `## Proposals` (status `approved`) → then implemented.

## Entry schema (Proposals)
Each proposal records: observed problem; task evidence (task IDs); frequency; impact; proposed
adjustment; expected benefit; regression risk; approval status
(`proposed | approved | rejected | implemented`); validation after change.

## Metrics (definitions — do NOT invent historical values)
Track over time from real task records only:
- tasks completed without rework;
- incorrect assumptions per task;
- repeated investigations avoided (memory reuse hits);
- stale-memory rejections;
- validation failures caught before completion;
- average workflow path (Fast/Standard/Deep distribution);
- unnecessary Deep-Path selections (downgraded on evidence);
- unresolved task resumptions;
- knowledge entries reused successfully;
- knowledge entries rejected as stale;
- developer corrections per task.

## Observations
<!-- Append dated, evidence-linked observations. No hidden chain-of-thought. -->
| Date | Observation | Task evidence | Signal |
| ---- | ----------- | ------------- | ------ |
| _none_ | | | |

## Proposals
<!-- Append proposals; leave status=proposed until a developer approves. -->
| ID | Observed problem | Evidence | Frequency | Impact | Proposed adjustment | Expected benefit | Regression risk | Status | Validation |
| -- | ---------------- | -------- | --------- | ------ | ------------------- | ---------------- | --------------- | ------ | ---------- |
| _none_ | | | | | | | | | |
