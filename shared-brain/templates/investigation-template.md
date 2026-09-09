<!--
Template — investigation.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/investigation.md
Produced in INVESTIGATE mode by /investigate-issue. Read-only evidence: never modify source, config,
or tests as part of a proposed fix; never implement. Replace every <placeholder>. Memory retrieval
and evidence rules: ~/.copilot/shared-brain/workflows/memory-evidence-policy.md.
-->

# Investigation: <issue ID or title>

## Metadata

- Issue ID: <id>
- Issue title: <title>
- Investigation status: <PENDING_DEVELOPER_REVIEW | BLOCKED_MISSING_INFORMATION | INCONCLUSIVE | NOT_REPRODUCIBLE>
- Root-cause confidence: <Confirmed | Probable | Inconclusive | Not Reproduced>
- Investigated timestamp: <ISO-8601>
- Source revision: <commit SHA / revision investigated>
- Working tree status: <clean | dirty — summary>
- Investigation report version: <integer, starts at 1; increment on reinvestigation>

## Issue Summary

- Original requirement:
- Reported (current) behavior:
- Expected behavior:
- Acceptance criteria:
- Relevant environment information:

## Initial Classification

- Issue type:
- Expected scope:
- Risk level: <Fast | Standard | Deep> + reason
- Potentially affected modules:
- Security risk:
- Data-integrity risk:
- Migration risk:
- Integration risk:
- Public-contract risk:

## Reproduction

- Reproduction status: <Reproduced | Partially reproduced | Not reproduced>
- Steps:
- Observed result:
- Expected result:
- Limitations:

## Evidence (verified facts only — no assumptions or hypotheses here)

For every material finding:

- Finding identifier: F-1
  - Evidence:
  - File path:
  - Symbol or configuration key:
  - Line range (when available):
  - Interpretation:
  - Confidence: <High | Medium | Low>

## Assumptions

Explicit, load-bearing assumptions made because direct evidence was unavailable. Each must be
re-checked before being relied upon by implementation or a later task.

- A-1: <assumption> — <why it was necessary; what would confirm/refute it>

## Hypotheses

Possible explanations that are **not confirmed**. Never cite these as fact elsewhere; a hypothesis
must be revalidated every time it is reused (see `memory-evidence-policy.md` §4).

- H-1: <hypothesis> — <what evidence would confirm or refute it>

## Relevant Memory

Entries retrieved from Project Memory / Shared Brain while investigating (max 5 by default; see
`memory-evidence-policy.md` §5). Keyword similarity alone is never proof of applicability.

- **Selected:**
  - <Entry ID> — <why relevant> — <validated against current source: yes/no + note>
- **Rejected:**
  - <Entry ID> — <why rejected: out of scope / stale / conflicting / unsupported>
- **Conflicts found:**
  - <Entry ID vs. Entry ID or vs. current evidence> — <resolution, or "unresolved — see Open Questions">

## Execution Flow

Verified execution path from entry point to observed outcome. Mark each step:

- Confirmed steps:
- Inferred steps:
- Divergence or failure point:
- External dependencies:

## Root Cause

- Conclusion:
- Classification: <Confirmed | Probable | Inconclusive | Not Reproduced>
- Supporting evidence:
- Alternative hypotheses:
- Remaining uncertainty:

## Impact Analysis

- Affected components:
- Expected affected files:
- Behavioral impact:
- Data impact:
- Security impact:
- Integration impact:
- Compatibility impact:
- Regression risk:

## Solution Options

List each viable approach considered, including the one recommended below:

- Option 1: <approach> — <trade-offs / risks>
- Option 2: <approach> — <trade-offs / risks>

## Recommended Solution

- Recommended change:
- Expected files and symbols:
- Implementation constraints:
- Why this option over the others:
- Risks and side effects:
- Verification plan:
- Rollback considerations:

## Open Questions

Identify each question's owner (Developer | Product owner | Client | QA | Infrastructure/deployment):

- Q-1 (<owner>):

## Review Scope

Explicitly define what a developer would approve:

- Approved behavior:
- Proposed technical scope:
- Files expected to change:
- Explicit exclusions:
- Required tests:
- Implementation prerequisites: <access, config, approvals, or environment needed before
  implementation can start, or "none">
- Conditions requiring reapproval:

## Investigation Gate

Set exactly one:

- [ ] PENDING_DEVELOPER_REVIEW
- [ ] BLOCKED_MISSING_INFORMATION
- [ ] INCONCLUSIVE
- [ ] NOT_REPRODUCIBLE

<!--
Closing response (in chat, not this file) must end with:
- Investigation report path
- Investigation status
- Root-cause confidence
- Open-question count
- Recommended next command (/review-investigation <path>)
Do not implement.
-->
