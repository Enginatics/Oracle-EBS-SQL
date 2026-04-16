---
layout: default
title: 'AP Open Balances Revaluation | Oracle EBS SQL Report'
description: 'Description: AP Open Balances Revaluation Report This report is in the same format as the AP Open Balances Revaluation Report which is no longer supported…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, R12 only, Open, Balances, Revaluation, gl_ledgers, hr_all_organization_units, ap_invoices_all'
permalink: /AP%20Open%20Balances%20Revaluation/
---

# AP Open Balances Revaluation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-open-balances-revaluation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Description: AP Open Balances Revaluation Report

This report is in the same format as the AP Open Balances Revaluation Report which is no longer supported and should no loinger be used. The data source for this report is the same as the AP Open Items Revaluation report.

Application: Payables
Source: Open Items Revaluation Report (XML)
Short Name: APOPITRN
DB package: AP_OPEN_ITEMS_REVAL_PKG

## Report Parameters
Operating Unit, Revaluation Period, Include Up to Due Date, Rate Type, Daily Rate Type, Daily Rate Date, Balancing Segment Low, Balancing Segment High, Transferred to GL only, Cleared only, Include Domestic Invoice, Transaction Currency, Supplier

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all), [ap_open_items_reval_gt](https://www.enginatics.com/library/?pg=1&find=ap_open_items_reval_gt), [ap_invoice_payments_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_payments_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [ap_invoice_distributions_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_distributions_all), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Open Balances Revaluation 30-Oct-2020 190225.xlsx](https://www.enginatics.com/example/ap-open-balances-revaluation/) |
| Blitz Report™ XML Import | [AP_Open_Balances_Revaluation.xml](https://www.enginatics.com/xml/ap-open-balances-revaluation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-open-balances-revaluation/](https://www.enginatics.com/reports/ap-open-balances-revaluation/) |

## Case Study & Technical Analysis: AP Open Balances Revaluation

### 1. Executive Summary

#### Business Problem
Multinational organizations frequently transact in foreign currencies. As exchange rates fluctuate, the value of open liabilities (unpaid invoices) changes relative to the functional currency. For accurate financial reporting (ASC 830 / IAS 21), companies must "revalue" these open balances at month-end to reflect the spot rate, booking the difference as an unrealized gain or loss. Failure to do so results in misstated liabilities and inaccurate P&L.

#### Solution Overview
The **AP Open Balances Revaluation** report (and its modern counterpart, **AP Open Items Revaluation**) calculates the revalued amount of all open foreign currency invoices as of a specific period end. It compares the original accounted amount (at the transaction date rate) with the revalued amount (at the period-end rate) to derive the unrealized gain/loss. This report serves as the supporting schedule for the General Ledger revaluation journal.

#### Key Benefits
*   **Compliance:** Ensures adherence to multi-currency accounting standards.
*   **Accuracy:** Provides a detailed audit trail for the "Unrealized Gain/Loss" account in the GL.
*   **Visibility:** Highlights exposure to specific volatile currencies.

### 2. Technical Analysis

#### Core Tables and Views
This report relies on a mix of transactional tables and Subledger Accounting (SLA) data:
*   **`AP_INVOICES_ALL`**: The source of the liability.
*   **`AP_INVOICE_PAYMENTS_ALL`**: Used to determine how much of the invoice remains open.
*   **`AP_OPEN_ITEMS_REVAL_GT`**: A Global Temporary table populated by the standard Oracle Revaluation program. This table stores the snapshot of open items and their calculated revaluation amounts.
*   **`XLA_AE_HEADERS` / `XLA_AE_LINES`**: Links the AP transaction to its underlying accounting entries.

#### SQL Logic and Data Flow
The report is unique because it often relies on the data generated by the standard Oracle "Open Items Revaluation" concurrent program.
*   **Data Generation:** When the standard program runs, it populates the `AP_OPEN_ITEMS_REVAL_GT` table.
*   **Reporting:** The SQL query extracts data from this temporary table, joining it back to `AP_INVOICES_ALL` and `PO_VENDORS` to add master data context (Supplier Name, Invoice Number) that might be missing or summarized in the temp table.
*   **Calculation:** `(Open Foreign Amount * End-of-Period Rate) - (Open Functional Amount)` = `Unrealized Gain/Loss`.

#### Integration Points
*   **General Ledger:** The output must match the revaluation journal created in GL.
*   **Daily Rates:** Relies on the `GL_DAILY_RATES` table for the period-end spot rates.

### 3. Functional Capabilities

#### Parameters & Filtering
*   **Revaluation Period:** The target period for the revaluation (determines the rate date).
*   **Rate Type:** Usually 'Spot' or 'Corporate'.
*   **Transferred to GL only:** Filters for transactions that have already been accounted and posted, ensuring the revaluation is based on final numbers.
*   **Cleared Only:** Option to include/exclude reconciled payments.

#### Performance & Optimization
*   **Temporary Table Usage:** By leveraging the `GT` table, the report avoids recalculating complex remaining balances from scratch, relying instead on Oracle's standard logic.

### 4. FAQ

**Q: Why is this report marked as "Legacy"?**
A: Oracle has transitioned to the "Open Items Revaluation" architecture. While this report format is still used by some for its specific layout, the underlying data source is the same.

**Q: Why don't I see my invoice?**
A: Ensure the invoice was open (unpaid) as of the "Revaluation Period" end date and that it is in a foreign currency. Functional currency invoices do not require revaluation.


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
