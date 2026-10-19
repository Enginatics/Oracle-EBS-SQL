---
layout: default
last_modified_at: 2026-10-19
title: 'INV Onhand Quantities | Oracle EBS SQL Report'
description: 'Detail report inventory item quantities by org, sub inventory, location, unit of measure, quantity on hand, quantity reserved, quantity unpacked, lot…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Onhand, Quantities, mtl_abc_classes, mtl_abc_assignments, mtl_abc_assignment_groups'
permalink: /INV%20Onhand%20Quantities/
report_name: 'INV Onhand Quantities'
report_web_name: inv-onhand-quantities
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Onhand Quantities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-onhand-quantities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Detail report inventory item quantities by org, sub inventory, location, unit of measure, quantity on hand, quantity reserved, quantity unpacked, lot number, lot expiration, planning information, serial control, availability type, date received, list price, min / max and safety stock.

Show Serial Numbers adds one row per serial number resident in the on-hand location; the quantity and value columns are those of the location and repeat on every serial row.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Subinventory, Item, Category Set 1, Category Set 2, Category Set 3, Nettable only, Show Movements Summary, Txn Date From, ABC Assignment Group, Show Serial Numbers

## Oracle EBS Tables Used
[mtl_abc_classes](https://www.enginatics.com/library/?pg=1&find=mtl_abc_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_abc_assignments](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_abc_assignment_groups](https://www.enginatics.com/library/?pg=1&find=mtl_abc_assignment_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_category_sets_vl](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_safety_stocks](https://www.enginatics.com/library/?pg=1&find=mtl_safety_stocks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [wms_license_plate_numbers](https://www.enginatics.com/library/?pg=1&find=wms_license_plate_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [ap_supplier_sites_all](https://www.enginatics.com/library/?pg=1&find=ap_supplier_sites_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_reservations](https://www.enginatics.com/library/?pg=1&find=mtl_reservations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [mtl_transaction_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)

## Related Reports
[INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Cycle count listing](/INV%20Cycle%20count%20listing/ "INV Cycle count listing Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Aging](/INV%20Aging/ "INV Aging Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Onhand%20Quantities/INV%20Onhand%20Quantities.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Onhand Quantities 26-Jul-2018 134821.xlsx](https://www.enginatics.com/example/inv-onhand-quantities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) |
| Blitz Report™ XML Import | [INV_Onhand_Quantities.xml](https://www.enginatics.com/xml/inv-onhand-quantities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) |
| SQL Source | [INV Onhand Quantities.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Onhand%20Quantities/INV%20Onhand%20Quantities.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-onhand-quantities/](https://www.enginatics.com/reports/inv-onhand-quantities/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-onhand-quantities)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
