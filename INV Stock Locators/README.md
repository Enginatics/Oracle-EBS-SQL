---
layout: default
last_modified_at: 2026-10-26
title: 'INV Stock Locators | Oracle EBS SQL Report'
description: 'Summary report for Inventory locations, showing locator number, description, type, status, subinventory, picking order, dropping order and unit, volume…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Inventory, Enginatics, INV, Stock, Locators, mtl_item_locations_kfv, hr_all_organization_units_tl, mtl_parameters'
permalink: /INV%20Stock%20Locators/
report_name: 'INV Stock Locators'
report_web_name: inv-stock-locators
module: 'Inventory'
module_url: /modules/inventory/
---

# INV Stock Locators – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-stock-locators/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators).
**Oracle EBS module:** [Inventory](/modules/inventory/ "Oracle EBS Inventory reports") · [all Inventory reports](/modules/inventory/)  

## Overview
Summary report for Inventory locations, showing locator number, description, type, status, subinventory, picking order, dropping order and unit, volume, weight, dimension and co-ordinate information.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Locator Type, Status, Subinventory, Organization Code

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators), [mtl_item_locations](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)

## Related Reports
[INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [INV Serial Numbers](/INV%20Serial%20Numbers/ "INV Serial Numbers Oracle EBS SQL Report"), [INV Stock Locator Upload](/INV%20Stock%20Locator%20Upload/ "INV Stock Locator Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Stock%20Locators/INV%20Stock%20Locators.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Stock Locators 26-Jul-2018 134603.xlsx](https://www.enginatics.com/example/inv-stock-locators/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) |
| Blitz Report™ XML Import | [INV_Stock_Locators.xml](https://www.enginatics.com/xml/inv-stock-locators/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) |
| SQL Source | [INV Stock Locators.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/INV%20Stock%20Locators/INV%20Stock%20Locators.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/inv-stock-locators/](https://www.enginatics.com/reports/inv-stock-locators/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators) |

## INV Stock Locators - Case Study & Technical Analysis

### Executive Summary
The **INV Stock Locators** report is a warehouse layout document. It lists all the defined storage locations (Locators) within the subinventories. It includes critical attributes like dimensions, weight capacities, and picking order. This report is essential for warehouse mapping and capacity planning.

### Business Challenge
A warehouse is a physical space that needs to be mapped digitally.
-   **Capacity Planning:** "Do we have enough empty bins to receive the incoming shipment?"
-   **Route Optimization:** "Are the bins numbered in a way that makes sense for a picker walking the aisle?"
-   **Status Control:** "Which bins are damaged and should be blocked from use?"

### Solution
The **INV Stock Locators** report provides a complete list of valid addresses in the warehouse. It exposes the configuration details of each bin.

**Key Features:**
-   **Address Breakdown:** Shows the segments of the locator (e.g., Aisle-Row-Bin-Level).
-   **Physical Constraints:** Lists the max weight, volume, and dimensions of the bin.
-   **Operational Flags:** Shows the Picking Order (sequence) and Status (Active/Inactive).

### Technical Architecture
The report queries the locator definition table.

#### Key Tables and Views
-   **`MTL_ITEM_LOCATIONS`**: The table storing the locator definitions.
-   **`MTL_SECONDARY_INVENTORIES`**: The subinventory the locator belongs to.
-   **`MTL_MATERIAL_STATUSES`**: The status of the locator (e.g., "Quarantine").

#### Core Logic
1.  **Retrieval:** Selects from `MTL_ITEM_LOCATIONS` (often joined with `MTL_ITEM_LOCATIONS_KFV` for the concatenated segments).
2.  **Filtering:** Can filter by Subinventory, Locator Type, or Status.
3.  **Sorting:** Usually sorted by Subinventory and then Picking Order.

### Business Impact
-   **Warehouse Optimization:** Used to analyze and optimize the picking path (by adjusting the Picking Order field).
-   **Space Management:** Helps identify underutilized or over-utilized areas of the warehouse.
-   **Master Data Management:** Ensures the digital map matches the physical labels on the racks.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=inv-stock-locators)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
