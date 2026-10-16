---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Columns | Oracle EBS SQL Report'
description: 'Report showing all SQL columns of selected Blitz Reports by parsing their SQL on the fly. Use the Category or Report Name parameters to scope the results…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Columns, xxen_report_sql_columns, xxen_reports_v'
permalink: /Blitz%20Report%20Columns/
report_name: 'Blitz Report Columns'
report_web_name: blitz-report-columns
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Columns – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Report showing all SQL columns of selected Blitz Reports by parsing their SQL on the fly.
Use the Category or Report Name parameters to scope the results. Running without filters will parse all enabled reports, which may take several minutes.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Category, Report Type, Report Name, Report Name like, Column Header contains

## Oracle EBS Tables Used
[xxen_report_sql_columns](https://www.enginatics.com/library/?pg=1&find=xxen_report_sql_columns&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)

## Related Reports
[Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Upload Dependencies](/Blitz%20Upload%20Dependencies/ "Blitz Upload Dependencies Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Columns/Blitz%20Report%20Columns.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Columns 27-Feb-2026 050200.xlsx](https://www.enginatics.com/example/blitz-report-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) |
| Blitz Report™ XML Import | [Blitz_Report_Columns.xml](https://www.enginatics.com/xml/blitz-report-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) |
| SQL Source | [Blitz Report Columns.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Columns/Blitz%20Report%20Columns.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-columns/](https://www.enginatics.com/reports/blitz-report-columns/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns) |

## Case Study & Technical Analysis: Blitz Report Columns

### Executive Summary
Blitz Report Columns is a metadata report for the Blitz Report™ library itself. It lists every SQL column of the Blitz Reports held in an Oracle EBS instance, with the column position, the translated column header, the underlying column alias and the Oracle data type. It is written for Blitz Report administrators, report developers and EBS technical consultants who maintain or review a library of Excel-based reports and need to find which report exposes a given field, or which reports share a column header. The report supports the governance task of documenting and auditing report content before reports are shared, changed or retired.

### Business Challenge
*   **Report Discovery:** A large library of reports makes it hard to locate the report that returns a particular field, such as a specific flexfield or status code.
*   **Inconsistent Headers:** Reports built by different developers may label the same underlying column with different headers, which confuses users comparing outputs.
*   **Change Impact:** Before altering a shared SQL pattern, the team needs to know every report that exposes the affected column.
*   **Documentation Gaps:** Column-level documentation for report libraries is rarely maintained by hand, so a generated listing is the only reliable inventory.

### The Solution
*   **Parsing On The Fly:** The report reads the stored SQL of each Blitz Report and derives its column list at run time rather than relying on a manually kept document.
*   **Report Context:** Each row is joined to its report name, its category and a type value that shows whether the item is a report or another Blitz object type.
*   **Header Translation:** The column header is resolved through the Blitz Report column translation function, so the header shown matches what end users see in Excel.
*   **Scoped Filtering:** Category, Report Type, Report Name, a name pattern and a column header search narrow the result to the reports under review.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORTS_V`: the view of Blitz Reports that supplies the report name, the report type and the report identifier used for the join.
*   `XXEN_REPORT_SQL_COLUMNS`: the table holding one row per column of each report's SQL, with the column number, the column name and the data type.

#### Logical Relationships
1.  `XXEN_REPORT_SQL_COLUMNS` is joined to `XXEN_REPORTS_V` on the report identifier, so every column row carries its report name and type.
2.  The category of each report is derived from the report identifier through the Blitz Report API category function.
3.  The column header is produced from the stored column name through the column translation function, while the lower case column name is returned alongside it.
4.  Rows are ordered by report name and then by column number, so each report's columns appear in their SQL sequence.

### Parameters & Filtering
*   **Category:** Restricts the output to reports in the selected Blitz Report category.
*   **Report Type:** Limits the result to one type value. Reports with no type are shown as Report.
*   **Report Name:** Selects one specific report by its exact name.
*   **Report Name like:** Applies a pattern match to the report name, useful for a family of related reports.
*   **Column Header contains:** Filters on the translated column header, so a search for a field label returns every report that displays it.

### Performance & Optimization
*   **Parsing Cost:** The report parses SQL text for each report in scope. Running it with no filters processes every enabled report and can take several minutes, so scoping by Category or Report Name is the recommended approach.
*   **Predicate Placement:** Filters are applied to the report view, so the parse is limited to reports that pass the selection before the column rows are returned.
*   **Simple Structure:** The statement is a single join with an order by and no aggregation, so the cost is dominated by the number of reports and columns rather than by query complexity.

### FAQ
**Q: How do I find every Blitz Report that shows a particular column header?**
A: Enter the header text in the Column Header contains parameter. The report returns each matching column with its report name and column number.

**Q: Why does the report take several minutes to run?**
A: With no parameters it parses the SQL of every enabled report. Set Category or Report Name to reduce the number of reports that are parsed.

**Q: Does the output show the data type of each column?**
A: Yes. Each row includes the data type of the column as stored in the report's SQL column definition.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-columns)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
