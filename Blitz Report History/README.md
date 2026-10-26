---
layout: default
last_modified_at: 2026-10-26
title: 'Blitz Report History | Oracle EBS SQL Report'
description: 'History of Blitz Report executions – Oracle EBS Blitz Report SQL report: free SQL, parameters and tables used.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, History, xxen_reports_h, fnd_concurrent_requests, xxen_report_runs'
permalink: /Blitz%20Report%20History/
report_name: 'Blitz Report History'
report_web_name: blitz-report-history
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
History of Blitz Report executions

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Name, Category, Type, Report Name starts with, Submitted by User, Started within Days, Start Date From, Start Date To, Show Parameters, Running or Errored, Running longer than x Minutes, Request Id, Run Id, Exclude System Reports, Exclude Submissions from User, License Exceeded, Incremental Alert Mode

## Oracle EBS Tables Used
[xxen_reports_h](https://www.enginatics.com/library/?pg=1&find=xxen_reports_h&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [fnd_concurrent_requests](https://www.enginatics.com/library/?pg=1&find=fnd_concurrent_requests&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [fnd_responsibility_tl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [gv$session](https://www.enginatics.com/library/?pg=1&find=gv%24session&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history), [xxen_report_run_param_values](https://www.enginatics.com/library/?pg=1&find=xxen_report_run_param_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)

## Related Reports
[Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [DBA ORDS Configuration Validation](/DBA%20ORDS%20Configuration%20Validation/ "DBA ORDS Configuration Validation Oracle EBS SQL Report"), [DBA Sessions](/DBA%20Sessions/ "DBA Sessions Oracle EBS SQL Report"), [FND Concurrent Requests](/FND%20Concurrent%20Requests/ "FND Concurrent Requests Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20History/Blitz%20Report%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/blitz-report-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) |
| Blitz Report™ XML Import | [Blitz_Report_History.xml](https://www.enginatics.com/xml/blitz-report-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) |
| SQL Source | [Blitz Report History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20History/Blitz%20Report%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-history/](https://www.enginatics.com/reports/blitz-report-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history) |

## Blitz Report History - Case Study & Technical Analysis

### Executive Summary

**Blitz Report History** is the detailed transaction log of the Blitz Report system. Unlike the "Execution Summary" which aggregates data, this report lists individual execution records. It is the primary tool for troubleshooting specific failed runs, auditing user activity, and analyzing performance at a granular level.

### Business Challenge

*   **Troubleshooting:** "My report failed yesterday at 2 PM." The admin uses this report to find that specific run, see the error message, and view the parameters used.
*   **Security Audit:** "Who ran the 'Salary Detail' report last week?"
*   **Performance Analysis:** Identifying exactly which run of a report took 2 hours instead of the usual 2 minutes (e.g., due to a specific parameter combination).

### Solution

This report provides a comprehensive view of the `XXEN_REPORT_RUNS` table, often joined with Oracle's standard concurrent request tables.

*   **Status:** Shows if a report is Running, Completed, or Errored.
*   **Parameters:** Can optionally show the specific parameters used for each run (`Show Parameters`).
*   **SQL Snapshot:** Some versions might link to the specific SQL used at runtime.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORT_RUNS`:** The core execution log.
*   **`FND_CONCURRENT_REQUESTS`:** Links the Blitz Report run to the standard Oracle Concurrent Manager request ID.
*   **`XXEN_REPORT_RUN_PARAM_VALUES`:** Stores the parameter values entered by the user for that specific run.

#### Logic

The query lists execution records, sorted by start date. It includes logic to decode the status and link to the user and responsibility context.

### Parameters

*   **Report Name / Category / Type:** Standard filters.
*   **Submitted by User:** Audit specific users.
*   **Started within Days / Date Range:** Time window.
*   **Show Parameters:** A toggle to include the parameter string in the output (can make the report wider/slower but essential for debugging).
*   **Running or Errored:** Filter to focus on problem areas.
*   **Request Id / Run Id:** Search for a specific transaction.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
