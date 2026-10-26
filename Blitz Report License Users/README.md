---
layout: default
last_modified_at: 2026-10-26
title: 'Blitz Report License Users | Oracle EBS SQL Report'
description: 'Currently active Blitz Report users (running reports within the past 60 days) and their most frequently executeds reports.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, License, Users, xxen_report_license_users, fnd_user, xxen_report_runs'
permalink: /Blitz%20Report%20License%20Users/
report_name: 'Blitz Report License Users'
report_web_name: blitz-report-license-users
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report License Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-license-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Currently active Blitz Report users (running reports within the past 60 days) and their most frequently executeds reports.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
User Count from

## Oracle EBS Tables Used
[xxen_report_license_users](https://www.enginatics.com/library/?pg=1&find=xxen_report_license_users&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users), [xxen_reports_v](https://www.enginatics.com/library/?pg=1&find=xxen_reports_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)

## Related Reports
[Blitz Report Execution Summary](/Blitz%20Report%20Execution%20Summary/ "Blitz Report Execution Summary Oracle EBS SQL Report"), [Blitz Report History Summary](/Blitz%20Report%20History%20Summary/ "Blitz Report History Summary Oracle EBS SQL Report"), [Blitz Report Assignment Upload](/Blitz%20Report%20Assignment%20Upload/ "Blitz Report Assignment Upload Oracle EBS SQL Report"), [Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [Blitz Report Template Sharing](/Blitz%20Report%20Template%20Sharing/ "Blitz Report Template Sharing Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20License%20Users/Blitz%20Report%20License%20Users.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report License Users 24-Sep-2023 232317.xlsx](https://www.enginatics.com/example/blitz-report-license-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) |
| Blitz Report™ XML Import | [Blitz_Report_License_Users.xml](https://www.enginatics.com/xml/blitz-report-license-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) |
| SQL Source | [Blitz Report License Users.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20License%20Users/Blitz%20Report%20License%20Users.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-license-users/](https://www.enginatics.com/reports/blitz-report-license-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-license-users)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
