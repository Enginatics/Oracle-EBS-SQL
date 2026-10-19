---
layout: default
last_modified_at: 2026-10-19
title: 'WIP Discrete Job Shortage | Oracle EBS SQL Report'
description: 'WIP report that lists discrete job Open Requirements and/or Shortages. Report Modes ========== The report can be run in the following modes: 1. Open…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Work in Process, Enginatics, WIP, Discrete, Job, Shortage, mtl_default_category_sets, mtl_item_categories, mtl_categories_kfv'
permalink: /WIP%20Discrete%20Job%20Shortage/
report_name: 'WIP Discrete Job Shortage'
report_web_name: wip-discrete-job-shortage
module: 'Work in Process'
module_url: /modules/work-in-process/
---

# WIP Discrete Job Shortage – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/wip-discrete-job-shortage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage).
**Oracle EBS module:** [Work in Process](/modules/work-in-process/ "Oracle EBS Work in Process reports") · [all Work in Process reports](/modules/work-in-process/)  

## Overview
WIP report that lists discrete job Open Requirements and/or Shortages.

Report Modes 
==========
The report can be run in the following modes:
1. Open Requirements - Reports all Open Requirements
2. Shortage based on Net QOH - Reports requirements with shortages against Nettable Quantity Onhand
3. Shortage based on QOH - Reports requirements with shortages against Total Quantity Onhand
4. Shortage based on Supply Sub/Loc - Reports requirements with Shortages against Onhand Quantity in the same supply Subinventory/Locator as specified in the job requirement.

Shortages
=======
The report displays the Total Open Requirements, Onhand Supply, and Shortage by Component.Additionally the report includes the cumulative shortage by date required for each component. 

Display Pegged Supply
=================
If the MRP Plan parameter is specified, the report will show any supply that is pegged to the job components by the MRP Plan.

Report Templates
=============
The following templates are available to restrict the report to showing Total Quantity Onhand, Nettable Quantity Onhand, or Subinventory/Locator matched Quantity Onhand.

1. Nettable QOH - Displays Nettable Onhand Quantities only
2. Nettable QOH with Pegged Supply - Displays Nettable Onhand Quantities only and Pegged Supply 
3. Subinventory/Locator Match QOH - Displays Subinventory/Locator Matched Onhand Quantities only
4. Subinventory/Locator Match QOH with Pegged Supply - Displays Subinventory/Locator Matched Onhand Quantities and any Pegged Supply
5. Total QOH - Displays Total (Nettable and Non-Nettable) Onhand Quantities only 
6. Total QOH with Pegged Supply - Displays Total (Nettable and Non-Nettable) Onhand Quantities only and any Pegged Supply

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Report Mode, Include Bulk, Include Supplier, Exclude Subinventory, Job From, Job To, Assembly From, Assembly To, Component From, Component To, Date Required From, Date Required To, Department From, Department To, Planner From, Planner To, Buyer From, Buyer To, Make or Buy, Schedule Group, Project, Requirement End Date, MRP Plan for Pegged Supply

