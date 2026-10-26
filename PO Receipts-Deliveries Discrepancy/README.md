---
layout: default
last_modified_at: 2026-10-26
title: 'PO Receipts/Deliveries Discrepancy | Oracle EBS SQL Report'
description: 'PO Receipts/Deliveries Discrepancy highlights, at purchase order line and release level, differences between the quantities and amounts received into…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, R12 only, Receipts/Deliveries, Discrepancy, po_line_locations_all, rcv_transactions, rcv_shipment_headers'
permalink: /PO%20Receipts-Deliveries%20Discrepancy/
report_name: 'PO Receipts/Deliveries Discrepancy'
report_web_name: po-receipts-deliveries-discrepancy
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Receipts/Deliveries Discrepancy – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-receipts-deliveries-discrepancy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
PO Receipts/Deliveries Discrepancy highlights, at purchase order line and release level, differences between the quantities and amounts received into receiving (transaction type RECEIVE) and delivered to their final destination (DELIVER), including the impact of any CORRECT transactions applied to either side.

Quantity Received and Quantity Delivered show the original transaction quantities, Quantity Corrected Receipt and Quantity Corrected Delivery the net correction impact, and Total Quantity Received and Total Quantity Delivered the corrected totals. Quantity Variance and Cost Variance compare the corrected totals, with amounts valued at the purchase price of each receiving transaction.

Return to Vendor and Return to Receiving quantities (net of their corrections) are shown for reference but are not netted into the variance columns.

Provide a Last Receipt Date range (required): the report shows purchase order lines that had a receipt within that range, and for each it nets ALL of the line's receiving transactions to date, so the variance reflects the current outstanding received-vs-delivered position, not just activity in the window. Narrow the range (and/or add a PO, Supplier or Item filter) to keep large organizations fast.

By default the report shows discrepancy rows only (quantity or cost variance different from zero). Set parameter Discrepancies Only to No to list all purchase order receiving activity for the selected lines.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Supplier, PO Number, Item, Last Receipt Date From, Last Receipt Date To, Discrepancies Only

## Oracle EBS Tables Used
[po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)

