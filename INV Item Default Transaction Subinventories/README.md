---
layout: default
title: 'INV Item Default Transaction Subinventories | Oracle EBS SQL Report'
description: 'Master data report of inventory item relationships including the type of relationship between the item and the subinventory.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, INV, Item, Default, Transaction, hr_all_organization_units_vl, mtl_parameters, mtl_item_sub_defaults'
permalink: /INV%20Item%20Default%20Transaction%20Subinventories/
---

# INV Item Default Transaction Subinventories – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/inv-item-default-transaction-subinventories/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Master data report of inventory item relationships including the type of relationship between the item and the subinventory.

## Report Parameters
Item, Subinventory, Organization Code

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_item_sub_defaults](https://www.enginatics.com/library/?pg=1&find=mtl_item_sub_defaults), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [INV Item Default Transaction Locators](/INV%20Item%20Default%20Transaction%20Locators/ "INV Item Default Transaction Locators Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Material Account Alias with Lot Numbers](/CAC%20Material%20Account%20Alias%20with%20Lot%20Numbers/ "CAC Material Account Alias with Lot Numbers Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Receiving Expense Value (Period-End)](/CAC%20Receiving%20Expense%20Value%20%28Period-End%29/ "CAC Receiving Expense Value (Period-End) Oracle EBS SQL Report"), [CAC Missing Receiving Accounting Transactions](/CAC%20Missing%20Receiving%20Accounting%20Transactions/ "CAC Missing Receiving Accounting Transactions Oracle EBS SQL Report"), [CAC Receiving Account Detail](/CAC%20Receiving%20Account%20Detail/ "CAC Receiving Account Detail Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [INV Item Default Transaction Subinventories 24-Jul-2023 194535.xlsx](https://www.enginatics.com/example/inv-item-default-transaction-subinventories/) |
| Blitz Report™ XML Import | [INV_Item_Default_Transaction_Subinventories.xml](https://www.enginatics.com/xml/inv-item-default-transaction-subinventories/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/inv-item-default-transaction-subinventories/](https://www.enginatics.com/reports/inv-item-default-transaction-subinventories/) |

## INV Item Default Transaction Subinventories - Case Study & Technical Analysis

### Executive Summary
The **INV Item Default Transaction Subinventories** report lists the default subinventory assigned to an item. Similar to the Locator report, this defines the "Home" subinventory for an item. It is used to restrict where an item can be transacted or to provide a default value during receiving and miscellaneous transactions.

### Business Use Cases
*   **Putaway Logic**: Defines the primary storage area for an item (e.g., "Cold Storage" vs. "Dry Goods").
*   **Transaction Control**: Can be used in conjunction with "Restrict Subinventories" flag on the Item Master to prevent users from putting items in the wrong place.
*   **Min-Max Planning**: Often used to define which subinventory is replenished for a specific item.

### Technical Analysis

#### Core Tables
*   `MTL_ITEM_SUB_DEFAULTS`: The table storing the default subinventory code for an item.
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

#### Key Joins & Logic
*   **Organization Specific**: Defaults are specific to an Inventory Organization.
*   **Relationship**: This is a simple 1:Many relationship (One Item can have defaults in multiple Orgs, but usually one default per Org/Type).

#### Key Parameters
*   **Item**: Filter for a specific item.
*   **Subinventory**: Filter for a specific subinventory.


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
