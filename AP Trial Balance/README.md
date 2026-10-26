---
layout: default
last_modified_at: 2026-10-26
title: 'AP Trial Balance | Oracle EBS SQL Report'
description: 'Application: Payables Source: Accounts Payable Trial Balance Short Name: APTBRPT DB package: XLATBAPREPORTPVT For scheduling the report to run…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, Trial, Balance, gl_daily_conversion_types'
permalink: /AP%20Trial%20Balance/
report_name: 'AP Trial Balance'
report_web_name: ap-trial-balance
module: 'Payables'
module_url: /modules/payables/
---

# AP Trial Balance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-trial-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

## Overview
Application: Payables
Source: Accounts Payable Trial Balance
Short Name: APTBRPT
DB package: XLA_TB_AP_REPORT_PVT

For scheduling the report to run periodically, use the 'as of relative period close' offset parameter. This is the relative period offset to the current period, so when the current period changes, the period close as of date will also be automatically updated when the report is re-run.

Requires custom package XXEN_XLA package to be installed to initialize the hidden parameters removed from the report to simplify scheduling of the report.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Report Definition, Journal Source, As of Date, Third Party Name, Include Write Offs, Payables Account From, Payables Account To, Include SLA Manuals/Other Sources, Revaluation Currency, Revaluation Rate Type, Revaluation Date, As of Relative Period Close

## Oracle EBS Tables Used
[gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)

## Related Reports
[IBY Payment Process Request Details](/IBY%20Payment%20Process%20Request%20Details/ "IBY Payment Process Request Details Oracle EBS SQL Report"), [GL Mass Allocation Upload](/GL%20Mass%20Allocation%20Upload/ "GL Mass Allocation Upload Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [GL Journals (Drilldown)](/GL%20Journals%20%28Drilldown%29/ "GL Journals (Drilldown) Oracle EBS SQL Report"), [GL Balance by Account Hierarchy](/GL%20Balance%20by%20Account%20Hierarchy/ "GL Balance by Account Hierarchy Oracle EBS SQL Report"), [CAC Internal Order Shipment Margin](/CAC%20Internal%20Order%20Shipment%20Margin/ "CAC Internal Order Shipment Margin Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Trial%20Balance/AP%20Trial%20Balance.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Trial Balance - Pivot Default Template 17-Jan-2023 235141.xlsx](https://www.enginatics.com/example/ap-trial-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) |
| Blitz Report™ XML Import | [AP_Trial_Balance.xml](https://www.enginatics.com/xml/ap-trial-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) |
| SQL Source | [AP Trial Balance.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Trial%20Balance/AP%20Trial%20Balance.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-trial-balance/](https://www.enginatics.com/reports/ap-trial-balance/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance) |

## Case Study & Technical Analysis: AP Trial Balance

### Executive Summary
The **AP Trial Balance** is the definitive reconciliation report for Oracle Payables. It provides a snapshot of the outstanding liability to suppliers at a specific point in time. This report is essential for the period-end close process, serving as the primary tool to reconcile the Accounts Payable subledger balance with the General Ledger control account. It ensures financial accuracy and regulatory compliance by verifying that the company's recorded liabilities match its actual obligations.

### Business Challenge
Financial controllers and accountants face significant pressure during the month-end close:
*   **Reconciliation Discrepancies:** Differences between the AP subledger and the GL balance must be identified and explained.
*   **Historical Reporting:** Auditors often require a liability listing "as of" a past date to verify the balance sheet at year-end.
*   **Multi-Currency Complexity:** Global organizations need to report liabilities in both the transaction currency and the functional ledger currency, accounting for revaluation.
*   **Data Volume:** Processing millions of historical transactions to reconstruct a balance at a past date is computationally expensive and slow.

### The Solution: Operational View
The **AP Trial Balance** addresses these challenges by leveraging the Subledger Accounting (SLA) architecture (in R12) or the standard AP Trial Balance engine.
*   **Point-in-Time Accuracy:** Accurately reconstructs the liability balance for any given historical date ("As of Date"), considering only transactions accounted up to that point.
*   **Drill-Down Capability:** Provides the detailed composition of the balance, listing individual unpaid invoices, allowing users to trace a GL balance back to specific transactions.
*   **Revaluation Support:** Can report balances using revalued exchange rates, helping to assess the impact of currency fluctuations on open liabilities.
*   **Flexible Grouping:** Allows data to be grouped by Account, Supplier, or Third Party, facilitating different reconciliation strategies.

### Technical Architecture (High Level)
The report relies on the **Subledger Accounting (SLA)** Trial Balance engine (in R12), which maintains a synchronized view of balances.

*   **Primary Tables:**
    *   `XLA_TRIAL_BALANCES` (or `XTB` views): The core table maintaining the balance of each liability combination.
    *   `AP_INVOICES_ALL`: Source of invoice details.
    *   `AP_PAYMENT_SCHEDULES_ALL`: Tracks the remaining amount due for each invoice.
    *   `GL_CODE_COMBINATIONS`: Defines the liability accounts being reported.
    *   `GL_DAILY_RATES`: Used for currency conversion and revaluation calculations.

*   **Logical Relationships:**
    *   The report queries the **Trial Balance Engine** (`XLA_TB_AP_REPORT_PVT` package) which aggregates data based on the 'As of Date'.
    *   It filters transactions based on the **Liability Account** (from `GL_CODE_COMBINATIONS`) to ensure it only picks up relevant payables balances.
    *   It joins to **Party** information to group balances by Supplier.
    *   It calculates the **Remaining Amount** by looking at the original invoice amount minus any payments or adjustments posted on or before the 'As of Date'.

### Parameters & Filtering
*   **As of Date:** The most critical parameter. The report calculates balances as they stood at the end of this day.
*   **Operating Unit:** Limits the report to a specific business entity.
*   **Payables Account From/To:** Allows filtering for specific liability accounts (e.g., Trade Payables vs. Intercompany Payables).
*   **Third Party Name:** Filters for a specific supplier, useful for investigating individual vendor discrepancies.
*   **Include SLA Manuals/Other Sources:** Determines if manual journal entries made directly in SLA should be included in the subledger balance.

### Performance & Optimization
*   **Incremental Maintenance:** The SLA Trial Balance engine is often maintained incrementally, meaning the report doesn't always have to sum up all history from day one. It can rely on summarized snapshots.
*   **Database Package:** The report utilizes the `XLA_TB_AP_REPORT_PVT` database package, which is optimized to perform heavy aggregations within the database layer rather than transferring raw data to the application layer.
*   **Relative Period Close:** The "As of Relative Period Close" parameter allows for dynamic scheduling (e.g., "run for the last closed period"), automating the month-end reporting packet without manual date updates.

### FAQ
**Q: Why does the AP Trial Balance not match the General Ledger?**
A: Common reasons include:
    *   Manual journal entries posted directly to the GL liability account (bypassing AP).
    *   Unaccounted AP transactions (invoices/payments entered but not yet transferred to GL).
    *   Data corruption or "orphan" records (rare, but possible).
    *   Running the report and the GL inquiry with different date ranges or criteria.

**Q: Can I run this report for a date in the future?**
A: While technically possible, it is most effective for current or past dates. Running it for a future date would simply show the current open items, assuming no further activity happens, which is rarely accurate for forecasting.

**Q: Does this report include invoices that are on hold?**
A: Yes, if the invoice is validated and accounted, it represents a liability and will appear on the Trial Balance, regardless of whether it is on hold for payment.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-trial-balance)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
