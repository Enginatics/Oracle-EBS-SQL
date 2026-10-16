---
layout: default
last_modified_at: 2026-10-16
title: 'AR Transactions and Lines | Oracle EBS SQL Report'
description: 'AR transaction report. Can be run at Header, Line and/or Distribution Level Display Level Lines and Sales Credits lists each line once per salesperson…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Receivables, Enginatics, Transactions, Lines, ra_customer_trx_all, ar_cons_inv_trx_all, ar_cons_inv_all'
permalink: /AR%20Transactions%20and%20Lines/
report_name: 'AR Transactions and Lines'
report_web_name: ar-transactions-and-lines
module: 'Receivables'
module_url: /modules/receivables/
---

# AR Transactions and Lines – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ar-transactions-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines).
**Oracle EBS module:** [Receivables](/modules/receivables/ "Oracle EBS Receivables reports") · [all Receivables reports](/modules/receivables/)  

## Overview
AR transaction report.
Can be run at Header, Line and/or Distribution Level

Display Level Lines and Sales Credits lists each line once per salesperson credit, with the revenue and non-revenue split. Transaction and line amounts are shown on the first row of a transaction or line only, so they can be summed.

Revenue As Of Date adds the accounting rule and the deferred revenue position of each line: Revenue Recognized is the sum of the revenue distributions with a GL date up to that date, and Unearned Balance is the line amount less that, for lines with an accounting rule or with revenue deferred by Revenue Management.
Optionally include special columns for service contracts (OKS) and lease contracts (OKL) data

When India Localization is installed, the following GST columns are also included: IGST Amount, CGST Amount, SGST Amount, CESS Amount, Custom Amount, Unclassified Tax Amount, HSN SAC Code, HSN Length Warning, GST State Tax Mismatch, CGST Recoverable, CGST Non-Recoverable, SGST Recoverable, SGST Non-Recoverable, IGST Recoverable, IGST Non-Recoverable, GST Registration No, GST PAN No, Reverse Charge Flag, Place of Supply, Ship From State, GST Warehouse Registration No, Taxable Value.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Ledger, Operating Unit, Display Level, Bill To Customer like, Bill To Customer Number, Consolidated Invoice Number, Transaction Number, Inv. Date Period, Inv. Date From, Inv. Date To, GL Period, GL Date From, GL Date To, Inv. Creation Date From, Inv. Creation Date To, Status, Overdue for more than x Days, Salesperson, Transaction Class, Transaction Type, Batch Source, Batch Name, Interface Category, Sales Order, Ship From Warehouse, Distribution Class, Distribution Account From, Distribution Account To, Print Date from, Print Date to, Display Contracts Details, Category Set 1, Category Set 2, Category Set 3, DFF Display, Revenue As Of Date, Deferred Revenue Only

