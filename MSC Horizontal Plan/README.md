---
layout: default
title: 'MSC Horizontal Plan | Oracle EBS SQL Report'
description: 'ASCP: Horizontal Plan from the Planners Workbench. Note: The number of Items included in the HP is restricted by the parameter ‘Item Restriction Limit’…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, MSC, Horizontal, Plan, msc_apps_instances&a2m_dblink, msc_plans&a2m_dblink, mfg_lookups&a2m_dblink'
permalink: /MSC%20Horizontal%20Plan/
---

# MSC Horizontal Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-horizontal-plan/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
ASCP: Horizontal Plan from the Planners Workbench.

Note: 
The number of Items included in the HP is restricted by the parameter ‘Item Restriction Limit’. This parameter defaults from the profile option ‘MSC: HP Maximum Displayed Item Count’ in the ASCP Planning Instance. The value set in the Item Restriction Limit parameter will override the value specified in profile option.


## Report Parameters
Report Type, Planning Instance, Plan, Operating Unit, Organization, Planner, Buyer, Category Set, Category, Item, Unit of Measure, Item Restriction Limit, Cutoff Date, Buckets, Preference, Include Supply Demand Types, Exclude Supply Demand Types, Days Stock Cover Aggregation, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_apps_instances&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_apps_instances&a2m_dblink), [msc_plans&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_plans&a2m_dblink), [mfg_lookups&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=mfg_lookups&a2m_dblink), [dual&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=dual&a2m_dblink)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MSC Horizontal Plan - Horizontal Plan Dashboard 02-Apr-2026 120400.xlsm](https://www.enginatics.com/example/msc-horizontal-plan/) |
| Blitz Report™ XML Import | [MSC_Horizontal_Plan.xml](https://www.enginatics.com/xml/msc-horizontal-plan/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-horizontal-plan/](https://www.enginatics.com/reports/msc-horizontal-plan/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
