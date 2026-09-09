# Workflow Policy — Memory & Evidence

Canonical, single-source rules for how the Development Orchestrator
(`~/.copilot/agents/development-orchestrator.agent.md`) retrieves, validates, records, and ages
out knowledge from **Project Memory** and the **Shared Brain**. This file holds methodology only —
no project-specific evidence. Other files (the orchestrator, skills, templates) **reference** this
policy rather than restating it; if you find the same rule duplicated elsewhere, that is drift —
fix it by pointing back here.

## 1. Memory is advisory evidence, not authoritative truth

A stored finding, pattern, pitfall, or decision describes what was true when it was verified. It is
input to reasoning, never a substitute for checking the current repository. Current source code,
runtime evidence, current configuration, recent migrations, executed tests, and approved
requirements always take precedence over stored memory (see the hierarchy below).

## 2. Evidence precedence (highest wins)

1. Approved current requirement / explicit human instruction
2. Current runtime evidence and reproducible test results
3. Current source code and configuration
4. Current architecture and version-specific documentation
5. Verified Project Memory (this repository)
6. Verified Shared Brain (cross-project)
7. Historical task records
8. Hypotheses and assumptions

When higher-priority evidence conflicts with memory, the higher-priority evidence wins and the
conflicting memory entry must be reviewed for invalidation (§6) — never silently ignored. **Project
Memory outranks the Shared Brain**: general cross-project guidance never overrides verified,
project-specific evidence.

## 3. Layered architecture

1. **Session Working Memory** — the current task's in-context state (plan, findings so far,
   partial diffs). Ephemeral, never durable, never citable as a source in a later task.
2. **Local Project Memory** — this repository's isolated findings, task state, decisions, and
   investigation artifacts (`~/.copilot/project-memory/projects/<PROJECT-KEY>/`).
3. **Team Project Knowledge** *(optional)* — reviewed, project-specific knowledge shared across a
   team, only where the repository/org already provides a secure, private, team-shared location
   (e.g. a wiki or an internal shared repo). Do **not** create an unused placeholder folder for
   this layer when no such location exists — document it as an available integration, not a
   mandatory scaffold.
4. **Shared Brain** — sanitized, generalized, cross-project knowledge only
   (`~/.copilot/shared-brain/`).

## 4. Knowledge types

| Type | Meaning | Durable? |
| --- | --- | --- |
| Fact / architecture | Directly supported by current evidence about this repository | Yes — `ARC-###` |
| Pattern | A verified, reusable implementation approach | Yes — `PAT-###` / `SB-PAT-###` |
| Pitfall | A verified failure pattern + trigger conditions | Yes — `PIT-###` / `SB-PIT-###` |
| Constraint | A verified technical/business/security/operational limitation | Yes — `CST-###` / `SB-CST-###` |
| Procedure / troubleshooting | A verified, reusable diagnostic or resolution procedure | Yes — `TRB-###` / `SB-TRB-###` |
| Decision | An approved choice with context, alternatives, and consequences | Yes — `DEC-YYYYMMDD-###` / `SB-DEC-###` |
| Hypothesis | A possible explanation that has not been confirmed | **Never durable** |

**Hypothesis rule:** a hypothesis, an investigation `Assumption`, or a `Probable`/`Inconclusive`
root cause must never be written into `knowledge/` (ARC/PAT/PIT/CST/TRB) or the Shared Brain, and
must never be cited as an established fact in a later task. It lives only inside the originating
`investigation.md`, is re-evaluated from scratch whenever a later task would rely on it, and may
only become durable knowledge once confirmed by evidence (source, runtime, or test) — see
`shared-brain/templates/knowledge-template.md` for the full schema.

## 5. Storage granularity (bounded, purpose-specific files)

