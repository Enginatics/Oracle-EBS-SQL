---
layout: default
title: 'CST Inventory Value - Multi-Organization (Element Costs) 11i | Oracle EBS SQL Report'
description: 'Report: CST Inventory Value - Multi-Organization (Element Costs) Description: This Inventory Value Report reports Inventory Value at the Cost Element…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Inventory, Value, Multi-Organization, mtl_categories_b_kfv, mtl_system_items_vl, mtl_secondary_inventories'
permalink: /CST%20Inventory%20Value%20-%20Multi-Organization%20%28Element%20Costs%29%2011i/
---

# CST Inventory Value - Multi-Organization (Element Costs) 11i – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-inventory-value-multi-organization-element-costs-11i/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report: CST Inventory Value - Multi-Organization (Element Costs)

Description: 
This Inventory Value Report reports Inventory Value at the Cost Element level, and can be used to analyze inventory value by Cost Element Account and/or by Cost Element.

The report can be run across multiple Inventory Organizations.

Provided Templates:
* Pivot - Account Summary 
  Inventory Value summarised by Cost Element Account 
* Pivot - Account, Organization, Subinventory, Item
  Inventory Value summarised by Cost Element Account, Inventory Organization, SubInventory, Item 
* Pivot - Cost Element, Organization, Subinventory, Item
  Inventory Value summarised by Cost Element, Inventory Organization, SubInventory, Item 

DB package: XXEN_INV_VALUE

## Report Parameters
Ledger, Operating Unt, Organization Code, Cost Type, As of Date, Item From, Item To, Category Set, Category From, Category To, Subinventory From, Subinventory To, Currency, Exchange Rate, Quantities By Revision, Negative Quantities only, Display Zero Costs only, Include Expense Items, Include Expense Subinventories, Include Zero Quantities, Include Unvalued Transactions

## Oracle EBS Tables Used
[mtl_categories_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b_kfv), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [cst_inv_qty_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_qty_temp), [cst_inv_cost_temp](https://www.enginatics.com/library/?pg=1&find=cst_inv_cost_temp), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_sets_of_books](https://www.enginatics.com/library/?pg=1&find=gl_sets_of_books), [gl_code_combinations_kfv](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations_kfv), [table](https://www.enginatics.com/library/?pg=1&find=table), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cst-inventory-value-multi-organization-element-costs-11i/) |
| Blitz Report™ XML Import | [CST_Inventory_Value_Multi_Organization_Element_Costs_11i.xml](https://www.enginatics.com/xml/cst-inventory-value-multi-organization-element-costs-11i/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-inventory-value-multi-organization-element-costs-11i/](https://www.enginatics.com/reports/cst-inventory-value-multi-organization-element-costs-11i/) |

## Executive Summary
The **CST Inventory Value - Multi-Organization (Element Costs) 11i** report is a powerful inventory valuation tool designed for multi-org environments. It calculates the value of on-hand inventory as of a specific date (historical or current), broken down by Cost Element (Material, Labor, Overhead, etc.). This "Element" view is crucial for financial reporting, as it allows the inventory balance to be split into its raw material content vs. value-added content (labor/overhead).

## Business Challenge
Standard inventory reports often just give a total value. However, finance needs more detail:
*   **Capitalization**: "How much of our inventory value is capitalized labor and overhead?"
*   **Reconciliation**: Reconciling the GL inventory account requires knowing the split between different sub-accounts (if Material and Overhead are booked to different GL codes).
*   **Multi-Org Analysis**: Aggregating values across multiple warehouses (Organizations) usually requires running separate reports and merging them manually.

## Solution
This report provides a unified view of inventory value across multiple organizations, summarized by Cost Element.

**Key Features:**
*   **As-Of Date Reporting**: Can rollback inventory quantities and costs to show the value at a past point in time (e.g., last month-end).
*   **Cost Element Pivot**: Presents data with columns for Material, Material Overhead, Resource, OSP, and Overhead.
*   **Subinventory Detail**: Can drill down to the subinventory level to value specific storage locations (e.g., "FGI" vs. "Stores").

## Architecture
The report uses a complex logic (often involving temporary tables `CST_INV_QTY_TEMP` and `CST_INV_COST_TEMP`) to calculate the "As-Of" quantity by taking current on-hand and reversing transactions back to the target date. It then applies the item cost.

**Key Tables:**
*   `MTL_ONHAND_QUANTITIES`: Current stock.
*   `MTL_MATERIAL_TRANSACTIONS`: History of moves (used for rollback).
*   `CST_ITEM_COSTS`: Unit costs.
*   `CST_ITEM_COST_DETAILS`: Cost element breakdown.

## Impact
*   **Financial Reporting**: Provides the detailed data needed for the "Inventory" note in the financial statements.
*   **Audit Support**: Allows for the precise validation of inventory balances at any historical date.
*   **Operational Insight**: Helps identify organizations holding excessive amounts of value-added inventory (WIP/Finished Goods) vs. Raw Materials.


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
