---
layout: default
last_modified_at: 2026-10-19
title: 'ONT Order to Cash Tracker | Oracle EBS SQL Report'
description: 'One row per sales order or quote line with the date of each step from quote to payment, and the accounting and GL posting of its invoice. Invoice columns…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Order Management, Enginatics, R12 only, ONT, Order, Cash, Tracker, ar_payment_schedules_all, ar_receivable_applications_all, ar_cash_receipts_all'
permalink: /ONT%20Order%20to%20Cash%20Tracker/
report_name: 'ONT Order to Cash Tracker'
report_web_name: ont-order-to-cash-tracker
module: 'Order Management'
module_url: /modules/order-management/
---

# ONT Order to Cash Tracker – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/ont-order-to-cash-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker).
**Oracle EBS module:** [Order Management](/modules/order-management/ "Oracle EBS Order Management reports") · [all Order Management reports](/modules/order-management/)  

## Overview
One row per sales order or quote line with the date of each step from quote to payment, and the accounting and GL posting of its invoice.

Invoice columns are those of the first invoice raised for the line; Invoiced Amount sums all its invoice lines. Amount Due Remaining is shown on the invoice's first order line only, so it can be summed. Paid Date is the date the invoice's last installment closed, Receipt Number the latest receipt applied to it.

Accounted Date is when final accounting was created for the invoice, GL Posted Date when its journal was posted.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Order Number, Quote Number, Customer Name, Account Number, Order Type, Phase, Ordered Date From, Ordered Date To, Creation Date From, Creation Date To, Incomplete Only

