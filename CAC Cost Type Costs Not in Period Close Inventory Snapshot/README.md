---
layout: default
title: 'CAC Cost Type Costs Not in Period Close Inventory Snapshot | Oracle EBS SQL Report'
description: 'Report comparing the month-end items, balances and costs against any entered Cost Type, showing which item numbers in your month-end inventory which are…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Cost, Type, Costs, mtl_parameters, mtl_units_of_measure_vl, mtl_item_status_vl'
permalink: /CAC%20Cost%20Type%20Costs%20Not%20in%20Period%20Close%20Inventory%20Snapshot/
---

# CAC Cost Type Costs Not in Period Close Inventory Snapshot – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-cost-type-costs-not-in-period-close-inventory-snapshot/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report comparing the month-end items, balances and costs against any entered Cost Type, showing which item numbers in your month-end inventory which are not in your Cost Type.  You automatically save off your month-end quantities and values when you close the inventory accounting period.

Parameters:
==========
Period Name (Closed):  the closed inventory accounting period you wish to report (mandatory).
Cost Type:  enter a Cost Type to compare against the stored month-end items, quantities and values (mandatory).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  any inventory organization, defaults to your session's inventory organization (optional).
Operating Unit:  specific operating unit (optional)
Ledger:  specific ledger (optional)

/* +=============================================================================+
-- | Copyright 2024 - 2025 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     15 Jan 2024 Douglas Volz Initial Coding
-- | 1.1     04 Mar 2025 Douglas Volz Removed tabs, add ledger and operating unit
-- |                                  columns and security access profiles.
-- +=============================================================================+*/

