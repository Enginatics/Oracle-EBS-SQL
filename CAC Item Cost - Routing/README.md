---
layout: default
title: 'CAC Item Cost & Routing | Oracle EBS SQL Report'
description: 'Report to show detailed item costs for buy and make items for one or any two cost types. If you enter multiple cost types you will get a row-by-row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CAC, Item, Cost, Routing, cst_activities, cst_item_costs, cst_item_cost_details'
permalink: /CAC%20Item%20Cost%20-%20Routing/
---

# CAC Item Cost & Routing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-routing/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Report to show detailed item costs for buy and make items for one or any two cost types.  If you enter multiple cost types you will get a row-by-row comparison in detail.
Note: to find all the items with a specific Basis Type, such as Lot or Ttl value (Total value), use the Basis Type parameter.

Parameters:
===========
Cost Type:  enter the cost type(s) you wish to report (mandatory).
Category Set 1:  the first item category set to report, typically the Cost or Product Line Category Set (optional).
Category Set 2:  the second item category set to report, typically the Inventory Category Set (optional).
Make or Buy:  enter Buy, Make or leave blank to get all items (optional).
Based on Rollup:  enter Yes to get the rolled up items, No to get the non-rolled-up items (optional).
Basis Type:  enter the basis type you wish to report, such as Item, Lot, Res Units, Res Value, or Ttl Value (optional).
Item Status to Exclude:  enter the item number status you want to exclude.  Defaulted to 'Inactive' (optional).
Item Number:  enter the item numbers you wish to report (optional).
Organization Code:  enter the specific inventory organization(s) you wish to report (optional).
Operating Unit:  enter the specific operating unit(s) you wish to report (optional).
Ledger:  enter the specific ledger(s) you wish to report (optional).

/* +=============================================================================+
-- | Copyright 2010 - 2023 Douglas Volz Consulting, Inc.
-- | All rights reserved.
-- | Permission to use this code is granted provided the original author is
-- | acknowledged. No warranties, express or otherwise is included in this permission.
-- +=============================================================================+
-- |
-- | Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- | Program Name: xxx_item_costs_routing_rept.sql
-- |
-- | Description:
-- | Report to show detailed items costs for buy and make items for any two cost types.
-- | 
-- | Version Modified on Modified by Description
-- | ======= =========== ============== =========================================
-- |  1.0     06 Oct 2009 Douglas Volz  Initial Coding
-- |  1.1     16 Mar 2010 Douglas Volz  Updated with Make/Buy flags
-- |  1.2     26 Aug 2010 Douglas Volz  Added two cost types and effectivity date
-- |                                    parameters.
-- |  1.3     12 Oct 2010 Douglas Volz  Added parameters for business objects
-- |  1.4     26 Oct 2010 Douglas Volz  Added parameter for specific Item_Number
-- |  1.5     01 Feb 2017 Douglas Volz  Added Resource Activity and Cost Category
-- |  1.6     22 May 2017 Douglas Volz  Added inventory item category
-- |  1.7     27 Jan 2020 Douglas Volz  Added Operating_Unit and Org_Code parameters
-- |  1.8     26 Apr 2020 Douglas Volz  Changed to multi-language views for the item
-- |                                    master, inventory orgs and operating units.
-- |  1.9     21 Oct 2020 Douglas Volz  Added Category1, Category2, Cost Creation
-- |                                    Date, Last Cost Update Date, screen out
-- |                                    the item master orgs.
-- |  1.10    17 Mar 2021 Douglas Volz  Add parameter for Inactive Items.
-- |  1.11    26 Oct 2023 Douglas Volz  Added item master std lot size and defaulted
-- |                                    columns, removed tabs, added Basis Type, Based on Rollup
-- |                                    and Make/Buy parameters and org access controls.
-- |                                    Removed Cost Type2, not needed with Multiple Value
-- |                                    functionality.
-- |  1.12    07 Dec 2023 Douglas Volz  Added G/L and Operating Unit security restrictions.
-- +=============================================================================+*/


## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Make or Buy, Based on Rollup, Basis Type, Item Status to Exclude, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups), [fnd_common_lookups](https://www.enginatics.com/library/?pg=1&find=fnd_common_lookups), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [gl_access_set_norm_assign](https://www.enginatics.com/library/?pg=1&find=gl_access_set_norm_assign), [gl_ledger_set_norm_assign_v](https://www.enginatics.com/library/?pg=1&find=gl_ledger_set_norm_assign_v), [mo_glob_org_access_tmp](https://www.enginatics.com/library/?pg=1&find=mo_glob_org_access_tmp), [dual](https://www.enginatics.com/library/?pg=1&find=dual), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings), [bom_operation_sequences](https://www.enginatics.com/library/?pg=1&find=bom_operation_sequences), [bom_operation_resources](https://www.enginatics.com/library/?pg=1&find=bom_operation_resources)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost & Routing 23-Jun-2022 163544.xlsx](https://www.enginatics.com/example/cac-item-cost-routing/) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Routing.xml](https://www.enginatics.com/xml/cac-item-cost-routing/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cac-item-cost-routing/](https://www.enginatics.com/reports/cac-item-cost-routing/) |

## Case Study & Technical Analysis: CAC Item Cost & Routing

### Executive Summary
The **CAC Item Cost & Routing** report is a deep-dive costing tool that provides a granular view of item costs, specifically focusing on the "Make" items where routing and resource costs play a significant role. It allows for a side-by-side comparison of two different Cost Types (e.g., Frozen vs. Pending), making it an essential tool for analyzing the impact of routing changes or resource rate updates.

### Business Challenge
Understanding the cost of a manufactured item requires more than just a total number.
*   **Cost Drivers**: Engineers and Accountants need to know *why* a cost increased. Was it a material price hike? Or did the labor hours in the routing increase?
*   **Routing Validation**: Verifying that the correct resources and usage rates are being rolled up into the standard cost is difficult without a detailed report.
*   **Basis Analysis**: Identifying which costs are driven by Lot size vs. Item quantity is crucial for setting optimal batch sizes.

### Solution
This report exposes the DNA of the item cost.
*   **Detailed Breakdown**: Shows the cost components (Material, Material Overhead, Resource, Outside Processing, Overhead).
*   **Comparison**: The dual-Cost Type parameter allows users to see exactly which component changed between the current standard and a proposed simulation.
*   **Basis Visibility**: Explicitly reports the "Basis Type" (Item, Lot, Total Value), helping users understand the behavior of the cost element.

### Technical Architecture
The report queries the core costing tables:
*   **Cost Details**: `cst_item_cost_details` provides the row-by-row breakdown of the cost.
*   **Item Master**: `mtl_system_items` provides the Make/Buy flag and status.
*   **Logic**: It pivots or joins the cost details for the two selected cost types to present them in a comparative format.

### Parameters
*   **Cost Type**: (Mandatory) The primary cost type to report.
*   **Cost Type 2**: (Optional) A second cost type for comparison.
*   **Make or Buy**: (Optional) Filter to focus on Manufactured items.
*   **Basis Type**: (Optional) Filter for specific cost drivers (e.g., 'Lot').

### Performance
*   **Detail Level**: This report can generate a large volume of data if run for all items, as it outputs multiple rows per item (one for each cost element/level).
*   **Optimization**: Filtering by "Make" items or specific Categories is recommended for performance.

### FAQ
**Q: Does this show the Routing operations?**
A: It shows the *cost* associated with resources, which are derived from the routing. It doesn't show the operation sequence numbers directly, but the resource usage reflects the routing.

**Q: Why is the "Lot" basis cost so high?**
A: Lot-based costs are calculated as `(Resource Rate * Usage) / Costing Lot Size`. If the lot size is small, the unit cost will be high.

**Q: Can I use this for Buy items?**
A: Yes, for Buy items it typically shows the Material cost and any Material Overhead.


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