Durable knowledge/pitfall entries live **one per file** by default (a small cluster captured
together in the same verification pass about the same narrow topic may share one file); category
folders (`knowledge/<category>/`, `pitfalls/<category>/`) are created lazily, only on the first real
entry in that category. This avoids both a handful of large files each holding many unrelated
entries, and a proliferation of pre-scaffolded empty files nobody populates. Investigations move
from `investigations/active/` to `investigations/completed/` once their gate reaches a terminal
status; tasks move from `completed/`/`abandoned/` to `archived/` once no longer likely to be
referenced; superseded/invalidated decisions move from `decisions/active/` to
`decisions/superseded/`. Retired whole files from earlier conventions go to `archive/` with a dated
provenance note — never deleted. Full namespace layout: `project-memory/README.md`.

## 6. Retrieval contract

1. Identify the repository and resolve the Project Memory location (`task-intake`).
2. Read only `index/memory-index.md` first — it is a thin router, never a store. It points to
   `project-profile.md`, and to exactly the sub-index needed:
   `index/component-index.md` (knowledge/pitfalls by component, integration, configuration, or
   operations area), `index/decision-index.md`, or `index/task-index.md`. Never read a whole
   `knowledge/`, `pitfalls/`, `decisions/`, or `tasks/` tree by default.
3. Generate retrieval criteria from: the requirement, repository, affected component, error or
   symptom, technology, relevant file paths, and known constraints.
4. Select **at most 5 entries by default**. Loading more requires a stated justification recorded
   with the task (e.g. a Deep-path task genuinely touching five-plus distinct subsystems).
5. For each candidate, state internally why it may be relevant before validating it. Keyword or
   title similarity alone is never sufficient proof of applicability.
6. Validate every candidate against:
   - repository / project scope
   - component scope
   - `applies_when` conditions
   - `does_not_apply_when` exclusions
   - status (reject `stale` / `invalidated` / `superseded` entries unless the task is specifically
     investigating the supersession)
   - freshness (how much the referenced area has changed since `verified_at`)
   - compatibility with current code
   - conflicts with newer or higher-priority evidence
7. Record accepted and rejected entries with a one-line reason each — in `investigation.md`'s
   Relevant Memory section, or the task record's Memory Consulted / Memory referenced field.

## 7. Conflict handling

Never silently choose between conflicting memory entries. Surface the conflict explicitly and
resolve it using the evidence-precedence hierarchy (§2). If it cannot be resolved and materially
affects the solution, record it as an open uncertainty and **stop before implementation**.

## 8. Freshness and invalidation

Status vocabulary: `candidate → verified → (stale | invalidated | superseded)`.

- **candidate** — created, not yet verified against real evidence or execution.
- **verified** — confirmed by evidence/execution at `verified_at`.
- **stale** — referenced files/components changed materially since verification; needs
  revalidation before reuse (not necessarily wrong).
- **invalidated** — confirmed wrong or no longer true.
- **superseded** — replaced by a newer entry; link both directions (`supersedes` /
  `superseded_by`).

Revalidation triggers (checked opportunistically during `task-resume`, `code-investigation`, and
`knowledge-capture` — no separate background job required):
- referenced files no longer exist or changed materially;
- the related component or architecture was significantly replaced;
- a dependency or framework received a major-version upgrade;
- runtime evidence contradicts the entry;
- an approved requirement changes the behavior;
- a newer verified entry supersedes it;
- the entry has not been reused in a long time and its referenced area has since changed.

Never delete historical knowledge — mark it appropriately and preserve traceability via
`supersedes` / `superseded_by`.

## 9. Promotion to Shared Brain

Unchanged gate (enforced by `knowledge-capture`): not client-specific; applicable beyond one
project; backed by direct evidence or executable validation; sanitized; explicit scope with
`applies_when` / `does_not_apply_when`; explicit review before anything sensitive or low-confidence
is promoted. Never automatic. A hypothesis is never promotable (§4).

## Verification date

Established: 2026-09-09. Invalidation: revisit if the evidence hierarchy, the layer set, the
retrieval budget, or the status vocabulary changes.
