# Development Orchestrator — Team Template

A reusable, client-agnostic template of a Copilot custom-agent framework built around one idea:
**an AI coding agent should get measurably better over time instead of repeating the same
mistakes on every task, while spending most of its effort writing code — not managing itself.**
It does that with two durable memory layers plus a **risk-scoped** investigation → approval →
implementation gate: routine changes flow straight through, and only genuinely risky changes stop
for a human review.

This repo is a sanitized copy of a working setup — no client data, no company-specific agents.
Clone it, install it, and let your team grow its own knowledge base from here.

## Why this exists

Ad-hoc AI coding assistants forget everything between sessions: the same wrong assumption gets
re-investigated, the same rejected approach gets re-proposed, the same production pitfall gets
re-discovered the hard way. This framework fixes that with:

- **Reasoning / decision logs** — every meaningful engineering decision (a choice between valid
  implementations, a rejected shortcut, a scope call, a rollback strategy) is written down with
  its context, evidence, and rejected alternatives — not as a hidden chain-of-thought, but as a
  traceable record the next task (or the next teammate) can read. See the `decision-capture`
  skill and `shared-brain/engineering/decision-principles.md`.
- **Project Memory** — a per-repository, isolated memory of tasks, decisions, and knowledge
  (architecture notes, patterns, pitfalls, troubleshooting procedures) so the agent doesn't
  re-investigate what it already learned about *this* codebase.
- **Shared Brain** — a cross-project, team-wide knowledge base of verified, reusable engineering
  patterns, pitfalls, troubleshooting procedures, and decision principles, promoted from Project
  Memory only once they're evidence-backed and no longer client-specific.
- **A risk-scoped investigation → approval → implementation gate** — a genuinely risky change
  (security/authorization, data migration, an external contract change, architecture, an upgrade,
  or anything a developer explicitly wants investigated first) never jumps straight from "I looked
  into it" to "I changed the code" — a human reviews and approves the investigation first. A
  routine Fast/Standard change (the majority of tickets) implements directly, with no persisted
  investigation/approval paperwork and no mandatory approval round-trip, because that overhead
  buys no governance value at that risk level.

## Layout

```
agents/
  development-orchestrator.agent.md   Thin routing agent: intake, risk classification,
                                       capability routing, completion gate, durable capture.
prompts/
  implement-card.prompt.md            /implement-card  — IMPLEMENT/VERIFY mode (gated path)
  investigate-issue.prompt.md         /investigate-issue — INVESTIGATE mode (Deep/gated only)
  review-investigation.prompt.md      /review-investigation — REVIEW_APPROVAL mode (Deep/gated only)
skills/                                Focused, single-purpose procedures the orchestrator routes to:
  task-intake, task-resume, investigate-issue (incl. progressive code investigation),
  review-investigation, implement-card (incl. tiered planning, validation, diff review),
  decision-capture, knowledge-capture, project-bootstrap, requirement-grilling
project-memory/                        Per-repository, isolated memory (empty scaffold — see below).
shared-brain/                          Cross-project, team-wide knowledge base (empty scaffold —
                                        see below), plus reusable templates and workflow policy.
```

Full behavior is documented in each file — this README is an index, not a duplicate of the rules.
Start with [agents/development-orchestrator.agent.md](./agents/development-orchestrator.agent.md),
then [project-memory/README.md](./project-memory/README.md) and
[shared-brain/README.md](./shared-brain/README.md).

## Install (per teammate)

Everything the orchestrator needs lives under `~/.copilot/` (this VS Code Copilot agent host reads
`agents/`, `prompts/`, `skills/` from there, plus this template's own `project-memory/` and
`shared-brain/` conventions).

1. Clone this repo.
2. Run `install.ps1` (PowerShell). If your machine's execution policy blocks local scripts, run
   `powershell -ExecutionPolicy Bypass -File .\install.ps1` instead. Rerun it after pulling
   template updates: it replaces existing template-managed files under `agents/`, `skills/`,
   `prompts/`, `shared-brain/workflows/`, and `shared-brain/templates/` by default. Changed files
   are backed up under `~/.copilot/template-backups/` before replacement (`-Force` remains
   accepted for compatibility but is no longer needed). It preserves unrelated custom agents,
   skills, prompts, Shared Brain knowledge/index/backlog, and all existing Project Memory.
   It removes obsolete skills merged into `investigate-issue` and `implement-card` only if
   their files exactly match a previously shipped template version; otherwise it warns so you
   can review customized versions manually. First-time installation creates the starter memory
   scaffolds.
3. Restart/reload your Copilot agent session so it picks up the new agent and skills.
4. On your first task in a new repository, the orchestrator will invoke `project-bootstrap` to
   register that repository in your local `project-memory/registry.md`.

You can also just copy the folders manually if you prefer to review each file first — `install.ps1`
is a convenience, not a requirement.

## How the team should use this day to day

- **Project Memory stays local and per-repository, on purpose.** It isolates one client/repo's
  tasks, decisions, and knowledge from every other one — see the isolation rule in
  [project-memory/README.md](./project-memory/README.md). Don't commit real project namespaces
  (`project-memory/projects/<key>/`) into this shared template repo; they're `.gitignore`d here
  for that reason.
- **Shared Brain is the team's collective memory and is meant to be versioned.** When the
  `knowledge-capture` skill promotes a finding (non-client-specific, evidence-backed, sanitized,
  with explicit scope and invalidation conditions — see the promotion rules in
  [shared-brain/README.md](./shared-brain/README.md)), open a PR against this repo adding the
  entry to `shared-brain/engineering/*.md` and its `shared-brain/index.md` row. Review it like any
  other change: does the evidence support the claim? Is anything client-identifying left in it?
- **`shared-brain/engineering/patterns.md` and `decision-principles.md` currently contain one
  illustrative example entry each**, clearly marked as such. Replace them with your team's first
  real, evidence-backed entries (or delete them) once you have one — don't leave the placeholder
  in place indefinitely.
- **Periodically sync improvements back.** If someone tunes a skill or the orchestrator itself,
  land it here so every teammate's copy benefits — that's the whole point of a shared template.

## What was intentionally left out of this template

This template ships only the generic core. It does **not** include any client- or
company-specific custom agents/skills (for example, product-specific upgrade automations), and it
does not include any real registered project data or real Shared Brain findings — those are
specific to one setup and would leak information across a public/shared template. Add your own
client-specific agents/skills alongside this framework in your own `~/.copilot/agents` and
`~/.copilot/skills` as needed; they can coexist with everything here.
