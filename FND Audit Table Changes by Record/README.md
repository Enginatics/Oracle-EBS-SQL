---
layout: default
title: 'FND Audit Table Changes by Record | Oracle EBS SQL Report'
description: 'Reports all changes to an audited application table. The report has one row per audit transaction showing the old and new values for all audited columns…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, FND, Audit, Table, Changes, &from_tables'
permalink: /FND%20Audit%20Table%20Changes%20by%20Record/
---

# FND Audit Table Changes by Record – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/fnd-audit-table-changes-by-record/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Reports all changes to an audited application table.

The report has one row per audit transaction showing the old and new values for all audited columns in a single row.

## Report Parameters
Audit Table, Audit Date From, Audit Date To, Audited User, Informational Audit Table Columns, Additional Info Table, Additional Info Table Columns

## Oracle EBS Tables Used
[&from_tables](https://www.enginatics.com/library/?pg=1&find=&from_tables)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Intercompany SO Price List vs. Item Cost Comparison](/CAC%20Intercompany%20SO%20Price%20List%20vs-%20Item%20Cost%20Comparison/ "CAC Intercompany SO Price List vs. Item Cost Comparison Oracle EBS SQL Report"), [CAC AP Accrual Reconciliation Summary by Match Type](/CAC%20AP%20Accrual%20Reconciliation%20Summary%20by%20Match%20Type/ "CAC AP Accrual Reconciliation Summary by Match Type Oracle EBS SQL Report"), [CAC Receiving Activity Summary](/CAC%20Receiving%20Activity%20Summary/ "CAC Receiving Activity Summary Oracle EBS SQL Report"), [CAC Invoice Price Variance](/CAC%20Invoice%20Price%20Variance/ "CAC Invoice Price Variance Oracle EBS SQL Report"), [CAC WIP Account Detail](/CAC%20WIP%20Account%20Detail/ "CAC WIP Account Detail Oracle EBS SQL Report"), [CAC Receiving Account Summary](/CAC%20Receiving%20Account%20Summary/ "CAC Receiving Account Summary Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [FND Audit Table Changes by Record 05-Sep-2020 132119.xlsx](https://www.enginatics.com/example/fnd-audit-table-changes-by-record/) |
| Blitz Report™ XML Import | [FND_Audit_Table_Changes_by_Record.xml](https://www.enginatics.com/xml/fnd-audit-table-changes-by-record/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/fnd-audit-table-changes-by-record/](https://www.enginatics.com/reports/fnd-audit-table-changes-by-record/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
