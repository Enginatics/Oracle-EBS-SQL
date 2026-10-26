---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Item Cost & Routing | Oracle EBS SQL Report'
description: 'Report to show detailed item costs for buy and make items for one or any two cost types. If you enter multiple cost types you will get a row-by-row…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Item, Cost, Routing, cst_activities, mtl_parameters, hr_organization_information'
permalink: /CAC%20Item%20Cost%20-%20Routing/
report_name: 'CAC Item Cost & Routing'
report_web_name: cac-item-cost-routing
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Item Cost & Routing – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-routing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

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
-- |  1.13    23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Make or Buy, Based on Rollup, Basis Type, Item Status to Exclude, Item Number, Organization Code, Operating Unit, Ledger

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [bom_operational_routings](https://www.enginatics.com/library/?pg=1&find=bom_operational_routings&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [bom_operation_sequences](https://www.enginatics.com/library/?pg=1&find=bom_operation_sequences&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [bom_operation_resources](https://www.enginatics.com/library/?pg=1&find=bom_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [cst_cost_elements](https://www.enginatics.com/library/?pg=1&find=cst_cost_elements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)

## Related Reports
[CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Resource Costs](/CAC%20Resource%20Costs/ "CAC Resource Costs Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Standard Cost Update Submissions](/CAC%20Standard%20Cost%20Update%20Submissions/ "CAC Standard Cost Update Submissions Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20-%20Routing/CAC%20Item%20Cost%20-%20Routing.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost & Routing 23-Jun-2022 163544.xlsx](https://www.enginatics.com/example/cac-item-cost-routing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Routing.xml](https://www.enginatics.com/xml/cac-item-cost-routing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) |
| SQL Source | [CAC Item Cost - Routing.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20-%20Routing/CAC%20Item%20Cost%20-%20Routing.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-item-cost-routing/](https://www.enginatics.com/reports/cac-item-cost-routing/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-routing)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
