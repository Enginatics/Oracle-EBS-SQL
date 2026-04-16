---
layout: default
title: 'EAM Weekly Schedule | Oracle EBS SQL Report'
description: 'Based on Oracle standard''s EAM Weekly Schedule report Application: Enterprise Asset Management Source: EAM Weekly Schedule report (XML) Short Name…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, R12 only, EAM, Weekly, Schedule, per_all_people_f, bom_resource_employees, bom_resources'
permalink: /EAM%20Weekly%20Schedule/
---

# EAM Weekly Schedule – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/eam-weekly-schedule/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Based on Oracle standard's EAM Weekly Schedule report
Application: Enterprise Asset Management
Source: EAM Weekly Schedule report (XML)
Short Name: EAMWSREP_XML
DB package: EAM_EAMWSREP_XMLP_PKG

## Report Parameters
Organization Code, Owning Department, Assigned Department, Week Starting, Date from, Date to, Area, Asset, Rebuild Item, Shutdown Type, Resource, Instance, Sort By

## Oracle EBS Tables Used
[per_all_people_f](https://www.enginatics.com/library/?pg=1&find=per_all_people_f), [bom_resource_employees](https://www.enginatics.com/library/?pg=1&find=bom_resource_employees), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [mtl_system_items_b_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_b_kfv), [bom_resource_equipments](https://www.enginatics.com/library/?pg=1&find=bom_resource_equipments), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources), [wip_op_resource_instances](https://www.enginatics.com/library/?pg=1&find=wip_op_resource_instances), [eam_work_order_details](https://www.enginatics.com/library/?pg=1&find=eam_work_order_details), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [csi_item_instances](https://www.enginatics.com/library/?pg=1&find=csi_item_instances), [eam_org_maint_defaults](https://www.enginatics.com/library/?pg=1&find=eam_org_maint_defaults), [mtl_eam_locations](https://www.enginatics.com/library/?pg=1&find=mtl_eam_locations), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics), [R12 only](https://www.enginatics.com/library/?pg=1&category[]=R12%20only)

## Related Reports
[CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [EAM Weekly Schedule 17-May-2020 135229.xlsx](https://www.enginatics.com/example/eam-weekly-schedule/) |
| Blitz Report™ XML Import | [EAM_Weekly_Schedule.xml](https://www.enginatics.com/xml/eam-weekly-schedule/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/eam-weekly-schedule/](https://www.enginatics.com/reports/eam-weekly-schedule/) |

## Case Study & Technical Analysis: EAM Weekly Schedule

### Executive Summary
The **EAM Weekly Schedule** report is a tactical planning tool for Maintenance Planners and Supervisors. It provides a Gantt-chart-style view of the upcoming week's workload, broken down by Work Order, Operation, and Resource.
Unlike a simple list of open work orders, this report focuses on *scheduling*: who is doing what, when they are starting, and how long it will take. It is essential for:
1.  **Resource Leveling:** Ensuring that mechanics and electricians are not overbooked on Tuesday and idle on Friday.
2.  **Shutdown Planning:** Identifying work orders that require a machine shutdown (`Shutdown Type`) to coordinate production downtime.
3.  **Execution Tracking:** Monitoring the progress of scheduled work against the plan.

### Business Challenge
Maintenance scheduling is a dynamic puzzle.
*   **Resource Constraints:** You have 5 mechanics, but 50 hours of work scheduled for Monday.
*   **Asset Availability:** You can't service the conveyor belt while it's running.
*   **Prioritization:** When an emergency breakdown occurs, the schedule must be shuffled. Planners need a clear view of the "Firm Planned" work vs. the backlog to make these decisions.

### The Solution
This report replicates the standard Oracle EAM Weekly Schedule logic but exposes it in a flexible SQL format.
*   **Detailed Resource View:** It drills down to the `WIP_OP_RESOURCE_INSTANCES` level. This means it doesn't just say "Mechanic Required"; it says "John Smith is assigned."
*   **Capacity Planning Columns:** The columns `CP_1` through `CP_8` (likely representing days of the week or capacity buckets) allow for a pivot-table style view of daily load.
*   **Operational Context:** It includes critical execution flags:
    *   **Material Shortage:** Warns if parts are missing (don't schedule the job if you don't have the parts!).
    *   **Shutdown Type:** Indicates if the asset must be stopped (Required) or if work can be done while running.
    *   **Warranty Status:** Alerts the planner if the asset is under warranty (maybe call the vendor instead of fixing it internally).

### Technical Architecture (High Level)
The query joins the Work Order header (`WIP_DISCRETE_JOBS`) to its operations and resources.
*   **Resource Explosion:** The inline view `worp` (Work Order Resource Pivot) joins `WIP_OPERATIONS` -> `WIP_OPERATION_RESOURCES` -> `WIP_OP_RESOURCE_INSTANCES`. This ensures that every specific person or machine assigned to a task gets a row.
*   **Instance Resolution:** The complex `UNION` in the `instance_name` column logic resolves the generic "Instance ID" into a human-readable name.
    *   If `Resource_Type = 2` (Person), it looks up `PER_ALL_PEOPLE_F`.
    *   If `Resource_Type = 1` (Machine), it looks up `MTL_SYSTEM_ITEMS` (Equipment Item).
*   **Package Logic:** The query calls `eam_eamwsrep_xmlp_pkg` functions (e.g., `cp_1_p`). These are standard Oracle Reports packages that likely calculate the hours allocated to specific days based on the `Week Starting` parameter.

### Parameters & Filtering
*   **Week Starting:** The anchor date for the schedule.
*   **Owning vs. Assigned Department:** Allows filtering by who *owns* the asset vs. who is *doing* the work.
*   **Shutdown Type:** Critical for production coordination.
*   **Sort By:** Flexible sorting (Start Date, Priority, Asset) to match the planner's workflow.

### Performance & Optimization
*   **Distinct Selection:** The use of `SELECT DISTINCT` suggests that the underlying joins (especially around resource instances) might produce duplicates that need to be flattened for the report.
*   **Date Math:** Duration calculations (`res_completion_date - res_start_date`) are done in the database, providing immediate visibility into job length without external calculation.

### FAQ
**Q: Why is the "Instance Name" blank?**
A: If a resource requirement is defined at the *Group* level (e.g., "Any Mechanic") but not assigned to a specific *Instance* (e.g., "John Doe"), the instance ID will be null. This is common for unassigned backlog work.

**Q: What does "Firm Planned" mean?**
A: A "Firm" work order is locked in the schedule. MRP or auto-scheduling tools will not automatically move it. This report highlights these locked jobs so planners know what is non-negotiable.

**Q: How does it handle multi-day jobs?**
A: The `Duration` column shows the total hours. The package functions (`cp_1`...`cp_7`) likely distribute these hours across the days of the week, though the exact logic depends on the package code (which is wrapped in the database).

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