## Report Parameters
Period Name (Closed), Cost Type, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [select](https://www.enginatics.com/library/?pg=1&find=select), [inventory_item_id](https://www.enginatics.com/library/?pg=1&find=inventory_item_id), [concatenated_segments](https://www.enginatics.com/library/?pg=1&find=concatenated_segments), [regexp_replace](https://www.enginatics.com/library/?pg=1&find=regexp_replace), [primary_uom_code](https://www.enginatics.com/library/?pg=1&find=primary_uom_code), [inventory_item_status_code](https://www.enginatics.com/library/?pg=1&find=inventory_item_status_code), [item_type](https://www.enginatics.com/library/?pg=1&find=item_type), [inventory_asset_flag](https://www.enginatics.com/library/?pg=1&find=inventory_asset_flag), [period_name](https://www.enginatics.com/library/?pg=1&find=period_name), [acct_period_id](https://www.enginatics.com/library/?pg=1&find=acct_period_id), [nvl](https://www.enginatics.com/library/?pg=1&find=nvl), [sum](https://www.enginatics.com/library/?pg=1&find=sum), [cst_period_close_summary](https://www.enginatics.com/library/?pg=1&find=cst_period_close_summary), [org_acct_periods](https://www.enginatics.com/library/?pg=1&find=org_acct_periods), [subinventory_code](https://www.enginatics.com/library/?pg=1&find=subinventory_code), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment](/CAC%20Inventory%20Pending%20Cost%20Adjustment/ "CAC Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-cost-type-costs-not-in-period-close-inventory-snapshot/) |
| Blitz Report™ XML Import | [CAC_Cost_Type_Costs_Not_in_Period_Close_Inventory_Snapshot.xml](https://www.enginatics.com/xml/cac-cost-type-costs-not-in-period-close-inventory-snapshot/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-cost-type-costs-not-in-period-close-inventory-snapshot/](https://www.enginatics.com/reports/cac-cost-type-costs-not-in-period-close-inventory-snapshot/) |

## Case Study & Technical Analysis: CAC Cost Type Costs Not in Period Close Inventory Snapshot

### Executive Summary
The **CAC Cost Type Costs Not in Period Close Inventory Snapshot** report is a reconciliation and audit tool designed to identify discrepancies between the official period-end inventory records and a target Cost Type (such as "Frozen" or "Pending"). Specifically, it finds items that held inventory balances at the time of period close but are completely missing a cost definition in the specified Cost Type. This is critical for ensuring that all inventory is properly valued and that there are no "uncosted" items lurking in the system which could lead to zero-value transactions or margin errors.

### Business Challenge
In Oracle EBS, inventory value at period end is captured in a snapshot table (`CST_PERIOD_CLOSE_SUMMARY`). However, organizations often maintain multiple Cost Types (e.g., Frozen for standard costing, Pending for future updates, or simulation types). A common issue arises when:
*   **New Items:** Items are received and transacted but the finance team hasn't yet defined a standard cost in the "Frozen" cost type.
*   **Cost Type Synchronization:** A simulation or "Pending" cost type is being prepared for a standard cost update, but it doesn't contain all the items that currently have on-hand balances.
*   **Zero Value Risk:** If an item has quantity but no cost record, it effectively has a zero value, which distorts financial reporting and profit margins.

### The Solution
This report solves these problems by:
*   **Snapshot Comparison:** It looks at the *actual* period-end snapshot (what was physically/logically on hand when the period closed).
*   **Gap Analysis:** It compares this snapshot against a user-selected Cost Type to find missing cost records.
*   **Asset Focus:** It automatically filters out expense items, focusing only on asset inventory that impacts the balance sheet.
*   **Valuation Impact:** It displays the on-hand quantity and the *snapshot* value (based on the cost at the time of the snapshot), allowing users to assess the materiality of the missing costs.

### Technical Architecture (High Level)
The report employs a "Set Difference" logic using a `NOT EXISTS` clause to identify the gaps.
*   **Primary Source (The "Left" Side):** An aggregated view of `CST_PERIOD_CLOSE_SUMMARY` (joined with `ORG_ACCT_PERIODS` and `MTL_SYSTEM_ITEMS_VL`). This represents the "truth" of what was on hand at period close.
*   **Comparison Target (The "Right" Side):** `CST_ITEM_COSTS` filtered by the user's chosen Cost Type parameter.
*   **The Filter:** The query selects items from the Primary Source where a corresponding record does *not exist* in the Comparison Target.

### Parameters & Filtering
*   **Period Name (Closed):** The inventory accounting period to analyze (must be closed to have a snapshot).
*   **Cost Type:** The cost type to check against (e.g., "Frozen", "Pending", "FY2024 Standard").
*   **Item Number:** Optional filter for specific items.
*   **Organization Code:** Filter by specific inventory organization.

### Performance & Optimization
*   **Pre-Aggregated Data:** By using `CST_PERIOD_CLOSE_SUMMARY`, the report avoids summing up millions of individual transactions (`MTL_MATERIAL_TRANSACTIONS`), making it extremely fast even for large databases.
*   **Efficient Filtering:** The inner query filters out zero-quantity records early, reducing the volume of data processed in the main join.
*   **Indexed Lookups:** The `NOT EXISTS` check against `CST_ITEM_COSTS` leverages standard indexes on `INVENTORY_ITEM_ID` and `COST_TYPE_ID`.

### FAQ
**Q: Why does this report require a closed period?**
A: The table `CST_PERIOD_CLOSE_SUMMARY` is only populated by the "Period Close" process. If the period is open, this table may not contain up-to-date data for that period.

**Q: What does "Rollback Value" mean?**
A: In the context of the period close summary, "Rollback" refers to the quantity and value calculated back to the period end date. However, since this table *is* the snapshot, it represents the static value at that point in time.

**Q: Does this report show items with Zero Cost?**
A: No, it shows items with *No Cost Record*. An item with a cost record of $0.00 is technically "costed" (at zero). This report finds items that are completely missing from the `CST_ITEM_COSTS` table for the selected Cost Type.

**Q: Can I use this for Average Costing?**
A: Yes, but in Average Costing, the "Cost Type" concept is less fluid than in Standard Costing. You would typically compare against the "Average" cost type to ensure integrity, though the system usually enforces cost creation automatically in Average Costing. This is most useful for Standard Costing environments.


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
