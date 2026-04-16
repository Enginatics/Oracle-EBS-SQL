---
layout: default
title: 'CAC ICP PII vs. Item Costs | Oracle EBS SQL Report'
description: 'Report to compare the Frozen or Pending Costs against the PII item costs. If you enter a Period Name this report also shows the stored month-end from the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, ICP, PII, vs., cst_item_costs, mtl_system_items_vl, mtl_item_status_vl'
permalink: /CAC%20ICP%20PII%20vs-%20Item%20Costs/
---

# CAC ICP PII vs. Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to compare the Frozen or Pending Costs against the PII item costs.  If you enter a Period Name this report also shows the stored month-end from the period end snapshot (snapshot that is created when you close the inventory periods).  If you leave the Period Name blank or null you will report the real-time onhand quantities.  Also note that this report excludes inactive items.

Note:  there is a hidden parameter, Numeric Sign for PII, which allows you to set the sign of the profit in inventory amounts.  You can specify positive or negative values based on how you enter PII amounts into your PII Cost Type.  Defaulted as positive (+1).

Parameters:
==========
Cost Type:  defaults to your Costing Method; if the cost type is missing component costs the report will find any missing item costs from your Costing Method cost type.
PII Cost Type:  the profit in inventory cost type you wish to report
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP (optional)
Period Name (Closed):  Accounting period you wish to report for the onhand quantities at month-end,  If you leave this value blank or null you get the real-time onhand quantities.
Category Set 1:  any item category you wish, typically the Product or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Cost category set (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2009 - 2022 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged. No warranties, express or otherwise is included in this
-- |  permission.
-- +=============================================================================+
-- | Version Modified on Modified by Description
-- | ======= =========== =====================================================
-- | 1.0     29 Sep 2009 Douglas Volz   Initial Coding
-- | 1.4     01 May 2019 Douglas Volz   Period name is now optional, if left null
-- |                                    the real-time quantities are reported.
-- | 1.5     27 Jan 2020 Douglas Volz   Added Org Code and Operating Unit parameters.
-- | 1.6     26 Feb 2022 Douglas Volz   Changed to multi-language views for items, 
-- |                                    item status and UOM.  Added List Price, 
-- |                                    Market Price and Currency Code to report. 
-- |                                    Exclude items with a status of Inactive.
-- | 1.7     26 Sep 2022 Douglas Volz   Performance improvements and removed group by.
-- +=============================================================================+*/

## Report Parameters
Cost Type, PII Cost Type, PII Sub-Element, Period Name (Closed), Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII vs. Item Costs 03-Sep-2022 232153.xlsx](https://www.enginatics.com/example/cac-icp-pii-vs-item-costs/) |
| Blitz Report™ XML Import | [CAC_ICP_PII_vs_Item_Costs.xml](https://www.enginatics.com/xml/cac-icp-pii-vs-item-costs/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-icp-pii-vs-item-costs/](https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/) |

## Case Study & Technical Analysis: CAC ICP PII vs. Item Costs

### Executive Summary
The **CAC ICP PII vs. Item Costs** report is a strategic validation tool used to audit the relationship between standard inventory costs and their embedded intercompany profit (PII) components. It serves two primary functions: validating that PII is correctly defined as a percentage of the total cost, and providing a valuation snapshot that compares "Gross Inventory Value" (with profit) vs. "Net Inventory Value" (without profit). This report is essential for ensuring that transfer pricing policies are correctly reflected in the system's cost data.

### Business Challenge
In complex supply chains, items may have PII components that are supposed to represent a specific margin (e.g., 10% of the total cost). However, due to manual errors, cost rollups, or currency fluctuations, the actual PII amount in the system might drift.
*   **Policy Compliance:** Finance needs to verify if the PII stored in the system matches the corporate transfer pricing policy.
*   **Valuation Analysis:** For management reporting, companies often need to see inventory value at "Standard Cost" vs. "Consolidated Cost" (Standard - PII).
*   **Data Integrity:** Identifying items where PII > Total Cost (which is impossible and indicates a data error) or where PII exists for "Buy" items that shouldn't have it.

### The Solution
This report provides a side-by-side comparison of the total item cost and its PII component.
*   **Cost Breakdown:** It displays `Item Cost` (Standard), `PII Item Cost` (Profit), and `Net Item Cost` (Cost Basis).
*   **Percentage Check:** It calculates the `PII Percent` (`PII / Total Cost`), allowing users to quickly spot outliers (e.g., sorting by percentage to find items with 0% or >50% profit).
*   **Dual-Mode Quantity:**
    *   **Historical Mode:** If a `Period Name` is entered, it pulls quantities from the month-end snapshot (`CST_PERIOD_CLOSE_SUMMARY`), matching the official closing balances.
    *   **Real-Time Mode:** If `Period Name` is blank, it pulls current on-hand quantities (`MTL_ONHAND_QUANTITIES_DETAIL`), useful for mid-month auditing.

### Technical Architecture (High Level)
The query joins the standard cost definition table with a specialized PII calculation subquery.
*   **Cost Type Join:** It joins `CST_ITEM_COSTS` (for the main Cost Type, usually "Frozen" or "Average") with a subquery on `CST_ITEM_COST_DETAILS` (for the specific PII Cost Type and Sub-Element).
*   **Dynamic Quantity Logic:** A complex `LEFT JOIN` structure determines the source of the quantity data (Snapshot vs. Real-Time) based on the presence of the `:p_period_name` parameter.
*   **Net Calculation:** The report performs the math `Total Cost - (Sign * PII Cost)` dynamically, handling the `Numeric Sign for PII` parameter to ensure correct netting regardless of whether PII is stored as a positive or negative value.

### Parameters & Filtering
*   **Cost Type:** The primary costing method (e.g., Frozen, Average) to compare against.
*   **PII Cost Type & Sub-Element:** The specific cost bucket holding the profit value.
*   **Period Name (Closed):** The switch that toggles between historical snapshot data and real-time on-hand data.
*   **Category Sets:** Allows for analysis by Product Line or Cost Category.

### Performance & Optimization
*   **Snapshot Utilization:** When running for a closed period, using `CST_PERIOD_CLOSE_SUMMARY` is significantly faster than summing transaction history.
*   **Inactive Item Exclusion:** The report automatically filters out inactive items to keep the output focused on relevant inventory.

### FAQ
**Q: Why is the "Net Item Cost" higher than the "Item Cost"?**
A: This happens if your `Numeric Sign for PII` parameter is set incorrectly. If PII is stored as a negative number (contra-asset) but you tell the report it's positive, the math will add it instead of subtracting it.

**Q: Can I use this to check Pending Costs before a standard cost update?**
A: Yes. Set the `Cost Type` parameter to "Pending" (or whatever your simulation cost type is named) to validate the new costs and PII values before they are frozen.

**Q: Why do some items show 0 Quantity?**
A: If you run in Real-Time mode, it shows items even if they have 0 on-hand, as long as they have a cost defined. This is useful for checking master data setup even for items currently out of stock.


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
