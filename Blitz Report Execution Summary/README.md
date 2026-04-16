---
layout: default
title: 'Blitz Report Execution Summary | Oracle EBS SQL Report'
description: 'Count and performance summary of historic Blitz Report executions – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Execution, Summary, xxen_reports_v, xxen_report_runs'
permalink: /Blitz%20Report%20Execution%20Summary/
---

# Blitz Report Execution Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-execution-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Count and performance summary of historic Blitz Report executions

## Report Parameters
Report Name, Submitted By, Submitted within Days, Exclude System Reports, Exclude own Submissions

## Oracle EBS Tables Used
[xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [Blitz Report License Users](/Blitz%20Report%20License%20Users/ "Blitz Report License Users Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [DIS Discoverer and Blitz Report Users](/DIS%20Discoverer%20and%20Blitz%20Report%20Users/ "DIS Discoverer and Blitz Report Users Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Execution Summary 24-Jul-2017 145940.xlsx](https://www.enginatics.com/example/blitz-report-execution-summary/) |
| Blitz Report™ XML Import | [Blitz_Report_Execution_Summary.xml](https://www.enginatics.com/xml/blitz-report-execution-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-execution-summary/](https://www.enginatics.com/reports/blitz-report-execution-summary/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
