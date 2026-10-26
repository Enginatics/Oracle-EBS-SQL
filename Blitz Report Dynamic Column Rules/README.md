---
layout: default
last_modified_at: 2026-10-26
title: 'Blitz Report Dynamic Column Rules | Oracle EBS SQL Report'
description: 'Oracle EBS Blitz Report SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Dynamic, Column, xxen_report_dyn_col_rule_rpts, xxen_report_dynamic_col_rules, xxen_reports_v'
permalink: /Blitz%20Report%20Dynamic%20Column%20Rules/
report_name: 'Blitz Report Dynamic Column Rules'
report_web_name: blitz-report-dynamic-column-rules
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Dynamic Column Rules – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-dynamic-column-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview


> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Rule Name, Report Name, Category, Enabled

## Oracle EBS Tables Used
[xxen_report_dyn_col_rule_rpts](https://www.enginatics.com/library/?pg=1&find=xxen_report_dyn_col_rule_rpts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules), [xxen_report_dynamic_col_rules](https://www.enginatics.com/library/?pg=1&find=xxen_report_dynamic_col_rules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [ZX US Sales Tax](/ZX%20US%20Sales%20Tax/ "ZX US Sales Tax Oracle EBS SQL Report"), [QP Price List Upload](/QP%20Price%20List%20Upload/ "QP Price List Upload Oracle EBS SQL Report"), [CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [ONT Order Upload](/ONT%20Order%20Upload/ "ONT Order Upload Oracle EBS SQL Report"), [PN Billing/Payment Term Upload](/PN%20Billing-Payment%20Term%20Upload/ "PN Billing/Payment Term Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Dynamic%20Column%20Rules/Blitz%20Report%20Dynamic%20Column%20Rules.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-dynamic-column-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) |
| Blitz Report™ XML Import | [Blitz_Report_Dynamic_Column_Rules.xml](https://www.enginatics.com/xml/blitz-report-dynamic-column-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) |
| SQL Source | [Blitz Report Dynamic Column Rules.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Dynamic%20Column%20Rules/Blitz%20Report%20Dynamic%20Column%20Rules.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-dynamic-column-rules/](https://www.enginatics.com/reports/blitz-report-dynamic-column-rules/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules) |

## Case Study & Technical Analysis: Blitz Report Dynamic Column Rules

### Executive Summary
The Blitz Report Dynamic Column Rules report lists every dynamic column rule defined in the Blitz Report configuration, together with the reports each rule is assigned to. It is an administration report for the Blitz Report library owners and for DBAs who maintain the reporting framework. It shows whether each rule is enabled, the SQL that the rule evaluates, who created and last changed it, and how many reports depend on it. The report runs in Excel through Blitz Report, so the rule inventory can be filtered, sorted and reviewed before a rule is changed or retired.

### Business Challenge
*   **Rule inventory:** Dynamic column rules are attached to many reports, and without a single listing it is hard to see which reports a rule affects before it is edited.
*   **Change accountability:** Administrators need to know who created, assigned and last updated each rule, and when, to support change control.
*   **Enablement control:** A disabled rule must be identifiable quickly, because it silently stops changing the columns of the reports that depend on it.
*   **Assignment hygiene:** Assignments made by different users need to be traced to the rule and the report they link.

### The Solution
*   **Rule and assignment join:** The report joins each rule to its report assignments and to the report catalogue, so one row shows a rule against a single report.
*   **Dependency count:** A correlated count gives the number of reports assigned to each rule.
*   **Audit fields:** Creator, last updater and timestamps are resolved to readable user names and client times for both the rule and the assignment.
*   **Filtering:** Rule name, report name, category and enabled status can be filtered, and the output is ordered by rule name and report name.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORT_DYNAMIC_COL_RULES`: the rule definitions, including the rule name, enabled flag and the rule SQL.
*   `XXEN_REPORT_DYN_COL_RULE_RPTS`: the assignments that link a rule to a report.
*   `XXEN_REPORTS_V`: the report catalogue, supplying the report name, category and report type.

#### Logical Relationships
1.  Each rule in `XXEN_REPORT_DYNAMIC_COL_RULES` is matched to its assignments in `XXEN_REPORT_DYN_COL_RULE_RPTS` on the rule ID, using an outer join so that unassigned rules still appear.
2.  Each assignment is matched to the report catalogue in `XXEN_REPORTS_V` on the report ID, again as an outer join.
3.  A correlated subquery on the assignment table counts the reports for each rule.
4.  The output is ordered by rule name and then by report name.

### Parameters & Filtering
*   **Rule Name:** limits the output to rules with a matching name.
*   **Report Name:** limits the output to rules assigned to a matching report.
*   **Category:** limits the output to reports in the selected category.
*   **Enabled:** shows only enabled or only disabled rules, matching the enabled flag of the rule.

### Performance & Optimization
*   The report reads only the rule, assignment and report catalogue views, so it does not touch the report data tables that the rules affect.
*   The dependency count is a scalar subquery keyed on the rule ID, so each rule is counted once against the assignment table.
*   Outer joins keep unassigned rules in the result without a second query.
*   Audit names and times are produced by `XXEN_UTIL` helper functions, which keeps the SQL short and consistent with the other Blitz Report administration reports.

### FAQ
**Q: How can I see which reports use a dynamic column rule?**
A: Filter by Rule Name or review the rows for that rule, each of which shows one assigned report, and the Report Count column gives the total.

**Q: Who last changed a dynamic column rule?**
A: The Rule Last Updated By and Rule Last Update Date columns show the user name and client time of the last update to the rule.

**Q: How do I find disabled rules?**
A: Use the Enabled parameter to filter on the rule's enabled flag, or review the Enabled column, which displays the flag as Yes or No.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-dynamic-column-rules)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
