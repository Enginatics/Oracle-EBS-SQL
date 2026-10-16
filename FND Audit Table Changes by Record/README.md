---
layout: default
last_modified_at: 2026-10-16
title: 'FND Audit Table Changes by Record | Oracle EBS SQL Report'
description: 'Reports all changes to an audited application table. The report has one row per audit transaction showing the old and new values for all audited columns…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Audit, Table, Changes, where'
permalink: /FND%20Audit%20Table%20Changes%20by%20Record/
report_name: 'FND Audit Table Changes by Record'
report_web_name: fnd-audit-table-changes-by-record
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Audit Table Changes by Record – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-audit-table-changes-by-record/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Reports all changes to an audited application table.

The report has one row per audit transaction showing the old and new values for all audited columns in a single row.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Audit Table, Audit Date From, Audit Date To, Audited User, Informational Audit Table Columns, Additional Info Table, Additional Info Table Columns

## Oracle EBS Tables Used
[where](https://www.enginatics.com/library/?pg=1&find=where&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Table%20Changes%20by%20Record/FND%20Audit%20Table%20Changes%20by%20Record.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Audit Table Changes by Record 05-Sep-2020 132119.xlsx](https://www.enginatics.com/example/fnd-audit-table-changes-by-record/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) |
| Blitz Report™ XML Import | [FND_Audit_Table_Changes_by_Record.xml](https://www.enginatics.com/xml/fnd-audit-table-changes-by-record/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) |
| SQL Source | [FND Audit Table Changes by Record.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Table%20Changes%20by%20Record/FND%20Audit%20Table%20Changes%20by%20Record.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-audit-table-changes-by-record/](https://www.enginatics.com/reports/fnd-audit-table-changes-by-record/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record) |

## Executive Summary
The **FND Audit Table Changes by Record** report provides a pivoted view of audit trail data. Unlike the "by Column" version, this report shows the "Old" and "New" values for all audited columns in a single row per transaction.

## Business Challenge
*   **Contextual Analysis:** Seeing all changes from a single transaction together to understand the full context of the update.
*   **Readability:** Easier for business users to read a single line describing an update rather than multiple rows.
*   **Exportability:** Better suited for Excel exports where a "flat" record structure is preferred.

## The Solution
This Blitz Report dynamically pivots the audit data:
*   **Single Row View:** One update transaction = one row in the report.
*   **Dynamic Columns:** The report automatically generates columns for "Old [Column]" and "New [Column]" based on the table definition.
*   **Transaction Type:** Clearly marks Inserts, Updates, and Deletes.

## Technical Architecture
Similar to the "by Column" report, it uses dynamic SQL. However, the query construction is more complex as it must select all relevant columns from the shadow table and present them in a wide format.

## Parameters & Filtering
*   **Audit Table:** The table to analyze.
*   **Date Range:** Timeframe for the changes.
*   **Audited User:** Filter by the person who made the change.

## Performance & Optimization
*   **Column Limit:** If a table has hundreds of audited columns, the report can become very wide.
*   **Data Volume:** As with all audit reports, querying large shadow tables without filters can be slow.

## FAQ
*   **Q: Which report should I use? "by Column" or "by Record"?**
    *   A: Use "by Record" when you want to see the full state of the record before/after the change. Use "by Column" if you are looking for specific field changes (e.g., "Who changed the credit limit?").

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-record)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
