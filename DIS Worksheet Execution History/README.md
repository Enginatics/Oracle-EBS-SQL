---
layout: default
title: 'DIS Worksheet Execution History | Oracle EBS SQL Report'
description: 'Discoverer worksheet access statistics from table eul5qppstats, including folder objects used. Parameter ''Show Folder Details'' switches between aggregate…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, DIS, Worksheet, Execution, History, &restrict_to_latest_workbook1, table, eul5_objs'
permalink: /DIS%20Worksheet%20Execution%20History/
---

# DIS Worksheet Execution History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/dis-worksheet-execution-history/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Discoverer worksheet access statistics from table eul5_qpp_stats, including folder objects used.
Parameter 'Show Folder Details' switches between aggregate and list view of used folder objects.

## Report Parameters
Workbook, Submitted by User, Business Area, Folder, View Name, Object Use Key, Object Id, Accessed within Days, Start Date From, Start Date To, Latest Workbook only, Show Folder Details, End User Layer

## Oracle EBS Tables Used
[&restrict_to_latest_workbook1](https://www.enginatics.com/library/?pg=1&find=&restrict_to_latest_workbook1), [table](https://www.enginatics.com/library/?pg=1&find=table), [eul5_objs](https://www.enginatics.com/library/?pg=1&find=eul5_objs), [eul5_documents](https://www.enginatics.com/library/?pg=1&find=eul5_documents)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/ "DIS Workbooks, Folders, Items and LOVs Oracle EBS SQL Report"), [DIS Items, Folders and Formulas](/DIS%20Items-%20Folders%20and%20Formulas/ "DIS Items, Folders and Formulas Oracle EBS SQL Report"), [DIS Folders, Business Areas, Items and LOVs](/DIS%20Folders-%20Business%20Areas-%20Items%20and%20LOVs/ "DIS Folders, Business Areas, Items and LOVs Oracle EBS SQL Report"), [DIS Access Privileges](/DIS%20Access%20Privileges/ "DIS Access Privileges Oracle EBS SQL Report"), [ONT Orders](/ONT%20Orders/ "ONT Orders Oracle EBS SQL Report"), [DIS Workbook Export Script](/DIS%20Workbook%20Export%20Script/ "DIS Workbook Export Script Oracle EBS SQL Report"), [DIS Workbook Owner Export Script](/DIS%20Workbook%20Owner%20Export%20Script/ "DIS Workbook Owner Export Script Oracle EBS SQL Report"), [DIS Workbook Import Validation](/DIS%20Workbook%20Import%20Validation/ "DIS Workbook Import Validation Oracle EBS SQL Report"), [DIS Business Areas](/DIS%20Business%20Areas/ "DIS Business Areas Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [DIS Worksheet Execution History 04-Jan-2019 135450.xlsx](https://www.enginatics.com/example/dis-worksheet-execution-history/) |
| Blitz Report™ XML Import | [DIS_Worksheet_Execution_History.xml](https://www.enginatics.com/xml/dis-worksheet-execution-history/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/dis-worksheet-execution-history/](https://www.enginatics.com/reports/dis-worksheet-execution-history/) |

## DIS Worksheet Execution History

### Description
This report provides a historical log of Discoverer worksheet executions, offering detailed insights into user activity and system usage. It queries the `eul5_qpp_stats` table to retrieve access statistics, including which folders and objects were utilized during execution.

Features include:
- **Execution Log**: A chronological record of who ran which workbook and when.
- **Folder Usage**: Identifies the specific EUL folders accessed by each execution, useful for understanding data consumption patterns.
- **Drill-Down Capability**: The 'Show Folder Details' parameter allows users to switch between an aggregate view and a detailed list of used folder objects.

This history is valuable for auditing, performance tuning, and identifying obsolete or heavily used reports during a migration project.

### Parameters
- **Workbook**: Filter by workbook name.
- **Submitted by User**: Filter by the user who executed the report.
- **Business Area**: Filter by Discoverer Business Area.
- **Folder**: Filter by specific folder usage.
- **View Name**: Filter by underlying view name.
- **Object Use Key**: Filter by object key.
- **Object Id**: Filter by object ID.
- **Accessed within Days**: Limit history to a recent time window.
- **Start Date From/To**: Define a specific date range for the history.
- **Latest Workbook only**: Restrict results to the most recent version of workbooks.
- **Show Folder Details**: Toggle detailed folder usage information.
- **End User Layer**: Select the EUL to query.

### Used Tables
- `eul5_objs`: EUL objects (folders).
- `eul5_documents`: Discoverer workbook definitions.
- `eul5_qpp_stats`: Query execution statistics.

### Categories
- **Enginatics**: Usage analysis and auditing tool.

### Related Reports
- [DIS Workbooks, Folders, Items and LOVs](/DIS%20Workbooks-%20Folders-%20Items%20and%20LOVs/)


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
