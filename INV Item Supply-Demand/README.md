---
layout: default
title: 'INV Item Supply/Demand | Oracle EBS SQL Report'
description: 'Inventory Item Supply/Demand data as per the standard Inventory Item Supply/Demand form'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, INV, Item, Supply/Demand, po_headers_all, mtl_sales_orders_kfv, gl_code_combinations_kfv'
permalink: /INV%20Item%20Supply-Demand/
---

# INV Item Supply/Demand – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-supply-demand/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Inventory Item Supply/Demand data as per the standard Inventory Item Supply/Demand form

## Report Parameters
Organization Code, Item, Item Number Contains, Item From, Item To, Category Set, Category, Cutoff Date, Include Onhand Source

## Oracle EBS Tables Used
[po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [mtl_sales_orders_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders_kfv), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_generic_dispositions_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_generic_dispositions_kfv), [rcv_shipment_headers](https://www.enginatics.com/library/?pg=1&find=rcv_shipment_headers), [po_requisition_headers_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_headers_all), [mrp_schedule_dates](https://www.enginatics.com/library/?pg=1&find=mrp_schedule_dates), [mtl_txn_request_headers](https://www.enginatics.com/library/?pg=1&find=mtl_txn_request_headers), [mtl_supply_demand_temp](https://www.enginatics.com/library/?pg=1&find=mtl_supply_demand_temp), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [table](https://www.enginatics.com/library/?pg=1&find=table)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [GL Account Analysis (Distributions)](/GL%20Account%20Analysis%20%28Distributions%29/ "GL Account Analysis (Distributions) Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Supply Demand 11-May-2021 190750.xlsx](https://www.enginatics.com/example/inv-item-supply-demand/) |
| Blitz Report™ XML Import | [INV_Item_Supply_Demand.xml](https://www.enginatics.com/xml/inv-item-supply-demand/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-supply-demand/](https://www.enginatics.com/reports/inv-item-supply-demand/) |

## INV Item Supply-Demand - Case Study & Technical Analysis

### Executive Summary
The **INV Item Supply-Demand** report is the most comprehensive view of an item's availability. It replicates the logic of the "Supply/Demand" form in Oracle Inventory. It lists **all** incoming supply (On-hand, Approved POs, WIP Jobs, In-transit Shipments) and **all** outgoing demand (Sales Orders, WIP Requirements, Reservations) to calculate the net "Available to Promise" (ATP) quantity over time.

### Business Use Cases
*   **Shortage Analysis**: The first place a planner looks when an item is short. It answers "When is the next PO arriving?" and "Who is consuming the stock?".
*   **ATP Verification**: Validates the system's promise date to customers.
*   **Excess Inventory**: Identifies items where Supply far exceeds Demand.

### Technical Analysis

#### Core Tables
*   `MTL_SUPPLY_DEMAND_TEMP`: This is a special temporary table. The report logic (or the form) populates this table on-the-fly by querying `PO_HEADERS_ALL`, `OE_ORDER_LINES_ALL`, `WIP_REQUIREMENT_OPERATIONS`, `MTL_ONHAND_QUANTITIES`, etc.
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

#### Key Joins & Logic
*   **Union of Everything**: The underlying logic is a massive `UNION ALL` query that brings together every possible source of supply and demand.
*   **Netting**: It sorts all transactions by date and calculates a running total (Cumulative Quantity).
*   **Cutoff**: Transactions past the cutoff date are ignored.

#### Key Parameters
*   **Item**: The specific item to analyze.
*   **Cutoff Date**: How far into the future to look.
*   **Include Onhand Source**: Whether to include current stock as the starting balance.


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
