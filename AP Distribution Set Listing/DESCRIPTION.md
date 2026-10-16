# Case Study & Technical Analysis: AP Distribution Set Listing

## Executive Summary
The AP Distribution Set Listing report documents the Oracle Payables distribution sets of an operating unit and their lines, with the account, percentage, income tax type, tax classification and project details of each line. Accounts Payable supervisors and finance systems teams use it to review which distribution sets exist, whether they are still active on a given date and how each invoice line will be coded when a distribution set is applied. It follows the logic of the standard Distribution Set Listing (APXGDGDL), and runs in Excel through Blitz Report.

## Business Challenge
*   **Coding control:** A distribution set codes every line of an invoice it is applied to, so an error in a set's accounts or percentages spreads to all invoices that use it.
*   **Active status:** Sets are retired by an inactive date, and the team must confirm which sets were usable on the date an invoice is entered.
*   **Tax and project coding:** Income tax types, tax classifications, projects, tasks and expenditure types on the lines must match the purpose of the set.
*   **Audit trail:** Reviewers need to see who created or last changed each set and each line.

## The Solution
*   Lists each distribution set of the operating unit with its description and inactive date, and each of its lines in the order of the distribution set line number.
*   Shows the account of each line as a concatenated segment string and adds the account description from the segment values.
*   Adds the project, task and expenditure organization for lines that charge a project, and the 1099 income tax type and VAT tax classification.
*   Resolves the created by and last updated by users of both the set and the line into user names.

## Technical Architecture (High Level)
### Primary Tables
*   `AP_DISTRIBUTION_SETS_ALL`: the distribution set header, with its name, description and inactive date.
*   `AP_DISTRIBUTION_SET_LINES_ALL`: one row per distribution set line, with the code combination, percentage, tax and project fields.
*   `HR_ALL_ORGANIZATION_UNITS_VL`: the operating unit and the expenditure organization of a line.
*   `GL_CODE_COMBINATIONS_KFV`: the accounting flexfield of the line.
*   `PA_PROJECTS_ALL` and `PA_TASKS`: the project and task charged by the line.
*   `MO_GLOB_ORG_ACCESS_TMP`: the operating units the user may access.

### Logical Relationships
1.  `AP_DISTRIBUTION_SETS_ALL` is joined to `AP_DISTRIBUTION_SET_LINES_ALL` on the distribution set id, so each set returns one row per line.
2.  The set is restricted to the operating units in `MO_GLOB_ORG_ACCESS_TMP`, and the operating unit name comes from `HR_ALL_ORGANIZATION_UNITS_VL`.
3.  The distribution code combination is read from `GL_CODE_COMBINATIONS_KFV` through an outer join, so lines without an account still appear.
4.  Project, task and expenditure organization are outer joined to `PA_PROJECTS_ALL`, `PA_TASKS` and `HR_ALL_ORGANIZATION_UNITS_VL`.

## Parameters & Filtering
*   **Operating Unit:** limits the listing to one operating unit.
*   **Distribution Set:** limits the listing to one distribution set by name.
*   **Effective Date:** the date against which the Status parameter is evaluated.
*   **Status:** selects distribution sets that are active or inactive as of the Effective Date, as the description states.

## Performance & Optimization
*   The operating unit filter uses the `MO_GLOB_ORG_ACCESS_TMP` table, so the query reads only the organizations granted to the user's responsibility.
*   Account, project and task lookups are outer joins on primary keys, so each line requires one row from each reference table and no aggregation is performed.
*   The report contains no aggregate functions; every row is a set line, so the output stays at line level and can be summed in Excel by the user.
*   Filtering by Distribution Set or Operating Unit at run time reduces the driving rows before the joins to the reference tables.

## FAQ
**Q: How do I list the lines of an Oracle Payables distribution set?**
A: Run the report with the Operating Unit and Distribution Set parameters. Each row is one distribution set line with its account, percentage and tax details.

**Q: How do I check which distribution sets were inactive on a given date?**
A: Enter the date in the Effective Date parameter and set Status. The report evaluates active and inactive status as of that date.

**Q: Which accounts are shown for a distribution set line?**
A: The account is the code combination of the line, displayed as concatenated segments, and the account description is built from the segment values.
