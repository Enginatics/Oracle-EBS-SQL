---
layout: default
last_modified_at: 2026-10-19
title: 'MRP Item Forecast | Oracle EBS SQL Report'
description: 'Detail report for item planning forecast, including forecast description, planner, item, bucket type, forecast start and end dates, current quantity…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, Item, Forecast, org_organization_definitions, mrp_forecast_items_v, mrp_forecast_dates'
permalink: /MRP%20Item%20Forecast/
report_name: 'MRP Item Forecast'
report_web_name: mrp-item-forecast
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP Item Forecast – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-item-forecast/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
Detail report for item planning forecast, including forecast description, planner, item, bucket type, forecast start and end dates, current quantity, original qty, project related data, and confidence projection.

Show Consumption adds one row per sales order consumption of each forecast entry from the forecast consumption history: sales order, line, customer, ship-to, schedule date, order quantity, consumed quantity and the date the consumption was recorded. A negative consumed quantity reverses an earlier consumption, for example after an order line was cancelled or reduced.

With Show Consumption, the current and original forecast quantity are shown on the first row of each forecast entry only, so that they sum correctly. Original minus current quantity equals the consumed quantity of the entry, unless the forecast quantity was changed manually.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Forecast Set, Forecast, Organization Code, Planner, Item, Project, Forecast Date From, Forecast Date To, Forecast older than x days, Show Consumption

## Oracle EBS Tables Used
[org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [mrp_forecast_items_v](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_items_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [mrp_forecast_dates](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_dates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [mrp_forecast_designators](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_designators&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)

## Related Reports
[MRP Item Forecast Upload](/MRP%20Item%20Forecast%20Upload/ "MRP Item Forecast Upload Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [MRP Horizontal Plan](/MRP%20Horizontal%20Plan/ "MRP Horizontal Plan Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Item%20Forecast/MRP%20Item%20Forecast.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Item Forecast 20-Jun-2018 081609.xlsx](https://www.enginatics.com/example/mrp-item-forecast/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) |
| Blitz Report™ XML Import | [MRP_Item_Forecast.xml](https://www.enginatics.com/xml/mrp-item-forecast/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) |
| SQL Source | [MRP Item Forecast.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Item%20Forecast/MRP%20Item%20Forecast.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-item-forecast/](https://www.enginatics.com/reports/mrp-item-forecast/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast) |

## MRP Item Forecast - Case Study & Technical Analysis

### Executive Summary
The **MRP Item Forecast** report details the independent demand (forecasts) that drives the planning process. It allows planners to review the specific forecast entries for an item, including the source of the forecast, quantities, and dates. This is crucial for validating the "input" side of the MRP equation.

### Business Challenge
If the forecast is wrong, the plan will be wrong ("Garbage In, Garbage Out"). Planners need to validate the forecast data before running the plan.
-   **Forecast Accuracy:** "Why is the system planning for 10,000 units? Did someone enter an extra zero?"
-   **Source Identification:** "Is this demand coming from the Sales Forecast or the Marketing Promo Forecast?"
-   **Consumption:** "Has this forecast been 'consumed' by actual sales orders, or is it still driving additional production?"

### Solution
The **MRP Item Forecast** report lists the detailed forecast entries.

**Key Features:**
-   **Forecast Sets:** Identifies which forecast set (scenario) the data belongs to.
-   **Granularity:** Shows individual forecast entries with dates and quantities.
-   **Project Association:** Can link forecasts to specific projects (for Project Manufacturing).

### Technical Architecture
The report queries the Master Scheduling/MRP forecast tables.

#### Key Tables and Views
-   **`MRP_FORECAST_ITEMS_V`**: The primary view for forecast entries.
-   **`MRP_FORECAST_DESIGNATORS`**: Defines the forecast names and sets.
-   **`MRP_FORECAST_DATES`**: Stores the specific dates and quantities for each forecast entry.

#### Core Logic
1.  **Selection:** Filters forecasts based on the Forecast Set and Item.
2.  **Details:** Retrieves the quantity, date, and bucket type (Day/Week/Period) for each entry.
3.  **Consumption Logic:** (Depending on the view used) may show the original forecast quantity versus the current (unconsumed) quantity.

### Business Impact
-   **Plan Accuracy:** Ensures that the manufacturing plan is based on valid and verified demand signals.
-   **Collaboration:** Facilitates discussions between Sales (who generate the forecast) and Operations (who execute it).
-   **Inventory Management:** Prevents over-production caused by obsolete or duplicate forecast entries.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-item-forecast)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
