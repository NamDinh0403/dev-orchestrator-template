# Knowledge Entry Template

Use for Project Memory knowledge (ARC/PAT/PIT/CST/TRB) and Shared Brain knowledge
(SB-PAT/SB-PIT/SB-CST/SB-TRB/SB-DEC). Copy the block; do not rewrite existing entries when
appending — supersede instead (see Discipline below).

Full canonical rules (evidence precedence, retrieval budget, validation checklist, freshness
statuses): `~/.copilot/shared-brain/workflows/memory-evidence-policy.md`.

## Knowledge types and ID prefixes

| Type | Meaning | Project Memory prefix | Shared Brain prefix |
| --- | --- | --- | --- |
| Fact / architecture | Directly supported by current evidence about this repository | `ARC-###` | _(rarely promoted — usually project-specific)_ |
| Pattern | A verified, reusable implementation approach | `PAT-###` | `SB-PAT-###` |
| Pitfall | A verified failure pattern + trigger conditions | `PIT-###` | `SB-PIT-###` |
| Constraint | A verified technical/business/security/operational limitation | `CST-###` | `SB-CST-###` |
| Procedure / troubleshooting | A verified, reusable diagnostic or resolution procedure | `TRB-###` | `SB-TRB-###` |
| Decision | An approved choice — see `decision-template.md` | `DEC-YYYYMMDD-###` | `SB-DEC-###` |
| Hypothesis | An unconfirmed explanation | **Not a durable knowledge entry.** Keep it only inside the originating `investigation.md`; never promote until confirmed by evidence. |

## Entry schema

```
### <ID>: <title>
- **Category:** architecture | pattern | pitfall | constraint | troubleshooting | decision-principle
- **Status:** candidate | verified | stale | invalidated | superseded
- **Finding:** <concise, verified finding> (for pitfalls include symptom + cause + prevention +
  detection; for troubleshooting/procedure include symptom + procedure; for constraints include
  the limitation and why it holds)
- **Scope:** <repositories / components / technologies where this was verified>
- **Applies when:** <explicit condition(s) where this entry is applicable>
- **Does not apply when:** <explicit exclusion(s) / boundary>
- **Evidence:**
  - type: source-code | runtime | test | configuration | requirement | human-review — reference: <path / log / test name> — commit or version: <value or "n/a">
- **Provenance:** source task <TASK-ID>, source investigation <slug or "n/a">, created <YYYY-MM-DD>
  by <agent | human>, verified <YYYY-MM-DD or "not yet verified"> by <human | automated-test |
  runtime-evidence | "n/a">
- **Confidence:** high | medium | low
- **Revalidate when:** <condition that should trigger a re-check, even if not yet invalidating>
- **Invalidated by:** <condition/evidence that would directly invalidate this entry>
- **Supersedes:** <ID or n/a>
- **Superseded-by:** <ID or n/a>
- **Related entries:** <IDs or n/a>
```

## Discipline
- Search the relevant index first; update or supersede an existing entry instead of duplicating.
- A `candidate` entry (created but not yet verified against real evidence or execution) must not
  be cited as a fact elsewhere until it reaches `verified`.
- Never delete a `stale`/`invalidated`/`superseded` entry — mark it and link the replacement.
- A hypothesis, an unconfirmed assumption, or a `Probable`/`Inconclusive` investigation root cause
  is never written here — see the Hypothesis row above and §4 of `memory-evidence-policy.md`.
