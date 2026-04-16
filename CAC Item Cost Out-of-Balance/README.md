---
layout: default
title: 'CAC Item Cost Out-of-Balance | Oracle EBS SQL Report'
description: 'Report to compare summary and detail item cost information and show any out-of-balances. Any difference may cause an inventory reconciliation issue…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, Cost, Out-of-Balance, cst_item_costs, cst_item_cost_details, cst_cost_types'
permalink: /CAC%20Item%20Cost%20Out-of-Balance/
---

# CAC Item Cost Out-of-Balance – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-out-of-balance/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to compare summary and detail item cost information and show any out-of-balances.  Any difference may cause an inventory reconciliation issue between the G/L and the inventory perpetual balances.

/* +=============================================================================+
-- | Copyright 2009-2020 Douglas Volz Consulting, Inc.                           |
-- | All rights reserved.                                                        |
-- | Permission to use this code is granted provided the original author is      |
-- | acknowledged. No warranties, express or otherwise is included in this       |
-- | permission.                                                                 |
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_cost_diff_rept.sql
-- |
-- | Parameters:  None
-- |
-- | Description:
-- | Report to compare summary and detail item cost information and show any out-of-balances.
-- | Any difference may cause an inventory reconciliation issue between the G/L
-- | and the inventory perpetual balances.
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     08 Nov 2010 Douglas Volz  Updated with additional columns and parameters
-- |  1.3     10 Dec 2012 Douglas Volz  Compare summary and detail item cost information.
-- |  1.4     29 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, operating unit and lookup values.  Add
-- |                                    Ledger and Operating Unit columns and parameters.
-- +=============================================================================+*/

## Report Parameters
Item Number, Category Set 1, Category Set 2, Category Set 3, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC Inventory Lot and Locator OPM Value (Period-End)](/CAC%20Inventory%20Lot%20and%20Locator%20OPM%20Value%20%28Period-End%29/ "CAC Inventory Lot and Locator OPM Value (Period-End) Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Out-of-Balance 23-Jun-2022 212720.xlsx](https://www.enginatics.com/example/cac-item-cost-out-of-balance/) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Out_of_Balance.xml](https://www.enginatics.com/xml/cac-item-cost-out-of-balance/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-cost-out-of-balance/](https://www.enginatics.com/reports/cac-item-cost-out-of-balance/) |

## Case Study & Technical Analysis: CAC Item Cost Out-of-Balance

### Executive Summary
The **CAC Item Cost Out-of-Balance** report is a technical integrity check for the Costing module. It verifies that the summary unit cost stored in the header table (`cst_item_costs`) matches the sum of the detailed cost elements stored in the detail table (`cst_item_cost_details`). Any discrepancy here indicates data corruption that can lead to serious accounting errors.

### Business Challenge
Oracle Costing stores costs in two places: a Header (Total) and Details (Breakdown).
*   **Data Corruption**: Bugs, manual SQL updates, or failed processes can cause these two to get out of sync.
*   **Accounting Impact**: Inventory valuation reports often use the Header, while accounting distributions often use the Details. If they differ, the GL will not match the Subledger.
*   **Hidden Errors**: These errors are invisible on standard screens, which usually display the Detail sum.

### Solution
This report hunts for these "impossible" errors.
*   **Math Check**: Calculates `Header Cost - Sum(Detail Costs)`.
*   **Variance Reporting**: Lists any item where the difference is not zero.
*   **Scope**: Checks all items in the selected organization and cost type.

### Technical Architecture
The report is a direct database integrity query:
*   **Tables**: `cst_item_costs` (Header) and `cst_item_cost_details` (Detail).
*   **Aggregation**: Groups the details by `inventory_item_id` and sums the `item_cost`.
*   **Comparison**: Compares the summed detail to the stored header `item_cost`.

### Parameters
*   **Organization Code**: (Optional) The org to check.
*   **Item Number**: (Optional) Specific item.

### Performance
*   **Fast**: It performs a simple aggregation and comparison.
*   **Zero Rows**: In a healthy system, this report should return **zero rows**.

### FAQ
**Q: How does this happen?**
A: It is rare. It usually happens after a custom data migration, a patch application that failed mid-stream, or a manual update to the database tables by a DBA.

**Q: How do I fix it?**
A: You usually need to run a "Cost Update" or "Cost Rollup" for the affected items to force the system to recalculate and resave the data correctly. In severe cases, an Oracle Data Fix is required.

**Q: Is a small difference okay?**
A: No. Even a $0.00001 difference is a sign of corruption. The system is designed to be exact.


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
