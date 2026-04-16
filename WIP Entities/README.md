---
layout: default
title: 'WIP Entities | Oracle EBS SQL Report'
description: 'Detail WIP report that lists job, type, status, planner, item, item description, planning method, pegging type, entity, job Description, WIP resource…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, WIP, Entities, hr_all_organization_units_vl, mtl_parameters, wip_entities'
permalink: /WIP%20Entities/
---

# WIP Entities – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-entities/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail WIP report that lists job, type, status, planner, item, item description, planning method, pegging type, entity, job Description, WIP resource transaction account distributions, project number, task, source code, source line item,Sales Order,Sales Order Line, WIP type, class code, scheduling dates, quantities, department, resource and organization.

## Report Parameters
Organization Code, Scheduled Start Date From, Scheduled Start Date To, Planner Code, Schedule Group, Item, Job, Job Status, Project, Open only, Category Set 1, Category Set 2, Category Set 3, Category Set, Category

## Oracle EBS Tables Used
[hr_all_organization_units_vl](https://www.enginatics.com/library/?pg=1&find=hr_all_organization_units_vl), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [wip_schedule_groups](https://www.enginatics.com/library/?pg=1&find=wip_schedule_groups), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all), [pjm_seiban_numbers](https://www.enginatics.com/library/?pg=1&find=pjm_seiban_numbers), [pa_tasks](https://www.enginatics.com/library/?pg=1&find=pa_tasks), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[INV Onhand Quantities](/INV%20Onhand%20Quantities/ "INV Onhand Quantities Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WIP Entities 02-Aug-2018 214556.xlsx](https://www.enginatics.com/example/wip-entities/) |
| Blitz Report™ XML Import | [WIP_Entities.xml](https://www.enginatics.com/xml/wip-entities/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/wip-entities/](https://www.enginatics.com/reports/wip-entities/) |

## Case Study & Technical Analysis: WIP Entities Report

### Executive Summary

The WIP Entities report is a comprehensive operational and analytical tool for Oracle Work in Process (WIP), providing a detailed listing of all manufacturing jobs, their types, statuses, and associated attributes. It integrates critical information such as the manufactured item, planner, scheduling dates, quantities, and linkages to sales orders and projects. This report is indispensable for production managers, planners, cost accountants, and project managers to monitor the progress of manufacturing orders, manage production schedules, understand the detailed context of each job, and ensure efficient and timely production fulfillment.

### Business Challenge

Managing manufacturing jobs in a dynamic production environment is complex, requiring detailed visibility into each job's status and characteristics. Organizations often face significant challenges in gaining this holistic view:

-   **Fragmented Job Information:** Details about a WIP job (e.g., status, item, quantities, scheduling, associated sales order or project) are often spread across multiple forms and tables in Oracle EBS, making it difficult to get a single, consolidated picture.
-   **Monitoring Production Progress:** Tracking the current status and progress of numerous discrete jobs or repetitive schedules is crucial for meeting delivery dates and managing shop floor capacity. Without a detailed report, this often relies on manual checks.
-   **Impact on Customer Fulfillment:** Delays or issues in WIP directly impact sales order fulfillment and customer satisfaction. Linking WIP jobs directly to sales orders provides critical visibility for customer service.
-   **Costing and Project Integration:** For project-driven manufacturing, understanding which WIP jobs are associated with which projects, and their current status, is essential for accurate project costing and tracking.
-   **Troubleshooting Production Issues:** When a production issue arises (e.g., a job is stuck, material is short), diagnosing the problem requires immediate access to all relevant job details, which can be time-consuming to gather manually.

### The Solution

This report offers a powerful, consolidated, and actionable solution for managing and analyzing WIP entities, transforming how manufacturing operations are monitored and controlled.

-   **Comprehensive Job Overview:** It presents a detailed list of all WIP jobs (entities), including their type (e.g., Discrete, Repetitive), current status, manufactured item, job description, scheduling dates, and quantities. This provides a holistic view of the shop floor.
-   **Integrated Sales Order and Project Context:** Crucially, the report links WIP jobs to their originating Sales Order and Sales Order Line, as well as to associated Project Number and Task, providing complete end-to-end visibility for customer fulfillment and project costing.
-   **Flexible Monitoring and Analysis:** With extensive filtering capabilities, users can quickly identify open jobs, jobs by specific item or planner, jobs for a particular schedule group, or jobs linked to specific projects, enabling targeted operational management.
-   **Enhanced Audit and Troubleshooting:** By consolidating all relevant job details, the report simplifies the process of auditing production activities and troubleshooting issues related to job status, material availability, or scheduling conflicts.

### Technical Architecture (High Level)

The report queries core Oracle Work in Process, Inventory, Order Management, and Projects tables to build its comprehensive, integrated view.

-   **Primary Tables Involved:**
    -   `wip_entities` (the central table for all WIP jobs/schedules).
    -   `wip_discrete_jobs` (for discrete job-specific details).
    -   `mtl_system_items_vl` (for item master details of the manufactured assembly).
    -   `mtl_planners` (for planner names).
    -   `oe_order_headers_all` and `oe_order_lines_all` (for sales order linkages).
    -   `pa_projects_all` and `pa_tasks` (for project and task linkages).
    -   `hr_all_organization_units_vl` (for organizational context).
    -   `wip_operations`, `bom_departments`, `bom_resources` (for operational and resource details).
-   **Logical Relationships:** The report starts with `wip_entities` and `wip_discrete_jobs` to get core job information. It then performs extensive joins to `mtl_system_items_vl` for assembly details, `oe_order_lines_all` and `pa_tasks` to link jobs to their respective demand sources (sales orders or projects). Further joins to resource and department tables provide operational context, and `wip_transaction_accounts` (though not directly listed in `Used tables` for this report, it's implied by the description mentioning "WIP resource transaction account distributions") would provide costing details.

### Parameters & Filtering

The report offers an extensive set of parameters for precise filtering and detailed data inclusion:

-   **Organizational Context:** `Organization Code` filters the report to a specific manufacturing organization.
-   **Job Identification:** `Job`, `Item`, `Job Status`, `Planner Code`, `Schedule Group` allow for granular targeting of specific production orders.
-   **Date Ranges:** `Scheduled Start Date From/To` are crucial for analyzing jobs scheduled within specific periods.
-   **Project Filter:** `Project` allows for focusing on jobs linked to a particular project.
-   **Status Flag:** `Open only` is essential for focusing on active production orders that are still in process.

### Performance & Optimization

As a detailed operational report integrating data across multiple modules, it is optimized through strong filtering and efficient joining strategies.

-   **Parameter-Driven Efficiency:** The use of `Organization Code`, `Scheduled Start Date` ranges, `Item`, and `Job` filters is critical for performance, allowing the database to efficiently narrow down the large transactional datasets to relevant WIP entities using existing indexes.
-   **Indexed Joins:** Queries leverage standard Oracle indexes on `wip_entity_id`, `organization_id`, `primary_item_id`, `sales_order_id`, and `project_id` for efficient data retrieval across WIP, Inventory, Order Management, and Projects tables.
-   **Targeted Data Retrieval:** The extensive filtering capabilities ensure that the report only processes the data relevant to the user's inquiry, preventing unnecessary database load.

### FAQ

**1. What is the difference between a 'WIP Entity' and a 'Discrete Job'?**
   A 'WIP Entity' is a generic term that refers to any production order in Oracle WIP, which can include Discrete Jobs, Repetitive Schedules, or even Flow Schedules. A 'Discrete Job' is a specific type of WIP entity used for manufacturing a fixed quantity of an item over a defined period, where materials and resources are consumed against that specific job.

**2. How does this report help track progress against a sales order?**
   By explicitly showing the `Sales Order` and `Sales Order Line` linked to a WIP job, this report provides crucial visibility for customer service and planning. It allows teams to quickly check the production status of items required for specific customer orders, enabling accurate delivery commitments and proactive communication with customers.

**3. Can this report identify jobs that are past due?**
   Yes. By comparing the `Scheduled Start Date` or `Scheduled Finish Date` to the current date and filtering for `Open only` jobs, users can quickly identify jobs that are behind schedule and require immediate attention or expediting to prevent further delays in production and customer fulfillment.


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
