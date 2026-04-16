---
layout: default
title: 'INV Item Reservations | Oracle EBS SQL Report'
description: 'Imported from BI Publisher Description: Item reservations report Application: Inventory Source: Item reservations report (XML) Short Name: INVDRRSVXML DB…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Reservations, mtl_parameters, mtl_demand, mtl_system_items_vl'
permalink: /INV%20Item%20Reservations/
---

# INV Item Reservations – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-reservations/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Imported from BI Publisher
Description: Item reservations report
Application: Inventory
Source: Item reservations report (XML)
Short Name: INVDRRSV_XML
DB package: INV_INVDRRSV_XMLP_PKG

## Report Parameters
Organization Code, Required Date From, Required Date To, Item, Item From, Item To, Category Set, Category From, Category To, Transaction Source Type, Source From, Source To, Sort Option

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_demand](https://www.enginatics.com/library/?pg=1&find=mtl_demand), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_categories_v](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories_v), [mtl_txn_source_types](https://www.enginatics.com/library/?pg=1&find=mtl_txn_source_types), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_sales_orders_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders_kfv), [mtl_generic_dispositions_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [INV Transaction Register](/INV%20Transaction%20Register/ "INV Transaction Register Oracle EBS SQL Report"), [INV Lot Transaction Register](/INV%20Lot%20Transaction%20Register/ "INV Lot Transaction Register Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Reservations 30-Sep-2025 000552.xlsx](https://www.enginatics.com/example/inv-item-reservations/) |
| Blitz Report™ XML Import | [INV_Item_Reservations.xml](https://www.enginatics.com/xml/inv-item-reservations/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-reservations/](https://www.enginatics.com/reports/inv-item-reservations/) |

## INV Item Reservations - Case Study & Technical Analysis

### Executive Summary
The **INV Item Reservations** report details the "hard allocations" of inventory. A reservation guarantees that a specific quantity of an item is held for a specific demand source (like a high-priority Sales Order or a WIP Job) and cannot be used by anyone else. This report is essential for troubleshooting "Available to Promise" (ATP) issues where stock exists physically but the system says "None Available".

### Business Use Cases
*   **Order Fulfillment**: Investigating why a Sales Order is backordered when there is plenty of stock on hand (answer: it's reserved for someone else).
*   **WIP Material Availability**: Ensuring that critical components are reserved for production jobs to prevent line stoppages.
*   **Warehouse Management**: Reservations often lock stock to a specific locator; this report helps find where that stock is.

### Technical Analysis

#### Core Tables
*   `MTL_RESERVATIONS`: The primary table storing the reservation link between Supply (Inventory) and Demand (Order/Job).
*   `MTL_DEMAND`: Legacy view often used for reporting.
*   `OE_ORDER_HEADERS_ALL` / `WIP_ENTITIES`: The demand sources.

#### Key Joins & Logic
*   **Supply vs. Demand**: The reservation links a `SUPPLY_SOURCE` (On-hand, PO) to a `DEMAND_SOURCE` (Sales Order, Account, Account Alias).
*   **Level**: Reservations can be at the Organization, Subinventory, Locator, or Lot level. High-level reservations (Org level) guarantee quantity but not specific units.

#### Key Parameters
*   **Item**: The item to check.
*   **Required Date**: When the material is needed.
*   **Transaction Source Type**: Filter by Sales Order, WIP Job, etc.


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