## Oracle EBS Tables Used
[ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ar_cons_inv_trx_all](https://www.enginatics.com/library/?pg=1&find=ar_cons_inv_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ar_cons_inv_all](https://www.enginatics.com/library/?pg=1&find=ar_cons_inv_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [oe_sys_parameters_all](https://www.enginatics.com/library/?pg=1&find=oe_sys_parameters_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ar_xla_ctlgd_lines_v](https://www.enginatics.com/library/?pg=1&find=ar_xla_ctlgd_lines_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_batch_sources_all](https://www.enginatics.com/library/?pg=1&find=ra_batch_sources_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_batches_all](https://www.enginatics.com/library/?pg=1&find=ra_batches_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_cust_trx_types_all](https://www.enginatics.com/library/?pg=1&find=ra_cust_trx_types_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_terms_vl](https://www.enginatics.com/library/?pg=1&find=ra_terms_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_cust_site_uses_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_site_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_cust_acct_sites_all](https://www.enginatics.com/library/?pg=1&find=hz_cust_acct_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_party_sites](https://www.enginatics.com/library/?pg=1&find=hz_party_sites&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [hz_locations](https://www.enginatics.com/library/?pg=1&find=hz_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [fnd_territories_vl](https://www.enginatics.com/library/?pg=1&find=fnd_territories_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ra_territories_kfv](https://www.enginatics.com/library/?pg=1&find=ra_territories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [ar_receipt_methods](https://www.enginatics.com/library/?pg=1&find=ar_receipt_methods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [iby_fndcpt_pmt_chnnls_vl](https://www.enginatics.com/library/?pg=1&find=iby_fndcpt_pmt_chnnls_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [iby_fndcpt_tx_extensions](https://www.enginatics.com/library/?pg=1&find=iby_fndcpt_tx_extensions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [iby_pmt_instr_uses_all](https://www.enginatics.com/library/?pg=1&find=iby_pmt_instr_uses_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [iby_creditcard](https://www.enginatics.com/library/?pg=1&find=iby_creditcard&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines), [iby_ext_bank_accounts](https://www.enginatics.com/library/?pg=1&find=iby_ext_bank_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)


## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transactions%20and%20Lines/AR%20Transactions%20and%20Lines.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [AR Transactions and Lines 20-Jan-2019 115611.xlsx](https://www.enginatics.com/example/ar-transactions-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) |
| Blitz Report™ XML Import | [AR_Transactions_and_Lines.xml](https://www.enginatics.com/xml/ar-transactions-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) |
| SQL Source | [AR Transactions and Lines.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/AR%20Transactions%20and%20Lines/AR%20Transactions%20and%20Lines.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ar-transactions-and-lines/](https://www.enginatics.com/reports/ar-transactions-and-lines/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines) |

## Case Study & Technical Analysis: AR Transactions and Lines

### 1. Executive Summary

#### Business Problem
Accounts Receivable (AR) departments need detailed visibility into customer transactions to manage collections, resolve disputes, and analyze revenue. Standard reports often lack the flexibility to show data at different levels of granularity (Header, Line, Distribution) or to include industry-specific details like Service Contracts (OKS) or Lease Management (OKL). Common challenges include:
*   **Revenue Analysis:** Difficulty in analyzing revenue by Item, Product Category, or Salesperson.
*   **Reconciliation:** Tracing transactions from the sub-ledger to the General Ledger.
*   **Customer Service:** Quickly retrieving invoice details (PO Number, Ship-To Address, Line Items) to answer customer queries.
*   **Collections:** Identifying overdue invoices and their aging status.

#### Solution Overview
The **AR Transactions and Lines** report is a versatile, multi-level reporting tool that serves as the "Swiss Army Knife" for AR analysis. It allows users to run the report at the **Header** level (for aging and balances), **Line** level (for product and revenue analysis), or **Distribution** level (for accounting reconciliation). It enriches standard AR data with critical context from Order Management, Service Contracts, and Payments.

#### Key Benefits
*   **Multi-Level Reporting:** Dynamic columns allow users to drill down from Invoice Headers to specific Line Items and GL Distributions.
*   **360-Degree View:** Combines Customer, Billing, Shipping, Payment, and Accounting data in a single view.
*   **Cross-Module Integration:** Fetches related data from Order Management (Sales Orders), Service Contracts (Contract Numbers), and Payments (Credit Card/Bank details).
*   **Global Reach:** Supports multi-org and multi-currency reporting with consolidated billing numbers.
*   **Performance:** Optimized to handle high volumes of transaction data efficiently.

### 2. Technical Analysis

#### Core Tables and Views
The report queries the core AR transaction tables and links to several peripheral modules:
*   **`RA_CUSTOMER_TRX_ALL`**: The transaction header (Invoice, Credit Memo, Debit Memo).
*   **`RA_CUSTOMER_TRX_LINES_ALL`**: Transaction lines (Items, Tax, Freight).
*   **`AR_PAYMENT_SCHEDULES_ALL`**: Tracks the due dates, remaining balances, and payment status.
*   **`RA_CUST_TRX_LINE_GL_DIST_ALL`**: The accounting distributions (Revenue, Receivable, Tax accounts).
*   **`HZ_PARTIES` / `HZ_CUST_ACCOUNTS`**: Customer master data (TCA).
*   **`OE_ORDER_HEADERS_ALL`**: Links to Sales Orders.
*   **`OKC_K_HEADERS_ALL`**: Links to Service Contracts (optional).

#### SQL Logic and Data Flow
The SQL uses a modular approach with lexical parameters (`&line_columns`, `&distribution_columns`) to dynamically adjust the query based on the user's selected "Display Level".
*   **Dynamic Granularity:**
    *   **Header Level:** Aggregates data to one row per invoice.
    *   **Line Level:** Joins to `RA_CUSTOMER_TRX_LINES_ALL` to show item details.
    *   **Distribution Level:** Joins to `RA_CUST_TRX_LINE_GL_DIST_ALL` to show GL account splits.
*   **Consolidated Billing:** Logic to handle "Consolidated Invoices" (`AR_CONS_INV_ALL`), which group multiple AR invoices into a single customer-facing document.
*   **Address Formatting:** Uses `hz_format_pub.format_address` to generate standardized address strings for Bill-To and Ship-To locations.
*   **Conditional Columns:** Uses `CASE` statements to ensure that header-level amounts (Total Due, Tax Original) are only displayed on the first line of a multi-line invoice to prevent duplication in Excel sums.

#### Integration Points
*   **Order Management:** Fetches Sales Order numbers and Warehouses.
*   **General Ledger:** Validates Revenue and Receivable accounts.
*   **Service Contracts (OKS):** Optional join to fetch Contract Number, Start/End Dates for subscription billing.
*   **Payments:** Fetches Payment Methods and masked instrument numbers.

### 3. Functional Capabilities

#### Reporting Dimensions
*   **Customer Analysis:** Analyze revenue by Bill-To, Ship-To, or Paying Customer.
*   **Product Analysis:** Group by Inventory Item, Item Category, or Description.
*   **Sales Performance:** Analyze revenue by Salesperson or Sales Region.
*   **Financials:** Reconcile AR to GL by Transaction Type, Class, or Currency.

#### Key Parameters
*   **Display Level:** Header, Line, or Distribution.
*   **Date Ranges:** Transaction Date, GL Date, Creation Date.
*   **Status:** Open, Closed, Incomplete, Pending.
*   **Contracts:** Option to "Display Contracts Details" for OKS/OKL integration.

### 4. Implementation Considerations

#### Performance
*   **Granularity Impact:** Running at the "Distribution" level significantly increases row count. Users should be advised to use "Header" or "Line" unless specific accounting analysis is required.
*   **Date Filters:** Always enforce date ranges in high-volume environments.

#### Best Practices
*   **Revenue Recognition:** Use the "Distribution" level to audit Revenue Recognition rules and ensure revenue is posted to the correct periods.
*   **Data Quality:** Use the report to identify invoices with missing Salespersons or incorrect Territory assignments.
*   **Collections:** Use the "Overdue Days" calculation to prioritize collection efforts for high-value, aged invoices.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ar-transactions-and-lines)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
