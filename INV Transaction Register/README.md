---
layout: default
title: 'INV Transaction Register | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Transaction register Application: Inventory Source: Transaction register (XML) Short Name: INVTRREGXML DB package…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Transaction, Register, org_access_view, mtl_system_items_vl, mtl_transaction_types'
permalink: /INV%20Transaction%20Register/
---

# INV Transaction Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-transaction-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Transaction register
Application: Inventory
Source: Transaction register (XML)
Short Name: INVTRREG_XML
DB package: INV_INVTRREG_XMLP_PKG

## Report Parameters
Unit of Measure, Transaction Date From, Transaction Date To, Organization Code, Item From, Item To, Transaction Type From, Transaction Type To, Transaction Reason From, Transaction Reason To, Subinventory From, Subinventory To, Category Set, Category From, Category To, Transaction Source Type, Transaction Source From, Transaction Source To, Lot Number Detail, Serial Number Detail

## Oracle EBS Tables Used
[org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_sales_orders_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_generic_dispositions_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions_kfv), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers), [mtl_unit_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_unit_transactions)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Lot Transaction Register](/INV%20Lot%20Transaction%20Register/ "INV Lot Transaction Register Oracle EBS SQL Report"), [INV Material Account Distribution Detail](/INV%20Material%20Account%20Distribution%20Detail/ "INV Material Account Distribution Detail Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [INV Intercompany Invoice Reconciliation](/INV%20Intercompany%20Invoice%20Reconciliation/ "INV Intercompany Invoice Reconciliation Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Transaction Register - Pivot Summaries 09-Aug-2023 054002.xlsx](https://www.enginatics.com/example/inv-transaction-register/) |
| Blitz Report™ XML Import | [INV_Transaction_Register.xml](https://www.enginatics.com/xml/inv-transaction-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-transaction-register/](https://www.enginatics.com/reports/inv-transaction-register/) |

## INV Transaction Register - Case Study & Technical Analysis

### Executive Summary
The **INV Transaction Register** is the most detailed audit report in Oracle Inventory. It lists every single material movement (Receipt, Issue, Transfer, Adjustment) within a specified date range. It is the "Bank Statement" for the warehouse, showing every debit and credit to the stock.

### Business Challenge
When inventory numbers don't add up, high-level summaries aren't enough. You need the raw details.
-   **Forensics:** "Who moved this stock? When? And why?"
-   **Traceability:** "Where did Lot #123 go? Did it ship to Customer A or Customer B?"
-   **Reconciliation:** "The GL shows a $500 variance. Which specific transaction caused it?"

### Solution
The **INV Transaction Register** provides a line-by-line listing of `MTL_MATERIAL_TRANSACTIONS`. It includes all the "Who, What, Where, When, Why" details.

**Key Features:**
-   **Comprehensive:** Includes PO Receipts, WIP Issues, Sales Order Shipments, and Miscellaneous Transactions.
-   **Attribute Rich:** Shows Lot Numbers, Serial Numbers, Reason Codes, and Reference fields.
-   **Source Linkage:** Links the transaction back to the source document (e.g., PO Number, Sales Order Number).

### Technical Architecture
The report is a direct dump of the transaction history table, often joined with 10+ other tables to resolve IDs to names.

#### Key Tables and Views
-   **`MTL_MATERIAL_TRANSACTIONS`**: The core transaction table.
-   **`MTL_TRANSACTION_TYPES`**: Defines the action (e.g., "PO Receipt").
-   **`MTL_UNIT_TRANSACTIONS`**: Serial number details.
-   **`MTL_TRANSACTION_LOT_NUMBERS`**: Lot number details.

#### Core Logic
1.  **Filtering:** Selects transactions based on Date Range, Item, and Transaction Type.
2.  **Joins:** Joins to `PO_HEADERS_ALL`, `OE_ORDER_HEADERS_ALL`, `WIP_ENTITIES` to get the source document numbers.
3.  **Detailing:** If requested, joins to the Lot and Serial tables to show the specific units moved.

### Business Impact
-   **Loss Prevention:** The first place to look when investigating theft or unexplained shrinkage.
-   **Quality Control:** Traces the movement of potentially defective lots.
-   **Operational Visibility:** Provides a granular view of warehouse activity for any given period.


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
