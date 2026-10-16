---
layout: default
last_modified_at: 2026-10-16
title: 'INL Landed Cost Adjustments | Oracle EBS SQL Report'
description: 'Landed cost adjustments processed by Cost Management, with the receiving accounting they generated. One row per accounting line of each adjustment: the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Oracle Landed Cost Management, Enginatics, R12 only, INL, Landed, Cost, Adjustments, rcv_accounting_event_types, xla_event_types_vl, cst_lc_adj_transactions'
permalink: /INL%20Landed%20Cost%20Adjustments/
report_name: 'INL Landed Cost Adjustments'
report_web_name: inl-landed-cost-adjustments
module: 'Oracle Landed Cost Management'
module_url: /modules/oracle-landed-cost-management/
---

# INL Landed Cost Adjustments – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inl-landed-cost-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments).
**Oracle EBS module:** [Oracle Landed Cost Management](/modules/oracle-landed-cost-management/ "Oracle EBS Oracle Landed Cost Management reports") · [all Oracle Landed Cost Management reports](/modules/oracle-landed-cost-management/)  

## Overview
Landed cost adjustments processed by Cost Management, with the receiving accounting they generated.

One row per accounting line of each adjustment: the adjustment of the receipt (Receiving Inspection against Landed Cost Absorption) and, for delivered quantities, the adjustment of the delivery (Purchase Price Variance in a standard cost organization, otherwise the inventory or expense account). Adjustment Value, the unit landed cost change times the receipt quantity, is shown on the first row of each adjustment only, so that it can be summed.

Adjustments still pending or in error in the interface are listed by CAC Interface Error Summary.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Transaction Date From, Transaction Date To, Shipment Number, PO Number, Item

