---
layout: default
title: 'AR Disputed Invoice | Oracle EBS SQL Report'
description: 'Imported Oracle standard disputed invoice report Source: Disputed Invoice Report (XML) Short Name: ARXDIRXML DB package: ARARXDIRXMLPPKG'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, BI Publisher, Enginatics, R12 only, Disputed, Invoice, gl_sets_of_books, fnd_currencies, hr_operating_units'
permalink: /AR%20Disputed%20Invoice/
---

# AR Disputed Invoice – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-disputed-invoice/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported Oracle standard disputed invoice report
Source: Disputed Invoice Report (XML)
Short Name: ARXDIR_XML
DB package: AR_ARXDIR_XMLP_PKG

## Report Parameters
Operating Unit, Order By, Customer Name Low, Customer Name High, Customer Number Low, Customer Number High, Invoice Number Low, Invoice Number High, Due Date Low, Due Date High, Collector Low, Collector High, Invoice Status

## Oracle EBS Tables Used
[gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties), [hz_customer_profiles](https://www.enginatics.com/library/?pg=1&find=hz_customer_profiles), [&lp_table_show_bill_mo](https://www.enginatics.com/library/?pg=1&find=&lp_table_show_bill_mo), [ar_notes](https://www.enginatics.com/library/?pg=1&find=ar_notes)

## Report Categories
[BI Publisher](https://www.enginatics.com/library/?pg=1&category[]=BI%20Publisher), [Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[AR Customer Credit Limits](/AR%20Customer%20Credit%20Limits/ "AR Customer Credit Limits Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report"), [AR Customers and Sites](/AR%20Customers%20and%20Sites/ "AR Customers and Sites Oracle EBS SQL Report"), [AR Customer Upload](/AR%20Customer%20Upload/ "AR Customer Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Disputed Invoice 30-Sep-2020 221652.xlsx](https://www.enginatics.com/example/ar-disputed-invoice/) |
| Blitz Report™ XML Import | [AR_Disputed_Invoice.xml](https://www.enginatics.com/xml/ar-disputed-invoice/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-disputed-invoice/](https://www.enginatics.com/reports/ar-disputed-invoice/) |

## AR Disputed Invoice - Case Study & Technical Analysis

### Executive Summary

The **AR Disputed Invoice** report is a vital instrument for the Accounts Receivable and Collections departments. It provides a focused view of all customer invoices that are currently in a "Dispute" status. By isolating these transactions, organizations can prioritize conflict resolution, address customer grievances (such as pricing errors or quality issues), and ultimately accelerate cash collection to reduce Days Sales Outstanding (DSO).

### Business Challenge

In the Order-to-Cash cycle, disputes are a primary bottleneck. When a customer disputes an invoice, they typically withhold payment until the issue is resolved. Common challenges include:

*   **Visibility:** Collections agents may unknowingly chase a customer for payment on an invoice that is already known to be problematic.
*   **Resolution Time:** Without a centralized list, disputes can languish in the system, aging and becoming harder to collect.
*   **Cash Flow Impact:** A significant volume of disputed amounts artificially inflates the Accounts Receivable balance while representing cash that cannot yet be collected.

### Solution

The **AR Disputed Invoice** report addresses these challenges by:

*   **Centralized Tracking:** Listing all disputed items in one place, allowing managers to assess the total value of disputed cash.
*   **Collector Assignment:** Enabling filtering by "Collector," so individual agents can receive a targeted list of disputes they are responsible for resolving.
*   **Detail Availability:** Providing key details such as the original invoice amount, the specific amount in dispute (which may be partial), and the transaction date.

### Technical Architecture

This report is based on the standard Oracle XML Publisher report `ARXDIR_XML`.

#### Key Tables & Joins

*   **Transaction Balance:** `AR_PAYMENT_SCHEDULES_ALL` is the core table. The report filters for records where `AMOUNT_IN_DISPUTE` is not null and not zero.
*   **Transaction Header:** `RA_CUSTOMER_TRX_ALL` provides the invoice number, date, and type.
*   **Customer Data:** `HZ_PARTIES` and `HZ_CUST_ACCOUNTS` provide customer names and numbers.
*   **Collectors:** `HZ_CUSTOMER_PROFILES` links the customer to their assigned Collector.
*   **Notes:** `AR_NOTES` (optional) may be joined to retrieve specific comments or reasons entered by the agent regarding the dispute.

#### Logic

The query logic focuses on the payment schedule (the open balance record).
1.  **Identification:** It identifies rows in `AR_PAYMENT_SCHEDULES_ALL` where the dispute class or amount indicates an active dispute.
2.  **Currency:** It handles multi-currency reporting, showing amounts in the entered currency.
3.  **Status:** It respects the "Invoice Status" parameter to show Open, Closed, or All transactions, though "Open" is the most common use case for collections.

### Parameters

*   **Operating Unit:** Filters by the specific business entity.
*   **Collector:** Allows generating the report for a specific collections agent.
*   **Customer Name/Number:** Filters for a specific client.
*   **Invoice Status:** Typically set to 'Open' to see currently unpaid disputed invoices.
*   **Order By:** Sorts the output, often by Customer or Invoice Date.

### FAQ

**Q: What constitutes a "Dispute" in Oracle AR?**
A: A dispute is flagged when a user enters a value in the "Dispute Amount" field on the Transaction or Collections window. This removes that amount from the "Amount Due Remaining" for dunning purposes but keeps it on the ledger.

**Q: Does this report show the reason for the dispute?**
A: Standard versions often show the dispute amount. If the report is customized or includes `AR_NOTES`, it can also show the reason code or comments entered by the collector.

**Q: If I credit the invoice, does it disappear from this report?**
A: If the credit memo fully offsets the dispute and the balance is cleared or the dispute amount is updated to zero, it will no longer appear as an open dispute.


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
