---
layout: default
last_modified_at: 2026-10-16
title: 'CAC WIP Pending Cost Adjustment | Oracle EBS SQL Report'
description: 'Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues, WIP resource (labor) and WIP…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, WIP, Pending, Cost, mtl_system_items_vl, mtl_units_of_measure_vl, mtl_item_status_vl'
permalink: /CAC%20WIP%20Pending%20Cost%20Adjustment/
report_name: 'CAC WIP Pending Cost Adjustment'
report_web_name: cac-wip-pending-cost-adjustment
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC WIP Pending Cost Adjustment – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report showing the potential standard cost changes for WIP discrete jobs, for the WIP completions, WIP component issues, WIP resource (labor) and WIP overhead transactions.  However, WIP cost adjustments for Assembly Scrap is not included.  The Cost Type (Old) defaults to your Costing Method Cost Type (Average, Standard, etc.); the Currency Conversion Dates default to the latest open or closed accounting period; and the To Currency Code and the Organization Code default from the organization code set for this session.   And if you choose Yes for "Include All WIP Jobs" all WIP jobs will be reported even if there are no valuation changes.

Parameters:
===========
Cost Type (New):  enter the Cost Type that has the revised or new item costs (mandatory).
Cost Type (Old):  enter the Cost Type that has the existing or current item costs, defaults to the Frozen Cost Type (mandatory).
Currency Conversion Date (New):  enter the currency conversion date to use for the new item costs (mandatory).
Currency Conversion Type (New):  enter the currency conversion type to use for the new item costs, defaults to Corporate (mandatory).
Currency Conversion Date (Old):  enter the currency conversion date to use for the existing item costs (mandatory).
Currency Conversion Type (Old):  enter the currency conversion type to use for the existing item costs, defaults to Corporate (mandatory).
To Currency Code:  enter the currency code used to translate the item costs and inventory values into.
Category Set 1 - 3:  up to three item categories to report, typically the Inventory, Cost or Product Line Category Sets (optional).
Include All WIP Jobs:  enter No to only report WIP jobs with valuation changes, enter Yes to report all WIP jobs. (mandatory).
Item Number:  specific buy or make item you wish to report (optional).
Organization Code:  enter the inventory organization(s) you wish to report, defaults to your session's inventory organization (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- |  Copyright 2020 - 2025 Douglas Volz Consulting, Inc.
-- |  Permission to use this code is granted provided the original author is
-- |  acknowledged.  No warranties, express or otherwise is included in this
-- |  permission. All rights reserved.
-- +=============================================================================+

