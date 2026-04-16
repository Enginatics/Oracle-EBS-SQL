---
layout: default
title: 'MRP Horizontal Plan | Oracle EBS SQL Report'
description: 'MRP: Horizontal Plan from the Planners Workbench. - The report can be run for multiple organizations and items within a selected plan - The report can be…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, MRP, Horizontal, Plan, mrp_material_plans, mrp_workbench_bucket_dates, table'
permalink: /MRP%20Horizontal%20Plan/
---

# MRP Horizontal Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-horizontal-plan/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
MRP: Horizontal Plan from the Planners Workbench.
- The report can be run for multiple organizations and items within a selected plan
- The report can be used to explode BOMS and display the HP for all components 
  within the BOM
- Select a template to choose to either display the HP by individual components, or by 
  End Assemblies, Components.


## Report Parameters
Plan, Current or Snapshot Data, Buckets, Organization Code, Category Set, Category, Item Type, Exclude Item Type, Item, Item From, Item To, Item Contains, Explode BOMs, Exclude Items with No Activity, Make or Buy, Planner, Buyer, Supply/Demand Source

## Oracle EBS Tables Used
[mrp_material_plans](https://www.enginatics.com/library/?pg=1&find=mrp_material_plans), [mrp_workbench_bucket_dates](https://www.enginatics.com/library/?pg=1&find=mrp_workbench_bucket_dates), [table](https://www.enginatics.com/library/?pg=1&find=table), [mrp_system_items](https://www.enginatics.com/library/?pg=1&find=mrp_system_items), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [mmp](https://www.enginatics.com/library/?pg=1&find=mmp), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners), [bom_small_expl_temp](https://www.enginatics.com/library/?pg=1&find=bom_small_expl_temp), [mrp_end_assemblies](https://www.enginatics.com/library/?pg=1&find=mrp_end_assemblies)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[MRP Plan Orders](/MRP%20Plan%20Orders/ "MRP Plan Orders Oracle EBS SQL Report"), [MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [MSC Plan Order Upload](/MSC%20Plan%20Order%20Upload/ "MSC Plan Order Upload Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [MRP Item Forecast Upload](/MRP%20Item%20Forecast%20Upload/ "MRP Item Forecast Upload Oracle EBS SQL Report"), [MRP Item Forecast](/MRP%20Item%20Forecast/ "MRP Item Forecast Oracle EBS SQL Report"), [MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Horizontal Plan 26-Jul-2021 041459.xlsx](https://www.enginatics.com/example/mrp-horizontal-plan/) |
| Blitz Report™ XML Import | [MRP_Horizontal_Plan.xml](https://www.enginatics.com/xml/mrp-horizontal-plan/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-horizontal-plan/](https://www.enginatics.com/reports/mrp-horizontal-plan/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
