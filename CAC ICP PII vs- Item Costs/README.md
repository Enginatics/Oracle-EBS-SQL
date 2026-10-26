---
layout: default
last_modified_at: 2026-10-26
title: 'CAC ICP PII vs. Item Costs | Oracle EBS SQL Report'
description: 'Report to compare the Frozen or Pending Costs against the PII item costs. If you enter a Period Name this report also shows the stored month-end from the…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, ICP, PII, vs., mtl_onhand_quantities_detail, mtl_secondary_inventories, mtl_supply'
permalink: /CAC%20ICP%20PII%20vs-%20Item%20Costs/
report_name: 'CAC ICP PII vs. Item Costs'
report_web_name: cac-icp-pii-vs-item-costs
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC ICP PII vs. Item Costs – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.8     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, PII Cost Type, PII Sub-Element, Period Name (Closed), Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)

## Related Reports
[CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [INV Slow Moving Inventory](/INV%20Slow%20Moving%20Inventory/ "INV Slow Moving Inventory Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20vs-%20Item%20Costs/CAC%20ICP%20PII%20vs-%20Item%20Costs.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII vs. Item Costs 03-Sep-2022 232153.xlsx](https://www.enginatics.com/example/cac-icp-pii-vs-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) |
| Blitz Report™ XML Import | [CAC_ICP_PII_vs_Item_Costs.xml](https://www.enginatics.com/xml/cac-icp-pii-vs-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) |
| SQL Source | [CAC ICP PII vs- Item Costs.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20vs-%20Item%20Costs/CAC%20ICP%20PII%20vs-%20Item%20Costs.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-icp-pii-vs-item-costs/](https://www.enginatics.com/reports/cac-icp-pii-vs-item-costs/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-vs-item-costs)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
