---
layout: default
title: 'CAC Inactive Items Set to Roll Up | Oracle EBS SQL Report'
description: 'Report to show items which are set to roll up even though these items have an inactive status. The Cost Rollup uses the Based on Rollup Flag to control if…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Inactive, Items, Set, cst_item_costs, cst_cost_types, mtl_parameters'
permalink: /CAC%20Inactive%20Items%20Set%20to%20Roll%20Up/
---

# CAC Inactive Items Set to Roll Up – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-inactive-items-set-to-roll-up/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show items which are set to roll up even though these items have an inactive status.  The Cost Rollup uses the Based on Rollup Flag to control if an item is rolled up, as opposed to the item status.

Parameters:
===========
Cost Type:  enter the cost type to report (mandatory).  Defaults to your Costing Method cost type.
Inactive Item Status:  enter the item statuses which should not be rolled up (mandatory).  Defaults to 'Inactive'.
Category Set 1:  any item category you wish, typically the Cost or Product Line category set (optional).
Category Set 2:  any item category you wish, typically the Inventory category set (optional).
Item Number:  enter the specific item number(s) you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_inactive_items_set_to_rollup_rept.sql
-- |
-- |  Version Modified on  Modified  by   Description
-- |  ======= =========== ============== =========================================
-- |      1.0 15 Nov 2023 Douglas Volz   Initial version
-- |      1.1 05 Dec 2023 Douglas Volz   Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Inactive Item Status, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-inactive-items-set-to-roll-up/) |
| Blitz Report™ XML Import | [CAC_Inactive_Items_Set_to_Roll_Up.xml](https://www.enginatics.com/xml/cac-inactive-items-set-to-roll-up/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-inactive-items-set-to-roll-up/](https://www.enginatics.com/reports/cac-inactive-items-set-to-roll-up/) |

## Case Study & Technical Analysis: CAC Inactive Items Set to Roll Up

### Executive Summary
The **CAC Inactive Items Set to Roll Up** report is a specialized inventory and costing diagnostic tool designed to ensure the accuracy of standard cost rollups. It identifies a specific data quality issue where items marked as "Inactive" are still flagged to be included in cost rollups. By detecting these inconsistencies, the report helps organizations prevent invalid or obsolete items from distorting product costs and inventory valuations.

### Business Challenge
In Oracle EBS Cost Management, the "Based on Rollup" flag determines if an item's cost is calculated during a standard cost rollup. A common configuration error occurs when an item is retired (set to Inactive status) but the "Based on Rollup" flag remains set to "Yes".
*   **Distorted Costs**: Inactive items might retain old, incorrect costs that get rolled up into parent assemblies, leading to inaccurate finished good costs.
*   **Processing Overhead**: The cost rollup process wastes resources calculating costs for items that are no longer in use.
*   **Data Inconsistency**: Contradictory settings (Inactive vs. Rollup=Yes) confuse users and complicate data maintenance.

### Solution
This report provides a targeted exception list to proactively manage item master data quality.
*   **Exception Reporting**: Filters specifically for items where `Inventory_Item_Status_Code` indicates inactivity (default 'Inactive') but `Based_on_Rollup` is enabled.
*   **Multi-Org Visibility**: Can be run across multiple inventory organizations, operating units, and ledgers to identify widespread issues.
*   **Actionable Output**: Provides the Item Number, Organization, and Category details needed to quickly locate and correct the master data.

### Technical Architecture
The report is built on a robust SQL query that joins key Inventory and Costing tables:
*   **Primary Tables**: `mtl_system_items_vl` (Item Master), `cst_item_costs` (Cost Details), and `mtl_item_status_vl` (Status Definitions).
*   **Security**: Implements standard Oracle EBS security (Operating Unit and Inventory Org access) via `org_access_view` and `mo_glob_org_access_tmp`.
*   **Logic**: The core logic compares the item's status against the user-provided "Inactive Item Status" parameter and checks the rollup flag.

### Parameters
*   **Cost Type**: (Mandatory) The cost type to analyze (e.g., Frozen, Pending).
*   **Inactive Item Status**: (Mandatory) The status code representing inactive items (default: 'Inactive').
*   **Category Set 1 & 2**: (Optional) Filter by specific item categories (e.g., Cost Category, Product Line).
*   **Item Number**: (Optional) Analyze a specific item.
*   **Organization Code**: (Optional) Limit to a specific inventory organization.
*   **Operating Unit**: (Optional) Filter by Operating Unit.
*   **Ledger**: (Optional) Filter by General Ledger.

### Performance
The report is optimized for large item masters:
*   **Selective Filtering**: By filtering on Cost Type and Item Status early in the execution plan, it minimizes the data set processed.
*   **Efficient Joins**: Uses standard keys (Inventory_Item_Id, Organization_Id) for high-performance joins between Item and Cost tables.

### FAQ
**Q: Why does an inactive item affect my rollup?**
A: If an inactive item is a component in an active Bill of Material (BOM) and "Based on Rollup" is Yes, the rollup process will attempt to cost it, potentially using outdated purchase prices or routing data.

**Q: How do I fix the items identified?**
A: You should update the Item Master for these items, unchecking the "Based on Rollup" flag in the Costing tab.

**Q: Can I use this for statuses other than 'Inactive'?**
A: Yes, the "Inactive Item Status" parameter allows you to check for any status code (e.g., 'Obsolete', 'Phase-Out').


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
