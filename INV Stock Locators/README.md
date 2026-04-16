---
layout: default
title: 'INV Stock Locators | Oracle EBS SQL Report'
description: 'Summary report for Inventory locations, showing locator number, description, type, status, subinventory, picking order, dropping order and unit, volume…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Stock, Locators, mtl_item_locations_kfv, hr_all_organization_units_tl, mtl_parameters'
permalink: /INV%20Stock%20Locators/
---

# INV Stock Locators – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-stock-locators/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Summary report for Inventory locations, showing locator number, description, type, status, subinventory, picking order, dropping order and unit, volume, weight, dimension and co-ordinate information.

## Report Parameters
Locator Type, Status, Subinventory, Organization Code

## Oracle EBS Tables Used
[mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [hr_all_organization_units_tl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_tl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_item_locations](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations), [mtl_material_statuses_vl](https://www.enginatics.com/library/?pg=1&find=mtl_material_statuses_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Stock Locators 26-Jul-2018 134603.xlsx](https://www.enginatics.com/example/inv-stock-locators/) |
| Blitz Report™ XML Import | [INV_Stock_Locators.xml](https://www.enginatics.com/xml/inv-stock-locators/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-stock-locators/](https://www.enginatics.com/reports/inv-stock-locators/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
