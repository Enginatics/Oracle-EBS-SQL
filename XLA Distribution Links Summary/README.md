---
layout: default
title: 'XLA Distribution Links Summary | Oracle EBS SQL Report'
description: 'Summary of subledger distribution links for developers to understand which sourceids are populated for which subledger table sources. The link to…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, XLA, Distribution, Links, Summary, gl_ledgers, xla_ae_lines, xla_ae_headers'
permalink: /XLA%20Distribution%20Links%20Summary/
---

# XLA Distribution Links Summary – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/xla-distribution-links-summary/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary of subledger distribution links for developers to understand which source_ids are populated for which subledger table sources.
The link to subledger tables for different source_distribution_type values is described e.g. MOS Doc IDs for:
AP KB202448 <a href="https://support.oracle.com/support/?kmContentId=813968" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=813968</a>
FA KB721213 <a href="https://support.oracle.com/support/?kmContentId=2002464" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=2002464</a>
PA KB160029 <a href="https://support.oracle.com/support/?kmContentId=1274575" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=1274575</a>

For GMF, there is
AP and PO Accrual Reconciliation Report Debugging from OPM Financials KB775263 <a href="https://support.oracle.com/support/?kmContentId=2114612" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=2114612</a>
and Financials Troubleshooting Guide FAQ6726 <a href="https://support.oracle.com/support/?kmContentId=1213193" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=1213193</a>

How the gl_import_references tableis used in 11i vs R12 is described in notes KB626209 and KB625770
<a href="https://support.oracle.com/support/?kmContentId=165327" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=165327</a>
<a href="https://support.oracle.com/support/?kmContentId=130542" rel="nofollow" target="_blank">https://support.oracle.com/support/?kmContentId=130542</a>

