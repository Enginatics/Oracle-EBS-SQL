---
layout: default
last_modified_at: 2026-10-16
title: 'FND Audit Table Changes by Column | Oracle EBS SQL Report'
description: 'Reports all changes to an audited application table. The report has one row per audit transaction and audited column showing the old and new audit column…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Application Object Library, Enginatics, FND, Audit, Table, Changes, fnd_tables'
permalink: /FND%20Audit%20Table%20Changes%20by%20Column/
report_name: 'FND Audit Table Changes by Column'
report_web_name: fnd-audit-table-changes-by-column
module: 'Application Object Library'
module_url: /modules/application-object-library/
---

# FND Audit Table Changes by Column – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-audit-table-changes-by-column/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column).
**Oracle EBS module:** [Application Object Library](/modules/application-object-library/ "Oracle EBS Application Object Library reports") · [all Application Object Library reports](/modules/application-object-library/)  

## Overview
Reports all changes to an audited application table.

The report has one row per audit transaction and audited column showing the old and new audit column value.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Audit Table, Audit Date From, Audit Date To, Audited Users, Include Audit Columns, Informational Audit Table Columns, Additional Info Table, Additional Info Table Columns, Record Filter

## Oracle EBS Tables Used
[fnd_tables](https://www.enginatics.com/library/?pg=1&find=fnd_tables&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)

## Related Reports
[CAC WIP Pending Cost Adjustment](/CAC%20WIP%20Pending%20Cost%20Adjustment/ "CAC WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Material Account Detail](/CAC%20Material%20Account%20Detail/ "CAC Material Account Detail Oracle EBS SQL Report"), [CAC AP Accrual Reconciliation Summary by Match Type](/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/ "CAC AP Accrual Reconciliation Summary by Match Type Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Where Used by Cost Type](/CAC%20Where%20Used%20by%20Cost%20Type/ "CAC Where Used by Cost Type Oracle EBS SQL Report"), [CAC Item List Price vs. Item Cost](/CAC%20Item%20List%20Price%20vs-%20Item%20Cost/ "CAC Item List Price vs. Item Cost Oracle EBS SQL Report"), [CAC Zero Item Costs](/CAC%20Zero%20Item%20Costs/ "CAC Zero Item Costs Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Accounting Period Status](/CAC%20Accounting%20Period%20Status/ "CAC Accounting Period Status Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Table%20Changes%20by%20Column/FND%20Audit%20Table%20Changes%20by%20Column.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Audit Table Changes by Column 06-Sep-2020 112717.xlsx](https://www.enginatics.com/example/fnd-audit-table-changes-by-column/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) |
| Blitz Report™ XML Import | [FND_Audit_Table_Changes_by_Column.xml](https://www.enginatics.com/xml/fnd-audit-table-changes-by-column/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) |
| SQL Source | [FND Audit Table Changes by Column.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/FND%20Audit%20Table%20Changes%20by%20Column/FND%20Audit%20Table%20Changes%20by%20Column.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/fnd-audit-table-changes-by-column/](https://www.enginatics.com/reports/fnd-audit-table-changes-by-column/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column) |

## Executive Summary
The **FND Audit Table Changes by Column** report is a universal tool for querying data from any Oracle Audit Trail table. It presents the history of changes in a normalized format, with one row per changed column.

## Business Challenge
*   **Forensic Analysis:** Investigating exactly what changed, who changed it, and when.
*   **Data Recovery:** Finding the previous value of a field to reverse an accidental update.
*   **Security Monitoring:** Tracking changes to sensitive fields like bank accounts or salary.

## The Solution
This Blitz Report uses dynamic SQL to query the specific shadow table for the selected entity:
*   **Universal Access:** Can query any table enabled for Audit Trail (e.g., `FND_USER_A`, `PO_VENDORS_A`).
*   **Granular Detail:** Shows the "Old Value" and "New Value" side-by-side for each specific column.
*   **User Context:** Identifies the EBS user who made the change, not just the database user.

## Technical Architecture
The report uses a dynamic SQL structure (indicated by `&from_audit_tables`). It constructs the query at runtime based on the `Audit Table` parameter selected by the user. It joins the shadow table (e.g., `_A`) with `FND_USER` to resolve the `WHO` columns.

## Parameters & Filtering
*   **Audit Table:** The specific table to query (Required).
*   **Date Range:** To limit the history.
*   **Record Filter:** A flexible `WHERE` clause to find specific records (e.g., `VENDOR_NAME like 'ABC%'`).

## Performance & Optimization
*   **Indexing:** Shadow tables can grow very large. Ensure the shadow table has indices on the primary key and timestamp columns for performance.
*   **Date Range:** Always use a date range to avoid scanning millions of historical audit records.

## FAQ
*   **Q: Why do I see multiple rows for one update?**
    *   A: If a user updates 5 fields in a single save, this report will show 5 rows—one for each column changed.
*   **Q: Can I see the primary key of the record?**
    *   A: Yes, the report typically includes the primary key columns to identify the record.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=fnd-audit-table-changes-by-column)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
