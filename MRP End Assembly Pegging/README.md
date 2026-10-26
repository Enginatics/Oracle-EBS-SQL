---
layout: default
last_modified_at: 2026-10-26
title: 'MRP End Assembly Pegging | Oracle EBS SQL Report'
description: 'Detail report for MRP pegging from final assembly to each component, including: planner, end demand pegged qty, demand and plan dates, supply quantity…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, End, Assembly, Pegging, oe_sets, mtl_parameters, mrp_full_pegging'
permalink: /MRP%20End%20Assembly%20Pegging/
report_name: 'MRP End Assembly Pegging'
report_web_name: mrp-end-assembly-pegging
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP End Assembly Pegging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-end-assembly-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
Detail report for MRP pegging from final assembly to each component, including: planner, end demand pegged qty, demand and plan dates, supply quantity, and supply date.

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Plan, End Assembly, Component, Supplier, Planner, Buyer, Make or Buy, End-Assembly Pegging Only

## Oracle EBS Tables Used
[oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mrp_recommendations](https://www.enginatics.com/library/?pg=1&find=mrp_recommendations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mrp_item_purchase_orders](https://www.enginatics.com/library/?pg=1&find=mrp_item_purchase_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [CRP Resource Plan](/CRP%20Resource%20Plan/ "CRP Resource Plan Oracle EBS SQL Report"), [WIP Discrete Job Shortage](/WIP%20Discrete%20Job%20Shortage/ "WIP Discrete Job Shortage Oracle EBS SQL Report"), [WIP Required Components](/WIP%20Required%20Components/ "WIP Required Components Oracle EBS SQL Report"), [GL Account Analysis](/GL%20Account%20Analysis/ "GL Account Analysis Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20End%20Assembly%20Pegging/MRP%20End%20Assembly%20Pegging.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP End Assembly Pegging 20-Jan-2019 031236.xlsx](https://www.enginatics.com/example/mrp-end-assembly-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) |
| Blitz Report™ XML Import | [MRP_End_Assembly_Pegging.xml](https://www.enginatics.com/xml/mrp-end-assembly-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) |
| SQL Source | [MRP End Assembly Pegging.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20End%20Assembly%20Pegging/MRP%20End%20Assembly%20Pegging.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-end-assembly-pegging/](https://www.enginatics.com/reports/mrp-end-assembly-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging) |

## MRP End Assembly Pegging - Case Study & Technical Analysis

### Executive Summary
The **MRP End Assembly Pegging** report provides a critical link between component supply and final product demand. It traces the requirement for a specific component all the way up the Bill of Materials (BOM) to the final "End Assembly" (finished good) that is driving that demand. This visibility is essential for prioritizing component allocation during shortages.

### Business Challenge
In a complex manufacturing environment, a single raw material (e.g., a specific screw or chip) might be used in dozens of different finished products. When that raw material is in short supply, planners need to know:
-   **Impact Analysis:** "If this shipment of screws is delayed, which customer orders for finished computers will be missed?"
-   **Prioritization:** "We only have enough chips for 50 units. Should we build Product A (high margin) or Product B (strategic customer)?"
-   **Expediting:** "Why is the system telling me to buy this part today? Is it for a rush order?"

### Solution
The **MRP End Assembly Pegging** report solves this by "pegging" (linking) supply to demand.

**Key Features:**
-   **Full Traceability:** Shows the path from the component, through sub-assemblies, to the final end item.
-   **Demand Context:** Identifies the specific Sales Order or Forecast that is driving the need.
-   **Schedule Alignment:** Compares the supply date (when the part is available) with the demand date (when the finished good is needed).

### Technical Architecture
The report relies on the MRP Pegging logic, which is calculated during the planning run.

#### Key Tables and Views
-   **`MRP_FULL_PEGGING`**: The core table storing the links between supply and demand.
-   **`MRP_RECOMMENDATIONS`**: Stores the planned orders generated by the MRP engine.
-   **`MRP_GROSS_REQUIREMENTS`**: Stores the independent demand (Sales Orders, Forecasts).
-   **`WIP_DISCRETE_JOBS`**: Represents the work orders that consume the materials.

#### Core Logic
1.  **Pegging Traversal:** The report starts with the component supply (e.g., a Purchase Order or Planned Order).
2.  **Upstream Navigation:** It recursively traverses the `MRP_FULL_PEGGING` table to find the parent demand.
3.  **End Item Identification:** It stops when it reaches an independent demand source (Sales Order or Forecast) at the top of the BOM structure.

### Business Impact
-   **Strategic Allocation:** Enables data-driven decisions on how to allocate scarce materials to the most important customer orders.
-   **Customer Service:** Allows customer service reps to proactively notify customers of potential delays based on component shortages.
-   **Inventory Optimization:** Helps identify "orphan" supply that is no longer pegged to any valid demand, allowing for cancellation or deferral.

---

## Useful Links

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-end-assembly-pegging)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
