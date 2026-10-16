---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Discoverer and Blitz Report Users | Oracle EBS SQL Report'
description: 'Shows the user adoption for companies replacing Discoverer with Blitz Report in a phased approach. The report shows the number of Discoverer worksheets…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Blitz, Report, fnd_user, eul5_qpp_stats, xxen_report_runs'
permalink: /DIS%20Discoverer%20and%20Blitz%20Report%20Users/
report_name: 'DIS Discoverer and Blitz Report Users'
report_web_name: dis-discoverer-and-blitz-report-users
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Discoverer and Blitz Report Users – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-discoverer-and-blitz-report-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Shows the user adoption for companies replacing Discoverer with Blitz Report in a phased approach.
The report shows the number of Discoverer worksheets and Blitz Report executed every month per user, to help identifying the users still using Discoverer instead of Blitz Report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Accessed within Days, Accessed After, End User Layer

## Oracle EBS Tables Used
[fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users), [eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users), [xxen_report_runs](https://www.enginatics.com/library/?pg=1&find=xxen_report_runs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)

## Related Reports
[DIS Workbook Conversion Selection](/DIS%20Workbook%20Conversion%20Selection/ "DIS Workbook Conversion Selection Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Discoverer%20and%20Blitz%20Report%20Users/DIS%20Discoverer%20and%20Blitz%20Report%20Users.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Discoverer and Blitz Report Users 14-Jan-2024 195259.xlsx](https://www.enginatics.com/example/dis-discoverer-and-blitz-report-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) |
| Blitz Report™ XML Import | [DIS_Discoverer_and_Blitz_Report_Users.xml](https://www.enginatics.com/xml/dis-discoverer-and-blitz-report-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) |
| SQL Source | [DIS Discoverer and Blitz Report Users.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Discoverer%20and%20Blitz%20Report%20Users/DIS%20Discoverer%20and%20Blitz%20Report%20Users.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-discoverer-and-blitz-report-users/](https://www.enginatics.com/reports/dis-discoverer-and-blitz-report-users/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users) |

## Case Study & Technical Analysis

### Abstract
The **DIS Discoverer and Blitz Report Users** report is a strategic migration tool designed for organizations transitioning from Oracle Discoverer to Blitz Report. It provides a comparative view of user adoption, tracking the number of reports executed in both systems over time. This helps project managers monitor the "sunset" of Discoverer and the uptake of the new solution.

### Technical Analysis

#### Core Logic
*   **Discoverer Usage**: Queries `EUL5_QPP_STATS` to count worksheet executions per user/month.
*   **Blitz Report Usage**: Queries `XXEN_REPORT_RUNS` (implied context) to count Blitz Report executions.
*   **Comparison**: Aligns the data by user and period to show trends.

#### Key Tables
*   `FND_USER`: The master list of application users.
*   `EUL5_QPP_STATS`: The source of Discoverer usage history.

#### Operational Use Cases
*   **Adoption Tracking**: "Are users actually running the new Blitz Reports we built for them?"
*   **Intervention**: Identifying users who are exclusively using Discoverer and may need additional training or support.
*   **Decommissioning**: Determining when Discoverer usage has dropped low enough to justify turning off the server.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-discoverer-and-blitz-report-users)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
