---
layout: default
title: 'MRP Pegging | Oracle EBS SQL Report'
description: 'Detail report for MRP planning pegging showing the hierarchy from demand, including forecast, sales orders, work order to supply (WIP jobs, purchase…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, MRP, Pegging, bom_calendar_dates, rcv_transactions, oe_sets'
permalink: /MRP%20Pegging/
---

# MRP Pegging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-pegging/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report for MRP planning pegging showing the hierarchy from demand, including forecast, sales orders, work order to supply (WIP jobs, purchase orders and on hand stock)

## Report Parameters
Organization Code, Plan, Sales Order, Order Type, Item, Supplier, Planner, Buyer, Make or Buy, Pegging, Exception, Origination Type, Plan Delay Days from, Actual Delay Days from, Supply Type, Receipt Date older than x days, Exclude On Hand

## Oracle EBS Tables Used
[bom_calendar_dates](https://www.enginatics.com/library/?pg=1&find=bom_calendar_dates), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions), [oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all), [po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all), [mrp_exception_details](https://www.enginatics.com/library/?pg=1&find=mrp_exception_details), [mtl_safety_stocks](https://www.enginatics.com/library/?pg=1&find=mtl_safety_stocks), [mrp_forecast_designators](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_designators), [mrp_forecast_dates](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_dates)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)



## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Pegging 02-Aug-2018 222325.xlsx](https://www.enginatics.com/example/mrp-pegging/) |
| Blitz Report™ XML Import | [MRP_Pegging.xml](https://www.enginatics.com/xml/mrp-pegging/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/mrp-pegging/](https://www.enginatics.com/reports/mrp-pegging/) |

## MRP Pegging - Case Study & Technical Analysis

### Executive Summary
The **MRP Pegging** report provides a comprehensive view of the supply-demand links established by the planning engine. Unlike the "End Assembly Pegging" report which focuses on the final product, this report details the immediate parent-child relationships for any item, showing exactly what demand is driving a specific supply order.

### Business Challenge
Planners need to justify every supply order.
-   **Justification:** "Why is the system telling me to buy 500 units of Part X? What is it used for?"
-   **Allocation:** "I have 100 units of stock. Which work orders are claiming that stock?"
-   **Impact Assessment:** "If this Purchase Order is late, which specific Work Orders will be delayed?"

### Solution
The **MRP Pegging** report exposes the "pegging" tree.

**Key Features:**
-   **Upstream/Downstream:** Can show what demand is driving a supply (Upstream) or what supply is satisfying a demand (Downstream).
-   **Order Details:** Includes specific order numbers (PO #, Job #, SO #).
-   **Delay Analysis:** Highlights cases where the supply date is later than the demand date (Plan Delay).

### Technical Architecture
The report queries the pegging data generated during the MRP run.

#### Key Tables and Views
-   **`MRP_FULL_PEGGING`**: The core table storing the links between transaction IDs (Supply ID -> Demand ID).
-   **`MRP_GROSS_REQUIREMENTS`**: Details the demand side (Sales Orders, Forecasts, WIP Component Demand).
-   **`MRP_RECOMMENDATIONS`**: Details the supply side (Planned Orders, Reschedule Recommendations).
-   **`PO_HEADERS_ALL` / `WIP_DISCRETE_JOBS`**: Provides details for existing supply orders.

#### Core Logic
1.  **Root Identification:** Starts with a specific item or order.
2.  **Traversal:** Follows the `PEGGING_ID` links in `MRP_FULL_PEGGING` to find the related transactions.
3.  **Enrichment:** Joins to source tables (PO, WIP, OE) to get human-readable details like Order Numbers and Customer Names.

### Business Impact
-   **Inventory Reduction:** Helps identify "orphan" supply (supply with no pegging) that can be cancelled.
-   **Expediting:** Pinpoints exactly which supply orders are critical for meeting customer demand.
-   **Transparency:** Removes the "black box" mystery of MRP by showing the exact logic behind every recommendation.


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
