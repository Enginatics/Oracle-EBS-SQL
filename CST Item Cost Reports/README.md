---
layout: default
title: 'CST Item Cost Reports | Oracle EBS SQL Report'
description: 'Flexible costing set of reports - analyze item costs for any cost type. Choose from the following options: Choose one of the following options: Activity…'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Item, Cost, Reports, gl_ledgers, fnd_currencies, org_organization_definitions'
permalink: /CST%20Item%20Cost%20Reports/
---

# CST Item Cost Reports – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-item-cost-reports/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Flexible costing set of reports -  analyze item costs for any cost type. 
Choose from the following options:
Choose one of the following options:
Activity Summary - Report item costs by activity.
Activity by Department - Report item costs by activity and department.
Activity by Flexfield Segment Value - Report item costs by the descriptive flexfield segment you enter.
Activity by Operation - Report item costs by activity and operation sequence number.
Element	- Report item costs by cost element and cost level.
Element by Activity - Report item costs by cost element and activity.
Element by Department - Report item costs by cost element and department.
Element by Operation - Report item costs by cost element and operation sequence number.
Element by Sub-Element - Report item costs by cost element and sub-element.
Operation Summary by Level - Report item costs by operation sequence number and cost level.
Operation by Activity - Report item costs by operation sequence number and activity.
Operation by Sub-Element - Report item costs by operation sequence number and sub-element.
Sub-Element - Report item costs by sub-element.
Sub-Element by Activity - Report item costs by sub-element and activity.
Sub-Element by Department - Report item costs by sub-element and department.
Sub-Element by Flexfield Segment Value - Report item costs by the descriptive flexfield segment you enter.
Sub-Element by Operation - Report item costs by sub-element and operation sequence number.



## Report Parameters
Organization Code, Ledger, Report Name, Cost Type, Category Set, Category From, Category To, Item, Item From, Item To, Sort Option

## Oracle EBS Tables Used
[gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_tl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_tl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [cst_detail_cost_view](https://www.enginatics.com/library/?pg=1&find=cst_detail_cost_view), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [mtl_category_sets_v](https://www.enginatics.com/library/?pg=1&find=mtl_category_sets_v), [mtl_item_categories](https://www.enginatics.com/library/?pg=1&find=mtl_item_categories), [mtl_categories_kfv](https://www.enginatics.com/library/?pg=1&find=mtl_categories_kfv)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC New Items](/CAC%20New%20Items/ "CAC New Items Oracle EBS SQL Report"), [CST Detailed Item Cost](/CST%20Detailed%20Item%20Cost/ "CST Detailed Item Cost Oracle EBS SQL Report"), [CAC Calculate ICP PII Item Costs by Where Used](/CAC%20Calculate%20ICP%20PII%20Item%20Costs%20by%20Where%20Used/ "CAC Calculate ICP PII Item Costs by Where Used Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Onhand Lot Value (Real-Time)](/CAC%20Onhand%20Lot%20Value%20%28Real-Time%29/ "CAC Onhand Lot Value (Real-Time) Oracle EBS SQL Report"), [CAC ICP PII Inventory Pending Cost Adjustment](/CAC%20ICP%20PII%20Inventory%20Pending%20Cost%20Adjustment/ "CAC ICP PII Inventory Pending Cost Adjustment Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report"), [CAC Cost vs. Planning Item Controls](/CAC%20Cost%20vs-%20Planning%20Item%20Controls/ "CAC Cost vs. Planning Item Controls Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Item Cost Reports 15-Jun-2019 123903.xlsx](https://www.enginatics.com/example/cst-item-cost-reports/) |
| Blitz Report™ XML Import | [CST_Item_Cost_Reports.xml](https://www.enginatics.com/xml/cst-item-cost-reports/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-item-cost-reports/](https://www.enginatics.com/reports/cst-item-cost-reports/) |

## Executive Summary
The **CST Item Cost Reports** is a versatile, multi-purpose reporting tool designed to analyze item costs from various angles. Instead of having ten separate reports for "Cost by Activity", "Cost by Department", "Cost by Operation", etc., this single report uses a "Report Name" parameter to pivot the data dynamically. It is invaluable for deep-dive cost analysis in manufacturing environments.

## Business Challenge
Different users need to see cost data in different ways:
*   **Production Manager**: "How much does the 'Assembly' department contribute to the cost of this widget?" (View: Element by Department)
*   **Process Engineer**: "Which specific operation is the most expensive?" (View: Operation Summary)
*   **Cost Accountant**: "What is the breakdown of overheads?" (View: Sub-Element)

## Solution
A single SQL report that changes its output columns and grouping based on the user's selection.

**Key Views (Report Names):**
*   **Activity Summary**: Costs grouped by Activity (ABC Costing).
*   **Element**: The classic Material/Labor/Overhead breakdown.
*   **Operation Summary**: Costs grouped by Routing Operation Sequence.
*   **Sub-Element**: Detailed breakdown (e.g., "Gold" vs. "Silver" material, or "Setup" vs. "Run" labor).

## Architecture
The report queries the `CST_DETAIL_COST_VIEW`, a standard Oracle view that joins `CST_ITEM_COSTS` and `CST_ITEM_COST_DETAILS` with related master data tables like `BOM_DEPARTMENTS` and `BOM_OPERATION_SEQUENCES`.

**Key Tables:**
*   `CST_DETAIL_COST_VIEW`: The primary source of cost details.
*   `CST_COST_TYPES`: Defines the cost scenario (Frozen, Pending, etc.).
*   `MTL_SYSTEM_ITEMS_VL`: Item master.

## Impact
*   **Decision Support**: Provides the specific data slice needed for make-vs-buy decisions, process improvements, and pricing.
*   **Simplicity**: Reduces the number of distinct reports users need to learn and maintain.
*   **Granularity**: Offers the deepest possible view into the components of a standard cost.


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
