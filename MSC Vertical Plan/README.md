---
layout: default
title: 'MSC Vertical Plan | Oracle EBS SQL Report'
description: 'ASCP: Vertical Plan from the Planners Workbench. – Oracle E-Business Suite SQL report'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, MSC, Vertical, Plan, msc_period_start_dates&a2m_dblink, msc_trading_partners&a2m_dblink, msc_cal_week_start_dates&a2m_dblink'
permalink: /MSC%20Vertical%20Plan/
---

# MSC Vertical Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/msc-vertical-plan/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
ASCP: Vertical Plan from the Planners Workbench.

## Report Parameters
Planning Instance, Plan, Organization, Category Set, Category, Item, Cutoff Date, Exclude Zero Quantity, Show Item Descriptive Attributes

## Oracle EBS Tables Used
[msc_period_start_dates&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_period_start_dates&a2m_dblink), [msc_trading_partners&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_trading_partners&a2m_dblink), [msc_cal_week_start_dates&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_cal_week_start_dates&a2m_dblink), [msc_vertical_plan_v&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_vertical_plan_v&a2m_dblink), [msc_apps_instances&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_apps_instances&a2m_dblink), [msc_plans&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_plans&a2m_dblink), [msc_system_items&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_system_items&a2m_dblink), [msc_item_categories&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_item_categories&a2m_dblink), [msc_category_sets&a2m_dblink](https://www.enginatics.com/library/?pg=1&find=msc_category_sets&a2m_dblink)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[MSC Horizontal Plan](/MSC%20Horizontal%20Plan/ "MSC Horizontal Plan Oracle EBS SQL Report"), [MSC Plan Orders](/MSC%20Plan%20Orders/ "MSC Plan Orders Oracle EBS SQL Report"), [MSC Exceptions](/MSC%20Exceptions/ "MSC Exceptions Oracle EBS SQL Report"), [MSC Pegging Hierarchy 11i](/MSC%20Pegging%20Hierarchy%2011i/ "MSC Pegging Hierarchy 11i Oracle EBS SQL Report"), [MSC Pegging Hierarchy](/MSC%20Pegging%20Hierarchy/ "MSC Pegging Hierarchy Oracle EBS SQL Report"), [MSC Plan Order Upload](/MSC%20Plan%20Order%20Upload/ "MSC Plan Order Upload Oracle EBS SQL Report"), [MRP Plan Orders](/MRP%20Plan%20Orders/ "MRP Plan Orders Oracle EBS SQL Report"), [CAC Inventory and Intransit Value (Period-End) - Discrete/OPM](/CAC%20Inventory%20and%20Intransit%20Value%20%28Period-End%29%20-%20Discrete-OPM/ "CAC Inventory and Intransit Value (Period-End) - Discrete/OPM Oracle EBS SQL Report"), [CAC ICP PII Inventory and Intransit Value (Period-End)](/CAC%20ICP%20PII%20Inventory%20and%20Intransit%20Value%20%28Period-End%29/ "CAC ICP PII Inventory and Intransit Value (Period-End) Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MSC Vertical Plan - Vertical Plan Dasboard 28-Aug-2022 070519.xlsm](https://www.enginatics.com/example/msc-vertical-plan/) |
| Blitz Report™ XML Import | [MSC_Vertical_Plan.xml](https://www.enginatics.com/xml/msc-vertical-plan/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/msc-vertical-plan/](https://www.enginatics.com/reports/msc-vertical-plan/) |

## MSC Vertical Plan - Case Study & Technical Analysis

### Executive Summary
The **MSC Vertical Plan** provides a bucketed view of the plan, similar to the Horizontal Plan, but typically oriented to show the detailed composition of supply and demand within each bucket. It is often used to analyze the specific transactions that make up the totals seen in the Horizontal Plan.

### Business Challenge
Planners see a total number in the Horizontal Plan (e.g., "Demand: 500") and need to know what comprises it.
-   **Drill-Down:** "The Horizontal Plan shows a huge spike in demand in Week 4. What orders are causing that?"
-   **Composition:** "How much of this week's supply is coming from Purchase Orders versus Work Orders?"

### Solution
The **MSC Vertical Plan** lists the bucketed totals and can be used to drill down into details.

**Key Features:**
-   **Bucketed View:** Shows data in time periods (Days/Weeks).
-   **Detailed Rows:** Can break down the totals by transaction type or specific order.
-   **Comparison:** Useful for comparing supply vs. demand side-by-side for each period.

### Technical Architecture
The report queries the vertical plan view in ASCP.

#### Key Tables and Views
-   **`MSC_VERTICAL_PLAN_V`**: A view specifically designed to aggregate and present plan data in a vertical format.
-   **`MSC_PLANS`**: Plan definition.
-   **`MSC_PERIOD_START_DATES`**: Defines the time buckets.

#### Core Logic
1.  **Aggregation:** Groups supply and demand data by Item, Organization, and Date Bucket.
2.  **Presentation:** Lists the buckets vertically (hence the name), allowing for more detailed columns than the horizontal pivot.

### Business Impact
-   **Root Cause Analysis:** Helps planners quickly identify the specific orders driving aggregate plan results.
-   **Plan Validation:** Used to verify that the bucketing logic is working as expected.


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