## Oracle EBS Tables Used
[ar_payment_schedules_all](https://www.enginatics.com/library/?pg=1&find=ar_payment_schedules_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [ar_receivable_applications_all](https://www.enginatics.com/library/?pg=1&find=ar_receivable_applications_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [ar_cash_receipts_all](https://www.enginatics.com/library/?pg=1&find=ar_cash_receipts_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [xla_transaction_entities](https://www.enginatics.com/library/?pg=1&find=xla_transaction_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [xla_ae_headers](https://www.enginatics.com/library/?pg=1&find=xla_ae_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [xla_ae_lines](https://www.enginatics.com/library/?pg=1&find=xla_ae_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [gl_import_references](https://www.enginatics.com/library/?pg=1&find=gl_import_references&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [gl_je_headers](https://www.enginatics.com/library/?pg=1&find=gl_je_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_order_holds_all](https://www.enginatics.com/library/?pg=1&find=oe_order_holds_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_hold_sources_all](https://www.enginatics.com/library/?pg=1&find=oe_hold_sources_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_hold_definitions](https://www.enginatics.com/library/?pg=1&find=oe_hold_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [ra_customer_trx_lines_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [jtf_rs_salesreps](https://www.enginatics.com/library/?pg=1&find=jtf_rs_salesreps&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [jtf_rs_resource_extns_vl](https://www.enginatics.com/library/?pg=1&find=jtf_rs_resource_extns_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [ra_customer_trx_all](https://www.enginatics.com/library/?pg=1&find=ra_customer_trx_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AR Open Balances Revaluation](/AR%20Open%20Balances%20Revaluation/ "AR Open Balances Revaluation Oracle EBS SQL Report"), [GL Account Analysis 11g](/GL%20Account%20Analysis%2011g/ "GL Account Analysis 11g Oracle EBS SQL Report"), [GL Account Analysis (Drilldown)](/GL%20Account%20Analysis%20%28Drilldown%29/ "GL Account Analysis (Drilldown) Oracle EBS SQL Report"), [AR Aging](/AR%20Aging/ "AR Aging Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Order%20to%20Cash%20Tracker/ONT%20Order%20to%20Cash%20Tracker.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/ont-order-to-cash-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) |
| Blitz Report™ XML Import | [ONT_Order_to_Cash_Tracker.xml](https://www.enginatics.com/xml/ont-order-to-cash-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) |
| SQL Source | [ONT Order to Cash Tracker.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/ONT%20Order%20to%20Cash%20Tracker/ONT%20Order%20to%20Cash%20Tracker.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/ont-order-to-cash-tracker/](https://www.enginatics.com/reports/ont-order-to-cash-tracker/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker) |

## Case Study & Technical Analysis: ONT Order to Cash Tracker

### Executive Summary
This report gives one row per sales order or quote line, with the date of each step from quotation to payment: order booking, hold, request and ship dates, invoice, due date, payment and the accounting and general ledger posting of the invoice. Order-to-cash managers and finance controllers use it to find where an order has stalled, to measure cycle time and to confirm that shipped orders have been invoiced, accounted and posted. It is a Release 12 report that runs in Excel through Blitz Report™.

### Business Challenge
*   **Stalled orders:** An order can stop at a hold, an unshipped line or an uninvoiced shipment, and the cause must be visible per line.
*   **Cycle time:** Managers need the elapsed steps from quote and booking through to shipment, invoice and payment to measure the process.
*   **Invoice completeness:** Shipped lines must have an invoice, and the invoice must be accounted and posted to the general ledger before period close.
*   **Cash visibility:** The receipt that paid an invoice and the date it was paid must be traceable from the order line.

### The Solution
*   Lists quote and order dates, booked date, order status, line status and the hold name and hold date that currently block each line.
*   Shows the request, schedule and ship dates and the shipped quantity of each line, next to the invoice number, invoice date and due date.
*   Adds the invoiced amount of all invoice lines for the order line, the amount remaining due, the paid date and the latest receipt applied to the invoice.
*   Shows the accounting date and the GL posted date of the invoice's journal, so that accounting and posting status can be checked.

### Technical Architecture (High Level)
#### Primary Tables
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the order and quote headers and lines, with the quote number, dates, status and quantities.
*   `OE_ORDER_HOLDS_ALL`, `OE_HOLD_SOURCES_ALL` and `OE_HOLD_DEFINITIONS`: the unreleased holds on each order or line and the hold names.
*   `RA_CUSTOMER_TRX_LINES_ALL` and `RA_CUSTOMER_TRX_ALL`: the invoice lines raised from order lines, and the invoice header.
*   `AR_PAYMENT_SCHEDULES_ALL`: the installments of each invoice, with due date, amount remaining, closure date and status.
*   `AR_RECEIVABLE_APPLICATIONS_ALL` and `AR_CASH_RECEIPTS_ALL`: the receipt applications and the receipt number.
*   `XLA_TRANSACTION_ENTITIES`, `XLA_AE_HEADERS` and `XLA_AE_LINES`: the subledger accounting entities, headers and lines of the invoice.
*   `GL_IMPORT_REFERENCES` and `GL_JE_HEADERS`: the link from subledger lines to the general ledger journal and its posting date.
*   `HR_ALL_ORGANIZATION_UNITS_VL`, `HZ_CUST_ACCOUNTS`, `HZ_PARTIES`, `OE_TRANSACTION_TYPES_TL`, `MTL_SYSTEM_ITEMS_VL`, `JTF_RS_SALESREPS` and `JTF_RS_RESOURCE_EXTNS_VL`: the operating unit, customer, order type, item and salesperson.

#### Logical Relationships
1.  Each header joins to its operating unit, customer, order type and salesperson, and to its lines.
2.  Each line is outer-joined to the invoice lines raised from it, by the order line identifier held as the interface line attribute on the invoice line.
3.  The invoice header is joined to the invoice lines, and its installments provide the due date, amount remaining, and paid date.
4.  The receipt number is the latest receipt applied to the invoice, ordered by application date.
5.  Subledger entities link to the invoice by transaction identifier, and to journals through GL import references.

### Parameters & Filtering
*   **Operating Unit:** restricts the orders to one operating unit within those the user can access.
*   **Order Number**, **Quote Number**, **Customer Name**, **Account Number** and **Order Type:** select the orders by identity.
*   **Phase:** selects quote or order phase.
*   **Ordered Date From** and **To**, **Creation Date From** and **To:** select orders by date.
*   **Incomplete Only:** a switch that restricts the output to orders and lines that are not yet complete through the order-to-cash steps.

### Performance & Optimization
*   The invoice amount, invoice number and receipt lookups are correlated subqueries per order line, so the number of lines in scope is the main factor in run time.
*   Operating unit restriction through `MO_GLOB_ORG_ACCESS_TMP` is applied in the inline view before the joins to the order tables.
*   The receipt number uses an analytic last-value function over the application date, which picks the latest application without a second pass.
*   Accounting and posting dates are read only where an invoice exists.

### FAQ
**Q: Why is the amount remaining shown on only one line per invoice?**
A: The amount due remaining is shown on the first order line of each invoice, so that the column can be summed without counting the same invoice more than once.

**Q: What does the Invoiced Amount column add up?**
A: It sums all the invoice lines raised from the order line, so partial and multiple invoices are reflected in the total.

**Q: How can I tell whether an invoice has been posted to the general ledger?**
A: The GL Posted Date column shows the date of the journal posting for the invoice, and it is blank until the journal is posted.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=ont-order-to-cash-tracker)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