## Report Parameters
Number Of History Days, Show Ledger and Period

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [fnd_application_vl](https://www.enginatics.com/library/?pg=1&find=fnd_application_vl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Recost Cost of Goods Sold](/CAC%20Recost%20Cost%20of%20Goods%20Sold/ "CAC Recost Cost of Goods Sold Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [CAC Purchase Price Variance](/CAC%20Purchase%20Price%20Variance/ "CAC Purchase Price Variance Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [XLA Distribution Links Summary 02-Oct-2024 131742.xlsx](https://www.enginatics.com/example/xla-distribution-links-summary/) |
| Blitz Report™ XML Import | [XLA_Distribution_Links_Summary.xml](https://www.enginatics.com/xml/xla-distribution-links-summary/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/xla-distribution-links-summary/](https://www.enginatics.com/reports/xla-distribution-links-summary/) |

## Case Study & Technical Analysis: XLA Distribution Links Summary Report

### Executive Summary

The XLA Distribution Links Summary report is a critical technical analysis and reconciliation tool for Oracle Subledger Accounting (SLA). It provides a summarized view of how subledger transaction distributions are linked to their corresponding accounting entries in SLA and ultimately to the General Ledger. This report is indispensable for technical consultants, functional analysts, and auditors to understand the complex mapping of source IDs to subledger tables, debug accounting flows, reconcile subledger balances to the GL, and ensure the accuracy and traceability of financial entries originating from various Oracle modules.

### Business Challenge

Oracle Subledger Accounting (SLA) is a powerful yet complex engine that generates accounting entries for transactions originating from various subledgers (e.g., Payables, Receivables, Projects, Inventory) before they are posted to the General Ledger. Understanding this linkage and flow is a significant challenge:

-   **Opaque Accounting Flows:** It's often difficult to trace a specific GL journal entry back to its original subledger transaction (e.g., a purchase order receipt, a sales invoice, a project expenditure). This lack of transparency complicates reconciliation and audit.
-   **Debugging Accounting Errors:** When a GL balance is incorrect, or a transaction is accounted for unexpectedly, diagnosing the issue requires understanding how the SLA rules translated the subledger transaction into GL debits and credits. Identifying the exact `source_id` and `source_distribution_type` is crucial but hard to do without specialized tools.
-   **Reconciliation Difficulties:** For reconciliation purposes, it's essential to aggregate subledger data and compare it to GL balances. The complex linking within SLA can make this a daunting task, especially for custom accounting rules.
-   **Technical Understanding:** For developers and technical analysts, understanding the `xla_distribution_links` table and how `source_id` columns relate to actual subledger tables (e.g., `AP_INVOICE_DISTRIBUTIONS_ALL`, `PA_EXPENDITURE_ITEMS_ALL`) requires specific knowledge and tools.

### The Solution

This report offers a powerful, summarized, and actionable solution for analyzing SLA distribution links, bringing transparency to subledger accounting flows.

-   **Clear Subledger-to-GL Mapping:** It provides a summarized view of the crucial `xla_distribution_links` table, detailing which subledger transaction IDs (source IDs) are populated for which `source_distribution_type` values. This demystifies how subledger entries become GL entries.
-   **Accelerated Debugging:** For technical users, the report is invaluable for quickly identifying how a particular subledger transaction has been accounted for, making it easier to debug incorrect GL postings or missing accounting entries.
-   **Reconciliation Support:** By providing key linking information, the report assists finance teams in tracing and reconciling subledger activity to the General Ledger, improving the efficiency and accuracy of month-end close.
-   **Reference to MOS Notes:** The `README.md` explicitly references relevant Oracle Support (MOS) documents that describe the linkage to subledger tables for different source distribution types, which is an invaluable resource for technical understanding.

### Technical Architecture (High Level)

The report queries core Oracle Subledger Accounting (XLA) and General Ledger tables to summarize distribution links.

-   **Primary Tables Involved:**
    -   `xla_distribution_links` (the central table for linking subledger transaction distributions to SLA accounting lines).
    -   `xla_ae_lines` and `xla_ae_headers` (for SLA accounting entry lines and headers).
    -   `xla_transaction_entities` (stores information about the subledger transactions that create accounting entries).
    -   `gl_ledgers` (for ledger context).
    -   `fnd_application_vl` (for application context, identifying the source module).
-   **Logical Relationships:** The report aggregates and summarizes records from `xla_distribution_links`. It links these to `xla_ae_lines` and `xla_ae_headers` to get the actual accounting entries. By using `xla_transaction_entities`, it identifies the source application and subledger, and then presents the `source_id` columns, indicating which transaction IDs are being linked from the original subledger tables. The `Number Of History Days` parameter controls the timeframe of the data included.

### Parameters & Filtering

The report offers focused parameters for targeted analysis of SLA distribution links:

-   **Number Of History Days:** A crucial parameter that controls how far back in time the report retrieves data, allowing users to focus on recent accounting activity or a specific historical period.
-   **Show Ledger and Period:** This parameter likely enables the display of the associated `Ledger` name and `Period` for the accounting entries, providing essential financial context.

### Performance & Optimization

As a technical summary report querying complex SLA tables, it is optimized by limiting the historical data retrieved.

-   **History Day Limit:** The `Number Of History Days` parameter is critical for performance. By restricting the data to a recent timeframe, the database can efficiently query the large `xla_distribution_links` table using date-based indexes.
-   **Efficient Aggregation:** The report provides a summary, implying efficient aggregation of data rather than returning every single distribution link, which would be a very large dataset.
-   **Indexed Joins:** Queries leverage standard Oracle indexes on `application_id`, `ae_header_id`, `ae_line_num`, and `source_distribution_type` for efficient data retrieval across SLA tables.

### FAQ

**1. What is the significance of `source_id_int_1`, `source_id_int_2`, etc., in the `xla_distribution_links` table?**
   These columns are generic foreign keys that store the primary key values from the original subledger transaction tables. For example, `source_id_int_1` might store `AP_INVOICE_DISTRIBUTION_ID` for an Accounts Payable transaction, or `PROJECT_EXPENDITURE_ITEM_ID` for a Projects transaction. This report helps decipher which subledger table each combination of source IDs refers to.

**2. How does this report assist in debugging GL reconciliation issues?**
   If a GL balance is off, this report helps by showing the detailed linkages. You can see which subledger transactions contributed to which GL entries. If a transaction is missing or incorrectly linked, this report provides the technical details (source IDs, distribution types) needed to investigate the SLA setup or the source subledger transaction itself.

**3. Why are Oracle Support (MOS) document IDs referenced in the description?**
   MOS documents often provide crucial technical details about Oracle EBS tables and their linkages, especially for complex modules like SLA. Referencing these IDs in the report description is invaluable for developers and support staff who need to understand the underlying data model and how specific `source_id` columns map to various subledger tables, aiding in advanced troubleshooting.


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
