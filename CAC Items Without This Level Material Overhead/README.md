---
layout: default
title: 'CAC Items Without This Level Material Overhead | Oracle EBS SQL Report'
description: 'Report to show item costs which do not have this level material overhead, for any cost type. For one or more inventory organizations. Parameters…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Items, Without, This, cst_item_costs, cst_cost_types, mtl_system_items_vl'
permalink: /CAC%20Items%20Without%20This%20Level%20Material%20Overhead/
---

# CAC Items Without This Level Material Overhead – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-items-without-this-level-material-overhead/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show item costs which do not have this level material overhead, for any cost type.  For one or more inventory organizations.

Parameters:
===========
Cost Type:  enter the cost type(s) you wish to report (mandatory).
Make or Buy:  enter Buy, Make or leave blank to get all items (optional).
Based on Rollup:  enter Yes to get the rolled up items, No to get the non-rolled-up items (optional).
Basis Type:  enter the basis type you wish to report, such as Item, Lot, Res Units, Res Value, or Ttl Value (optional).
Item Status to Exclude:  enter the item status you wish to exclude, defaulted to Inactive (optional).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Category Set 3:  the third item category set to report (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2024 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0    15 Nov 2024 Douglas Volz  Initial Coding based on the Item Cost Summary Report.
-- |  1.1    08 Dec 2024 Douglas Volz  Added Ledger and Operating Unit security profiles.
-- +=============================================================================+*/

## Report Parameters
Cost Type, Make or Buy, Based on Rollup, Item Status to Exclude, Category Set 1, Category Set 2, Category Set 3, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [gl_code_combinations](https://www.enginatics.com/library/?pg=1&find=gl_code_combinations), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Material Account Summary](/CAC%20Material%20Account%20Summary/ "CAC Material Account Summary Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Missing Material Accounting Transactions](/CAC%20Missing%20Material%20Accounting%20Transactions/ "CAC Missing Material Accounting Transactions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report"), [CAC Item Cost Summary](/CAC%20Item%20Cost%20Summary/ "CAC Item Cost Summary Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [None](https://www.enginatics.com/example/cac-items-without-this-level-material-overhead/) |
| Blitz Report™ XML Import | [CAC_Items_Without_This_Level_Material_Overhead.xml](https://www.enginatics.com/xml/cac-items-without-this-level-material-overhead/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-items-without-this-level-material-overhead/](https://www.enginatics.com/reports/cac-items-without-this-level-material-overhead/) |

## Case Study & Technical Analysis: CAC Items Without This Level Material Overhead

### Executive Summary
The **CAC Items Without This Level Material Overhead** report is a revenue leakage prevention tool. It identifies items that are missing "Material Overhead" (MOH). For many manufacturing and distribution companies, MOH is the mechanism used to recover freight, handling, and procurement costs. If an item lacks this cost element, the company is effectively subsidizing these expenses.

### Business Challenge
*   **Under-Costing**: If you pay 5% for freight but don't add it to the item cost, your margin analysis is inflated.
*   **Inconsistency**: Some items might have the overhead applied automatically, while others (perhaps manually created) were missed.
*   **Compliance**: Government contracting or transfer pricing rules often require a consistent application of overheads.

### Solution
This report acts as a "completeness check".
*   **Filter**: It looks for items where the `Material Overhead` cost element at `This Level` is zero or null.
*   **Scope**: Can be run for Buy items (where MOH is most common) or Make items.
*   **Basis Analysis**: Helps verify if the missing overhead is due to a missing "Basis" (e.g., Item vs. Lot).

### Technical Architecture
The report queries the detailed cost table:
*   **Table**: `cst_item_cost_details`.
*   **Condition**: Checks for the absence of `cost_element_id = 2` (Material Overhead) or where the value is 0.
*   **Join**: Links to `mtl_system_items` to filter by Make/Buy code.

### Parameters
*   **Cost Type**: (Mandatory) The cost type to check.
*   **Make or Buy**: (Optional) Usually set to 'Buy' to focus on purchased parts.
*   **Organization Code**: (Optional) The inventory org.

### Performance
*   **Efficient**: It uses standard indexing on the cost tables.
*   **Output**: Returns a list of items requiring attention.

### FAQ
**Q: Is Material Overhead mandatory?**
A: No, it depends on your company's costing policy. Some companies expense freight and handling directly to the P&L rather than capitalizing it into inventory.

**Q: Can I use this for OPM?**
A: This report is designed for Discrete Costing. OPM handles overheads through a different mechanism (Cost Factors).

**Q: What if I use Total Value basis?**
A: The report checks for the *existence* of the cost element. If you use Total Value basis, the element should still exist, even if the calculated amount varies.


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
