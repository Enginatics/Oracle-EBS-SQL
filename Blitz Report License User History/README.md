---
layout: default
last_modified_at: 2026-10-19
title: 'Blitz Report License User History | Oracle EBS SQL Report'
description: 'Shows the history of active Blitz Report users at every at every month end, looking back the past 60 days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, License, User, dual, xxen_report_runs, fnd_user'
permalink: /Blitz%20Report%20License%20User%20History/
report_name: 'Blitz Report License User History'
report_web_name: blitz-report-license-user-history
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report License User History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-license-user-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Shows the history of active Blitz Report users at every at every month end, looking back the past 60 days.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)

## Related Reports
[Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Report License Users](/Blitz%20Report%20License%20Users/ "Blitz Report License Users Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [Blitz Report Web Service Sessions](/Blitz%20Report%20Web%20Service%20Sessions/ "Blitz Report Web Service Sessions Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20License%20User%20History/Blitz%20Report%20License%20User%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report License User History 15-Mar-2024 212941.xlsx](https://www.enginatics.com/example/blitz-report-license-user-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) |
| Blitz Report™ XML Import | [Blitz_Report_License_User_History.xml](https://www.enginatics.com/xml/blitz-report-license-user-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) |
| SQL Source | [Blitz Report License User History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20License%20User%20History/Blitz%20Report%20License%20User%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-license-user-history/](https://www.enginatics.com/reports/blitz-report-license-user-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history) |

## Blitz Report License User History - Case Study & Technical Analysis

### Executive Summary

**Blitz Report License User History** is a compliance and usage tracking report. It tracks the number of active Blitz Report users over time, typically providing a snapshot at each month-end. This is used to monitor license compliance (if the license is user-based) and to understand adoption trends.

### Business Challenge

*   **License Compliance:** Ensuring the organization is within its purchased user limit.
*   **Trend Analysis:** Is usage growing? Do we need to purchase more licenses next year?
*   **Cost Allocation:** Potentially charging back costs to departments based on their active user count.

### Solution

This report calculates the "Active Users" metric historically.

*   **Lookback:** The description mentions "looking back the past 60 days," suggesting it counts users who have run at least one report in that window as "active."
*   **Monthly Snapshots:** It provides a trend line rather than just a current snapshot.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORT_RUNS`:** The source of activity data.
*   **`FND_USER`:** To identify the users.
*   **`DUAL`:** Likely used to generate the timeline (months).

#### Logic

The query likely generates a series of dates (month ends) and for each date, counts the distinct users who appeared in `XXEN_REPORT_RUNS` in the preceding period (e.g., 60 days).

### Parameters

*   (None listed, likely runs automatically for the system history).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-user-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
