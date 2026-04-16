---
layout: default
title: 'CAC ICP PII Inventory and Intransit Value (Period-End) | Oracle EBS SQL Report'
description: 'Report showing amount of profit in inventory at the end of the month. If you enter a cost type this report uses the item costs from the cost type; if you…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, CAC, ICP, PII, Inventory, mtl_secondary_inventories, inv_organizations, cst_cost_group_accounts'
permalink: /CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/
---

# CAC ICP PII Inventory and Intransit Value (Period-End) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-inventory-and-intransit-value-period-end/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report showing amount of profit in inventory at the end of the month.  If you enter a cost type this report uses the item costs from the cost type; if you leave the cost type blank it uses the item costs from the month-end snapshot.  In either case this report uses the month-end quantities, based on the entered period name.  And as these quantities come from the month-end snapshot (created when you close the inventory accounting period) and this snapshot is only by inventory organization, subinventory and item and not split out by cost element, this report only shows the Material Account, based upon your Costing Method.

Notes:
1)  Profit in inventory is abbreviated as PII or sometimes as ICP - InterCompany Profit.
2)  There is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type.  Defaulted as positive (+1).

/* +=============================================================================+
-- | Copyright 2009 - 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is  acknowledged.  No warranties, express or otherwise is included in this  permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Hidden Parameters:
-- |  p_sign_pii          -- Hidden parameter to set the sign of the profit in
-- |                         inventory amounts.  This parameter determines if PII
-- |                         is normally entered as a positive or negative amount.
-- |  Displayed Parameters:
-- |  4 p_period_name     -- Accounting period you wish to report for
-- |  5 p_cost_type       -- Enter a Cost Type to value the quantities
-- |                         using the Cost Type Item Costs; or, if 
-- |                         Cost Type is blank or null the report will 
-- |                         use the stored month-end snapshot values
-- |  6 p_pii_cost_type   -- The PII Cost Type you wish to report (mandatory)
-- |  6 p_pii_sub_element -- The sub-element or resource for profit in inventory,
-- |                         such as PII or ICP (mandatory)
-- |  p_category_set1     -- The first item category set to report, typically the
-- |                         Cost or Product Line Category Set
-- |  p_category_set2     -- The second item category set to report, typically the
-- |                         Inventory Category Set
-- |  4 p_item_number     -- Enter the specific item number you wish to report (optional)
-- |  3 p_subinventory    -- Enter the specific subinventory you wish to report (optional)
-- |  2 p_org_code        -- Specific inventory organization you wish to report (optional)
-- |  1 p_operating_unit  -- Operating Unit you wish to report, leave blank for all
-- |                         operating units (optional) 
-- |  1 p_ledger          -- general ledger you wish to report, leave blank for all
-- |                         ledgers (optional) 
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.19    20 Mar 2022 Douglas Volz Fix for category accounts (valuation accounts) and
-- |                                  added subinventory description.
-- | 1.20    19 Oct 2022 Douglas Volz Fix for valuation accounts, causing duplicate rows.
-- | 1.21    21 Oct 2022 Douglas Volz Fix for detecting Cost Group Accounting.
-- +=============================================================================+*/