## Related Reports
[PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [AP Invoices with PO, Intercompany and SLA Details](/AP%20Invoices%20with%20PO-%20Intercompany%20and%20SLA%20Details/ "AP Invoices with PO, Intercompany and SLA Details Oracle EBS SQL Report"), [PO Receiving Transactions](/PO%20Receiving%20Transactions/ "PO Receiving Transactions Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [PO Purchase Requisitions with PO Details](/PO%20Purchase%20Requisitions%20with%20PO%20Details/ "PO Purchase Requisitions with PO Details Oracle EBS SQL Report"), [AP Invoices and Lines](/AP%20Invoices%20and%20Lines/ "AP Invoices and Lines Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receipts-Deliveries%20Discrepancy/PO%20Receipts-Deliveries%20Discrepancy.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [Example](https://www.enginatics.com/example/po-receipts-deliveries-discrepancy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) |
| Blitz Report™ XML Import | [PO_Receipts_Deliveries_Discrepancy.xml](https://www.enginatics.com/xml/po-receipts-deliveries-discrepancy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) |
| SQL Source | [PO Receipts-Deliveries Discrepancy.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receipts-Deliveries%20Discrepancy/PO%20Receipts-Deliveries%20Discrepancy.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-receipts-deliveries-discrepancy/](https://www.enginatics.com/reports/po-receipts-deliveries-discrepancy/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy) |

## Case Study & Technical Analysis: PO Receipts/Deliveries Discrepancy

### Executive Summary
The PO Receipts/Deliveries Discrepancy report finds purchase order lines and releases where the quantity and cost received into receiving differ from the quantity and cost delivered to the final destination. It is written for receiving managers, inventory accountants and purchasing teams who must clear the in-transit and receiving balances that build up when goods are received but not delivered, or delivered without a matching receipt. ## Business Challenge
*   **Goods received but not delivered:** Material accepted into receiving but never delivered to its destination leaves a balance that inflates inventory and accruals.
*   **Corrections obscure the position:** Receipt and delivery corrections change the quantities after the original transactions, so the true position must net them.
*   **Cost variance from purchase price:** Received and delivered value must be compared at the purchase price of each transaction, so that price differences are visible.

### The Solution
*   **Net outstanding position:** For each line, all receiving transactions to date are netted, so the variance reflects the current outstanding position rather than only the activity in the chosen window.
*   **Original and corrected quantities:** Receipt and delivery quantities are shown as recorded, alongside the net correction impact, and the corrected totals are then shown.
*   **Variance columns:** Quantity variance and cost variance compare the corrected totals, with amounts valued at each receiving transaction's purchase price.

### Technical Architecture (High Level)
#### Primary Tables
*   `RCV_TRANSACTIONS`: the receiving transactions of type RECEIVE, DELIVER, CORRECT, RETURN TO VENDOR and RETURN TO RECEIVING, the core of the report.
*   `RCV_SHIPMENT_HEADERS`: the shipment headers that carry the receipt number.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL` and `PO_RELEASES_ALL`: the purchase order header, line and release.
*   `PO_LINE_LOCATIONS_ALL`: the shipments, used for the quantity requested.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `MTL_SYSTEM_ITEMS_VL`: the item and item description.
*   `HR_OPERATING_UNITS`: the operating unit.
*   `ORG_ACCESS_VIEW` and `MO_GLOB_ORG_ACCESS_TMP`: the organisations accessible to the current user.

#### Logical Relationships
1. A distinct list of purchase order lines and organisations with a RECEIVE transaction forms the driving set, and receiving transactions are joined to it on line and organisation.
2. Each correction transaction is joined to its parent transaction through `PARENT_TRANSACTION_ID`, so the correction can be classed as a receipt or delivery correction.
3. Receiving transactions join to `RCV_SHIPMENT_HEADERS` for the receipt number, and to `PO_HEADERS_ALL`, `PO_RELEASES_ALL` and `PO_LINES_ALL` for the purchase order.
4. Transactions join to the supplier through the purchase order header and to the supplier site as an outer join.
5. Items join to `MTL_SYSTEM_ITEMS_VL` on the item and organisation, as an outer join.
6. The result is grouped to one row per operating unit, organisation, purchase order, release and line, and then wrapped in an outer query that returns the final columns.

### Parameters & Filtering
*   **Operating Unit and Organization Code:** Restrict the output to one operating unit or inventory organisation.
*   **Supplier and PO Number:** Restrict the lines to one supplier or purchase order.
*   **Item:** Restricts the lines to one item.
*   **Last Receipt Date From and Last Receipt Date To:** Required. They select the lines that had a receipt within the range, while all receiving transactions of those lines are still netted.
*   **Discrepancies Only:** When Yes, the default, only lines with a non-zero quantity or cost variance are shown. When No, all receiving activity for the selected lines is listed.

### Performance & Optimization
*   **Driving line set:** A distinct list of lines with receipts forms the driving set, so the transaction table is read only for lines that have been received.
*   **Single aggregation pass:** Quantities and amounts for each transaction type are computed with conditional aggregation in one `group by`, rather than in separate subqueries.
*   **Range requirement:** The required receipt date range is the main control on the size of the result, and the description recommends narrowing it, with a purchase order, supplier or item filter, for large organisations.

### FAQ
**Q: How do I find purchase order lines where received and delivered quantities do not match in Oracle Purchasing?**
A: Run PO Receipts/Deliveries Discrepancy with a last receipt date range and read the quantity variance and cost variance columns, which are non-zero for discrepancies.

**Q: Why does the variance not include returns to vendor?**
A: Returns to vendor and returns to receiving are shown for reference, and the description states that they are not netted into the variance columns.

**Q: Why are older receipts included when I enter a narrow date range?**
A: The date range selects the lines that had a receipt within it, but all receiving transactions of those lines are netted to date, so the variance is the current outstanding position.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receipts-deliveries-discrepancy)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
