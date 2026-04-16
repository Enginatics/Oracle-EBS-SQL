---
layout: default
title: 'INV Lot Transaction Register | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Lot transaction register Application: Inventory Source: Lot transaction register (XML) Short Name: INVTRLNTXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Lot, Transaction, Register, mtl_transaction_lot_numbers, mtl_system_items_vl, mtl_material_transactions'
permalink: /INV%20Lot%20Transaction%20Register/
---

# INV Lot Transaction Register – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-lot-transaction-register/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Lot transaction register
Application: Inventory
Source: Lot transaction register (XML)
Short Name: INVTRLNT_XML
DB package: INV_INVTRLNT_XMLP_PKG

## Report Parameters
Unit of Measure, Transaction Dates From, Transaction Dates To, Serial Number Detail, Lot Numbers From, Lot Numbers To, Items From, Items To, Transaction Types From, Transaction Types To, Transaction Reasons From, Transaction Reasons To, Subinventories From, Subinventories To, Category Set, Categories From, Categories To, Source Type, Transaction Sources From, Transaction Sources To

## Oracle EBS Tables Used
[mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_transaction_reasons](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_reasons), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [fnd_user](https://www.enginatics.com/library/?pg=1&find=fnd_user), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_sales_orders_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_generic_dispositions_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions_kfv), [cst_cost_updates](https://www.enginatics.com/library/?pg=1&find=cst_cost_updates), [mtl_cycle_count_headers](https://www.enginatics.com/library/?pg=1&find=mtl_cycle_count_headers), [mtl_physical_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_physical_inventories), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [mtl_unit_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_unit_transactions), [mtl_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets), [q_body](https://www.enginatics.com/library/?pg=1&find=q_body), [q_serial](https://www.enginatics.com/library/?pg=1&find=q_serial)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Lot Transaction Register - Default 03-May-2024 032459.xlsx](https://www.enginatics.com/example/inv-lot-transaction-register/) |
| Blitz Report™ XML Import | [INV_Lot_Transaction_Register.xml](https://www.enginatics.com/xml/inv-lot-transaction-register/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-lot-transaction-register/](https://www.enginatics.com/reports/inv-lot-transaction-register/) |

## INV Lot Transaction Register - Case Study & Technical Analysis

### Executive Summary
The **INV Lot Transaction Register** is a specialized audit report designed for industries with strict traceability requirements (Pharmaceuticals, Food & Beverage, Aerospace). It provides a complete genealogy of lot-controlled items, detailing every transaction that has affected a specific lot number—from initial receipt or production, through inventory moves, to final shipment or consumption.

### Business Challenge
Traceability is a major compliance requirement for many organizations. Challenges include:
-   **Recall Management:** In the event of a quality issue, companies must be able to instantly identify where every unit of a bad lot went (which customers received it).
-   **Regulatory Compliance:** FDA (21 CFR Part 11) and other bodies require immutable records of lot history.
-   **Root Cause Analysis:** When a defect is found in a finished good, engineers need to trace back to the raw material lots used.
-   **Data Fragmentation:** Lot data is often scattered across receiving, WIP, and shipping tables, making manual tracing impossible.

### Solution
The **INV Lot Transaction Register** consolidates all lot-related activities into a single chronological view. It links the lot number to the underlying transaction source (PO, Job, Sales Order), providing end-to-end visibility.

**Key Features:**
-   **Genealogy Tracking:** Shows the complete lifecycle of a lot.
-   **Source Linkage:** Connects the lot to the specific supplier (via PO) or customer (via SO).
-   **Attribute Visibility:** Displays lot attributes like Expiration Date and Status at the time of the transaction.

### Technical Architecture
The report is built on the Oracle Inventory transaction model, specifically focusing on the lot extension tables.

#### Key Tables and Views
-   **`MTL_TRANSACTION_LOT_NUMBERS`**: The core table linking a transaction ID to a lot number and quantity.
-   **`MTL_MATERIAL_TRANSACTIONS`**: The parent table containing the transaction details (Date, Type, Item).
-   **`MTL_LOT_NUMBERS`**: The master definition of the lot (Expiration Date, Origination Date).
-   **`MTL_SYSTEM_ITEMS_VL`**: Item master details.

#### Core Logic
1.  **Transaction Selection:** The report selects transactions from `MTL_MATERIAL_TRANSACTIONS` based on the date range and item criteria.
2.  **Lot Explosion:** It joins to `MTL_TRANSACTION_LOT_NUMBERS` to retrieve the specific lots involved in each transaction.
3.  **Source Resolution:** Depending on the `TRANSACTION_SOURCE_TYPE_ID`, it joins to `PO_HEADERS_ALL`, `WIP_ENTITIES`, or `OE_ORDER_HEADERS_ALL` to get the document number (PO#, Job#, SO#).
4.  **Serial Detail:** If requested, it can further drill down to `MTL_UNIT_TRANSACTIONS` for serial-controlled lots.

### Business Impact
-   **Risk Mitigation:** Drastically reduces the time and cost of executing a product recall.
-   **Compliance:** Ensures audit readiness for regulatory inspections.
-   **Quality Control:** Enables faster isolation of quality spills by identifying all affected inventory immediately.


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
