---
layout: default
title: 'INV Onhand Quantities | Oracle EBS SQL Report'
description: 'Detail report inventory item quantities by org, sub inventory, location, unit of measure, quantity on hand, quantity reserved, quantity unpacked, lot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Onhand, Quantities, mtl_abc_classes, mtl_abc_assignments, mtl_abc_assignment_groups'
permalink: /INV%20Onhand%20Quantities/
---

# INV Onhand Quantities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-onhand-quantities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report inventory item quantities by org, sub inventory, location, unit of measure, quantity on hand, quantity reserved, quantity unpacked, lot number, lot expiration, planning information, serial control, availability type, date received, list price, min / max and safety stock.

## Report Parameters
Organization Code, Subinventory, Item, Category Set 1, Category Set 2, Category Set 3, Nettable only, Show Movements Summary, Txn Date From, ABC Assignment Group

## Oracle EBS Tables Used
[mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes), [mtl_abc_assignments](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignments), [mtl_abc_assignment_groups](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignment_groups), [mtl_safety_stocks](https://www.enginatics.com/library/?pg=1&find=mtl_safety_stocks), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [mtl_reservations](https://www.enginatics.com/library/?pg=1&find=mtl_reservations)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Onhand Quantities 26-Jul-2018 134821.xlsx](https://www.enginatics.com/example/inv-onhand-quantities/) |
| Blitz Report™ XML Import | [INV_Onhand_Quantities.xml](https://www.enginatics.com/xml/inv-onhand-quantities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-onhand-quantities/](https://www.enginatics.com/reports/inv-onhand-quantities/) |

## INV Onhand Quantities - Case Study & Technical Analysis

### Executive Summary
The **INV Onhand Quantities** report is the definitive "Stock Status" report for Oracle Inventory. It provides a detailed snapshot of exactly what is in the warehouse right now. Unlike simple stock lists, this report exposes the rich attributes of on-hand inventory, including Lot numbers, Serial numbers, Reservations, LPNs (License Plates), and Statuses.

### Business Challenge
Knowing "we have 100 units" is rarely enough. Operations teams need to know:
-   **Availability:** "We have 100, but how many are already reserved for other orders?"
-   **Location:** "Which specific bin are they in?"
-   **Quality:** "Are any of them expired or on Quality Hold?"
-   **Traceability:** "Do we have the specific serial number the customer is asking for?"

### Solution
The **INV Onhand Quantities** report provides a multi-dimensional view of stock. It joins the core quantity tables with all the attribute tables to provide a complete picture of inventory health.

**Key Features:**
-   **Granularity:** Shows stock at the Subinventory, Locator, Lot, and Serial level.
-   **Availability Calculation:** Displays "Quantity on Hand" vs. "Quantity Available to Transact" (Onhand - Reserved).
-   **Attribute Visibility:** Includes Expiration Dates, Material Status, and Cost Group information.

### Technical Architecture
The report queries the live on-hand balance tables, which are the most critical and heavily indexed tables in the Inventory schema.

#### Key Tables and Views
-   **`MTL_ONHAND_QUANTITIES_DETAIL`**: The primary table storing current stock balances.
-   **`MTL_RESERVATIONS`**: Used to calculate the "Reserved" quantity.
-   **`MTL_LOT_NUMBERS`**: Lot attributes.
-   **`MTL_SERIAL_NUMBERS`**: Serial attributes.
-   **`WMS_LICENSE_PLATE_NUMBERS`**: Container (LPN) details.

#### Core Logic
1.  **Balance Retrieval:** Selects from `MTL_ONHAND_QUANTITIES_DETAIL`.
2.  **Reservation Netting:** Subqueries `MTL_RESERVATIONS` to determine how much of that stock is hard-allocated.
3.  **Status Check:** Checks `MTL_MATERIAL_STATUSES` to see if the stock is transactable.
4.  **Costing:** Can join to `CST_ITEM_COSTS` to provide the value of the on-hand stock.

### Business Impact
-   **Customer Service:** Enables accurate promising of orders by showing true availability.
-   **Warehouse Efficiency:** Reduces "search time" by pinpointing exact locations.
-   **Waste Reduction:** Helps identify expiring lots before they become unsalable.


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
