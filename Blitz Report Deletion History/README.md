---
layout: default
last_modified_at: 2026-10-19
title: 'Blitz Report Deletion History | Oracle EBS SQL Report'
description: 'Shows deleted Blitz Reports and can be used to recover accidentally deleted reports. The history of deleted reports can be purged completely by running…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Blitz, Report, Deletion, History, xxen_reports_h, xxen_reports'
permalink: /Blitz%20Report%20Deletion%20History/
report_name: 'Blitz Report Deletion History'
report_web_name: blitz-report-deletion-history
module: 'Blitz Report'
module_url: /modules/blitz-report/
---

# Blitz Report Deletion History – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/blitz-report-deletion-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history).
**Oracle EBS module:** [Blitz Report](/modules/blitz-report/ "Oracle EBS Blitz Report reports") · [all Blitz Report reports](/modules/blitz-report/)  

## Overview
Shows deleted Blitz Reports and can be used to recover accidentally deleted reports.
The history of deleted reports can be purged completely by running concurrent 'Blitz Report Monitor' with parameter 'Purge delete reports SQL history' set to Yes

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
None

## Oracle EBS Tables Used
[xxen_reports_h](https://www.enginatics.com/library/?pg=1&find=xxen_reports_h&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history), [xxen_reports](https://www.enginatics.com/library/?pg=1&find=xxen_reports&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)

## Related Reports
[Blitz Reports](/Blitz%20Reports/ "Blitz Reports Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [Blitz Report History](/Blitz%20Report%20History/ "Blitz Report History Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [AP Invoice Upload](/AP%20Invoice%20Upload/ "AP Invoice Upload Oracle EBS SQL Report"), [Blitz Report Text Search](/Blitz%20Report%20Text%20Search/ "Blitz Report Text Search Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Deletion%20History/Blitz%20Report%20Deletion%20History.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Blitz Report Deletion History 03-Apr-2018 095214.xlsx](https://www.enginatics.com/example/blitz-report-deletion-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) |
| Blitz Report™ XML Import | [Blitz_Report_Deletion_History.xml](https://www.enginatics.com/xml/blitz-report-deletion-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) |
| SQL Source | [Blitz Report Deletion History.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/Blitz%20Report%20Deletion%20History/Blitz%20Report%20Deletion%20History.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/blitz-report-deletion-history/](https://www.enginatics.com/reports/blitz-report-deletion-history/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history) |

## Blitz Report Deletion History - Case Study & Technical Analysis

### Executive Summary

**Blitz Report Deletion History** is an audit and recovery tool. It tracks reports that have been deleted from the system. Crucially, it can be used to recover accidentally deleted reports because Blitz Report often performs a "soft delete" or archives the definition before removal.

### Business Challenge

*   **Accidental Deletion:** A developer intends to delete a test report but accidentally deletes the production version.
*   **Audit Trail:** Security requires a log of who deleted a critical financial report and when.
*   **Recovery:** Restoring the SQL logic of a deleted report without having to rewrite it from scratch.

### Solution

This report queries the history tables (`XXEN_REPORTS_H`) to find records where the report status indicates deletion.

*   **Recovery:** The SQL text and parameters are preserved in the history table, allowing them to be copied back into a new report definition.
*   **Purge:** The description notes that this history can be permanently purged using the 'Blitz Report Monitor' concurrent program.

### Technical Architecture

#### Key Tables

*   **`XXEN_REPORTS`:** The active report table.
*   **`XXEN_REPORTS_H`:** The history table that stores version changes and deleted records.

#### Logic

The report filters the history table for records that represent a deletion event.

### Parameters

*   (None listed in the README, but likely supports standard filters like Date or User if customized).

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=blitz-report-deletion-history)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
