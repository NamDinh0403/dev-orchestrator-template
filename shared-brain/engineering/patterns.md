# Shared Brain — Patterns

Verified, reusable, cross-project engineering patterns. Each entry uses the knowledge template
(`../templates/knowledge-template.md`). Add an entry only when it is confirmed and reusable
beyond one client.

> **Illustrative example below.** This entry shows the expected format only — it is not a real,
> verified finding. Replace it with your team's first real, evidence-backed pattern (or delete it)
> once you have one.

---

### SB-PAT-000: Example — prefer a config/DI seam over forking a shared library

- **Category:** pattern (example)
- **Finding:** When a consuming application needs to change behavior that lives in a shared,
  externally-owned library, prefer extending/overriding it through whatever seam the library
  exposes (dependency-injection provider substitution, subclassing an extension point, a
  configuration/feature flag) instead of forking or directly editing the shared library's source.
- **Scope:** any consumer of a shared internal library that exposes an injection, subclassing, or
  configuration seam. Not applicable when no such seam exists or the target is `final`/not exported.
- **Evidence:** _(replace with your own — link the task, the diff, and the validation that proved
  it worked, e.g. a passing build/test run)._
- **Source project:** _(project key)_
- **Source task:** _(task id)_
- **Verification date:** _(YYYY-MM-DD)_
- **Applicable version / branch:** _(if known)_
- **Confidence:** _(high | medium | low)_
- **Invalidation conditions:** _(what would make this obsolete)_
- **Superseded-by:** n/a
