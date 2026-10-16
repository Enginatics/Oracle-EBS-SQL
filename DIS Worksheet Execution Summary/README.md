---
layout: default
last_modified_at: 2026-10-16
title: 'DIS Worksheet Execution Summary | Oracle EBS SQL Report'
description: 'Discoverer worksheet access statistic summary from table eul5qppstats to show the number of active Discoverer users, number of different workbooks and…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Discoverer, Enginatics, DIS, Worksheet, Execution, Summary, eul5_qpp_stats'
permalink: /DIS%20Worksheet%20Execution%20Summary/
report_name: 'DIS Worksheet Execution Summary'
report_web_name: dis-worksheet-execution-summary
module: 'Discoverer'
module_url: /modules/discoverer/
---

# DIS Worksheet Execution Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-worksheet-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary).
**Oracle EBS module:** [Discoverer](/modules/discoverer/ "Oracle EBS Discoverer reports") · [all Discoverer reports](/modules/discoverer/)  

## Overview
Discoverer worksheet access statistic summary from table eul5_qpp_stats to show the number of active Discoverer users, number of different workbooks and worksheets executed and the number of different folder (combinations) that these are based on.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Workbook, Submitted by User, Business Area, Folder, View Name, Accessed within Days, Start Date From, Start Date To, End User Layer, Show User Details

## Oracle EBS Tables Used
[eul5_qpp_stats](https://www.enginatics.com/library/?pg=1&find=eul5_qpp_stats&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)

## Related Reports
[DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [DIS Converter Diagnostic Dump](/DIS%20Converter%20Diagnostic%20Dump/ "DIS Converter Diagnostic Dump Oracle EBS SQL Report"), [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report"), [DIS Worksheet Execution History](/DIS%20Worksheet%20Execution%20History/ "DIS Worksheet Execution History Oracle EBS SQL Report"), [DIS Users](/DIS%20Users/ "DIS Users Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Worksheet%20Execution%20Summary/DIS%20Worksheet%20Execution%20Summary.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Worksheet Execution Summary 07-Oct-2022 230941.xlsx](https://www.enginatics.com/example/dis-worksheet-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) |
| Blitz Report™ XML Import | [DIS_Worksheet_Execution_Summary.xml](https://www.enginatics.com/xml/dis-worksheet-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) |
| SQL Source | [DIS Worksheet Execution Summary.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/DIS%20Worksheet%20Execution%20Summary/DIS%20Worksheet%20Execution%20Summary.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/dis-worksheet-execution-summary/](https://www.enginatics.com/reports/dis-worksheet-execution-summary/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary) |

## DIS Worksheet Execution Summary

### Description
This report summarizes Discoverer usage statistics to provide a high-level view of system adoption and activity. It aggregates data from `eul5_qpp_stats` to show key metrics such as the number of active users, the variety of workbooks and worksheets being executed, and the diversity of underlying folders being accessed.

This summary is ideal for management reporting and capacity planning, helping administrators understand the scale of Discoverer usage and identify trends in user behavior. It complements detailed execution logs by providing the "big picture" of the reporting environment.

### Parameters
- **Workbook**: Filter statistics by workbook.
- **Submitted by User**: Filter by user.
- **Business Area**: Filter by Business Area.
- **Folder**: Filter by folder.
- **View Name**: Filter by view name.
- **Accessed within Days**: Limit the summary to recent activity.
- **Start Date From/To**: Define the date range for the summary.
- **End User Layer**: Select the EUL to analyze.
- **Show User Details**: Option to break down statistics by individual user.

### Used Tables
- `eul5_qpp_stats`: The primary source for query performance and usage statistics in Discoverer.

### Categories
- **Enginatics**: Management and usage reporting.

### Related Reports
- [DIS Access Privileges](/DIS%20Access%20Privileges/)
- [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/)

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=dis-worksheet-execution-summary)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
