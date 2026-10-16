# Case Study & Technical Analysis: PER Organization Upload

## Executive Summary
The PER Organization Upload creates and updates organisations in Oracle HRMS, together with their classifications, their organisation information types and the cost allocation key flexfield segments that go with them. It is written for HR system administrators and implementation teams who build the organisation structure of an Oracle EBS enterprise, including business units, legal entities, inventory organisations and cost centres. The upload works within the business group of the current responsibility, and it does not create business groups.
## Business Challenge
*   **Structure set-up at scale:** A new enterprise structure can need dozens of organisations, each with classifications, locations and information types, and entering them one at a time is slow.
*   **Consistent classifications:** Each organisation needs the right classification, such as HR organisation, operating unit or legal entity, with the mandatory information types for that classification.
*   **Maintaining information types:** Organisation information types carry dozens of segments with labels that depend on the classification and the legislation, which are hard to keep consistent by hand.

## The Solution
*   **Organisation header in one row:** Each row carries the organisation name, type, dates, location, internal or external flag and internal address.
*   **Classification and enablement:** The classification, its enabled status and whether it has mandatory information types are shown on the row.
*   **Information type values with labels:** For each organisation information type, the segment labels and values are returned, with dynamic labels that follow the classification and legislation.
*   **Cost allocation segments:** For HR organisations, the cost allocation key flexfield segments are returned as thirty separate columns.

## Technical Architecture (High Level)
### Primary Tables
*   `HR_ALL_ORGANIZATION_UNITS`: the organisation record, with type, dates, location and business group.
*   `HR_ALL_ORGANIZATION_UNITS_TL`: the translated organisation name.
*   `PER_BUSINESS_GROUPS`: the business group that owns the organisation, and its legislation code.
*   `HR_LOCATIONS_ALL`: the organisation location.
*   `PAY_COST_ALLOCATION_KEYFLEX`: the cost allocation key flexfield segments for HR organisations.
*   `HR_ORGANIZATION_INFORMATION`: the organisation information records, including the classification records with the context CLASS.
*   `HR_ORG_INFO_TYPES_BY_CLASS`: the information types that each classification carries, with their mandatory and enabled flags.
*   `HR_ORG_INFORMATION_TYPES` and `HR_ORG_INFORMATION_TYPES_TL`: the information type definitions and their translated names.

### Logical Relationships
1. `HR_ALL_ORGANIZATION_UNITS` joins to `HR_ALL_ORGANIZATION_UNITS_TL` on the organisation identifier, filtered to the session language.
2. The organisation joins to `PER_BUSINESS_GROUPS` on the business group identifier, and that link carries the legislation code used for labels.
3. The organisation joins to `HR_LOCATIONS_ALL` on the location identifier, as an outer join.
4. The classification record is found in `HR_ORGANIZATION_INFORMATION` with the context CLASS.
5. The information records are matched to the classification through `HR_ORG_INFO_TYPES_BY_CLASS` and to their definitions through `HR_ORG_INFORMATION_TYPES`.
6. The cost allocation keyflex is joined only when the classification is HR organisation.

## Parameters & Filtering
*   **Upload Mode:** Chooses between create and update. Organisation information is returned only when the mode includes update.
*   **Business Group:** Restricts the organisations to the business group selected, which must be the one of the current responsibility.
*   **Organization Type and Organization Name:** Restrict the organisations by type and name.
*   **Location:** Restricts the organisations to one location.
*   **Organization Status:** Filters on whether the organisation is active on the current date.
*   **Classification and Classification Status:** Restrict the rows to one classification and to enabled or disabled classifications.
*   **Information Type:** Restricts the rows to one organisation information type.

## Performance & Optimization
*   **Business group driver:** The query is restricted to one business group, which narrows the organisations before the information joins.
*   **Pre-filtered information set:** Organisation information is pre-filtered to the general and multi-row navigation methods and to enabled information types with a matching flexfield context, which keeps the join small.
*   **Two-step upload guidance:** The description notes that self-referencing segments may need a second pass, so the first pass should create the information type and the second should update the self-referencing attribute.

## FAQ
**Q: How do I create an HR organisation with a classification in Oracle HRMS using a spreadsheet?**
A: Download the organisations for the business group, add a row with the name, type and classification, and upload the file. The Classification column controls which information types are available.

**Q: Can this upload create a new business group?**
A: No. The description states that business group creation is not supported, and the Define Organizations form must be used for that.

**Q: Which organisation information types cannot be updated after creation?**
A: The description names Business Group Information and Canada Employer Identification. These can be created but not modified by this upload.
