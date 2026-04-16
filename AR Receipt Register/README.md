---
layout: default
title: 'AR Receipt Register | Oracle EBS SQL Report'
description: 'Application: Receivables Description: Receivables Receipt Register Provided Templates: Default: Detail - Detail Listing with no Pivot Summarization Pivot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Receipt, Register, ar_receivable_apps_all_mrc_v, ar_receivable_applications_all, ar_payment_schedules_all'
permalink: /AR%20Receipt%20Register/
---

# AR Receipt Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-receipt-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Receivables
Description: Receivables Receipt Register

Provided Templates:
Default: Detail - Detail Listing with no Pivot Summarization
Pivot: Summary by Receipt Date - Summary by Balancing Segment, Receipt Currency, Receipt Date
Pivot: Summary by Receipt Status - Summary by Balancing Segment, Receipt Status
Pivot: Summary by Batch - Summary by Balancing Segment, Receipt Currency, Batch
Pivot: Summary by Customer Name - Summary by Balancing Segment, Receipt Currency, Customer
Pivot: Summary by Debit Account - Summary by Balancing Segment, Account Segment, Debit Account, Receipt Currency
Pivot: Summary by GL Date - Summary by Balancing Segment, Receipt Currency, GL Date

Source: Receipt Register
Short Name: ARRXRCRG/RXARRCRG


## Report Parameters
Reporting Level, Reporting Context, Balancing Segment Low, Balancing Segment High, Accounting Period, GL Date From, GL Date To, Entered Currency, Customer Name, Customer Name Low, Customer Name High, Customer Account Number, Customer Account Num Low, Customer Account Num High, Receipt Method, Receipt Status, Batch Name Low, Batch Name High, Receipt Date From, Receipt Date To, Deposit Date From, Deposit Date To, Receipt Last Updated From, Receipt Last Updated To, Receipt Number Low, Receipt Number High, Document Sequence Name, Document Number Low, Document Number High, Revaluation Currency, Revaluation Rate Type, Revaluation Date

## Oracle EBS Tables Used
[ar_receivable_apps_all_mrc_v](https://www.enginatics.com/library/?pg=1&find=ar_receivable_apps_all_mrc_v), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all), [ar_batches_all](https://www.enginatics.com/library/?pg=1&find=ar_batches_all), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all), [ap_inv_selection_criteria_all](https://www.enginatics.com/library/?pg=1&find=ap_inv_selection_criteria_all), [ap_checks_all](https://www.enginatics.com/library/?pg=1&find=ap_checks_all), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Receipt Register - Default Detail 01-Feb-2023 120010.xlsx](https://www.enginatics.com/example/ar-receipt-register/) |
| Blitz Report™ XML Import | [AR_Receipt_Register.xml](https://www.enginatics.com/xml/ar-receipt-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ar-receipt-register/](https://www.enginatics.com/reports/ar-receipt-register/) |

## AR Receipt Register Report

### Executive Summary
The AR Receipt Register provides a comprehensive listing of all customer receipts, including their status, application, and accounting information. This report is a fundamental tool for accounts receivable departments, offering a detailed and auditable trail of all cash inflows. By providing a consolidated view of receipts, the report helps to ensure the accuracy of cash and accounts receivable balances, facilitate reconciliation, and improve cash flow management.

### Business Challenge
Managing and tracking customer receipts is a critical function for any business. However, many organizations face challenges in effectively managing their receipts, including:
- **Lack of Visibility:** Difficulty in getting a clear and up-to-date view of all customer receipts, which can lead to delays in applying cash and an increased risk of errors.
- **Reconciliation Issues:** Discrepancies between the accounts receivable subledger and the general ledger, which can result in inaccurate financial reporting.
- **Inefficient Cash Application:** The process of applying cash to outstanding invoices can be time-consuming and manual, particularly in organizations with a high volume of receipts.
- **Customer Inquiries:** Difficulty in quickly and accurately responding to customer inquiries about the status of their payments.

### The Solution
The AR Receipt Register provides a detailed and actionable view of all customer receipts, helping organizations to:
- **Improve Cash Management:** By providing a clear and timely view of all cash inflows, the report enables organizations to optimize their cash flow and ensure that they have the right amount of cash in the right place at the right time.
- **Streamline Reconciliation:** The report makes it easier to reconcile the accounts receivable subledger with the general ledger, helping to ensure the accuracy of financial statements.
- **Enhance Cash Application:** The report provides a clear and consolidated view of all receipts, which can help to streamline the cash application process and reduce the risk of errors.
- **Improve Customer Service:** By providing a quick and easy way to look up the status of customer payments, the report can help to improve customer service and resolve inquiries more efficiently.

### Technical Architecture (High Level)
The report is based on a query of several key tables in the Oracle Receivables module. The primary tables used include:
- **ar_cash_receipts_all:** This table stores the main information about each receipt, including the receipt number, date, and amount.
- **ar_receivable_applications_all:** This table stores information about how receipts have been applied to invoices.
- **ar_batches_all:** This table contains information about the receipt batches.
- **ra_customer_trx_all:** This table is used to retrieve information about the invoices that the receipts have been applied to.

### Parameters & Filtering
The report includes a wide range of parameters that allow you to customize the output to your specific needs. The key parameters include:
- **Reporting Level and Context:** These parameters allow you to run the report for a specific ledger or operating unit, or for all accessible ledgers or operating units.
- **GL Date Range:** This parameter allows you to filter the report by the GL date of the receipts.
- **Customer Name and Account Number:** These parameters allow you to filter the report by a specific customer.
- **Receipt Method and Status:** These parameters allow you to filter the report by the receipt method and status.
- **Receipt Date Range:** This parameter allows you to filter the report by the date of the receipts.

### Performance & Optimization
The AR Receipt Register is designed to be both efficient and flexible. It is optimized to use the standard indexes on the Oracle Receivables tables, which helps to ensure that the report runs quickly, even with large amounts of data.

### FAQ
**Q: What is the difference between the "Receipt Register" and the "Applied Receipts Register"?**
A: The "Receipt Register" provides a listing of all receipts, regardless of whether they have been applied to an invoice or not. The "Applied Receipts Register" focuses specifically on receipts that have been applied to invoices.

**Q: Can I use this report to see the unapplied and on-account portions of a receipt?**
A: Yes, the report provides a detailed breakdown of each receipt, including the unapplied and on-account amounts.

**Q: Can I use this report to see the details of the invoices that a receipt was applied to?**
A: Yes, the report provides a detailed breakdown of each receipt application, including the invoice number, the amount applied, and the date of the application.

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
