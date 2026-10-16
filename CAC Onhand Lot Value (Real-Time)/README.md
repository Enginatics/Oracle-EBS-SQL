---
layout: default
last_modified_at: 2026-10-16
title: 'CAC Onhand Lot Value (Real-Time) | Oracle EBS SQL Report'
description: 'Report for onhand inventory at the time you run the report (real-time). By organization, Lot and Subinventory. If you leave the Cost Type blank the report…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Onhand, Lot, Value, cst_cost_groups, pa_projects_all, mtl_item_locations'
permalink: /CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/
report_name: 'CAC Onhand Lot Value (Real-Time)'
report_web_name: cac-onhand-lot-value-real-time
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Onhand Lot Value (Real-Time) – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-onhand-lot-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report for onhand inventory at the time you run the report (real-time).  By organization, Lot and Subinventory.  If you leave the Cost Type blank the report will value the inventory using the inventory organization's Costing Method (Standard, Average, FIFO, LIFO).  If you enter a Cost Type the report will use these item costs, plus, if any item costs are missing from the entered Cost Type, get the remaining item costs from the Costing Method Cost Type.  Note that consigned quantities are reported but not valued.  And if you choose to report expense subinventories, they are not valued either.


/* +=============================================================================+
-- | Copyright 2009 - 2020 Douglas Volz Consulting, Inc.                         |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged.  No warranties, express or otherwise is included in this     |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_inventory_val_rept.sql
-- |
-- |  Parameters:
-- |  p_period_name         -- Accounting period you wish to report for
-- |  p_org_code            -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit      -- Operating Unit you wish to report, leave blank for all
-- |                           operating units (optional) 
-- |  p_ledger              -- general ledger you wish to report, leave blank for all
-- |                           ledgers (optional)
-- |  p_cost_type           -- Enter a Cost Type to value the quantities
-- |                           using the Cost Type Item Costs; or, if 
-- |                           Cost Type is blank or null the report will 
-- |                           use the stored month-end snapshot values
-- |  p_category_set1       -- The first item category set to report, typically the
-- |                           Cost or Product Line Category Set
-- |  p_category_set2       -- The second item category set to report, typically the
-- |                           Inventory Category Set 
-- |
-- | ===================================================================
-- | Note:  if you enter a cost type this script uses the item costs 
-- |        from the cost type; if you leave the cost type 
-- |        blank it uses the item costs from the month-end snapshot.
-- | ===================================================================
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- | 1.0     27 Sep 2009 Douglas Volz Initial Coding
-- | 1.1     28 Sep 2009 Douglas Volz Added a sum for the ICP costs from cicd
-- | 1.16    23 Apr 2020 Douglas Volz Changed to multi-language views for the item
-- |                                  master, item categories and operating units.
-- |                                  Used mfg_lookups for "Intransit".
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Include Expense Subinventories, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_cost_groups](https://www.enginatics.com/library/?pg=1&find=cst_cost_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_item_locations](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mtl_lot_numbers](https://www.enginatics.com/library/?pg=1&find=mtl_lot_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Receiving Value (Period-End)](/CAC%20Receiving%20Value%20%28Period-End%29/ "CAC Receiving Value (Period-End) Oracle EBS SQL Report"), [CAC PO Price vs. Costing Method Comparison](/CAC%20PO%20Price%20vs-%20Costing%20Method%20Comparison/ "CAC PO Price vs. Costing Method Comparison Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC Inventory Out-of-Balance](/CAC%20Inventory%20Out-of-Balance/ "CAC Inventory Out-of-Balance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Onhand Lot Value (Real-Time) 07-Jul-2022 152614.xlsx](https://www.enginatics.com/example/cac-onhand-lot-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) |
| Blitz Report™ XML Import | [CAC_Onhand_Lot_Value_Real_Time.xml](https://www.enginatics.com/xml/cac-onhand-lot-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) |
| SQL Source | [CAC Onhand Lot Value (Real-Time).sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-onhand-lot-value-real-time/](https://www.enginatics.com/reports/cac-onhand-lot-value-real-time/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time) |

## Case Study & Technical Analysis: CAC Onhand Lot Value (Real-Time)

### Executive Summary
The **CAC Onhand Lot Value (Real-Time)** report provides a valuation of current inventory at the *Lot Number* level. While standard reports typically value inventory at the Item level (Average or Standard cost), this report is essential for industries where value or cost is tracked by specific batches (Lots).

### Business Challenge
*   **Lot-Specific Costing**: In some industries (Pharma, Food), specific lots might have different costs (FIFO/LIFO layers).
*   **Expiry Analysis**: High-value lots that are about to expire need to be identified and sold.
*   **Audit**: Auditors often select specific lots on the floor and ask for their specific book value.

### Solution
This report combines stock levels with cost.
*   **Granularity**: Item + Subinventory + Locator + Lot Number.
*   **Valuation**: Multiplies the On-hand Quantity of the lot by the Item Cost.
*   **Real-Time**: Queries the live `mtl_onhand_quantities_detail` table, not a snapshot.

### Technical Architecture
*   **Tables**: `mtl_onhand_quantities_detail` (MOQD), `cst_item_costs` (or `cst_quantity_layers` for FIFO/LIFO).
*   **Logic**: Sums quantity by Lot and joins to the cost table.
*   **Note**: If using Standard Costing, all lots of an item have the same unit cost. The value is simply Qty * Standard.

### Parameters
*   **Cost Type**: (Optional) Defaults to the Org's costing method.
*   **Include Expense Subinventories**: (Optional) Toggle to include non-asset locations.

### Performance
*   **Heavy**: MOQD can have millions of rows. Aggregating real-time on-hand balances can be slow during peak hours.

### FAQ
**Q: Does this show "Reserved" quantity?**
A: The report typically shows "Total Onhand". It may or may not split out "Available to Reserve" depending on the specific SQL logic (standard MOQD queries show total physical stock).

**Q: Can I see the Expiration Date?**
A: Yes, Lot attributes like Expiration Date are usually included from `mtl_lot_numbers`.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-onhand-lot-value-real-time)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
