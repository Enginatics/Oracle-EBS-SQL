# Case Study & Technical Analysis: QA Collection Plan Relationships

## Executive Summary
This report lists every parent and child collection plan relationship in Oracle Quality, at one row per parent element to child element mapping. Quality engineers and metrology specialists use it when documenting a quality setup, auditing which plans feed which, or specifying an interface that must reproduce the values a parent plan writes into its children. Each row names both plans with their descriptions and types, the relationship behavior, the data entry and layout modes, the criteria that gate the child, and the element relationship operator. The report runs in Excel through Blitz Report.

## Business Challenge
*   **Undocumented plan chains:** One collection plan can create child plans automatically, and the chain is hard to see from the Oracle windows.
*   **Derived values:** Summed, averaged or copied values that a parent writes into its children must be reproduced in any external interface.
*   **Gating criteria:** A child plan is created only when its criteria are met, and those conditions are not visible on the element mapping.
*   **Organization boundaries:** Parent plans are secured by inventory organization, and a relationship must still be understood when the child sits in another organization.

## The Solution
*   **One row per mapping:** Each parent element to child element mapping is listed, and a relationship with no mapping yet is listed once.
*   **Plan identity:** The parent and child plan names, descriptions, types and organizations are returned, with the child plan shown in full even when its organization is not accessible.
*   **Behavior flags:** The relationship type, data entry mode, layout mode, automatic row count and default parent specification flag are shown as readable meanings.
*   **Criteria rendering:** The number of criteria and a readable list of their conditions are returned for each relationship.
*   **Operator meaning:** The element relationship type states what the parent value does to the child value.

## Technical Architecture (High Level)
### Primary Tables
*   `QA_PC_PLAN_RELATIONSHIP`: the pairing of a parent plan and a child plan, with the relationship type, data entry mode, layout mode and default flags.
*   `QA_PC_ELEMENT_RELATIONSHIP`: the element by element mapping within a relationship, with the element relationship type and link flag.
*   `QA_PC_CRITERIA`: the conditions under which the child is created, with operator and low and high values.
*   `QA_PLANS`: the parent and child plans, with name, description, type and organization id.
*   `QA_PLAN_CHARS`: the element prompts for each plan.
*   `QA_CHARS`: the element names.
*   `MTL_PARAMETERS`: the inventory organization code of each plan.
*   `ORG_ACCESS_VIEW`: the organizations the responsibility can access.

### Logical Relationships
1. `QA_PC_PLAN_RELATIONSHIP` joins to `QA_PLANS` twice, once as the parent plan and once as the child plan, on plan id.
2. Each plan joins to `MTL_PARAMETERS` on organization id as an outer join, which gives the organization code.
3. `QA_PC_PLAN_RELATIONSHIP` joins to `QA_PC_ELEMENT_RELATIONSHIP` on plan relationship id as an outer join, so relationships without mappings remain.
4. The parent and child characters join to `QA_CHARS` on character id, and their prompts come from `QA_PLAN_CHARS` for the matching plan.
5. Criteria are read from `QA_PC_CRITERIA` on plan relationship id, and they are summarized per relationship in the criteria count and the criteria list.

## Parameters & Filtering
*   **Organization:** matches either the parent or the child side of the relationship.
*   **Parent Plan and Child Plan:** restrict the relationships to one parent or child plan.
*   **Collection Element:** matches either side of the mapping.
*   **Element Relationship and Data Entry Mode:** restrict the rows to one relationship behavior or data entry mode.
*   **Criteria Element:** restricts the output to relationships gated by a given collection element.

## Performance & Optimization
*   The parent plan is filtered by the organization access view, and seeded template plans with organization id zero are always allowed.
*   The criteria list is an aggregated subquery per relationship, so the criteria text is built once for each relationship row.
*   The Criteria Element parameter narrows the relationships before the aggregated text is produced, because aggregated text cannot be filtered in the outer query.

## FAQ
**Q: Why does a row show a blank Organization Code?**
A: Seeded template plans are not owned by an inventory organization, so their organization code is blank.

**Q: Why can I see a child plan in an organization I cannot access?**
A: Inventory organization security applies to the parent plan only. The child plan is shown in full so the relationship is not left incomplete.

**Q: How do I find all relationships gated by one element?**
A: Enter the element in the Criteria Element parameter. The criteria list then shows the conditions for each relationship that uses it.
