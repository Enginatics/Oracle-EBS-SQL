# Case Study & Technical Analysis: Blitz Report Dynamic Column Rules

## Executive Summary
The Blitz Report Dynamic Column Rules report lists every dynamic column rule defined in the Blitz Report configuration, together with the reports each rule is assigned to. It is an administration report for the Blitz Report library owners and for DBAs who maintain the reporting framework. It shows whether each rule is enabled, the SQL that the rule evaluates, who created and last changed it, and how many reports depend on it. The report runs in Excel through Blitz Report, so the rule inventory can be filtered, sorted and reviewed before a rule is changed or retired.

## Business Challenge
*   **Rule inventory:** Dynamic column rules are attached to many reports, and without a single listing it is hard to see which reports a rule affects before it is edited.
*   **Change accountability:** Administrators need to know who created, assigned and last updated each rule, and when, to support change control.
*   **Enablement control:** A disabled rule must be identifiable quickly, because it silently stops changing the columns of the reports that depend on it.
*   **Assignment hygiene:** Assignments made by different users need to be traced to the rule and the report they link.

## The Solution
*   **Rule and assignment join:** The report joins each rule to its report assignments and to the report catalogue, so one row shows a rule against a single report.
*   **Dependency count:** A correlated count gives the number of reports assigned to each rule.
*   **Audit fields:** Creator, last updater and timestamps are resolved to readable user names and client times for both the rule and the assignment.
*   **Filtering:** Rule name, report name, category and enabled status can be filtered, and the output is ordered by rule name and report name.

## Technical Architecture (High Level)
### Primary Tables
*   `XXEN_REPORT_DYNAMIC_COL_RULES`: the rule definitions, including the rule name, enabled flag and the rule SQL.
*   `XXEN_REPORT_DYN_COL_RULE_RPTS`: the assignments that link a rule to a report.
*   `XXEN_REPORTS_V`: the report catalogue, supplying the report name, category and report type.

### Logical Relationships
1.  Each rule in `XXEN_REPORT_DYNAMIC_COL_RULES` is matched to its assignments in `XXEN_REPORT_DYN_COL_RULE_RPTS` on the rule ID, using an outer join so that unassigned rules still appear.
2.  Each assignment is matched to the report catalogue in `XXEN_REPORTS_V` on the report ID, again as an outer join.
3.  A correlated subquery on the assignment table counts the reports for each rule.
4.  The output is ordered by rule name and then by report name.

## Parameters & Filtering
*   **Rule Name:** limits the output to rules with a matching name.
*   **Report Name:** limits the output to rules assigned to a matching report.
*   **Category:** limits the output to reports in the selected category.
*   **Enabled:** shows only enabled or only disabled rules, matching the enabled flag of the rule.

## Performance & Optimization
*   The report reads only the rule, assignment and report catalogue views, so it does not touch the report data tables that the rules affect.
*   The dependency count is a scalar subquery keyed on the rule ID, so each rule is counted once against the assignment table.
*   Outer joins keep unassigned rules in the result without a second query.
*   Audit names and times are produced by `XXEN_UTIL` helper functions, which keeps the SQL short and consistent with the other Blitz Report administration reports.

## FAQ
**Q: How can I see which reports use a dynamic column rule?**
A: Filter by Rule Name or review the rows for that rule, each of which shows one assigned report, and the Report Count column gives the total.

**Q: Who last changed a dynamic column rule?**
A: The Rule Last Updated By and Rule Last Update Date columns show the user name and client time of the last update to the rule.

**Q: How do I find disabled rules?**
A: Use the Enabled parameter to filter on the rule's enabled flag, or review the Enabled column, which displays the flag as Yes or No.
