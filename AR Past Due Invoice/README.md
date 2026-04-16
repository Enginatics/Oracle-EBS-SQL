---
layout: default
title: 'AR Past Due Invoice | Oracle EBS SQL Report'
description: 'Detail past due AR invoice report with invoice number, days past due, amount past due and currency code'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, Past, Due, Invoice, hr_all_organization_units_vl, ar_payment_schedules_all, ra_customer_trx_all'
permalink: /AR%20Past%20Due%20Invoice/
---

# AR Past Due Invoice – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-past-due-invoice/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail past due AR invoice report with invoice number, days past due, amount past due and currency code

## Report Parameters
Operating Unit, Order By, As of Date, Days Late Low, Days Late High, Balance Due Low, Balance Due High, Collector, Customer Name, Customer Name not in, Customer Number, Type Low, Salesperson/Agent Low

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [ra_salesreps](https://www.enginatics.com/library/?pg=1&find=ra_salesreps), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles), [ar_collectors](https://www.enginatics.com/library/?pg=1&find=ar_collectors)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Past Due Invoice - demo 1 16-Jun-2025 182210.xlsx](https://www.enginatics.com/example/ar-past-due-invoice/) |
| Blitz Report™ XML Import | [AR_Past_Due_Invoice.xml](https://www.enginatics.com/xml/ar-past-due-invoice/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-past-due-invoice/](https://www.enginatics.com/reports/ar-past-due-invoice/) |

## AR Past Due Invoice - Case Study & Technical Analysis

### Executive Summary

The **AR Past Due Invoice** report is a targeted collections tool designed to identify and list specific customer invoices that have exceeded their payment terms. Unlike summary aging reports that group debts into time buckets, this report provides a granular, line-item view of delinquent transactions, calculating the exact number of days each invoice is overdue. It is essential for prioritizing collection efforts and improving cash flow.

### Business Challenge

Effective cash collection requires knowing exactly which debts are overdue and by how much.
*   **Prioritization:** Collections agents have limited time. They need to know whether to focus on a large invoice that is 5 days late or a smaller one that is 90 days late.
*   **Precision:** When calling a customer, the agent needs specific invoice numbers and dates to dispute excuses and demand payment.
*   **DSO Management:** Reducing Days Sales Outstanding (DSO) requires immediate visibility into invoices as soon as they cross the "due" threshold.

### Solution

The **AR Past Due Invoice** report empowers the collections team by:
*   **Exact Aging:** Calculating the precise "Days Late" for every open item.
*   **Segmentation:** Allowing filters by "Days Late" (e.g., 1-30 days vs. 60+ days) to drive different dunning strategies (e.g., email reminder vs. phone call).
*   **Assignment:** Filtering by "Collector" to generate personalized worklists for each team member.

### Technical Architecture

The report focuses on the payment schedule of open transactions.

#### Key Tables & Joins

*   **Schedule:** `AR_PAYMENT_SCHEDULES_ALL` is the core table. It holds the `DUE_DATE`, `AMOUNT_DUE_REMAINING`, and `STATUS`.
*   **Transaction Header:** `RA_CUSTOMER_TRX_ALL` provides the invoice number and original transaction details.
*   **Customer:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` identify the debtor.
*   **Collector:** `AR_COLLECTORS` (linked via `HZ_CUSTOMER_PROFILES`) allows the report to be segmented by the assigned agent.
*   **Salesperson:** `RA_SALESREPS` is included to allow sales teams to assist in collecting from their accounts.

#### Logic

1.  **Filter:** Selects transactions where `STATUS = 'OP'` (Open) and `AMOUNT_DUE_REMAINING > 0`.
2.  **Time Check:** Filters where `DUE_DATE < :As_Of_Date`.
3.  **Calculation:**
    $$ \text{Days Late} = \text{As Of Date} - \text{Due Date} $$
4.  **Sorting:** Typically ordered by Customer and then by Days Late (descending) to highlight the worst offenders.

### Parameters

*   **As of Date:** The reference date for calculating lateness (defaults to today).
*   **Days Late Low / High:** Defines the range of delinquency (e.g., Low=31, High=60 for a specific dunning campaign).
*   **Balance Due Low / High:** Filters out small, immaterial balances to focus on high-value debts.
*   **Collector:** Generates the report for a specific agent.
*   **Customer Name:** Targets a specific account for detailed review.

### FAQ

**Q: Does this report show invoices that are due today?**
A: Typically, "Past Due" implies `Due Date < As of Date`. If an invoice is due today, it is usually not considered past due until tomorrow.

**Q: Are disputed invoices included?**
A: Yes, unless specifically excluded by customization. A disputed invoice is still legally past due until the dispute is resolved or a credit is issued.

**Q: What happens if I run this for a past date?**
A: The report will show what *was* past due on that date, based on the open balance at that time (if the query logic supports historical "As of" reconstruction, though standard versions often look at current open items relative to a past date).


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
