---
layout: default
title: 'CRP Resource Plan | Oracle EBS SQL Report'
description: 'Detail report for each resource code, showing the resource date, hours, work start and end date, type of work scheduled, and the quantity scheduled.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CRP, Resource, Plan, dual, crp_resource_plan, table'
permalink: /CRP%20Resource%20Plan/
---

# CRP Resource Plan – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/crp-resource-plan/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report for each resource code, showing the resource date, hours, work start and end date, type of work scheduled, and the quantity scheduled.

## Report Parameters
Organization Code, Plan, Department, Resource Code, Resource Description, Sales Order, Planner, Job, Assembly, Component, Show Active only, Expand Lot Time, Show Components

## Oracle EBS Tables Used
[dual](https://www.enginatics.com/library/?pg=1&find=dual), [crp_resource_plan](https://www.enginatics.com/library/?pg=1&find=crp_resource_plan), [table](https://www.enginatics.com/library/?pg=1&find=table), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mrp_recommendations](https://www.enginatics.com/library/?pg=1&find=mrp_recommendations), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_schedule_groups](https://www.enginatics.com/library/?pg=1&find=wip_schedule_groups), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories), [po_distributions_all](https://www.enginatics.com/library/?pg=1&find=po_distributions_all), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CRP Resource Plan 03-Aug-2018 210345.xlsx](https://www.enginatics.com/example/crp-resource-plan/) |
| Blitz Report™ XML Import | [CRP_Resource_Plan.xml](https://www.enginatics.com/xml/crp-resource-plan/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/crp-resource-plan/](https://www.enginatics.com/reports/crp-resource-plan/) |

## Executive Summary
The **CRP Resource Plan** report is the counterpart to the "Available Resources" report. While the former shows *supply* (capacity), this report shows *demand* (load). It details the specific work scheduled for each resource, including the start/end dates, hours required, and the specific job or sales order driving the demand. This allows planners to see exactly what is consuming the shop floor's capacity.

## Business Challenge
Knowing that a machine is "busy" isn't enough. Planners need to know *what* it is busy doing.
*   **Prioritization**: If a machine is overbooked, which jobs should be moved? Planners need to see the pegged demand (e.g., "This job is for a critical customer order").
*   **Load Balancing**: Identifying periods where demand exceeds supply allows for proactive rescheduling.
*   **Pegging**: Tracing the resource requirement back to the source demand (Sales Order -> Job -> Operation -> Resource).

## Solution
This report provides a detailed schedule of resource requirements.

**Key Features:**
*   **Detailed Pegging**: Links the resource load to the specific WIP Job, Assembly, and even the Sales Order.
*   **Time Phasing**: Shows the specific date and time the resource is required.
*   **Flexible Filtering**: Allows filtering by Planner, Job, Assembly, or Department to focus on specific problem areas.

## Architecture
The report queries `CRP_RESOURCE_PLAN` (or `MRP_GROSS_REQUIREMENTS` linked to resource data) to show the load. It joins to `WIP_DISCRETE_JOBS` and `OE_ORDER_LINES_ALL` to provide the context of *why* the resource is needed.

**Key Tables:**
*   `CRP_RESOURCE_PLAN`: The calculated load on resources.
*   `WIP_DISCRETE_JOBS`: The production order.
*   `WIP_OPERATIONS`: The specific routing step requiring the resource.
*   `OE_ORDER_LINES_ALL`: The customer demand driving the production.

## Impact
*   **Conflict Resolution**: Enables planners to make informed decisions about which jobs to reschedule when capacity is tight.
*   **Customer Service**: Helps predict if a resource constraint will cause a customer order to be late.
*   **Resource Optimization**: Ensures that high-value resources are working on high-priority orders.


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
