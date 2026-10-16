---
layout: default
last_modified_at: 2026-10-16
title: 'CAC ICP PII Inventory Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing potential standard cost changes for onhand and intransit inventory value which you own, for gross, profit in inventory and net inventory…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, ICP, PII, Inventory, mtl_category_accounts, mtl_parameters, hr_organization_information'
permalink: /CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/
report_name: 'CAC ICP PII Inventory Pending Cost Adjustment'
report_web_name: cac-icp-pii-inventory-pending-cost-adjustment
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC ICP PII Inventory Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-icp-pii-inventory-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report showing potential standard cost changes for onhand and intransit inventory value which you own, for gross, profit in inventory and net inventory values.  If you enter a period name this report uses quantities from the month-end snapshot; if you leave the period name blank it uses the real-time quantities.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.), the Currency Conversion Dates default to the current accounting period, and the To Currency Code and the Organization Code default from the organization code set for this session.  And to use the quantities from the month-end snapshot, you can only choose closed accounting periods as the month-end snapshot is created when you close the inventory accounting period.

Note:  If using this report for reporting after the standard cost update this report requires both the before and after cost types available after the standard cost update is run.
           Please save your frozen costs to another Cost Type before running the standard cost update, using the item cost copy.

Hidden Parameters:
Sign PII:  hidden parameter to set the sign of the profit in inventory amounts.  This parameter determines if PII is normally entered as a positive or negative amount.
Default value for this report assumes PII costs are entered as positive amounts.

Displayed Parameters:
Cost Type (New):  the new cost type to be reported, mandatory
Cost Type (Old):  the old cost type to be reported, mandatory
PII Cost Type (New):  the new PII Cost Type you wish to report, such as PII or ICP, mandatory
PII Cost Type (Old):  the prior or old PII Cost Type you wish to report, such as PII or ICP, mandatory
PII Sub-Element:  the sub-element or resource for profit in inventory, such as PII or ICP, mandatory
Currency Conversion Date(New):  the new currency conversion date, mandatory
Currency Conversion Date (Old):  the old currency conversion date, mandatory
Currency Conversion Type (New):  the desired currency conversion type to use for cost type 1, mandatory
Currency Conversion Type (Old):  the desired currency conversion type to use for cost type 2, mandatory
To Currency Code:  the currency you are converting into
Period Name:  enter a Period Name to use the month-end snapshot; if no  period name is entered will use the real-time quantities
Category Set1:  the first item category set to report, typically the  Cost or Product Line Category Set
Category Set2:  the second item category set to report, typically the Inventory Category Set
Include Zero Quantities:  include items with no onhand or no intransit quantities
Only Items in Cost Type:  only report items in the New Cost Type
Item Number:  specific item number to report, leave blank for all operating units, optional
Organization Code:  specific inventory organization you wish to report, optional
Operating Unit:  Operating Unit you wish to report, leave blank for all operating units, optional
Ledger:  general ledger you wish to report, leave blank for all ledgers, optional

-- |  Copyright 2008-2024 Douglas Volz Consulting, Inc.
-- |  All rights reserved.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this permission.

