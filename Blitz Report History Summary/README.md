---
layout: default
last_modified_at: 2026-10-16
title: 'Blitz Report History Summary | Oracle EBS SQL Report'
description: 'Count and performance summary of historic Blitz Report executions – Oracle EBS Blitz Report SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, History, Summary, xxen_reports_v, xxen_report_runs'
permalink: /Blitz%20Report%20History%20Summary/
report_name: 'Blitz Report History Summary'
report_web_name: blitz-report-history-summary
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report History Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-history-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Count and performance summary of historic Blitz Report executions

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Name, Submitted By, Submitted within Days, Exclude System Reports, Exclude own Submissions

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)

## Related Reports
[Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report Execution Summary](/Blitz%20Report%20Execution%20Summary/ "Blitz Report Execution Summary Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20History%20Summary/Blitz%20Report%20History%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-history-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) |
| Blitz Report™ XML Import | [Blitz_Report_History_Summary.xml](https://www.enginatics.com/xml/blitz-report-history-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) |
| SQL Source | [Blitz Report History Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20History%20Summary/Blitz%20Report%20History%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-history-summary/](https://www.enginatics.com/reports/blitz-report-history-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary) |

## Case Study & Technical Analysis: Blitz Report History Summary

### Executive Summary
The Blitz Report History Summary is an administrative report that summarises how often each Blitz Report has been executed and how long those executions took. It is written for Blitz Report administrators and Oracle EBS system owners who need to understand which reports are used most, which take the longest, and who runs them. For each report it shows the number of runs, the average, maximum and total run time, the number of distinct users, and the most frequent user. It is part of the Blitz Report toolset rather than a finance or supply chain report, and it supports capacity planning and the decision of where to tune or retire reports.

### Business Challenge
*   **Knowing which reports matter:** Administrators need to see which reports are run most often before they change, retire or migrate them.
*   **Locating slow executions:** Long-running reports affect concurrent processing and user experience, and the maximum and total run time show where effort should go.
*   **Understanding adoption:** The number of distinct users per report shows whether a report serves one team or the whole organisation.
*   **Governance of usage:** Owners need to exclude system reports or their own test runs so that the statistics reflect real business use.

### The Solution
*   **Execution statistics per report:** The report counts completed runs for each report and computes average, maximum and total duration in seconds, which are then formatted as readable times.
*   **User analysis:** It counts the distinct submitting users and identifies the most frequent one, using the number of runs per user to rank them.
*   **Report classification:** Each report is returned with its type and category, so the summary can be grouped by function.
*   **Creator and update trail:** Created by and last updated by names, with their dates, are returned for every report.
*   **Spreadsheet analysis:** Running the report in Excel through Blitz Report lets administrators sort by count or duration and build their own pivots.

### Technical Architecture (High Level)
#### Primary Tables
*   `XXEN_REPORTS_V`: the view of Blitz Report definitions, supplying the report name, type, creation and update details.
*   `XXEN_REPORT_RUNS`: one row per report execution, holding the creation and completion dates, the completion message and the submitting user.

#### Logical Relationships
1. `XXEN_REPORTS_V` is joined to `XXEN_REPORT_RUNS` as an outer join on the report identifier, so reports with no runs are still eligible.
2. The inner query keeps only completed runs, those with a completion date and no completion message.
3. Duration is calculated as the difference between completion and creation date, multiplied by 86400 to give seconds.
4. Analytic functions partition by report identifier to produce the counts, averages, maxima, sums and distinct user counts.
5. The outer query collapses the analytic output to one row per report and orders the result by run count, with the highest first.

### Parameters & Filtering
*   **Report Name:** Restricts the summary to one Blitz Report by name.
*   **Submitted By:** Limits the runs counted to those submitted by one user.
*   **Submitted within Days:** Restricts the runs to those created within the given number of days, so the statistics reflect recent activity.
*   **Exclude System Reports:** When set, removes built-in reports from the summary so that only user-defined reports are counted.
*   **Exclude own Submissions:** When set, removes the runs submitted by the current user, so that an administrator's own testing does not distort the figures.

### Performance & Optimization
*   **Completed runs only:** The inner filter excludes runs without a completion date or with a completion message, so only meaningful durations are aggregated.
*   **Single-pass analytics:** Counts, averages, maxima and sums are computed by analytic functions over the same partition, so the report table is read once per aggregate rather than joined repeatedly.
*   **Most frequent user by ranking:** The most frequent user is found with a `keep (dense_rank last)` expression rather than a separate query, which keeps the summary to one statement.
*   **Scalar lookups for names:** User names are resolved through a function call, and the category is derived by a function for each report.

### FAQ
**Q: How do I see which Blitz Reports are run most often?**
A: Run Blitz Report History Summary and read the count column, which is sorted in descending order by default.

**Q: How is the average run time of a Blitz Report calculated?**
A: The duration of each completed run is the difference between its completion and creation dates in seconds, and the average is the sum of those durations divided by the number of runs.

**Q: Does the summary include my own test runs?**
A: Set Exclude own Submissions to Yes to remove the runs submitted by the current user from the statistics.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
