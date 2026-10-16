---
layout: default
last_modified_at: 2026-10-16
title: 'MRP Pegging | Oracle EBS SQL Report'
description: 'Detail report for MRP planning pegging showing the hierarchy from demand, including forecast, sales orders, work order to supply (WIP jobs, purchase…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Master Scheduling/MRP, Enginatics, MRP, Pegging, bom_calendar_dates, rcv_transactions, oe_sets'
permalink: /MRP%20Pegging/
report_name: 'MRP Pegging'
report_web_name: mrp-pegging
module: 'Master Scheduling/MRP'
module_url: /modules/master-scheduling-mrp/
---

# MRP Pegging – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/mrp-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging).
**Oracle EBS module:** [Master Scheduling/MRP](/modules/master-scheduling-mrp/ "Oracle EBS Master Scheduling/MRP reports") · [all Master Scheduling/MRP reports](/modules/master-scheduling-mrp/)  

## Overview
Detail report for MRP planning pegging showing the hierarchy from demand, including forecast, sales orders, work order to supply (WIP jobs, purchase orders and on hand stock)

> **Run this report in Excel in seconds:** [download Blitz Report™ free](https://www.enginatics.com/download/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) (your first 30 reports are free) or try it in the [online demo](https://demo.enginatics.com/).

## Report Parameters
Organization Code, Plan, Sales Order, Order Type, Item, Supplier, Planner, Buyer, Make or Buy, Pegging, Exception, Origination Type, Plan Delay Days from, Actual Delay Days from, Supply Type, Receipt Date older than x days, Exclude On Hand

## Oracle EBS Tables Used
[bom_calendar_dates](https://www.enginatics.com/library/?pg=1&find=bom_calendar_dates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [rcv_transactions](https://www.enginatics.com/library/?pg=1&find=rcv_transactions&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [oe_sets](https://www.enginatics.com/library/?pg=1&find=oe_sets&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [per_people_x](https://www.enginatics.com/library/?pg=1&find=per_people_x&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [po_headers_all](https://www.enginatics.com/library/?pg=1&find=po_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [po_document_types_all_vl](https://www.enginatics.com/library/?pg=1&find=po_document_types_all_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [po_lines_all](https://www.enginatics.com/library/?pg=1&find=po_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_exception_details](https://www.enginatics.com/library/?pg=1&find=mrp_exception_details&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_safety_stocks](https://www.enginatics.com/library/?pg=1&find=mtl_safety_stocks&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_forecast_designators](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_designators&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_forecast_dates](https://www.enginatics.com/library/?pg=1&find=mrp_forecast_dates&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [po_line_locations_all](https://www.enginatics.com/library/?pg=1&find=po_line_locations_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_full_pegging](https://www.enginatics.com/library/?pg=1&find=mrp_full_pegging&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_onhand_quantities_detail](https://www.enginatics.com/library/?pg=1&find=mtl_onhand_quantities_detail&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_secondary_inventories](https://www.enginatics.com/library/?pg=1&find=mtl_secondary_inventories&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [dual](https://www.enginatics.com/library/?pg=1&find=dual&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_workbench_display_options](https://www.enginatics.com/library/?pg=1&find=mrp_workbench_display_options&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_sr_assignments](https://www.enginatics.com/library/?pg=1&find=mrp_sr_assignments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_sr_receipt_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_receipt_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_sr_source_org](https://www.enginatics.com/library/?pg=1&find=mrp_sr_source_org&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_planners](https://www.enginatics.com/library/?pg=1&find=mtl_planners&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [fnd_lookup_values](https://www.enginatics.com/library/?pg=1&find=fnd_lookup_values&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_recommendations](https://www.enginatics.com/library/?pg=1&find=mrp_recommendations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_item_purchase_orders](https://www.enginatics.com/library/?pg=1&find=mrp_item_purchase_orders&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [wip_entities](https://www.enginatics.com/library/?pg=1&find=wip_entities&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [wip_discrete_jobs](https://www.enginatics.com/library/?pg=1&find=wip_discrete_jobs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mrp_gross_requirements](https://www.enginatics.com/library/?pg=1&find=mrp_gross_requirements&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [oe_order_lines_all](https://www.enginatics.com/library/?pg=1&find=oe_order_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [oe_order_headers_all](https://www.enginatics.com/library/?pg=1&find=oe_order_headers_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [oe_transaction_types_tl](https://www.enginatics.com/library/?pg=1&find=oe_transaction_types_tl&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [wip_operations](https://www.enginatics.com/library/?pg=1&find=wip_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [bom_departments](https://www.enginatics.com/library/?pg=1&find=bom_departments&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [bom_standard_operations](https://www.enginatics.com/library/?pg=1&find=bom_standard_operations&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [wip_operation_resources](https://www.enginatics.com/library/?pg=1&find=wip_operation_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [po_requisition_lines_all](https://www.enginatics.com/library/?pg=1&find=po_requisition_lines_all&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging), [ap_suppliers](https://www.enginatics.com/library/?pg=1&find=ap_suppliers&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category%5B%5D=Enginatics&utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)

## Related Reports
[INV Item Upload](/INV%20Item%20Upload/ "INV Item Upload Oracle EBS SQL Report"), [INV Item Upload 11i](/INV%20Item%20Upload%2011i/ "INV Item Upload 11i Oracle EBS SQL Report"), [INV Items](/INV%20Items/ "INV Items Oracle EBS SQL Report"), [PO Headers and Lines](/PO%20Headers%20and%20Lines/ "PO Headers and Lines Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
The [SQL source](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Pegging/MRP%20Pegging.sql) can be run in any SQL client. Some Oracle EBS SQL reports in this library use functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) – install it first. Blitz Report™ adds parameters, Excel output with pivots, scheduling and security on top.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [MRP Pegging 02-Aug-2018 222325.xlsx](https://www.enginatics.com/example/mrp-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) |
| Blitz Report™ XML Import | [MRP_Pegging.xml](https://www.enginatics.com/xml/mrp-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) |
| SQL Source | [MRP Pegging.sql](https://github.com/Enginatics/Oracle-EBS-SQL/blob/master/MRP%20Pegging/MRP%20Pegging.sql) |
| Full Report on Enginatics | [www.enginatics.com/reports/mrp-pegging/](https://www.enginatics.com/reports/mrp-pegging/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging) |

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

- [Blitz Report™ – World’s Fastest Oracle EBS Reporting Tool](https://www.enginatics.com/blitz-report/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Oracle Discoverer Replacement – Import Worksheets into Blitz Report™](https://www.enginatics.com/blog/discoverer-replacement/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Oracle EBS Reporting Toolkits by Blitz Report™](https://www.enginatics.com/blitz-report-toolkits/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Blitz Report™ FAQ & Community Q&A](https://www.enginatics.com/discussion/questions-answers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Supply Chain Hub by Blitz Report™](https://www.enginatics.com/supply-chain-hub/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Blitz Report™ Customer Case Studies](https://www.enginatics.com/customers/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Oracle EBS Reporting Blog](https://www.enginatics.com/blog/?utm_source=oraclereporting.com&utm_medium=referral&utm_campaign=oracle-ebs-sql&utm_content=mrp-pegging)
- [Oracle EBS Reporting Resource Centre](https://oracleebsreporting.com/)

© Enginatics GmbH
