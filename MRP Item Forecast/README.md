---
layout: default
title: 'MRP Item Forecast | Oracle EBS SQL Report'
description: 'Detail report for item planning forecast, including forecast description, planner, item, bucket type, forecast start and end dates, current quantity…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, MRP, Item, Forecast, org_organization_definitions, mrp_forecast_items_v, mrp_forecast_dates'
permalink: /MRP%20Item%20Forecast/
---

# MRP Item Forecast – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-item-forecast/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report for item planning forecast, including forecast description, planner, item, bucket type, forecast start and end dates, current quantity, original qty, project related data, and confidence projection.

## Report Parameters
Forecast Set, Forecast, Organization Code, Planner, Item, Project, Forecast Date From, Forecast Date To, Forecast older than x days

## Oracle EBS Tables Used
[org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mrp_forecast_items_v](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_items_v), [mrp_forecast_dates](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_dates), [mrp_forecast_designators](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_designators), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[MRP Item Forecast Upload](/MRP%20Item%20Forecast%20Upload/ "MRP Item Forecast Upload Oracle EBS SQL Report"), [MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [INV Safety Stocks](/INV%20Safety%20Stocks/ "INV Safety Stocks Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Item Forecast 20-Jun-2018 081609.xlsx](https://www.enginatics.com/example/mrp-item-forecast/) |
| Blitz Report™ XML Import | [MRP_Item_Forecast.xml](https://www.enginatics.com/xml/mrp-item-forecast/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-item-forecast/](https://www.enginatics.com/reports/mrp-item-forecast/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
