# Case Study & Technical Analysis: Blitz Report Parameter Link Validation

## Executive Summary
The Blitz Report Parameter Link Validation report finds orphaned parameter rows in the Blitz Report library. An orphaned row is an additional-anchor (sub) parameter that has no display sequence and does not link to a visible parameter of the same name in the same report. Report developers and DBAs who maintain the library run it after renaming parameters to confirm that no stale rows remain. The report does not change run-time output, because the executed SQL is built only from linked parameters. Its purpose is to keep the parameter setup clean and to prevent an old parameter name from being reactivated unexpectedly. The results can be filtered in Excel through Blitz Report.

## Business Challenge
*   **Stale configuration after renames:** When a parameter is renamed, the old sub-rows can remain in the setup and clutter the parameter definitions of the report.
*   **Unexpected reactivation:** An orphaned sub-row would be reactivated if a visible parameter with the old name were created later, changing the report without an obvious cause.
*   **Difficult manual review:** The library holds many reports, each with several anchors, so a manual check of every parameter setup is impractical.

## The Solution
*   **Orphan detection:** The report returns parameter rows whose parameter ID is absent from the linked-parameter view, which is the set of parameters that actually feed the run-time SQL.
*   **Scope by category:** The Category parameter limits the check to one group of reports.
*   **Context columns:** Each row shows the report name, category, display sequence, parameter name, anchor and the SQL text, so the developer can see what the orphan would have contributed.
*   **Audit columns:** Creator, last updater and timestamps are shown as readable user names and client times.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_PARAMETERS_V`: the parameter rows of every report, with display sequence, anchor and SQL text.
*   `XXEN_REPORT_PARAMETERS_LINK_V`: the linked parameters that are used when the run-time SQL is assembled.

### Logical Relationships
1.  The report reads each row of `XXEN_REPORT_PARAMETERS_V`.
2.  A `NOT IN` subquery removes every parameter ID that appears in `XXEN_REPORT_PARAMETERS_LINK_V`.
3.  The remaining rows are the orphans, returned in report name, parameter name and anchor order.

## Parameters & Filtering
*   **Category:** the only parameter. It restricts the orphan check to the reports in the selected category, which is the main way to limit the scope of a large library.

## Performance & Optimization
*   The orphan test is a single `NOT IN` subquery on the linked-parameter view, so each parameter is compared once against the set of linked IDs.
*   The query reads only the two parameter views and does not touch the report data tables.
*   Ordering by report name, parameter name and anchor produces a stable list for review without a second pass.

## FAQ
**Q: What is an orphaned Blitz Report parameter?**
A: It is an additional-anchor parameter row with no display sequence whose parameter ID does not appear in the linked-parameter view, so it is never injected into the run-time SQL.

**Q: Does a parameter listed by this report affect the output of the report?**
A: No. The description states that unlinked sub-rows are never injected into the run-time SQL and are harmless at run time, although they clutter the setup.

**Q: How do I limit the check to one group of reports?**
A: Enter the category in the Category parameter, and only the orphaned rows for reports in that category are returned.
