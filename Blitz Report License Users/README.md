---
layout: default
title: 'Blitz Report License Users | Oracle EBS SQL Report'
description: 'Currently active Blitz Report users (running reports within the past 60 days) and their most frequently executeds reports.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, License, Users, xxen_report_license_users, fnd_user, xxen_report_runs'
permalink: /Blitz%20Report%20License%20Users/
---

# Blitz Report License Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-license-users/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Currently active Blitz Report users (running reports within the past 60 days) and their most frequently executeds reports.

## Report Parameters
User Count from

## Oracle EBS Tables Used
[xxen_report_license_users](https://www.enginatics.com/library/?pg=1&find=xxen_report_license_users), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report Execution Summary](/Blitz%20Report%20Execution%20Summary/ "Blitz Report Execution Summary Oracle EBS SQL Report"), [Blitz Upload History](/Blitz%20Upload%20History/ "Blitz Upload History Oracle EBS SQL Report"), [Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [Blitz Report License User History](/Blitz%20Report%20License%20User%20History/ "Blitz Report License User History Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [Blitz Upload Data](/Blitz%20Upload%20Data/ "Blitz Upload Data Oracle EBS SQL Report"), [FND Applications](/FND%20Applications/ "FND Applications Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report License Users 24-Sep-2023 232317.xlsx](https://www.enginatics.com/example/blitz-report-license-users/) |
| Blitz Report™ XML Import | [Blitz_Report_License_Users.xml](https://www.enginatics.com/xml/blitz-report-license-users/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-license-users/](https://www.enginatics.com/reports/blitz-report-license-users/) |

## Blitz Report License Users - Case Study & Technical Analysis

### Executive Summary

**Blitz Report License Users** is a current-state compliance report. It lists the specific users who are currently considered "active" for licensing purposes (typically defined as having run a report in the last 60 days). It also provides insight into their usage patterns by showing their most frequently executed reports.

### Business Challenge

*   **License Management:** Identifying exactly *who* is consuming a license.
*   **Cost Optimization:** Finding users who have a license but barely use it (e.g., ran one report 59 days ago).
*   **User Profiling:** Understanding what the "Power Users" are actually doing.

### Solution

This report joins the user table with the execution logs and the license definition logic.

*   **Active List:** Provides the names of all active users.
*   **Top Reports:** Shows what each user is running most often.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORT_LICENSE_USERS`:** A view or table that encapsulates the logic for determining who counts as a licensed user.
*   **`XXEN_REPORT_RUNS`:** Execution history.

#### Logic

The query filters for users with activity in the defined window (e.g., `sysdate - 60`) and aggregates their run history to find the top reports.

### Parameters

*   (None listed, likely a system snapshot).


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
