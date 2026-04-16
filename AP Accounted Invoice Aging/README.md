---
layout: default
title: 'AP Accounted Invoice Aging | Oracle EBS SQL Report'
description: 'Application: Payables Report: Accounts Payable Accounted Invoice Aging Report Pre-requisite: XLATRIALBALANCES should be populated before running this…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, Accounted, Invoice, Aging, xla_trial_balances, xla_tb_definitions_vl, gl_ledgers'
permalink: /AP%20Accounted%20Invoice%20Aging/
---

# AP Accounted Invoice Aging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-accounted-invoice-aging/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Application: Payables
Report: Accounts Payable Accounted Invoice Aging Report
Pre-requisite: XLA_TRIAL_BALANCES should be populated before running this report.

Description.
Report details Aging of outstanding amounts at a specified point in time for Accounted Invoices and relies mainly on the data in XLA_TRIAL_BALANCES table for the accounting information.
XLA_TRIAL_BALANCES data is inserted by the Open Account Balances Data Manager.
The Open Account Balances Data Manager maintains reportable information for all enabled open account balance listing definitions. This program is submitted automatically after a successful transfer to General Ledger for the same ledger or
manually by running the Open Account Balances Data Manager program. When changes are applied to a Open Account Balances Listing Definition, the Open Account Balances Data Manager program is automatically submitted for the changed definition.

For scheduling the report to run periodically, use the 'as of relative period close' offset parameter. This is the relative period offset to the current period, so when the current period changes, the period close as of date will also be automatically updated when the report is re-run.

## Report Parameters
Ledger, Operating Unit, Report Definition, As of Date, Aging Bucket Name, Third Party Name, Payables Account From, Payables Account To, Exclude Fully Paid, Exclude Cancelled, Revaluation Currency, Revaluation Rate Type, Revaluation Date, As of Relative Period Close

## Oracle EBS Tables Used
[xla_trial_balances](https://www.enginatics.com/library/?pg=1&find=xla_trial_balances), [xla_tb_definitions_vl](https://www.enginatics.com/library/?pg=1&find=xla_tb_definitions_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_access_sets](https://www.enginatics.com/library/?pg=1&find=gl_access_sets), [gl_access_set_assignments](https://www.enginatics.com/library/?pg=1&find=gl_access_set_assignments), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods), [xla_tb_defn_je_sources](https://www.enginatics.com/library/?pg=1&find=xla_tb_defn_je_sources), [xla_subledgers](https://www.enginatics.com/library/?pg=1&find=xla_subledgers), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Accounted Invoice Aging - TEST B1 19-Jan-2026 085443.xlsx](https://www.enginatics.com/example/ap-accounted-invoice-aging/) |
| Blitz Report™ XML Import | [AP_Accounted_Invoice_Aging.xml](https://www.enginatics.com/xml/ap-accounted-invoice-aging/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/ap-accounted-invoice-aging/](https://www.enginatics.com/reports/ap-accounted-invoice-aging/) |

## AP Accounted Invoice Aging Report

### Executive Summary
The AP Accounted Invoice Aging report provides a detailed analysis of outstanding accounts payable balances at a specific point in time. This report is crucial for financial managers and accounts payable teams to effectively manage cash flow, assess liabilities, and ensure timely payments to suppliers. By leveraging the `XLA_TRIAL_BALANCES` table, the report offers an accurate, accounted view of invoice aging, which is essential for financial reporting and reconciliation.

### Business Challenge
Managing accounts payable effectively is critical for maintaining healthy supplier relationships and optimizing cash flow. However, many organizations struggle with:
- **Lack of Visibility:** Difficulty in obtaining a clear and accurate picture of outstanding payables and their aging, leading to missed payments and strained supplier relationships.
- **Manual Reconciliation:** Spending significant time and effort manually reconciling supplier statements with internal records, a process that is both time-consuming and prone to errors.
- **Inaccurate Cash Flow Forecasting:** Inability to accurately forecast cash requirements due to a lack of timely and accurate information on upcoming payments.
- **Compliance and Audit Issues:** Difficulty in providing auditors with a clear and accurate record of outstanding liabilities, leading to potential compliance issues.

### The Solution
The AP Accounted Invoice Aging report provides a comprehensive and actionable view of outstanding payables. The report helps to:
- **Improve Cash Flow Management:** By providing a clear view of upcoming payments, the report helps organizations to better manage their cash flow and optimize their working capital.
- **Strengthen Supplier Relationships:** By ensuring that payments are made on time, the report helps to build and maintain strong relationships with suppliers.
- **Streamline Reconciliation:** The report provides a clear and accurate record of outstanding invoices, making it easier to reconcile supplier statements and resolve discrepancies.
- **Enhance Financial Reporting:** The report provides an accurate and up-to-date view of outstanding liabilities, which is essential for accurate financial reporting and analysis.

### Technical Architecture (High Level)
The report is built upon the `XLA_TRIAL_BALANCES` table, which stores the accounted balances for all subledger transactions. The key tables used in the report include:
- **xla_trial_balances:** The primary source of accounted invoice information.
- **ap_invoices_all:** Provides detailed information about each invoice, including the invoice number, date, and amount.
- **ap_payment_schedules_all:** Contains the payment schedule for each invoice, including the due date and amount due.
- **ap_suppliers:** Provides information about the suppliers, including their name and contact information.

The report joins these tables to provide a complete and accurate view of the accounted invoice aging.

### Parameters & Filtering
The report includes a wide range of parameters that allow you to customize the output to your specific needs. The key parameters include:
- **Ledger:** Specify the ledger for which you want to run the report.
- **Operating Unit:** Filter the report by a specific operating unit.
- **As of Date:** Specify the date for which you want to see the aging of outstanding invoices.
- **Aging Bucket Name:** Select the aging bucket definition that you want to use for the report.
- **Third Party Name:** Filter the report by a specific supplier.
- **Exclude Fully Paid:** Exclude invoices that have already been fully paid.
- **Exclude Cancelled:** Exclude invoices that have been cancelled.

### Performance & Optimization
The report is designed to run efficiently, even with large volumes of data. It is optimized to leverage the indexes on the `XLA_TRIAL_BALANCES` and `AP_INVOICES_ALL` tables, ensuring that the report runs quickly and does not impact the performance of the system.

### FAQ
**Q: What is the purpose of the `XLA_TRIAL_BALANCES` table?**
A: The `XLA_TRIAL_BALANCES` table is a key table in the Subledger Accounting (XLA) module. It stores the accounted balances for all subledger transactions, providing a single source of truth for all subledger-related reporting.

**Q: How is the data in the `XLA_TRIAL_BALANCES` table populated?**
A: The data in the `XLA_TRIAL_BALANCES` table is populated by the "Open Account Balances Data Manager" concurrent program. This program is typically run automatically after the "Transfer to General Ledger" program is run.

**Q: Can I schedule this report to run on a regular basis?**
A: Yes, the report can be scheduled to run on a regular basis using the standard Oracle EBS concurrent request scheduling functionality. The "as of relative period close" offset parameter is particularly useful for scheduling the report to run at the end of each period.

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
