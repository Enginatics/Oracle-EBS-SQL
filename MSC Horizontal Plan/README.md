---
layout: default
last_modified_at: 2026-10-19
title: 'MSC Horizontal Plan | Oracle EBS SQL Report'
description: 'ASCP: Horizontal Plan from the Planners Workbench. Note: The number of Items included in the HP is restricted by the parameter ‘Item Restriction Limit’…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Advanced Supply Chain Planning, Enginatics, R12 only, MSC, Horizontal, Plan, msc_apps_instances, msc_plans, mfg_lookups'
permalink: /MSC%20Horizontal%20Plan/
report_name: 'MSC Horizontal Plan'
report_web_name: msc-horizontal-plan
module: 'Advanced Supply Chain Planning'
module_url: /modules/advanced-supply-chain-planning/
---

# MSC Horizontal Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan).
**Oracle EBS module:** [Advanced Supply Chain Planning](/modules/advanced-supply-chain-planning/ "Oracle EBS Advanced Supply Chain Planning reports") · [all Advanced Supply Chain Planning reports](/modules/advanced-supply-chain-planning/)  

## Overview
ASCP: Horizontal Plan from the Planners Workbench.

Note: 
The number of Items included in the HP is restricted by the parameter ‘Item Restriction Limit’. This parameter defaults from the profile option ‘MSC: HP Maximum Displayed Item Count’ in the ASCP Planning Instance. The value set in the Item Restriction Limit parameter will override the value specified in profile option.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Report Type, Planning Instance, Plan, Operating Unit, Organization, Planner, Buyer, Category Set, Category, Item, Unit of Measure, Item Restriction Limit, Cutoff Date, Buckets, Preference, Include Supply Demand Types, Exclude Supply Demand Types, Days Stock Cover Aggregation, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_apps_instances](https://www.enginatics.com/library/?pg=1&find=msc_apps_instances&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_plans](https://www.enginatics.com/library/?pg=1&find=msc_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [mfg_lookups](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_form_query](https://www.enginatics.com/library/?pg=1&find=msc_form_query&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_material_plans](https://www.enginatics.com/library/?pg=1&find=msc_material_plans&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_plan_organizations](https://www.enginatics.com/library/?pg=1&find=msc_plan_organizations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_system_items](https://www.enginatics.com/library/?pg=1&find=msc_system_items&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_item_categories](https://www.enginatics.com/library/?pg=1&find=msc_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [msc_trading_partners](https://www.enginatics.com/library/?pg=1&find=msc_trading_partners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan), [R12 only](https://www.enginatics.com/library/?pg=1&category%5B%5D=R12%20only&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)

## Related Reports
[MSC Vertical Plan](/MSC%20Vertical%20Plan/ "MSC Vertical Plan Oracle EBS SQL Report"), [MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report"), [MSC Plan Order Upload](/MSC%20Plan%20Order%20Upload/ "MSC Plan Order Upload Oracle EBS SQL Report"), [CAC Inventory Pending Cost Adjustment - No Currencies](/CAC%20Inventory%20Pending%20Cost%20Adjustment%20-%20No%20Currencies/ "CAC Inventory Pending Cost Adjustment - No Currencies Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End)](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC Inventory and Intransit Value (Period-End) Oracle EBS SQL Report"), [MSC Exceptions](/MSC%20Exceptions/ "MSC Exceptions Oracle EBS SQL Report"), [MSC Pegging Hierarchy](/MSC%20Pegging%20Hierarchy/ "MSC Pegging Hierarchy Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MSC%20Horizontal%20Plan/MSC%20Horizontal%20Plan.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MSC Horizontal Plan - Horizontal Plan Dashboard 02-Apr-2026 120400.xlsm](https://www.enginatics.com/example/msc-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) |
| Blitz Report™ XML Import | [MSC_Horizontal_Plan.xml](https://www.enginatics.com/xml/msc-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) |
| SQL Source | [MSC Horizontal Plan.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MSC%20Horizontal%20Plan/MSC%20Horizontal%20Plan.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/msc-horizontal-plan/](https://www.enginatics.com/reports/msc-horizontal-plan/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan) |

## MSC Horizontal Plan - Case Study & Technical Analysis

### Executive Summary
The **MSC Horizontal Plan** is the ASCP equivalent of the MRP Horizontal Plan. It provides a time-phased, bucketed view of supply, demand, and projected inventory across the entire supply chain. It is the fundamental tool for visualizing the flow of materials over time.

### Business Challenge
Planners need to see the "big picture" of inventory flow, not just a list of orders.
-   **Inventory Projection:** "What will our stock level be at the end of each week for the next 6 months?"
-   **Supply/Demand Balance:** "Are we consistently producing more than we are selling?"
-   **Safety Stock:** "When do we dip below our safety stock target?"

### Solution
The **MSC Horizontal Plan** aggregates planning data into time buckets.

**Key Features:**
-   **Bucketing:** Aggregates data into Daily, Weekly, and Monthly buckets.
-   **Row Types:** Displays rows for Gross Requirements, Scheduled Receipts, Planned Orders, Projected On Hand, and Safety Stock.
-   **Flexibility:** Can include or exclude specific supply/demand types based on user preference.

### Technical Architecture
The report mimics the Horizontal Plan view in the ASCP Planner's Workbench.

#### Key Tables and Views
-   **`MSC_PLANS`**: Defines the plan.
-   **`MSC_SUPPLIES`** / **`MSC_DEMANDS`**: The core tables storing all supply and demand transactions.
-   **`MSC_CAL_WEEK_START_DATES`**: Used to aggregate daily data into weekly buckets.

#### Core Logic
1.  **Aggregation:** Sums the quantities of supply and demand for each item within each time bucket.
2.  **Calculation:** Calculates the Projected Available Balance (PAB) cumulatively: `Previous PAB + Supply - Demand`.
3.  **Presentation:** Pivots the data to display time periods as columns.

### Business Impact
-   **Strategic Planning:** Helps identify long-term trends in inventory and capacity.
-   **Inventory Optimization:** Visualizes excess inventory and potential stockouts.
-   **Communication:** Provides a standard format for sharing the plan with stakeholders.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=msc-horizontal-plan)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
