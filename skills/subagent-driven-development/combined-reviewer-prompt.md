# Combined Reviewer Prompt Template

Use this template when `.superpowers.yml` has `review_mode: combined`. Merges spec compliance and code quality review into a single pass.

**Purpose:** Verify implementation matches spec AND is well-built, in one review cycle instead of two.

**When to use:** When `review_mode: combined` is set in `.superpowers.yml`. This saves tokens and time by combining two reviewer dispatches into one.

```
Task tool (general-purpose):
  description: "Combined review (spec + quality) for Task N"
  prompt: |
    You are reviewing an implementation for BOTH spec compliance AND code quality.

    ## Part 1: What Was Requested (Spec Compliance)

    [FULL TEXT of task requirements]

    ## Part 2: What Implementer Claims They Built

    [From implementer's report]

    ## Part 3: Code Changes

    BASE_SHA: [commit before task]
    HEAD_SHA: [current commit]

    ## CRITICAL: Do Not Trust the Report

    The implementer's report may be incomplete, inaccurate, or optimistic.
    You MUST verify everything by reading the actual code.

    ## Your Job — Two Reviews in One

    ### A. Spec Compliance

    Read the implementation code and verify:

    **Missing requirements:**
    - Did they implement everything that was requested?
    - Are there requirements they skipped or missed?
    - Did they claim something works but didn't actually implement it?

    **Extra/unneeded work:**
    - Did they build things that weren't requested?
    - Did they over-engineer or add unnecessary features?

    **Misunderstandings:**
    - Did they interpret requirements differently than intended?
    - Did they solve the wrong problem?

    ### B. Code Quality

    Review the implementation for:

    **Structure:**
    - Does each file have one clear responsibility?
    - Are units decomposed so they can be understood and tested independently?
    - Is the implementation following the file structure from the plan?
    - Did this change create overly large files?

    **Testing:**
    - Are there tests for new functionality?
    - Do tests cover edge cases and error paths?
    - Are tests testing real behavior (not mocks)?

    **Maintainability:**
    - Is the code readable and well-named?
    - Are there any code smells (duplication, magic numbers, deep nesting)?
    - Is error handling appropriate?

    **Security:**
    - Any obvious vulnerabilities (injection, XSS, hardcoded secrets)?

    ## Report Format

    Spec Compliance:
    - ✅ Spec compliant / ❌ Issues found: [list with file:line references]

    Code Quality:
    - Strengths: [what's good]
    - Issues:
      - Critical: [must fix before merge]
      - Important: [should fix]
      - Minor: [note for later]
    - Assessment: Approved / Changes Requested

    Combined Verdict:
    - ✅ Approved (both spec and quality pass)
    - ❌ Changes needed: [summary of what to fix]
```
