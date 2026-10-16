---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report Execution Summary | Oracle EBS SQL Report'
description: 'Count and performance summary of historic Blitz Report executions – Oracle EBS Blitz Report SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Execution, Summary, xxen_reports_v, xxen_report_runs'
permalink: /Blitz%20Report%20Execution%20Summary/
report_name: 'Blitz Report Execution Summary'
report_web_name: blitz-report-execution-summary
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Execution Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Count and performance summary of historic Blitz Report executions

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Name, Submitted By, Submitted within Days, Exclude System Reports, Exclude own Submissions

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)

## Related Reports
[Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [Blitz Report History Summary](/Blitz%20Report%20History%20Summary/ "Blitz Report History Summary Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Execution%20Summary/Blitz%20Report%20Execution%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Execution Summary 24-Jul-2017 145940.xlsx](https://www.enginatics.com/example/blitz-report-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) |
| Blitz Report™ XML Import | [Blitz_Report_Execution_Summary.xml](https://www.enginatics.com/xml/blitz-report-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) |
| SQL Source | [Blitz Report Execution Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Execution%20Summary/Blitz%20Report%20Execution%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-execution-summary/](https://www.enginatics.com/reports/blitz-report-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary) |

## Blitz Report Execution Summary - Case Study & Technical Analysis

### Executive Summary

**Blitz Report Execution Summary** is a performance and usage analytics report. It provides high-level statistics on how often reports are run and how they perform. This is essential for identifying the most popular reports (candidates for optimization) and the most resource-intensive reports (candidates for tuning).

### Business Challenge

*   **Performance Tuning:** Which reports are consuming the most database resources?
*   **Adoption Tracking:** Are users actually using the new "Inventory Aging" report we built?
*   **Cleanup:** Which reports have not been run in the last year and can be retired?

### Solution

This report aggregates execution data from the `XXEN_REPORT_RUNS` table.

*   **Counts:** Shows the total number of executions per report.
*   **Performance:** Likely shows average run times or total duration.
*   **User Activity:** Can be filtered to see who is submitting the most reports.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORTS_V`:** Report definitions.
*   **`XXEN_REPORT_RUNS`:** The log table recording every execution of a Blitz Report.

#### Logic

The query groups by Report Name (and potentially User) and calculates counts and averages.

### Parameters

*   **Report Name:** Filter for a specific report.
*   **Submitted By:** Filter by user.
*   **Submitted within Days:** Time window for the analysis (e.g., last 30 days).
*   **Exclude System Reports:** Hide internal Blitz Report maintenance jobs.
*   **Exclude own Submissions:** Filter out the administrator's own tests.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-execution-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