-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 04 Dec 2020 Douglas Volz   Created initial Report based on the Pending
-- |                                     Cost Adjustment Report for Inventory and Intransit.
-- |      1.1 11 Dec 2020 Douglas Volz   Corrected cost adjustments for assemblies
-- |      1.2 16 Dec 2020 Douglas Volz   Change SIGN of completion quantities to match
-- |                                     the Oracle WIP Standard Cost Adjustment Report.
-- |      1.3 10 Feb 2021 Douglas Volz   Fixes for WIP completion quantities, needed to
-- |                                     change the SIGN of completion quantities.
-- |      1.4 17 Feb 2021 Douglas Volz   Add absolute difference column.
-- |      1.5 13 Dec 2021 Douglas Volz   Add parameter to report all WIP jobs, even
-- |                                     if there is no valuation change.
-- |      1.6 12 Feb 2024 Douglas Volz   Remove tabs, simplify G/L conversion rates,
-- |                                     added inventory org access security.
-- |      1.7 20 Jul 2026 Douglas Volz   Added in overhead cost and valuation differences.
-- |      1.8 26 Sep 2026 Enginatics     Currency rate and overhead corrections.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type (New), Cost Type (Old), Currency Conversion Date (New), Currency Conversion Type (New), Currency Conversion Date (Old), Currency Conversion Type (Old), To Currency Code, Category Set 1, Category Set 2, Category Set 3, Include All WIP Jobs, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [gl_daily_rates](https://www.enginatics.com/library/?pg=1&find=gl_daily_rates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [gl_daily_conversion_types](https://www.enginatics.com/library/?pg=1&find=gl_daily_conversion_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_accounting_classes](https://www.enginatics.com/library/?pg=1&find=wip_accounting_classes&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [cst_resource_costs](https://www.enginatics.com/library/?pg=1&find=cst_resource_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [bom_department_resources](https://www.enginatics.com/library/?pg=1&find=bom_department_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [cst_department_overheads](https://www.enginatics.com/library/?pg=1&find=cst_department_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment), [cst_resource_overheads](https://www.enginatics.com/library/?pg=1&find=cst_resource_overheads&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)

## Related Reports
[CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC WIP Period Balances to Accounting Activity Reconciliation](/CAC%20WIP%20Period%20Balances%20to%20Accounting%20Activity%20Reconciliation/ "CAC WIP Period Balances to Accounting Activity Reconciliation Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status Which Are Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20Which%20Are%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status Which Are Ready for Close Oracle EBS SQL Report"), [CAC WIP Jobs With Complete Status But Not Ready for Close](/CAC%20WIP%20Jobs%20With%20Complete%20Status%20But%20Not%20Ready%20for%20Close/ "CAC WIP Jobs With Complete Status But Not Ready for Close Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Pending%20Cost%20Adjustment/CAC%20WIP%20Pending%20Cost%20Adjustment.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC WIP Pending Cost Adjustment 10-Jul-2022 165903.xlsx](https://www.enginatics.com/example/cac-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) |
| Blitz Report™ XML Import | [CAC_WIP_Pending_Cost_Adjustment.xml](https://www.enginatics.com/xml/cac-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) |
| SQL Source | [CAC WIP Pending Cost Adjustment.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20WIP%20Pending%20Cost%20Adjustment/CAC%20WIP%20Pending%20Cost%20Adjustment.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-wip-pending-cost-adjustment/](https://www.enginatics.com/reports/cac-wip-pending-cost-adjustment/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment) |

## Case Study & Technical Analysis: CAC WIP Pending Cost Adjustment

### Executive Summary
The **CAC WIP Pending Cost Adjustment** report is a predictive financial tool used during the Standard Cost Update process. While the "Inventory Pending Cost Adjustment" report covers goods on the shelf, this report covers goods *in production*.
It simulates the revaluation of Work in Process (WIP) balances that will occur when standard costs are updated. This allows Finance to:
1.  **Forecast WIP Revaluation:** Predict the gain or loss that will hit the P&L due to the revaluation of open jobs.
2.  **Validate Resource Rates:** Ensure that changes to labor and machine rates are correctly reflected in the WIP value.
3.  **Audit Component Costs:** Verify that the new standard costs for raw materials are correctly propagating to the jobs where they have been issued.

### Business Challenge
Updating standard costs affects not just inventory, but also the value of every open work order.
*   **The "WIP Revaluation" Event:** When you run "Update Standard Costs," Oracle takes a snapshot of all open jobs.
    *   If you issued a component at $10 (Old Cost) and it is now $12 (New Cost), the system revalues that issued quantity and posts a $2 variance.
    *   If you completed an assembly at $100 (Old Cost) but it hasn't been closed, and the new cost is $110, the system adjusts the relief amount.
*   **Complexity:** WIP value is a mix of Materials, Resources, Overheads, and Outside Processing. A simple "Item Cost" report doesn't show the impact on labor or machine time already charged to the job.

### The Solution
This report acts as a "What-If" engine for WIP.
*   **Three-Pronged Analysis:** It breaks down the revaluation into:
    1.  **WIP Completions:** The impact on the assembly itself (for jobs that are partially complete).
    2.  **Component Issues:** The impact on raw materials sitting in the job.
    3.  **Resources:** The impact on labor and machine hours already charged.
*   **Currency Simulation:** Like its Inventory counterpart, it allows users to simulate the impact of exchange rate changes on the cost of components or resources defined in foreign currencies.
*   **Granular Visibility:** It lists every job, operation, and resource, allowing users to pinpoint exactly *where* the value change is coming from (e.g., "Job 12345, Operation 10, Labor Rate increase").

### Technical Architecture (High Level)
The query constructs a massive union of the three WIP value drivers.
*   **Component Logic:**
    *   Scans `WIP_REQUIREMENT_OPERATIONS` (or `MTL_MATERIAL_TRANSACTIONS` depending on the exact logic variant) to find issued quantities.
    *   Joins to `CST_ITEM_COSTS` twice (Old vs. New) to calculate the delta.
*   **Resource Logic:**
    *   Scans `WIP_OPERATIONS` (or `WIP_TRANSACTION_ACCOUNTS` history) to find applied resource hours.
    *   Joins to `BOM_RESOURCES` and `CST_ITEM_COSTS` (for resource rates) to calculate the delta.
*   **Assembly Logic:**
    *   Looks at `WIP_DISCRETE_JOBS.QUANTITY_COMPLETED` to determine the relief value adjustment.
*   **Exclusions:** The description notes that "resource overheads / production overheads are not included." This is a key technical detail—it focuses on the *direct* costs (Material and Direct Labor) rather than the allocated burdens.

### Parameters & Filtering
*   **Cost Type (New/Old):** The two sets of costs to compare.
*   **Currency Conversion:** For simulating FX impacts.
*   **Include All WIP Jobs:** A toggle to show even those jobs with $0 variance (useful for proving that a cost update *won't* affect certain product lines).
*   **Organization/Item:** Standard filters.

### Performance & Optimization
*   **Union All:** The query likely uses `UNION ALL` to combine the Component, Resource, and Assembly datasets. This is efficient but results in a large number of rows for high-volume manufacturing.
*   **Cost Type Filtering:** By filtering `CST_ITEM_COSTS` early, the query minimizes the join volume.

### FAQ
**Q: Why is the "New Material Overhead Cost" calculated differently for WIP Completions?**
A: The code snippet shows a `CASE` statement: `round(nvl(cic1.material_overhead_cost,0) - nvl(cic1.tl_material_overhead,0),5)`. This logic subtracts "This Level" (TL) overheads. This is likely to avoid double-counting overheads that are applied at the assembly level versus those rolled up from components.

**Q: Does this report update the costs?**
A: No, it is purely a reporting tool. The actual update happens when you run the "Update Standard Costs" concurrent program.

**Q: Why don't I see Overhead variances?**
A: As noted in the description, this specific version of the report excludes overheads. This is often done because overheads are calculated as a percentage of resource/material, so their variance is a derivative of the base cost variance.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-wip-pending-cost-adjustment)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
