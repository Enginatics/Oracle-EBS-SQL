---
layout: default
title: 'AR Customer Open Balances Period Lookback | Oracle EBS SQL Report'
description: 'Report: AR Customer Open Balances Period Lookback Application: Receivables Description: Customer Open Balances summary showing - Open Balances as of the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Customer, Open, Balances, Period, ar_receivable_applications_all, ar_adjustments_all, gl_daily_conversion_types'
permalink: /AR%20Customer%20Open%20Balances%20Period%20Lookback/
---

# AR Customer Open Balances Period Lookback – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-customer-open-balances-period-lookback/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report: AR Customer Open Balances Period Lookback
Application: Receivables
Description:
Customer Open Balances summary showing
- Open Balances as of the specified 'As of Date' and as of <n> periods prior to the 'As of Date' period.
- Maximum Open Balance in the prior <n> periods prior to the 'As of Date' period

All balances are show in the functional currency.

Parameters:
As of Date - the report will be run as of this date. Defaults to the current system date.
Look Back <n> periods - number of periods prior to the 'As of Date' period to show
Max Open over last <n> Periods - number of periods prior to the 'As of Date' period to consider in the Maximum Open Balance amount calculation


## Report Parameters
Ledger, Operating Unit, Currency, Customer, As of Date, Look Back <n> Periods, Max Open over last <n> Periods, Revaluation Currency, Revaluation Rate Type, Revaluation Date

## Oracle EBS Tables Used
[ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ar_adjustments_all](https://www.enginatics.com/library/?pg=1&find=ar_adjustments_all), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [ra_cust_trx_line_gl_dist_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_line_gl_dist_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ar_system_parameters_all](https://www.enginatics.com/library/?pg=1&find=ar_system_parameters_all), [xle_entity_profiles](https://www.enginatics.com/library/?pg=1&find=xle_entity_profiles), [ar_lookups](https://www.enginatics.com/library/?pg=1&find=ar_lookups), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ar_cash_receipt_history_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipt_history_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/ar-customer-open-balances-period-lookback/) |
| Blitz Report™ XML Import | [AR_Customer_Open_Balances_Period_Lookback.xml](https://www.enginatics.com/xml/ar-customer-open-balances-period-lookback/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-customer-open-balances-period-lookback/](https://www.enginatics.com/reports/ar-customer-open-balances-period-lookback/) |

## AR Customer Open Balances Period Lookback - Case Study & Technical Analysis

### Executive Summary

The **AR Customer Open Balances Period Lookback** report is a powerful analytical tool for Oracle Receivables that provides a historical view of customer open balances. Unlike standard aging reports that offer a snapshot at a single point in time, this report allows financial analysts and credit managers to compare current open balances with those from previous periods. It also identifies the maximum open balance over a specified timeframe, offering critical insights into customer credit utilization trends and potential risk exposure.

### Business Challenge

Managing accounts receivable effectively requires identifying trends in customer payment behavior. Organizations often struggle with:

*   **Trend Identification:** Detecting whether a customer's outstanding balance is increasing or decreasing over time can be difficult with standard static reports.
*   **Risk Forecasting:** Predicting future bad debt requires understanding historical credit usage patterns.
*   **Credit Limit Management:** Determining appropriate credit limits requires knowing not just the current balance, but also the peak credit usage in the past.
*   **Currency Fluctuations:** For multi-national organizations, analyzing balances in a functional currency while accounting for exchange rate fluctuations is complex.

### Solution

The **AR Customer Open Balances Period Lookback** report addresses these challenges by providing:

*   **Historical Comparison:** Displays open balances as of a specific "As of Date" and compares them to balances from *n* periods prior.
*   **Peak Exposure Analysis:** Calculates the maximum open balance reached during the lookback period, helping to assess the highest risk exposure for each customer.
*   **Trend Visibility:** Enables users to spot customers with consistently growing balances, indicating potential collection issues.
*   **Multi-Currency Support:** Reports balances in the functional currency, with options for revaluation to ensure accurate financial reporting.

### Technical Architecture

The report is built on a robust SQL architecture that queries Oracle Receivables transaction and payment history tables.

#### Key Tables Used

*   `AR_PAYMENT_SCHEDULES_ALL`: The core table for tracking transaction balances and status.
*   `AR_RECEIVABLE_APPLICATIONS_ALL`: Used to track how receipts and credit memos are applied to invoices, essential for calculating historical balances.
*   `AR_ADJUSTMENTS_ALL`: Accounts for any adjustments made to transactions.
*   `HZ_CUST_ACCOUNTS` & `HZ_PARTIES`: Provides customer master data.
*   `GL_DAILY_RATES`: Used for currency conversion when reporting in a currency different from the transaction currency.
*   `GL_LEDGERS` & `HR_OPERATING_UNITS`: Defines the organizational context for the report.

#### Data Logic

The report's logic is sophisticated, involving:
1.  **As-of Date Calculation:** Determining the open balance of each transaction as of the specified date by subtracting applications and adjustments made after that date.
2.  **Period Lookback:** Repeating the balance calculation for *n* periods prior to the "As of Date" to provide comparative data.
3.  **Max Balance Calculation:** Iterating through the specified lookback periods to find the highest total open balance for each customer.
4.  **Currency Revaluation:** Applying revaluation rates if specified to present balances in a consistent currency.

### Parameters

The report offers flexible parameters to tailor the analysis:

*   **As of Date:** The reference date for the report (defaults to the current date).
*   **Look Back <n> Periods:** The number of prior periods to compare against the current period.
*   **Max Open over last <n> Periods:** The number of periods to consider when calculating the maximum open balance.
*   **Ledger / Operating Unit:** Filters data by specific financial entities.
*   **Customer:** Allows filtering for a specific customer or range of customers.
*   **Revaluation Currency / Rate Type / Date:** Controls how foreign currency transactions are revalued.

### Performance

To ensure high performance, especially when calculating historical balances across many periods:
*   The query leverages indexes on `AR_PAYMENT_SCHEDULES_ALL` (specifically on `customer_id` and `gl_date`) and `AR_RECEIVABLE_APPLICATIONS_ALL`.
*   It is recommended to run the report for specific operating units or customer ranges if the database volume is extremely high.

### FAQ

**Q: How is the "Open Balance" calculated for past periods?**
A: The report takes the original amount of the transaction and subtracts only those applications (receipts, credit memos) and adjustments that occurred *on or before* the period end date being analyzed.

**Q: Does the "Max Open Balance" include unapplied cash?**
A: Typically, the calculation focuses on the gross open receivables (invoices, debit memos). However, depending on the specific configuration, it can be set to net out unapplied receipts.

**Q: Why might the balance shown here differ from the GL balance?**
A: Differences can arise due to unposted items, manual journal entries in GL that are not reflected in AR, or differences in exchange rate types used for revaluation.


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
