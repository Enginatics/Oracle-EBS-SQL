---
layout: default
title: 'AR Open Balances Revaluation | Oracle EBS SQL Report'
description: 'Report: AR Open Balances Revaluation Report Application: Receivables Source: AR Open Balances Revaluation Report Short Name: AROBRR'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Open, Balances, Revaluation, ar_receivable_applications, ar_adjustments, hr_operating_units'
permalink: /AR%20Open%20Balances%20Revaluation/
---

# AR Open Balances Revaluation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-open-balances-revaluation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report: AR Open Balances Revaluation Report
Application: Receivables
Source: AR Open Balances Revaluation Report
Short Name: AROBRR


## Report Parameters
Ledger, Operating Unit, As of Date, Exchange Rate Type, Currency, User Rate Type Exchange Rate, Include Domestic Invoices, Customer

## Oracle EBS Tables Used
[ar_receivable_applications](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications), [ar_adjustments](https://www.enginatics.com/library/?pg=1&find=ar_adjustments), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [ra_customer_trx](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx), [ar_payment_schedules](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules), [ra_cust_trx_types](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types), [ra_cust_trx_line_gl_dist](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [xla_distribution_links](https://www.enginatics.com/library/?pg=1&find=xla_distribution_links), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ar_system_parameters](https://www.enginatics.com/library/?pg=1&find=ar_system_parameters), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers), [ar_lookups](https://www.enginatics.com/library/?pg=1&find=ar_lookups), [ar_cash_receipts](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts), [ar_cash_receipt_history](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history), [ar_distributions](https://www.enginatics.com/library/?pg=1&find=ar_distributions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Open Balances Revaluation - Default 11-Oct-2023 065223.xlsx](https://www.enginatics.com/example/ar-open-balances-revaluation/) |
| Blitz Report™ XML Import | [AR_Open_Balances_Revaluation.xml](https://www.enginatics.com/xml/ar-open-balances-revaluation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-open-balances-revaluation/](https://www.enginatics.com/reports/ar-open-balances-revaluation/) |

## AR Open Balances Revaluation - Case Study & Technical Analysis

### Executive Summary

The **AR Open Balances Revaluation** report is a key financial closing tool for multinational organizations. It calculates the unrealized foreign exchange (FX) gains or losses on outstanding customer invoices. Accounting standards (such as US GAAP and IFRS) mandate that monetary assets denominated in foreign currencies be revalued at the end of each reporting period using the closing exchange rate. This report provides the supporting detail for these adjustments.

### Business Challenge

When an invoice is issued in a foreign currency (e.g., EUR) but the company's books are kept in another (e.g., USD), the value of that receivable fluctuates with the exchange rate.
*   **Volatility:** Significant currency swings can materially impact the balance sheet.
*   **Compliance:** Failure to revalue open balances results in incorrect asset valuation and violates accounting principles.
*   **Complexity:** Manually tracking the original rate vs. the current rate for thousands of open invoices and partial payments is prone to error.

### Solution

The **AR Open Balances Revaluation** report automates the valuation process by:
*   **Snapshotting:** Identifying all open receivables as of a specific "As of Date."
*   **Rate Comparison:** Retrieving the original exchange rate used at the time of the transaction and comparing it to the closing rate for the period.
*   **Calculation:** Computing the difference (Unrealized Gain/Loss) for each transaction and summarizing it by currency and account.

### Technical Architecture

The report logic involves simulating the revaluation process without necessarily posting it.

#### Key Tables & Joins

*   **Open Balances:** `AR_PAYMENT_SCHEDULES` contains the remaining amount due for each invoice.
*   **Transaction Details:** `RA_CUSTOMER_TRX` provides the original exchange rate and currency code.
*   **Market Rates:** `GL_DAILY_RATES` is queried to find the exchange rate for the "As of Date" based on the selected Rate Type (e.g., Corporate, Spot).
*   **Accounting:** `GL_CODE_COMBINATIONS` and `XLA_AE_LINES` may be referenced to determine the Receivables account associated with the transaction.

#### Logic

1.  **Selection:** Finds all transactions with a non-zero balance as of the parameter date.
2.  **Rate Retrieval:** Looks up the revaluation rate. If a rate is missing for the specific date, it may look back to the last available rate depending on configuration.
3.  **Computation:**
    $$ \text{Revalued Amount} = \text{Open Foreign Amount} \times \text{Revaluation Rate} $$
    $$ \text{Unrealized Gain/Loss} = \text{Revalued Amount} - \text{Open Functional Amount} $$

### Parameters

*   **As of Date:** The valuation date (usually the last day of the month).
*   **Exchange Rate Type:** The rate type to use for revaluation (e.g., 'Month End', 'Corporate').
*   **Currency:** Option to run for a specific currency or all currencies.
*   **Include Domestic Invoices:** Typically set to 'No', as domestic transactions do not generate FX gains/losses unless the functional currency differs from the reporting currency.

### FAQ

**Q: Does this report post entries to the GL?**
A: No, this is a reporting tool. The actual "Revaluation" process in the General Ledger or the "Revaluation" program in AR is responsible for creating the journal entries. This report is used to validate those figures.

**Q: Why is the revaluation rate missing?**
A: If the report shows a missing rate, ensure that the Daily Rates are defined in the General Ledger for the "As of Date" and the selected "Exchange Rate Type."

**Q: How are partial payments handled?**
A: The report revalues only the *remaining* open balance of the invoice, not the original full amount.


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
