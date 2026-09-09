# Knowledge Entry Template

Use for both Project Memory knowledge (ARC/PAT/PIT/TRB) and Shared Brain knowledge
(SB-PAT/SB-PIT/SB-TRB/SB-DEC). Copy the block; do not rewrite existing entries when appending.

```
### <ID>: <title>
- **Category:** architecture | pattern | pitfall | troubleshooting | decision-principle
- **Finding:** <concise, verified finding> (for pitfalls include symptom + cause + prevention +
  detection; for troubleshooting include symptom + procedure)
- **Scope:** <where it applies — technologies/modules/contexts>
- **Evidence:** <source files / tests / validation proving it>
- **Source project:** <PROJECT-KEY>
- **Source task:** <TASK-ID>
- **Verification date:** YYYY-MM-DD
- **Applicable version / branch:** <if known>
- **Confidence:** high | medium | low
- **Invalidation conditions:** <what would make this obsolete>
- **Superseded-by:** <ID or n/a>
```

ID prefixes:
- Project Memory: `ARC-###`, `PAT-###`, `PIT-###`, `TRB-###`
- Shared Brain: `SB-PAT-###`, `SB-PIT-###`, `SB-TRB-###`, `SB-DEC-###`
