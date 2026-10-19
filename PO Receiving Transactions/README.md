---
layout: default
last_modified_at: 2026-10-19
title: 'PO Receiving Transactions | Oracle EBS SQL Report'
description: 'Receiving transactions register: one row per receiving transaction (receive, accept, reject, transfer, deliver, return to supplier or receiving…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Purchasing, Enginatics, Receiving, Transactions, hr_operating_units, rcv_transactions, po_requisition_lines_all'
permalink: /PO%20Receiving%20Transactions/
report_name: 'PO Receiving Transactions'
report_web_name: po-receiving-transactions
module: 'Purchasing'
module_url: /modules/purchasing/
---

# PO Receiving Transactions – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/po-receiving-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions).
**Oracle EBS module:** [Purchasing](/modules/purchasing/ "Oracle EBS Purchasing reports") · [all Purchasing reports](/modules/purchasing/)  

## Overview
Receiving transactions register: one row per receiving transaction (receive, accept, reject, transfer, deliver, return to supplier or receiving, correction) for purchase orders, internal requisitions, RMAs and inter-organization shipments, with the source document, item, quantity and PO price.

Quantity In Receiving and Days In Receiving are current values from the receiving supply, populated only on the receive, accept, reject or transfer transaction whose quantity still sits in receiving. Days In Receiving counts from the receipt date.

Amount is quantity times PO unit price and is blank for sources without a PO price.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Operating Unit, Organization Code, Transaction Date From, Transaction Date To, Transaction Type, Source Document, Receipt Number, PO Number, Supplier, Item, Routing, In Receiving Only, Show Lot and Serial

