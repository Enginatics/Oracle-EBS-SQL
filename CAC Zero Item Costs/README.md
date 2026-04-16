---
layout: default
title: 'CAC Zero Item Costs | Oracle EBS SQL Report'
description: 'Report to show zero item costs in the Costing Method cost type, the creation date, the last transaction id, last transaction date and any onhand stock…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Zero, Item, Costs, mtl_material_transactions, mtl_transaction_types, mtl_onhand_quantities_detail'
permalink: /CAC%20Zero%20Item%20Costs/
---

# CAC Zero Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-zero-item-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show zero item costs in the Costing Method cost type, the creation date, the last transaction id, last transaction date and any onhand stock, based on the item master creation date.

Parameters:
Creation Date From:  starting item master creation date (required).
Creation Date To: ending item master creation date (required).
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).S
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.                         |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged.  No warranties, express or otherwise is included in this      |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_zero_item_cost_rept.sql
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    11 Mar 2010 Douglas Volz   Initial Coding
-- |  1.1    29 Mar 2010 Douglas Volz   Added item status and item type to the 
-- |                                    report and removed 9xx inventory orgs
-- |  1.2    05 Oct 2010 Douglas Volz   Added Ledger parameter, updated column headings,
-- |                                    added UOM_Code column, added union all to
-- |                                    select items with no costs at all
-- |  1.3    10 Feb 2017 Douglas Volz   Removed client-specific org restrictions
-- |  1.4    22 May 2017 Douglas Volz   Added product type, business code, product family,
-- |                                    product line and package code item categories
-- |  1.5    17 Jul 2018 Douglas Volz   Revised to report any two item categories.
-- |  1.6    27 Jan 2020 Douglas Volz   Added Org_Code and Operating_Unit parameters.
-- |  1.7    27 Apr 2020 Douglas Volz   Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units
-- |  1.8    07 Nov 2020 Douglas Volz   Changed to multi-language for status and UOM
-- |  1.9    09 Jul 2023 Douglas Volz   Remove tabs and restrict to only orgs you have
-- |                                    access to, using the org access view.
-- +=============================================================================+*/


## Report Parameters
Creation Date From, Creation Date To, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_material_transactions](https://www.enginatics.com/library/?pg=1&find=mtl_material_transactions), [mtl_transaction_types](https://www.enginatics.com/library/?pg=1&find=mtl_transaction_types), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Zero Item Costs 10-Jul-2022 170519.xlsx](https://www.enginatics.com/example/cac-zero-item-costs/) |
| Blitz Report™ XML Import | [CAC_Zero_Item_Costs.xml](https://www.enginatics.com/xml/cac-zero-item-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-zero-item-costs/](https://www.enginatics.com/reports/cac-zero-item-costs/) |

## Executive Summary
The **CAC Zero Item Costs** report is an inventory master data audit tool designed to identify items that have a standard cost of zero. While some items (like expense items or new parts) legitimately have zero cost, a "make" or "buy" part with zero cost in a standard costing environment can lead to significant accounting errors, such as zero-value inventory transactions and incorrect margins. This report helps the Cost Accounting team proactively monitor and fix missing costs before they cause transaction issues.

## Business Challenge
In an ERP system, if an item has a cost of zero:
*   **Valuation Errors**: Inventory on hand will have zero value on the balance sheet.
*   **Margin Errors**: Sales of the item will show 100% margin (Sales Price - 0 Cost), overstating profit.
*   **Transaction Errors**: Issues to WIP or shipments will carry zero value, distorting job costs and COGS.

It is critical to identify these items *before* they are transacted. However, with thousands of items created automatically or manually, it is easy for cost setup to be missed.

## Solution
This report scans the Item Master and Cost tables to find items where the total cost in the specified Cost Type (usually "Frozen" or "Standard") is zero. It provides context such as the item's creation date, last transaction date, and on-hand quantity to help prioritize which items need immediate attention.

**Key Features:**
*   **Zero Cost Detection**: Filters specifically for items with `ITEM_COST = 0` or no cost record.
*   **Activity Context**: Shows the "Last Transaction Date" and "On-hand Quantity". A zero-cost item with stock or recent activity is a high-priority fix.
*   **Creation Date Filtering**: Allows users to focus on recently created items (e.g., "Show me all items created this week with zero cost").
*   **Category Filtering**: Supports filtering by item categories (e.g., Product Line) to route the missing cost requests to the appropriate analysts.

## Architecture
The query joins `MTL_SYSTEM_ITEMS` (Item Master) with `CST_ITEM_COSTS` (Cost table). It typically uses an outer join to find items that might not even have a record in the cost table yet.

**Key Tables:**
*   `MTL_SYSTEM_ITEMS`: Defines the item and its attributes (Make/Buy, Asset/Expense).
*   `CST_ITEM_COSTS`: Stores the standard cost for the item.
*   `MTL_ONHAND_QUANTITIES`: (Aggregated) to show if the item is currently in stock.
*   `MTL_MATERIAL_TRANSACTIONS`: To find the last transaction date.

## Impact
*   **Data Quality**: Ensures the integrity of the item master and cost data.
*   **Financial Accuracy**: Prevents the recording of zero-value transactions that distort financial statements.
*   **Proactive Management**: Enables the cost team to catch missing costs immediately after item creation, rather than waiting for a month-end error report.


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
