---
layout: default
last_modified_at: 2026-10-16
title: 'MRP Horizontal Plan | Oracle EBS SQL Report'
description: 'MRP: Horizontal Plan from the Planners Workbench. - The report can be run for multiple organizations and items within a selected plan - The report can be…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, Horizontal, Plan, mrp_material_plans, mrp_workbench_bucket_dates, mrp_system_items'
permalink: /MRP%20Horizontal%20Plan/
report_name: 'MRP Horizontal Plan'
report_web_name: mrp-horizontal-plan
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP Horizontal Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
MRP: Horizontal Plan from the Planners Workbench.
- The report can be run for multiple organizations and items within a selected plan
- The report can be used to explode BOMS and display the HP for all components 
  within the BOM
- Select a template to choose to either display the HP by individual components, or by 
  End Assemblies, Components.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Plan, Current or Snapshot Data, Buckets, Organization Code, Category Set, Category, Item Type, Exclude Item Type, Item, Item From, Item To, Item Contains, Explode BOMs, Exclude Items with No Activity, Make or Buy, Planner, Buyer, Supply/Demand Source

## Oracle EBS Tables Used
[mrp_material_plans](https://www.enginatics.com/library/?pg=1&find=mrp_material_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mrp_workbench_bucket_dates](https://www.enginatics.com/library/?pg=1&find=mrp_workbench_bucket_dates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mrp_system_items](https://www.enginatics.com/library/?pg=1&find=mrp_system_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [bom_small_expl_temp](https://www.enginatics.com/library/?pg=1&find=bom_small_expl_temp&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan), [mrp_end_assemblies](https://www.enginatics.com/library/?pg=1&find=mrp_end_assemblies&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [MRP Plan Orders](/MRP%20Plan%20Orders/ "MRP Plan Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Horizontal%20Plan/MRP%20Horizontal%20Plan.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Horizontal Plan 26-Jul-2021 041459.xlsx](https://www.enginatics.com/example/mrp-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) |
| Blitz Report™ XML Import | [MRP_Horizontal_Plan.xml](https://www.enginatics.com/xml/mrp-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) |
| SQL Source | [MRP Horizontal Plan.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Horizontal%20Plan/MRP%20Horizontal%20Plan.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-horizontal-plan/](https://www.enginatics.com/reports/mrp-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan) |

## MRP Horizontal Plan - Case Study & Technical Analysis

### Executive Summary
The **MRP Horizontal Plan** is the classic "spreadsheet" view of the material plan. It displays supply, demand, and projected available balance (PAB) in time buckets (days, weeks, periods) across the horizon. It is the fundamental tool for planners to visualize the supply/demand balance for an item over time.

### Business Challenge
Planners need to see the "story" of an item's inventory. A simple list of orders isn't enough; they need to see how the inventory level fluctuates.
-   **Trend Analysis:** "Are we consistently running low on stock at the end of the month?"
-   **Capacity Planning:** "Do we have a huge spike in demand in Week 40 that we need to prepare for?"
-   **Safety Stock Visibility:** "When does our projected balance dip below the safety stock level?"

### Solution
The **MRP Horizontal Plan** provides a time-phased view of all planning elements.

**Key Features:**
-   **Time Buckets:** Aggregates data into daily, weekly, or monthly columns.
-   **Row Types:** Displays separate rows for Gross Requirements, Scheduled Receipts, Planned Orders, and Projected Available Balance.
-   **BOM Explosion:** Can optionally explode the bill of materials to show requirements for components.

### Technical Architecture
The report mimics the "Horizontal Plan" form in the Planner's Workbench.

#### Key Tables and Views
-   **`MRP_MATERIAL_PLANS`**: The core table storing the time-phased data (bucketed quantities) for the plan.
-   **`MRP_WORKBENCH_BUCKET_DATES`**: Defines the start and end dates for the time buckets.
-   **`MRP_SYSTEM_ITEMS`**: Stores plan-specific item attributes (like safety stock levels for that specific plan).

#### Core Logic
1.  **Bucketing:** The system aggregates individual supply/demand records into the defined time buckets.
2.  **Calculation:** It calculates the Projected Available Balance (PAB) for each bucket: `Previous PAB + Supply - Demand`.
3.  **Presentation:** Pivots the data so that time periods are columns and data types (Supply, Demand) are rows.

### Business Impact
-   **Visual Planning:** Makes it easy to spot trends and potential issues at a glance.
-   **Communication:** Provides a clear, standard format for discussing inventory plans with suppliers or production managers.
-   **Stability:** Helps planners smooth out production by visualizing peaks and valleys in demand.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-horizontal-plan)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
