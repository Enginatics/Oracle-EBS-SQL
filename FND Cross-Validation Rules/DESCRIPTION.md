# Case Study & Technical Analysis: FND Cross-Validation Rules

## Executive Summary
This report lists the cross-validation rules defined on key flexfield structures, one row per rule element, meaning each include or exclude range. Its second mode lists the enabled accounting flexfield combinations that break an enabled, currently active rule. General ledger administrators and security reviewers use it to audit which account combinations are permitted, and to find combinations that were created before a rule was tightened. The output runs in Excel through Blitz Report™.

## Business Challenge
*   **Account control:** Cross-validation rules restrict which combinations of segments can be used, such as which cost centers can be posted to a given natural account, and these rules must be reviewable as a whole.
*   **Rules that do not apply retrospectively:** Oracle validates a combination only when it is created, so a combination created before a rule was defined or tightened remains enabled while violating the rule.
*   **Audit evidence:** Internal audit needs a list of the rules, their ranges, their active dates and who last changed them.
*   **Multi-structure ledgers:** A ledger can use one chart of accounts structure with several rules, and each rule must be traced to its structure.

## The Solution
*   Lists each rule with its application, flexfield, structure, rule name, description, enabled status, active dates and error message.
*   Shows each element of a rule as an include or exclude range, with the low and high segment values, the element's enabled status and the rule's creator and last update.
*   In violating-combinations mode, lists each enabled account combination that fails an enabled and active rule, one row per combination and violated element.
*   Reports a combination outside every include range against the Include element type with blank ranges, and a combination inside an exclude range against that exclude range.

## Technical Architecture (High Level)
### Primary Tables
*   `FND_FLEX_VDATION_RULES_VL`: the cross-validation rule definitions, including rule name, active dates and error message.
*   `FND_FLEX_VALIDATION_RULE_LINES`: the rule elements, one row per include or exclude range.
*   `FND_FLEX_INCLUDE_RULE_LINES` and `FND_FLEX_EXCLUDE_RULE_LINES`: the segment low and high values of each include and exclude element.
*   `FND_FLEX_VALIDATION_RULES`: the enabled rule definitions used in the violation check.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield combinations tested by the violation check.
*   `FND_ID_FLEXS`, `FND_ID_FLEX_STRUCTURES_VL`, `FND_ID_FLEX_SEGMENTS` and `FND_ID_FLEX_SEGMENTS_VL`: the flexfield, structure and segment definitions.
*   `FND_APPLICATION_VL`: the application name for each rule.

### Logical Relationships
1.  Each rule is joined to its application, flexfield, and structure, which give the names shown in the output.
2.  The rule elements are built by a union of the include lines and the exclude lines, each joined to its range values.
3.  Segment ranges are pivoted into one column pair per segment, so a combination can be compared with each segment in turn.
4.  In violation mode, enabled and currently active accounting combinations of the GL flexfield are paired with every enabled rule of the same structure.
5.  A combination is kept as a violation when it falls outside every include range of a rule, or inside an exclude range.
6.  The output is joined back to the rule definitions and ordered by application, flexfield, structure, rule and account.

## Parameters & Filtering
*   **Flexfield** and **Structure:** restrict the rules to one key flexfield and one structure.
*   **Ledger:** restricts the output to the chart of accounts of one ledger.
*   **Rule Name:** selects one cross-validation rule.
*   **Enabled Only:** limits the output to enabled rules and elements.
*   **Show Violating Combinations:** switches the report from the rule definitions to the account combinations that violate an enabled, active rule.

## Performance & Optimization
*   The violation mode is the expensive path, because every enabled, active, non-summary account combination is compared with every enabled rule of the structure, so the Ledger and Structure parameters are the main levers.
*   The segment comparisons are evaluated only on rules that have elements, and an include match is computed once per combination and rule through an analytic maximum.
*   Active date windows are applied to rules and combinations before the comparison, which keeps retired rules and inactive accounts out of the join.
*   The definition mode reads only rule metadata and does not touch account combinations, so it runs quickly for a whole flexfield.

## FAQ
**Q: Why does an existing account combination violate a rule?**
A: Oracle validates a combination only when it is created, so a combination created before the rule was defined or tightened stays enabled even though it violates the rule.

**Q: How is a combination outside all include ranges reported?**
A: It is reported against element type Include with blank segment ranges, because it matches none of the include ranges of the rule.

**Q: How are segment values compared with the ranges?**
A: The values are compared as text, which matches Oracle's validation for character value sets.
