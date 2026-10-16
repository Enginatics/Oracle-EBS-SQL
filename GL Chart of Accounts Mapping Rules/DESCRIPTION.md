# Case Study & Technical Analysis: GL Chart of Accounts Mapping Rules

## Executive Summary
This report lists the mapping rules of a Global Consolidation System (GCS) chart of accounts mapping in Oracle General Ledger. A mapping translates balances from a source chart of accounts into a target chart of accounts, and the report shows both kinds of rule: segment rules, which map segment values or value ranges, and code combination rules, which map a range of source code combinations to a target code combination. It is written for consolidation and group reporting accountants who must confirm that a mapping used for the group consolidation translates every account as intended, and for those who need to explain the mapping during a review. It is converted from the Oracle BI Publisher report Chart of Accounts - Mapping Rules (GLXCOCRRXML).

## Business Challenge
*   **Group reporting on a different chart:** A subsidiary's chart of accounts is often different from the group chart, so a mapping is needed before its balances can be consolidated.
*   **Confirming the mapping logic:** Reviewers must see exactly how each source segment or code combination maps to a target value before they accept the consolidation.
*   **Maintaining a mapping over time:** Mappings have start and end dates, and changes must be traceable through the last update user and date.
*   **Explaining rules to auditors:** The rules must be presented in a readable form, not as raw mapping tables.

## The Solution
*   Lists each mapping by name with its description, the source and target chart of accounts, and its active start and end dates.
*   Shows segment rules with their target segment, the mapping type, the source segment, the source value or range, and the target value or parent rollup value.
*   Shows code combination rules with the source code combination range from low to high, and the target code combination.
*   Shows the last updated user and date of each rule, so changes can be traced.

## Technical Architecture (High Level)
### Primary Tables
*   `GL_COA_MAPPINGS`: the mapping definition, with its name, description, source and target chart of accounts, and active dates.
*   `FND_ID_FLEX_STRUCTURES_VL`: the source and target chart of accounts structures.
*   `FND_ID_FLEX_SEGMENTS`: the segments of the target and source structures.
*   `GL_CONS_SEGMENT_MAP`: the segment mapping rules, with the mapping type and the source and target values.
*   `GL_CONS_FLEX_HIERARCHIES` and `FND_FLEX_VALUE_HIERARCHIES`: the child value ranges of a parent value in the source value set.
*   `GL_CONS_FLEXFIELD_MAP`: the code combination mapping rules, with the source ranges and the target code combination.
*   `GL_CODE_COMBINATIONS_KFV`: the target code combination, shown as concatenated segments.

### Logical Relationships
1. `GL_COA_MAPPINGS` is joined to the source and target chart of accounts structures on their identifiers.
2. The segment branch joins the target segments of the target structure to the segment mapping rules of the mapping.
3. The source segment is joined through the source structure, and the source ranges come from the child values of a hierarchy or value set.
4. The code combination branch joins the mapping's code combination rules to the target code combination.
5. The two branches are combined with UNION ALL and labelled as Segment Rule or Code Combination Rule.
6. The code combination ranges are built by concatenating the low and high segment values of the mapping row, separated by the delimiter of the source chart of accounts.

## Parameters & Filtering
*   **COA Mapping:** selects the mapping whose rules are listed.

## Performance & Optimization
*   The report works on one mapping at a time, so the joins to the mapping rules are restricted by the mapping identifier.
*   The segment branch uses outer joins to the rule table and the hierarchy tables, so target segments without a rule still appear.
*   The code combination ranges are built by concatenating segment values inline, which avoids a separate lookup for each range.
*   Ordering by rule type, segment number and source values puts the segment rules before the code combination rules in a stable sequence.

## FAQ
**Q: How do I review the rules of a consolidation mapping?**
A: Select the mapping in the COA Mapping parameter. Segment rules appear first, followed by code combination rules.

**Q: What does a segment rule with a parent rollup value mean?**
A: The source value range is taken from the child values of the parent rollup value in the source value set hierarchy, which is shown in the source range columns.

**Q: How can I see when a mapping rule was last changed?**
A: Each row shows the last updated by user and the last update date of the rule.
