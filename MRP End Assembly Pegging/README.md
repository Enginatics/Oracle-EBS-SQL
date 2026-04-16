---
layout: default
title: 'MRP End Assembly Pegging | Oracle EBS SQL Report'
description: 'Detail report for MRP pegging from final assembly to each component, including: planner, end demand pegged qty, demand and plan dates, supply quantity…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, MRP, End, Assembly, Pegging, oe_sets, mtl_parameters, mrp_full_pegging'
permalink: /MRP%20End%20Assembly%20Pegging/
---

# MRP End Assembly Pegging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-end-assembly-pegging/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report for MRP pegging from final assembly to each component, including: planner, end demand pegged qty, demand and plan dates, supply quantity, and supply date.

## Report Parameters
Organization Code, Plan, End Assembly, Component, Supplier, Planner, Buyer, Make or Buy, End-Assembly Pegging Only

## Oracle EBS Tables Used
[oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values), [mrp_recommendations](https://www.enginatics.com/library/?pg=1&find=mrp_recommendations), [mrp_item_purchase_orders](https://www.enginatics.com/library/?pg=1&find=mrp_item_purchase_orders), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[MRP Pegging](/MRP%20Pegging/ "MRP Pegging Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report"), [PO Headers and Lines 11i](/PO%20Headers%20and%20Lines%2011i/ "PO Headers and Lines 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP End Assembly Pegging 20-Jan-2019 031236.xlsx](https://www.enginatics.com/example/mrp-end-assembly-pegging/) |
| Blitz Report™ XML Import | [MRP_End_Assembly_Pegging.xml](https://www.enginatics.com/xml/mrp-end-assembly-pegging/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-end-assembly-pegging/](https://www.enginatics.com/reports/mrp-end-assembly-pegging/) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© 2026 Enginatics
