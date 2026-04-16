---
layout: default
title: 'CAC Inventory Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for onhand and intransit inventory value which you own. If you enter a period name this report uses the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inventory, Pending, Cost, mtl_secondary_inventories, inv_organizations, cst_cost_group_accounts'
permalink: /CAC%20Inventory%20Pending%20Cost%20Adjustment/
---

# CAC Inventory Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing the potential standard cost changes for onhand and intransit inventory value which you own.  If you enter a period name this report uses the quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.

If using this report for reporting after the standard cost update has run this report requires both the before and after cost types available for reporting purposes.  Using the item cost copy please save your Frozen costs before running the standard cost update.

Parameters:
===========
Period Name (Closed):  to use the month-end quantities, choose a closed inventory accounting period (optional).
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Currency Conversion Date (New):  enter the currency conversion date to use for the new item costs (mandatory).
Currency Conversion Type (New):  enter the currency conversion type to use for the new item costs, defaults to Corporate (mandatory).
Currency Conversion Date (Old):  enter the currency conversion date to use for the existing item costs (mandatory).
Currency Conversion Type (Old):  enter the currency conversion type to use for the existing item costs, defaults to Corporate (mandatory).
To Currency Code:  enter the currency code used to translate the item costs and inventory values into.
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  The second item category set to report, typically the Inventory Category Set (optional).
Only Items in New Cost Type:  enter Yes to only report the items in the New Cost Type.  Specify No if you want to use this report to reconcile overall inventory value (mandatory).
Include Items With No Quantities:  enter Yes to report items that do not have onhand quantities (mandatory).
Include Zero Item Cost Differences:  enter Yes to include items with a zero item cost difference, defaults to a value of No (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2008-2024 Douglas Volz Consulting, Inc
-- |  All rights reserved
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name:  xxx_std_cost_pending_adj_rept.sql
-- | 
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client
-- |     1.12 23 Sep 2023 Douglas Volz   Add parameter to not include zero item cost differences,
-- |                                     removed tabs and added org access controls.
-- |     1.13 22 Oct 2023 Andy Haack     Fix for G/L Daily Currency Rates
-- |     1.14 07 Feb 2024 Douglas Volz   Add item master and costing lot sizes, use default controls, 
-- |                                     based on rollup and shrinkage rate columns
-- +=============================================================================+*/



## Report Parameters
Period Name (Closed), Cost Type (New), Cost Type (Old), Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Only Items in New Cost Type, Include Items With No Quantities, Include Zero Item Cost Differences, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Inventory Pending Cost Adjustment 23-Jun-2022 162333.xlsx](https://www.enginatics.com/example/cac-inventory-pending-cost-adjustment/) |
| Blitz Report™ XML Import | [CAC_Inventory_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-inventory-pending-cost-adjustment/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inventory-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-inventory-pending-cost-adjustment/) |


## Case Study & Technical Analysis: CAC Inventory Pending Cost Adjustment

### Executive Summary
The **CAC Inventory Pending Cost Adjustment** report is a critical financial planning tool for manufacturing and distribution companies operating on Standard Costing. It allows Finance and Operations to simulate the financial impact of a standard cost update *before* it is committed to the system.
By comparing the current ("Old") standard costs against a proposed ("New") cost type, the report calculates the projected revaluation of **On-hand** and **Intransit** inventory. This enables organizations to:
1.  **Forecast P&L Impact:** Predict the revaluation gain or loss that will hit the General Ledger.
2.  **Validate Cost Changes:** Identify erroneous cost swings (e.g., a 500% increase in a bolt) before they corrupt inventory valuation.
3.  **Audit Currency Effects:** Analyze how exchange rate fluctuations affect the standard cost of imported items.

### Business Challenge
Updating standard costs is a high-risk operation. Once the "Update Standard Costs" program runs, inventory values are instantly revalued, and the difference is posted to the P&L.
*   **The "Blind Update" Risk:** Without a preview tool, Finance teams often run updates blindly, discovering massive, unexpected variances only after the month-end close.
*   **Timing & Quantities:** The revaluation impact depends heavily on *when* the update runs. A cost increase on an item with 0 quantity has no impact, while the same increase on an item with 1M units is material. This report allows users to simulate the impact using either "Real-Time" quantities or "Period-End" snapshots.
*   **Intransit Visibility:** Many standard reports miss "Intransit" inventory (goods moved between orgs but not yet received). This report captures both, ensuring the total balance sheet impact is calculated.

### The Solution
This report acts as a "What-If" engine for inventory valuation.
*   **Dual Mode Logic:**
    *   **Real-Time:** Uses current on-hand quantities (`MTL_ONHAND_QUANTITIES_DETAIL`) for immediate analysis.
    *   **Period-End:** Uses historical snapshots (`CST_PERIOD_CLOSE_SUMMARY`) to simulate what the impact *would have been* if costs changed at month-end.
*   **Comprehensive Scope:** It aggregates value from:
    *   **Onhand Inventory:** Goods in warehouses.
    *   **Intransit Inventory:** Goods in transit between organizations (owned by the shipping or receiving org).
*   **Currency Simulation:** It allows users to specify different currency conversion rates for the "New" vs. "Old" costs, enabling complex scenario planning for multinational supply chains.

### Technical Architecture (High Level)
The query is designed as a massive union of two primary datasets: **Onhand** and **Intransit**.
*   **`inv_organizations` (CTE):** Sets up the organizational context, filtering for valid, active inventory organizations and handling security access.
*   **`item_quantities` (CTE):** The core logic engine. It switches between tables based on the `Period Name` parameter:
    *   If `Period Name` is null: Queries `MTL_ONHAND_QUANTITIES_DETAIL` (Real-time).
    *   If `Period Name` is set: Queries `CST_PERIOD_CLOSE_SUMMARY` (Historical).
    *   *Intransit Logic:* Similarly switches between `MTL_SUPPLY` (Real-time) and `CST_PERIOD_CLOSE_SUMMARY` (Historical, filtered for Intransit).
*   **Cost Joins:** The aggregated quantities are joined to `CST_ITEM_COSTS` twice (once for Old, once for New).
*   **Valuation Calculation:**
    *   `Revaluation = Quantity * (New Cost - Old Cost)`
    *   The report handles currency conversions if the `To Currency Code` differs from the functional currency.

### Parameters & Filtering
*   **Period Name (Closed):** Leave blank for real-time; select a period for historical simulation.
*   **Cost Type (New/Old):** The two cost sets to compare (e.g., "Pending" vs. "Frozen").
*   **Currency Conversion:** Critical for global operations. Allows simulating the impact of FX rate changes on inventory value.
*   **Only Items in New Cost Type:** Useful for partial updates (e.g., only updating "New 2024 Products").
*   **Include Zero Item Cost Differences:** Filters out noise to focus only on items with actual cost changes.

### Performance & Optimization
*   **CTE Structure:** The use of Common Table Expressions (CTEs) for organizations and quantities allows the optimizer to filter data early, reducing the volume of rows joined to the heavy cost tables.
*   **Union All:** The query uses `UNION ALL` to combine Onhand and Intransit datasets, which is faster than `UNION` as it avoids a distinct sort (deduplication is handled by the logic).

### FAQ
**Q: Why do I see "Intransit" value?**
A: If your organization owns goods currently moving between warehouses (FOB Shipment/Receipt logic), those goods are subject to revaluation just like goods on the shelf.

**Q: Can I use this to check Average Cost updates?**
A: Yes, while primarily for Standard Costing, the report can compare any two cost types. However, "updating" Average Cost is a different business process than Standard Costing.

**Q: What if an item has no quantity?**
A: You can choose to "Include Items With No Quantities". This is useful for verifying that the new standard cost is correctly loaded, even if there is no immediate financial impact.

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
