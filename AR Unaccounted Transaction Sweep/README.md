---
layout: default
title: 'AR Unaccounted Transaction Sweep | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Application: Receivables Source: Unaccounted Transaction Sweep Short Name: ARTRXSWP DB package: arunaccountedtrxsweep'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, Unaccounted, Transaction, Sweep, ar_period_close_excps_gt, hz_cust_accounts, hz_parties'
permalink: /AR%20Unaccounted%20Transaction%20Sweep/
---

# AR Unaccounted Transaction Sweep – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-unaccounted-transaction-sweep/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Application: Receivables
Source: Unaccounted Transaction Sweep
Short Name: ARTRXSWP
DB package: ar_unaccounted_trx_sweep

## Report Parameters
Reporting Level, Reporting Context, Period Name, Sweep Now, Sweep To Period Name, Debug Flag

## Oracle EBS Tables Used
[ar_period_close_excps_gt](https://www.enginatics.com/library/?pg=1&find=ar_period_close_excps_gt), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [xla_accounting_errors](https://www.enginatics.com/library/?pg=1&find=xla_accounting_errors), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [ar_distributions_all](https://www.enginatics.com/library/?pg=1&find=ar_distributions_all), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-unaccounted-transaction-sweep/) |
| Blitz Report™ XML Import | [AR_Unaccounted_Transaction_Sweep.xml](https://www.enginatics.com/xml/ar-unaccounted-transaction-sweep/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-unaccounted-transaction-sweep/](https://www.enginatics.com/reports/ar-unaccounted-transaction-sweep/) |

## AR Unaccounted Transaction Sweep - Case Study & Technical Analysis

### Executive Summary

The **AR Unaccounted Transaction Sweep** is a specialized period-close utility in Oracle Receivables. Its primary purpose is to unblock the period closing process. Oracle enforces a strict rule: an accounting period cannot be closed if it contains transactions that have not been successfully accounted (transferred to the General Ledger). This report identifies such transactions and offers the option to "sweep" them—i.e., move their accounting date—to the next open period.

### Business Challenge

The financial close is a time-sensitive process.
*   **The Blocker:** A single unaccounted invoice (e.g., due to a missing exchange rate or invalid account code) can prevent the entire AR period from closing.
*   **The Deadline:** If the accounting team cannot resolve the error before the corporate deadline, they risk delaying the entire company's financial reporting.
*   **The Fix:** Fixing the root cause (e.g., defining a new tax rule) might take days, which is time the team doesn't have.

### Solution

The **AR Unaccounted Transaction Sweep** provides a tactical solution:
*   **Identification:** First, run in "Review" mode (Sweep Now = No) to list all stuck transactions and the associated error messages (from Subledger Accounting).
*   **Resolution (Sweep):** If the errors cannot be fixed immediately, run in "Execute" mode (Sweep Now = Yes). This updates the GL Date of the problematic transactions to the first day of the *next* period.
*   **Result:** The current period is now clean and can be closed. The transactions remain in the system but will be processed in the following month.

### Technical Architecture

The tool interacts with the Subledger Accounting (SLA) engine and the core AR transaction tables.

#### Key Tables & Logic

*   **Exception Table:** `AR_PERIOD_CLOSE_EXCPS_GT` is a global temporary table populated by the sweep program. It aggregates exceptions from various sources.
*   **Sources Checked:**
    *   **Invoices:** Checks `RA_CUST_TRX_LINE_GL_DIST_ALL` for unposted distributions.
    *   **Receipts:** Checks `AR_DISTRIBUTIONS_ALL` (Cash/Misc Receipts).
    *   **Adjustments:** Checks `AR_ADJUSTMENTS_ALL`.
*   **Error Details:** Links to `XLA_ACCOUNTING_ERRORS` to retrieve the specific reason why the accounting failed (e.g., "Code Combination ID not found").

#### The Sweep Action

When "Sweep Now" is enabled, the program executes an `UPDATE` statement:
$$ \text{GL\_DATE} = \text{Start Date of 'Sweep To Period'} $$
This applies to the distribution lines of the affected transactions.

### Parameters

*   **Period Name:** The period you are trying to close (e.g., 'Oct-23').
*   **Sweep Now:**
    *   *No:* Report mode only. Lists the exceptions.
    *   *Yes:* Action mode. Moves the transactions.
*   **Sweep To Period Name:** The target period (e.g., 'Nov-23'). Must be Open or Future-Entry.

### FAQ

**Q: Is sweeping recommended?**
A: It is a fallback mechanism. The best practice is to resolve the accounting error in the correct period to ensure expenses/revenue are matched to the right month. Sweeping moves the P&L impact to the next month.

**Q: Can I sweep a transaction that has been partially accounted?**
A: Generally, no. If part of a transaction (e.g., the Revenue line) is already posted, you cannot change the GL date of the whole transaction. The sweep program typically handles completely unaccounted events.

**Q: What happens if I don't sweep?**
A: You simply cannot close the AR period until the transactions are either fixed (and accounted) or deleted.


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
