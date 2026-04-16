---
layout: default
title: 'FND Audit Table Changes by Column | Oracle EBS SQL Report'
description: 'Reports all changes to an audited application table. The report has one row per audit transaction and audited column showing the old and new audit column…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Audit, Table, Changes, &from_audit_tables, &from_tables'
permalink: /FND%20Audit%20Table%20Changes%20by%20Column/
---

# FND Audit Table Changes by Column – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-audit-table-changes-by-column/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Reports all changes to an audited application table.

The report has one row per audit transaction and audited column showing the old and new audit column value.

## Report Parameters
Audit Table, Audit Date From, Audit Date To, Audited Users, Include Audit Columns, Informational Audit Table Columns, Additional Info Table, Additional Info Table Columns, Record Filter

## Oracle EBS Tables Used
[&from_audit_tables](https://www.enginatics.com/library/?pg=1&find=&from_audit_tables), [&from_tables](https://www.enginatics.com/library/?pg=1&find=&from_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[FND Audit Setup](/FND%20Audit%20Setup/ "FND Audit Setup Oracle EBS SQL Report"), [AP Expenses](/AP%20Expenses/ "AP Expenses Oracle EBS SQL Report"), [FND Audit Table Changes by Record](/FND%20Audit%20Table%20Changes%20by%20Record/ "FND Audit Table Changes by Record Oracle EBS SQL Report"), [AR Transactions and Lines](/AR%20Transactions%20and%20Lines/ "AR Transactions and Lines Oracle EBS SQL Report"), [CAC AP Accrual IR ISO Match Analysis](/CAC%20AP%20Accrual%20IR%20ISO%20Match%20Analysis/ "CAC AP Accrual IR ISO Match Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Audit Table Changes by Column 06-Sep-2020 112717.xlsx](https://www.enginatics.com/example/fnd-audit-table-changes-by-column/) |
| Blitz Report™ XML Import | [FND_Audit_Table_Changes_by_Column.xml](https://www.enginatics.com/xml/fnd-audit-table-changes-by-column/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-audit-table-changes-by-column/](https://www.enginatics.com/reports/fnd-audit-table-changes-by-column/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
