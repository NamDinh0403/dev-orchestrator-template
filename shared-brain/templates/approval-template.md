<!--
Template — approval.md
Location: ~/.copilot/project-memory/projects/<PROJECT-KEY>/investigations/<issue-id-or-slug>/approval.md
Produced in REVIEW_APPROVAL mode by /review-investigation. Never modifies application source code.
Use the section matching the decision. Never invent a reviewer identity.
-->

# Investigation Approval

## Metadata

- Issue ID: <id>
- Investigation report path: <path to investigation.md>
- Investigation report version: <version this decision reviewed>
- Decision: <APPROVED_FOR_IMPLEMENTATION | CHANGES_REQUESTED | REJECTED | NEEDS_REINVESTIGATION>
- Reviewer: <explicit user value | authenticated source identity | Developer>
- Review timestamp: <ISO-8601>
- Investigated source revision: <revision from investigation.md>
- Approved source revision: <current revision at approval time>
- Approval version: <integer, starts at 1>

<!-- ============ APPROVE ============ (use when Decision = APPROVED_FOR_IMPLEMENTATION) -->

## Approved Scope

- Approved behavior:
- Approved technical approach:
- Approved files or components:
- Explicit exclusions:
- Required tests:
- Required verification:

## Approval Conditions

Conditions implementation must satisfy:

- C-1:

## Reapproval Triggers

Reinvestigation/reapproval is required if any occurs (at minimum):

- Material source changes affecting investigated behavior.
- Root cause contradicted by new evidence.
- Expansion to another module.
- Security impact discovered.
- Data migration required.
- Public API or integration contract change discovered.
- Change to acceptance criteria.
- Change to the proposed solution beyond approved constraints.

## Decision

APPROVED_FOR_IMPLEMENTATION

<!-- ============ REQUEST_CHANGES ============ (use when Decision = CHANGES_REQUESTED) -->
<!--
## Review Comments
- 
## Required Investigation Updates
- 
Decision: CHANGES_REQUESTED
Investigation gate updated to: NEEDS_REINVESTIGATION
Recommended next command: /investigate-issue <investigation-report-path>
Do not rewrite investigation findings as if they were already re-investigated.
-->

<!-- ============ REJECT ============ (use when Decision = REJECTED) -->
<!--
## Rejection Reason
- 
Decision: REJECTED
Investigation gate updated to: REJECTED
No implementation may proceed from a rejected investigation.
-->
