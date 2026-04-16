---
layout: default
title: 'Blitz Report License User History | Oracle EBS SQL Report'
description: 'Shows the history of active Blitz Report users at every at every month end, looking back the past 60 days.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, License, User, dual, xxen_report_runs, fnd_user'
permalink: /Blitz%20Report%20License%20User%20History/
---

# Blitz Report License User History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-license-user-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Shows the history of active Blitz Report users at every at every month end, looking back the past 60 days.

## Report Parameters


## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Report License Users](/Blitz%20Report%20License%20Users/ "Blitz Report License Users Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report"), [Blitz Report Execution Summary](/Blitz%20Report%20Execution%20Summary/ "Blitz Report Execution Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report License User History 15-Mar-2024 212941.xlsx](https://www.enginatics.com/example/blitz-report-license-user-history/) |
| Blitz Report™ XML Import | [Blitz_Report_License_User_History.xml](https://www.enginatics.com/xml/blitz-report-license-user-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-license-user-history/](https://www.enginatics.com/reports/blitz-report-license-user-history/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
