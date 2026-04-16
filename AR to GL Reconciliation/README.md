---
layout: default
title: 'AR to GL Reconciliation | Oracle EBS SQL Report'
description: 'Imported from Concurrent Program Application: Receivables Source: AR to GL Reconciliation Report Short Name: ARGLRECR DB package:'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Reconciliation, ar_gl_recon_gt'
permalink: /AR%20to%20GL%20Reconciliation/
---

# AR to GL Reconciliation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-to-gl-reconciliation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from Concurrent Program
Application: Receivables
Source: AR to GL Reconciliation Report
Short Name: ARGLRECR
DB package:

## Report Parameters
Ledger, Out of Balance Only, Company Segment Low, Company Segment High, GL Period, GL Account Low, GL Account High, Summary Account

## Oracle EBS Tables Used
[ar_gl_recon_gt](https://www.enginatics.com/library/?pg=1&find=ar_gl_recon_gt)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CE Cash in Transit](/CE%20Cash%20in%20Transit/ "CE Cash in Transit Oracle EBS SQL Report"), [CE General Ledger Reconciliation](/CE%20General%20Ledger%20Reconciliation/ "CE General Ledger Reconciliation Oracle EBS SQL Report"), [CE Cleared Transactions](/CE%20Cleared%20Transactions/ "CE Cleared Transactions Oracle EBS SQL Report"), [CE Bank Statement and Reconciliation](/CE%20Bank%20Statement%20and%20Reconciliation/ "CE Bank Statement and Reconciliation Oracle EBS SQL Report"), [CE Bank Statement Import Execution](/CE%20Bank%20Statement%20Import%20Execution/ "CE Bank Statement Import Execution Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR to GL Reconciliation - Default 18-Oct-2023 042217.xlsx](https://www.enginatics.com/example/ar-to-gl-reconciliation/) |
| Blitz Report™ XML Import | [AR_to_GL_Reconciliation.xml](https://www.enginatics.com/xml/ar-to-gl-reconciliation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-to-gl-reconciliation/](https://www.enginatics.com/reports/ar-to-gl-reconciliation/) |

## AR to GL Reconciliation - Case Study & Technical Analysis

### Executive Summary

The **AR to GL Reconciliation** report is the definitive month-end closing tool for verifying the integrity of the Receivables module. It compares the transactional balance in the Receivables subledger against the account balance in the General Ledger (GL). A match ensures that all sales activity has been correctly accounted for and that the financial statements accurately reflect the company's outstanding receivables.

### Business Challenge

The "Subledger vs. General Ledger" reconciliation is a mandatory control for any ERP system. Discrepancies can occur due to:
*   **Manual Journals:** Users posting directly to the Receivables control account in GL, bypassing the subledger.
*   **Unposted Items:** Transactions entered in AR that have not yet been transferred to GL.
*   **Data Integrity:** System glitches or data corruption causing a mismatch between the transaction and its accounting entry.
*   **Timing Differences:** Transactions dated in one period but accounted for in another.

Finding and fixing these variances is often the most stressful part of the financial close process.

### Solution

The **AR to GL Reconciliation** report automates this comparison by providing a side-by-side view of:
1.  **Subledger Balance:** The sum of all open items in AR.
2.  **GL Balance:** The ending balance of the Receivables account in GL.
3.  **Difference:** The variance that needs investigation.

It breaks down the activity for the period (Invoices, Receipts, Adjustments) to help pinpoint exactly *where* the mismatch occurred (e.g., "My Invoices match, but my Receipts are off by $500").

### Technical Architecture

Unlike simple query-based reports, this report relies on a sophisticated data extraction process.

#### Key Tables & Logic

*   **Temporary Storage:** The report uses a Global Temporary Table (`AR_GL_RECON_GT`) to store the calculated results. This table is populated by a PL/SQL package (typically `AR_RECONCILIATION_PKG`) at runtime.
*   **Data Sources:**
    *   *Subledger Data:* Aggregated from `RA_CUSTOMER_TRX` (Invoices), `AR_CASH_RECEIPTS` (Receipts), and `AR_ADJUSTMENTS`.
    *   *GL Data:* Aggregated from `GL_JE_LINES` and `GL_BALANCES`.
*   **Drilldown:** The report logic allows drilling down from the summary balance to the specific journals or transactions contributing to that balance.

#### Reconciliation Formula

The report essentially proves the roll-forward:
$$ \text{Beginning Balance} + \text{Period Activity} = \text{Ending Balance} $$

It performs this calculation independently for both AR and GL and compares the results.

### Parameters

*   **Ledger:** The primary accounting book being reconciled.
*   **GL Period:** The specific accounting period (e.g., 'Nov-23').
*   **GL Account:** The specific Receivables control account(s) to check.
*   **Out of Balance Only:** A critical filter that hides accounts that match, allowing the user to focus solely on the problem areas.

### FAQ

**Q: What is the most common cause of a variance?**
A: Manual journal entries posted directly to the GL Receivables account. The system allows this (unless restricted), but the AR subledger has no knowledge of these entries, creating an immediate difference.

**Q: Does this report show individual invoices?**
A: The main report is a summary. However, Oracle provides "Drilldown" versions or supporting reports (like the "Account Analysis" or "Journal Entries Report") to investigate the details behind the summary figures.

**Q: Why does the report take a long time to run?**
A: Because it has to aggregate millions of transactions and journal lines to calculate the period activity and balances on the fly.


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