## Oracle EBS Tables Used
[mtl_default_category_sets](https://www.enginatics.com/library/?pg=1&find=mtl_default_category_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_lines](https://www.enginatics.com/library/?pg=1&find=wip_lines&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_requirement_operations](https://www.enginatics.com/library/?pg=1&find=wip_requirement_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_schedule_groups](https://www.enginatics.com/library/?pg=1&find=wip_schedule_groups&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [bom_components_b](https://www.enginatics.com/library/?pg=1&find=bom_components_b&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_item_quantities_view](https://www.enginatics.com/library/?pg=1&find=mtl_item_quantities_view&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_item_locations_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_item_locations_kfv&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_reservations](https://www.enginatics.com/library/?pg=1&find=mtl_reservations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mtl_sales_orders](https://www.enginatics.com/library/?pg=1&find=mtl_sales_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [pa_projects_all](https://www.enginatics.com/library/?pg=1&find=pa_projects_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [wip_repetitive_schedules](https://www.enginatics.com/library/?pg=1&find=wip_repetitive_schedules&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage), [mrp_orders_sc_v](https://www.enginatics.com/library/?pg=1&find=mrp_orders_sc_v&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)

## Related Reports
[WIP Job Upload](/WIP%20Job%20Upload/ "WIP Job Upload Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [CAC Manufacturing Variance](/CAC%20Manufacturing%20Variance/ "CAC Manufacturing Variance Oracle EBS SQL Report"), [GL Account Analysis (Drilldown) (with inventory and WIP)](/GL%20Account%20Analysis%20%28Drilldown%29%20%28with%20inventory%20and%20WIP%29/ "GL Account Analysis (Drilldown) (with inventory and WIP) Oracle EBS SQL Report"), [GL Account Distribution Analysis](/GL%20Account%20Distribution%20Analysis/ "GL Account Distribution Analysis Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Discrete%20Job%20Shortage/WIP%20Discrete%20Job%20Shortage.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [WIP Discrete Job Shortage 02-Aug-2021 054401.xlsx](https://www.enginatics.com/example/wip-discrete-job-shortage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) |
| Blitz Report™ XML Import | [WIP_Discrete_Job_Shortage.xml](https://www.enginatics.com/xml/wip-discrete-job-shortage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) |
| SQL Source | [WIP Discrete Job Shortage.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/WIP%20Discrete%20Job%20Shortage/WIP%20Discrete%20Job%20Shortage.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/wip-discrete-job-shortage/](https://www.enginatics.com/reports/wip-discrete-job-shortage/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage) |

## Case Study: Proactive Material Shortage Management

### Executive Summary
The **WIP Discrete Job Shortage** report is a critical production planning tool designed to prevent manufacturing delays caused by material unavailability. By comparing the component requirements of open Discrete Jobs against current on-hand inventory, this report identifies shortages *before* they impact the shop floor. It supports multiple logic modes—including Net Quantity On-Hand (QOH) and Total QOH—to provide a realistic and actionable view of material readiness.

### Business Challenge
In manufacturing, material shortages are a primary cause of missed delivery dates and idle production lines.
*   **Reactive Planning:** Planners often discover shortages only when the shop floor attempts to issue material, leading to immediate stoppages.
*   **Inventory Visibility:** Standard reports may show "total" inventory but fail to account for "non-nettable" subinventories (e.g., quarantine, defective) or material already reserved for other jobs.
*   **Complex Supply Logic:** Determining availability requires checking not just the total stock, but stock in specific supply subinventories or locators defined on the Bill of Materials (BOM).
*   **Pegging Visibility:** Understanding which supply orders (POs, Work Orders) are pegged to a specific requirement is difficult without navigating complex MRP screens.

### The Solution
This report provides a sophisticated shortage analysis engine directly within a reporting format.
*   **Predictive Analysis:** Calculates "Open Requirements" vs. "Onhand Supply" to highlight deficits immediately.
*   **Flexible Availability Logic:**
    *   **Net QOH:** Considers only nettable subinventories.
    *   **Total QOH:** Considers all on-hand inventory.
    *   **Supply Sub/Loc:** Checks availability strictly within the specific subinventory/locator assigned to the component.
*   **Pegging Integration:** Optionally displays supply pegged by the MRP plan, allowing planners to see if a PO is already inbound to cover the shortage.
*   **Cumulative Shortage:** Displays cumulative shortage by date, helping to prioritize which jobs to reschedule.

### Technical Architecture
The report logic is built upon the complex relationships between Work in Process and Inventory.
*   **Demand Source:** `WIP_DISCRETE_JOBS` and `WIP_REQUIREMENT_OPERATIONS` define the demand (what is needed and when).
*   **Supply Source:** `MTL_ONHAND_QUANTITIES_DETAIL` (or related views like `MTL_ITEM_QUANTITIES_VIEW`) provides the current stock position.
*   **Item Definition:** `MTL_SYSTEM_ITEMS_B` defines item attributes like "Nettable" status and default supply locators.
*   **MRP Integration:** Joins with `MRP_GROSS_REQUIREMENTS` and `MRP_FULL_PEGGING` when the pegging option is enabled.

### Parameters & Filtering
*   **Scope:** Organization Code, Job Name (From/To), Assembly, Component.
*   **Report Mode:** Open Requirements, Shortage based on Net QOH, Shortage based on QOH, Shortage based on Supply Sub/Loc.
*   **Dates:** Date Required (From/To), Requirement End Date.
*   **Responsibility:** Planner, Buyer, Department.
*   **Inclusions:** Include Bulk Items, Include Supplier Items, Exclude Subinventory.

### Performance & Optimization
*   **On-Hand Calculation:** Calculating on-hand quantity on the fly can be resource-intensive. The report uses optimized views, but running for a specific "Schedule Group" or "Department" is recommended for large organizations.
*   **MRP Data:** The "Display Pegged Supply" option requires joining to large MRP tables. Use this option only when necessary, as it significantly increases query complexity and runtime.

### FAQ
**Q: What is the difference between "Net QOH" and "Total QOH"?**
A: "Net QOH" excludes subinventories that are flagged as non-nettable (e.g., MRB, Scrap). "Total QOH" includes all inventory regardless of status.

**Q: Does this report show shortages for Phantom assemblies?**
A: Phantom assemblies are typically blown through to their components. This report focuses on the components required by the Discrete Job itself.

**Q: Can I see which specific job is causing the shortage?**
A: Yes, the report lists the specific Job and Operation where the component is required.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=wip-discrete-job-shortage)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