## Oracle EBS Tables Used
[rcv_accounting_event_types](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_event_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [xla_event_types_vl](https://www.enginatics.com/library/?pg=1&find=xla_event_types_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [cst_lc_adj_transactions](https://www.enginatics.com/library/?pg=1&find=cst_lc_adj_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [inl_ship_lines_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [inl_ship_headers_all](https://www.enginatics.com/library/?pg=1&find=inl_ship_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [rcv_accounting_events](https://www.enginatics.com/library/?pg=1&find=rcv_accounting_events&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [rcv_receiving_sub_ledger](https://www.enginatics.com/library/?pg=1&find=rcv_receiving_sub_ledger&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)

## Related Reports
[CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Cost%20Adjustments/INL%20Landed%20Cost%20Adjustments.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INL Landed Cost Adjustments 10-Oct-2026 151355.xlsx](https://www.enginatics.com/example/inl-landed-cost-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) |
| Blitz Report™ XML Import | [INL_Landed_Cost_Adjustments.xml](https://www.enginatics.com/xml/inl-landed-cost-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) |
| SQL Source | [INL Landed Cost Adjustments.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INL%20Landed%20Cost%20Adjustments/INL%20Landed%20Cost%20Adjustments.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inl-landed-cost-adjustments/](https://www.enginatics.com/reports/inl-landed-cost-adjustments/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments) |

## Case Study & Technical Analysis: INL Landed Cost Adjustments

### Executive Summary
The INL Landed Cost Adjustments report lists the landed cost adjustments that Oracle Cost Management has processed for receipts, together with the receiving accounting that each adjustment generated. It has one row per accounting line of each adjustment. Cost accountants use it to see how a change in landed cost, such as a late freight or duty invoice, changed the value of received inventory, and to confirm which accounts were debited and credited. It supports the Landed Cost Management reconciliation of receiving accruals and inventory value. The report runs in Excel through Blitz Report.

### Business Challenge
*   **Inventory valuation:** When landed costs change after receipt, the value of the received inventory changes, and the accountant must show by how much and in which accounts.
*   **Receiving accounting:** Each adjustment creates receiving accounting lines that must be traced to the receipt, the shipment and the purchase order.
*   **Standard cost variances:** In a standard cost organization, the delivered portion of the adjustment must be booked to purchase price variance, not to inventory.
*   **Pending adjustments:** Adjustments still pending or in error in the interface must be found separately, as they have no accounting yet.

### The Solution
*   Lists each landed cost adjustment with its transaction date, item, receipt number, receipt quantity and unit of measure.
*   Shows the prior and new unit landed cost, the unit change, and the adjustment value, which is the unit change multiplied by the receipt quantity.
*   Shows the receiving accounting event type, the accounting date, the period, the accounting line type and the account with its description.
*   Shows the debit, credit and net accounted amounts of each line, so the lines can be summed by account.

### Technical Architecture (High Level)
#### Primary Tables
*   `CST_LC_ADJ_TRANSACTIONS`: the landed cost adjustment, with its prior and new landed cost, transaction date and organization.
*   `RCV_TRANSACTIONS` and `RCV_SHIPMENT_HEADERS`: the receipt transaction and its shipment header.
*   `INL_SHIP_LINES_ALL` and `INL_SHIP_HEADERS_ALL`: the Landed Cost Management shipment line and header.
*   `PO_LINES_ALL` and `PO_HEADERS_ALL`: the purchase order line and header of the receipt.
*   `RCV_ACCOUNTING_EVENTS` and `RCV_RECEIVING_SUB_LEDGER`: the receiving accounting events and their sub-ledger lines.
*   `RCV_ACCOUNTING_EVENT_TYPES` and `XLA_EVENT_TYPES_VL`: the receiving event type names.
*   `GL_CODE_COMBINATIONS_KFV`, `GL_LEDGERS`, `MTL_PARAMETERS`, `ORG_ORGANIZATION_DEFINITIONS` and `HR_ALL_ORGANIZATION_UNITS_VL`: the account, ledger, organization and operating unit.
*   `ORG_ACCESS_VIEW`: the organizations that the responsibility can access.

#### Logical Relationships
1.  `CST_LC_ADJ_TRANSACTIONS` is joined to `RCV_TRANSACTIONS` on the receipt transaction id, and the receipt is joined to its shipment header and to the purchase order.
2.  The Landed Cost Management shipment line and header are outer joined from the receipt through the LCM shipment line id.
3.  `CST_LC_ADJ_TRANSACTIONS` is joined to `RCV_ACCOUNTING_EVENTS` where the event source is LC_ADJUSTMENTS and the source id is the adjustment transaction id.
4.  Each accounting event is joined to `RCV_RECEIVING_SUB_LEDGER`, which holds the accounting lines, and each line to its account in `GL_CODE_COMBINATIONS_KFV`.
5.  The operating unit comes from the organization's set of books through `ORG_ORGANIZATION_DEFINITIONS` and `GL_LEDGERS`.

### Parameters & Filtering
*   **Operating Unit** and **Organization Code:** restrict the adjustments to one operating unit or inventory organization.
*   **Transaction Date From** and **Transaction Date To:** bound the transaction dates of the adjustments.
*   **Shipment Number**, **PO Number** and **Item:** select the adjustments of one shipment, purchase order or item.

### Performance & Optimization
*   The organization restriction is a subquery on `ORG_ACCESS_VIEW`, so the adjustments read are limited to the responsibility's organizations.
*   The adjustment value is calculated with an analytic ROW_NUMBER over the transaction, so it is shown once per adjustment and can be summed without repetition.
*   The outer joins to the LCM shipment tables are used only where a receipt has a landed cost shipment, so receipts without one are not dropped.
*   Filtering by Organization Code and Transaction Date limits the adjustment rows before the accounting joins, which is the largest part of the query.

### FAQ
**Q: How do I see the value that a landed cost adjustment added to a receipt?**
A: Sum the Adjustment Value column. It is shown on the first accounting row of each adjustment only, so the total is not multiplied by the number of accounting lines.

**Q: Why are some adjustments not listed?**
A: Adjustments that are still pending or in error in the interface have no receiving accounting yet. They are listed in the CAC Interface Error Summary report, as the description states.

**Q: Which account receives the adjustment in a standard cost organization?**
A: For delivered quantities the adjustment goes to Purchase Price Variance. Otherwise, the account is the inventory or expense account of the receiving accounting line.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inl-landed-cost-adjustments)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
