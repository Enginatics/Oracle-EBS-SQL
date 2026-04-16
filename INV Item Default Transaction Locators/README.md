---
layout: default
title: 'INV Item Default Transaction Locators | Oracle EBS SQL Report'
description: 'Master data report of Inventory Items and the default locators for shipping, receiving or move order receipt transactions'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Default, Transaction, hr_all_organization_units_vl, mtl_parameters, mtl_item_loc_defaults'
permalink: /INV%20Item%20Default%20Transaction%20Locators/
---

# INV Item Default Transaction Locators – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-default-transaction-locators/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report of Inventory Items and the default locators for shipping, receiving or move order receipt transactions

## Report Parameters
Item, Subinventory, Organization Code

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_item_loc_defaults](https://www.enginatics.com/library/?pg=1&find=mtl_item_loc_defaults), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[EAM Assets](/EAM%20Assets/ "EAM Assets Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Material Transactions](/INV%20Material%20Transactions/ "INV Material Transactions Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [INV Item Default Transaction Subinventories](/INV%20Item%20Default%20Transaction%20Subinventories/ "INV Item Default Transaction Subinventories Oracle EBS SQL Report"), [INV Item Transaction Defaults Upload](/INV%20Item%20Transaction%20Defaults%20Upload/ "INV Item Transaction Defaults Upload Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/inv-item-default-transaction-locators/) |
| Blitz Report™ XML Import | [INV_Item_Default_Transaction_Locators.xml](https://www.enginatics.com/xml/inv-item-default-transaction-locators/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-default-transaction-locators/](https://www.enginatics.com/reports/inv-item-default-transaction-locators/) |

## INV Item Default Transaction Locators - Case Study & Technical Analysis

### Executive Summary
The **INV Item Default Transaction Locators** report documents the default physical locations (Locators) assigned to items for specific transaction types (Shipping, Receiving, Move Order Receipt). Setting these defaults automates warehouse processes by pre-populating the locator field during transactions, reducing data entry errors and speeding up receiving and picking.

### Business Use Cases
*   **Receiving Efficiency**: Ensures that when the dock team receives "Item A", the system automatically suggests "Bin B-01" as the putaway location.
*   **Picking Optimization**: Defines the primary pick face for an item.
*   **Warehouse Reorganization**: Used as a baseline export before performing a mass update of default locations during a warehouse layout change.

### Technical Analysis

#### Core Tables
*   `MTL_ITEM_LOC_DEFAULTS`: The table storing the default locator ID for a given item and subinventory.
*   `MTL_ITEM_LOCATIONS_KFV`: The locator definitions (Row, Rack, Bin).
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

#### Key Joins & Logic
*   **Scope**: Defaults are defined at the Item + Subinventory level.
*   **Type**: The `DEFAULT_TYPE` column indicates the purpose (e.g., 1=Shipping, 2=Receiving).
*   **Hierarchy**: These defaults are often overridden by more specific rules (like WMS Rules Engine), but serve as the base logic for standard Inventory organizations.

#### Key Parameters
*   **Item**: Filter for a specific item.
*   **Subinventory**: Filter for a specific area.


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