-- |  Version Modified on  Modified  by   Desc
-- |  ======= =========== ============== =========================================
-- |      1.0 21 Nov 2010 Douglas Volz   Created initial Report for prior client based on BBCI_INV_VALUE_STD_ADJ_FX_REPT1.7.sql
-- |     1.14 07 Feb 2024 Douglas Volz   Add item master and costing lot sizes, use default controls,
-- |                                     based on rollup and shrinkage rate columns.  Added in GL and OU security restrictions.
-- |     1.15 25 Jun 2024 Douglas Volz   Reinstalled missing parameter, To Currency Code.  Commented out GL and OU security restrictions.
-- +=============================================================================

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Period Name (Closed), Cost Type (New), Cost Type (Old), PII Cost Type (New), PII Cost Type (Old), PII Sub-Element, Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Only Items in New Cost Type, Include Items With No Quantities, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_category_accounts](https://www.enginatics.com/library/?pg=1&find=mtl_category_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_cost_group_accounts](https://www.enginatics.com/library/?pg=1&find=cst_cost_group_accounts&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_categories_b](https://www.enginatics.com/library/?pg=1&find=mtl_categories_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_category_sets_b](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_interorg_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_interorg_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment), [mtl_supply](https://www.enginatics.com/library/?pg=1&find=mtl_supply&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)

## Related Reports
[CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Material Account Detail](/CAC%20ICP%20PII%20Material%20Account%20Detail/ "CAC ICP PII Material Account Detail Oracle EBS SQL Report"), [CAC Category Accounts Setup](/CAC%20Category%20Accounts%20Setup/ "CAC Category Accounts Setup Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC ICP PII Inventory Pending Cost Adjustment 23-Jun-2022 152034.xlsx](https://www.enginatics.com/example/cac-icp-pii-inventory-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) |
| Blitz Report™ XML Import | [CAC_ICP_PII_Inventory_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-icp-pii-inventory-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) |
| SQL Source | [CAC ICP PII Inventory Pending Cost Adjustment.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-icp-pii-inventory-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-icp-pii-inventory-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment) |

## Case Study & Technical Analysis: CAC ICP PII Inventory Pending Cost Adjustment

### Executive Summary
The **CAC ICP PII Inventory Pending Cost Adjustment** report is a critical pre-update analysis tool for multinational organizations that manage Intercompany Profit (ICP) or Profit in Inventory (PII). Before committing a Standard Cost Update, finance teams must understand the financial impact of changing costs. This report specifically isolates the impact on the "Profit" portion of inventory value, allowing users to forecast the revaluation of PII separately from the revaluation of the base inventory cost.

### Business Challenge
When standard costs are updated, the value of existing inventory changes, resulting in a revaluation gain or loss. For companies that track intercompany profit (the markup added when goods move between subsidiaries), this revaluation has two distinct components:
1.  **Base Cost Revaluation:** The change in the true manufacturing cost.
2.  **Profit Revaluation:** The change in the embedded profit margin.

Mixing these two creates financial reporting risks. If the profit portion increases, it shouldn't be recognized as income but rather deferred. Finance teams need to know exactly how much the "Profit" bucket will change *before* running the update to book the correct elimination entries.

### The Solution
This report provides a "What-If" analysis by comparing two cost scenarios (Old vs. New) against the current (or historical) inventory quantities.
*   **Dual-Dimension Analysis:** It compares `Cost Type (Old)` vs. `Cost Type (New)` for the base inventory, AND `PII Cost Type (Old)` vs. `PII Cost Type (New)` for the profit component.
*   **Flexible Quantity Source:** It can run against real-time quantities (for mid-month analysis) or frozen period-end snapshots (for month-end reconciliation).
*   **Currency Simulation:** It allows users to simulate the impact in a different reporting currency using specific conversion rates and dates.

### Technical Architecture (High Level)
The report is built on a complex query structure that unions On-hand and Intransit inventory.
*   **Quantity Logic:**
    *   If `Period Name` is provided: Uses `CST_PERIOD_CLOSE_SUMMARY` (Snapshot).
    *   If `Period Name` is null: Uses `MTL_ONHAND_QUANTITIES_DETAIL` (Real-time) and `MTL_SUPPLY` (Intransit).
*   **Costing Logic:** It performs four distinct cost lookups per item:
    1.  Old Standard Cost
    2.  New Standard Cost
    3.  Old PII Cost (via specific Cost Type or Sub-Element)
    4.  New PII Cost (via specific Cost Type or Sub-Element)
*   **Organization CTE:** Uses a `inv_organizations` Common Table Expression to centralize organization, ledger, and currency details, ensuring consistent filtering across the complex unions.

### Parameters & Filtering
*   **Cost Types (New/Old):** The primary standard cost types being compared.
*   **PII Cost Types (New/Old):** The specific cost types holding the profit component (often a "Simulation" type vs. "Frozen").
*   **PII Sub-Element:** The specific resource or overhead sub-element used to tag profit (e.g., "ICP_Markup").
*   **Currency Conversion:** Parameters to define the exchange rates for the "New" and "Old" scenarios, allowing for FX impact analysis on the revaluation.
*   **Period Name:** Determines whether to use snapshot or real-time data.

### Performance & Optimization
*   **Union All:** The query efficiently combines On-hand and Intransit data using `UNION ALL` rather than complex joins, allowing the database to optimize each branch independently.
*   **Snapshot Usage:** Using the period close snapshot is significantly faster for historical analysis than rolling back transactions.

### FAQ
**Q: Why do I need to specify both "Cost Type" and "PII Cost Type"?**
A: The "Cost Type" represents the full value of the item (Base + Profit). The "PII Cost Type" is often a shadow cost type used to track *only* the profit component, or the report uses it to isolate the specific sub-element value.

**Q: Can I use this report for the actual month-end close?**
A: Yes. By selecting a closed `Period Name`, the report uses the official frozen quantities, making it perfect for calculating the final month-end PII elimination entry.

**Q: What happens if I leave the Period Name blank?**
A: The report will use current real-time on-hand quantities. This is useful for mid-month forecasting to see what the impact *would* be if you updated costs today.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-icp-pii-inventory-pending-cost-adjustment)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
