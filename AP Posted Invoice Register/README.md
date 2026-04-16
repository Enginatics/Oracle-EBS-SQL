---
layout: default
title: 'AP Posted Invoice Register | Oracle EBS SQL Report'
description: 'Application: Payables Description: Payables Posted Invoice Register This report provides equivalent functionality to the Oracle standard Payables Posted…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Posted, Invoice, Register, ap_holds_all, &lp_template_table, xla_ae_headers'
permalink: /AP%20Posted%20Invoice%20Register/
---

# AP Posted Invoice Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-posted-invoice-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Payables
Description: Payables Posted Invoice Register

This report provides equivalent functionality to the Oracle standard Payables Posted Invoice Register report.

For scheduling the report to run periodically, use the relative period from/to offset parameters. These are the relative period offsets to the current period, so when the current period changes, the included periods will also automatically be updated when the report is re-run.

Templates
- Pivot: Summary by Account, Invoice Currency
  Equivalent to standard report in Summarize Report = Yes Mode 
- Pivot: Summary by Account, Batch, Invoice Currency
  Equivalent to standard report in Summarize=No Order By=Journal Entry Batch
- Pivot: Summary by Account, Invoice Currency, Batch
  Equivalent to standard report in Summarize=No Order By=Entered Currency
- Detail
  Provides detail listing of the posted invoices

Additional data fields are available. Run the report without a template to see full list available fields

Source: Payables Posted Invoice Register
Short Name: APXPOINV
DB package: XLA_JELINES_RPT_PKG

Also requires custom package XXEN_XLA package to be installed to initialize the hidden parameters removed from the report to simplify scheduling of the report.

## Report Parameters
Operating Unit, Ledger/Ledger Set, Period From, Period To, Journal Source, Include Zero Amount Lines, Account Flexfield From, Account Flexfield To, GL Batch Name, Include Manual Entries from GL, Relative Period From, Relative Period To

## Oracle EBS Tables Used
[ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all), [&lp_template_table](https://www.enginatics.com/library/?pg=1&find=&lp_template_table), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities), [xla_events](https://www.enginatics.com/library/?pg=1&find=xla_events), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AP Invoice on Hold 11i](/AP%20Invoice%20on%20Hold%2011i/ "AP Invoice on Hold 11i Oracle EBS SQL Report"), [AP Invoice on Hold](/AP%20Invoice%20on%20Hold/ "AP Invoice on Hold Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ap-posted-invoice-register/) |
| Blitz Report™ XML Import | [AP_Posted_Invoice_Register.xml](https://www.enginatics.com/xml/ap-posted-invoice-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-posted-invoice-register/](https://www.enginatics.com/reports/ap-posted-invoice-register/) |

## Case Study & Technical Analysis: AP Posted Invoice Register

### 1. Executive Summary

#### Business Problem
The "Posting" process (transferring data from Payables to the General Ledger) is the final step in the AP cycle. Finance teams need to verify that all approved invoices have been successfully transferred to the GL to ensure month-end completeness. Standard Oracle reports for this are often rigid, making it hard to reconcile specific GL batches back to the individual invoices that comprise them.

#### Solution Overview
The **AP Posted Invoice Register** is a flexible, high-performance alternative to the standard `APXPOINV` report. It lists all AP invoices that have been posted to the General Ledger within a specific period. Crucially, it includes the **GL Batch Name** and **Header ID**, allowing users to seamlessly cross-reference a line in a GL Journal back to the specific AP Invoice Number and Supplier.

#### Key Benefits
*   **Reconciliation:** The "Rosetta Stone" between AP and GL. If a GL account balance looks wrong, this report shows exactly which invoices fed into it.
*   **Period Close:** Verifies that all eligible invoices for the period have been posted (Status = 'P').
*   **Drill-Down:** Provides the granular detail (Invoice Line, Distribution Line) behind summarized GL journal entries.

### 2. Technical Analysis

#### Core Tables and Views
This report is heavily anchored in the Subledger Accounting (SLA) schema:
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: The source of truth for posted accounting. These tables store the debits and credits exactly as they were sent to GL.
*   **`AP_INVOICES_ALL`**: Provides the operational context (Supplier, Invoice Num).
*   **`GL_JE_BATCHES` / `GL_JE_HEADERS`**: The destination in the General Ledger.
*   **`XLA_TRANSACTION_ENTITIES`**: The bridge table linking the generic SLA engine to the specific AP application.

#### SQL Logic and Data Flow
The query starts from the "Accounted" perspective rather than the "Transactional" perspective.
*   **Driver:** `XLA_AE_HEADERS` where `GL_TRANSFER_STATUS_CODE = 'Y'` (Posted).
*   **Join to AP:** Uses `SOURCE_ID_INT_1` in `XLA_TRANSACTION_ENTITIES` to join back to `AP_INVOICES_ALL.INVOICE_ID`.
*   **Filtering:** Filters by `Ledger`, `Period`, and optionally `Account Flexfield` to isolate specific accounts (e.g., Liability or Expense).
*   **Relative Periods:** Supports "Relative Period" parameters (e.g., "Current Period - 1"), making it ideal for automated scheduling.

#### Integration Points
*   **General Ledger:** This report is essentially a "Subledger Drilldown" report, mirroring the data found in GL Drilldown pages but in a flat, exportable format.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Period From/To:** Standard date range selection.
*   **GL Batch Name:** Allows users to investigate a specific suspicious batch found in the GL.
*   **Account Flexfield:** Filter for a specific natural account (e.g., "Show me all postings to the 'Office Supplies' account").
*   **Include Zero Amount Lines:** Toggle to show/hide net-zero adjustments.

#### Performance & Optimization
*   **Indexed Access:** Querying `XLA_AE_HEADERS` by `PERIOD_NAME` and `LEDGER_ID` leverages the primary partitioning keys of the SLA tables, ensuring rapid retrieval even in high-volume environments.

### 4. FAQ

**Q: Why does this report show different amounts than the "Invoice Register"?**
A: The Invoice Register shows *entered* amounts. This report shows *accounted* amounts. Differences can arise due to exchange rate variances, tax calculations, or SLA rules that modify the accounting derivation.

**Q: Can I see unposted invoices here?**
A: No, this report is specifically for *Posted* items. Use the "Unaccounted Transactions" report for items stuck in AP.

**Q: What is the "Pivot" template?**
A: The Pivot template summarizes the data by Account and Currency, mimicking the "Summarize Report = Yes" option in the standard Oracle report, but with the ability to drill down in Excel.


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