## Report Parameters
Period Name (Closed), Cost Type, PII Cost Type, PII Sub-Element, Category Set 1, Category Set 2, Category Set 3, Item Number, Subinventory, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [inv_organizations](https://www.enginatics.com/library/?pg=1&find=inv_organizations), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [valuation_accounts](https://www.enginatics.com/library/?pg=1&find=valuation_accounts), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [pii](https://www.enginatics.com/library/?pg=1&find=pii), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [select](https://www.enginatics.com/library/?pg=1&find=select), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [inventory_asset_flag](https://www.enginatics.com/library/?pg=1&find=inventory_asset_flag), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [nvl](https://www.enginatics.com/library/?pg=1&find=nvl), [sum](https://www.enginatics.com/library/?pg=1&find=sum), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Inventory and Intransit Value (Period-End) - Pivot by Org 21-Oct-2022 201233.xlsx](https://www.enginatics.com/example/cac-icp-pii-inventory-and-intransit-value-period-end/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Inventory_and_Intransit_Value_Period_End.xml](https://www.enginatics.com/xml/cac-icp-pii-inventory-and-intransit-value-period-end/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-inventory-and-intransit-value-period-end/](https://www.enginatics.com/reports/cac-icp-pii-inventory-and-intransit-value-period-end/) |

## Case Study & Technical Analysis: CAC ICP PII Inventory and Intransit Value (Period-End)

### Executive Summary
The **CAC ICP PII Inventory and Intransit Value (Period-End)** report is a specialized financial tool designed to calculate and report the **Intercompany Profit (ICP)** or **Profit in Inventory (PII)** trapped within the ending inventory balances. For multinational corporations that transfer goods between subsidiaries at a markup (transfer price), this profit must be eliminated from the consolidated financial statements. This report provides the granular data needed to calculate that elimination entry at month-end.

### Business Challenge
When Entity A sells to Entity B at a profit, and Entity B still holds that inventory at month-end, the consolidated entity has not yet realized that profit (since it hasn't been sold to an external customer).
*   **Tracking Complexity:** The "profit" portion is often hidden within the standard cost of the item in the receiving organization.
*   **Data Volume:** Calculating this across thousands of items and multiple inventory organizations is manually impossible.
*   **Period-End Accuracy:** The calculation must be based on the *exact* quantities on hand at the moment the period was closed, not the current real-time quantity.
*   **Intransit Visibility:** Goods in transit between organizations also contain unrealized profit and must be included.

### The Solution
This report solves the problem by:
1.  **Snapshot-Based Quantities:** Using `CST_PERIOD_CLOSE_SUMMARY` to get the exact frozen quantities at period close.
2.  **Dual Costing:** Comparing the standard inventory value against a specific "PII Cost Type" (which holds the profit component) or extracting the profit from a specific Cost Element/Sub-Element.
3.  **Intransit Inclusion:** Calculating the value of goods currently moving between organizations (Intransit Inventory).
4.  **Automated Elimination:** Providing the exact dollar amount of profit that needs to be credited to the Inventory account and debited to the COGS/Profit Elimination account.

### Technical Architecture (High Level)
The query is complex, involving multiple layers of logic to handle different costing methods (Standard vs. Average/Cost Group).
*   **Quantity Source:** `CST_PERIOD_CLOSE_SUMMARY` provides the official month-end quantities for both On-hand and Intransit (depending on the version/setup).
*   **Valuation Source:**
    *   **Inventory Value:** Derived from the item's cost in the current organization.
    *   **Profit Value:** Derived from `CST_ITEM_COST_DETAILS` or `CST_ITEM_COSTS` using the parameters `PII Cost Type` and `PII Sub-Element`.
*   **Organization Logic:** A Common Table Expression (CTE) `inv_organizations` is used to pre-fetch organization details, ledger mappings, and Cost Group accounting flags to simplify the main query.

### Parameters & Filtering
*   **Period Name:** The closed accounting period to report on (Critical for reconciliation).
*   **PII Cost Type:** The specific cost type where the profit component is stored (or the cost type used to calculate the delta).
*   **PII Sub-Element:** The specific cost sub-element (e.g., "ICP", "Markup") that represents the profit.
*   **Numeric Sign for PII:** A hidden parameter to control whether the output is positive or negative (for journal entry ease).

### Performance & Optimization
*   **CTE Usage:** The `inv_organizations` CTE reduces repetitive joins to HR and GL tables.
*   **Snapshot Access:** Querying `CST_PERIOD_CLOSE_SUMMARY` is generally faster and more accurate for historical reporting than trying to roll back transactions from `MTL_MATERIAL_TRANSACTIONS`.

### FAQ
**Q: What is the difference between "PII" and "ICP"?**
A: They are usually synonymous in this context. PII stands for "Profit in Inventory," and ICP stands for "Intercompany Profit." Both refer to the unrealized margin held in stock.

**Q: Why do I need a separate "PII Cost Type"?**
A: In many implementations, the "Frozen" cost includes the profit. To know *how much* is profit, companies often maintain a parallel cost type (e.g., "IC_COST") that represents the true manufacturing cost, or they isolate the profit into a specific Material Overhead sub-element. This report supports the sub-element approach.

**Q: Does this report include Intransit Inventory?**
A: Yes, the title and logic indicate it covers Intransit Value, which is crucial as significant profit can be "floating" between warehouses at month-end.


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
