# Case Study & Technical Analysis: Blitz Report Assignment Validation

## Executive Summary
The Blitz Report Assignment Validation report lists every Blitz Report in the library together with the number of assignments it has at each assignment level. It is a governance and support tool for administrators who maintain Blitz Report™ access. Its purpose is to show, in one table, which reports are assigned to sites, applications, request groups, responsibilities, users, forms, functions and reports, and which reports have no assignment at all. An administrator can use it to confirm that every report is reachable by the intended users before a rollout or a clean-up.

## Business Challenge
*   **Invisible reports:** A report with no assignment cannot be found by any user in the menu, so it is effectively unavailable, and this is hard to spot across hundreds of reports.
*   **Partial assignment:** A report can be assigned at one level, such as a responsibility, but missing at another level that users depend on, such as a request group.
*   **Exclusions:** Exclusion assignments remove access for specific targets, and their count needs to be visible next to the include counts.
*   **Audit trail:** Administrators need to see who created or last changed each report, and when, when they review access.

## The Solution
*   **Assignment counts by level:** The report pivots the assignment table into one column per level, counting distinct include targets at each level.
*   **Blank-cell signalling:** Zero counts are converted to blanks, so an empty cell in an assignment column stands out against populated cells.
*   **Exclusion counting:** A separate column counts exclude assignments, so exclusions can be seen beside the includes.
*   **Targeted gap finding:** The report can list only the reports with no include assignment at any level, or with no include assignment at one selected level.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORTS_V`: the report catalogue, supplying the report name, type, category, disabled flag, creator and update details.
*   `XXEN_REPORT_ASSIGNMENTS`: the assignment rows, each with a report ID, an assignment level, an include or exclude indicator and two identifier columns.

### Logical Relationships
1.  An inline view groups `XXEN_REPORT_ASSIGNMENTS` by report ID.
2.  Within that view, `COUNT(DISTINCT ...)` expressions produce one total column for include assignments, one column per assignment level for includes, and one column for excludes. Each distinct target is built from the assignment level and the two identifier columns.
3.  `XXEN_REPORTS_V` is outer joined to the aggregated view on report ID, so reports with no assignments still appear.
4.  The result is ordered by the total include count, with blanks first, and then by report name.

## Parameters & Filtering
*   **Category and Not in Category:** Include or exclude reports by category, to scope the review to one part of the library.
*   **Type:** Limits the output to one report type.
*   **Disabled:** Shows reports by their disabled status.
*   **Not Assigned Only:** When set to Yes, returns only reports with no include assignment at any level.
*   **Not Assigned at Level:** Returns reports that have no include assignment at the selected level, which finds targeted gaps.

## Performance & Optimization
*   **Single pass aggregation:** The assignment table is read once and aggregated by report, so the level counts come from one grouped scan rather than one query per level.
*   **Outer join to the catalogue:** The catalogue is outer joined to the aggregate, so unassigned reports are retained without a separate query.
*   **Catalogue-level filters:** The category, type, disabled and not-assigned parameters restrict the report rows, so the output can be limited to a subset of the library without changing the assignment aggregation.
*   **Distinct counting:** Each level uses `COUNT(DISTINCT)` on the target key, so duplicate assignment rows do not inflate the counts.

## FAQ
**Q: How do I find Blitz Reports that are not assigned to anyone?**
A: Set Not Assigned Only to Yes. The report then lists only reports with no include assignment at any level.

**Q: What does a blank assignment cell mean?**
A: A blank cell means the report has no assignment at that level, because zero counts are displayed as empty.

**Q: How do I check that every report is assigned at responsibility level?**
A: Select Responsibility in the Not Assigned at Level parameter, which lists the reports with no include assignment to any responsibility.
