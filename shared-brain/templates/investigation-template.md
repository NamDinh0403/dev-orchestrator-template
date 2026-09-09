<!--
Template — investigation.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/investigation.md
Produced in INVESTIGATE mode by /investigate-issue. Read-only evidence: never modify source, config,
or tests as part of a proposed fix; never implement. Replace every <placeholder>.
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
- Reported behavior:
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

## Evidence

For every material finding:

- Finding identifier: F-1
  - Evidence:
  - File path:
  - Symbol or configuration key:
  - Line range (when available):
  - Interpretation:
  - Confidence: <High | Medium | Low>

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

## Proposed Solution

- Recommended change:
- Expected files and symbols:
- Implementation constraints:
- Alternatives considered:
- Risks and trade-offs:
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
