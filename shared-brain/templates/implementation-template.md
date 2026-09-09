<!--
Template — implementation.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/{active,completed}/<issue-id-or-slug>/implementation.md
Produced in IMPLEMENT → VERIFY → COMPLETE by /implement-card, only after a valid
APPROVED_FOR_IMPLEMENTATION approval. Replace every <placeholder>.
-->

# Implementation Result: <issue ID or title>

## Metadata

- Issue ID: <id>
- Investigation report path: <path to investigation.md>
- Investigation report version implemented: <version>
- Approval path: <path to approval.md>
- Approval version: <version>
- Approved source revision: <revision approval referenced>
- Implemented source revision (base): <revision implementation started from>
- Implementation status: <COMPLETE | BLOCKED | PARTIAL>
- Implemented timestamp: <ISO-8601>

## Approval Precondition Check

- approval.md located: <yes/no>
- Decision = APPROVED_FOR_IMPLEMENTATION: <yes/no>
- Approval references current investigation version: <yes/no>
- Approval references investigated source revision: <yes/no>
- Material source changes since approval: <none | list — and how handled>
- Root cause revalidated against current source: <yes/no + note>
- Approved scope restated: <yes/no>

## Approved Scope Implemented

- Approved behavior delivered:
- Explicit exclusions respected:

## Requirement-to-Change Mapping

| Requirement / acceptance criterion | Change (file/symbol) |
| ----------------------------------- | --------------------- |

## Changes

- Files changed:
- Symbols changed:
- Summary of change:

## Verification (VERIFY mode)

Only executed commands and their results:

- Command: `<command>` → <result>
- Required tests (from approval): <status>
- Build: <status>
- Lint / type check: <status>
- diff-review: <summary>
- security-review (if flagged): <summary>

## Manual Verification

Steps a human should perform to confirm:

- 

## Scope / Risk Notes

- Deviations from approved scope: <none | STOPPED — reason>
- New risks discovered (security/data/migration/integration/contract): <none | list>
- Known limitations:

## Outcome

- Result:
- Follow-up items:
