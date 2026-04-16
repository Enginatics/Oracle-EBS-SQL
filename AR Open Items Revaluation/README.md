---
layout: default
title: 'AR Open Items Revaluation | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Open Items Revaluation Report Application: Receivables Source: Open Items Revaluation Report (XML) Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, R12 only, Open, Items, Revaluation, gl_translation_rates, ar_receivable_applications, ar_cash_receipt_history'
permalink: /AR%20Open%20Items%20Revaluation/
---

# AR Open Items Revaluation – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-open-items-revaluation/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Open Items Revaluation Report
Application: Receivables
Source: Open Items Revaluation Report (XML)
Short Name: ARXINREV_XML
DB package: AR_ARXINREV_XMLP_PKG


## Report Parameters
Ledger, Operating Unit, Report Format, Revaluation Period, Include Up To Due Date, Rate Type, Daily Rate Type, Daily Rate Date, Balancing Segment Low, Balancing Segment High, Transferred To GL only, Cleared only

## Oracle EBS Tables Used
[gl_translation_rates](https://www.enginatics.com/library/?pg=1&find=gl_translation_rates), [ar_receivable_applications](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications), [ar_cash_receipt_history](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history), [ar_adjustments](https://www.enginatics.com/library/?pg=1&find=ar_adjustments), [ra_cust_trx_types](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations), [hz_cust_acct_sites](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites), [hz_cust_site_uses](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ra_customer_trx](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx), [ar_xla_ctlgd_lines_v](https://www.enginatics.com/library/?pg=1&find=ar_xla_ctlgd_lines_v), [ar_payment_schedules](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules), [gl_period_statuses](https://www.enginatics.com/library/?pg=1&find=gl_period_statuses)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Open Items Revaluation - Default 11-Oct-2023 030916.xlsx](https://www.enginatics.com/example/ar-open-items-revaluation/) |
| Blitz Report™ XML Import | [AR_Open_Items_Revaluation.xml](https://www.enginatics.com/xml/ar-open-items-revaluation/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-open-items-revaluation/](https://www.enginatics.com/reports/ar-open-items-revaluation/) |

## AR Open Items Revaluation - Case Study & Technical Analysis

### Executive Summary

The **AR Open Items Revaluation** report is the XML Publisher-based standard report for calculating foreign exchange (FX) gains and losses on open receivables. It is an essential month-end compliance tool that ensures assets held in foreign currencies are reported at their current fair value, as required by accounting standards like IAS 21 and FAS 52.

### Business Challenge

Global organizations hold receivables in multiple currencies. As exchange rates fluctuate between the invoice date and the reporting date, the functional currency value of these assets changes.
*   **Financial Accuracy:** Reporting receivables at historical rates can significantly overstate or understate the company's financial position.
*   **Manual Effort:** Calculating the FX impact for thousands of individual invoices and credit memos manually is impractical and error-prone.
*   **Audit Trail:** Auditors require a clear, itemized list showing the original rate, the closing rate, and the resulting adjustment for every revalued transaction.

### Solution

The **AR Open Items Revaluation** report streamlines the revaluation process:
*   **Automated Calculation:** It automatically retrieves the closing exchange rate for the selected period and applies it to all open foreign currency balances.
*   **Detailed Analysis:** It lists each invoice, showing the original amount, the open amount, the original exchange rate, the revaluation rate, and the calculated gain or loss.
*   **Flexibility:** Users can run the report in "Detail" mode for auditing or "Summary" mode for booking journal entries.

### Technical Architecture

This report (`ARXINREV_XML`) is built on Oracle's XML Publisher technology, offering a more modern output format compared to older text-based reports.

#### Key Tables & Joins

*   **Open Items:** `AR_PAYMENT_SCHEDULES` is the source of truth for what is currently owed.
*   **Transaction Data:** `RA_CUSTOMER_TRX` provides the invoice number, date, and original currency details.
*   **Exchange Rates:** `GL_DAILY_RATES` (or `GL_TRANSLATION_RATES`) supplies the period-end rates used for revaluation.
*   **Accounting:** `AR_XLA_CTLGD_LINES_V` and `GL_CODE_COMBINATIONS` help identify the specific GL accounts (e.g., Trade Receivables) associated with the transactions.

#### Logic

1.  **Scope:** Identifies all transactions that are "Open" (have a remaining balance) as of the end of the "Revaluation Period."
2.  **Rate Selection:** Uses the "Rate Type" (e.g., Corporate, Spot) and "Daily Rate Date" (usually period-end) to fetch the new exchange rate.
3.  **Gain/Loss Formula:**
    $$ \text{Unrealized Gain/Loss} = (\text{Open Amount} \times \text{New Rate}) - (\text{Open Amount} \times \text{Original Rate}) $$

### Parameters

*   **Revaluation Period:** The accounting period for which the revaluation is being performed (e.g., 'Oct-23').
*   **Report Format:**
    *   *Detail:* Lists every invoice.
    *   *Summary:* Aggregates by Currency and GL Account.
*   **Rate Type:** The source of the revaluation rate (e.g., 'Corporate').
*   **Transferred to GL only:** If set to 'Yes', restricts the report to transactions that have already been posted to the General Ledger, ensuring alignment between subledger and GL.
*   **Cleared only:** For receipts, filters for those that have cleared the bank.

### FAQ

**Q: How does this differ from the "AR Open Balances Revaluation" report?**
A: Both reports perform similar calculations. This version (`ARXINREV_XML`) is the newer XML Publisher version, which typically offers better formatting and potentially different parameter options compared to the older text-based or RDF versions.

**Q: Why is the "Unrealized Gain/Loss" zero for some items?**
A: This happens if the revaluation rate is identical to the original rate, or if the item is in the functional currency (and "Include Domestic Invoices" is not applicable or set to No).

**Q: Does this report automatically create the journal entry?**
A: No, this report calculates and displays the figures. The actual journal creation is done by the "Revaluation" process in the General Ledger or the "Receivables Revaluation" program, depending on your setup.


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
