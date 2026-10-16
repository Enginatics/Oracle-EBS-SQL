---
layout: default
last_modified_at: 2026-10-16
title: 'AP Accounted Invoice Aging | Oracle EBS SQL Report'
description: 'Application: Payables Report: Accounts Payable Accounted Invoice Aging Report Pre-requisite: XLATRIALBALANCES should be populated before running this…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Payables, Enginatics, R12 only, Accounted, Invoice, Aging, xla_trial_balances, xla_tb_definitions_vl, gl_ledgers'
permalink: /AP%20Accounted%20Invoice%20Aging/
report_name: 'AP Accounted Invoice Aging'
report_web_name: ap-accounted-invoice-aging
module: 'Payables'
module_url: /modules/payables/
---

# AP Accounted Invoice Aging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ap-accounted-invoice-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging).
**Oracle EBS module:** [Payables](/modules/payables/ "Oracle EBS Payables reports") · [all Payables reports](/modules/payables/)  

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

When India Localization is installed, the following GST columns are also included: GST Registration No, GST PAN No, GST TAN No, CESS Amount, CGST Amount, Custom Amount, IGST Amount, SGST Amount, Unclassified Tax Amount, Taxable Value, HSN SAC Code, CESS Rate, CGST Rate, IGST Rate, SGST Rate, CGST Non-Recoverable, CGST Recoverable, IGST Non-Recoverable, IGST Recoverable, SGST Non-Recoverable, SGST Recoverable, Reverse Charge Flag.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Report Definition, As of Date, Aging Bucket Name, Third Party Name, Payables Account From, Payables Account To, Exclude Fully Paid, Exclude Cancelled, Revaluation Currency, Revaluation Rate Type, Revaluation Date, As of Relative Period Close

## Oracle EBS Tables Used
[xla_trial_balances](https://www.enginatics.com/library/?pg=1&find=xla_trial_balances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [xla_tb_definitions_vl](https://www.enginatics.com/library/?pg=1&find=xla_tb_definitions_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_access_sets](https://www.enginatics.com/library/?pg=1&find=gl_access_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_access_set_assignments](https://www.enginatics.com/library/?pg=1&find=gl_access_set_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_periods](https://www.enginatics.com/library/?pg=1&find=gl_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [xla_tb_defn_je_sources](https://www.enginatics.com/library/?pg=1&find=xla_tb_defn_je_sources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [xla_subledgers](https://www.enginatics.com/library/?pg=1&find=xla_subledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [iby_payment_methods_vl](https://www.enginatics.com/library/?pg=1&find=iby_payment_methods_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_terms_vl](https://www.enginatics.com/library/?pg=1&find=ap_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_invoice_lines_all](https://www.enginatics.com/library/?pg=1&find=ap_invoice_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_holds_all](https://www.enginatics.com/library/?pg=1&find=ap_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ap_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [xla_entity_types_vl](https://www.enginatics.com/library/?pg=1&find=xla_entity_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_invoices_all](https://www.enginatics.com/library/?pg=1&find=ap_invoices_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [fnd_currencies_vl](https://www.enginatics.com/library/?pg=1&find=fnd_currencies_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [ce_bank_branches_v](https://www.enginatics.com/library/?pg=1&find=ce_bank_branches_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Accounted%20Invoice%20Aging/AP%20Accounted%20Invoice%20Aging.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AP Accounted Invoice Aging - TEST B1 19-Jan-2026 085443.xlsx](https://www.enginatics.com/example/ap-accounted-invoice-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) |
| Blitz Report™ XML Import | [AP_Accounted_Invoice_Aging.xml](https://www.enginatics.com/xml/ap-accounted-invoice-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) |
| SQL Source | [AP Accounted Invoice Aging.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AP%20Accounted%20Invoice%20Aging/AP%20Accounted%20Invoice%20Aging.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ap-accounted-invoice-aging/](https://www.enginatics.com/reports/ap-accounted-invoice-aging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ap-accounted-invoice-aging)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
