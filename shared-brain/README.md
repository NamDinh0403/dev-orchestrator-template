# Shared Brain

Cross-project, reusable engineering knowledge for the Development Orchestrator
(`~/.copilot/agents/development-orchestrator.agent.md`). Shared across all clients and repositories.

## Purpose

- Store reusable engineering patterns, recurring failure modes, validated troubleshooting
  procedures, cross-project implementation lessons, workflow procedures, templates, and
  decision-making principles applicable to multiple repositories.

## Allowed content

- Verified, reusable engineering findings not tied to a single client.
- General technology/framework rules with explicit scope and evidence.
- Workflow procedures and reusable templates.

## Prohibited content

Client secrets, authentication information, private card content, project-specific paths,
project-specific task history, unverified assumptions, temporary debugging notes, raw reasoning
logs, and large source-code dumps.

## Evidence requirements

Every entry must cite direct source evidence or executable validation, and record scope,
verification date, confidence, and invalidation conditions.

## Promotion rules

Promote a finding from Project Memory only when it: is not client-specific; applies to more
than one project or is a general technology rule; is backed by source evidence or executable
validation; has sensitive information removed; has explicit scope; and records invalidation
conditions. Otherwise keep it in Project Memory. See the `knowledge-capture` skill.

## Stale knowledge handling

When an entry no longer matches reality, mark it **superseded** with a link to the replacement.
Do not silently delete history.

## Conflict resolution

Current source code and executed validation override Shared Brain. When they conflict, trust
the code, record the conflict in the task, and correct the entry.

## Privacy boundaries

Shared Brain is cross-client. Never let one client's private data, paths, or task history leak
here. Generalize and sanitize before promoting.

## Entry ID conventions

- `SB-PAT-###` — cross-project patterns (`engineering/patterns.md`)
- `SB-PIT-###` — cross-project pitfalls (`engineering/known-pitfalls.md`)
- `SB-TRB-###` — cross-project troubleshooting (`engineering/troubleshooting.md`)
- `SB-DEC-###` — decision principles (`engineering/decision-principles.md`)

Index: `index.md`.
