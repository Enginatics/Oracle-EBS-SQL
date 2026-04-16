---
layout: default
title: 'Blitz Report User History | Oracle EBS SQL Report'
description: 'Lists all active EBS users with their active responsibilities and blitz report execution counts. The report can be used to analyze blitz report usage…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, User, History, fnd_user, fnd_user_resp_groups, fnd_responsibility_vl'
permalink: /Blitz%20Report%20User%20History/
---

# Blitz Report User History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-user-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Lists all active EBS users with their active responsibilities and blitz report execution counts.
The report can be used to analyze blitz report usage within the EBS user community e.g. to find the most active users or to spot the ones not using blitz report to it's full potential yet.

## Report Parameters
Last Logon Date within x days, Executions within x days

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [fnd_user_resp_groups](https://www.enginatics.com/library/?pg=1&find=fnd_user_resp_groups), [fnd_responsibility_vl](https://www.enginatics.com/library/?pg=1&find=fnd_responsibility_vl), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl), [fnd_request_groups](https://www.enginatics.com/library/?pg=1&find=fnd_request_groups), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[Blitz Report Assignments and Responsibilities](/Blitz%20Report%20Assignments%20and%20Responsibilities/ "Blitz Report Assignments and Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access 11i](/FND%20Responsibility%20Access%2011i/ "FND Responsibility Access 11i Oracle EBS SQL Report"), [FND Responsibilities](/FND%20Responsibilities/ "FND Responsibilities Oracle EBS SQL Report"), [FND Responsibility Access](/FND%20Responsibility%20Access/ "FND Responsibility Access Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Inventory Organization Summary](/CAC%20Inventory%20Organization%20Summary/ "CAC Inventory Organization Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report User History 10-Nov-2020 205738.xlsx](https://www.enginatics.com/example/blitz-report-user-history/) |
| Blitz Report™ XML Import | [Blitz_Report_User_History.xml](https://www.enginatics.com/xml/blitz-report-user-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/blitz-report-user-history/](https://www.enginatics.com/reports/blitz-report-user-history/) |

## Executive Summary
The Blitz Report User History report is an analytical tool designed to track and evaluate user engagement with Blitz Reports in the Oracle E-Business Suite. It provides a detailed list of active users, their responsibilities, and the number of Blitz Reports they have executed, offering valuable insights into adoption and usage patterns.

## Business Challenge
Understanding how users interact with reporting tools is crucial for maximizing the return on investment in software like Blitz Report. Organizations often struggle to identify which users are actively leveraging the tool and which may need additional training or support. Without this visibility, it is difficult to drive adoption, optimize license usage, or ensure that the reporting capabilities are being utilized to their full potential.

## Solution
The Blitz Report User History report addresses this challenge by aggregating usage data into a clear and actionable format. It lists active EBS users along with their assigned responsibilities and execution counts for Blitz Reports. This allows administrators and managers to pinpoint power users, identify underutilized accounts, and tailor training programs to improve overall efficiency.

## Key Features
*   **Usage Analysis:** Tracks the number of Blitz Report executions per user.
*   **User & Responsibility Mapping:** Lists active users alongside their active responsibilities.
*   **Time-Based Filtering:** Includes parameters to filter by "Last Logon Date" and "Executions within x days" for targeted analysis.
*   **Adoption Insights:** Helps identify active users and those who may require further engagement.

## Technical Details
The report queries standard Oracle FND tables such as `fnd_user`, `fnd_user_resp_groups`, `fnd_responsibility_vl`, `fnd_application_vl`, and `fnd_request_groups`, as well as the Blitz Report specific table `xxen_report_runs`. This combination of data sources ensures a comprehensive view of user activity and report execution history.


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
