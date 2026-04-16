---
layout: default
title: 'CST Detailed Item Cost | Oracle EBS SQL Report'
description: 'Detail report that lists each item and the associated costs to be recognized as part of total unit cost of producing the item.'
keywords: 'Oracle EBS, Oracle E-Business Suite, SQL report, Blitz Report, Enginatics, CST, Detailed, Item, Cost, cst_activities, gl_ledgers, fnd_currencies'
permalink: /CST%20Detailed%20Item%20Cost/
---

# CST Detailed Item Cost – Oracle EBS SQL Report

**Oracle E-Business Suite** SQL report from the [Enginatics Library](https://www.enginatics.com/reports/cst-detailed-item-cost/) powered by [Blitz Report™](https://www.enginatics.com/blitz-report/).

## Overview
Detail report that lists each item and the associated costs to be recognized as part of total unit cost of producing the item.

## Report Parameters
Ledger, Organization Code, Cost Type, Category Set 1, Category Set 2, Category From, Category To, Item, Item From, Item To, Exclude Items with no Cost Details

## Oracle EBS Tables Used
[cst_activities](https://www.enginatics.com/library/?pg=1&find=cst_activities), [gl_ledgers](https://www.enginatics.com/library/?pg=1&find=gl_ledgers), [fnd_currencies](https://www.enginatics.com/library/?pg=1&find=fnd_currencies), [org_organization_definitions](https://www.enginatics.com/library/?pg=1&find=org_organization_definitions), [mtl_parameters](https://www.enginatics.com/library/?pg=1&find=mtl_parameters), [cst_item_costs](https://www.enginatics.com/library/?pg=1&find=cst_item_costs), [cst_cost_types](https://www.enginatics.com/library/?pg=1&find=cst_cost_types), [cst_item_cost_details](https://www.enginatics.com/library/?pg=1&find=cst_item_cost_details), [mtl_system_items_vl](https://www.enginatics.com/library/?pg=1&find=mtl_system_items_vl), [mtl_units_of_measure_vl](https://www.enginatics.com/library/?pg=1&find=mtl_units_of_measure_vl), [mtl_item_status_vl](https://www.enginatics.com/library/?pg=1&find=mtl_item_status_vl), [bom_resources](https://www.enginatics.com/library/?pg=1&find=bom_resources), [org_access_view](https://www.enginatics.com/library/?pg=1&find=org_access_view)

## Report Categories
[Enginatics](https://www.enginatics.com/library/?pg=1&category[]=Enginatics)

## Related Reports
[CAC Item Cost Break-Out by Activity](/CAC%20Item%20Cost%20Break-Out%20by%20Activity/ "CAC Item Cost Break-Out by Activity Oracle EBS SQL Report"), [CAC Item Cost & Routing](/CAC%20Item%20Cost%20-%20Routing/ "CAC Item Cost & Routing Oracle EBS SQL Report"), [CAC Last Standard Item Cost](/CAC%20Last%20Standard%20Item%20Cost/ "CAC Last Standard Item Cost Oracle EBS SQL Report"), [CAC Item Cost Out-of-Balance](/CAC%20Item%20Cost%20Out-of-Balance/ "CAC Item Cost Out-of-Balance Oracle EBS SQL Report"), [CAC Calculate Average Item Costs](/CAC%20Calculate%20Average%20Item%20Costs/ "CAC Calculate Average Item Costs Oracle EBS SQL Report"), [CAC WIP Material Usage Variance](/CAC%20WIP%20Material%20Usage%20Variance/ "CAC WIP Material Usage Variance Oracle EBS SQL Report"), [CAC PO Receipt History for Item Costing](/CAC%20PO%20Receipt%20History%20for%20Item%20Costing/ "CAC PO Receipt History for Item Costing Oracle EBS SQL Report"), [CAC ICP PII Item Cost Summary](/CAC%20ICP%20PII%20Item%20Cost%20Summary/ "CAC ICP PII Item Cost Summary Oracle EBS SQL Report"), [CAC New Standard Item Costs](/CAC%20New%20Standard%20Item%20Costs/ "CAC New Standard Item Costs Oracle EBS SQL Report")

## Running This SQL Without Blitz Report
Some Oracle EBS SQL reports in this library require functions from the utility package [xxen_util](https://www.enginatics.com/xxen_util/true). Install it before running the SQL directly against your Oracle EBS database.

## Download & Import Options

| Resource | Link |
|---|---|
| Excel Example Output | [CST Detailed Item Cost 25-Jun-2019 140038.xlsx](https://www.enginatics.com/example/cst-detailed-item-cost/) |
| Blitz Report™ XML Import | [CST_Detailed_Item_Cost.xml](https://www.enginatics.com/xml/cst-detailed-item-cost/) |
| Full SQL on Enginatics | [www.enginatics.com/reports/cst-detailed-item-cost/](https://www.enginatics.com/reports/cst-detailed-item-cost/) |

## CST Detailed Item Cost - Case Study

### Executive Summary
The **CST Detailed Item Cost** report is a vital analytical tool for manufacturing and supply chain finance professionals. It provides a granular breakdown of the cost structure for inventory items, detailing the specific components—such as material, labor, resources, and overhead—that comprise the total unit cost. This level of detail is essential for accurate product pricing, margin analysis, and cost variance investigation.

### Business Challenge
In complex manufacturing environments, understanding the "true" cost of a product is often challenging. Organizations struggle with:
*   **Margin Visibility:** Without a clear understanding of cost components, it is difficult to set prices that ensure profitability or to identify products that are eroding margins.
*   **Cost Driver Analysis:** When unit costs increase, finance teams need to pinpoint whether the rise is due to raw material price hikes, increased labor hours, or higher overhead allocations.
*   **Standard Cost Maintenance:** Validating that standard costs are correctly set up before a new period begins requires a detailed audit of all cost elements.
*   **Inventory Valuation:** Ensuring that the inventory value on the balance sheet accurately reflects the cost of goods requires rigorous validation of item costs.

### Solution
The **CST Detailed Item Cost** report solves these problems by offering deep visibility into item costing:
*   **Component-Level Breakdown:** Lists each item and breaks down its cost into specific elements (e.g., Material, Material Overhead, Resource, Outside Processing, Overhead), providing a complete DNA of the product cost.
*   **Cost Type Flexibility:** Allows users to analyze costs for different Cost Types (e.g., "Frozen" for current standard costs, "Pending" for future costs, or "Average" for actual costing), facilitating "what-if" analysis and period-end updates.
*   **Category Analysis:** Supports filtering by Item Categories, enabling category managers to review cost structures for entire product lines at once.
*   **Efficiency:** The "Exclude Items with no Cost Details" parameter helps keep the report focused on active, costed items, reducing noise in the data.

### Technical Architecture
The report extracts data from the Oracle Cost Management module, linking item definitions with their cost details.
*   **Core Tables:**
    *   `CST_ITEM_COSTS`: The header table for item costs, storing the total unit cost for an item in a specific organization and cost type.
    *   `CST_ITEM_COST_DETAILS`: The detail table that holds the individual cost elements (e.g., the specific cost of steel vs. plastic for a component).
    *   `CST_COST_TYPES`: Defines the set of costs being viewed (e.g., Frozen, Average, Pending).
    *   `MTL_SYSTEM_ITEMS_VL`: Provides item descriptions and attributes.
    *   `ORG_ORGANIZATION_DEFINITIONS`: Identifies the inventory organization.
*   **Key Logic:**
    *   The report joins item master data with cost tables based on `Inventory_Item_Id` and `Organization_Id`.
    *   It filters by the selected `Cost_Type_Id` to ensure the user sees the specific version of the cost they requested.
    *   It aggregates detailed costs to match the total unit cost found in the header table.

### Frequently Asked Questions
**Q: Can I use this report to compare my current standard costs with next year's proposed costs?**
A: Yes, you can run the report twice—once for the "Frozen" cost type (current) and once for your "Pending" cost type (proposed)—and compare the outputs to analyze the impact of cost changes.

**Q: Does this report show costs for all organizations?**
A: The report is typically run for a specific "Organization Code" to provide a focused view, as costs for the same item can vary significantly between different manufacturing plants or warehouses.

**Q: Why do some items appear with zero cost?**
A: This could happen if the item is new and hasn't been costed yet, or if it's an expense item. You can use the "Exclude Items with no Cost Details" parameter to hide these from the report.

**Q: Does it include overheads?**
A: Yes, the report details all cost elements, including material overheads and resource overheads, provided they are defined in the cost structure.


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
