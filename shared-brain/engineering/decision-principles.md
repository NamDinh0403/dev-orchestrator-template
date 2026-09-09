# Shared Brain — Decision Principles

Reusable, cross-project engineering decision principles (not project-specific decision records).
Use `SB-DEC-###` IDs.

> **Illustrative example below.** This entry shows the expected format only — it is not a real,
> verified finding. Replace it with your team's first real, evidence-backed principle (or delete
> it) once you have one.

---

### SB-DEC-000: Example — prefer extension/DI override over editing a shared library

- **Principle:** When required behavior lives in a shared, externally-owned library (package
  dependency, shared component library), prefer overriding it from the consumer via extension,
  composition, or dependency-injection provider substitution rather than editing the library
  source. Editing shared code affects every consumer, is usually out of scope for a single task,
  and creates maintenance/merge burden on library upgrades.
- **When it applies:** the consumer can subclass/override the relevant unit and the library
  exposes an injection or extension seam.
- **When to reconsider:** the change is a genuine library-level fix benefiting all consumers, or
  no extension/override seam exists — then coordinate a library change explicitly.
- **Evidence basis:** _(link to the pattern/task that proved this out, e.g. SB-PAT-###)._
- **Confidence:** _(high | medium | low)_
- **Invalidation conditions:** _(what would make this obsolete, e.g. the library ships a
  first-class configuration/feature-flag for the behavior)._