## Oracle EBS Tables Used
[hr_operating_units](https://www.enginatics.com/library/?pg=1&find=hr_operating_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_releases_all](https://www.enginatics.com/library/?pg=1&find=po_releases_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [hz_cust_accounts](https://www.enginatics.com/library/?pg=1&find=hz_cust_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [hz_parties](https://www.enginatics.com/library/?pg=1&find=hz_parties&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [hr_locations_all](https://www.enginatics.com/library/?pg=1&find=hr_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_shipment_lines](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_routing_headers](https://www.enginatics.com/library/?pg=1&find=rcv_routing_headers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_supply](https://www.enginatics.com/library/?pg=1&find=rcv_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_lot_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_lot_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [rcv_serial_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_serial_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)

## Related Reports
[GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [CAC Interface Error Summary](/CAC%20Interface%20Error%20Summary/ "CAC Interface Error Summary Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report"), [INV Movement Statistics](/INV%20Movement%20Statistics/ "INV Movement Statistics Oracle EBS SQL Report"), [PO Internal Requisitions and Sales Orders](/PO%20Internal%20Requisitions%20and%20Sales%20Orders/ "PO Internal Requisitions and Sales Orders Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receiving%20Transactions/PO%20Receiving%20Transactions.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [PO Receiving Transactions 15-Oct-2026 022543.xlsx](https://www.enginatics.com/example/po-receiving-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) |
| Blitz Report™ XML Import | [PO_Receiving_Transactions.xml](https://www.enginatics.com/xml/po-receiving-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) |
| SQL Source | [PO Receiving Transactions.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/PO%20Receiving%20Transactions/PO%20Receiving%20Transactions.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/po-receiving-transactions/](https://www.enginatics.com/reports/po-receiving-transactions/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions) |

## Case Study & Technical Analysis: PO Receiving Transactions

### Executive Summary
PO Receiving Transactions is a register of Oracle Purchasing receiving activity, with one row for each receiving transaction. It covers receipts, acceptances, rejections, transfers, deliveries, returns to supplier or receiving, and corrections, for purchase orders, internal requisitions, RMA returns and inter-organization shipments. Receiving supervisors, inventory accountants and procurement analysts use it to trace what was received against each purchase order line, to find material that has been sitting in receiving too long, and to reconcile receipts with the purchase price.

### Business Challenge
*   **Receipt Traceability:** A supplier invoice cannot be matched until the receipt is confirmed, so the team needs to trace each receipt to its source document.
*   **Material In Receiving:** Goods left in the receiving area for long periods tie up stock and can be missed by planning.
*   **Price Exposure:** Receipt value at the PO price must be known for accrual and matching.
*   **Lot and Serial Visibility:** Controlled items need their lot and serial numbers shown against each receiving transaction.

### The Solution
*   **Transaction Register:** Each receiving transaction is listed with its type, parent transaction, source document, supplier, item, quantity and destination.
*   **Current Receiving Position:** For receive, accept, reject or transfer transactions whose quantity is still in receiving, the quantity in receiving and the days in receiving are shown.
*   **Value At PO Price:** The amount is the quantity multiplied by the PO unit price, and is blank where no PO price exists.
*   **Optional Lot and Serial Detail:** Lot and serial transactions can be included, so each controlled unit appears with its number and expiration date.

### Technical Architecture (High Level)
#### Primary Tables
*   `RCV_TRANSACTIONS`: the receiving transactions, with type, source document, quantities, PO price, destination and dates.
*   `RCV_SHIPMENT_HEADERS` and `RCV_SHIPMENT_LINES`: the receipt headers and lines, with receipt number, source and item.
*   `RCV_SUPPLY`: the material currently held in receiving.
*   `RCV_LOT_TRANSACTIONS` and `RCV_SERIAL_TRANSACTIONS`: the lot and serial detail of each transaction.
*   `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL` and `PO_RELEASES_ALL`: the purchase order, line, shipment and release records.
*   `PO_REQUISITION_HEADERS_ALL` and `PO_REQUISITION_LINES_ALL`: the internal requisition sources.
*   `OE_ORDER_HEADERS_ALL` and `OE_ORDER_LINES_ALL`: the RMA sources.
*   `AP_SUPPLIERS` and `AP_SUPPLIER_SITES_ALL`: the supplier and supplier site.
*   `MTL_SYSTEM_ITEMS_VL`, `MTL_PARAMETERS`, `MTL_ITEM_LOCATIONS_KFV` and `MTL_TRANSACTION_REASONS`: the item, organization, locator and reason.
*   `HR_OPERATING_UNITS`, `HR_ORGANIZATION_INFORMATION`, `HR_LOCATIONS_ALL` and `PER_ALL_PEOPLE_F`: the operating unit, the locations and the people.
*   `HZ_CUST_ACCOUNTS` and `HZ_PARTIES`: the customer for RMA sources.
*   `ORG_ACCESS_VIEW`: the organizations the user can access.

#### Logical Relationships
1.  Each receiving transaction in `RCV_TRANSACTIONS` is joined to its organization in `MTL_PARAMETERS` and to the accounting organization information in `HR_ORGANIZATION_INFORMATION`.
2.  Transactions are joined to their shipment header and line in `RCV_SHIPMENT_HEADERS` and `RCV_SHIPMENT_LINES`.
3.  Purchase order and shipment references are outer joined to `PO_HEADERS_ALL` and `PO_LINE_LOCATIONS_ALL`.
4.  Supplier and item references are outer joined to `AP_SUPPLIERS` and `MTL_SYSTEM_ITEMS_VL`.
5.  Each transaction is outer joined to `RCV_SUPPLY` for the quantity still in receiving.
6.  Lot and serial transactions are unioned into a single inline view and joined on the transaction identifier when the lot and serial option is set.

### Parameters & Filtering
*   **Operating Unit and Organization Code:** Restrict the transactions to an operating unit or an organization.
*   **Transaction Date From and Transaction Date To:** Limit the transactions to a date window.
*   **Transaction Type and Source Document:** Restrict the output to one receiving transaction type or one source.
*   **Receipt Number, PO Number, Supplier and Item:** Select the receipt, the purchase order, the supplier or the item.
*   **Routing:** Restricts the output to one receiving routing.
*   **In Receiving Only:** Limits the output to transactions whose quantity is still in receiving.
*   **Show Lot and Serial:** Adds lot and serial rows to the output.

### Performance & Optimization
*   **Organization Access Filter:** Transactions are restricted to organizations the responsibility can access before the detail joins are evaluated.
*   **Lot and Serial Branch Switch:** The lot and serial inline view contains a switch that makes it empty when the option is not set, so no lot data is read by default.
*   **Outer Joins For Optional Sources:** Purchase order, requisition, RMA and inventory sources are optional, so outer joins avoid dropping transactions from other sources.
*   **Keep Dense Rank for People:** Names of people are fetched with keep-dense-rank aggregates that return the latest name for each person.

### FAQ
**Q: How do I find receipts that have been in receiving for more than a week?**
A: Set In Receiving Only to Yes and review the Days In Receiving column. The value counts from the receipt date.

**Q: Why is the Amount column blank on some rows?**
A: The amount is quantity times the PO unit price, so it is blank for sources that have no PO price, such as some inventory transfers.

**Q: Can I see the lot and serial numbers of a receipt?**
A: Set Show Lot and Serial to Yes. Each controlled lot or serial unit is then listed against its receiving transaction.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=po-receiving-transactions)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
