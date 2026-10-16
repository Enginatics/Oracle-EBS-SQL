# Case Study & Technical Analysis: EAM Failure Codes Upload

## Executive Summary
The EAM Failure Codes Upload creates, updates and end-dates the failure, cause and resolution codes used in Oracle Enterprise Asset Management. Maintenance planners and reliability engineers use it to build the code library that work orders are closed against, so that failure analysis can be reported consistently across asset maintenance. The report runs in Excel via Blitz Report, and all three code types are read from their own tables, with the Code Type parameter selecting which table is affected.

## Business Challenge
*   **Consistent failure coding:** Work order completion depends on a shared set of failure, cause and resolution codes, and inconsistent coding weakens later reliability analysis.
*   **Bulk code maintenance:** Adding or revising many codes through the EAM setup forms is slow when a new maintenance taxonomy is introduced.
*   **Retiring obsolete codes:** Codes that are no longer used need an effective end date rather than deletion from history, and reactivating them should be a simple edit.
*   **Global scope:** The codes are not tied to any operating unit or organization, so an error affects every maintenance organization that uses them.

## The Solution
*   **Three code types in one layout:** Failure Code, Cause Code and Resolution Code are presented on one spreadsheet, with the Code Type column identifying each row.
*   **Current codes for editing:** In Create, Update mode the existing codes are downloaded with their description and effective end date, ready for amendment.
*   **Lifecycle control:** The Effective End Date column ends a code or, when cleared, reactivates it.
*   **Explicit deletion:** The Delete Record column removes an existing code when set to Yes.

## Technical Architecture (High Level)
### Primary Tables
*   `EAM_FAILURE_CODES`: the failure code definitions, with the code, description and effective end date.
*   `EAM_CAUSE_CODES`: the cause code definitions, with the same columns.
*   `EAM_RESOLUTION_CODES`: the resolution code definitions, read for the third code type, with the same columns.

### Logical Relationships
1. The three code tables are read separately and combined with `UNION ALL` into one inline result set.
2. Each branch assigns a fixed code type value: '10' for failure codes, '20' for cause codes and '30' for resolution codes.
3. Each branch returns the code, description and effective end date, and a `ROWNUM` as the upload row identifier.
4. The outer query translates the code type through `xxen_util.meaning` with the EAM_FAILURE_CODE_TYPE lookup, and returns the delete record column as empty for the upload.

## Parameters & Filtering
*   **Upload Mode:** The SQL includes a branch only when the mode contains the update action, so Create mode opens an empty spreadsheet and Create, Update mode downloads the existing codes.
*   **Code Type:** When set to Failure Code, Cause Code or Resolution Code, only the matching branch is returned. When left empty, all three code types are returned on the same spreadsheet.

## Performance & Optimization
*   The mode and code type conditions are evaluated against bind variables inside each `UNION ALL` branch, so a branch that is excluded does not return rows.
*   The three code tables are read directly with no joins, so the query cost is proportional to the number of codes in each table.
*   The outer query adds one lookup, the code type meaning translation, and no aggregation or analytic functions are used.
*   Because the codes are global, no organization or operating unit filter is applied, and the report does not read any organization security views.

## FAQ
**Q: How do I end-date an EAM failure code without deleting it?**
A: Enter an Effective End Date for the code in the Failure Code rows and upload; clearing the date later reactivates it.

**Q: Are EAM failure codes scoped to an organization?**
A: No. The description states that codes are global and not scoped to any operating unit, so a change applies wherever the codes are used.

**Q: How do I delete an EAM cause code?**
A: Set the Delete Record column to Yes on the Cause Code row; the code is removed from the cause code table.
