---
layout: default
last_modified_at: 2026-10-26
title: 'CAC Item Cost Break-Out by Activity | Oracle EBS SQL Report'
description: 'Report to show item costs by cost element, by activity. Using up to five entered activities. In order for this report to show your activity costs you must…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Cost Accounting, Enginatics, CAC, Item, Cost, Break-Out, mtl_parameters, hr_organization_information, hr_all_organization_units'
permalink: /CAC%20Item%20Cost%20Break-Out%20by%20Activity/
report_name: 'CAC Item Cost Break-Out by Activity'
report_web_name: cac-item-cost-break-out-by-activity
module: 'Cost Accounting'
module_url: /modules/cost-accounting/
---

# CAC Item Cost Break-Out by Activity – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cac-item-cost-break-out-by-activity/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity).
**Oracle EBS module:** [Cost Accounting](/modules/cost-accounting/ "Oracle EBS Cost Accounting reports") · [all Cost Accounting reports](/modules/cost-accounting/)  

## Overview
Report to show item costs by cost element, by activity.  Using up to five entered activities.  In order for this report to show your activity costs you must first define your activities and then associate your sub-elements by activity.

/* +=============================================================================+
-- |  Copyright 2009-2022 Douglas Volz Consulting, Inc.                          |
-- |  All rights reserved.                                                       |
-- |  Permission to use this code is granted provided the original author is     |
-- |  acknowledged. No warranties, express or otherwise is included in this      |
-- |  permission.                                                                |
-- +=============================================================================+
-- |
-- |  Original Author: Douglas Volz (doug@volzconsulting.com)
-- |
-- |  Program Name: xxx_item_cost_break_out_by_activity_rept.sql
-- |
-- |  Parameters:
- |  p_cost_type            -- The cost type you wish to report
-- |  p_org_code             -- Specific inventory organization you wish to report (optional)
-- |  p_operating_unit       -- Operating Unit you wish to report, leave blank for all
-- |                            operating units (optional) 
-- |  p_ledger               -- general ledger you wish to report, leave blank for all
-- |                            ledgers (optional)
-- |  p_item_number          -- Enter the specific item number you wish to report
-- |  p_activity1            -- First activity to report
-- |  p_activity2            -- Second activity to report
-- |  p_activity3            -- Third activity to report
-- |  p_activity4            -- Fourth activity to report
-- |  p_activity5            -- Fifth activity to report
-- |  p_category_set1        -- The first item category set to report, typically the
-- |                            Cost or Product Line Category Set
-- |  p_category_set2        -- The second item category set to report, typically the
-- |                            Inventory Category Set 
-- |
-- |  Description:
-- |  Report to show Frozen costs in the Frozen cost type, by activity.  Using
-- |  up to six parameters activities.
-- |  
-- |  Version Modified on Modified by Description
-- |  ======  =========== ============== =========================================
-- |  1.0     08 Nov 2016 Douglas Volz  Initial Coding based on XXX_ITEM_COST_REPT.sql\
-- |                                    Hard-coded for activities starting with S (Sort),
-- |                                    A (Assembly), T (Test), BE (Back-End) or UNASSIGNED.
-- |  1.1     09 Nov 2016 Douglas Volz  Added PL item costs with no sub-element (resource_id)
-- |  1.2     10 Nov 2016 Douglas Volz  Added Business Code, Product Family and 
-- |                                    Product Type item categories
-- |  1.3     18 Nov 2016 Douglas Volz  Modified to use the Resource Activity assignments
-- |  1.4     21 Jan 2017 Douglas Volz  Changed the report to assume that all
-- |                                    resources have been assigned to an activity
-- |  1.5     07 Sep 2019 Douglas Volz  Reported activities are now parameters.
-- |                                    Up to five activity parameters.
-- |  1.6     09 Sep 2019 Douglas Volz  Added a max(mc.segment1) for the category
-- |                                    column select statements due to having
-- |                                    multiple category values for the same org,
-- |                                    item and category set id (Inventory). 
-- |  1.7     27 Jan 2020 Douglas Volz  Added Operating Unit and Org Code parameters.
-- |  1.8     02 Jul 2022 Douglas Volz  Change for multi-language and lookup types.
-- |  1.9     23 Oct 2026 Andy Haack    Rebuilt to the Blitz Report SQL standards.
-- +=============================================================================+*/

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Cost Type, Category Set 1, Category Set 2, Category Set 3, Activity1, Activity2, Activity3, Activity4, Activity5, Organization Code, Item Number, Operating Unit, Ledger

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [hr_organization_information](https://www.enginatics.com/library/?pg=1&find=hr_organization_information&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [hr_all_organization_units](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity), [xxen_report_org_access](https://www.enginatics.com/library/?pg=1&find=xxen_report_org_access&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)

## Related Reports
[CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC ICP PII WIP Pending Cost Adjustment](/CAC%20ICP%20PII%20WIP%20Pending%20Cost%20Adjustment/ "CAC ICP PII WIP Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [CAC ICP PII WIP Material Usage Variance](/CAC%20ICP%20PII%20WIP%20Material%20Usage%20Variance/ "CAC ICP PII WIP Material Usage Variance Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC User-Defined and Rolled Up Costs](/CAC%20User-Defined%20and%20Rolled%20Up%20Costs/ "CAC User-Defined and Rolled Up Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Break-Out%20by%20Activity/CAC%20Item%20Cost%20Break-Out%20by%20Activity.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CAC Item Cost Break-Out by Activity 23-Jun-2022 201517.xlsx](https://www.enginatics.com/example/cac-item-cost-break-out-by-activity/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) |
| Blitz Report™ XML Import | [CAC_Item_Cost_Break_Out_by_Activity.xml](https://www.enginatics.com/xml/cac-item-cost-break-out-by-activity/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) |
| SQL Source | [CAC Item Cost Break-Out by Activity.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/CAC%20Item%20Cost%20Break-Out%20by%20Activity/CAC%20Item%20Cost%20Break-Out%20by%20Activity.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/cac-item-cost-break-out-by-activity/](https://www.enginatics.com/reports/cac-item-cost-break-out-by-activity/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity) |

## Case Study & Technical Analysis: CAC Item Cost Break-Out by Activity

### Executive Summary
The **CAC Item Cost Break-Out by Activity** report is an Activity-Based Costing (ABC) analysis tool. It moves beyond the traditional "Material/Labor/Overhead" view and breaks down costs by the specific business activities defined in the system (e.g., "Setup", "Quality Control", "Machining", "Plating"). This perspective is vital for organizations trying to understand the true process costs of their products.

### Business Challenge
Traditional cost elements often hide the true drivers of expense.
*   **Hidden Costs**: A "Labor" cost of $10 could be $1 of actual assembly and $9 of machine setup. Without activity visibility, management might try to cut assembly time instead of optimizing setup.
*   **Process Improvement**: Lean manufacturing initiatives require data on which activities consume the most resources.
*   **Pricing Strategy**: Accurate pricing depends on knowing the cost of the specific activities required to produce a custom order.

### Solution
This report leverages the "Activity" field in Oracle Costing.
*   **Activity Columns**: Allows the user to specify up to 5 specific activities (e.g., 'SETUP', 'TEST') to break out into dedicated columns.
*   **Granularity**: Shows the cost contribution of each activity to the total unit cost.
*   **Flexibility**: Can be run for any Cost Type (Standard, Frozen, etc.).

### Technical Architecture
The report relies on the `activity_id` stored in `cst_item_cost_details`:
*   **Mapping**: Joins to `cst_activities` to resolve the activity names.
*   **Pivot Logic**: Uses SQL logic to sum the costs for the user-specified activities into distinct columns for easy analysis.
*   **Prerequisite**: Requires that the organization has actually defined Activities and assigned them to Resources or Overheads in the setup.

### Parameters
*   **Activity 1-5**: (Optional) The specific activity codes you want to isolate.
*   **Cost Type**: (Mandatory) The cost type to analyze.
*   **Item Number**: (Optional) Specific item focus.

### Performance
*   **Aggregation**: The report aggregates detailed cost rows by activity, which is generally efficient.
*   **Configuration**: If no activities are entered, it simply reports the total cost, behaving like a standard cost report.

### FAQ
**Q: What if I don't use Activities?**
A: Then this report will likely show zeros in the activity columns. It is only useful if you have implemented Activity-Based Costing features in Oracle.

**Q: Can I see more than 5 activities?**
A: The standard template supports 5. To see more, you would need to modify the SQL or run the report multiple times with different parameters.

**Q: Does this work for OPM?**
A: This specific report is designed for Discrete Costing (Standard/Average). OPM has its own Activity Costing structure.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=cac-item-cost-break-out-by-activity)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
