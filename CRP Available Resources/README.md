---
layout: default
title: 'CRP Available Resources | Oracle EBS SQL Report'
description: 'Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CRP, Available, Resources, mtl_parameters, crp_available_resources, bom_departments'
permalink: /CRP%20Available%20Resources/
---

# CRP Available Resources – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/crp-available-resources/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report showing the date range availability of each resource, as well as daily hours and unit capacity of the resource.

## Report Parameters
Organization Code, Plan, Department, Resource

## Oracle EBS Tables Used
[mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [crp_available_resources](https://www.enginatics.com/library/?pg=1&find=crp_available_resources), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [CAC Resources by Department Setup](/CAC%20Resources%20by%20Department%20Setup/ "CAC Resources by Department Setup Oracle EBS SQL Report"), [CAC Department Overhead Rates](/CAC%20Department%20Overhead%20Rates/ "CAC Department Overhead Rates Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [WIP Entities](/WIP%20Entities/ "WIP Entities Oracle EBS SQL Report"), [CAC WIP Resource Efficiency](/CAC%20WIP%20Resource%20Efficiency/ "CAC WIP Resource Efficiency Oracle EBS SQL Report"), [CAC WIP Account Summary](/CAC%20WIP%20Account%20Summary/ "CAC WIP Account Summary Oracle EBS SQL Report"), [CAC Resources Associated with Overheads Setup](/CAC%20Resources%20Associated%20with%20Overheads%20Setup/ "CAC Resources Associated with Overheads Setup Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CRP Available Resources 14-May-2018 005901.xlsx](https://www.enginatics.com/example/crp-available-resources/) |
| Blitz Report™ XML Import | [CRP_Available_Resources.xml](https://www.enginatics.com/xml/crp-available-resources/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/crp-available-resources/](https://www.enginatics.com/reports/crp-available-resources/) |

## Executive Summary
The **CRP Available Resources** report is a fundamental tool for Capacity Requirements Planning (CRP). It provides a detailed view of the available capacity for manufacturing resources (machines and labor) over a specified date range. By showing the daily hours and unit capacity for each resource, this report helps production planners identify potential bottlenecks and validate that the shop floor has the necessary bandwidth to meet the production schedule.

## Business Challenge
Manufacturing efficiency depends on balancing demand (production orders) with supply (resource capacity).
*   **Overbooking**: Scheduling more work than a machine can handle leads to missed deadlines and overtime costs.
*   **Underutilization**: Idle machines represent wasted capital and lost revenue potential.
*   **Visibility**: Planners need to know exactly how many hours a specific resource is available on a specific day, accounting for shifts, holidays, and maintenance.

## Solution
This report queries the CRP tables to present the calculated availability of resources.

**Key Features:**
*   **Daily Granularity**: Shows availability day-by-day, allowing for precise scheduling.
*   **Resource Specificity**: Drills down to the individual resource level within a department.
*   **Capacity Metrics**: Displays both "Daily Hours" (time available) and "Unit Capacity" (throughput potential).

## Architecture
The report pulls data from `CRP_AVAILABLE_RESOURCES`, which is populated by the planning engine (ASCP or MRP). It links to `BOM_DEPARTMENTS` and `BOM_RESOURCES` for descriptive details.

**Key Tables:**
*   `CRP_AVAILABLE_RESOURCES`: The core table storing the calculated capacity.
*   `BOM_DEPARTMENTS`: The manufacturing department owning the resource.
*   `BOM_RESOURCES`: The specific machine or labor code.

## Impact
*   **Realistic Scheduling**: Ensures that production plans are feasible based on actual shop floor constraints.
*   **Bottleneck Identification**: Highlights resources with limited availability that may constrain total output.
*   **Shift Management**: Helps managers decide if additional shifts or overtime are needed to meet demand.


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
